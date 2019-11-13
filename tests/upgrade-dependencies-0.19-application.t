Upgrading an Elm 0.19 application

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin_elmformat:$TESTDIR/bin"
  $ rsync -a "$TESTDIR/example_elm19_application/" ./
  $ git init -q && git add . && git commit -q -m "."
  $ yes | elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.1
  INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  INFO: Found elm-format 0\.8\.[0-9]+ (re)
  
  ***
  *** ./elm.json already exists.
  *** It looks like this project has already been upgraded to Elm 0.19.
  *** Would you like me to upgrade your project's dependencies?
  ***
  
  [Y/n]: 
  INFO: Updating elm-version to 0.19.1
  INFO: Installing latest version of elm-explorations/webgl
  Here is my plan:
    
    Add:
      elm-explorations/webgl    1\.[1-9]+\.[0-9]+ (re)
  
  Would you like me to update your elm.json accordingly? [Y/n]: Success!
  
  
  SUCCESS! Your project's dependencies have been upgraded.
  However, your project may not yet compile due to API changes in your
  dependencies.
  


The transformed project should look like:

  $ git add -N .
  $ git status --short
   A elm-upgrade-[-0-9.TZ]*\.log (re)
   M elm.json
  $ git diff
  diff --git a/elm-upgrade-[-0-9.TZ]*\.log b/elm-upgrade-[-0-9.TZ]*\.log (re)
  new file mode 100644
  index 0000000..[0-9a-f]* (re)
  --- /dev/null
  \+\+\+ b/elm-upgrade-[-0-9.TZ]*\.log (re)
  @@ -0,0 +1,20 @@
  \+INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  +INFO: Found elm 0.19.1
  \+INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  \+INFO: Found elm-format 0\.8\.[0-9]+ (re)
  +
  +***
  +*** ./elm.json already exists.
  +*** It looks like this project has already been upgraded to Elm 0.19.
  +*** Would you like me to upgrade your project's dependencies?
  +***
  +
  +
  +INFO: Updating elm-version to 0.19.1
  +INFO: Installing latest version of elm-explorations/webgl
  +
  +
  +SUCCESS! Your project's dependencies have been upgraded.
  +However, your project may not yet compile due to API changes in your
  +dependencies.
  +
  diff --git a/elm.json b/elm.json
  index 326e41e\.\.[0-9a-f]* 100644 (re)
  --- a/elm.json
  +++ b/elm.json
  @@ -3,7 +3,7 @@
       "source-directories": [
           "src"
       ],
  -    "elm-version": "0.19.0",
  +    "elm-version": "0.19.1",
       "dependencies": {
           "direct": {
               "NoRedInk/elm-json-decode-pipeline": "1.0.0",
  @@ -11,7 +11,7 @@
               "elm/html": "1.0.0",
               "elm/json": "1\.[0-9]+\.[0-9]+", (re)
               "elm/random": "1.0.0",
  -            "elm-explorations/webgl": "1.0.0"
  \+            "elm-explorations/webgl": "1\.[1-9][0-9]*\.[0-9]+" (re)
           },
           "indirect": {
               "elm/time": "1.0.0",
  @@ -22,4 +22,4 @@
           "direct": {},
           "indirect": {}
       }
  -}
  \ No newline at end of file
  +}
