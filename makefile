SHELL     := /bin/bash

DIST_DIR  := dist
ETC_DIR   := etc
SASS_DIR  := sass
SRC_DIR   := src

INPUT_FMT := markdown
HTML_FMT  := html
TEXT_FMT  := plain

HFLAGS     = --standalone
HFLAGS    += --from $(INPUT_FMT)
HFLAGS    += --to $(HTML_FMT)
HFLAGS    += --css=../style.css
HFLAGS    += --no-highlight

TFLAGS     = -f $(INPUT_FMT)
TFLAGS    += -t $(TEXT_FMT)

SFLAGS     = --style=compressed
SFLAGS    += --no-source-map

.PHONY: all build clean deploy etc html plaintext sass

all: build

build: sass html plaintext etc

clean:
	rm -rf $(DIST_DIR)

deploy:
	git push server # Assume "server" is set up in SSH config

etc:
	cp -R $(ETC_DIR)/. $(DIST_DIR)

html: sass
	for i in $$(find $(SRC_DIR) -iname "*.md"); do \
	mkdir -p $(DIST_DIR)/$$(basename $$i ".md"); \
	pandoc $$i -o $(DIST_DIR)/$$(basename $$i ".md")/index.html $(HFLAGS); \
	done

plaintext:
	mkdir -p $(DIST_DIR)/t
	for i in $$(find $(SRC_DIR) -iname "*.md"); do \
	pandoc $$i -o $(DIST_DIR)/t/$$(basename $$i ".md") $(TFLAGS); \
	done

sass:
	sass $(SASS_DIR)/style.sass $(DIST_DIR)/style.css $(SFLAGS)
