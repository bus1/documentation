# ------------------------------------------------------------------------------
# autotools

SHELL = bash
ACLOCAL_AMFLAGS = -I build/m4 ${ACLOCAL_FLAGS}
AM_MAKEFLAGS = --no-print-directory
AUTOMAKE_OPTIONS = color-tests parallel-tests

GCC_COLORS ?= 'ooh, shiny!'
export GCC_COLORS

# remove targets if the command fails
.DELETE_ON_ERROR:

# keep intermediate files
.SECONDARY:

# keep the test-suite.log and Makefile around at all times
.PRECIOUS: $(TEST_SUITE_LOG) Makefile

CLEANFILES = $(BUILT_SOURCES)

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
	$(AM_V_XSLT)$(XSLTPROC) -o $@ $(XSLTPROC_FLAGS) src/html.xsl $<

XML_FILES = $(wildcard src/*.xml)
HTML_FILES = $(patsubst src/%.xml,html/%.html,$(XML_FILES))

CLEANFILES += \
	$(HTML_FILES)

all: $(HTML_FILES)
.PHONY: all

push: html
	rsync -av --delete --exclude='.*' --exclude=README --exclude=CNAME src/bus1.png html/ ../bus1.github.io/
	( cd ../bus1.github.io && \
	  git add *.html *.png && \
	  git commit -a -m 'Update from "documentation" repository' && \
	  git push )
.PHONY: push
