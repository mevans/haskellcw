module Tokens where

data Token =
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
  TokenComma |
  TokenVar String
  deriving (Eq,Show)