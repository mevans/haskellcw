module Syntax where

data Exp = SLet String Exp
         | SAt Exp Exp
         | SPush Exp
         | SStream Int
         | SInt Int
         | SIntList [Int]
         | SVar String
         | SPlus Exp Exp
         | SMinus Exp Exp
         | SMultiply Exp Exp
         | SDivide Exp Exp
         | STrue
         | SFalse
         | SIf Exp Exp Exp
         | SLength Exp
    deriving Show