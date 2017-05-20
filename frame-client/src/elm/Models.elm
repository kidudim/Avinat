module Models exposing (..)


type alias FrameStream =
  { id : Int
  , name : String
  }

type alias FramePhoto =
  { id : String
  }


type alias GetFrameResponse =
  { streams : (List FrameStream)
  }
