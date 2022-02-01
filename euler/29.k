/ just a cartesian product
/ main problem is the very long ints, which are represented as ordered prime factor arrays


pf:{$[y>1;$[0=x!y;x,o[x;y%x];o[x+1;y]];()]}

#?,/{x{n:,/y#,pf[2;x];n[<n]}\:/:x}2+!99
