When a dependency has not yet been upgraded:

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin_elmformat:$TESTDIR/bin"
  $ rsync -a "$TESTDIR/example_elm18_application/" ./
  $ jq '.dependencies += { "avh4/fake-package": "1.0.1 <= v < 2.0.0" }' elm-package.json > tmp && mv tmp elm-package.json
  $ git init -q && git add . && git commit -q -m "."
  $ yes | elm-upgrade
  
  **NOT FOR SHARING.** Do not post about the alpha/rc version of elm-upgrade on reddit, twitter, HN, discourse, etc.
  **NOT FOR SHARING.** Learn why here: <https://www.deconstructconf.com/2017/evan-czaplicki-on-storytelling>
  
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.0
  INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  INFO: Found elm-format 0.8.0-alpha-elm019rc1-rc2
  INFO: Cleaning ./elm-stuff before upgrading
  INFO: Converting elm-package.json -> elm.json
  INFO: Detected an application project (this project has no exposed modules)
  INFO: Switching from NoRedInk/elm-decode-pipeline (deprecated) to NoRedInk/json-decode-pipeline
  INFO: Installing latest version of NoRedInk/json-decode-pipeline
  Here is my plan:
    
    Add:
      NoRedInk/json-decode-pipeline    1.0.0
  
  Would you like me to update your elm.json accordingly? [Y/n]: Dependencies loaded from local cache.
  Verifying dependencies...\r (no-eol) (esc)
  Building dependencies (1/3)\r (no-eol) (esc)
  Building dependencies (2/3)\r (no-eol) (esc)
  Building dependencies (3/3)\r (no-eol) (esc)
  Dependencies ready!                
  INFO: Switching from elm-lang/core (deprecated) to elm/core
  INFO: Installing latest version of elm/core
  It is already installed!
  INFO: Detected use of elm-lang/core#Json.Decode; installing elm/json
  I found it in your elm.json file!
  In "transitive-dependencies" though.
  Should I move it into "dependencies" for more general use? [Y/n]: Dependencies loaded from local cache.
  Verifying dependencies...\r (no-eol) (esc)
  Building dependencies (1/3)\r (no-eol) (esc)
  Building dependencies (2/3)\r (no-eol) (esc)
  Building dependencies (3/3)\r (no-eol) (esc)
  Dependencies ready!                
  INFO: Detected use of elm-lang/core#Random; installing elm/random
  Here is my plan:
    
    Add:
      elm/time      1.0.0
      elm/random    1.0.0
  
  Would you like me to update your elm.json accordingly? [Y/n]: Dependencies loaded from local cache.
  Verifying dependencies...\r (no-eol) (esc)
  Building dependencies (1/5)\r (no-eol) (esc)
  Building dependencies (2/5)\r (no-eol) (esc)
  Building dependencies (3/5)\r (no-eol) (esc)
  Building dependencies (4/5)\r (no-eol) (esc)
  Building dependencies (5/5)\r (no-eol) (esc)
  Dependencies ready!                
  INFO: Switching from elm-lang/html (deprecated) to elm/html
  INFO: Installing latest version of elm/html
  Here is my plan:
    
    Add:
      elm/virtual-dom    1.0.0
      elm/html           1.0.0
  
  Would you like me to update your elm.json accordingly? [Y/n]: Dependencies loaded from local cache.
  Verifying dependencies...\r (no-eol) (esc)
  Building dependencies (1/7)\r (no-eol) (esc)
  Building dependencies (2/7)\r (no-eol) (esc)
  Building dependencies (3/7)\r (no-eol) (esc)
  Building dependencies (4/7)\r (no-eol) (esc)
  Building dependencies (5/7)\r (no-eol) (esc)
  Building dependencies (6/7)\r (no-eol) (esc)
  Building dependencies (7/7)\r (no-eol) (esc)
  Dependencies ready!                
  WARNING: avh4/fake-package has not been upgraded to 0.19 yet!
  INFO: Upgrading *.elm files in src/
  
  
  SUCCESS! Your project's dependencies and code have been upgraded.
  However, your project may not yet compile due to API changes in your
  dependencies.
  
  See <https://gist.github.com/evancz/8e89512dfa9f68903f05f1ac4c44861b>
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
  @@ -0,0 +1,22 @@
  +{
  +    "type": "application",
  +    "source-directories": [
  +        "src"
  +    ],
  +    "elm-version": "0.19.0",
  +    "dependencies": {
  +        "NoRedInk/json-decode-pipeline": "1.0.0",
  +        "elm/core": "1.0.0",
  +        "elm/html": "1.0.0",
  +        "elm/json": "1.0.0",
  +        "elm/random": "1.0.0",
  +        "avh4/fake-package": "1.0.1"
  +    },
  +    "test-dependencies": {},
  +    "do-not-edit-this-by-hand": {
  +        "transitive-dependencies": {
  +            "elm/time": "1.0.0",
  +            "elm/virtual-dom": "1.0.0"
  +        }
  +    }
  +}
  \ No newline at end of file
