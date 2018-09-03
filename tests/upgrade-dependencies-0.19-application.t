Upgrading an application from Elm 0.18 to Elm 0.19

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin_elmformat:$TESTDIR/bin"
  $ rsync -a "$TESTDIR/example_elm19_application/" ./
  $ git init -q && git add . && git commit -q -m "."
  $ yes | elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.0
  INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  INFO: Found elm-format 0.8.0
  
  ***
  *** ./elm.json already exists.
  *** It looks like this project has already been upgraded to Elm 0.19.
  *** Would you like me to upgrade your project's dependencies?
  ***
  
  [Y/n]: 
  INFO: Installing latest version of elm-explorations/webgl
  Here is my plan:
    
    Add:
      elm-explorations/webgl    1.0.1
  
  Would you like me to update your elm.json accordingly? [Y/n]: Dependencies loaded from local cache.
  Verifying dependencies...\r (no-eol) (esc)
  Building dependencies (1/8)\r (no-eol) (esc)
  Building dependencies (2/8)\r (no-eol) (esc)
  Building dependencies (3/8)\r (no-eol) (esc)
  Building dependencies (4/8)\r (no-eol) (esc)
  Building dependencies (5/8)\r (no-eol) (esc)
  Building dependencies (6/8)\r (no-eol) (esc)
  Building dependencies (7/8)\r (no-eol) (esc)
  Building dependencies (8/8)\r (no-eol) (esc)
  Dependencies ready!                
  
  
  SUCCESS! Your project's dependencies have been upgraded.
  However, your project may not yet compile due to API changes in your
  dependencies.
  


The transformed project should look like:

  $ git add -N .
  $ git status --short
   M elm.json
  $ git diff
  diff --git a/elm.json b/elm.json
  index f4961a0..31781d7 100644
  --- a/elm.json
  +++ b/elm.json
  @@ -11,7 +11,7 @@
               "elm/html": "1.0.0",
               "elm/json": "1.0.0",
               "elm/random": "1.0.0",
  -            "elm-explorations/webgl": "1.0.0"
  +            "elm-explorations/webgl": "1.0.1"
           },
           "indirect": {
               "elm/time": "1.0.0",
