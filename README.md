## Example usage

```
Ξ workspace/tangram-logo git:(master) ▶ elm-upgrade
Found elm at /usr/local/bin/elm
Found elm-format at /usr/local/bin/elm-format
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


## Development info

```sh
npm install
npm link
```

You should now have `elm-uprgade` on your path.
