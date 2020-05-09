CSS := style.css
CSS_MINIFIED := $(CSS:=.minified)
HTML := countdown.html
HTML_MINIFIED := $(HTML:=.minified)
JAVSCRIPT := countdown.js
JAVASCRIPT_MINIFIED := $(JAVSCRIPT:=.minified)
PYTHON := countdown.py
TARGET := countdown
MINIFY := node-minify --silence

export PATH := $(CURDIR)/node_modules/.bin:$(PATH)

$(TARGET): $(PYTHON) $(HTML_MINIFIED)
	m4 $< > .tmp-$@
	chmod +x .tmp-$@
	mv .tmp-$@ $@

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

clean:
	rm -rf $(TARGET) $(CSS_MINIFIED) $(HTML_MINIFIED) $(JAVASCRIPT_MINIFIED) node_modules
