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

  -- Logical Operators
  '>' { TokenGreaterThan }
  '<' { TokenLessThan }
  '!' { TokenNot }
  "||" { TokenOr }
  "&&" { TokenAnd }

  '(' { TokenParenLeft }
  ')' { TokenParenRight }
  var { TokenVar $$ }
  int { TokenInt $$ }
  push { TokenPush }
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
  pop { TokenPop }
  append { TokenAppend }
  '[' { TokenBracketLeft }
  ']' { TokenBracketRight }
  ',' { TokenComma }

%right push at length '[' range
%left '+' '-' ']'
%left '*' '/'
%%

Statements : Statement { [$1] }
           | Statement Statements { $1 : $2 }

ExpressionList : Exp { [$1] }
           | Exp ',' ExpressionList { $1 : $3 }
           | { [] }

Statement : push Exp { SPush $2 }
          | let var '=' Exp { SLet $2 $4 }
          | var '[' Exp ']' '=' Exp { SAssignAt $1 $3 $6 }
          | var '=' Exp { SAssign $1 $3 }
          | var Operation '=' Exp { SAssignOpp $2 $1 $4 }
          | for var in Exp '{' Statements '}' { SFor $2 $4 $6 }

Exp : int { SInt $1 }
    | var { SVar $1 }
    | Exp Operation Exp { SOpp $2 $1 $3 }
    | Exp ComparisonOperation Exp { SComparisonOpp $2 $1 $3 }
    | Exp LogicalOperation Exp { SLogicalOpp $2 $1 $3 }
    | '!' Exp { SNot $2 }
    | '(' Exp ')' { $2 }
    | true { SBool True }
    | false { SBool False }
    | if Exp then Exp else Exp { SIf $2 $4 $6}
    | length Exp { SLength $2 }
    | range Exp Exp { SRange $2 $3}
    | concat Exp Exp { SConcat $2 $3 }
    | pop Exp { SPop $2 }
    | Exp append Exp { SAppend $1 $3 }
    | Exp '[' Exp ']' { SAt $1 $3 }
    | '[' ExpressionList ']' { SExpList $2 }

Operation : '+' { Plus }
          | '-' { Minus }
          | '*' { Multiply }
          | '/' { Divide }
          | '%' { Mod }
          | '^' { Pow }

ComparisonOperation : '=''=' { Equal }
                    | '!''=' { NotEqual }
                    | '>'  { GreaterThan }
                    | '>''=' { GreaterThanOrEq }
                    | '<'  { LessThan }
                    | '<''=' { LessThanOrEq }

LogicalOperation : "&&" { And }
                 | "||" { Or }

{

parseError :: [Token] -> a
parseError a = error ("Parse error" ++ show a)

}