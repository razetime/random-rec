Split ← (⊢-˜+`×¬)∘=⊔⊢

Abbrnum ← 1⊸{
  𝕊⟨⟩:@;
  ((⊢≡⍷)𝕨↑¨𝕩)◶⟨(𝕨+1)⊸𝕊,𝕨⟩𝕩}
words ← ' ' Split¨ •FLines "abbrs.txt"

(•Show Abbrnum ≍○< ⊢)¨words
