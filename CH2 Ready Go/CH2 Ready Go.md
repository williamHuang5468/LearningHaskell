# Learning Haskell Ch2 - Introduction #

Open the command line

	ghci

You will see the blow.

	prelude>

You can using the command

	:set promt "ghci>"
	the name will modify to be "ghci"

## Simple Code ##

	ghci> 2 + 15
	17
	ghci> 49 * 100
	4900
	ghci> 1892 - 1472
	420
	ghci> 5 / 2
	2.5
	ghci>

Notice

	ghci> 5 * -3

	<interactive>:49:1:
	    Precedence parsing error cannot mix ‘*’ [infixl 7] and prefix `-' [infixl 6] in the same infix expression 

You need using "()"

	ghci> 5 * (-3)
	-15

## Boolean Algebra ##

You can using the keywords.
	
	&&(AND)
	||(OR)
	not
	True
	False

You can't use:
	Not
	true
	false

Example:

	ghci> True && False
	False
	ghci> True && True
	True
	ghci> False || True
	True
	ghci> not False
	True
	ghci> not (True && True)
	False

### Equals ###

	ghci> 5 == 5
	True
	ghci> 1 == 0
	False
	ghci> 5 /= 5
	False
	ghci> 5 /= 4
	True
	ghci> "hello" == "hello"
	True

Notice:

If i input the 5-"asdf" or 5 == True, will get:

	ghci> 5-"asdf"
	
	<interactive>:70:2:
	    No instance for (Num [Char]) arising from a use of ‘-’
	    In the expression: 5 - "asdf"
	    In an equation for ‘it’: it = 5 - "asdf"

	ghci> 5 == True
	
	<interactive>:71:1:
	    No instance for (Num Bool) arising from the literal ‘5’
	    In the first argument of ‘(==)’, namely ‘5’
	    In the expression: 5 == True
	    In an equation for ‘it’: it = 5 == True

The number can be compute. 

	ghci> 4+5.0
	9.0

### Using Method ###

	ghci> min 9 10
	9
	ghci> min 3.4 3.2
	3.2
	ghci> max 100 101
	101

前綴函數

中綴函數的形式呼叫，使用" ` "

	ghci> 92 `div` 10
	9
	ghci> 92 div 10
	
	<interactive>:83:1:
	    Could not deduce (Num ((a0 -> a0 -> a0) -> a1 -> t))
	      arising from the ambiguity check for ‘it’
	    from the context (Num ((a -> a -> a) -> a2 -> t),
	                      Num a2,
	                      Integral a)
	      bound by the inferred type for ‘it’:
	                 (Num ((a -> a -> a) -> a2 -> t), Num a2, Integral a) => t
	      at <interactive>:83:1-9
	    The type variables ‘a0’, ‘a1’ are ambiguous
	    When checking that ‘it’
	      has the inferred type ‘forall a a1 t.
	                             (Num ((a -> a -> a) -> a1 -> t), Num a1, Integral a) =>
	                             t’
	    Probable cause: the inferred type is ambiguous

### Condiction ###

**在if條件中，else是必要的。**
 
	doubleSmallNumber x = if x > 100
	                      then x
	                      else  x*2

加一

	doubleSmallNumber' x = (if x > 100 then x else x*2) + 1

解釋

>> 函式 參數(x)，如果 X 大於 一百，回傳X，否則回傳兩倍的X

沒有參數的函式，固定回傳值

	conanO'Brien = "It's a-me, Conan O'Brien!"

**Notice**

	開頭大寫是不允許的，內建型別是用大寫開頭做辨別，如果自己也用會搞混。

## List入門 ##

介紹 List，字串和 list comprehension。

>> List 是一種單型別的資料結構，可以用來存儲多個型別相同的元素。

我們可以在裡面裝一組數字或者一組字元，但不能把字元和數字裝在一起。

>> *Note*: 在 ghci 下，我們可以使用 ``let`` 關鍵字來定義一個常數。在 ghci 下執行 ``let a=1`` 與在腳本中編寫 ``a=1`` 是等價的。

	ghci> let lostNumbers = [4,8,15,16,23,48]  
	ghci> lostNumbers  
	[4,8,15,16,23,48]

