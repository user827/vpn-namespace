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

autoreconf --verbose --force --install --symlink

args="\
  --sysconfdir=/etc \
  --localstatedir=/var \
"

if [ -f "$topdir/.config.args" ]; then
  args="$args $(cat "$topdir"/.config.args)"
fi

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
