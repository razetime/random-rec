Conj←1‿¯1⊸×
Cmul←{a‿b𝕊c‿d: ⟨a×c-b×d, a×d+b×c⟩}
Iter←(⊢∾⟨1‿0⟩∾Conj¨○⌽)∘(⊢∾˜⟨0‿¯1⟩⊸∾˜0‿¯1⊸CMul¨∘⌽)
(⊢∾˜⟨0‿¯1⟩⊸∾˜0‿¯1⊸CMul¨∘⌽) Iter ⟨⟩
