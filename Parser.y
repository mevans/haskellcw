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
  push { TokenPush }

%right push
%%

Exp : stream { Stream $1 }
    | int { Int $1 }
    | push Exp { Push $2 }

{
parseError :: [Token] -> a
parseError a = error ("Parse error" ++ show a)

data Exp = Stream Int
         | Int Int
         | Push Exp
    deriving (Show, Eq)

}