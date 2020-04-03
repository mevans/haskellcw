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
  push     { \s -> TokenPush }
  at       { \s -> TokenAt }
  @number  { \s -> TokenInt (read s) }
  S@number { \s -> TokenStream (read (tail s)) }
  $alpha [$alpha $digit \_ \']* { \s -> TokenVar s}
