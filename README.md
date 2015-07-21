# Compiling
Compiling is pretty simple the interpreter is one file, brainfuck.hs, compile it with ghc

# Running
The brainfuck executable accepts a list of files that contain brainfuck programs, this can be weird with input so be wary of running multiple brainfuck programs that need input
> $ ./brainfuck &lt;filename1&gt; &lt;filename2&gt; ... \
> filename1: &lt;Tape Output&gt; \
>  filename2: &lt;Tape Output&gt;

# Quirks
A quirk with input is that you have to enter one integer per line, this is due to my lack of experience with haskell input and may be fixed in a later version  