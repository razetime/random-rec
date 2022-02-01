/ goldbach

sieve:{ /translation of roger hui's sieve.
 b:x#{&/(*/x)#'~0=!'x}2 3 5
 b[!6&x]:(6&x)#0 0 1 1 0 1
 $[
  (49>x)|49=x;b;
  :[p{b[x*x+2*!y]:0}'m:1+_(x-1+p*p)%2*p:3_&o⌈%x;b]
 ]
 }

primes: !_1e4
