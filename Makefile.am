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
        --stringparam bus1.version $(VERSION)

# ------------------------------------------------------------------------------
# documentation
html/%.html: src/%.xml src/html.xsl
	$(AM_V_XSLT)$(XSLTPROC) -o $@ $(XSLTPROC_FLAGS) src/html.xsl $<

HTML_FILES = $(patsubst src/%.xml,html/%.html,$(wildcard src/*.xml))

# ------------------------------------------------------------------------------
# bus1 kernel module documentation
html/%.html: ../bus1/Documentation/bus1/%.xml src/html.xsl
	$(AM_V_XSLT)$(XSLTPROC) -o $@ $(XSLTPROC_FLAGS) src/html.xsl $<

HTML_FILES += $(patsubst ../bus1/Documentation/bus1/%.xml,html/%.html,$(wildcard ../bus1/Documentation/bus1/*.xml))

# ------------------------------------------------------------------------------
CLEANFILES += $(HTML_FILES)

all: $(HTML_FILES)
.PHONY: all

web: all
	( cd ../bus1.github.io && \
	  git pull --rebase )
	rsync -av --delete --exclude='.*' --exclude=README --exclude=CNAME html/ ../bus1.github.io/
	( cd ../bus1.github.io && \
	  git add *.html *.css *.png *.svg && \
	  git commit -a -m 'Update from "documentation" repository' && \
	  git push )
.PHONY: web
