module Node.Async (
    ttt,
    every,
    concat,
    each,
    eachSeries
) where

import Prelude

import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)

foreign import ttt::Effect Unit

foreign import everyImpl::forall a. Array a 
                      -> (a -> (EffectFn2 String Boolean Unit) -> Effect Unit)
                      -> (String -> Boolean -> Effect Unit) 
                      -> Effect Unit


every::forall a.Array a -> (a -> (String -> Boolean -> Effect Unit) -> Effect Unit) -> (String -> Boolean -> Effect Unit) -> Effect Unit
every arr tf rf =  everyImpl arr (\a cb -> tf a (runEffectFn2 cb)) rf

foreign import concatImpl::forall a b.Array a 
                                      -> ( a -> (EffectFn2 String (Array b) Unit) -> Effect Unit) 
                                      -> (String -> (Array b) -> Effect Unit) 
                                      -> Effect Unit

concat::forall a b.Array a -> (a -> (String -> Array b -> Effect Unit) -> Effect Unit) -> (String -> Array b -> Effect Unit) -> Effect Unit
concat arr f rf = concatImpl arr (\a cb -> f  a (runEffectFn2 cb)) rf

foreign import eachImpl::forall a.Array a -> (a -> (EffectFn1 String Unit) -> Effect Unit) -> (String -> Effect Unit) -> Effect Unit

each :: forall a. Array a -> (a -> (String -> Effect Unit) -> Effect Unit) -> (String -> Effect Unit) -> Effect Unit
each arr f rf = eachImpl arr (\a cb-> f a (runEffectFn1 cb)) rf

foreign import eachSeriesImpl::forall a.Array a -> (a -> (EffectFn1 String Unit) -> Effect Unit) -> (String -> Effect Unit) -> Effect Unit

eachSeries :: forall a. Array a -> (a -> (String -> Effect Unit) -> Effect Unit) -> (String -> Effect Unit) -> Effect Unit
eachSeries arr f rf = eachSeriesImpl arr (\a cb-> f a (runEffectFn1 cb)) rf
