MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-variables
MAKEFLAGS += --no-builtin-rules
SHELL := /bin/bash
#.SHELLFLAGS := -euo pipefail	###FIXME does not work with it yet

RM			:= /bin/rm
MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
ROOT_DIR    := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
CURRENT_DIR := $(notdir $(patsubst %/,%,$(dir $(MKFILE_PATH))))

PACKAGE_NAME := litecollections

PYTHON := python3

# dirs to clean up
PYCACHE_DIRS = $(shell find $(ROOT_DIR) -type d -name __pycache__)
HYPOTHESIS_DIRS = $(shell find $(ROOT_DIR) -type d -name .hypothesis)

# state management
SOURCE_CHECKSUM := $(shell grep -r litecollections -e . 2>&1 | sha1sum | awk '{print $$1}')
STATE_DIR := $(ROOT_DIR)/.state/$(SOURCE_CHECKSUM)
$(STATE_DIR):
	mkdir -p $@

INSTALL_PACKAGE := $(STATE_DIR)/package-installed.state
.ONESHELL:
$(INSTALL_PACKAGE): $(STATE_DIR) setup.py
	if [[ -z $$VIRTUAL_ENV ]]; then
		$(PYTHON) -m pip install --user . && touch $@
	else
		$(PYTHON) -m pip install . && touch $@
	fi
	test -f $@
install: $(INSTALL_PACKAGE)

#	$(PYTHON) -m pip install --user hypothesis && touch $@

INSTALL_PACKAGE_WITH_TEST_TOOLS := $(STATE_DIR)/package-installed-with-test-tools.state
$(INSTALL_PACKAGE_WITH_TEST_TOOLS): $(STATE_DIR)
	TEST_TOOLS=1 $(MAKE) install && touch $@
	test -f $@
install-with-test-tools: $(INSTALL_PACKAGE_WITH_TEST_TOOLS)

uninstall:
	$(PYTHON) -m pip uninstall -y $(PACKAGE_NAME) \
	&& $(RM) -rfv -- $(STATE_DIR)

test: install-with-test-tools
	$(PYTHON) -m unittest --verbose

clean:
	$(RM) -rv -- $(PYCACHE_DIRS) $(HYPOTHESIS_DIRS)

debug:
	$(info MKFILE_PATH $(MKFILE_PATH))
	$(info ROOT_DIR is $(ROOT_DIR))
	$(info CURRENT_DIR is $(CURRENT_DIR))
	$(info INSTALL_PACKAGE_WITH_TEST_TOOLS is $(INSTALL_PACKAGE_WITH_TEST_TOOLS))
	$(info PYCACHE_DIRS is $(PYCACHE_DIRS))
	$(info HYPOTHESIS_DIRS is $(HYPOTHESIS_DIRS))
	$(info SOURCE_CHECKSUM is $(SOURCE_CHECKSUM))
	$(info STATE_DIR is $(STATE_DIR))

# to release, you will need TWINE_USERNAME and TWINE_PASSWORD defined
release: setup.py test
	echo "WARNING - make release has never been tested" && exit 1
	$(MAKE) clean
	$(PYTHON) setup.py sdist
	$(PYTHON) -m pip install --user --upgrade twine
	$(HOME)/.local/bin/twine upload $(shell find dist -type f -name '*.tar.gz' | sort -V | grep . | tail -1)

print-%  : ; @echo $* = $($*)

.PHONY: clean debug test install-with-test-tools install uninstall print-%
