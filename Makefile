sources = \
		$(wildcard docs/source/* docs/source/*/*) \
		requirements.txt \
		Makefile


.PHONY: all
all: env

.PHONY: build
build: $(sources) | \
		docs/build/html \
		env/bin/sphinx-build
	env/bin/sphinx-build docs/source docs/build/html

# Note you must escape '&' in the matomo tpl as it has special meaning in sed
release: build
	sed -i \
		's|<body class="wy-body-for-nav">|<body class="wy-body-for-nav matomo">\n$(shell cat matomo.tpl)|g' \
		$$(find docs/build/html -type f -name '*.html')
	find . -type f -name *.pickle
	rm ./docs/build/html/.doctrees/environment.pickle

docs/build:
	mkdir -p $(@)

docs/build/html: docs/build
	mkdir -p $(@)

env: requirements.txt
	python -m venv env
	env/bin/pip install --upgrade pip
	env/bin/pip install -r requirements.txt && touch $(@)

env/bin/sphinx-build: env

.PHONY: clean
clean: clean-build clean-env

.PHONY: clean-build
clean-build:
	test ! -d docs/build || rm -rf docs/build

.PHONY: clean-env
clean-env:
	test ! -d env || rm -rf env
