/addition of bitwise things
/ kind of a pain, but possible
/ problem is, brute force does not work, even in a language that's built like k.
n:1000000
/ Due to the absence of $ on int arrays, needs to manually pad the things.
/ this brute force is garbage and will never complete.
+/{m::x;+/{a:2\x;b:2\m-x;l:(#a)|#b;a:((l-#a)#0),a;b:((l-#b)#0),b;(2/~a=b)+(2/a|b)+(2/a&b)}'!m+1}'!n+1

