module Syntax where

data Operation = Plus | Minus | Multiply | Divide | Pow | Mod
    deriving (Show, Eq)

data ComparisonOperation = Equal | NotEqual | GreaterThan | GreaterThanOrEq | LessThan | LessThanOrEq
    deriving (Show, Eq)

data LogicalOperation = And | Or
    deriving (Show, Eq)

data Exp = SLet String Exp
         | SAt Exp Exp
         | SPush Exp
         | SInt Int
         | SIntList [Int]
         | SExpList [Exp]
         | SVar String
         | SOpp Operation Exp Exp
         | SComparisonOpp ComparisonOperation Exp Exp
         | SLogicalOpp LogicalOperation Exp Exp
         | SAssignOpp Operation String Exp
         | SBool Bool
         | SNot Exp
         | SIf Exp Exp Exp
         | SLength Exp
         | SVoid
         | SAssign String Exp
         | SRange Exp Exp
         | SFor String Exp [Exp]
         | SConcat Exp Exp
         | SPop Exp
         | SAppend Exp Exp
         -- Variable, position, value
         | SAssignAt String Exp Exp
    deriving (Show, Eq)