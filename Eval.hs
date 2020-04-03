module Eval where
import Syntax

type Environment = [(String,Exp)]
data Frame = HAdd Exp Environment | AddH Exp
           | HLength Environment
    deriving Show
type Kont = [ Frame ]
type State = (Exp, Environment, Kont)

getStream :: Int -> Environment -> Exp
getStream n environment = case result of
                            Just e -> e
                            Nothing -> error "Not found"
            where result = (lookup ("S" ++ show n) environment)



eval1 :: State -> State

-- Addition
eval1 ((SPlus e1 e2), env, k) = (e1, env, (HAdd e2 env):k )
eval1 ((SInt i), env1, (HAdd e env2) : k) = (e, env2, (AddH (SInt i)) : k)
eval1 ((SInt j), env, (AddH (SInt i)) : k) = (SInt (i + j), [], k)

-- Length
eval1 ((SLength l), env, k) = (l, env, (HLength env) : k)
eval1 ((SIntList is), env1, (HLength env2) : k) = (SInt (length is), [], k)

-- Stream
eval1 ((SStream n), env, k) = (getStream n env, env, k)
