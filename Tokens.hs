module Tokens where

data Token =
  TokenStream Int |
  TokenInt Int |
  TokenPush |
  TokenAt |
  TokenLet |
  TokenEq |
  -- Operators
  TokenPlus |
  TokenMinus |
  TokenMultiply |
  TokenDivide |
  TokenPower |
  TokenModulo |

  TokenParenLeft |
  TokenParenRight |
  TokenTrue |
  TokenFalse |
  TokenIf |
  TokenThen |
  TokenElse |
  TokenLength |
  TokenRange |
  TokenFor |
  TokenIn |
  TokenBraceRight |
  TokenBraceLeft |
  TokenConcat |
  TokenPop |
  TokenAppend |
  TokenVar String
  deriving (Eq,Show)