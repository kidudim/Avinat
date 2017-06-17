-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/effects/http.html
module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import RemoteData exposing (WebData)

import Msgs exposing (..)
import Commands exposing (getFrameStreams)
import Models exposing (FrameStream, FramePhoto, GetFrameResponse)

main : Program Never Model Msg
main =
  Html.program
    { init = init "cats"
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL

type alias Model =
  { topic : String
  , gifUrl : String
  , streams : WebData GetFrameResponse
  }


init : String -> (Model, Cmd Msg)
init topic =
  ( Model topic "waiting.gif" RemoteData.NotAsked
  , getFrameStreams topic
  )



-- UPDATE


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MorePlease ->
      (model, getFrameStreams model.topic)

    -- NewGif (Ok newUrl) ->
    --   (Model model.topic newUrl, Cmd.none)
    --
    -- NewGif (Err _) ->
    --   (model, Cmd.none)

    OnFetchFrame response ->
      let
        _ = Debug.log "testing 123"
      in
        ( { model | streams = response } , Cmd.none)


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h2 [] [text model.topic]
    , button [ onClick MorePlease ] [ text "More Please!" ]
    , br [] []
    , img [src model.gifUrl] []
    , maybeResponse model.streams
    ]


maybeResponse : WebData GetFrameResponse -> Html Msg
maybeResponse response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success players ->
            --list players
            text (toString response)

        RemoteData.Failure error ->
            text (toString error)

-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
