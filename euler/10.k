/ prime thingy
/ sieve of eratosthenes time
m:10000000
sieve:{
  b:x#{&/(*/x)#/:{((x-1)#0),x}'x}2 3 5
  b[!6&x]:(6&x)#0 0 1 1 0 1
}