Theory SparseCount
Ancestors GridSigns CountReceipt KernelWeights sptree integer list
Libs cv_transLib intLib

(* Bit j names the j-th input of this 64-slot raw block. *)
Definition load_row_def:
  (load_row 0 base mask xs tab = if mask=0 /\ xs=[] then SOME tab else NONE) /\
  (load_row (SUC n) base mask xs tab =
    if mask=0 then (if xs=[] then SOME tab else NONE) else
    if mask MOD 2=0 then load_row n (base+1) (mask DIV 2) xs tab else
    case xs of [] => NONE | x::rest =>
      if x < 2**256 then load_row n (base+1) (mask DIV 2) rest
        (sptree$insert base ((&x - &(2**255)):int,1:num) tab)
      else NONE)
End

Definition load_grid_def:
  (load_grid [] base tab = if base>=85121 then SOME tab else NONE) /\
  (load_grid ((mask,xs)::rows) base tab =
    if base>=85121 then NONE else
    case load_row (MIN 64 (85121-base)) base mask xs tab of NONE => NONE
    | SOME t => load_grid rows (base+64) t)
End

(* Each byte is a coarse-grid delta. Escape 255 precedes a 32-bit subtick.
   Polarity alternates. The remaining code must be zero at a chunk boundary. *)
Definition chunk_def:
  (chunk 0 code prev (bit:num) acc = if code=0 then SOME (prev,bit,acc) else NONE) /\
  (chunk (SUC n) code prev bit acc =
    let tag=code MOD 256; rest=code DIV 256;
        t=if tag=255 then rest MOD (2**32) else (prev DIV 4096+tag)*4096;
        tail=if tag=255 then rest DIV (2**32) else rest
    in if prev<t then chunk n tail t (1-bit) ((t,1:num,bit)::acc) else NONE)
End

Definition unpack_def:
  (unpack [] prev bit acc = SOME (REVERSE acc)) /\
  (unpack ((n,w)::chunks) prev bit acc =
     if 0<n /\ n<=32 /\ bit<=1 then
       case chunk n w prev bit acc of NONE => NONE | SOME (u,v,z) => unpack chunks u v z
     else NONE)
End

Definition region_def:
  region tab repairs rad lower upper bit words =
    case unpack words lower bit [] of NONE => NONE | SOME packets =>
      if GridSigns$match_runs tab repairs rad packets then FullCount$scan_between lower upper packets
      else NONE
End

Definition observation_def:
  observation kernels (rows,jobs,mb,m,ab,a,ea,eb) =
    let rad=519575974158994; cut=344981504; last=347602944 in
    case load_grid rows 0 sptree$LN of NONE => NONE | SOME tab =>
    case GridSigns$repairs tab (sptree$fromList kernels) jobs sptree$LN of NONE => NONE
    | SOME fixes =>
      if GridSigns$coarse_radius_ok rad /\ 0<ea /\ ea<=2 /\ 0<eb /\ eb<=2 /\
         GridSigns$sign_at tab fixes rad 0=ea /\ GridSigns$sign_at tab fixes rad 1=ea /\
         GridSigns$sign_at tab fixes rad cut=eb /\ GridSigns$sign_at tab fixes rad (cut-1)=eb /\
         GridSigns$sign_at tab fixes rad last<>0 then
        case (region tab fixes rad 0 cut mb m, region tab fixes rad cut last ab a) of
          (SOME v,SOME w) => SOME (v,w) | _ => NONE
      else NONE
End

Definition exact_observation_def:
  exact_observation kernels data result <=> observation kernels data = SOME result
End
val _=cv_auto_trans exact_observation_def;

Definition pair_from_raw_def:
  pair_from_raw kernels h phase bound left right <=>
    GridSigns$valid_kernels kernels /\
    case (observation kernels left,observation kernels right) of
      (SOME (ml,al),SOME (mr,ar)) =>
        CountReceipt$pair_test h phase bound (SOME ml) (SOME al) (SOME mr) (SOME ar)
      | _ => F
End
