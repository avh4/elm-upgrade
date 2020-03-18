#!/bin/bash

set -ex

echo "Pre-downloading required elm packages"
yes | ./node_modules/.bin/elm init
yes | ./node_modules/.bin/elm install elm/json
yes | ./node_modules/.bin/elm install elm/core
yes | ./node_modules/.bin/elm install elm/time
yes | ./node_modules/.bin/elm install elm/random
yes | ./node_modules/.bin/elm install elm/virtual-dom
yes | ./node_modules/.bin/elm install elm/html
yes | ./node_modules/.bin/elm install NoRedInk/elm-json-decode-pipeline
yes | ./node_modules/.bin/elm install elm-explorations/webgl
rm elm.json
