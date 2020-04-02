module Tokens where

data Token =
  TokenStream Int |
  TokenInt Int
  deriving (Eq,Show)