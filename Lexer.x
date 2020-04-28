{
module Lexer where
import Tokens
}

%wrapper "basic"
$digit = 0-9
$nonZero = 1-9
$alpha = [a-zA-Z]
@number = 0 | $nonZero[$digit]*

tokens :-
  $white+       ;
  "--".*        ;
  let      { \s -> TokenLet }
  \=       { \s -> TokenEq }
  -- Operators
  \+       { \s -> TokenPlus }
  \-       { \s -> TokenMinus }
  \*       { \s -> TokenMultiply }
  \/       { \s -> TokenDivide }
  \^       { \s -> TokenPower }
  \%       { \s -> TokenModulo }

  -- Comparison Operators
  \>       { \s -> TokenGreaterThan }
  \<       { \s -> TokenLessThan }
  \!       { \s -> TokenNot }

  -- Logical Operators
  \|\|     { \s -> TokenOr }
  \&\&     { \s -> TokenAnd }

  \(       { \s -> TokenParenLeft }
  \)       { \s -> TokenParenRight }
  push     { \s -> TokenPush }
  true     { \s -> TokenTrue }
  false    { \s -> TokenFalse }
  if       { \s -> TokenIf }
  then     { \s -> TokenThen }
  else     { \s -> TokenElse }
  length   { \s -> TokenLength }
  range    { \s -> TokenRange }
  for      { \s -> TokenFor }
  in       { \s -> TokenIn }
  \{       { \s -> TokenBraceLeft }
  \}       { \s -> TokenBraceRight }
  concat   { \s -> TokenConcat }
  pop      { \s -> TokenPop }
  append   { \s -> TokenAppend }
  \[       { \s -> TokenBracketLeft }
  \]       { \s -> TokenBracketRight }
  \,       { \s -> TokenComma }
  @number  { \s -> TokenInt (read s) }
  $alpha [$alpha $digit \_ \']* { \s -> TokenVar s}
