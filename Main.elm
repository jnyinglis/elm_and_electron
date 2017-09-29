module Main exposing (..)

import Html exposing (Html)
import Html.Events
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Http exposing (..)


main : Program (Maybe (List User)) Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


init : Maybe (List User) -> ( Model, Cmd Msg )
init maybeUserList =
    let
        initmodel =
            { model | users = maybeUserList }
    in
        initmodel ! []



-- MODEL


type alias UserId =
    Int


type alias UserName =
    String


type alias FirstName =
    String


type alias LastName =
    String


type alias User =
    { id : UserId
    , userName : UserName
    , firstName : FirstName
    , lastName : LastName
    , origin : String
    }


type alias Model =
    { userInput : String
    , acceptedInput : Maybe String
    , keyPressCount : Int
    , users : Maybe (List User)
    , alertMessage : Maybe String
    }


type alias UsersAsJSON =
    String


usersAsJSON : UsersAsJSON
usersAsJSON =
    """
   [
     {
      "id": 1,
      "username": "john i",
      "firstname": "john",
      "lastname": "inglis"
     },
     {
      "id": 2,
      "username": "user 2",
      "firstname": "user",
      "lastname": "2"
     },
     {
      "id": 3,
      "username": "user 3",
      "firstname": "user",
      "lastname": "3"
     },
     {
      "id": 4,
      "username": "user 4",
      "firstname": "user",
      "lastname": "4"
     },
     {
      "id": 5,
      "username": "user 5",
      "firstname": "user",
      "lastname": "5"
     },
     {
      "id": 6,
      "username": "user 6",
      "firstname": "user",
      "lastname": "6"
     },
     {
      "id": 7,
      "username": "user 7",
      "firstname": "user",
      "lastname": "7"
     }
   ]
 """


model : Model
model =
    { userInput = ""
    , acceptedInput = Maybe.Nothing
    , keyPressCount = 0
    , users = Maybe.Nothing
    , alertMessage = Maybe.Nothing
    }



-- UPDATE


type Msg
    = InputString String
    | AcceptInput
    | GetUsersFromString
    | WantUsersFromHTTP
    | ReceivedUsersFromHTTP (Result Error (List User))
    | CloseAlert


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputString userInput ->
            ( { model | userInput = userInput, keyPressCount = model.keyPressCount + 1 }, Cmd.none )

        AcceptInput ->
            ( { model | acceptedInput = Just model.userInput }, Cmd.none )

        GetUsersFromString ->
            let
                fromWhere =
                    "usersAsJSON from Main.elm"

                usersResult =
                    decodeString (usersDecoder fromWhere) usersAsJSON

                usersSucceeded =
                    Result.toMaybe usersResult

                usersFailed =
                    case usersResult of
                        Result.Ok a ->
                            Maybe.Nothing

                        Result.Err a ->
                            Maybe.Just ("JSON Error : " ++ a)
            in
                ( { model | users = usersSucceeded, alertMessage = usersFailed }, Cmd.none )

        WantUsersFromHTTP ->
            ( model, requestUsersFromHTTP )

        ReceivedUsersFromHTTP (Ok users) ->
            ( { model | users = Just users }, Cmd.none )

        ReceivedUsersFromHTTP (Err error) ->
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


requestUsersFromHTTP : Cmd Msg
requestUsersFromHTTP =
    let
        url =
            "http://localhost:3000/users"

        fromWhere =
            "from HTTP"

        request =
            Http.get url (usersDecoder fromWhere)
    in
        Http.send ReceivedUsersFromHTTP request


usersDecoder : String -> Decoder (List User)
usersDecoder fromWhere =
    list (userDecoder fromWhere)


userDecoder : String -> Decoder User
userDecoder fromWhere =
    decode User
        |> required "id" int
        |> required "username" string
        |> required "firstname" string
        |> required "lastname" string
        |> hardcoded fromWhere


decodeUsers : String -> Result String (List User)
decodeUsers fromWhere =
    decodeString (list (userDecoder fromWhere)) usersAsJSON



-- VIEW


view : Model -> Html Msg
view model =
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
