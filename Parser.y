{
module Parser where
import Tokens
import Syntax
}

%name parse
%tokentype { Token }
%error { parseError }
%token
  let { TokenLet }
  '=' { TokenEq }
  '+' { TokenPlus }
  '-' { TokenMinus }
  '*' { TokenMultiply }
  '/' { TokenDivide }
  '(' { TokenParenLeft }
  ')' { TokenParenRight }
  var { TokenVar $$ }
  int { TokenInt $$ }
  stream { TokenStream $$ }
  push { TokenPush }
  at { TokenAt }
  true { TokenTrue }
  false { TokenFalse }
  if { TokenIf }
  then { TokenThen }
  else { TokenElse }
  length { TokenLength }
  '[' { TokenBracketLeft }
  ']' { TokenBracketRight }

%right push at length '['
%left '+' '-' ']'
%left '*' '/'
%%

Statements : Statement { [$1] }
           | Statement Statements { $1 : $2 }

Statement : push Exp { SPush $2 }
          | let var '=' Exp { SLet $2 $4 }
          | Exp { $1 }

Exp : Exp at Exp { SAt $1 $3}
    | stream { SStream $1 }
    | int { SInt $1 }
    | var { SVar $1 }
    | Exp '+' Exp { SPlus $1 $3 }
    | Exp '-' Exp { SMinus $1 $3 }
    | Exp '*' Exp { SMultiply $1 $3 }
    | Exp '/' Exp { SDivide $1 $3 }
    | '(' Exp ')' { $2 }
    | true { STrue }
    | false { SFalse }
    | if Exp then Exp else Exp { SIf $2 $4 $6}
    | length Exp { SLength $2 }

{

parseError :: [Token] -> a
parseError a = error ("Parse error" ++ show a)

}