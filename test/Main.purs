module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Class.Console (log, logShow)
import Node.Async (concat, each, eachSeries, every)

foreign import jslog::forall a. a -> Effect Unit

foreign import setTimeout::Effect Unit -> Int -> Effect Unit

main :: Effect Unit
main = do
  concat [1,2,3] (\num cb -> cb "" ["(",show num,")"]) (\_ b -> logShow b)
  every  [1,2,3,4] (\num cb -> cb "" (num < 5)) (\_ b -> logShow b)
  each   ["a","b","c"] (\num cb -> logShow num *> cb "") (\err -> log err)
  eachSeries ["a","b","c"] (\num cb -> do
                                       logShow num 
                                       setTimeout (  cb "") 1000) (\err -> log err)
 