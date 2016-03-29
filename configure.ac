# ------------------------------------------------------------------------------
# versions

AC_PREREQ([2.64])
AC_INIT([documentation],
        [1],
        [http://www.github.com/bus1/documentation],
        [documentation],
        [http://www.github.com/bus1/documentation])

# ------------------------------------------------------------------------------
# autotools

AC_CONFIG_SRCDIR([src/index.xml])
AC_CONFIG_MACRO_DIR([build/m4])
AC_CONFIG_HEADERS([build/config.h])
AC_CONFIG_AUX_DIR([build/build-aux])

AM_MAINTAINER_MODE([enable])
AM_INIT_AUTOMAKE([foreign 1.11 -Wall -Wno-portability silent-rules tar-pax no-dist-gzip dist-xz subdir-objects parallel-tests])
AM_SILENT_RULES([yes])
AC_CANONICAL_HOST
AC_DEFINE_UNQUOTED([CANONICAL_HOST], "$host", [Canonical host string.])

AC_PATH_PROG([XSLTPROC], [xsltproc])

# ------------------------------------------------------------------------------
# report

AC_CONFIG_FILES([Makefile])

AC_OUTPUT
AC_MSG_RESULT([
        $PACKAGE_NAME $VERSION
        prefix:                 ${prefix}
])
