applyTwice :: (a -> a) -> a -> a

--  它標明了首個參數是個參數與回傳值型別都是a的函數，
--  第二個參數與回傳值的型別也都是a。

--  其首個參數是個型別為 (a->a) 的函數,第二個參數是個 a。 該函數的型別可以是 (Int->Int)，也可以是 (String->String)，但第二個參數必須與之一致。 
applyTwice f x = f (f x)

applyTwice (+3) 10 = (+3) (+3 10)