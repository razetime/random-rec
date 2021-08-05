/ truncating them primes


pr: {{$[y<1+_%x;$[0=y!x;0;o[x;y+1]];1]}[x;2]}

prs: pr#2_!800000

+/{&/~0N=prs?.'(||',\|$x),,\$x}#4_prs
