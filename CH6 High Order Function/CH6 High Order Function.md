# Learning Haskell CH6 - High Order Function #

## Curried functions ##

Haskell 的所有函數都只有一個參數

所有多個參數的函數都是 Curried functions

執行 max 4 5 時，它會首先回傳一個取一個參數的函數，其回傳值不是 4 就是該參數，取決於誰大。

	ghci> max 4 5
	5
	ghci> (max 4) 5
	5

**此兩個方法相同**

把空格放到兩個東西之間，稱作*函數呼叫*。
它有點像個運算符，並擁有最高的優先順序。 

`max :: (Ord a) => a -> a -> a。 `

也可以寫作:

`max :: (Ord a) => a -> (a -> a)`。 

可以讀作 max 取一個參數 a，並回傳一個函數(就是那個 ->)，這個函數取一個 a 型別的參數，回傳一個a。 

這樣的好處又是如何? 簡言之，我們若以不全的參數來呼叫某函數，就可以得到一個*不全呼叫的函數*。 如果你高興，構造新函數就可以如此便捷，將其傳給另一個函數也是同樣方便。

	multThree :: (Num a) => a -> a -> a -> a
	multThree x y z = x * y * z

我們若執行 mulThree 3 5 9 或 ((mulThree 3) 5) 9，它背後是如何運作呢？ 首先，按照空格分隔，把 3 交給 mulThree。 這回傳一個回傳函數的函數。 然後把 5 交給它，回傳一個取一個參數並使之乘以 15 的函數。 最後把 9 交給這一函數，回傳 135。

這個函數的型別也可以寫作 `multThree :: (Num a) => a -> (a -> (a -> a))`，`->` 前面的東西就是函數取的參數，後面的東西就是其回傳值。所以說，我們的函數取一個 a，並回傳一個型別為 `(Num a) => a -> (a -> a)` 的函數，類似，這一函數回傳一個取一個 a，回傳一個型別為 `(Num a) => a -> a` 的函數。 而最後的這個函數就只取一個 a 並回傳一個 a

	ghci> let multTwoWithNine = multThree 9
	ghci> multTwoWithNine 2 3
	54
	ghci> let multWithEighteen = multTwoWithNine 2
	ghci> multWithEighteen 10
	180

**以不全的參數呼叫函數可以方便地創造新的函數**

取一數與 100 比較大小的函數該如何?

	compareWithHundred :: (Num a, Ord a) => a -> Ordering
	compareWithHundred x = compare 100 x

注意下在等號兩邊都有 x。 想想 compare 100 會回傳什麼？一個取一數與 100 比較的函數。這樣重寫:

	compareWithHundred :: (Num a, Ord a) => a -> Ordering
	compareWithHundred = compare 100

型別聲明依然相同，因為 compare 100 回傳函數。compare 的型別為 `(Ord a) => a -> (a -> Ordering)`，用 100 呼叫它後回傳的函數型別為 `(Num a, Ord a) => a -> Ordering`

**中綴函數也可以不全呼叫，用括號把它和一邊的參數括在一起就行了。**

這回傳一個取一參數並將其補到缺少的那一端的函數。

	divideByTen :: (Floating a) => a -> a
	divideByTen = (/10)

**呼叫 divideByTen 200 就是 (/10) 200，和 200 / 10 等價。**

### 一個檢查字元是否為大寫的函數: ###

	isUpperAlphanum :: Char -> Bool
	isUpperAlphanum = (`elem` ['A'..'Z'])

唯一的例外就是 `-` 運算符，按照前面提到的定義，(-4) 理應回傳一個並將參數減 4 的函數，而實際上，處于計算上的方便，(-4) 表示負 4。 若你一定要弄個將參數減 4 的函數，就用`subtract` 好了，像這樣 (`subtract 4`).

