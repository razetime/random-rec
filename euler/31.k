/currency time

c: 1 2 5 10 20 50 100 200

{$[x=0;1;x<0;0;(x>0)&y<0;0;o[x;y-1]+o[x-c y;y]]}[200;7]
