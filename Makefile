SHELL = /usr/bin/env bash

# Node.js
NODE ?= node

# Python
OS_PYTHON_VERSION = 3.11
OS_PYTHON = python$(OS_PYTHON_VERSION)
VENV_DIR = .venv
VENV_PYTHON = $(VENV_DIR)/bin/python3
VENV_PIP = $(VENV_DIR)/bin/pip
#TEST_DIR = tests
#SRC_DIR = src
PYTHON_REQUIREMENTS_FILE = requirements.txt

NODEENV = $(VENV_DIR)/bin/nodeenv
VENV_NODE = $(VENV_DIR)/bin/node
JUPYTER_CLI = $(VENV_DIR)/bin/jupyter

# Default target
.DEFAULT_GOAL := help
.PHONY: help
.PHONY: create-venv
.PHONY: delete-venv
.PHONY: install-node
.PHONY: install-dependencies
#.PHONY: test
#.PHONY: lint
#.PHONY: format
.PHONY: clean-pyc
.PHONY: clean-jupyter-book
.PHONY: clean-jupyter-book-all

all: help

# Parse and print the target names and their descriptions in a formatted way
define PY_SCRIPT_PARSE_PRINT_TARGETS
import re, sys
for line in sys.stdin:
	if match:= re.match(r'^(?P<name>[a-zA-Z_-]+[0-9a-zA-Z_-]+):.*?## (?P<msg>.*)$$', line):
		print(f"{match['name']:<30}\t{match['msg']}")
endef
export PY_SCRIPT_PARSE_PRINT_TARGETS

help: ## Show help
	@echo -e "See README.md\n"
	@echo -e "Makefile targets:\n"
	@$(OS_PYTHON) -c "$$PY_SCRIPT_PARSE_PRINT_TARGETS" < $(MAKEFILE_LIST)

create-venv: ## Create virtual environment
	$(OS_PYTHON) -m venv $(VENV_DIR)
	$(VENV_PIP) install --upgrade pip
	$(VENV_PIP) install --upgrade setuptools wheel

delete-venv: ## Delete Python virtual environment
	rm -rf $(VENV_DIR)

install-dependencies: ## Install dependencies
	$(VENV_PIP) install -r $(PYTHON_REQUIREMENTS_FILE)

install-node: install-dependencies ## Install latest Node.js LTS into the Python virtual environment
	$(NODEENV) --node=lts --prebuilt --python-virtualenv
	@echo -e "Node installed in local Python virtualenv"
	@$(VENV_NODE) --version

#test: ## Run tests
#	$(VENV_PYTHON) -m pytest $(TEST_DIR)

#lint: ## Run linting
#	$(VENV_PYTHON) -m flake8 $(SRC_DIR)

#format: ## Format code
#	$(VENV_PYTHON) -m black $(SRC_DIR)

clean-pyc: ## Clean up generated Python bytecode files
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

clean-jupyter-book: ## Clean up files built by Jupyter Book
	$(JUPYTER_CLI) book clean

clean-jupyter-book-all: ## Clean up all files built, retrieved or generated in any form by Jupyter Book
	$(JUPYTER_CLI) book clean --all --yes
