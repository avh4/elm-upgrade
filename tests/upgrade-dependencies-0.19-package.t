Upgrading an Elm 0.19 package

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin_elmformat:$TESTDIR/bin"
  $ rsync -a "$TESTDIR/example_elm19_package/" ./
  $ git init -q && git add . && git commit -q -m "."
  $ yes | elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.0
  INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  INFO: Found elm-format 0\.8\.[0-9]+ (re)
  
  ***
  *** ./elm.json already exists.
  *** It looks like this project has already been upgraded to Elm 0.19.
  *** Since this is a package project, you should keep the version bounds
  *** for your dependencies as wide as possible.
  ***
  
  
  INFO: Checking if all your dependencies support Elm 0.19...
  
  
  SUCCESS! Your project's dependencies look good.
  


The transformed project should look like:

  $ git add -N .
  $ git status --short
   A elm-upgrade-[-0-9.TZ]*\.log (re)
  $ git diff
  diff --git a/elm-upgrade-[-0-9.TZ]*\.log b/elm-upgrade-[-0-9.TZ]*\.log (re)
  new file mode 100644
  index 0000000..[0-9a-f]* (re)
  --- /dev/null
  \+\+\+ b/elm-upgrade-[-0-9.TZ]*\.log (re)
  @@ -0,0 +1,18 @@
  \+INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  +INFO: Found elm 0.19.0
  \+INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  \+INFO: Found elm-format 0\.8\.[0-9]+ (re)
  +
  +***
  +*** ./elm.json already exists.
  +*** It looks like this project has already been upgraded to Elm 0.19.
  +*** Since this is a package project, you should keep the version bounds
  +*** for your dependencies as wide as possible.
  +***
  +
  +
  +INFO: Checking if all your dependencies support Elm 0.19...
  +
  +
  +SUCCESS! Your project's dependencies look good.
  +
