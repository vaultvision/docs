sources = \
		$(wildcard docs/source/* docs/source/*/*) \
		requirements.txt \
		Makefile


.PHONY: all
all: .venv

.PHONY: build
build: $(sources) | \
		docs/build/html \
		.venv/bin/sphinx-build
	.venv/bin/sphinx-build docs/source docs/build/html
	cp -af \
		docs/source/js/override_default_light.js \
		docs/build/html/_static/dark_mode_js/default_light.js
	cp -af \
		docs/source/js/override_theme_switcher.js \
		docs/build/html/_static/dark_mode_js/theme_switcher.js

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

.venv: requirements.txt
	python -m venv .venv
	.venv/bin/pip install --upgrade pip
	.venv/bin/pip install -r requirements.txt && touch $(@)

.venv/bin/sphinx-build: .venv

.PHONY: clean
clean: clean-build clean-venv

.PHONY: clean-build
clean-build:
	test ! -d docs/build || rm -rf docs/build

.PHONY: clean-venv
clean-venv:
	test ! -d .venv || rm -rf .venv
