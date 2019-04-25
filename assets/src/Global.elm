module Global exposing (globalStyle)

import Css exposing (..)
import Css.Global exposing (Snippet, body, global, typeSelector)
import Html
import Html.Styled exposing (..)


type Msg
    = None



-- globalbStyle : List Snippet -> Html.Html Msg


globalStyle =
    global
        [ typeSelector "*"
            [ boxSizing borderBox ]
        ]
