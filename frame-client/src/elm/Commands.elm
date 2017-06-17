module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Models exposing (FrameStream, FramePhoto)
import RemoteData

import Msgs exposing (Msg)
import Models exposing (GetFrameResponse, FrameStream)

getFrameStreams : String -> Cmd Msg
getFrameStreams topic =
  Http.get fetchFrameUrl frameResponseDecoder
      |> RemoteData.sendRequest
      |> Cmd.map Msgs.OnFetchFrame


fetchFrameUrl : String
fetchFrameUrl =
  let
    frameId = "4974396762488832"
    accessKey = "m7lzHcgdB9BVZyKg4PuDFkStP8QVfvzSDIfZpEfb"
    url =
      "/public/api/frames/" ++ frameId ++ "?access_key=" ++ accessKey
  in
    url


frameResponseDecoder : Decode.Decoder GetFrameResponse
frameResponseDecoder =
    decode GetFrameResponse
      |> required "streams" frameStreamsDecoder

frameStreamsDecoder : Decode.Decoder (List FrameStream)
frameStreamsDecoder =
    Decode.list sreamDecoder


sreamDecoder : Decode.Decoder FrameStream
sreamDecoder =
  decode FrameStream
      |> required "id" Decode.int
      |> required "name" Decode.string
      |> required "photos" photosDecoder


photosDecoder : Decode.Decoder (List FramePhoto)
photosDecoder =
  Decode.list photoDecoder


photoDecoder : Decode.Decoder FramePhoto
photoDecoder =
  decode FramePhoto
    |> required "id" Decode.int
