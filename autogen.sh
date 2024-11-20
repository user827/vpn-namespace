set -eu

oldpwd=$(pwd)
topdir=$(dirname "$0")
cd "$topdir"

if [ -f .git/hooks/pre-commit.sample ] && [ ! -f .git/hooks/pre-commit ]; then
  # This part is allowed to fail
  cp -p .git/hooks/pre-commit.sample .git/hooks/pre-commit && \
    chmod +x .git/hooks/pre-commit && \
    echo "Activated pre-commit hook." || :
fi

#intltoolize --force --automake
autoreconf --verbose --force --install --symlink

#libdir() {
#  echo $(cd "$1/$(gcc -print-multi-os-directory)"; pwd)
#}

args="\
  --sysconfdir=/etc \
  --localstatedir=/var \
"
#--libdir=$(libdir /usr/lib) \

if [ -f "$topdir/.config.args" ]; then
  args="$args $(cat "$topdir"/.config.args)"
fi

#if [ ! -L /bin ]; then
#  args="$args \
#    --with-rootprefix=/ \
#    --with-rootlibdir=$(libdir /lib) \
#    "
#fi

cd "$oldpwd"

if [ "${1:-}" = c ]; then
  "$topdir"/configure $args
  make --warn-undefined-variables clean
else
  echo
  echo "----------------------------------------------------------------"
  echo "Initialized build system. For a common configuration please run:"
  echo "----------------------------------------------------------------"
  echo
  echo "$topdir/configure $args"
  echo
fi
