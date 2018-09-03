Upgrading an application from Elm 0.18 to Elm 0.19

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin_elmformat:$TESTDIR/bin"
  $ rsync -a "$TESTDIR/example_elm18_application/" ./
  $ git init -q && git add . && git commit -q -m "."
  $ yes | elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.0
  INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  INFO: Found elm-format 0.8.0
  INFO: Cleaning ./elm-stuff before upgrading
  INFO: Converting elm-package.json -> elm.json
  INFO: Detected an application project (this project has no exposed modules)
  INFO: Switching from NoRedInk/elm-decode-pipeline (deprecated) to NoRedInk/elm-json-decode-pipeline
  INFO: Installing latest version of NoRedInk/elm-json-decode-pipeline
  Here is my plan:
    
    Add:
      NoRedInk/elm-json-decode-pipeline    1.0.0
  
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
  I found it in your elm.json file, but in the "indirect" dependencies.
  Should I move it into "direct" dependencies for more general use? [Y/n]: Dependencies loaded from local cache.
  Verifying dependencies...\r (no-eol) (esc)
  Building dependencies (1/3)\r (no-eol) (esc)
  Building dependencies (2/3)\r (no-eol) (esc)
  Building dependencies (3/3)\r (no-eol) (esc)
  Dependencies ready!                
  INFO: Detected use of elm-lang/core#Random; installing elm/random
  Here is my plan:
    
    Add:
      elm/random    1.0.0
      elm/time      1.0.0
  
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
      elm/html           1.0.0
      elm/virtual-dom    1.0.0
  
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
  INFO: Upgrading *.elm files in src/
  
  
  SUCCESS! Your project's dependencies and code have been upgraded.
  However, your project may not yet compile due to API changes in your
  dependencies.
  
  See <https://github.com/elm/compiler/blob/master/upgrade-docs/0.19.md>
  and the documentation for your dependencies for more information.
  

The transformed project should look like:

  $ git add -N .
  $ git status --short
  D  elm-package.json
   A elm-upgrade-[-0-9:.TZ]*\.log (re)
   A elm.json
   M src/Main.elm
  $ git diff
  diff --git a/elm-upgrade-[-0-9:.TZ]*\.log b/elm-upgrade-[-0-9:.TZ]*\.log (re)
  index e69de29..[0-9a-f]* 100644 (re)
  --- a/elm-upgrade-[-0-9:.TZ]*\.log (re)
  \+\+\+ b/elm-upgrade-[-0-9:.TZ]*\.log (re)
  @@ -0,0 +1,25 @@
  \+INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  +INFO: Found elm 0.19.0
  \+INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  +INFO: Found elm-format 0.8.0
  +INFO: Cleaning ./elm-stuff before upgrading
  +INFO: Converting elm-package.json -> elm.json
  +INFO: Detected an application project (this project has no exposed modules)
  +INFO: Switching from NoRedInk/elm-decode-pipeline (deprecated) to NoRedInk/elm-json-decode-pipeline
  +INFO: Installing latest version of NoRedInk/elm-json-decode-pipeline
  +INFO: Switching from elm-lang/core (deprecated) to elm/core
  +INFO: Installing latest version of elm/core
  +INFO: Detected use of elm-lang/core#Json.Decode; installing elm/json
  +INFO: Detected use of elm-lang/core#Random; installing elm/random
  +INFO: Switching from elm-lang/html (deprecated) to elm/html
  +INFO: Installing latest version of elm/html
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
  diff --git a/elm.json b/elm.json
  index e69de29..[0-9a-f]* 100644 (re)
  --- a/elm.json
  +++ b/elm.json
  @@ -0,0 +1,24 @@
  +{
  +    "type": "application",
  +    "source-directories": [
  +        "src"
  +    ],
  +    "elm-version": "0.19.0",
  +    "dependencies": {
  +        "direct": {
  +            "NoRedInk/elm-json-decode-pipeline": "1.0.0",
  +            "elm/core": "1.0.0",
  +            "elm/html": "1.0.0",
  +            "elm/json": "1.0.0",
  +            "elm/random": "1.0.0"
  +        },
  +        "indirect": {
  +            "elm/time": "1.0.0",
  +            "elm/virtual-dom": "1.0.0"
  +        }
  +    },
  +    "test-dependencies": {
  +        "direct": {},
  +        "indirect": {}
  +    }
  +}
  \ No newline at end of file
  diff --git a/src/Main.elm b/src/Main.elm
  index 570439c..3a12d7e 100644
  --- a/src/Main.elm
  +++ b/src/Main.elm
  @@ -33,18 +33,23 @@ update : Msg -> Model -> ( Model, Cmd Msg )
   update msg model =
       case msg of
           Click ->
  -            model ! []
  +            ( model
  +            , Cmd.none
  +            )
   
   
   main : Program Never Model Msg
   main =
       Html.program
  -        { init = init ! []
  +        { init =
  +            ( init
  +            , Cmd.none
  +            )
           , update = update
           , subscriptions = \_ -> Sub.none
           , view =
               \_ ->
                   Html.div
  -                    [ style [ ("color", "red") ] ]
  +                    [ style "color" "red" ]
                       [ Html.text "Hi" ]
           }


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
  *** Would you like me to upgrade your project's dependencies?
  ***
  
  [Y/n]: 
  
  
  SUCCESS! Your project's dependencies have been upgraded.
  However, your project may not yet compile due to API changes in your
  dependencies.
  
  $ git add -N .
  $ git status --short
  D  elm-package.json
  A  elm-upgrade-[-0-9:.TZ]*\.log (re)
   A elm-upgrade-[-0-9:.TZ]*\.log (re)
  A  elm.json
  M  src/Main.elm
  $ git diff
  diff --git a/elm-upgrade-[-0-9:.TZ]*\.log b/elm-upgrade-[-0-9:.TZ]*\.log (re)
  index e69de29..[0-9a-f]* 100644 (re)
  --- a/elm-upgrade-[-0-9:.TZ]*\.log (re)
  \+\+\+ b/elm-upgrade-[-0-9:.TZ]*\.log (re)
  @@ -0,0 +1,18 @@
  \+INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  +INFO: Found elm 0.19.0
  \+INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  +INFO: Found elm-format 0.8.0
  +
  +***
  +*** ./elm.json already exists.
  +*** It looks like this project has already been upgraded to Elm 0.19.
  +*** Would you like me to upgrade your project's dependencies?
  +***
  +
  +
  +
  +
  +SUCCESS! Your project's dependencies have been upgraded.
  +However, your project may not yet compile due to API changes in your
  +dependencies.
  +
