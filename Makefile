SHELL := /bin/bash

PACKAGE_NAME := litecollections

PYTHON := python3

PYCACHE_DIRS = $(shell find -type d -name __pycache__)

install: setup.py
	$(PYTHON) -m pip install --user .

install-with-test-tools:
	$(PYTHON) -m pip install --user hypothesis
	$(MAKE) install

test: install-with-test-tools
	$(PYTHON) -m unittest --verbose $(PACKAGE_NAME)

clean:
	rm -rv $(PYCACHE_DIRS)