若不用 `let` 給它命名或傳到另一函數中，在 ghci 中直接執行 `multThree 3 4` 會怎樣?

	ghci> multThree 3 4
	:1:0:
	No instance for (Show (t -> t))
	arising from a use of `print' at :1:0-12
	Possible fix: add an instance declaration for (Show (t -> t))
	In the expression: print it
	In a 'do' expression: print it

>> ghci 說，這一表達式回傳了一個 a -> a 型別的函數，但它不知道該如何顯示它。
> 
>>函數不是 Show 型別類的實例，所以我們不能得到表示一函數內容的字串。 
>
>>若在 ghci 中計算 1+1，它會首先計算得 2，然後呼叫 show 2 得到該數值的字串表示，即 "2"，再輸出到屏幕.

## 高階函式 ##

Haskell 中函式可以取另一函式為參數，也可以做為回傳值。

**取一個函數並呼叫它兩次的函數**

	applyTwice :: (a -> a) -> a -> a  
	applyTwice f x = f (f x)

Run : 

	ghci> applyTwice (+3) 10  
	16  
	ghci> applyTwice (++ " HAHA") "HEY"  
	"HEY HAHA HAHA"  
	ghci> applyTwice ("HAHA " ++) "HEY"  
	"HAHA HAHA HEY"  
	ghci> applyTwice (multThree 2 2) 9  
	144  
	ghci> applyTwice (3:) [1]  
	[3,3,1]

### 實作zipWith ###

它取一個函數和兩個 List 做參數，並把兩個 List 交到一起(使相應的元素去呼叫該函數)
	
	zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]  
	zipWith' _ [] _ = []  
	zipWith' _ _ [] = []  
	zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

Run 

	ghci> zipWith' (+) [4,2,5,6] [2,6,2,3]  
	[6,8,7,9]  
	ghci> zipWith' max [6,3,2,1] [7,3,1,5]  
	[7,3,2,5]  
	ghci> zipWith' (++) ["foo "，"bar "，"baz "] ["fighters"，"hoppers"，"aldrin"]  
	["foo fighters","bar hoppers","baz aldrin"]  
	ghci> zipWith' (*) (replicate 5 2) [1..]  
	[2,4,6,8,10]  
	ghci> zipWith' (zipWith' (*)) [[1,2,3],[3,5,6],[2,3,4]] [[3,2,2],[3,4,5],[5,4,3]]  
	[[3,4,6],[9,20,30],[10,12,12]]

## Map and Filter ##

`map` 取一個函數和 List 做參數，遍歷該 List 的每個元素來呼叫該函數產生一個新的 List。

	map :: (a -> b) -> [a] -> [b]  
	map _ [] = []  
	map f (x:xs) = f x : map f xs

取一個**取 a 回傳 b 的函數**和**一組 a 的 List**，並**回傳一組 b**。

	ghci> map (+3) [1,5,3,1,6]  
	[4,8,6,4,9]  
	ghci> map (++ "!") ["BIFF"，"BANG"，"POW"]  
	["BIFF!","BANG!","POW!"]  
	ghci> map (replicate 3) [3..6]  
	[[3,3,3],[4,4,4],[5,5,5],[6,6,6]]  
	ghci> map (map (^2)) [[1,2],[3,4,5,6],[7,8]]  
	[[1,4],[9,16,25,36],[49,64]]  
	ghci> map fst [(1,2),(3,5),(6,3),(2,6),(2,5)]  
	[1,3,6,2,2]

`filter` 函數**取一個限制條件**和**一個 List**，**回傳該 List 中所有符合該條件的元素**。

	filter :: (a -> Bool) -> [a] -> [a]  
	filter _ [] = []  
	filter p (x:xs)   
	    | p x       = x : filter p xs  
	    | otherwise = filter p xs

Run

	ghci> filter (>3) [1,5,3,2,1,6,4,3,2,1]  
	[5,6,4]  
	ghci> filter (==3) [1,2,3,4,5]  
	[3]  
	ghci> filter even [1..10]  
	[2,4,6,8,10]  
	ghci> let notNull x = not (null x) in filter notNull [[1,2,3],[],[3,4,5],[2,2],[],[],[]]  
	[[1,2,3],[3,4,5],[2,2]]  
	ghci> filter (`elem` ['a'..'z']) "u LaUgH aT mE BeCaUsE I aM diFfeRent"  
	"uagameasadifeent"  
	ghci> filter (`elem` ['A'..'Z']) "i lauGh At You BecAuse u r aLL the Same"  
	"GAYBALLS"

以上都可以用 List Comprehension 的限制條件來實現。

如果有多個限制條件，只能連着套好幾個 filter 或用 && 等邏輯函數的組合之，這時就不如 List comprehension 來得爽了。

### quicksort  ###

我們用到了 List Comprehension 來過濾大於或小於錨的元素。 換做 filter 也可以實現，而且更加易讀

	quicksort :: (Ord a) => [a] -> [a]    
	quicksort [] = []    
	quicksort (x:xs) =     
	    let smallerSorted = quicksort (filter (<=x) xs)
	        biggerSorted = quicksort (filter (>x) xs)   
	    in  smallerSorted ++ [x] ++ biggerSorted

### 找出小於 100000 的 3829 的所有倍數 ###

	largestDivisible :: (Integral a) => a  
	largestDivisible = head (filter p [100000,99999..])  
	    where p x = x `mod` 3829 == 0

### 找出所有小於 10000 的奇數的平方和 ###

`takeWhile` 函數，它取一個限制條件和 List 作參數，然後從頭開始遍歷這一 List，並回傳符合限制條件的元素。而一旦遇到不符合條件的元素，它就停止了。 

如果我們要取出字串` "elephants know how to party"` 中的首個單詞，可以 `takeWhile (/=' ') "elephants know how to party"`，回傳 `"elephants"`。


要求所有小於 10000 的奇數的平方的和，首先就用 (^2) 函數 map 掉這個無限的 List [1..] 。然後過濾之，只取奇數就是了。 在大於 10000 處將它斷開，最後前面的所有元素加到一起。 

首先就用 (^2) 函數 map 掉這個無限的 List [1..] 。然後過濾之，只取奇數就是了。 在大於 10000 處將它斷開，最後前面的所有元素加到一起。

	ghci> sum (takeWhile (<10000) (filter odd (map (^2) [1..])))  
	166650

 **先從幾個初始數據(表示所有自然數的無限 List)，再 map 它，filter 它，切它，直到它符合我們的要求，再將其加起來。**

*List comprehension *

	ghci> sum (takeWhile (<10000) [m | m <- [n^2 | n <- [1..]], odd m])  
	166650

### 以 1 到 100 之間的所有數作為起始數，會有多少個鏈的長度大於 15 ###

問題與 Collatz 序列有關，取一個自然數，若為偶數就除以 2。 

若為奇數就乘以 3 再加 1。 再用相同的方式處理所得的結果，得到一組數字構成的的鏈。

它有個性質，無論任何以任何數字開始，最終的結果都會歸 1。

所以若拿 13 當作起始數，就可以得到這樣一個序列 13，40，20，10，5，16，8，4，2，1。13*3+1 得 40，40 除 2 得 20，如是繼續，得到一個 10 個元素的鏈。

	chain :: (Integral a) => a -> [a]  
	chain 1 = [1]  
	chain n  
	    | even n =  n:chain (n `div` 2)  
	    | odd n  =  n:chain (n*3 + 1)

Run 

	ghci> chain 10  
	[10,5,16,8,4,2,1]  
	ghci> chain 1  
	[1]  
	ghci> chain 30  
	[30,15,46,23,70,35,106,53,160,80,40,20,10,5,16,8,4,2,1]

這個函數來告訴我們結果

	numLongChains :: Int  
	numLongChains = length (filter isLong (map chain [1..100]))  
	    where isLong xs = length xs > 15

我們把 chain 函數 map 到 [1..100]，得到一組鏈的 List，然後用個限制條件過濾長度大於 15 的鏈。過濾完畢後就可以得出結果list中的元素個數.

我們還只是 map 單參數的函數到 List，如 map (*2) [0..] 可得一組型別為 (Num a) => [a] 的 List，而 map (*) [0..] 也是完全沒問題的。* 的型別為 (Num a) => a -> a -> a，用單個參數呼叫二元函數會回傳一個一元函數。如果用 * 來 map 一個 [0..] 的 List，就會得到一組一元函數組成的 List，即 (Num a) => [a->a]。map (*) [0..] 所得的結果寫起來大約就是 [(0*),(1*),(2*)..]


	ghci> let listOfFuns = map (*) [0..]  
	ghci> (listOfFuns !! 4) 5  
	20

取所得 List 的第四個元素可得一函數，與 (*4) 等價。 然後用 5 呼叫它，與 (* 4) 5 或 4*5 都是等價的.