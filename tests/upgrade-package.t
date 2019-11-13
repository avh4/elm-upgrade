Upgrading a package from Elm 0.18 to Elm 0.19

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin_elmformat:$TESTDIR/bin"
  $ rsync -a "$TESTDIR/example_elm18_package/" ./
  $ git init -q && git add . && git commit -q -m "."
  $ elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.1
  INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  INFO: Found elm-format 0\.8\.[0-9]+ (re)
  INFO: Cleaning ./elm-stuff before upgrading
  INFO: Converting elm-package.json -> elm.json
  INFO: Detected a package project (this project has exposed modules)
  INFO: Switching from elm-lang/core (deprecated) to elm/core
  INFO: Installing latest version of elm/core
  It is already installed!
  INFO: Upgrading *.elm files in src/
  
  
  SUCCESS! Your project's dependencies and code have been upgraded.
  However, your project may not yet compile due to API changes in your
  dependencies.
  
  See <https://github.com/elm/compiler/blob/master/upgrade-docs/0.19.md>
  and the documentation for your dependencies for more information.
  
  Here are some common upgrade steps that you will need to do manually:
  
  - elm/core
    - [ ] Replace uses of toString with String.fromInt, String.fromFloat, or Debug.toString as appropriate
  

The transformed project should look like:

  $ git add -N .
  $ git status --short elm-package.json
  D  elm-package.json
  $ git diff
  diff --git a/elm-upgrade-[-0-9.TZ]*\.log b/elm-upgrade-[-0-9.TZ]*\.log (re)
  new file mode 100644
  index 0000000..[0-9a-f]* (re)
  --- /dev/null
  \+\+\+ b/elm-upgrade-[-0-9.TZ]*\.log (re)
  @@ -0,0 +1,24 @@
  \+INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  +INFO: Found elm 0.19.1
  \+INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  \+INFO: Found elm-format 0\.8\.[0-9]+ (re)
  +INFO: Cleaning ./elm-stuff before upgrading
  +INFO: Converting elm-package.json -> elm.json
  +INFO: Detected a package project (this project has exposed modules)
  +INFO: Switching from elm-lang/core (deprecated) to elm/core
  +INFO: Installing latest version of elm/core
  +INFO: Upgrading *.elm files in src/
  +
  +
  +SUCCESS! Your project's dependencies and code have been upgraded.
  +However, your project may not yet compile due to API changes in your
  +dependencies.
  +
  +See <https://github.com/elm/compiler/blob/master/upgrade-docs/0.19.md>
  +and the documentation for your dependencies for more information.
  +
  +Here are some common upgrade steps that you will need to do manually:
  +
  +- elm/core
  +  - [ ] Replace uses of toString with String.fromInt, String.fromFloat, or Debug.toString as appropriate
  +
  diff --git a/elm.json b/elm.json
  new file mode 100644
  index 0000000..[0-9a-f]* (re)
  --- /dev/null
  +++ b/elm.json
  @@ -0,0 +1,15 @@
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
  +        "elm/core": "1.0.0 <= v < 2.0.0"
  +    },
  +    "test-dependencies": {}
  +}
  \ No newline at end of file

Running `elm-upgrade` again:

  $ git add .
  $ yes | elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.1
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
  
  $ git add -N .
  $ git status --short
  A  elm-upgrade-[-0-9.TZ]*\.log (re)
   A elm-upgrade-[-0-9.TZ]*\.log (re)
  R  elm-package.json -> elm.json
  $ git diff
  diff --git a/elm-upgrade-[-0-9.TZ]*\.log b/elm-upgrade-[-0-9.TZ]*\.log (re)
  new file mode 100644
  index 0000000..[0-9a-f]* (re)
  --- /dev/null
  \+\+\+ b/elm-upgrade-[-0-9.TZ]*\.log (re)
  @@ -0,0 +1,18 @@
  \+INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  +INFO: Found elm 0.19.1
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
