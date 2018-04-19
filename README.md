## elm-upgrade ![](https://img.shields.io/npm/v/elm-upgrade.svg) ![Build Status](https://travis-ci.org/avh4/elm-upgrade.svg?branch=master)](https://travis-ci.org/avh4/elm-upgrade)

**elm-upgrade** helps you upgrade your Elm 0.17 projects to Elm 0.18.  It attemps to automate many of the steps in the [Elm 0.18 upgrade guide](https://github.com/elm-lang/elm-platform/blob/master/upgrade-docs/0.18.md).  **elm-upgrade** will do the following:
  - Update the `elm-version` in your project's `elm-package.json` file
  - Try to upgrade all of your project dependencies in `elm-package.json`
  - Warn you if some of your project dependencies don't support Elm 0.18 yet
  - Use [elm-format](https://github.com/avh4/elm-format) to upgrade your code, which includes the following:
    - Infix function calls using backticks become normal functions calls
    - Infix function calls using backticks with `andThen` and `onError` become pipelines
    - Ranges become calls to `List.range`
    - Primes in variable names become underscores
    - References to `fst` and `snd` become `Tuple.first` and `Tuple.second`

## How to use it

To use **elm-upgrade**, first [install elm-format](https://github.com/avh4/elm-format#installation-) and then run the following in your terminal:

```sh
npm install -g elm-upgrade
cd path/to/my/elm/project
elm-upgrade
```

After the automated upgrade, you will probably still have to fix a few things.  See the [Elm 0.18 upgrade guide](https://github.com/elm-lang/elm-platform/blob/master/upgrade-docs/0.18.md) for more details.


## What it looks liks

```
Ξ workspace/tangram-logo git:(master) ▶ elm-upgrade
INFO: Found elm at /usr/local/bin/elm
INFO: Found elm-format at /usr/local/bin/elm-format
INFO: Found Elm Platform 0.18.0
INFO: Found elm-format-0.18 0.5.0-alpha-elm018beta-rc1
INFO: Cleaning ./elm-stuff before upgrading
INFO: Changing elm-package.json#elm-version to "0.18.0 <= v < 0.19.0"
INFO: Removing all dependencies from elm-package.json to reinstall them
INFO: Installing latest version of elm-lang/core
INFO: Installing latest version of elm-lang/html
INFO: Installing latest version of elm-lang/svg
INFO: Upgrading *.elm files in ./


SUCCESS! Your project's dependencies and code have been upgraded.
However, your project may not yet compile due to API changes in your
dependencies.

See https://github.com/elm-lang/elm-platform/blob/master/upgrade-docs/0.18.md
and the documentation for your dependencies for more information.

Ξ workspace/tangram-logo git:(master) ▶ git diff
```
```diff
diff --git a/Pieces.elm b/Pieces.elm
index c15b583..65bd962 100644
--- a/Pieces.elm
+++ b/Pieces.elm
@@ -54,12 +54,12 @@ rotate angle ps =
         rad =
             degrees angle

-        rotate' ( x, y ) =
+        rotate_ ( x, y ) =
             ( cos rad * x + sin rad * y
             , sin rad * -x + cos rad * y
             )
     in
-        List.map rotate' ps
+        List.map rotate_ ps


 triangle : Float -> List Point
diff --git a/elm-package.json b/elm-package.json
index a21d43e..dd09245 100644
--- a/elm-package.json
+++ b/elm-package.json
@@ -8,9 +8,9 @@
     ],
     "exposed-modules": [],
     "dependencies": {
-        "elm-lang/core": "4.0.5 <= v < 5.0.0",
-        "elm-lang/html": "1.1.0 <= v < 2.0.0",
-        "elm-lang/svg": "1.1.1 <= v < 2.0.0"
+        "elm-lang/core": "5.0.0 <= v < 6.0.0",
+        "elm-lang/html": "2.0.0 <= v < 3.0.0",
+        "elm-lang/svg": "2.0.0 <= v < 3.0.0"
     },
-    "elm-version": "0.17.1 <= v < 0.18.0"
+    "elm-version": "0.18.0 <= v < 0.19.0"
 }
```


## Development info for contributors to elm-upgrade

```sh
npm install
npm link
```

You should now have `elm-upgrade` on your path.
