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
# bus1 kerneldoc internal kernel API
../../linux/scripts/docproc:
	( cd ../../linux && \
	  make -f scripts/Makefile scripts/docproc )

bus1.kernel-api.xml: ../../linux/scripts/docproc ../bus1/Documentation/DocBook/bus1.tmpl
	$(AM_V_XSLT) SRCTREE=../bus1 KBUILD_SRC=../../linux ../../linux/scripts/docproc doc ../bus1/Documentation/DocBook/bus1.tmpl 2>/dev/null > $@

CLEANFILES += bus1.kernel-api.xml

html/bus1.kernel-api.html: bus1.kernel-api.xml
	$(AM_V_XSLT)$(XSLTPROC) -o $@ $(XSLTPROC_FLAGS) src/html.xsl $<

HTML_FILES += html/bus1.kernel-api.html

# ------------------------------------------------------------------------------
CLEANFILES += $(HTML_FILES)

all: $(HTML_FILES)
.PHONY: all

# we need to update the external sources before we build our pages
git-update:
	git pull --rebase
	( cd ../bus1.github.io && \
	  git pull --rebase )
	( cd ../bus1 && \
	  git pull --rebase )
.PHONY: git-update

web: git-update all
	rsync -av --delete --exclude='.*' --exclude=README --exclude=CNAME html/ ../bus1.github.io/
	( cd ../bus1.github.io && \
	  git add *.html *.css *.png *.svg && \
	  git commit -a -m 'Update from "documentation" repository' && \
	  git push )
.PHONY: web
