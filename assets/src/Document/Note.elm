module Document.Note exposing (document, Document)


import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Events exposing (onInput)

type alias ID =
    Int

type Msg
    = OnInput ID String

type alias Document =
    { title : String
    , id : ID
    , childrens : List ID
    , parent : Maybe ID
    , content : String
    , ancestors : List ID
    }

container =
    styled div [ displayFlex ]

result =
    styled div [ backgroundColor (rgb 210 180 190) ]

document : ID -> Document -> Html Msg
document id note =
  container []
    [ textarea [ onInput (\s -> OnInput id s) ] []
    , result [] [ text note.content ]
    ]