#!/bin/bash

BASE="${BASH_SOURCE%/*}"
ln -sfv $(which node) "$BASE/bin/"
