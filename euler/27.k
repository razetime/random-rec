/ prime finding quadratics


/ recursive method's the simplest. I really tried,ok?
pr: {{$[y<1+_%x;$[0=y!x;0;o[x;y+1]];1]}[x;2]}

cf:{,/x,/:\:x}1000-!2001
:a:cf[*>{{$[pr{x|-x}(x*x)+(y*x)+z;o[1+x;y;z];x]}.0,x}'cf]
*/a
