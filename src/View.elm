module View exposing (root)

import Types exposing (..)
import Html exposing (Html)
import Html.Events


root : Model -> Html Msg
root model =
    Html.div []
        [ Html.div []
            [ Html.text "Enter something here"
            , Html.input [ Html.Events.onInput InputString ] []
            ]
        , viewAlertMessage model.alertMessage
        , Html.div []
            [ Html.button [ Html.Events.onClick AcceptInput ] [ Html.text "Press this to accept the input" ] ]
        , Html.div []
            [ Html.text ("Number of key presses : " ++ toString model.keyPressCount) ]
        , Html.div []
            [ Html.text ("Input accepted : " ++ Maybe.withDefault "Nothing Accepted Yet" model.acceptedInput) ]
        , Html.div []
            [ Html.button [ Html.Events.onClick GetUsersFromString ] [ Html.text "Get users from String in Elm" ] ]
        , Html.div []
            [ Html.button [ Html.Events.onClick WantUsersFromHTTP ] [ Html.text "Get users from HTTP" ] ]
        , viewUsers model.users
        ]


viewUsers : Maybe (List User) -> Html msg
viewUsers maybeUsers =
    case maybeUsers of
        Just users ->
            Html.div []
                [ Html.table [] (List.map viewUser users) ]

        Maybe.Nothing ->
            Html.div [] []


viewUser : User -> Html msg
viewUser user =
    Html.tr []
        [ Html.th [] [ Html.text (toString user.id) ]
        , Html.td [] [ Html.text user.userName ]
        , Html.td [] [ Html.text user.firstName ]
        , Html.td [] [ Html.text user.lastName ]
        , Html.td [] [ Html.text user.origin ]
        ]


viewAlertMessage : Maybe String -> Html Msg
viewAlertMessage maybeAlertMessage =
    case maybeAlertMessage of
        Just alertMessage ->
            Html.div []
                [ Html.span [ Html.Events.onClick CloseAlert ] [ Html.text "X - " ]
                , Html.text alertMessage
                ]

        Maybe.Nothing ->
            Html.div [] []
