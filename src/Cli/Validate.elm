module Cli.Validate exposing (ValidationResult(..), predicate, regex)

{-|

@docs predicate, ValidationResult, regex

-}

import Regex


{-| -}
type ValidationResult
    = Valid
    | Invalid String


{-| Turns a predicate function into a validate function.

      Command.build identity
       |> with (Option.optionalKeywordArg "pair-programmers"
       |> Option.validateMapIfPresent String.toInt
       |> Option.validateIfPresent (Validate.predicate "Must be even" (\n -> n % 2 == 0))

-}
predicate : String -> (a -> Bool) -> (a -> ValidationResult)
predicate message predicate =
    predicate
        >> (\boolResult ->
                if boolResult then
                    Valid
                else
                    Invalid message
           )


{-| -}
regex : String -> String -> ValidationResult
regex regexPattern checkString =
    if Regex.contains (Regex.regex regexPattern) checkString then
        Valid
    else
        Invalid ("Must be of form /" ++ regexPattern ++ "/")
