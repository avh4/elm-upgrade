When a dependency has not yet been upgraded:

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin_elmformat:$TESTDIR/bin"
  $ rsync -a "$TESTDIR/example_elm18_package/" ./
  $ jq '.dependencies += { "avh4/fake-package": "1.0.1 <= v < 2.0.0" }' elm-package.json > tmp && mv tmp elm-package.json
  $ git init -q && git add . && git commit -q -m "."
  $ elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.0
  INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  INFO: Found elm-format 0.8.0
  INFO: Cleaning ./elm-stuff before upgrading
  INFO: Converting elm-package.json -> elm.json
  INFO: Detected a package project (this project has exposed modules)
  INFO: Switching from elm-lang/core (deprecated) to elm/core
  INFO: Installing latest version of elm/core
  It is already installed!
  WARNING: avh4/fake-package has not been upgraded to 0.19 yet!
  INFO: Upgrading *.elm files in src/
  
  
  SUCCESS! Your project's dependencies and code have been upgraded.
  However, your project may not yet compile due to API changes in your
  dependencies.
  
  See <https://github.com/elm/compiler/blob/master/upgrade-docs/0.19.md>
  and the documentation for your dependencies for more information.
  
  WARNING! 1 of your dependencies have not yet been upgraded to
  support Elm 0.19.
    - https://github.com/avh4/fake-package
  
  $ git add -N .
  $ git diff elm.json
  diff --git a/elm.json b/elm.json
  index e69de29..[0-9a-f]* 100644 (re)
  --- a/elm.json
  +++ b/elm.json
  @@ -0,0 +1,16 @@
  +{
  +    "type": "package",
  +    "name": "avh4/project",
  +    "summary": "helpful summary of your project, less than 80 characters",
  +    "license": "MIT",
  +    "version": "1.0.0",
  +    "exposed-modules": [
  +        "CoolData"
  +    ],
  +    "elm-version": "0.19.0 <= v < 0.20.0",
  +    "dependencies": {
  +        "elm/core": "1.0.0 <= v < 2.0.0",
  +        "avh4/fake-package": "1.0.1 <= v < 2.0.0"
  +    },
  +    "test-dependencies": {}
  +}
  \ No newline at end of file


Running `elm-upgrade` again:

  $ git add .
  $ yes | elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.0
  INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  INFO: Found elm-format 0.8.0
  
  ***
  *** ./elm.json already exists.
  *** It looks like this project has already been upgraded to Elm 0.19.
  *** Since this is a package project, you should keep the version bounds
  *** for your dependencies as wide as possible.
  ***
  
  
  INFO: Checking if all your dependencies support Elm 0.19...
  WARNING: avh4/fake-package has not been upgraded to 0.19 yet!
  $ git add -N .
  $ git status --short
  D  elm-package.json
  A  elm-upgrade-[-0-9:.TZ]*\.log (re)
   A elm-upgrade-[-0-9:.TZ]*\.log (re)
  A  elm.json
  M  src/CoolData.elm
  $ git diff
  diff --git a/elm-upgrade-[-0-9:.TZ]*\.log b/elm-upgrade-[-0-9:.TZ]*\.log (re)
  index e69de29..[0-9a-f]* 100644 (re)
  --- a/elm-upgrade-[-0-9:.TZ]*\.log (re)
  \+\+\+ b/elm-upgrade-[-0-9:.TZ]*\.log (re)
  @@ -0,0 +1,15 @@
  \+INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  +INFO: Found elm 0.19.0
  \+INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  +INFO: Found elm-format 0.8.0
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
  +WARNING: avh4/fake-package has not been upgraded to 0.19 yet!
