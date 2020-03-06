#!/bin/bash

function make_link {
  if which -s "$1"; then
    ln -sfv "$(which "$1")" "$BASE/bin/"
  else
    echo "$0: ERROR: not found on \$PATH: $1"
    exit 1
  fi
}

echo "Locating command line tools needed for integration tests..."
BASE="${BASH_SOURCE%/*}"
make_link node
make_link rsync
make_link git
ln -sfv "$(which security)" "$BASE/bin/" || true # required by elm, but only on Mac OS
make_link jq
make_link mv
make_link yes
make_link sed
make_link dirname
make_link uname

echo
