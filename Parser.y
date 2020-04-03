{
module Parser where
import Tokens
}

%name parse
%tokentype { Token }
%error { parseError }
%token
  let { TokenLet }
  '=' { TokenEq }
  var { TokenVar $$ }
  int { TokenInt $$ }
  stream { TokenStream $$ }
  push { TokenPush }
  at { TokenAt }

%right push at
%%

Statements : Statement { [$1] }
           | Statement Statements { $1 : $2 }

Statement : push Exp { Push $2 }
          | let var '=' Exp { Let $2 $4 }

Exp : Exp at Exp { At $1 $3}
    | stream { Stream $1 }
    | int { Int $1 }
    | var { Var $1 }

{
parseError :: [Token] -> a
parseError a = error ("Parse error" ++ show a)

data Exp = Let String Exp
         | At Exp Exp
         | Push Exp
         | Stream Int
         | Int Int
         | Var String
    deriving Show

}