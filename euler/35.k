/ rotating primes


pr: {{$[y<1+_%x;$[0=y!x;0;o[x;y+1]];1]}[x;2]}

prs: pr#2+!999998

+/{d:$x;&/~0N=prs?.'(!#d){(x_y),x#y}\:d}'prs
