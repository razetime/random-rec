⍝ unsatisfactory plotting script.
'InitCauseway' 'View' ⎕CY 'sharpplot'
InitCauseway ⍬   ⍝ initialise current namespace

pts ← ,(¯2+(⍳30)÷10)∘.+0j1×¯1+(⍳20)÷10
x ← 9○pts
y ← 11○pts
mandelbrot ← {n←0 ⋄ n⊣⍵{n+←1 ⋄ ⍺+⍵×⍵}⍣{(~(|⍵)≤2)∨n≥80}0}
vals ← mandelbrot¨pts
cl ← ∪vals
type ← cl⍳vals
colors ← 256⊥1 3⌿255,[.5]cl

sp ← ⎕NEW Causeway.SharpPlot
sp.MarkerLimit ← 0
sp.SplitBy ⊂type
sp.Heading ← 'Mandelbrot Set'
sp.SetMarkers ⊂System.Drawing.Marker.Bullet
sp.SetColors ⊂colors
sp.DrawScatterPlot(x y)
sp.SaveSvg(⊂'samplemand.svg')
⍝ ⎕←sp.RenderSvg ⍬

