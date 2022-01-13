#!/usr/bin/env cbqn

# Quiner interpreter (https://esolangs.org/wiki/Quiner)
# run with ./BQN quiner.bqn <flags>
# or cbqn quiner.bqn <flags>

"ERROR: No arguments given. Use -h for help." ! 0≠≠•args
input ← {
  "-h": •Out "  -h            displays this help
  -f '<file>' run a file
  -c '<code>' run some code"
  •Exit@;
  "-f": "ERROR: No file given"!1<≠•args
  •FChars 1⊑•args;
  "-c": "ERROR: No code given"!1<≠•args
  1⊑•args;
  "ERROR: Invalid flag given. Use -h for help."!0
}⊑•args
nl ← @+10
Split ← (⊢-˜+`×¬)∘=⊔⊢
stdin ← ""
stdout ← ""

{
  𝕊 ⟨code, data, i, j⟩:
  i‿data ↩ {
    𝕊 ind‿data: # execute a single command.
    p ← ind+⌊´"*,.></+"⊐˜ind↓code
    n‿l ← (0⊸(10⊸×⊸+˜´)⋈≠)'0'-˜(∧`(≥⟜'0'∧≤⟜'9'))⊸/⌽p↑code
    n‿l{
      0‿0 𝕊 '+': 2‿1 𝕊 '+';
      0‿0 𝕊 𝕩  : 1‿1 𝕊 𝕩;
      n‿l 𝕊 '*': j ⌊↩ 0⌈n-˜≠data, ⟨p+1, (-n)↓data⟩;
      n‿l 𝕊 ',': stdin {nl∾˜𝕩∾•GetLine@} •_while_ {n>≠𝕩}↩ ,  ap ← n↑stdin, stdin↓˜↩n, ⟨p+1, data∾ap⟩;
      n‿l 𝕊 '.':
      stdout ∾↩ (-n)↑data
      {(nl≠¯1⊑stdout)∧⊑nl∊stdout ? sp ← nl Split stdout, •Out¨¯1↓sp, stdout ↩ ¯1⊑sp;@}
      ⟨p+1, (-n)↓data⟩;
      n‿l 𝕊 '>': ⟨p+n+1, data∾n↑(p+1)↓code⟩;
      n‿l 𝕊 '<': ⟨p+1, data∾(-(p-l)⌊n)↑(p-l)↑code⟩;
      n‿l 𝕊 '/': {'/'=(p+1)⊑code ? ⟨p+1+n, data⟩; ⟨p+1, data⟩};
      n‿l 𝕊 '+': ⟨p+1, ((-n)↓data)∾@+256|0+´@-˜(-n)↑data⟩;
      ("ERROR: Expected command character"∾nl∾code∾nl∾(p+1)↑'^')! 0
    }p⊑code
  } •_while_ {ind‿data: ind<≠code} i‿data
  ⟨data, code, j, i⟩
} •_while_ {in‿co‿i‿j: i<≠in} ⟨input, "", 0, 0⟩

•Out stdout