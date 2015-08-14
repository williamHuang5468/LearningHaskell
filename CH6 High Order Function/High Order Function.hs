applyTwice :: (a -> a) -> a -> a

--  它標明了首個參數是個參數與回傳值型別都是a的函數，
--  第二個參數與回傳值的型別也都是a。

--  其首個參數是個型別為 (a->a) 的函數,第二個參數是個 a。 該函數的型別可以是 (Int->Int)，也可以是 (String->String)，但第二個參數必須與之一致。 
applyTwice f x = f (f x)

multThree :: (Num a) => a -> a -> a -> a
multThree x y z = x * y * z

compareWithHundred :: (Num a, Ord a) => a -> Ordering
compareWithHundred x = compare 100 x

compareWithHundredNoneX :: (Num a, Ord a) => a -> Ordering
compareWithHundredNoneX = compare 100

divideByTen :: (Floating a) => a -> a
divideByTen = (/10)

--  Check is upperletter
isUpperAlphanum :: Char -> Bool
isUpperAlphanum = (`elem` ['A'..'Z'])

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]  
zipWith' _ [] _ = []  
zipWith' _ _ [] = []  
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

{-
Using where

myFlip :: (a -> b -> c) -> (b -> a -> c)
myFlip f = g
	where g x y = f y x
-}
myFlip :: (a -> b -> c) -> b -> a -> c
myFlip f x y = f y x

{-
	
	map (+3) [1,2,3] 

	[x + 3 | x <- [1,2,3]]

-}
myMap :: (a -> b) -> [a] -> [b]  
myMap _ [] = []  
myMap f (x:xs) = f x : myMap f xs