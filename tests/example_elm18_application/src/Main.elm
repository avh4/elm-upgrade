module Main exposing (main)

import Html exposing (Html)


type alias Model =
    {}


init : Model
init =
    {}


type Msg
    = Click


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Click ->
            model ! []


main : Program Never Model Msg
main =
    Html.program
        { init = init ! []
        , update = update
        , subscriptions = \_ -> Sub.none
        , view =
            \_ ->
                Html.text "Hi"
        }
