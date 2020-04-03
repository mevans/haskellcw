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
  TokenVar String
  deriving (Eq,Show)