import System.IO

doubleMe :: Float -> Float
doubleMe x = x + x

main = do 
	putStrLn "Please Enter your name:"
	name <- getLine
	putStrLn ("Hello : " ++ name ++ "!")