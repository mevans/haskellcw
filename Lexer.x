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

  \(       { \s -> TokenParenLeft }
  \)       { \s -> TokenParenRight }
  push     { \s -> TokenPush }
  at       { \s -> TokenAt }
  true     { \s -> TokenTrue }
  false    { \s -> TokenFalse }
  if       { \s -> TokenIf }
  then     { \s -> TokenThen }
  else     { \s -> TokenElse }
  length   { \s -> TokenLength }
  @number  { \s -> TokenInt (read s) }
  S@number { \s -> TokenStream (read (tail s)) }
  $alpha [$alpha $digit \_ \']* { \s -> TokenVar s}
