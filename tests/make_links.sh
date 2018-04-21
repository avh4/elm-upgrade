#!/bin/bash

BASE="${BASH_SOURCE%/*}"
ln -sfv $(which node) "$BASE/bin/"
ln -sfv $(which rsync) "$BASE/bin/"
