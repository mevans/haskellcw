module Utils where
import Data.Char

streamName :: Int -> String
streamName n = [chr (97 + n)]

replaceAtIndex :: Int -> a -> [a] -> [a]
replaceAtIndex n item ls = a ++ (item:b) where (a, (_:b)) = splitAt n ls