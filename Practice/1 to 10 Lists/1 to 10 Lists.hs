--  Problem 1
{-|
	(*) Find the last element of a list.
	Prelude> myLast [1,2,3,4]
	4
	Prelude> myLast ['x','y','z']
	'z'
-}
myLast :: [a] -> a
myLast [] = error "empty list"
myLast element = element !! ((length element)-1)
--  using myLast f:l = f

--  Problem 2
{-|
	(*) Find the last but one element of a list.
	Prelude> myButLast [1,2,3,4]
	3
	Prelude> myButLast ['a'..'z']
	'y'
-}

myButLast :: [a] -> a
myButLast [] = error "empty list"
myButLast [a] = error "just only element"
myButLast element = element !! ((length element)-2)

--  Problem 3
{-|
	(*) Find the K'th element of a list. The first element in the list is number 1.
	Prelude> elementAt [1,2,3] 2
	2
	Prelude> elementAt "haskell" 5
	'e'
-}

elementAt :: [a]-> Int -> a
elementAt [] _ = error "empty list"
elementAt [a] _ = error "just only element"
elementAt element number = element !! (number-1)

--  Problem 4
{-|
	(*) Find the number of elements of a list.
	Prelude> myLength [123, 456, 789]
	3
	Prelude> myLength "Hello, world!"
	13
-}

myLength :: [a] -> Int
myLength [] = 0
myLength (x:xs) = 1 + myLength xs

--  Problem 5
{-|
	(*) Reverse a list.
	Prelude> myReverse "A man, a plan, a canal, panama!"
	"!amanap ,lanac a ,nalp a ,nam A"
	Prelude> myReverse [1,2,3,4]
	[4,3,2,1]
-}

--  Problem 6
{-|
	(*) Find out whether a list is a palindrome. A palindrome can be read forward or backward; e.g. (x a m a x).
	*Main> isPalindrome [1,2,3]
	False
	*Main> isPalindrome "madamimadam"
	True
	*Main> isPalindrome [1,2,4,8,16,8,4,2,1]
	True
-}

--  Problem 7
{-|
	(**) Flatten a nested list structure.
	Transform a list, possibly holding lists as elements into a `flat' list by replacing each list with its elements (recursively).
	
	* (my-flatten '(a (b (c d) e)))
	(A B C D E)

	 data NestedList a = Elem a | List [NestedList a]
	*Main> flatten (Elem 5)
	[5]
	*Main> flatten (List [Elem 1, List [Elem 2, List [Elem 3, Elem 4], Elem 5]])
	[1,2,3,4,5]
	*Main> flatten (List [])
	[]
-}

--  Problem 8
{-|
	(**) Eliminate consecutive duplicates of list elements.
	If a list contains repeated elements they should be replaced with a single copy of the element. The order of the elements should not be changed.

	* (compress '(a a a a b c c a a d e e e e))
	(A B C A D E)

	compress "aaaabccaadeeee"
	"abcade"
-}

--  Problem 9
{-|
	(**) Pack consecutive duplicates of list elements into sublists. If a list contains repeated elements they should be placed in separate sublists.

	* (pack '(a a a a b c c a a d e e e e))
((A A A A) (B) (C C) (A A) (D) (E E E E))

	*Main> pack ['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 
             'a', 'd', 'e', 'e', 'e', 'e']
	["aaaa","b","cc","aa","d","eeee"]
-}

--  Problem 10
{-|
	(*) Run-length encoding of a list. Use the result of problem P09 to implement the so-called run-length encoding data compression method. Consecutive duplicates of elements are encoded as lists (N E) where N is the number of duplicates of the element E.

	* (encode '(a a a a b c c a a d e e e e))
	((4 A) (1 B) (2 C) (2 A) (1 D)(4 E))
	
	encode "aaaabccaadeeee"
	[(4,'a'),(1,'b'),(2,'c'),(2,'a'),(1,'d'),(4,'e')]
-}
