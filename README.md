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

#Language Design
Programs are designed to take an input of streams, and output a stream of numbers\

The **input** of streams is provided as the first command line argument, which is read from a file

To **output** a number in the program, use the `push` method
eg. program.txt containing `push 5` and running that on any input, will result in `5`\
note: `push` also can accept a list of numbers to add to the output

To access the input streams, there are reserved variable names in the format `S<stream number>`\
eg. for the first problem input, `S1` is defined as `1, 2, 3, 4`

##Variables
To **define** a variable, use the `let` keyword\
eg. `let x = 5`\
`x` can now be used throughout the program\
eg. `push x`\
would now put 5 into the output

To **reassign** a variable, the `let` keyword isn't needed\
eg. `x = 9`\
The value of `x` is now 9\
##Arithmetic
All basic arithmetic operators are available: `+ - * / ^ %`\
As these programs only deal with integers, the division rounds down.\
eg. ```let x = 5 + 9
       push x```\
Will put `14` in the output

Assignment operators are all also available
`eg x += 6`
##Lists
The only type of list is a list of ints. The reserved variables for the input streams store a list of ints

To access an element of an array, use the `<list> at <index>` syntax\
eg. for the first problem input, `S1` has the value: 1, 2, 3, 4 therefore\
`S1 at 0` will return `1`

The `length` keyword can be used to get the length of a list\
eg. `length S1` will return 4

Lists cannot currently be created easily, however a list can be created using the `range` function\
The syntax for the range function is `range <start> <end>`\
eg. `range 0 10` will return 0,1,2,3,4,5,6,7,8,9,10

#Loops
For loops can be created with the `for <var> in <list>{ }` syntax\
eg. ```for x in (range 0 10){
       push x
       }
       ```\
Will result in the numbers 0 - 10 to be added to the output