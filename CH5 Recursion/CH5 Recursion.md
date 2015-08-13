# Learning Haskell Ch5 - Recursion #

## 實作Maximum ##

`maximum` 函數取一組可排序的 List（屬於 Ord Typeclass） 做參數，並回傳其中的最大值。

處理單個元素的 List 時，回傳該元素。如果該 List 的頭部大於尾部的最大值，我們就可以假定較長的 List 的最大值就是它的頭部。而尾部若存在比它更大的元素，它就是尾部的最大值。

	maximum' :: (Ord a) => [a] -> a  
	maximum' [] = error "maximum of empty list"  
	maximum' [x] = x  
	maximum' (x:xs)   
	    | x > maxTail = x  
	    | otherwise = maxTail  
	    where maxTail = maximum' xs

改用 max 函數會使程式碼更加清晰。如果你還記得，max 函數取兩個值做參數並回傳其中較大的值。如下便是用 max 函數重寫的 `maximun'`

	maximum' :: (Ord a) => [a] -> a  
	maximum' [] = error "maximum of empty list"  
	maximum' [x] = x  
	maximum' (x:xs) = max x (maximum' xs)


## replicate  ##

它取一個 Int 值和一個元素做參數, 回傳一個包含多個重複元素的 List

replicate 3 5 回傳 [5,5,5]

	replicate' :: (Num i, Ord i) => i -> a -> [a]  
	replicate' n x  
	    | n <= 0    = []  
	    | otherwise = x:replicate' (n-1) x

## take ##

take 函數, 它可以從一個 List 取出一定數量的元素

	take' :: (Num i, Ord i) => i -> [a] -> [a]  
	take' n _  
	    | n <= 0   = []  
	take' _ []     = []  
	take' n (x:xs) = x : take' (n-1) xs

若要取零或負數個的話就會得到一個空 List. 同樣, 若是從一個空 List中取值, 它會得到一個空 List。

## reverse  ##

反轉List

	reverse' :: [a] -> [a]  
	reverse' [] = []  
	reverse' (x:xs) = reverse' xs ++ [x]

## repeat ##

repeat' :: a -> [a]  
repeat' x = x:repeat' x

## zip ##

zip 取兩個 List 作參數並將其捆在一起。zip [1,2,3] [2,3] 回傳 [(1,2),(2,3)]

zip' :: [a] -> [b] -> [(a,b)]  
zip' _ [] = []  
zip' [] _ = []  
zip' (x:xs) (y:ys) = (x,y):zip' xs ys

## elem ##

它取一個元素與一個 List 作參數, 並檢測該元素是否包含于此 List。

	myElem :: (Eq a)=> a -> [a] -> Bool
	myElem _ [] = False
	myElem e (x:xs) = if e == x then True else myElem e xs

**Second way**

	myElem :: (Eq a)=> a -> [a] -> Bool
	myElem _ [] = False
	myElem e (x:xs)
		| e == x = True
		| otherwise = myElem e xs

## 快速排序 ##

宣告

	quicksort :: (Ord a) => [a] -> [a]

邊界條件

	空List

定義演算法

>>排過序的 List 就是令所有小於等於頭部的元素在先(它們已經排過了序), 後跟大於頭部的元素(它們同樣已經拍過了序)

定義中有兩次排序，所以就得遞迴兩次！

**如何才能從 List 中取得比頭部小的那些元素呢？**

	quicksort :: (Ord a) => [a] -> [a]  
	quicksort [] = []  
	quicksort (x:xs) =  
	  let smallerSorted = quicksort [a | a <- xs, a <= x] 
	      biggerSorted = quicksort [a | a <- xs, a > x]  
	  in smallerSorted ++ [x] ++ biggerSorted


若給 [5,1,9,4,6,7,3] 排序，這個算法就會取出它的頭部，即 5。

將其置於分別比它大和比它小的兩個 List 中間，得 [1,4,3] ++ [5] ++ [9,6,7], 我們便知道了當排序結束之時，5會在第四位，因為有3個數比它小每，也有三個數比它大。

接着排 [1,4,3] 與 [9,6,7], 結果就出來了！對它們的排序也是使用同樣的函數，將它們分成許多小塊，最終到達臨界條件

## 遞迴思考 ##

**的固定模式：先定義一個邊界條件，再定義個函數，讓它從一堆元素中取一個並做點事情後，把餘下的元素重新交給這個函數。 **

>> 例如，sum 函數就是一個 List 頭部與其尾部的 sum 的和。一個 List 的積便是該 List 的頭與其尾部的積相乘的積，一個 List 的長度就是 1 與其尾部長度的和

再者就是邊界條件。一般而言，邊界條件就是為避免程序出錯而設置的保護措施，處理 List 時的邊界條件大部分都是空 List，而處理 Tree 時的邊界條件就是沒有子元素的節點。

使用遞迴來解決問題時應當先考慮遞迴會在什麼樣的條件下不可用, 然後再找出它的邊界條件和單位元, 考慮參數應該在何時切開(如對 List 使用模式匹配), 以及在何處執行遞迴.