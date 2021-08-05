
/ just really long fibonacci
/ not sure why it's not working in  the repl

a:,1
b:,1
i:1

dec:{(-1_(),x),(10!*|x),y+(*|x)%10}

{~1000=#b}{i+:1;t:b;b::.',/$|dec/|b+(((#b)-#a)#0),a;a::t}/1



