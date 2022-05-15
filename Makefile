SHELL := /bin/bash

PACKAGE_NAME := litecollections

COMPONENTS = $(wildcard $(PACKAGE_NAME)/Lite*.py)

debug:
	echo $(COMPONENTS)
