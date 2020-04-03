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
  at { TokenAt }

%%

Exp : Exp at Exp { At $1 $3}
    | push Exp { Push $2 }
    | stream { Stream $1 }
    | int { Int $1 }

{
parseError :: [Token] -> a
parseError a = error ("Parse error" ++ show a)

data Exp = At Exp Exp
         | Push Exp
         | Stream Int
         | Int Int
    deriving Show

}