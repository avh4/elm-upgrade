## elm-upgrade [![](https://img.shields.io/npm/v/elm-upgrade.svg)](https://www.npmjs.com/package/elm-upgrade) [![Build Status](https://travis-ci.org/avh4/elm-upgrade.svg?branch=master)](https://travis-ci.org/avh4/elm-upgrade)

`elm-upgrade` can help you **upgrade your Elm 0.18 projects to Elm 0.19**.  It attempts to automate many of the steps in the [Elm 0.19 upgrade guide][upgrade].  `elm-upgrade` will do the following:
  - Convert your `elm-package.json` file to ...
    - ... an application `elm.json` if your project has no exposed modules
    - ... a package `elm.json` if your project has at least one exposed module
  - Try to upgrade all of your project dependencies
  - Warn you if some of your project dependencies don't support Elm 0.19 yet
  - Use [elm-format](https://github.com/avh4/elm-format) `--upgrade` to upgrade your code, which includes the following:
    - Convert escaped characters in strings to the new syntax (`\u{xxxx}`)
    - Inline uses of functions which were removed in Elm 0.19:
      - `(,,)`, `(,,,)`, etc tuple constructor functions
      - `Platform.Cmd.(!)`
      - `flip`, `curry`, `uncurry`, and `rem` from the `Basics` module
    - Upgrade code that uses `Html.Attributes.style`

`elm-upgrade` can also **upgrade dependencies of your Elm 0.19 applications**.
If you are already using Elm 0.19, `elm-upgrade` will to the following:
  - check for newer versions of all your direct dependencies and try to install them


## How to use **elm-upgrade**

First install Elm 0.19 and the latest version of [elm-format](https://github.com/avh4/elm-format#installation-).  (If you want to install them locally for your project, you can do so with the following: )

```sh
cd path/to/my/elm/project
npm install elm@elm0.19.0
npm install elm-format@elm0.19.0
```

Then run the following in your terminal:

```sh
cd path/to/my/elm/project
npx elm-upgrade@latest
```

NOTE:  `npx` ships with node 8.2 and later.  If you need to use an older version of node, you can still use elm-upgrade with `npm install -g elm-upgrade; elm-upgrade`.

After the automated upgrade, you will probably still have to fix a few things.  See the [Elm 0.19 upgrade guide][upgrade] for more details.

[upgrade]: https://github.com/elm/compiler/blob/master/upgrade-docs/0.19.md

## What it looks like

```
$ elm-upgrade
INFO: Found elm at /Users/avh4/workspace/elm-upgrade/node_modules/.bin/elm
INFO: Found elm 0.19.0
INFO: Found elm-format at /Users/avh4/workspace/elm-upgrade/node_modules/.bin/elm-format
INFO: Found elm-format 0.8.0
INFO: Cleaning ./elm-stuff before upgrading
INFO: Converting elm-package.json -> elm.json
INFO: Detected an application project (this project has no exposed modules)
INFO: Switching from elm-lang/core (deprecated) to elm/core
INFO: Installing latest version of elm/core
It is already installed!
INFO: Detected use of elm-lang/core#Random; installing elm/random
Here is my plan:

  Add:
    elm/random    1.0.0
    elm/time      1.0.0

Would you like me to update your elm.json accordingly? [Y/n]: y
Dependencies loaded from local cache.
Dependencies ready!
INFO: Detected use of elm-lang/core#Time; installing elm/time
I found it in your elm.json file, but in the "indirect" dependencies.
Should I move it into "direct" dependencies for more general use? [Y/n]: y
Dependencies loaded from local cache.
Dependencies ready!
INFO: Switching from elm-lang/html (deprecated) to elm/html
INFO: Installing latest version of elm/html
Here is my plan:

  Add:
    elm/html           1.0.0
    elm/virtual-dom    1.0.0

Would you like me to update your elm.json accordingly? [Y/n]: y
Dependencies loaded from local cache.
Dependencies ready!
INFO: Upgrading *.elm files in ./


SUCCESS! Your project's dependencies and code have been upgraded.
However, your project may not yet compile due to API changes in your
dependencies.

See <https://github.com/elm/compiler/blob/master/upgrade-docs/0.19.md>
and the documentation for your dependencies for more information.

Here are some common upgrade steps that you will need to do manually:

- elm/core
  - [ ] Replace uses of toString with String.fromInt, String.fromFloat, or Debug.toString as appropriate
- elm/html
  - [ ] If you used Html.program*, install elm/browser and switch to Browser.element or Browser.document
  - [ ] If you used Html.beginnerProgram, install elm/browser and switch Browser.sandbox

$ git add -N elm.json
$ git diff
```
```diff
diff --git a/Main.elm b/Main.elm
index 7dd0dfb..1cbcdea 100644
--- a/Main.elm
+++ b/Main.elm
@@ -1,4 +1,4 @@
-module Main exposing (..)
+module Main exposing (Model, Msg(..), height, init, main, update, view, width)

 import Html exposing (..)
 import Html.Attributes exposing (..)
@@ -122,31 +122,27 @@ view model =
         cursorY =
             toString model.yPosition ++ "px"
     in
-    div [ style [ ( "position", "relative" ) ] ]
+    div [ style "position" "relative" ]
         [ img
-            [ style
-                [ ( "width", "100%" )
-                , ( "max-width", toString width ++ "px" )
-                , ( "margin-left", "-50%" )
-                , ( "position", "absolute" )
-                , ( "left", "50%" )
-                ]
+            [ style "width" "100%"
+            , style "max-width" (toString width ++ "px")
+            , style "margin-left" "-50%"
+            , style "position" "absolute"
+            , style "left" "50%"
             , src "assets/oujia_6.jpeg"
             ]
             []
         ]
diff --git a/elm-package.json b/elm-package.json
deleted file mode 100644
index f5ba1c5..0000000
--- a/elm-package.json
+++ /dev/null
@@ -1,15 +0,0 @@
-{
-    "version": "1.0.0",
-    "summary": "helpful summary of your project, less than 80 characters",
-    "repository": "https://github.com/user/project.git",
-    "license": "BSD3",
-    "source-directories": [
-        "."
-    ],
-    "exposed-modules": [],
-    "dependencies": {
-        "elm-lang/core": "5.1.1 <= v < 6.0.0",
-        "elm-lang/html": "2.0.0 <= v < 3.0.0"
-    },
-    "elm-version": "0.18.0 <= v < 0.19.0"
-}
diff --git a/elm.json b/elm.json
index e69de29..65d31f3 100644
--- a/elm.json
+++ b/elm.json
@@ -0,0 +1,23 @@
+{
+    "type": "application",
+    "source-directories": [
+        "."
+    ],
+    "elm-version": "0.19.0",
+    "dependencies": {
+        "direct": {
+            "elm/core": "1.0.0",
+            "elm/html": "1.0.0",
+            "elm/random": "1.0.0",
+            "elm/time": "1.0.0"
+        },
+        "indirect": {
+            "elm/json": "1.0.0",
+            "elm/virtual-dom": "1.0.0"
+        }
+    },
+    "test-dependencies": {
+        "direct": {},
+        "indirect": {}
+    }
+}
\ No newline at end of file
```


## Development info for contributors to elm-upgrade

See [CONTRIBUTING.md](CONTRIBUTING.md).
