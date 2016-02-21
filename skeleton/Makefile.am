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
bin_PROGRAMS =

AM_CPPFLAGS = \
	-include $(top_builddir)/build/config.h \
	-I $(top_srcdir)/src \
	-I $(top_builddir)/src \
	$(OUR_CPPFLAGS)

AM_CFLAGS = $(OUR_CFLAGS)
AM_LDFLAGS = $(OUR_LDFLAGS)

# ------------------------------------------------------------------------------
# org.bus1.skeleton

bin_PROGRAMS += \
	org.bus1.skeleton

org_bus1_skeleton_SOURCES = \
	src/skeleton.h \
	src/skeleton.c
