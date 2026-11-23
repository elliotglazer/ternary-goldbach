Theory Fused
Ancestors FastAxis LargeTerminal
Libs cv_transLib intLib

Definition choose_def:
 choose (p:int,q:int) (f:int,g:int) =
  if ABS p<=1 \/ ABS q<=1 \/ ABS f<=1 \/ ABS g<=1 then (0:num) else
  let pf=((0<p)=(0<f)); qg=((0<q)=(0<g))
  in if pf<>qg then (if pf then 1 else 2)
     else if (0<p)<>(0<g) then 3 else 4
End
Definition rawpairs_def:
 rawpairs sc xs ws ker B M powers =
  let (x,y)=FastAxis$kt_pack 6 B (FastAxis$rotlist sc (FastAxis$kdiv sc 2) xs ws);
      (u,v)=ker; a=x*u; b=y*v; c=(x+y)*(u+v)
  in FastAxis$unpack_acc powers
    (FastAxis$foldcyc (a-b) M,FastAxis$foldcyc (c-a-b) M) []
End
Definition coords_def:
 coords sc z w (ch:num) (p,q,f,g,e) =
 let (x,y)=z; (u,v)=w; hh=FastAxis$kdiv sc 2;
     v0=if ch<=2 then FastAxis$kdiv (x*u-y*v+hh) sc else FastAxis$kdiv (x*v+y*u+hh) sc
 in if ch=0 \/ ABS v0<=e then
      LargeTerminal$score (p,q) (f,g,e) (FastAxis$rotate2 sc hh z w)
    else if (ch=1 \/ ch=3)=(0<v0) then 2 else 1
End
Definition emit_def:
 (emit sc [] ws cs = (0:num,0:num)) /\
 (emit sc (z::zs) ws cs = case (ws,cs) of (w::ww,((ch:num),row)::cc) =>
    (let b=coords sc z w ch row; (bits,bad)=emit sc zs ww cc
     in (2*bits+(if b=2 then 1 else 0),2*bad+(if b=0 then 1 else 0)))
    | _ => (0,0))
End
Definition preclass_def:
 (preclass [] = []) /\
 (preclass ((p,q,f,g,e)::xs) =
    (choose (p,q) (f,g),(p,q,f,g,e))::preclass xs)
End
Definition old_def:
 old sc zs ws chk taps =
 let ys=FastAxis$rotlist sc (FastAxis$kdiv sc 2) zs ws in
   FastAxis$kr_mod (FastAxis$lp_sum ys 0) 65537=chk /\
   [FastAxis$lp_pick 0 ys; FastAxis$lp_pick 1 ys; FastAxis$lp_pick 30 ys; FastAxis$lp_pick 59 ys]=taps
End
Definition passes_def:
 (passes 0 mode sc xs ws ker B M pw cs chk taps mask = T) /\
 (passes (SUC n) mode sc xs ws ker B M pw cs chk taps mask =
    let zs=rawpairs sc xs ws ker B M pw in
    (if mode then emit (sc*sc) (DROP 1 zs) (DROP 1 ws) cs=(mask,0)
     else old (sc*sc) zs ws chk taps) /\ passes n mode sc xs ws ker B M pw cs chk taps mask)
End
Definition compare_run_def:
 compare_run n mode sc xs ws phases chk taps mask =
 let B=(2:int)**160; M=B**60-1; pw=FastAxis$kt_powers 6 B [];
     ker=FastAxis$kt_pack 6 B (FastAxis$lp_conj ws); cs=preclass phases
 in passes n mode sc xs ws ker B M pw cs chk taps mask
End
val _=cv_auto_trans compare_run_def;
