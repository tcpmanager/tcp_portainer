.PHONY: all install_requirements download combine

PYTHON := $(shell which python3 2>/dev/null || which python)

all: install_requirements download combine list

install_requirements:
	$(PYTHON) -m pip install -r scripts/requirements.txt

download:
	$(PYTHON) scripts/download.py

combine:
	$(PYTHON) scripts/combine.py

validate:
	$(PYTHON) scripts/validate.py

list:
	$(PYTHON) scripts/list.py
