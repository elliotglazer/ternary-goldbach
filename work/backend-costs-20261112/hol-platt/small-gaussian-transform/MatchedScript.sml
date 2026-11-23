Theory Matched
Ancestors Fused
Libs intLib cv_transLib

val _ = intLib.ARITH_TAC;

Definition fold_residue_def:
  fold_residue tab odd r b =
    let n=crt_res r b; x=fetch tab odd n; y=fetch tab odd (10000-n) in
        if odd then subz x y else addz x y
End
Definition folded_slice_def:
  (folded_slice 0 r tab odd twist lift = []) /\
  (folded_slice (SUC n) r tab odd twist lift =
   let a=subz (fold_residue tab odd r 1) (fold_residue tab odd r 9);
       b=subz (fold_residue tab odd r 5) (fold_residue tab odd r 13);
       ib=if twist then (SND b,-FST b) else (-SND b,FST b);
       z=addz a ib in
       (lift*FST z,lift*SND z)::folded_slice n ((2*r) MOD 625) tab odd twist lift)
End
Definition matched_pair_def:
  matched_pair s h fwd bwd chirps kernel tab lift twist =
    let evens=transform500 s h fwd bwd chirps kernel (folded_slice 500 1 tab F twist lift);
        odds=transform500 s h fwd bwd chirps kernel (folded_slice 500 1 tab T twist lift)
    in (primitive_rows F 0 evens odds, primitive_rows T 0 evens odds)
End
Definition matched_after_def:
  matched_after p extra roots chirps kernel xs =
    let s=(&(2**(p+extra)):int); h=divs s 2; lift=(&(2**extra):int);
        tab=sptree$fromList xs; fwd=root_tree 10 roots; bwd=root_tree 10 (mirrors roots);
        a=matched_pair s h fwd bwd chirps kernel tab lift F;
        b=matched_pair s h fwd bwd chirps kernel tab lift T
    in FST a ++ FST b ++ SND a ++ SND b
End
Definition matched_def:
  matched p extra m q roots chirps kernel =
    matched_after p extra roots chirps kernel (produce 10000 m p q)
End
val _ = cv_auto_trans matched_def;
