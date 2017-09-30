module App exposing (main)

import Html exposing (Html)
import State
import View
import Types


main : Program (Maybe (List Types.User)) Types.Model Types.Msg
main =
    Html.programWithFlags
        { init = State.init
        , view = View.root
        , update = State.update
        , subscriptions = State.subscriptions
        }
