selfHead :: [a] -> a
selfHead [] = error "Empty list"
selfHead (x:_) = x