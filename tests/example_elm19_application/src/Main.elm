module Main exposing (main)

import Html exposing (Html)
import Html.Attributes exposing (style)
import Json.Decode exposing (Decoder)
import Random


type alias Model =
    {}


init : Model
init =
    {}


decode : Decoder Model
decode =
    Json.Decode.succeed {}


generate : Random.Generator Model
generate =
    Random.bool |> Random.map (always init)


type Msg
    = Click


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Click ->
            ( model
            , Cmd.none
            )


main : Program Never Model Msg
main =
    Html.program
        { init =
            ( init
            , Cmd.none
            )
        , update = update
        , subscriptions = \_ -> Sub.none
        , view =
            \_ ->
                Html.div
                    [ style "color" "red" ]
                    [ Html.text "Hi" ]
        }
