Upgrading a package from Elm 0.18 to Elm 0.19

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin_elmformat:$TESTDIR/bin"
  $ rsync -a "$TESTDIR/example_elm18_application/" ./
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
  INFO: Upgrading *.elm files in src/
  
  
  SUCCESS! Your project's dependencies and code have been upgraded.
  However, your project may not yet compile due to API changes in your
  dependencies.
  
  See <TODO: upgrade docs link>
  and the documentation for your dependencies for more information.
  

The transformed project should look like:

  $ git add -N .
  $ git diff
  diff --git a/elm.json b/elm.json
  index e69de29..[0-9a-f]* 100644 (re)
  --- a/elm.json
  +++ b/elm.json
  @@ -0,0 +1,19 @@
  +{
  +    "type": "application",
  +    "source-directories": [
  +        "src"
  +    ],
  +    "elm-version": "0.19.0",
  +    "dependencies": {
  +        "NoRedInk/json-decode-pipeline": "2.0.0",
  +        "elm-lang/core": "6.0.0",
  +        "elm-lang/html": "3.0.0"
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
  diff --git a/src/Main.elm b/src/Main.elm
  index d10b24b..f275804 100644
  --- a/src/Main.elm
  +++ b/src/Main.elm
  @@ -20,13 +20,18 @@ update : Msg -> Model -> ( Model, Cmd Msg )
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
