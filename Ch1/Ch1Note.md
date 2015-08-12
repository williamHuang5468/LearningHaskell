# Learning Haskell Ch1 - Introduction #

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

沒有參數的函式，固定回傳值

	conanO'Brien = "It's a-me, Conan O'Brien!"

**Notice**

	開頭大寫是不允許的

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