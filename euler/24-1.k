
/ permutation vectors


/ inefficient method:
/ {(<1+)':x}!10

/ combinatoric method:
n:!10
f:*/1+!:
.,/$(,999999){r:*|x;j:_r%f y;a:n[j];n::n^,a;(-1_x),a,(f y)!r}/|1+!9
