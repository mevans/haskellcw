module Tokens where

data Token =
  TokenStream Int |
  TokenInt Int |
  TokenPush |
  TokenAt |
  TokenLet |
  TokenEq |
  TokenPlus |
  TokenMinus |
  TokenMultiply |
  TokenDivide |
  TokenParenLeft |
  TokenParenRight |
  TokenTrue |
  TokenFalse |
  TokenIf |
  TokenThen |
  TokenElse |
  TokenVar String
  deriving (Eq,Show)