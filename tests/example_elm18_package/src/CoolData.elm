module CoolData exposing (..)

{-| This module implements the standard `f` algorithm known as "CoolData".

@docs f

-}


{-| The standard "CoolData" algorithm.
-}
f : Float -> Float
f a =
    sqrt a * (1 / 1 + a)
