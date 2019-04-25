module Main exposing (main)

import Array exposing (..)
import Browser exposing (element)
import Browser.Dom exposing (..)
import Css exposing (..)
import Css.Transitions exposing (linear, transform3, transition)
import Debug
import Dict exposing (..)
import Document.Note exposing (Document, document)
import Global exposing (globalStyle)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, css, value)
import Html.Styled.Events exposing (onClick, onInput)
import Normalize exposing (normalize)
import Platform.Cmd
import Task exposing (..)


type alias ID =
    Int


type alias ColumnIndex =
    Int


type alias ActiveColumn =
    Maybe ColumnIndex


type alias Document =
    { title : String
    , id : ID
    , childrens : List ID
    , parent : Maybe ID
    , content : String
    , ancestors : List ID
    }


type alias Documents =
    Dict ID Document


type alias Model =
    { documents : Documents
    , activeColumn : ActiveColumn
    , activeDocument : Maybe ID
    , viewport : Maybe Browser.Dom.Viewport
    }


getViewport : Cmd Msg
getViewport =
    Task.perform SaveViewport Browser.Dom.getViewport


initialCmd : Cmd Msg
initialCmd =
    Platform.Cmd.batch [ getViewport ]


initialModel : Model
initialModel =
    { documents =
        Dict.fromList
            [ ( 0
              , { title = "000"
                , id = 0
                , childrens = []
                , parent = Nothing
                , content = "wefwefwfwf"
                , ancestors = []
                }
              )
            , ( 1
              , { title = "111"
                , id = 1
                , childrens = [ 2 ]
                , parent = Just 0
                , content = "initialModel"
                , ancestors = [ 1 ]
                }
              )
            , ( 2
              , { title = "222"
                , id = 2
                , childrens = []
                , parent = Just 1
                , content = "child content"
                , ancestors = [ 0, 1 ]
                }
              )
            , ( 3
              , { title = "333"
                , id = 3
                , childrens = []
                , parent = Nothing
                , content = "child content"
                , ancestors = []
                }
              )
            ]
    , activeColumn = Nothing
    , activeDocument = Nothing
    , viewport = Nothing
    }


processDocuments : Documents -> List (List Document)
processDocuments documents =
    let
        splitToColumns key document acc =
            case Array.get (List.length document.ancestors) acc of
                Just a ->
                    Array.set (List.length document.ancestors) (List.append a [ document ]) acc

                Nothing ->
                    Array.push (document :: []) acc
    in
    documents
        |> Dict.foldl splitToColumns (Array.fromList [])
        |> Array.toList


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, initialCmd )


container : List (Attribute msg) -> List (Html msg) -> Html msg
container =
    styled div
        [ backgroundColor (rgba 255 0 0 1)
        , overflow hidden
        , width (vw 100)
        , position relative
        , height (vh 100)
        ]


slider : List (Attribute msg) -> List (Html msg) -> Html msg
slider =
    styled div
        [ width (px 300)
        , height (vh 100)
        , overflow scroll
        , padding2 (px 30) (px 15)
        , backgroundColor (rgba 255 255 0 1)
        , pseudoElement "-webkit-scrollbar" [ display none ]
        , position absolute
        , transition
            [ transform3 200 0 linear
            ]
        ]


box : List (Attribute msg) -> List (Html msg) -> Html msg
box =
    styled div
        [ backgroundColor (rgba 117 125 138 1)
        , width (pct 100)
        , marginBottom (px 15)
        ]


textpool : List (Attribute msg) -> List (Html msg) -> Html msg
textpool =
    styled textarea
        [ display block
        , width (pct 100)
        ]


getPosition : ActiveColumn -> ColumnIndex -> Attribute Msg
getPosition activeColumn index =
    case activeColumn of
        Nothing ->
            if index == 0 then
                css [ transform (translateX (px 100)) ]

            else
                css [ transform (translateX (px (toFloat (100 + (index * 300))))) ]

        Just activeIndex ->
            if activeIndex == index then
                css [ transform (translateX (px 450)) ]

            else
                css [ transform (translateX (px 0)) ]



-- VIEW


view : Model -> Html Msg
view model =
    container [] (List.indexedMap (renderSlider model.activeColumn) (processDocuments model.documents))


renderSlider : ActiveColumn -> ColumnIndex -> List Document -> Html Msg
renderSlider activeColumn index column =
    slider [ getPosition activeColumn index ] (List.map (renderBox index) column)


renderBox : ColumnIndex -> Document -> Html Msg
renderBox columnINDEX document =
    box [ onClick (FocusDocument columnINDEX document.id) ]
        [ div [] [ text document.content ]
        , textpool [ value document.content, onInput (OnInput document.id) ] []
        ]


updateDocument : String -> Maybe Document -> Maybe Document
updateDocument content document =
    case document of
        Nothing ->
            document

        Just doc ->
            Just { doc | content = content }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FocusDocument columnINDEX documentID ->
            ( { model | activeColumn = Just columnINDEX, activeDocument = Just documentID }, Cmd.none )

        OnInput id content ->
            ( { model | documents = Dict.update id (updateDocument content) model.documents }, Cmd.none )

        SaveViewport viewport ->
            ( { model | viewport = Just viewport }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type Msg
    = FocusDocument ColumnIndex ID
    | OnInput ID String
    | SaveViewport Viewport


applyStyles : Html Msg -> Html Msg
applyStyles page =
    styled div [] [ class "container" ] (normalize :: globalStyle :: page :: [])


enhancePage : Html Msg -> Html.Html Msg
enhancePage page =
    toUnstyled (applyStyles page)


main : Program () Model Msg
main =
    element
        { init = init
        , view = view >> enhancePage
        , update = update
        , subscriptions = subscriptions
        }
