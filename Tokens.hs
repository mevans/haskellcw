module Tokens where

data Token =
  TokenStream Int |
  TokenInt Int |
  TokenPush |
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
  TokenBracketLeft |
  TokenBracketRight |
  TokenVar String
  deriving (Eq,Show)