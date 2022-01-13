/ numbers to letters
/ frustratingly close, difficult to debug.

ut: 0 3 3 5 4 4 3 5 5 4 3 6 6 8 8 7 7 9 8 8 / 0-19.
nn: ut,,/(10#ut)+/:6 6 5 5 5 7 6 6 / 0..99
h: 0,7+1_10#ut / 100,200..900
ts: 6 6 8 8 7 7 9 8 7 /11..19
lc: {(a;b;c):x;(h@a)+(3*(a>0)&(b>0)|c>0)+nn@c+10*b}

'+10\1+!999
