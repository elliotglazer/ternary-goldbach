"""Build an equivalent whole-axis circuit with balanced unpacking and exact centered division."""
from pathlib import Path
import hashlib

here=Path(__file__).resolve().parent
original=here.parents[1]/"large-kronecker-hol-price/LargePanelScript.sml"
assert hashlib.sha256(original.read_bytes()).hexdigest()=="0e49e0993a28c2f6400744f3569bcf6873b06a3756b21ea450db4b57ca5a75b8"
s=original.read_text().split('val f=TextIO.openIn "cases.txt";')[0].replace("Theory LargePanel","Theory FastAxis")
extra=r"""
Definition unpack_acc_def:
  (unpack_acc [] (z:int # int) tail = z::tail) /\
  (unpack_acc (sw::ss) z tail =
   let s=FST sw; h=SND sw; x=FST z; y=SND z; u=kdiv (x+h) s; v=kdiv (y+h) s in
   unpack_acc ss (x-u*s,y-v*s) (unpack_acc ss (u,v) tail))
End
Theorem unpack_acc_equiv:
  !steps z tail. unpack_acc steps z tail = kt_unpack steps z ++ tail
Proof
  Induct_on $Qsteps$Q >> simp[unpack_acc_def,kt_unpack_def,LET_THM,APPEND_ASSOC]
QED
Definition rotate2_def:
  rotate2 (s:int) h (z:int # int) (w:int # int) =
    let x=FST z; y=SND z; u=FST w; v=SND w;
        a=x*u; b=y*v; c=(x+y)*(u+v)
    in (kdiv (a-b+h) s,kdiv (c-a-b+h) s)
End
Definition rotlist_def:
  (rotlist s h [] ws = []) /\
  (rotlist s h (z::zs) ws = case ws of []=>[] | w::rest =>
      rotate2 s h z w :: rotlist s h zs rest)
End
Definition foldcyc_def:
  foldcyc (z:int) m =
    let power=m+1; hi=kdiv z power; u=z-hi*power+hi in
    if 0 < m /\ ~ (2*u < -m) /\ 2*u<m then u
    else if 0 < m /\ ~ (2*(u-m) < -m) /\ 2*(u-m)<m then u-m
    else kr_center u m
End
Definition alternative_def:
  alternative (mode:num) d B M sc powers xs ws kernel =
    let aa=kt_pack d B (rotlist sc (kdiv sc 2) xs ws);
        x=FST aa; y=SND aa; u=FST kernel; v=SND kernel;
        p=x*u; q=y*v; t=(x+y)*(u+v);
        compressed=(if mode=2 then (foldcyc (p-q) M,foldcyc (t-p-q) M)
                    else (kr_center (p-q) M,kr_center (t-p-q) M));
        pairs=unpack_acc powers compressed [];
        final=sc*sc
    in rotlist final (kdiv final 2) pairs ws
End
"""
extra=extra.replace("$Q",chr(96))
extra+='\nval _=cv_auto_trans alternative_def;\n'
sr=s[s.index("Definition lp_repeat_def:"):s.index("val _=cv_auto_trans lp_roots_def;")]
sr=sr.replace("lp_repeat","fast_repeat").replace("lp_top","fast_top")
sr=sr.replace("fast_repeat 0","fast_repeat mode 0").replace("fast_repeat (SUC r)","fast_repeat mode (SUC r)").replace("fast_repeat r ","fast_repeat mode r ").replace("fast_repeat reps","fast_repeat mode reps").replace("fast_top n","fast_top mode n")
sr=sr.replace("let ys=lp_run d B M sc powers xs ws ker;",
              "let ys=(if mode=0 then lp_run d B M sc powers xs ws ker else alternative mode d B M sc powers xs ws ker);")
(here/"FastAxisScript.sml").write_text(s+extra+sr+'\nval _=cv_auto_trans fast_top_def;\n')
# Each input is one already-audited sampled shape. Time the same checks at all modes.
w=(here.parent/"worker.sml").read_text().replace("SampleAxisTheory","FastAxisTheory").replace("SampleAxisTrial","FastAxisTrial")
w=w.replace("fun trial r =","fun trial mode r =").replace(chr(96)*2+"lp_top"+chr(96)*2+",[nu n",chr(96)*2+"fast_top"+chr(96)*2+",[nu mode,nu n")
w=w.replace('print("PANEL " ^','print("FAST " ^ Int.toString mode ^ " " ^')
w=w.replace("in List.app trial (if n<=8192 then [0,1,4,4,0] else [0,1,1,0]) end;",
'''in List.app (fn (mode,r)=>trial mode r)
  (if n<=8192 then [(0,0),(1,0),(2,0),(0,2),(1,2),(2,2),(2,2),(1,2),(0,2),(2,0),(1,0),(0,0)]
   else [(0,0),(1,0),(2,0),(0,1),(1,1),(2,1),(2,1),(1,1),(0,1),(2,0),(1,0),(0,0)]) end;''')
(here/"worker.sml").write_text(w)
keys={46,280,1570,5580,19540,70140}
all_rows=[]
for group in ("small","medium","long","tail"):
    for row in (here.parent/(group+".txt")).read_text().splitlines():
        if int(row.split()[0]) in keys:
            keys.remove(int(row.split()[0]))
            all_rows.append(row)
assert not keys
(here/"panel.txt").write_text("\n".join(all_rows)+"\n")
