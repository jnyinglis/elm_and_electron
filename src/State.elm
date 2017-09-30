module State exposing (init, update, subscriptions)

import Types exposing (..)
import Rest exposing (..)
import Http exposing (..)


init : Maybe (List User) -> ( Model, Cmd Msg )
init maybeUserList =
    let
        initmodel =
            { model | users = maybeUserList }
    in
        initmodel ! []


subscriptions =
    \_ -> Sub.none


model : Model
model =
    { userInput = ""
    , acceptedInput = Maybe.Nothing
    , keyPressCount = 0
    , users = Maybe.Nothing
    , alertMessage = Maybe.Nothing
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputString userInput ->
            ( { model | userInput = userInput, keyPressCount = model.keyPressCount + 1 }, Cmd.none )

        AcceptInput ->
            ( { model | acceptedInput = Just model.userInput }, Cmd.none )

        GetUsersFromString ->
            case getUsersFromString of
                Result.Ok users ->
                    ( { model | users = Just users, alertMessage = Maybe.Nothing }, Cmd.none )

                Result.Err error ->
                    ( { model | users = Maybe.Nothing, alertMessage = Just ("JSON Error : " ++ error) }, Cmd.none )

        WantUsersFromHTTP ->
            ( model, requestUsersFromHTTP )

        ReceivedUsersFromHTTP (Result.Ok users) ->
            ( { model | users = Just users }, Cmd.none )

        ReceivedUsersFromHTTP (Result.Err error) ->
            let
                errorMessage =
                    case error of
                        Http.NetworkError ->
                            "Is the server running?"

                        Http.BadStatus response ->
                            (toString response.status)

                        Http.BadPayload message _ ->
                            "Decoding Failed: " ++ message

                        _ ->
                            "HTTP Error : " ++ (toString error)
            in
                ( { model | users = Maybe.Nothing, alertMessage = Just errorMessage }, Cmd.none )

        CloseAlert ->
            ( { model | alertMessage = Maybe.Nothing }, Cmd.none )
