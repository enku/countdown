CSS := style.css
HTML := countdown.html
JAVSCRIPT := countdown.js
PYTHON := countdown.py
TARGET := countdown

$(TARGET): $(PYTHON) $(HTML) $(CSS) $(JAVSCRIPT)
	m4 $< > .tmp-$@
	chmod +x .tmp-$@
	mv .tmp-$@ $@

clean:
	rm -f $(TARGET)
