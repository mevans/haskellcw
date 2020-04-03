module Tokens where

data Token =
  TokenStream Int |
  TokenInt Int |
  TokenPush |
  TokenAt
  deriving (Eq,Show)