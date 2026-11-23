Theory SmallFFT
Ancestors integer list cv_std
Libs intLib cv_transLib
val _=intLib.ARITH_TAC;
Definition divs_def:
  divs (x:int) (s:int) = if s=0 then 0 else x / s
End
Definition addz_def:
  addz (a:int # int) (b:int # int) = (FST a + FST b,SND a + SND b)
End
Definition subz_def:
  subz (a:int # int) (b:int # int) = (FST a - FST b,SND a - SND b)
End
Definition mulz_def:
  mulz s h (w:int # int) (z:int # int) =
    let a=FST w; b=SND w; x=FST z; y=SND z in
    if a=s /\ b=0 then z else if a=0 /\ b=s then (-y,x)
    else if a=0 /\ b= -s then (y,-x) else if x=0 /\ y=0 then (0,0)
    else let u=a*x; v=b*y; t=(a+b)*(x+y) in
      (divs (u-v+h) s,divs (t-u-v+h) s)
End
Definition split_par_def:
  (split_par ([]:(int # int) list) = ([],[])) /\
  (split_par [a] = ([a],[])) /\
  (split_par (a::b::xs) = let rs=split_par xs in (a::FST rs,b::SND rs))
End
Definition root_tree_def:
  (root_tree 0 ws = []) /\
  (root_tree (SUC d) ws = ws::root_tree d (FST (split_par ws)))
End
Definition merge_fft_def:
  (merge_fft s h [] xs ys = ([],[])) /\
  (merge_fft s h (w::ws) xs ys =
     case xs of [] => ([],[]) | a::aa => case ys of [] => ([],[]) | b::bb =>
       let t=mulz s h w b; rs=merge_fft s h ws aa bb in
       (addz a t::FST rs,subz a t::SND rs))
End
Definition fft_def:
  (fft s h [] xs = xs) /\
  (fft s h (ws::tree) xs =
     let parts=split_par xs;
         rs=merge_fft s h ws (fft s h tree (FST parts)) (fft s h tree (SND parts))
     in FST rs ++ SND rs)
End
Definition point_def:
  (point s h flag [] ys = []) /\
  (point s h flag (x::xs) ys = case ys of []=>[] | y::tail=>
     (if flag then mulz s h y x else addz x y)::point s h flag xs tail)
End
Definition work_def:
  work mode s h tree ws xs =
    if mode=0:num then fft s h tree xs else point s h (mode=1) xs ws
End
Definition vec_eq_def:
  (vec_eq ([]:(int # int) list) ys <=> ys=[]) /\
  (vec_eq (x::xs) ys <=> case ys of []=>F | y::tail=>x=y /\ vec_eq xs tail)
End
Definition loop_def:
  (loop 0 mode s h tree ws flag xs ex us eu = T) /\
  (loop (SUC r) mode s h tree ws flag xs ex us eu =
    (vec_eq (if flag then work mode s h tree ws xs else ex) ex /\
     loop r mode s h tree ws flag us eu xs ex))
End
Definition safe_mod_def:
  safe_mod (a:int) b = if b=0 then 0 else a % b
End
Definition inputs_def:
  (inputs 0 cap a b = []) /\
  (inputs (SUC n) cap a b =
    let u=safe_mod (6364136223846793005*a+1442695040888963407) (2*cap);
        v=safe_mod (1442695040888963407*b+6364136223846793005) (2*cap)
    in (u-cap,v-cap)::inputs n cap u v)
End
Definition roots_def:
  (roots 0 s h u z step = []) /\
  (roots (SUC n) s h u z step =
    (divs (FST z + divs u 2) u,divs (SND z + divs u 2) u)::
      roots n s h u (mulz s h step z) step)
End
Definition digest_def:
  (digest ([]:(int # int) list) (a:int) b = (a,b)) /\
  (digest (x::xs) a b = digest xs
      (safe_mod (1000003*a+FST x) 2305843009213693951)
      (safe_mod (1000033*b+SND x) 2305843009213693951))
End
Definition panel_def:
  panel mode d p e fill step flag reps cx cu =
    let n=2**d; s=(&(2**p):int); h=divs s 2; u=(&(2**72):int); high=s*u;
        cap=s * &(2**e);
        ws=roots (if mode=0 then n DIV 2 else n) high (divs high 2) u (high,0) step;
        tree=root_tree d ws;
        zs=REPLICATE (n-fill) ((0:int),(0:int));
        xs=inputs fill cap 1276261 1534179 ++ zs;
        us=inputs fill cap 7191061 7129357 ++ zs;
        ex=work mode s h tree ws xs; eu=work mode s h tree ws us
    in (digest ex 0 0=cx /\ digest eu 0 0=cu /\ loop reps mode s h tree ws flag xs ex us eu)
End
val _=cv_auto_trans panel_def;