`"Hello" == ['H', 'e', 'l', 'l', 'o']`

用``++``將兩List合併

	ghci> [1,2,3,4] ++ [9,10,11,12]  
	[1,2,3,4,9,10,11,12]  
	ghci> "hello" ++ " " ++ "world"  
	"hello world"  
	ghci> ['w','o'] ++ ['o','t']  
	"woot"

使用``++``會走遍左側的List，當左側的List量大到一定程度會有緩慢問題

大量運算``++``會有緩慢的情況發生

### 使用`:` 連接單個元素###

	ghci> 'A':" SMALL CAT"  
	"A SMALL CAT"  
	ghci> 5:[1,2,3,4,5] 
	[5,1,2,3,4,5]

explain
	
	[5,1,2] = [5] : [1] : [2]
	

>>*Note*: ``[],[[]],[[],[],[]]`` 是不同的。
>>
>>第一個是一個空的 List，
>
>>第二個是含有一個空 List 的 List，
>
>>第三個是含有三個空 List 的 List。

### `!!` ，按照索引取得 List 中的元素 ###

	ghci> "Steve Buscemi" !! 6  
	'B'  
	ghci> [9.4,33.2,96.2,11.2,23.25] !! 1  
	33.2

### List 包List ###

	ghci> let b = [[1,2,3,4],[5,3,3,3],[1,2,2,3,4],[1,2,3]]
	ghci> b
	[[1,2,3,4],[5,3,3,3],[1,2,2,3,4],[1,2,3]]
	ghci> b ++ [[1,1,1,1]]
	[[1,2,3,4],[5,3,3,3],[1,2,2,3,4],[1,2,3],[1,1,1,1]]
	ghci> [6,6,6]:b
	[[6,6,6],[1,2,3,4],[5,3,3,3],[1,2,2,3,4],[1,2,3]]
	ghci> b !! 2
	[1,2,2,3,4]

**List 中的 List 可以是不同長度，但必須得是相同的型別。**

當 List 內裝有可比較的元素時，使用 > 和 >= 可以比較 List 的大小。它會先比較第一個元素，若它們的值相等，則比較下一個，以此類推。

	ghci> [3,2,1] > [2,1,0]  
	True  
	ghci> [3,2,1] > [2,10,100]  
	True  
	ghci> [3,4,2] > [3,4]  
	True  
	ghci> [3,4,2] > [2,4]  
	True  
	ghci> [3,4,2] == [3,4,2]  
	True

### 其他List功能 ###

``head`` 回傳List的頭

	ghci> head [5,4,3,2,1] 
	5

``tail`` 回傳List的尾(去除頭的部分)

	ghci> tail [5,4,3,2,1]  
	[4,3,2,1]

``last`` 回傳最後一個元素

	ghci> last [5,4,3,2,1]
	1

``init`` 去除最後一個元素的部分
	
	ghci> init [5,4,3,2,1]
	[5,4,3,2]

>> Notice: 對空的List取``head``

	ghci> head []  
	*** Exception: Prelude.head: empty list

``length`` 取長度

	ghci> length [5,4,3,2,1]  
	5

``null`` 檢查是否為空
	
	ghci> null [1,2,3]  
	False  
	ghci> null []  
	True

``reverse`` 反轉List

	ghci> reverse [5,4,3,2,1]  
	[1,2,3,4,5]

``take`` 回傳List的前幾個元素

	ghci> take 3 [5,4,3,2,1]  
	[5,4,3]  
	ghci> take 1 [3,9,3]  
	[3]  
	ghci> take 5 [1,2]  
	[1,2]  
	ghci> take 0 [6,6,6] 
	[]

**若是圖取超過 List 長度的元素個數，只能得到原 List。**
``take`` 0 個元素，則會得到一個空 List！

