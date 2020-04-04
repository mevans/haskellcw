module Syntax where

data Operation = Plus | Minus | Multiply | Divide | Pow | Mod
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
         | SAssign String Exp
    deriving (Show, Eq)