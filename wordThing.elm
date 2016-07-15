module WordThing exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App
import Html.Events exposing (..)
import String

-- MODEL 

type alias Model = 
    { text : String
      , changesCount : Int
    }

initialModel : Model 
initialModel = 
    { text = ""
    , changesCount = 0}


-- UPDATE 

type Action = 
   TextChanged String 
   | Clear 

update : Action -> Model -> Model
update event model = 
    case event of 
        TextChanged newText ->
            { model 
              | text = newText
              , changesCount =
                  model.changesCount + 1 
             }

        Clear -> 
            { model 
              | text = ""
              , changesCount = 0
            }

-- VIEW 

splitParagraphs : String -> List (Html Action)
splitParagraphs inputString = 
    let 
      paragraghStrings = String.split "\n\n" inputString

      wrapInP string = 
        p [] [ text string ]
    in 
      List.map  wrapInP paragraghStrings

view : Model -> Html Action
view model = 
    p []
      [ text "Current: "
      , model.text
          |> splitParagraphs
          |> div 
            [ style [ ( "background-color", "red") ]
            ]
    --, div [] (splitParagraphs model.text)
      , hr [] []
      , text ("Time Changed" 
          ++ toString model.changesCount
          )
      , hr [] []
      , text ("Characters " 
          ++ toString (String.length model.text)
          )
      , hr [] []
      , button [ onClick Clear]
               [ text "Clear" ]
      , textarea 
        [ rows 20, cols 50
        , onInput TextChanged
        ,  value model.text
        ]
        []
      ]


main : Program Never 
main = 
  Html.App.beginnerProgram
  { model = initialModel
  , view = view
  , update = update
  }
