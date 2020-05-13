CSS := style.css
CSS_MINIFIED := $(CSS:=.minified)
HTML := countdown.html
HTML_MINIFIED := $(HTML:=.minified)
JAVSCRIPT := countdown.js
JAVASCRIPT_MINIFIED := $(JAVSCRIPT:=.minified)
TARGET := rocket.html
MINIFY := node-minify --silence

export PATH := $(CURDIR)/node_modules/.bin:$(CURDIR)/.venv/bin:$(PATH)
export PIPENV_VENV_IN_PROJECT := 1

$(TARGET): $(HTML_MINIFIED)
	cp $< $@

.venv:
	pipenv sync --bare --dev

node_modules:
	npm install

%.css.minified: %.css node_modules
	$(MINIFY) -c clean-css --input $< --output $@

%.html.minified: %.html $(CSS_MINIFIED) $(JAVASCRIPT_MINIFIED) node_modules
	m4 $< > .tmp-$<
	$(MINIFY) -c html-minifier --input .tmp-$< --output $@
	rm .tmp-$<

%.js.minified: %.js node_modules
	$(MINIFY) -c uglify-es --input $< --output $@

.PHONY: lint-css
lint-css: node_modules
	csslint --quiet $(CSS)

lint-html: .venv
	html_lint.py --disable=concerns_separation $(HTML)

.PHONY: lint-js
lint-js: node_modules
	eslint $(JAVSCRIPT)

.PHONY: lint
lint: lint-css lint-js lint-html

clean:
	rm -rf $(TARGET) $(CSS_MINIFIED) $(HTML_MINIFIED) $(JAVASCRIPT_MINIFIED) .venv node_modules
