Theory C10004FullInteger
Ancestors C10004Packed PackedPrice C10004Shared C10004TraversalBase integer list arithmetic
Libs cv_transLib

Definition full_pair_def:
  full_pair (b:num) (z:num) : int # int =
    (&(z MOD b) - &(b DIV 2), &((z DIV b) MOD b) - &(b DIV 2))
End
Definition full_stages_def:
  (full_stages [] (z:num) = []) /\
  (full_stages ((b:num,m:int)::ss) z =
   (m,full_pair b z)::full_stages ss (z DIV (b*b)))
End
Definition full_coeff_def:
  full_coeff z =
   (full_pair 2 z,
    full_stages [(2,1);(2,1);(2,1);(2,256);(2,1);(2,1);(2,4);(2,64);(2,1);(2,1);(1024,4);(33554432,64);(17179869184,1);(8796093022208,1);(36028797018963968,4);(147573952589676412928,8);(151115727451828646838272,1);(154742504910672534362390528,1);(158456325028528675187087900672,1)] (z DIV 4))
End

Definition full_headblock_def:
  (full_headblock 0 (z:num) = []) /\
  (full_headblock (SUC n) z = full_pair 5192296858534827628530496329220096 z ::
     full_headblock n (z DIV 26959946667150639794667015087019630673637144422540572481103610249216))
End
Definition full_heads_def:
  (full_heads [] = []) /\
  (full_heads (z::zs) = full_headblock 16 z ++ full_heads zs)
End
Definition full_get_def:
  (full_get d n [] = d) /\
  (full_get d 0 (c::cs) = c) /\
  (full_get d (SUC n) (c::cs) = full_get d n cs)
End
Definition full_residue_def:
  full_residue i =
    (2501*(1+2*(i MOD 2)) + 4880*((6 ** ((i DIV 2) MOD 40)) MOD 41) +
     2624*((2 ** (i DIV 80)) MOD 61)) MOD 10004
End
Definition full_src_def:
  full_src cache idx (hr:int,hi:int) =
    let a = full_residue idx;
        k = (2048*a + 10003) DIV 20008;
        row = full_get ((0:int,0:int),[]) k cache;
        t = actual_steps (&(1024*a) - &(10004*k)) (FST row) (SND row)
    in ((hr+FST t+262144)/524288,(hi+SND t+262144)/524288)
End
Definition full_rows_def:
  (full_rows cache idx [] = []) /\
  (full_rows cache idx (h::hs) = full_src cache idx h :: full_rows cache (SUC idx) hs)
End
Definition full_sources_def:
  full_sources coeff heads = full_rows (MAP full_coeff coeff) 0 (full_heads heads)
End
Definition full_checked_def:
  full_checked roots coeff heads phases params <=>
    LENGTH coeff = 1025 /\ LENGTH heads = 300 /\
    shared_checked roots (full_sources coeff heads) phases params
End
Definition full_identity_def:
  full_identity roots coeff heads xs ys <=>
    let got = full_sources coeff heads in
      got = packed_input 16 xs /\ ft_checked roots got = SOME (TAKE 2301 (packed_input 16 ys))
End
val _ = cv_auto_trans full_pair_def;
val _ = cv_auto_trans full_stages_def;
val _ = cv_auto_trans full_coeff_def;
val _ = cv_auto_trans full_headblock_def;
val _ = cv_auto_trans full_heads_def;
val _ = cv_auto_trans full_get_def;
val _ = cv_auto_trans full_residue_def;
val _ = cv_auto_trans full_src_def;
val _ = cv_auto_trans full_rows_def;
val _ = cv_auto_trans full_sources_def;
val _ = cv_auto_trans full_checked_def;
val _ = cv_auto_trans full_identity_def;
