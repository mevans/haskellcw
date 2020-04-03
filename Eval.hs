module Eval where
import Syntax

type Environment = [(String,Exp)]
data Frame = HAdd Exp Environment | AddH Exp
    deriving Show
type Kont = [ Frame ]
type State = (Exp, Environment, Kont)


eval1 :: State -> State

eval1 ((SPlus e1 e2), env, k) = (e1, env, (HAdd e2 env):k )
eval1 ((SInt i), env1, (HAdd e env2) : k) = (e, env2, (AddH (SInt i)) : k)
eval1 ((SInt j), env, (AddH (SInt i)) : k) = (SInt (i + j), [], k)
