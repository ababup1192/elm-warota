module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Attribute, Html, a, div, h1, img, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)



---- MODEL ----


type alias Model =
    { phrase : String
    , face : Int
    , color : Int
    , eye : Int
    , mouth : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { phrase = "", face = 1, color = 1, eye = 1, mouth = 1 }, Cmd.none )



---- UPDATE ----


type Msg
    = Phrase String
    | ChangeFace
    | ChangeColor
    | ChangeEye
    | ChangeMouth


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Phrase input ->
            ( { model | phrase = input }, Cmd.none )

        ChangeFace ->
            ( { model | face = model.face + 1 }, Cmd.none )

        ChangeColor ->
            ( { model | color = model.color + 1 }, Cmd.none )

        ChangeEye ->
            ( { model | eye = model.eye + 1 }, Cmd.none )

        ChangeMouth ->
            ( { model | mouth = model.mouth + 1 }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ div [ class "header" ]
            [ h1 []
                [ text "ワロタジェネレーター" ]
            , div [ class "change-button" ]
                [ a
                    [ onClick ChangeFace ]
                    [ img [ class "change", src "../public/warota-face.JPEG" ] [] ]
                , a
                    [ onClick ChangeColor ]
                    [ img [ class "change", src "../public/color-button.JPEG" ] [] ]
                , a
                    [ onClick ChangeEye ]
                    [ img [ class "change", src "../public/eye-button.JPEG" ] [] ]
                , a
                    [ onClick ChangeMouth ]
                    [ img [ class "change", src "../public/mouth-button.JPEG" ] [] ]
                ]
            , div
                [ class "warota-component" ]
                [ input [ placeholder "phrase", value model.phrase, onInput Phrase ] []
                ]
            ]
        , div [ class "generate" ]
            [ viewFaceImg model
            , viewEyeImg model
            , viewMouthImg model
            , h1 [] [ validatePhrase model ]
            ]
        ]


validatePhrase : Model -> Html Msg
validatePhrase model =
    if model.phrase == "ワロタ" || model.phrase == "わろた" then
        text "著作権的なアレでダメです"

    else
        text model.phrase


viewFaceImg : Model -> Html Msg
viewFaceImg model =
    if modBy 2 model.face == 0 then
        img [ src <| "../public/warota" ++ String.fromInt (modBy 2 model.color) ++ ".PNG" ] []

    else
        img [ src <| "../public/a-ne" ++ String.fromInt (modBy 2 model.color) ++ ".PNG" ] []


viewEyeImg : Model -> Html Msg
viewEyeImg model =
    img [ class <| "eye" ++ String.fromInt (modBy 5 model.eye), src "../public/eye.PNG" ] []


viewMouthImg : Model -> Html Msg
viewMouthImg model =
    img [ class "mouth", src <| "../public/mouth" ++ String.fromInt (modBy 3 model.mouth) ++ ".PNG" ] []



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
