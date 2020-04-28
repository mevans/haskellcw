import Lexer
import Parser
import Eval
import System.Environment
import System.IO
import Syntax
import Data.List
import Utils

parseInput x = map (\l -> map (\n -> read n :: Int) l)(map words (lines x))

columnsToEnvironment :: [[Int]] -> [(String,Exp)]
columnsToEnvironment xs = zip (map streamName [0..]) (map (\x -> (SIntList x)) xs)

evalN :: Int -> State -> State
evalN 0 s = s
evalN n s = evalN (n - 1) (eval1 s)

main = do
    args <- getArgs
    let input = head args
    let numberEvals = read (args !! 2) :: Int
    contents <- readFile input
    let lines = parseInput contents
    let streams = transpose lines
    print streams
    let initialEnv = columnsToEnvironment streams
--    let v = getStream 1 initialEnv

    let programFileName = args !! 1
    programContents <- readFile programFileName
    let programTokens = alexScanTokens programContents
--    putStrLn(show programTokens)
    let parsedProgram = parse programTokens
--    putStrLn(show parsedProgram)
--    let initialState = ((head parsedProgram), initialEnv, [], [])
--    putStrLn(show (evalN numberEvals initialState))
    let evaluatedBlock = evalBlock parsedProgram initialEnv []
    putStrLn(show evaluatedBlock)
--    eval parsedProgram

--    contents <- readFile textFileName
--    let tokens = alexScanTokens contents
----    let parsed = parseToy tokens
--    putStrLn (show tokens)