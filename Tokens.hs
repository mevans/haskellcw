module Tokens where

data Token =
  TokenStream Int |
  TokenInt Int |
  TokenPush
  deriving (Eq,Show)