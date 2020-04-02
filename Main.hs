import Lexer
import Parser
import System.Environment
import System.IO

parseInput x = map (\l -> map (\n -> read n:: Integer) l)(map words (lines x))

rowsToColumns :: [[Integer]] -> [[Integer]]
rowsToColumns x
        | null x = []
        | null (head x) = []
        | otherwise = [map head x] ++ rowsToColumns (map tail x)

main = do
    args <- getArgs
    let input = head args
    contents <- readFile input
    let lines = parseInput contents
    let streams = rowsToColumns lines
    putStrLn (show streams)

    let programFileName = args !! 1
    programContents <- readFile programFileName
    let programTokens = alexScanTokens programContents
    putStrLn(show programTokens)

--    contents <- readFile textFileName
--    let tokens = alexScanTokens contents
----    let parsed = parseToy tokens
--    putStrLn (show tokens)