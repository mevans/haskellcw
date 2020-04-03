module Syntax where

data Exp = Let String Exp
         | At Exp Exp
         | Push Exp
         | Stream Int
         | Int Int
         | Var String
         | Plus Exp Exp
         | Minus Exp Exp
         | Multiply Exp Exp
         | Divide Exp Exp
         | Void
    deriving Show