``drop`` 和take相反，刪除List前幾個元素

	ghci> drop 3 [8,4,2,1,5,6]  
	[1,5,6]  
	ghci> drop 0 [1,2,3,4]  
	[1,2,3,4]  
	ghci> drop 100 [1,2,3,4]  
	[]

`maximum` 回傳List中最大的元素 ; `minimum `回傳最小

``sum`` 回傳List中值的總和 ; `product`回傳List中所有元素的積

	ghci> sum [5,2,1,6,3,2,5,7]  
	31  
	ghci> product [6,2,1,2]  
	24  
	ghci> product [1,2,5,6,7,9,2,0]  
	0

`elem` 判斷元素是否在List中，長以中綴方式出現

	ghci> 4 `elem` [3,4,5,6]  
	True  
	ghci> 10 `elem` [3,4,5,6]  
	False

## 使用Range ##

取得1~20值的List，使用Range

	[1..20]

Example:

	ghci> [1..20]
	[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
	ghci> ['a'..'z']
	"abcdefghijklmnopqrstuvwxyz"
	ghci> ['K'..'Z']  
	"KLMNOPQRSTUVWXYZ"

每次跨多一點值

	ghci> [2,4..20]
	[2,4,6,8,10,12,14,16,18,20]
	ghci> [3,6..20]
	[3,6,9,12,15,18]

憑藉前兩項判斷步數

要得到 20 到 1 的 List，[20..1] 是不可以的。

必須得 ``[20,19..1]``。 

**在 Range 中使用浮點數要格外小心！出於定義的原因，浮點數並不精確。若是使用浮點數的話，你就會得到如下的糟糕結果**

	ghci> [0.1, 0.3 .. 1]
	[0.1,0.3,0.5,0.7,0.8999999999999999,1.0999999999999999]

**避免在 Range 中使用浮點數。**

你也可以不標明 Range 的上限

取前 24 個 13 的倍數該怎樣？恩，你完全可以 [13,26..24*13]，但有更好的方法： 

	take 24 [13,26..]

`cycle` 生成無限 List，接受一個 List 做參數並返回一個無限 List

	ghci> take 10 (cycle [1,2,3])
	[1,2,3,1,2,3,1,2,3,1]
	ghci> take 12 (cycle "LOL ")
	"LOL LOL LOL "

`repeat` 接受一個值作參數，並返回一個僅包含該值的無限 List。

	ghci> take 10 (repeat 5)
	[5,5,5,5,5,5,5,5,5,5]

`replicate` 取得相同元素的List

	ghci> replicate 3 10
	[10,10,10] 

## List Comprehension ##

	ghci> [x*2 | x <- [1..10]]
	[2,4,6,8,10,12,14,16,18,20]

給這個 comprehension 再添個限制條件(predicate)

	要求只取乘以 2 後大於等於 12 的元素。

Code 

	ghci> [x*2 | x <- [1..10], x*2 >= 12]
	[12,14,16,18,20]

	[Result | x <- Range, Condiction]

取 50 到 100 間所有除7的餘數為 3 的元素

	ghci> [ x | x <- [50..100], x `mod` 7 == 3]
	[52,59,66,73,80,87,94]

### filter ###

從一個 List 中篩選出符合特定限制條件的操作

List 中所有大於 10 的奇數變為 "BANG"，小於 10 的奇數變為 "BOOM"，其他則統統扔掉。方便重用起見，我們將這個 comprehension 置於一個函數之中。

	boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

	ghci> boomBangs [7..13]
	["BOOM!","BOOM!","BANG!","BANG!"]

**加多個限制條件。若要達到 10 到 20 間所有不等於 13，15 或 19 的數**

	ghci> [ x | x <- [10..20], x /= 13, x /= 15, x /= 19]
	[10,11,12,14,16,17,18,20]

多個 List 中取元素

在不過濾的前提 下，取自兩個長度為 4 的集合的 comprehension 會產生一個長度為 16 的 List。假設有兩個 List，`[2,5,10]` 和 `[8,10,11]`， 要取它們所有組合的積

	ghci> [ x*y | x <- [2,5,10], y <- [8,10,11]]
	[16,20,22,40,50,55,80,100,110]

概念

	x*y | x = [] , y = []

只取大於`50`的結果

	ghci> [ x*y | x <- [2,5,10], y <- [8,10,11], x*y > 50]
	[55,80,100,110]

### Self defination ###

	let length xs = sum [1 | _ <- xs]

Code:

	ghci> length "Hello"
	5
	ghci> length ""
	0

Explain:

`_` 匿名，表示不關心值是多少，與其用一個永遠不用的變數，不如用一個`_`

`1` 表示你不在乎值是多少，都為1 

### 自訂 除去字串中所有非大寫字母的函數 ###

	removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

Example 

	ghci> removeNonUppercase "Hahaha! Ahahaha!"
	"HA"
	ghci> removeNonUppercase "IdontLIKEFROGS"
	"ILIKEFROGS"

**有個包含許多數值的 List 的 List，讓我們在不拆開它的前提下除去其中的所有奇數**

	ghci> let xxs = [[1,3,5,2,3,1,2,4,5],[1,2,3,4,5,6,7,8,9],[1,2,4,2,1,6,3,1,3,2,3,6]]
	ghci> [ [ x | x <- xs, even x ] | xs <- xxs]
	[[2,2,4],[2,4,6,8],[2,4,2,6,2,6]]

##Tuple

Tuple (元組)很像 List --都是將多個值存入一個個體的容器。

但它們卻有着本質的不同，一組數字的 List 就是一組數字，它們的型別相同，且不關心其中包含元素的數量。

而 Tuple 則要求你對需要組合的數據的數目非常的明確，它的型別取決於其中項的數目與其各自的型別。

Tuple 中的項由括號括起，並由逗號隔開。

**另外的不同之處就是 Tuple 中的項不必為同一型別**，在 Tuple 裡可以存入多型別項的組合。

`fst` 回傳tuple的首項

	ghci> fst (8,11)
	8
	ghci> fst ("Wow", False)
	"Wow"

`snd` 回傳tuple的尾項

	ghci> snd (8,11)
	11
	ghci> snd ("Wow", False)
	False

>> *Note*：這兩個函數僅對序對有效，而不能應用於三元組，四元組和五元組之上。稍後，我們將過一遍從 Tuple 中取數據的所有方式。

`zip` 用來生成一組序對 (Pair) 的 List。它取兩個 List，然後將它們交叉配對，形成一組序對的 List

### 你需要組合或是遍歷兩個 List ###
	
	ghci> zip [1,2,3,4,5] [5,5,5,5,5]
	[(1,5),(2,5),(3,5),(4,5),(5,5)]
	ghci> zip [1 .. 5] ["one", "two", "three", "four", "five"]
	[(1,"one"),(2,"two"),(3,"three"),(4,"four"),(5,"five")]

不同類型
	
	ghci> zip [5,3,2,6,2,7,2,5,4,6,6] ["im","a","turtle"]
	[(5,"im"),(3,"a"),(2,"turtle")]

無限

	ghci> zip [1..] ["apple", "orange", "cherry", "mango"]
	[(1,"apple"),(2,"orange"),(3,"cherry"),(4,"mango")]

如何取得所有三邊長度皆為整數且小於等於 10，周長為 24 的直角三角形？

首先，把所有三遍長度小於等於 10 的三角形都列出來：

	ghci> let triangles = [ (a,b,c) | c <- [1..10], b <- [1..10], a <- [1..10] ]

剛才我們是從三個 List 中取值，並且通過輸出函數將其組合為一個三元組。只要在 ghci 下邊呼叫 triangle，你就會得到所有三邊都小於等於 10 的三角形。我們接下來給它添加一個限制條件，令其必須為直角三角形。同時也考慮上 b 邊要短於斜邊，a 邊要短於 b 邊情況

	ghci> let rightTriangles = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2]

最後修改函數，告訴它只要周長為 24 的三角形。

	ghci> let rightTriangles' = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2, a+b+c == 24]
	ghci> rightTriangles'
	[(6,8,10)]