text←"Given$a$text$file$of$many$lines,$where$fields$within$a$line$
are$delineated$by$a$single$'dollar'$character,$write$a$program
that$aligns$each$column$of$fields$by$ensuring$that$words$in$each$
column$are$separated$by$at$least$one$space.
Further,$allow$for$each$word$in$a$column$to$be$either$left$
justified,$right$justified,$or$center$justified$within$its$column."

Split ← (⊢-˜+`×¬)∘=⊔⊢
PadRow ← {
  w‿t𝕊𝕩: # t → type.
         # 0 → left
         # 1 → right
         # 2 → center
 pstyle←t⊑⟨{0‿𝕩},{𝕩‿0},{⟨⌊𝕩÷2,⌈𝕩÷2⟩}⟩
 𝕩{(⊣∾𝕨∾⊢)´(Pstyle 𝕩)/¨<w}¨(⌈´-⊢)≠¨𝕩
}
Align ← {{𝕨∾' '∾𝕩}´˘⍉" "‿𝕨⊸PadRow˘⍉>⟨""⟩‿0 PadRow '$' Split¨(@+10) Split 𝕩}

•Show 1 Align text
