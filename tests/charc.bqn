#!usr/bin/env cbqn

codepage ← ⍷"0_ 	； 	∧ 	∨ 	“ 	” 	⊞ 	⊟ 	➙ 	⧴ 	″ 	¶ 	‴ 	＆ 	｜ 	↶ 	↷
1_ 	⟲ 	← 	↑ 	→ 	↓ 	⎇ 	‽ 	↧ 	↥ 	⌊ 	⌈ 	± 	↖ 	↗ 	↘ 	↙
2_ 		! 	"" 	# 	$ 	% 	& 	' 	( 	) 	* 	+ 	, 	- 	. 	/
3_ 	0 	1 	2 	3 	4 	5 	6 	7 	8 	9 	: 	; 	< 	= 	> 	?
4_ 	@ 	A 	B 	C 	D 	E 	F 	G 	H 	I 	J 	K 	L 	M 	N 	O
5_ 	P 	Q 	R 	S 	T 	U 	V 	W 	X 	Y 	Z 	[ 	\ 	] 	^ 	_
6_ 	` 	a 	b 	c 	d 	e 	f 	g 	h 	i 	j 	k 	l 	m 	n 	o
7_ 	p 	q 	r 	s 	t 	u 	v 	w 	x 	y 	z 	{ 	| 	} 	~ 	⭆
8_ 	？ 	⪫ 	⪪ 	℅ 	◧ 	◨ 	⮌ 	≡ 	№ 	⊙ 	⸿ 	⬤ 	≔ 	≕ 	▷ 	▶
9_ 	✂ 	Σ 	Π 	↨ 	⍘ 	✳ 	↔ 	≦ 	≧ 	ⅈ 	ⅉ 	⌕ 	⊕ 	⊖ 	⊗ 	⊘
A_ 	⎚ 	¬ 	₂ 	Φ 	§ 	﹪ 			« 	» 	× 	⁺ 		⁻ 	· 	÷
B_ 	⁰ 	¹ 	² 	³ 	⁴ 	⁵ 	⁶ 	⁷ 	⁸ 	⁹ 	¦ 	‖ 	‹ 	⁼ 	› 	¿
C_ 		Ａ 	Ｂ 	Ｃ 	Ｄ 	Ｅ 	Ｆ 	Ｇ 	Ｈ 	Ｉ 	Ｊ 	Ｋ 	Ｌ 	Ｍ 	Ｎ 	Ｏ
D_ 	Ｐ 	Ｑ 	Ｒ 	Ｓ 	Ｔ 	Ｕ 	Ｖ 	Ｗ 	Ｘ 	Ｙ 	Ｚ 	⟦ 	∕ 	⟧ 		…
E_ 	´ 	α 	β 	χ 	δ 	ε 	φ 	γ 	η 	ι 		κ 	λ 	μ 	ν 	¤
F_ 	π 	θ 	ρ 	σ 	τ 	υ 	ς 	ω 	ξ 	ψ 	ζ 	⦃ 		⦄ 	～"


t ←⥊∾⌜˜codepage
# stdouts ← (↕≠t){•Show ⟨𝕨, "of", ≠t⟩,•Show •SH ⟨"/home/razetime/Software/Charcoal/charcoal", "-c", 𝕩⟩}¨t
stdouts ← {1⊑•SH ⟨"/home/razetime/Software/Charcoal/charcoal", "-c", 𝕩⟩}¨t
•Show "Execution done."
stdouts •FLines "stdouts.txt"
•Show •BQN¨(0<≠)¨⊸/(∧´≥⟜'0'∧≤⟜'9')¨⊸/stdouts