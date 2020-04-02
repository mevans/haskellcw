{
module Parser where
import Lexer
}

%name parse
%tokentype { Token }
%error { parseError }
%token
  stream { TokenStream $$ }

%%

Exp : stream { Stream $1 }

{
parseError :: [Token] -> a
parseError a = error ("Parse error" ++ show a)

data Exp = Stream Int
    deriving (Show, Eq)

}