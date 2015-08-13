# Learning Haskell CH6 - High Order Function #

## Curried functions ##

Haskell 的所有函數都只有一個參數

所有多個參數的函數都是 Curried functions

執行 max 4 5 時，它會首先回傳一個取一個參數的函數，其回傳值不是 4 就是該參數，取決於誰大。

	ghci> max 4 5
	5
	ghci> (max 4) 5
	5

把空格放到兩個東西之間，稱作函數呼叫。
它有點像個運算符，並擁有最高的優先順序。 

`max :: (Ord a) => a -> a -> a。 `

也可以寫作:

 `max :: (Ord a) => a -> (a -> a)`。 
