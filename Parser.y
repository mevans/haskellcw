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

%right push at
%%

Statements : Statement { [$1] }
           | Statement Statements { $1 : $2 }

Statement : push Exp { Push $2 }

Exp : Exp at Exp { At $1 $3}
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