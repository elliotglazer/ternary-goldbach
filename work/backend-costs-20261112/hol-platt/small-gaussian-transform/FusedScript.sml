Theory Fused
Ancestors Gauss SmallFFT sptree cv_std
Libs intLib cv_transLib

val _ = intLib.ARITH_TAC;

Definition fetch_def:
  fetch tab odd r =
    case sptree$lookup (r-1) tab of NONE => (0:int,0:int)
      | SOME cell => if odd then SND cell else FST cell
End

Theorem fetch_from_list:
  fetch (sptree$fromList xs) odd r =
    if r-1 < LENGTH xs then
      (if odd then SND (EL (r-1) xs) else FST (EL (r-1) xs))
    else (0,0)
Proof
  simp[fetch_def,sptreeTheory.lookup_fromList] >> rw[]
QED

Definition crt_res_def:
  crt_res r b = r + 625*((b+16-r MOD 16) MOD 16)
End
Definition pair16_def:
  pair16 tab odd neg r b =
    let x=fetch tab odd (crt_res r b); y=fetch tab odd (crt_res r (16-b)) in
       if neg then subz x y else addz x y
End
Definition slice_def:
  (slice 0 r tab odd neg twist = []) /\
  (slice (SUC n) r tab odd neg twist =
    let a=subz (pair16 tab odd neg r 1) (pair16 tab odd neg r 9);
        b=subz (pair16 tab odd neg r 5) (pair16 tab odd neg r 13);
        ib=if twist then (SND b,-FST b) else (-SND b,FST b) in
    addz a ib :: slice n ((2*r) MOD 625) tab odd neg twist)
End
Definition mirrors_def:
  (mirrors ([]:(int#int) list)=[]) /\
  (mirrors (w::ws)=(FST w,-SND w)::mirrors ws)
End
Definition transform500_def:
  transform500 s h forward backward chirps kernel xs =
    let pre=point s h T xs chirps ++ REPLICATE 524 (0,0);
        mid=point s h T (fft s h forward pre) kernel;
        inv=fft s h backward mid in point s h T (TAKE 500 inv) chirps
End
Definition primitive_rows_def:
  (primitive_rows neg k ([]:(int#int) list) odds=[]) /\
  (primitive_rows neg k (a::rest) odds =
   case odds of [] => [] | b::tail =>
     let xs=primitive_rows neg (k+1) rest tail in
       if k MOD 5 = 0 then xs else
         (if (k MOD 2=0) = neg then b else a)::xs)
End
Definition block_def:
  block s h fwd bwd chirps kernel tab neg twist =
    let ev=transform500 s h fwd bwd chirps kernel (slice 500 1 tab F neg twist);
        od=transform500 s h fwd bwd chirps kernel (slice 500 1 tab T neg twist)
    in primitive_rows neg 0 ev od
End
Definition after_table_def:
  after_table p roots chirps kernel xs =
    let s=(&(2**p):int); h=divs s 2; tab=sptree$fromList xs;
        fwd=root_tree 10 roots; bwd=root_tree 10 (mirrors roots)
    in block s h fwd bwd chirps kernel tab F F ++
       block s h fwd bwd chirps kernel tab F T ++
       block s h fwd bwd chirps kernel tab T F ++
       block s h fwd bwd chirps kernel tab T T
End
Definition fused_def:
  fused p m q roots chirps kernel = after_table p roots chirps kernel (produce 10000 m p q)
End
val _ = cv_auto_trans fused_def;
