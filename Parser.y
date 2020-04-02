{
module Parser where
import Tokens
}

%name parse
%tokentype { Token }
%error { parseError }
%token
  int { TokenInt $$ }
  stream { TokenStream $$ }

%%

Exp : stream { Stream $1 }
    | int { Int $1 }

{
parseError :: [Token] -> a
parseError a = error ("Parse error" ++ show a)

data Exp = Stream Int
         | Int Int
    deriving (Show, Eq)

}