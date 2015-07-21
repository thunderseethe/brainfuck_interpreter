# Compiling
Compiling is pretty simple the interpreter is one file, brainfuck.hs, compile it with ghc

# Running
The brainfuck executable accepts a list of files that contain brainfuck programs, this can be weird with input so be wary of running multiple brainfuck programs that need input

	$ ./brainfuck <filename1> <filename2> ...
	filename1: <Tape Output>
	filename2: <Tape Output>

# Quirks
A quirk with input is that you have to enter one integer per line, this is due to my lack of experience with haskell input and may be fixed in a later version  