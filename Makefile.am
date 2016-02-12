SHELL=bash
AM_MAKEFLAGS = --no-print-directory
AUTOMAKE_OPTIONS = color-tests parallel-tests

GCC_COLORS ?= 'ooh, shiny!'
export GCC_COLORS

CLEANFILES =

# ------------------------------------------------------------------------------

AM_V_XSLT = $(AM_V_XSLT_$(V))
AM_V_XSLT_ = $(AM_V_XSLT_$(AM_DEFAULT_VERBOSITY))
AM_V_XSLT_0 = @echo "  XSLT    " $@;

XSLTPROC_FLAGS = \
        --nonet \
        --xinclude \
        --stringparam man.output.quietly 1 \
        --stringparam funcsynopsis.style ansi \
        --stringparam man.authors.section.enabled 0 \
        --stringparam man.copyright.section.enabled 0 \
        --stringparam bus1.version $(VERSION)

html/%.html: src/%.xml
	$(AM_V_XSLT)$(XSLTPROC) -o $@ $(XSLTPROC_FLAGS) http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl $<

XML_FILES = $(wildcard src/*.xml)
HTML_FILES = $(patsubst src/%.xml,html/%.html,$(XML_FILES))

CLEANFILES += \
	$(HTML_FILES)

html: $(HTML_FILES)
	$(AM_V_at)$(MKDIR_P) html

all: html
.PHONY: all

push: html
	rsync -av --delete --exclude='.*' --exclude=README --exclude=CNAME html/ ../bus1.github.io/
	( cd ../bus1.github.io && \
	  git add *.html && \
	  git commit -a -m 'Update from "docs" repository' && \
	  git push )
.PHONY: push
