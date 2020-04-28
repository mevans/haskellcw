module Utils where
import Data.Char

streamName :: Int -> String
streamName n = [chr (97 + n)]