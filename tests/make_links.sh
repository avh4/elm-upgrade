#!/bin/bash

BASE="${BASH_SOURCE%/*}"
ln -sfv "$(which node)" "$BASE/bin/"
ln -sfv "$(which rsync)" "$BASE/bin/"
ln -sfv "$(which git)" "$BASE/bin/"
ln -sfv "$(which security)" "$BASE/bin/" || true # required by elm, but only on Mac OS
