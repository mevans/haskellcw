module Eval where
import Syntax
import Control.Monad.State

type Environment = [(String, Exp)]
data Frame = HoleApp Exp Environment | AppHole Exp
type Kont = [Frame]
type Configuration = (Exp,Environment,Kont)

data Value
	= VInt Int
	| VNone
	deriving Show

type Eval = StateT Environment IO

val :: Value -> Int
val (VInt i) = i
val VNone = 0

eval' :: Exp -> Eval Value
eval' exp = case exp of
    Push e -> do
    	e' <- eval' e
    	liftIO $ print e'
    	return VNone
    Int i -> return (VInt i)
    Plus e1 e2 -> do
        e1' <- eval' e1
        e2' <- eval' e2
        return (VInt ((val e1') + val(e2')))
    _ -> do
        error "nope"

eval :: [Exp] -> IO ()
eval xs = evalStateT (mapM_ eval' xs) []