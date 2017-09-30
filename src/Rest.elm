module Rest exposing (..)

import Types exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Http exposing (..)


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


getUsersFromString =
    let
        fromWhere =
            "usersAsJSON from Main.elm"
    in
        decodeString (usersDecoder fromWhere) usersAsJSON


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
