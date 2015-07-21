import Debug.Trace
import Data.Char
import System.Environment

data Tape = Tape [Int] Int [Int]
instance Show Tape where
	show (Tape left curr right) = show $ (reverse left)++[curr]++right

brainfuck :: Tape -> [Char] -> IO Tape
brainfuck tape [] = return tape
-- handle > operator
brainfuck (Tape left move []) ('>':prog) =
	brainfuck (Tape (move:left) 0 []) prog 
brainfuck (Tape left move (curr:right)) ('>':prog) =
	brainfuck (Tape (move:left) curr right) prog

-- handle < operator
brainfuck (Tape [] move right) ('<':prog)  =
	brainfuck (Tape [] 0 (move:right)) prog
brainfuck (Tape (curr:left) move right) ('<':prog) =
	brainfuck (Tape left curr (move:right)) prog

-- handle + operator
brainfuck (Tape left curr right) ('+':prog) =
	brainfuck (Tape left (curr + 1) right) prog

-- handle - operator
brainfuck (Tape left 0 right) ('-':prog) =
	brainfuck (Tape left 0 right) prog
brainfuck (Tape left curr right) ('-':prog) =
	brainfuck (Tape left (curr - 1) right) prog

-- handle . operator
brainfuck (Tape left curr right) ('.':prog) = do
	putChar $ chr $ curr
	brainfuck (Tape left curr right) prog
-- handle , operator
brainfuck (Tape left curr right) (',':prog) = do
	char <- getChar
	brainfuck (Tape left (ord char) right) prog
-- handle @ operator
brainfuck (Tape left curr right) ('@':prog) = do
	intString <- getLine
	brainfuck (Tape left (read intString) right) prog

-- handle loop operators
brainfuck tape@(Tape left curr right) ('[':prog) =
	if curr == 0
	then brainfuck tape (afterLoop 0 prog)
	else do
		newTape <- brainfuck tape (toLoop 0 prog)
		brainfuck newTape ('[':prog)

-- Ignore all other characters
brainfuck tape (_:prog) =
	brainfuck tape prog

afterLoop :: Int -> [Char] -> [Char]
afterLoop 0 (']':prog) = prog
afterLoop n (']':prog) = afterLoop (n-1) prog
afterLoop n ('[':prog) = afterLoop (n+1) prog
afterLoop n (_:prog) = afterLoop n prog


toLoop :: Int -> [Char] -> [Char]
toLoop 0 (']':prog) = []
toLoop n (']':prog) = ']':(toLoop (n-1) prog) -- ++[']']
toLoop n ('[':prog) = '[':(toLoop (n+1) prog) -- ++['[']
toLoop n (c:prog) = c:(toLoop n prog) -- ++[c]

-- Input/Output methods
interpreter = brainfuck (Tape [] 0 [])

strOutput :: [(String, Tape)] -> String
strOutput [] = ""
strOutput ((arg, tape):output) =
	(arg++": "++(show tape)++"\n") ++ (strOutput output)

-- >+>++>+++<<<
main = do
	args <- getArgs
	files <- mapM readFile args
	tapes <- mapM interpreter files
	putStrLn $ strOutput (zip args tapes)