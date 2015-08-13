
myMaximum :: (Ord a) =>[a] -> a  
myMaximum [] = error "maximum of empty list"  
myMaximum [x] = x
myMaximum (x:xs)
	| x > maxTail = x
	| otherwise =maxTail
	where maxTail = myMaximum xs

{-

myMaximum (x:xs)
		| x > myMaximum xs = x
		| otherwise = myMaximum xs

-}

myReplicate :: Int -> a -> [a]
myReplicate n x
	| n <= 0  = []
	| otherwise = x:myReplicate (n-1) x

myTake :: Int -> [a] -> [a]
myTake n _
	| n <= 0 = []
myTake _ [] = []
myTake n (x:xs) = x:myTake (n-1) xs

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

myRepeat :: a -> [a]
myRepeat x = x:myRepeat x

myZip :: [a]-> [b] -> [(a,b)]
myZip _ [] = []
myZip [] _ = []
myZip (x:xs) (y:ys) = (x,y):zip xs ys

myElem :: (Eq a)=> a -> [a] -> Bool
myElem _ [] = False
myElem e (x:xs) = if e == x then True else myElem e xs

{-
Second way

myElem :: (Eq a)=> a -> [a] -> Bool
myElem _ [] = False
myElem e (x:xs)
	| e == x = True
	| otherwise = myElem e xs
-}

quicksort :: (Ord a) => [a] -> [a]  
quicksort [] = []  
quicksort (x:xs) =  
  let smallerSorted = quicksort [a | a <- xs, a <= x] 
      biggerSorted = quicksort [a | a <- xs, a > x]  
  in smallerSorted ++ [x] ++ biggerSorted