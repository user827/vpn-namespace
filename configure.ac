#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([vpnns], [m4_esyscmd_s([git describe --always])], [no@to.bugs])
AC_CONFIG_AUX_DIR([build-aux])
#TODO what the heck does subdir-objects do?
AM_INIT_AUTOMAKE([foreign 1.11 -Wall -Wno-portability -Werror tar-pax no-dist-gzip dist-xz])

# Checks for programs.
AC_PROG_INSTALL
AC_PROG_SED
AC_PROG_LN_S

AC_PREFIX_DEFAULT([/usr])
AM_SILENT_RULES([yes])


# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_CONFIG_FILES([
  Makefile
])
#AC_CONFIG_SUBDIRS([
  #src/hooks/altroute_vpn4
#])

AC_OUTPUT
