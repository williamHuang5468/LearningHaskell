# Learning Haskell Ch4 - 函數的語法 #

## Pattern matching ##

**檢查我們傳給它的數字是不是 7。**

	lucky :: (Integral a) => a -> String  
	lucky 7 = "LUCKY NUMBER SEVEN!"  
	lucky x = "Sorry, you're out of luck, pal!"

用If辦到判別

	sayMe :: (Integral a) => a -> String  
	sayMe 1 = "One!"  
	sayMe 2 = "Two!"  
	sayMe 3 = "Three!"  
	sayMe 4 = "Four!"  
	sayMe 5 = "Five!"  
	sayMe x = "Not between 1 and 5"

>>Notice:如果`sayMe x = "Not between 1 and 5"`放到前面，就會所有都是`sayMe x = "Not between 1 and 5"`

遞迴Factorial

	factorial :: (Integral a) => a -> a  
	factorial 0 = 1  
	factorial n = n * factorial (n - 1)

如果給3

計算步驟：先計算 `3*factorial 2`，`factorial 2` 等於 `2*factorial 1`，也就是 `3*(2*(factorial 1))`。`factorial 1` 等於 `1*factorial 0`

**失敗的模式匹配**

當你的模式沒有涵蓋到所有情況

	charName :: Char -> String  
	charName 'a' = "Albert"  
	charName 'b' = "Broseph"  
	charName 'c' = "Cecil"

例子中:只要不是a,b,c就會失敗

	ghci> charName 'a'  
	"Albert"  
	ghci> charName 'b'  
	"Broseph"  
	ghci> charName 'h'  
	"*** Exception: tut.hs:(53,0)-(55,21): Non-exhaustive patterns in function charName

**對Tuple的匹配**

**二維空間中的向量相加**

還不瞭解模式匹配的解法

	addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)  
	addVectors a b = (fst a + fst b, snd a + snd b)

模式匹配的解法

	addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)  
	addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

`fst` 和 `snd` 可以從序對中取出元素。三元組 (Tripple) 呢？嗯，沒現成的函數，得自己動手：

	first :: (a, b, c) -> a  
	first (x, _, _) = x  
	
	second :: (a, b, c) -> b  
	second (_, y, _) = y  
	
	third :: (a, b, c) -> c  
	third (_, _, z) = z

`_`表示我們不關心具體內容

在List Comprehension使用模式匹配

	ghci> let xs = [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)]  
	ghci> [a+b | (a,b) <- xs]  
	[4,7,6,8,11,4]

一旦模式匹配失敗，它就簡單挪到下個元素。

對 List 本身也可以使用模式匹配。你可以用 `[]` 或 `:` 來匹配它。因為 `[1,2,3] `本質就是 `1:2:3:[]` 的語法糖。

你也可以使用前一種形式，像 `x:xs` 這樣的模式可以將 List 的頭部綁定為 x，尾部綁定為 xs。

如果這 List 只有一個元素，那麼 xs 就是一個空 List。

>>*Note*：``x:xs`` 這模式的應用非常廣泛，尤其是遞迴函數。**不過它只能匹配長度大於等於 1 的 List。**

**如果你要把 List 的前三個元素都綁定到變數中，可以使用類似 `x:y:z:xs` 這樣的形式。它只能匹配長度大於等於 3 的 List。**

自行實作`head`變數

	head :: [a] -> a  
	head [] = error "Can't call head on an empty list, dummy!"  
	head (x:_) = x

Run 

	ghci> head' [4,5,6]  
	4  
	ghci> head' "Hello"  
	'H'

>> 若要綁定多個變數(用 `_` 也是如此)，我們必須用括號將其括起

>> `error` 函數，它可以生成一個運行時錯誤，用參數中的字串表示對錯誤的描述。它會直接導致程序崩潰，因此應謹慎使用。

用模式匹配實作`length`

	length' :: (Num b) => [a] -> b  
	length' [] = 0  
	length' (_:xs) = 1 + length' xs

先定義好未知輸入的結果 --- 空 List

在第二個模式中將這 List 分割為頭部和尾部。

List 的長度就是其尾部的長度加 1。匹配頭部用的 _，因為我們並不關心它的值。同時也應明確，我們顧及了 List 所有可能的模式：第一個模式匹配空 List，第二個匹配任意的非空 List。

解釋:

用"ham" 呼叫 length。

首先它會檢查它是否為空 List。顯然不是，於是進入下一模式。

它匹配了第二個模式，把它分割為頭部和尾部並無視掉頭部的值，得長度就是 1+length' "am"。

以此類推，"am" 的 length 就是 1+length' "m"。好，現在我們有了 1+(1+length' "m")。

length' "m" 即 1+length "" (也就是 1+length' [] )。根據定義，length' [] 等於 0。最後得 1+(1+(1+0))。

用模式匹配實作`sum`

	sum' :: (Num a) => [a] -> a  
	sum' [] = 0  
	sum' (x:xs) = x + sum' xs

