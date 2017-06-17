module Models exposing (..)


type alias FrameStream =
  { id : Int
  , name : String
  , photos : (List FramePhoto)
  }

type alias FramePhoto =
  { id : Int
  }


type alias GetFrameResponse =
  { streams : (List FrameStream)
  }
