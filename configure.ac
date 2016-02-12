AC_INIT([docs],
        [1],
        [http://www.github.com/bus1/docs],
        [docs],
        [http://www.github.com/bus1/docs])

AC_CONFIG_SRCDIR([src/bootup.txt])
AC_CONFIG_AUX_DIR([build-aux])

AM_INIT_AUTOMAKE([foreign 1.11 -Wall -Wno-portability silent-rules tar-pax no-dist-gzip dist-xz subdir-objects])
AM_SILENT_RULES([yes])

AC_CANONICAL_HOST

AC_PATH_PROG([XSLTPROC], [xsltproc])

# ------------------------------------------------------------------------------
# arguments

AC_ARG_ENABLE(debug, AS_HELP_STRING([--enable-debug], [enable debug options]))

# ------------------------------------------------------------------------------
AC_CONFIG_FILES([
        Makefile
])

AC_OUTPUT
AC_MSG_RESULT([
        $PACKAGE_NAME $VERSION

        prefix:                  ${prefix}
])
