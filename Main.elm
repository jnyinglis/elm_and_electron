module Main exposing (..)

import Html exposing (Html)


main : Html msg
main =
    Html.div []
        [ Html.div []
            [ Html.text "Enter something here"
            , Html.input [] []
            ]
        , Html.div []
            [ Html.button [] [ Html.text "Press this to accept the input" ] ]
        ]
