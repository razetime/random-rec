⍝ recursive dfn:
dfnHailstone←{
    c←⊃⌽⍵ ⍝ last element
    1=c:1 ⍝ if it is 1, stop.
    ⍵,∇(1+2|c)⊃(c÷2)(1+3×c) ⍝ otherwise pick the next step, and append the result of the recursive call
}