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
  push     { \s -> TokenPush }
  at       { \s -> TokenAt }
  @number  { \s -> TokenInt (read s) }
  S@number { \s -> TokenStream (read (tail s)) }