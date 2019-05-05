STYLE     := reader

SHELL     := /bin/sh
UNAME     := $(shell uname -s)

DATA_DIR  := data
DIST_DIR  := dist
ETC_DIR   := etc
FONTS_DIR := fonts
SASS_DIR  := sass
SRC_DIR   := src

INPUT_FMT := markdown
HTML_FMT  := html
TEXT_FMT  := plain

HFLAGS     = --standalone
HFLAGS    += --template=$(DATA_DIR)/$(STYLE).pdc
HFLAGS    += --from $(INPUT_FMT)
HFLAGS    += --to $(HTML_FMT)
HFLAGS    += --css=../style.css
HFLAGS    += --no-highlight

TFLAGS     = --from $(INPUT_FMT)
TFLAGS    += --to $(TEXT_FMT)
TFLAGS    += --template=$(DATA_DIR)/plain.pdc

SFLAGS     = --style=compressed
SFLAGS    += --no-source-map

SWFLAGS    = --watch


.PHONY: all build clean deploy etc html plaintext sass sass-live
.SILENT: etc html plaintext sass

all: build

build: sass html plaintext etc

clean:
	rm -rf $(DIST_DIR)

deploy:
	git push server # Assume "server" is set up in SSH config

etc:
	cp -R $(ETC_DIR)/. $(DIST_DIR)
	echo "Copy static files to dist/"

html: sass
	for i in $$(find $(SRC_DIR) -iname "*.md"); do \
	mkdir -p $(DIST_DIR)/$$(basename $$i ".md"); \
	pandoc $$i -o $(DIST_DIR)/$$(basename $$i ".md")/index.html $(HFLAGS); \
	done
	echo "Compile HTML files"
ifeq ($(UNAME), Darwin)
	find $(DIST_DIR) -type f -iname "index.html" | xargs sed -i '' 's/↩/[return]/g'
else ifeq ($(UNAME), Linux)
	find $(DIST_DIR) -type f -iname "index.html" | xargs sed -i 's/↩/[return]/g'
endif
	echo "Replace default Pandoc footnote character"
	mv $(DIST_DIR)/index/index.html $(DIST_DIR)/index.html
	rm -rf $(DIST_DIR)/index
	echo "Resolve index file"
	cp -r $(FONTS_DIR) $(DIST_DIR)/$(FONTS_DIR)
	echo "Copy fonts to dist/"

plaintext:
	mkdir -p $(DIST_DIR)/t
	for i in $$(find $(SRC_DIR) -iname "*.md"); do \
	pandoc $$i -o $(DIST_DIR)/t/$$(basename $$i ".md") $(TFLAGS); \
	done
	echo "Compile plaintext files"

sass:
	sass $(SASS_DIR)/$(STYLE)/style.sass $(DIST_DIR)/style.css $(SFLAGS)
	echo "Compile SASS stylesheets"

sass-live:
	sass $(SASS_DIR)/$(STYLE)/style.sass $(DIST_DIR)/style.css $(SFLAGS) $(SWFLAGS)
