/ recurring decimals
/bit of inspiration from a C# solution
/ ngn's version:
/ fr:&a:983;p:0;p-fr{x&~fr x}{fr[x]:p;p+:1;a!x*10}/1
1+*>{a::x;p::0;fr::x#0;v:{(~x=0) &(0=fr x)}{fr[x]::p;p+:1;a!x*10}/1;p-fr v}'1+!999