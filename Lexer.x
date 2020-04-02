{
module Lexer where
}

%wrapper "basic"
$digit = 0-9
$nonZero = 1-9
$alpha = [a-zA-Z]
@number = $nonZero[$digit]*

tokens :-
  $white+       ;
  "--".*        ;
  S@number {\s -> TokenStream (read (tail s))}
{
data Token =
  TokenStream Int
  deriving (Eq,Show)
}