Haskell CW

To compile:\
`alex Lexer.x` to compile the alex\
`happy Parser.y` to compile the happy\
`ghc Main`\
(These only need doing if you changed the lexer / parser / main)\


To run:\
`./Main <input file> <program>`\
eg. to run problem 3\
`./Main problems/3/input.txt problems/3/program.txt`