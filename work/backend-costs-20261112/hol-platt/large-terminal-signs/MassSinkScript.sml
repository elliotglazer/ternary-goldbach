Theory MassSink
Ancestors FastAxis integer
Libs cv_transLib intLib
Definition rotmass_def:
 (rotmass sc h [] ws acc = ([],acc:int)) /\
 (rotmass sc h (z::zs) ws acc =
    case ws of []=>([],acc) | w::ww =>
    let (out,m)=rotmass sc h zs ww (acc+ABS(FST z)+ABS(SND z))
    in (FastAxis$rotate2 sc h z w::out,m))
End
Definition massloop_def:
 (massloop 0 mode sc zs ws want chk <=> T) /\
 (massloop (SUC n) mode sc zs ws want chk <=>
  (let h=FastAxis$kdiv sc 2;
       (ys,m)=if mode then rotmass sc h zs ws 0 else (FastAxis$rotlist sc h zs ws,want)
   in m=want /\ FastAxis$kr_mod (FastAxis$lp_sum ys 0) 65537=chk) /\
  massloop n mode sc zs ws want chk)
End
val _=cv_auto_trans massloop_def;
