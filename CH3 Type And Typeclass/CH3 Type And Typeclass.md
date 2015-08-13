# Learning Haskell Ch3 - Types and Typeclasses #

## Type ##

Haskell 是 Static Type，這表示在編譯時期每個表達式的型別都已經確定下來，這提高了程式碼的安全性。

若程式碼中有讓布林值與數字相除的動作，就不會通過編譯。

這樣的好處就是與其讓程序在運行時崩潰，不如在編譯時就找出可能的錯誤。

Haskell 中所有東西都有型別，因此在編譯的時候編譯器可以做到很多事情。

與 Java 和 Pascal 不同，Haskell 支持型別推導。寫下一個數字，你就沒必要另告訴 Haskell 說"它是個數字"，它自己能推導出來。這樣我們就不必在每個函數或表達式上都標明其型別了。

在前面我們只簡單涉及一下 Haskell 的型別方面的知識，但是理解這一型別系統對於 Haskell 的學習是至關重要的。

可以使用 ghci 來檢測表達式的型別。使用 `:t` 命令後跟任何可用的表達式，即可得到該表達式的型別。

	ghci> :t 'a'  
	'a' :: Char  
	ghci> :t True  
	True :: Bool  
	ghci> :t "HELLO!"  
	"HELLO!" :: [Char]  
	ghci> :t (True, 'a')  
	(True, 'a') :: (Bool, Char)  
	ghci> :t 4 == 5  
	4 == 5 :: Bool