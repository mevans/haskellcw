module Syntax where

data Operation = Plus | Minus | Multiply | Divide
    deriving (Show, Eq)

data Exp = SLet String Exp
         | SAt Exp Exp
         | SPush Exp
         | SStream Int
         | SInt Int
         | SIntList [Int]
         | SVar String
         | SOpp Operation Exp Exp
         | STrue
         | SFalse
         | SIf Exp Exp Exp
         | SLength Exp
         | SVoid
    deriving (Show, Eq)