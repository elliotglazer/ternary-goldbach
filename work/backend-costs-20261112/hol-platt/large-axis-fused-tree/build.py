from pathlib import Path
from shutil import copyfile
here=Path(__file__).resolve().parent
prior=here.parent/"large-axis-sample"
src=(prior/"SampleAxisScript.sml").read_text().replace("Theory SampleAxis","Theory FusedTree")
old=src[src.index("Definition lp_repeat_def:"):src.index("val _=cv_auto_trans lp_roots_def;")]
extra="""
Definition fu_rot_def:
  fu_rot (four:bool) (s:int) h (z:int # int) (r:int # int) =
    let x=FST z; y=SND z; u=FST r; v=SND r; a=x*u; b=y*v;
        c=if four then x*v+y*u else (x+y)*(u+v)-a-b in
    (kdiv (a-b+h) s,kdiv (c+h) s)
End
Definition fu_first_def:
  (fu_first f s h B [] ws = []) /\\
  (fu_first f s h B [x] ws = case ws of []=>[] | r::rs=>[fu_rot f s h x r]) /\\
  (fu_first f s h B (x::y::zs) ws =
    case ws of []=>[] | [r]=>[fu_rot f s h x r] | r::t::rs =>
      let a=fu_rot f s h x r; b=fu_rot f s h y t in
      (FST a+B*FST b,SND a+B*SND b)::fu_first f s h B zs rs)
End
Definition fu_out_def:
  (fu_out f s h [] (z:int # int) ws =
    case ws of []=>([],[]) | r::rs=>([fu_rot f s h z r],rs)) /\\
  (fu_out f s h (pw::ps) z ws =
    let b=FST pw; t=SND pw; x=FST z; y=SND z;
        u=kdiv (x+t) b; v=kdiv (y+t) b;
        a=fu_out f s h ps (x-u*b,y-v*b) ws;
        c=fu_out f s h ps (u,v) (SND a)
    in (FST a ++ FST c,SND c))
End
Definition fu_run_def:
  fu_run f d B M sc powers xs ws ker =
    let aa=kt_pack (d-1) (B*B) (fu_first f sc (kdiv sc 2) B xs ws);
        x=FST aa; y=SND aa; u=FST ker; v=SND ker; a=x*u; b=y*v;
        c=(x+y)*(u+v)-a-b; s=sc*sc in
    FST (fu_out f s (kdiv s 2) powers (kr_center (a-b) M,kr_center c M) ws)
End
val _=cv_auto_trans fu_run_def;
"""
old=old.replace("lp_repeat","fu_repeat").replace("lp_top","fu_top")
old=old.replace("fu_repeat 0","fu_repeat mode 0").replace("fu_repeat (SUC","fu_repeat mode (SUC").replace("fu_repeat r ","fu_repeat mode r ").replace("fu_repeat reps","fu_repeat mode reps").replace("fu_top n","fu_top mode n")
old=old.replace("let ys=lp_run d B M sc powers xs ws ker;","let ys=if (mode:num)=0 then lp_run d B M sc powers xs ws ker else fu_run (mode=2) d B M sc powers xs ws ker;")
(here/"FusedTreeScript.sml").write_bytes((src+extra+old+"\nval _=cv_auto_trans fu_top_def;\n").encode())
worker=(prior/"fast/worker.sml").read_text().replace("FastAxis","FusedTree").replace("fast_top","fu_top")
(here/"worker.sml").write_bytes(worker.encode())
copyfile(prior/"fast/Holmakefile",here/"Holmakefile")
sh=(prior/"fast/run.sh").read_text().replace("cd ../../..","cd ../..").replace("FastAxis","FusedTree")
(here/"run.sh").write_bytes(sh.encode())
panel=[]
for group,targets in (("small",(32,96,256,500)),("medium",(1200,3000,5500))):
    lines=(prior/f"p24_{group}.txt").read_text().splitlines()
    for t in targets:
        line=min(lines,key=lambda l:abs(int(l.split()[0])-t))
        if line not in panel: panel.append(line)
(here/"panel.txt").write_bytes(("\n".join(panel)+"\n").encode())
