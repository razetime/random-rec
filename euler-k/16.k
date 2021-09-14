/ custom bigint arithmetic time
p: {((x-#y)#0),y}
s: {{(~*x)_x}@((x%10),0)+0,10!x}/
m: {s@+/{p[|/#'x]'x}@{x,'{x#0}'!#x}@s'|x*/:y} / slow but working bigint multiplication.
+/999m[,2]/,2
