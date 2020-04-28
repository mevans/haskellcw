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
  -- Operators
  '+' { TokenPlus }
  '-' { TokenMinus }
  '*' { TokenMultiply }
  '/' { TokenDivide }
  '^' { TokenPower }
  '%' { TokenModulo }

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
  range { TokenRange }
  for { TokenFor }
  in { TokenIn }
  '{' { TokenBraceLeft }
  '}' { TokenBraceRight }
  concat { TokenConcat }

%right push at length '[' range
%left '+' '-' ']'
%left '*' '/'
%%

Statements : Statement { [$1] }
           | Statement Statements { $1 : $2 }

Statement : push Exp { SPush $2 }
          | let var '=' Exp { SLet $2 $4 }
          | var '=' Exp { SAssign $1 $3 }
          | var Operation '=' Exp { SAssignOpp $2 $1 $4 }
          | for var in Exp '{' Statements '}' { SFor $2 $4 $6 }

Exp : Exp at Exp { SAt $1 $3}
    | stream { SStream $1 }
    | int { SInt $1 }
    | var { SVar $1 }
    | Exp Operation Exp { SOpp $2 $1 $3 }
    | '(' Exp ')' { $2 }
    | true { STrue }
    | false { SFalse }
    | if Exp then Exp else Exp { SIf $2 $4 $6}
    | length Exp { SLength $2 }
    | range Exp Exp { SRange $2 $3}
    | concat Exp Exp { SConcat $2 $3 }

Operation : '+' { Plus }
          | '-' { Minus }
          | '*' { Multiply }
          | '/' { Divide }
          | '%' { Mod }
          | '^' { Pow }

{

parseError :: [Token] -> a
parseError a = error ("Parse error" ++ show a)

}