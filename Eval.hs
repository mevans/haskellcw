module Eval where
import Syntax

type Output = [Int]
type Environment = [(String,Exp)]
data Frame = HOpp Operation Exp Environment | OppH Operation Exp
           | HLength Environment
           | HLet String
           | HAssign String
           | HPush Environment
           | HAt Exp Environment | AtH Exp
           | HAssignOpp Operation String | AssignOppH Operation String Exp
           | HRange Exp | RangeH Exp
                                                    --  VVV Stores track of current statement in current cycle
           | HFor String [Exp] | ForH String [Int] [Exp] Int
           | HConcat Exp | ConcatH Exp
    deriving Show
type Kont = [ Frame ]
type State = (Exp, Environment, Kont, Output)

getStream :: Int -> Environment -> Exp
getStream n env = getVariable ("S" ++ show n) env

getVariable :: String -> Environment -> Exp
getVariable var environment = case result of
                                Just e -> e
                                Nothing -> error (var ++ " not initialised")
                              where result = (lookup var environment)

addToEnvironment :: String -> Exp -> Environment -> Environment
addToEnvironment var e env = (var, e) : filter (\m -> (fst m) /= var) env

reassign :: String -> Exp -> Environment -> Environment
reassign var e env = case result of
                        Just e' -> addToEnvironment var e env
                        Nothing -> error (var ++ " not initialised")
                    where result = lookup var env

isTerminated :: State -> Bool
-- Only terminate if the last expression is a void, and there is no kont
isTerminated (SVoid, env, [], o) = True
isTerminated _ = False

applyOperation :: Operation -> Int -> Int -> Int
applyOperation operation i j = result
        where result = case operation of
                Plus -> i + j
                Minus -> i - j
                Multiply -> i * j
                Divide -> div i j
                Pow -> i ^ j
                Mod -> mod i j

eval1 :: State -> State

-- Operations
eval1 ((SOpp opp e1 e2), env, k, o) = (e1, env, (HOpp opp e2 env) : k, o)
eval1 ((SInt i), env1, (HOpp opp e env2) : k, o) = (e, env2, (OppH opp (SInt i)) : k, o)
eval1 ((SInt j), env, (OppH opp (SInt i)) : k, o) = (SInt (applyOperation opp i j), env, k, o)


-- Assign Operations
eval1 ((SAssignOpp opp var e), env, k, o) = (e, env, (HAssignOpp opp var) : k, o)
eval1 (e@(SInt i), env, (HAssignOpp opp var) : k, o) = (getVariable var env, env, (AssignOppH opp var e) : k, o)
eval1 ((SInt i), env, (AssignOppH opp var (SInt j)) : k, o) = (SVoid, reassign var (SInt (applyOperation opp i j)) env, k, o)

-- Length
eval1 ((SLength l), env, k, o) = (l, env, (HLength env) : k, o)
eval1 ((SIntList is), env1, (HLength env2) : k, o) = (SInt (length is), env2, k, o)

-- Concat
-- When you see a concat with 2 expressions, focus on simplifying the second expression, and save the other expression for later
eval1 ((SConcat e1 e2), env, k, o) = (e2, env, (HConcat e1) : k, o)
-- Once that second expression has been reduced to an int list and we see the other expression again, now reduce the other expression and save the int list for later
eval1 (list@(SIntList is), env, (HConcat e) : k, o) = (e, env, (ConcatH list) : k, o)
-- Once the other expression is reduced to an int list and the other int list we saved for later is here, return the combined list
eval1 ((SIntList is), env, (ConcatH (SIntList ys)) : k, o) = ((SIntList (is ++ ys)), env, k, o)

-- Stream
eval1 ((SStream n), env, k, o) = (getStream n env, env, k, o)

-- Let variable
eval1 ((SLet var e), env, k, o) = (e, env, (HLet var) : k, o)
eval1 (e, env, (HLet var) : k, o) = (SVoid, addToEnvironment var e env, k, o)

-- Re-assign variable
eval1 ((SAssign var e), env, k, o) = (e, env, (HAssign var) : k, o)
eval1 (e, env, (HAssign var) : k, o) = (SVoid, reassign var e env, k, o)

-- Push value to output
eval1 ((SPush e), env, k, o) = (e, env, (HPush env) : k, o)
eval1 ((SInt i), env1, (HPush env2) : k, o) = (SVoid, env1, k, o ++ [i])
-- Push list to output
eval1 ((SIntList is), env1, (HPush env2) : k, o) = (SVoid, env1, k, o ++ is)

-- At

-- e1 reduces to stream, e2 reduces to int
eval1 ((SAt e1 e2), env, k, o) = (e1, env, (HAt e2 env) : k, o)
eval1 (list@(SIntList is), env1, (HAt e env2) : k, o) = (e, env2, (AtH list) : k, o)
eval1 ((SInt i), env, (AtH (SIntList is)) : k, o) = (SInt (is !! i), env, k, o)

-- Variables
eval1 ((SVar var), env, k, o) = (getVariable var env, env, k, o)

-- Range
eval1 ((SRange e1 e2), env, k, o) = (e1, env, (HRange e2) : k, o)
eval1 (first@(SInt i), env, (HRange e2) : k, o) = (e2, env, (RangeH first) : k, o)
eval1 ((SInt i), env, (RangeH (SInt j)) : k, o) = ((SIntList [j..i]), env, k, o)

eval1 ((SFor var e es), env, k, o) = (e, env, (HFor var es) : k, o)
eval1 ((SIntList is), env, (HFor var es) : k, o) = (SVoid, env, (ForH var is es 0) : k, o)
-- If there is a for loop with an empty range and already at 0 index, chuck it away
eval1 (e, env, (ForH var [] exps 0) : k, o) = (e, env, k, o)
eval1 (SVoid, env, (ForH var range@(i:is) exps@(e:es) index) : k, o)
        -- Loop is starting / starting new cycle (put in first expression, assign variable to next i, add another for loop with index of 1 to kont
        | index == 0 = (e, addToEnvironment var (SInt i) env, (ForH var range exps 1) : k, o)
        -- Loop cycle has reached end, back to the top, remove item from range
        | index == length exps = (SVoid, env, (ForH var is exps 0) : k, o)
        -- Loop in middle of a cycle
        | otherwise = (exps !! index, env, (ForH var range exps (index + 1)) : k, o)

eval :: State -> State
eval input@(e, env, k, o)
    | isTerminated state = state
    | otherwise = eval state
    where state@(e', env', k', o') = eval1 input

evalBlock :: [Exp] -> Environment -> [Int] -> [Int]
evalBlock [] env acc = acc
evalBlock (e:es) env acc = evalBlock es env' o'
        where result@(e', env', k', o') = eval (e, env, [], acc)