我們知道空 List 的和是 0，就把它定義為一個模式。我們也知道一個 List 的和就是頭部加上尾部的和的和。

**`as`模式**

將一個名字和 @ 置於模式前，可以在按模式分割什麼東西時仍保留對其整體的引用。

如這個模式 `xs@(x:y:ys)`，它會匹配出與 `x:y:ys` 對應的東西，同時你也可以方便地通過 xs 得到整個 List，而不必在函數體中重複 `x:y:ys`。

	capital :: String -> String  
	capital "" = "Empty string, whoops!"  
	capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]

Run

	ghci> capital "Dracula"  
	"The first letter of Dracula is D"

>>使用 as 模式通常就是為了在較大的模式中保留對整體的引用，從而減少重複性的工作。

>> 你不可以在模式匹配中使用 ++。
>
>>若有個模式是 (xs++ys)，那麼這個 List 該從什麼地方分開呢？不靠譜吧。
>
>>而 (xs++[x,y,z]) 或只一個 (xs++[x]) 或許還能說的過去，不過出於 List 的本質，這樣寫也是不可以的。

## 什麼是 Guards ##

**模式用來檢查一個值是否合適並從中取值，而 guard 則用來檢查一個值的某項屬性是否為真。**

聽有點像是 if 語句，實際上也正是如此。不過處理多個條件分支時 guard 的可讀性要高些。

>> BMI 值即為體重除以身高的平方。如果小於 18.5，就是太瘦；如果在 18.5 到 25 之間，就是正常；25 到 30 之間，超重；如果超過 30，肥胖。這就是那個函數(我們目前暫不為您計算 BMI，它只是直接取一個 BMI 值)。

	bmiTell :: (RealFloat a) => a -> String  
	bmiTell bmi  
	    | bmi <= 18.5 = "You're underweight, you emo, you!"  
	    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"  
	    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"  
	    | otherwise   = "You're a whale, congratulations!"

`otherwise = True` ，捕獲一切。這與模式很相像，

	bmiTell :: (RealFloat a) => a -> a -> String  
	bmiTell weight height  
    	| weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"  
	    | weight / height ^ 2 <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"  
    	| weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"  
    	| otherwise                 = "You're a whale, congratulations!"

### 實作`Max` ###

	max' :: (Ord a) => a -> a -> a  
	max' a b   
    	| a > b     = a  
    	| otherwise = b

guard 也可以塞在一行裡面，但這樣會喪失可讀性。

	max' :: (Ord a) => a -> a -> a  
	max' a b | a > b = a | otherwise = b

### 實作`Compare` ###

	myCompare :: (Ord a) => a -> a -> Ordering  
	a `myCompare` b  
	    | a > b     = GT  
	    | a == b    = EQ  
	    | otherwise = LT

Run

	ghci> 3 `myCompare` 2  
	GT

>>*Note*：通過反單引號，我們不僅可以以中綴形式呼叫函數，也可以在定義函數的時候使用它。有時這樣會更易讀。

## 關鍵字Where ##

上一節的BMI例子

	bmiTell :: (RealFloat a) => a -> a -> String  
	bmiTell weight height  
	    | weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"  
	    | weight / height ^ 2 <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"  
	    | weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"  
	    | otherwise                   = "You're a whale, congratulations!"

**注意，我們重複了 3 次。**

**發現重複，我們可以用一個名字取代三個表達式**

	bmiTell :: (RealFloat a) => a -> a -> String  
	bmiTell weight height  
	    | bmi <= 18.5 = "You're underweight, you emo, you!"  
	    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"  
	    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"  
	    | otherwise   = "You're a whale, congratulations!"  
	    where bmi = weight / height ^ 2

用`Where bmi`取代所有`bmi`值

Where盡量和guard縮排相同

**我們可以再做下修改：**

	bmiTell :: (RealFloat a) => a -> a -> String  
	bmiTell weight height  
	    | bmi <= skinny = "You're underweight, you emo, you!"  
	    | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"  
	    | bmi <= fat    = "You're fat! Lose some weight, fatty!"  
	    | otherwise     = "You're a whale, congratulations!"  
	    where bmi = weight / height ^ 2  
	          skinny = 18.5  
	          normal = 25.0  
	          fat = 30.0

我們將每個BMI值賦予意義，利用名字取代。

函數在 where 綁定中定義的名字只對本函數可見，因此我們不必擔心它會污染其他函數的命名空間。注意，其中的名字都是一列垂直排開，如果不這樣規範，Haskell 就搞不清楚它們在哪個地方了。

where 綁定不會在多個模式中共享。如果你在一個函數的多個模式中重複用到同一名字，就應該把它置於全局定義之中。

where 綁定也可以使用模式匹配！前面那段程式碼可以改成：

	...  
	where bmi = weight / height ^ 2  
	      (skinny, normal, fat) = (18.5, 25.0, 30.0)

**姓名的首字母**

	initials :: String -> String -> String  
	initials firstname lastname = [f] ++ ". " ++ [l] ++ "."  
	    where (f:_) = firstname  
	          (l:_) = lastname

