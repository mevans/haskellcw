module Tokens where

data Token =
  TokenStream Int |
  TokenInt Int |
  TokenPush |
  TokenAt |
  TokenLet |
  TokenEq |
  TokenVar String
  deriving (Eq,Show)