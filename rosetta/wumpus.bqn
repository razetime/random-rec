_while_←{𝔽⍟𝔾∘𝔽_𝕣_𝔾∘𝔽⍟𝔾𝕩}
_RU←{F _𝕣 msg: {•Out msg, •GetLine@}_while_¬∘𝔽 •GetLine@}
adj←⟨1‿5‿4,2‿7‿0,3‿9‿1,4‿1‿2,0‿13‿3,14‿0‿6,16‿5‿7,6‿1‿8,17‿7‿9,8‿2‿10,18‿9‿11,10‿3‿12,19‿11‿13,4‿10‿12,5‿15‿13,19‿14‿16,15‿6‿17,16‿8‿18,17‿10‿19,18‿12‿15⟩
rct←(•rand.Deal 20)⊏⟨"Bat", "Bat", "Pit", "Pit", "Wumpus"⟩∾15⥊⟨"Empty"⟩
arrows←5
{
  𝕊 pr:
  •Out "YOU ARE IN ROOM "∾(•Fmt 𝕩)∾" TUNNELS LEAD TO "∾(•Fmt pr⊑adj)
  •Out "SHOOT OR MOVE (H FOR HELP)"
  {
    'M': •Out "WHERE TO "∾•Fmt pr⊑adj
      {
  } •GetLine@
}_while_{𝕊:arrows>0}•rand.Range∘≠⊸⊑/"Empty"⊸≡¨rct # first room is a random empty space.