## 關鍵字Let ##

let 綁定與 where 綁定很相似。

where 綁定是在函數底部定義名字，對包括所有 guard 在內的整個函數可見。

let 綁定則是個表達式，允許你在任何位置定義局部變數，而對不同的 guard 不可見。

正如 Haskell 中所有賦值結構一樣，let 綁定也可以使用模式匹配。

**依據半徑和高度求圓柱體表面積的函數**

	cylinder :: (RealFloat a) => a -> a -> a  
	cylinder r h = 
	    let sideArea = 2 * pi * r * h  
	        topArea = pi * r ^2  
	    in  sideArea + 2 * topArea

>> `let `的格式為 `let [bindings] in [expressions]`

**let 綁定本身是個表達式，而 where 綁定則是個語法結構。**

還記得前面我們講if語句時提到它是個表達式，因而可以隨處安放？

	ghci> [if 5 > 3 then "Woo" else "Boo", if 'a' > 'b' then "Foo" else "Bar"]  
	["Woo", "Bar"]  
	ghci> 4 * (if 10 > 5 then 10 else 0) + 2  
	42

用 let 實作：

	ghci> 4 * (let a = 9 in a + 1) + 2  
	42

let 也可以定義局部函數

	ghci> [let square x = x * x in (square 5, square 3, square 2)]  
	[(25,9,4)]

若要在一行中綁定多個名字，再將它們排成一列顯然是不可以的。不過可以用分號將其分開。

	ghci> (let a = 100; b = 200; c = 300 in a*b*c, let foo="Hey "; bar = "there!" in foo ++ bar)  
	(6000000,"Hey there!")

你可以在 let 綁定中使用模式匹配。這在從 Tuple 取值之類的操作中很方便。

	ghci> (let (a,b,c) = (1,2,3) in a+b+c) * 100  
	600

你也可以把 let 綁定放到 List Comprehension 中。我們重寫下那個計算 bmi 值的函數，用個 let 替換掉原先的 where。
	
	calcBmis :: (RealFloat a) => [(a, a)] -> [a]  
	calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2]


List Comprehension 中 let 綁定的樣子和限制條件差不多，只不過它做的不是過濾，而是綁定名字。let 中綁定的名字在輸出函數及限制條件中都可見。這一來我們就可以讓我們的函數隻返回胖子的 bmi 值：

	calcBmis :: (RealFloat a) => [(a, a)] -> [a]  
	calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2, bmi >= 25.0]

在 List Comprehension 中我們忽略了 let 綁定的 in 部分，因為名字的可見性已經預先定義好了。不過，把一個 let...in 放到限制條件中也是可以的，這樣名字只對這個限制條件可見。在 ghci 中 in 部分也可以省略，名字的定義就在整個交互中可見。

	ghci> let zoot x y z = x * y + z  
	ghci> zoot 3 9 2  
	29  
	ghci> let boot x y z = x * y + z in boot 3 4 2  
	14  
	ghci> boot  
	< interactive>:1:0: Not in scope: `boot'

你說既然 let 已經這麼好了，還要 where 幹嘛呢？嗯，let 是個表達式，定義域限制的相當小，因此不能在多個 guard 中使用。一些朋友更喜歡 where，因為它是跟在函數體後面，把主函數體距離型別聲明近一些會更易讀。

## Case expressions ##

像是Java中Switch case的case用法

`case` 表達式就是一種表達式。
跟 `if..else` 和 `let` 一樣的表達式。
用它可以對變數的不同情況分別求值，還可以使用模式匹配。

取一個變數，對它模式匹配，執行對應的程式碼塊。好像在哪兒聽過？啊，就是函數定義時參數的模式匹配！

模式匹配本質上不過就是 case 語句的語法糖而已。

以下兩段程式碼是相同的

一

	head' :: [a] -> a  
	head' [] = error "No head for empty lists!"  
	head' (x:_) = x

二

	head' :: [a] -> a  
	head' xs = case xs of [] -> error "No head for empty lists!"  
						(x:_) -> x

`case`語法

	case expression of pattern -> result  
                   pattern -> result  
                   pattern -> result  

解釋

	expression匹配合適的模式。

匹配成功執行區塊的程式碼；否則往下個模式匹配，若到最後都沒匹配到，會產生運行錯誤。

函數參數的模式匹配只能在定義函數時使用，而 case 表達式可以用在任何地方。

	describeList :: [a] -> String  
	describeList xs = "The list is " ++ case xs of [] -> "empty."  
	                                               [x] -> "a singleton list."   
	                                               xs -> "a longer list."

這在表達式中作模式匹配很方便，由於模式匹配本質上就是 case 表達式的語法糖，那麼寫成這樣也是等價的：

	describeList :: [a] -> String  
	describeList xs = "The list is " ++ what xs  
	    where what [] = "empty."  
	          what [x] = "a singleton list."  
	          what xs = "a longer list."