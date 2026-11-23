Theory SampleAxis
Ancestors integer list cv_std
Libs intLib cv_transLib
val _=intLib.ARITH_TAC;
Definition kr_mod_def:
  kr_mod (z:int) (m:int) = if m=0 then 0 else z % m
End
val _=cv_auto_trans kr_mod_def;
Definition kdiv_def:
  kdiv (z:int) d = if d=0 then 0 else z / d
End
val _=cv_auto_trans kdiv_def;
Definition kr_center_def:
  kr_center z d =
    let r=kr_mod z d in if 2*r >= d then r-d else r
End
val _=cv_auto_trans kr_center_def;
Definition kr_rot_def:
  kr_rot (scale:int) (z:int # int) (w:int # int) =
    let x=FST z; y=SND z; u=FST w; v=SND w; p=x*u; q=y*v; t=(x+y)*(u+v);
        real=p-q; imag=t-p-q in
    (kdiv (real+kdiv scale 2) scale,kdiv (imag+kdiv scale 2) scale)
End
val _=cv_auto_trans kr_rot_def;
Definition kt_pairs_def:
  (kt_pairs (s:int) [] = []) /\
  (kt_pairs s [z:int # int] = [z]) /\
  (kt_pairs s (z::w::zs) =
    (FST z+s*FST w,SND z+s*SND w)::kt_pairs s zs)
End
val _=cv_auto_trans kt_pairs_def;
Definition kt_pack_def:
  (kt_pack 0 (s:int) zs = case zs of []=>(0:int,0:int) | z::rest=>z) /\
  (kt_pack (SUC n) s zs = kt_pack n (s*s) (kt_pairs s zs))
End
val _=cv_auto_trans kt_pack_def;
Definition kt_powers_def:
  (kt_powers 0 (s:int) acc = acc) /\
  (kt_powers (SUC n) s acc = kt_powers n (s*s) ((s,kdiv s 2)::acc))
End
val _=cv_auto_trans kt_powers_def;
Definition kt_unpack_def:
  (kt_unpack [] (z:int # int) = [z]) /\
  (kt_unpack (sw::ss) z =
    let s=FST sw; h=SND sw; x=FST z; y=SND z; u=kdiv (x+h) s; v=kdiv (y+h) s in
    kt_unpack ss (x-u*s,y-v*s) ++ kt_unpack ss (u,v))
End
val _=cv_auto_trans kt_unpack_def;

Definition lp_roots_def:
  (lp_roots 0 H U z rat step = []) /\
  (lp_roots (SUC n) H U z rat step =
    (kdiv (FST z+kdiv U 2) U,kdiv (SND z+kdiv U 2) U)::
      lp_roots n H U (kr_rot H z rat) (kr_rot H rat step) step)
End
Definition lp_inputs_def:
  (lp_inputs 0 (cap:int) a b = []) /\
  (lp_inputs (SUC n) cap a b =
    let x=kr_mod (6364136223846793005*a+1442695040888963407) (2*cap);
        y=kr_mod (1442695040888963407*b+6364136223846793005) (2*cap)
    in (x-cap,y-cap)::lp_inputs n cap x y)
End
Definition lp_chirp_def:
  (lp_chirp sc [] ws = []) /\
  (lp_chirp sc (z::zs) ws = case ws of []=>[] | w::rest =>
      kr_rot sc z w::lp_chirp sc zs rest)
End
Definition lp_conj_def:
  (lp_conj ([]:(int # int) list) = []) /\
  (lp_conj (z::zs) = (FST z,-SND z)::lp_conj zs)
End
Definition lp_run_def:
  lp_run d B M sc powers xs ws kernel =
    let aa=kt_pack d B (lp_chirp sc xs ws);
        x=FST aa; y=SND aa; u=FST kernel; v=SND kernel;
        p=x*u; q=y*v; t=(x+y)*(u+v);
        pairs=kt_unpack powers (kr_center (p-q) M,kr_center (t-p-q) M)
    in lp_chirp (sc*sc) pairs ws
End
Definition lp_sum_def:
  (lp_sum ([]:(int # int) list) acc=acc) /\
  (lp_sum (z::zs) acc=lp_sum zs (acc+FST z+3*SND z))
End
Definition lp_pick_def:
  (lp_pick (i:num) ([]:(int # int) list)=(0,0)) /\
  (lp_pick i (z::zs)=if i=0 then z else lp_pick (i-1) zs)
End
Definition lp_repeat_def:
  (lp_repeat 0 n d B M sc powers xs ws ker expected acc=acc) /\
  (lp_repeat (SUC r) n d B M sc powers xs ws ker expected acc=
     let ys=lp_run d B M sc powers xs ws ker;
         es=[lp_pick 0 ys;lp_pick 1 ys;lp_pick (n DIV 2) ys;lp_pick (n-1) ys];
         x=kr_mod (lp_sum ys 0) 65537
     in lp_repeat r n d B M sc powers xs ws ker expected
         (if es=expected then acc+x else acc-9999999))
End
Definition lp_top_def:
  lp_top n p cap w d rat step reps expected =
    let sc=(&(2**p):int); U=(&(2**64):int); H=sc*U; B=(&(2**(8*w)):int);
        M=(&(2**(8*w*n)):int)-1;
        ws=lp_roots n H U (H,0) rat step;
        xs=lp_inputs n (cap*sc) 1276261 1534179;
        ker=kt_pack d B (lp_conj ws);
        powers=kt_powers d B [];
        control=kr_mod (FST ker+SND ker+ &(LENGTH ws)+ &(LENGTH xs)) 65537
    in lp_repeat reps n d B M sc powers xs ws ker expected control
End
val _=cv_auto_trans lp_roots_def;
val _=cv_auto_trans lp_inputs_def;
val _=cv_auto_trans lp_chirp_def;
val _=cv_auto_trans lp_conj_def;
val _=cv_auto_trans lp_run_def;
val _=cv_auto_trans lp_sum_def;
val _=cv_auto_trans lp_pick_def;
val _=cv_auto_trans lp_repeat_def;
val _=cv_auto_trans lp_top_def;
