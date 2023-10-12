Rot ← ¬⊸{-⌾(𝕨⊸⊑)⌽𝕩}
Fmt ← {𝕩⊑" #"}¨
_while_ ← {𝔽⍟𝔾∘𝔽_𝕣_𝔾∘𝔽⍟𝔾𝕩}

Ant ← 2⊑{ # Generator Block
  p‿d‿g:
  rot ← d Rot˜ p⊑g
  ⟨
    p + rot
    rot
    ¬⌾(p⊸⊑)g
  ⟩
} _while_ {   # Condition Block
  p‿d‿g:
  ∧´(p≥0‿0)∧p<≢g
}

•Show Fmt Ant ⟨50‿50, 0‿1, 100‿100⥊0⟩
