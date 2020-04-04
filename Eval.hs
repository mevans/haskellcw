module Eval where
import Syntax

type Output = [Int]
type Environment = [(String,Exp)]
data Frame = HAdd Exp Environment | AddH Exp
           | HLength Environment
           | HLet String
           | HPush Environment
           | HAt Exp Environment | AtH Exp
    deriving Show
type Kont = [ Frame ]
type State = (Exp, Environment, Kont, Output)

getStream :: Int -> Environment -> Exp
getStream n environment = case result of
                            Just e -> e
                            Nothing -> error "Not found"
            where result = (lookup ("S" ++ show n) environment)

addToEnvironment :: String -> Exp -> Environment -> Environment
addToEnvironment var e env = (var, e) : filter (\m -> (fst m) /= var) env

isTerminated :: State -> Bool
-- Only terminate if the last expression is a void, and there is no kont
isTerminated (SVoid, env, [], o) = True
isTerminated _ = False

eval1 :: State -> State

-- Addition
eval1 ((SPlus e1 e2), env, k, o) = (e1, env, (HAdd e2 env) : k, o)
eval1 ((SInt i), env1, (HAdd e env2) : k, o) = (e, env2, (AddH (SInt i)) : k, o)
eval1 ((SInt j), env, (AddH (SInt i)) : k, o) = (SInt (i + j), [], k, o)

-- Length
eval1 ((SLength l), env, k, o) = (l, env, (HLength env) : k, o)
eval1 ((SIntList is), env1, (HLength env2) : k, o) = (SInt (length is), [], k, o)

-- Stream
eval1 ((SStream n), env, k, o) = (getStream n env, env, k, o)

-- Let variable
eval1 ((SLet var e), env, k, o) = (e, env, (HLet var) : k, o)
eval1 (e, env, (HLet var) : k, o) = (SVoid, addToEnvironment var e env, k, o)

-- Push value to output
eval1 ((SPush e), env, k, o) = (e, env, (HPush env) : k, o)
eval1 ((SInt i), env1, (HPush env2) : k, o) = (SVoid, env1, k, o ++ [i])

-- At

-- e1 reduces to stream, e2 reduces to int
eval1 ((SAt e1 e2), env, k, o) = (e1, env, (HAt e2 env) : k, o)
eval1 (list@(SIntList is), env1, (HAt e env2) : k, o) = (e, env2, (AtH list) : k, o)
eval1 ((SInt i), env, (AtH (SIntList is)) : k, o) = (SInt (is !! i), env, k, o)


eval :: State -> State
eval input@(e, env, k, o)
    | isTerminated state = state
    | otherwise = eval state
    where state@(e', env', k', o') = eval1 input

evalBlock :: [Exp] -> Environment -> [Int] -> [Int]
evalBlock [] env acc = acc
evalBlock (e:es) env acc = evalBlock es env' o'
        where result@(e', env', k', o') = eval (e, env, [], acc)
