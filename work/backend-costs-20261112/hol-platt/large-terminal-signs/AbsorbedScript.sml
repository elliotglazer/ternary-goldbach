Theory Absorbed
Ancestors Fused
Libs cv_transLib intLib
Definition cache_one_def:
 cache_one sc (p,q,f,g,e,rawerr) (u,v) =
  let z=FastAxis$rotate2 sc (FastAxis$kdiv sc 2) (p,q) (u,v);
      a=FST z; b=SND z;
      ep=FastAxis$kdiv (ABS p+ABS q+ABS u+ABS v+2+sc-1) sc + 1;
      ch=if ABS a<=ep \/ ABS b<=ep then 0 else Fused$choose (a,b) (f,g)
  in (ch,rawerr,(p,q,f,g,e))
End
Definition cache_def:
 (cache sc [] ws = []) /\
 (cache sc (z::zs) ws = case ws of []=>[] | w::ww => cache_one sc z w::cache sc zs ww)
End
Definition collect_def:
 (collect sc [] ws cs = (0:num,0:num)) /\
 (collect sc (z::zs) ws cs = case (ws,cs) of (w::ww,((ch:num),er,(p,q,f,g,e))::cc) =>
   (let v=if ch<=2 then FST z else SND z;
        sign=if ch=0 \/ ABS v<=er then LargeTerminal$score (p,q) (f,g,e) (FastAxis$rotate2 sc (FastAxis$kdiv sc 2) z w)
             else if (ch=1 \/ ch=3)=(0<v) then 2 else 1;
        (bits,bad)=collect sc zs ww cc
    in (2*bits+(if sign=2 then 1 else 0),2*bad+(if sign=0 then 1 else 0))) | _ => (0,0))
End
Definition batch_def:
 (batch 0 mode sc xs ws ker B M pw cs chk taps mask = T) /\
 (batch (SUC n) mode sc xs ws ker B M pw cs chk taps mask =
 let zs=Fused$rawpairs sc xs ws ker B M pw in
 (if mode then collect (sc*sc) (DROP 1 zs) (DROP 1 ws) cs=(mask,0) else Fused$old (sc*sc) zs ws chk taps) /\
 batch n mode sc xs ws ker B M pw cs chk taps mask)
End
Definition absrun_def:
 absrun n mode sc xs ws phases chk taps mask =
 let B=(2:int)**160; M=B**60-1; pw=FastAxis$kt_powers 6 B [];
     ker=FastAxis$kt_pack 6 B (FastAxis$lp_conj ws); cs=cache sc phases (DROP 1 ws)
 in batch n mode sc xs ws ker B M pw cs chk taps mask
End
val _=cv_auto_trans absrun_def;
