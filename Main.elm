module Main exposing (..)

import Html.App
import WordThing

main : Program Never 
main = 
  Html.App.beginnerProgram
  { model = WordThing.initialModel
  , view = WordThing.view
  , update = WordThing.update
  }
