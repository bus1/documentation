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

AM_V_CP = $(AM_V_CP_$(V))
AM_V_CP_ = $(AM_V_CP_$(AM_DEFAULT_VERBOSITY))
AM_V_CP_0 = @echo "  CP      " $@;

XSLTPROC_FLAGS = \
        --nonet \
        --xinclude \
        --stringparam refentry.generate.name 0 \
        --stringparam man.output.quietly 1 \
        --stringparam funcsynopsis.style ansi \
        --stringparam man.authors.section.enabled 0 \
        --stringparam man.copyright.section.enabled 0 \
        --stringparam bus1.version $(VERSION)

html/%.css: src/%.css
	$(AM_V_at)$(MKDIR_P) html
	$(AM_V_CP) cp $< $@

CSS_FILES = \
	html/bus1.css

html/%.svg: src/%.svg
	$(AM_V_at)$(MKDIR_P) html
	$(AM_V_CP) cp $< $@

IMAGE_FILES = \
	html/bus1.svg

html/%.html: src/%.xml src/html.xsl
	$(AM_V_XSLT)$(XSLTPROC) -o $@ $(XSLTPROC_FLAGS) src/html.xsl $<

XML_FILES = $(wildcard src/*.xml)
HTML_FILES = $(patsubst src/%.xml,html/%.html,$(XML_FILES))

# ------------------------------------------------------------------------------
# bus1 kernel module
html/%.html: ../bus1/Documentation/bus1/%.xml src/html.xsl
	$(AM_V_XSLT)$(XSLTPROC) -o $@ $(XSLTPROC_FLAGS) src/html.xsl $<

XML_KERNEL_FILES = $(wildcard ../bus1/Documentation/bus1/*.xml)
HTML_KERNEL_FILES = $(patsubst ../bus1/Documentation/bus1/%.xml,html/%.html,$(XML_KERNEL_FILES))

# ------------------------------------------------------------------------------
CLEANFILES += \
	$(CSS_FILES) \
	$(IMAGE_FILES) \
	$(HTML_FILES) \
	$(HTML_KERNEL_FILES)

all: $(CSS_FILES) $(IMAGE_FILES) $(HTML_FILES) $(HTML_KERNEL_FILES) src/html.xsl
.PHONY: all

push: html
	rsync -av --delete --exclude='.*' --exclude=README --exclude=CNAME html/ ../bus1.github.io/
	( cd ../bus1.github.io && \
	  git add *.html *.css *.svg && \
	  git commit -a -m 'Update from "documentation" repository' && \
	  git push )
.PHONY: push
