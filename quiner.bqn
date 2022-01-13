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
    # For Debug:
    #•Show code‿((-l+1)↑(p+1)↑code)‿data‿ind‿j
    n‿l{
      0‿0 𝕊 '+': 2‿1 𝕊 '+';
      0‿0 𝕊 𝕩  : 1‿1 𝕊 𝕩;
      n‿l 𝕊 '*': j ⌊↩ 0⌈n-˜≠data, ⟨p+1, (-n)↓data⟩;
      n‿l 𝕊 ',': stdin {nl∾˜𝕩∾•GetLine@} •_while_ {n>≠𝕩}↩ ,  ap ← n↑stdin, stdin↓˜↩n, ⟨p+1, data∾ap⟩;
      n‿l 𝕊 '.':
      •Out (-n)↑data
      ⟨p+1, (-n)↓data⟩;
      n‿l 𝕊 '>': ⟨(≠code)⌊p+n+1, data∾ {(n⌊≠𝕩)↑𝕩}(p+1)↓code⟩;
      n‿l 𝕊 '<': ⟨p+1, data∾(-(p-l)⌊n)↑(p-l)↑code⟩;
      n‿l 𝕊 '/': {'/'=(p+1)⊑code ? ⟨(≠code)⌊p+2+n, data⟩; ⟨p+1, data⟩};
      n‿l 𝕊 '+': ⟨p+1, ((-n)↓data)∾@+256|0+´@-˜(-n)↑data⟩;
      ("ERROR: Expected command character"∾nl∾code∾nl∾(p+1)↑'^')! 0
    }p⊑code
  } •_while_ {ind‿data: ind<≠code} i‿data
  ⟨data, code, j, i⟩
} •_while_ {in‿co‿i‿j: i<≠in} ⟨input, "", 0, 0⟩

•Out stdout

# a*	Remove the last a characters from the end of the data deque. If the data queue's instruction pointer now points to nothing, move it back to the end of the data deque.
# a,	Input a characters from standard input and append them to the end of the data deque.
# a.	Remove the last a characters from the end of the data deque and print them to standard output.
# a>	Append the following a characters to the end of the data deque and skip their execution.
# a<	Append the previous a characters to the end of the data deque (not counting a as part of the characters).
# a/?	If ? is the / character, skip the execution of the next a characters (not counting / as part of the characters). Otherwise, do nothing (and do not execute the ? character).
# a+	Remove the last a characters from the end of the data deque, add their ascii values together (overflowing at 256), and append the resulting sum as an ascii character to the data deque. The default value for a is 2.

#2>9/ ,4>@@@>5+ 99> 1>0.99// 1>1.004<4<4<
#13>Hello, World!13.