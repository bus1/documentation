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

%.html: %.xml src/html.xsl
	$(AM_V_XSLT)$(XSLTPROC) $(XSLTPROC_FLAGS) -o $@ src/html.xsl $<

# ------------------------------------------------------------------------------
# documentation
html/%.html: src/%.xml src/html.xsl
	$(AM_V_XSLT)$(XSLTPROC) -o $@ $(XSLTPROC_FLAGS) src/html.xsl $<

XML_FILES = $(wildcard src/*.xml)

# ------------------------------------------------------------------------------
# bus1 kernel module documentation
html/%.html: ../bus1/Documentation/bus1/%.xml src/html.xsl
	$(AM_V_XSLT)$(XSLTPROC) -o $@ $(XSLTPROC_FLAGS) src/html.xsl $<

XML_FILES += $(wildcard ../bus1/Documentation/bus1/*.xml)

# ------------------------------------------------------------------------------
# bus1 kerneldoc internal kernel API
../../linux/scripts/docproc:
	( cd ../../linux && \
	  make -f scripts/Makefile scripts/docproc )

bus1.kernel-api.xml: ../../linux/scripts/docproc ../bus1/Documentation/DocBook/bus1.tmpl
	$(AM_V_XSLT) SRCTREE=../bus1 KBUILD_SRC=../../linux ../../linux/scripts/docproc doc ../bus1/Documentation/DocBook/bus1.tmpl 2>/dev/null > $@

html/bus1.kernel-api.html: bus1.kernel-api.xml
	$(AM_V_XSLT)$(XSLTPROC) -o $@ $(XSLTPROC_FLAGS) src/html.xsl $<

XML_FILES += bus1.kernel-api.xml

CLEANFILES += bus1.kernel-api.xml

# ------------------------------------------------------------------------------
# extract refname list from XMl files and create alias symlinks
aliases: $(XML_FILES)
	$(AM_V_at)for xml in $(XML_FILES); do \
		$(XSLTPROC) $(XSLTPROC_FLAGS) src/refname-list.xsl $$xml | while read file alias; do \
			ln -sf $$file.html html/$$alias.html; \
		done \
	done
.PHONY: aliases

# ------------------------------------------------------------------------------
# strip source directory, replace .xml with .html, add html/ target directory
HTML_FILES = $(addprefix html/,$(patsubst %.xml,%.html,$(notdir $(XML_FILES))))

CLEANFILES += $(wildcard html/*.html)

all: $(HTML_FILES) aliases
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
