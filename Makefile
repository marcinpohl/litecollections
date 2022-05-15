SHELL := /bin/bash

PACKAGE_NAME := litecollections

PYTHON := python3

# dirs to clean up
PYCACHE_DIRS = $(shell find -type d -name __pycache__)
HYPOTHESIS_DIRS = $(shell find -type d -name .hypothesis)

# state management
SOURCE_CHECKSUM := $(shell grep -r litecollections -e . 2>&1 | sha1sum | awk '{print $$1}')
STATE_DIR := .state/$(SOURCE_CHECKSUM)
$(STATE_DIR):
	mkdir -p $@

INSTALL_PACKAGE := $(STATE_DIR)/package-installed.state
$(INSTALL_PACKAGE): $(STATE_DIR) setup.py
	$(PYTHON) -m pip install --user . && touch $@
	test -f $@
install: $(INSTALL_PACKAGE)

#	$(PYTHON) -m pip install --user hypothesis && touch $@

INSTALL_PACKAGE_WITH_TEST_TOOLS := $(STATE_DIR)/package-installed-with-test-tools.state
$(INSTALL_PACKAGE_WITH_TEST_TOOLS): $(STATE_DIR)
	TEST_TOOLS=1 $(MAKE) install && touch $@
	test -f $@
install-with-test-tools: $(INSTALL_PACKAGE_WITH_TEST_TOOLS)

test: install-with-test-tools
	$(PYTHON) -m unittest --verbose

clean:
	rm -rv $(PYCACHE_DIRS) $(HYPOTHESIS_DIRS)

# to release, you will need TWINE_USERNAME and TWINE_PASSWORD defined
release: setup.py test
	echo "WARNING - make release has never been tested" && exit 1
	$(MAKE) clean
	$(PYTHON) setup.py sdist
	$(PYTHON) -m pip install --user --upgrade twine
	$(HOME)/.local/bin/twine upload $(shell find dist -type f -name '*.tar.gz' | sort -V | grep . | tail -1)

	
