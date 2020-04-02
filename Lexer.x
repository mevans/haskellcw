{
module Lexer where
import Tokens
}

%wrapper "basic"
$digit = 0-9
$nonZero = 1-9
$alpha = [a-zA-Z]
@number = $nonZero[$digit]*

tokens :-
  $white+       ;
  "--".*        ;
  @number  { \s -> TokenInt (read s) }
  S@number { \s -> TokenStream (read (tail s)) }