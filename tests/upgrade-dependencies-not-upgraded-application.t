When a dependency has not yet been upgraded:

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin_elmformat:$TESTDIR/bin"
  $ rsync -a "$TESTDIR/example_elm18_application/" ./
  $ jq '.dependencies += { "avh4/fake-package": "1.0.1 <= v < 2.0.0" }' elm-package.json > tmp && mv tmp elm-package.json
  $ git init -q && git add . && git commit -q -m "."
  $ elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.0
  INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  INFO: Found elm-format 0.7.0-exp-105-gf2936580
  INFO: Cleaning ./elm-stuff before upgrading
  INFO: Converting elm-package.json -> elm.json
  INFO: Detected an application project (this project has no exposed modules)
  INFO: Installing latest version of elm-lang/core
  INFO: Switching from NoRedInk/elm-decode-pipeline (deprecated) to NoRedInk/json-decode-pipeline
  INFO: Installing latest version of NoRedInk/json-decode-pipeline
  INFO: Installing latest version of elm-lang/html
  WARNING: avh4/fake-package has not been upgraded to 0.19 yet!
  INFO: Upgrading *.elm files in src/
  
  
  SUCCESS! Your project's dependencies and code have been upgraded.
  However, your project may not yet compile due to API changes in your
  dependencies.
  
  See <TODO: upgrade docs link>
  and the documentation for your dependencies for more information.
  
  WARNING! 1 of your dependencies have not yet been upgraded to
  support Elm 0.19. You can create an issue to request the packages be
  upgraded here:
    - https://github.com/avh4/fake-package/issues
  
  $ git add -N .
  $ git diff elm.json
  diff --git a/elm.json b/elm.json
  index e69de29..[0-9a-f]* 100644 (re)
  --- a/elm.json
  +++ b/elm.json
  @@ -0,0 +1,20 @@
  +{
  +    "type": "application",
  +    "source-directories": [
  +        "src"
  +    ],
  +    "elm-version": "0.19.0",
  +    "dependencies": {
  +        "NoRedInk/json-decode-pipeline": "2.0.0",
  +        "elm-lang/core": "6.0.0",
  +        "elm-lang/html": "3.0.0",
  +        "avh4/fake-package": "1.0.1"
  +    },
  +    "test-dependencies": {},
  +    "do-not-edit-this-by-hand": {
  +        "transitive-dependencies": {
  +            "elm-lang/json": "1.0.0",
  +            "elm-lang/virtual-dom": "3.0.0"
  +        }
  +    }
  +}
  \ No newline at end of file
