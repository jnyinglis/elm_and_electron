module Types exposing (..)

import Http exposing (..)


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


type Msg
    = InputString String
    | AcceptInput
    | GetUsersFromString
    | WantUsersFromHTTP
    | ReceivedUsersFromHTTP (Result Error (List User))
    | CloseAlert
