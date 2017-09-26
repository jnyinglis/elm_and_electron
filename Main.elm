module Main exposing (..)

import Html exposing (Html)
import Html.Events


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { userInput : String
    , acceptedInput : String
    , keyPressCount : Int
    }


model : Model
model =
    { userInput = ""
    , acceptedInput = ""
    , keyPressCount = 0
    }



-- UPDATE


type Msg
    = InputString String
    | AcceptInput


update : Msg -> Model -> Model
update msg model =
    case msg of
        InputString userInput ->
            { model | userInput = userInput, keyPressCount = model.keyPressCount + 1 }

        AcceptInput ->
            { model | acceptedInput = model.userInput }



-- VIEW


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.div []
            [ Html.text "Enter something here"
            , Html.input [ Html.Events.onInput InputString ] []
            ]
        , Html.div []
            [ Html.button [ Html.Events.onClick AcceptInput ] [ Html.text "Press this to accept the input" ] ]
        , Html.div []
            [ Html.text ("Number of key presses : " ++ toString model.keyPressCount) ]
        , Html.div []
            [ Html.text model.acceptedInput ]
        ]
