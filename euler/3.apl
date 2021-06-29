 ⍝ lightly imperative

 f←0
 d←2
 n← 600851475143
 f⊣{d+←1 ⋄ {0=(d-1)|⍵:∇ ⍵÷f∘←d-1 ⋄ ⍵}⍵}⍣{⍵<2}n