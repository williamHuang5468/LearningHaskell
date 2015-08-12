import System.IO

main = do 
	putStrLn "Please Enter your name:"
	name <- getLine
	putStrLn ("Hello : " ++ name ++ "!")