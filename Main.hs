import Lexer
import Parser
import Eval
import System.Environment
import System.IO
import Syntax
import Data.List

parseInput x = map (\l -> map (\n -> read n :: Int) l)(map words (lines x))

columnsToEnvironment :: [[Int]] -> [(String,Exp)]
columnsToEnvironment xs = zip (map (\n -> "S" ++ show n)[1..]) (map (\x -> (SIntList x)) xs)

main = do
    args <- getArgs
    let input = head args
    contents <- readFile input
    let lines = parseInput contents
    let streams = transpose lines
    let initialEnv = columnsToEnvironment streams
--    let v = getStream 1 initialEnv

    let programFileName = args !! 1
    programContents <- readFile programFileName
    let programTokens = alexScanTokens programContents
    let parsedProgram = parse programTokens
    putStrLn(show (head parsedProgram))
    let state = ((head parsedProgram), initialEnv, [])
    let afterOne = eval1 state
    putStrLn(show afterOne)
    let afterTwo = eval1 afterOne
    putStrLn(show afterTwo)
    let afterThree = eval1 afterTwo
    putStrLn(show afterThree)
    let afterLoads = eval1 (eval1 (eval1 (eval1 (eval1 (eval1 afterThree)))))
    putStrLn(show afterLoads)
--    eval parsedProgram

--    contents <- readFile textFileName
--    let tokens = alexScanTokens contents
----    let parsed = parseToy tokens
--    putStrLn (show tokens)