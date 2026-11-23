Theory SparseHead
Ancestors GridSigns CountReceipt KernelWeights sptree integer list
Libs cv_transLib intLib

(* Bit j names the j-th input of this 64-slot raw block. *)
Definition load_row_def:
  (load_row 0 pos mask bits stride unit tab = if mask=0 /\ bits=0 then SOME tab else NONE) /\
  (load_row (SUC len) pos mask bits stride unit tab =
    if mask=0 then (if bits=0 then SOME tab else NONE) else
    if mask MOD 2=0 then load_row len (SUC pos) (mask DIV 2) bits stride unit tab else
      load_row len (SUC pos) (mask DIV 2) (bits DIV stride) stride unit
        (sptree$insert pos ((&(bits MOD stride)- &(stride DIV 2)):int,unit:num) tab))
End
Definition load_grid_def:
  (load_grid [] base tab = if base>=57678 then SOME tab else NONE) /\
  (load_grid ((mask,w,e,bits)::rows) base tab =
    if base>=57678 \/ w=0 \/ 256<w \/ 255<e then NONE else
    case load_row (MIN 64 (57678-base)) base mask bits (2**w) (2**e) tab of NONE => NONE
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

Definition panel_radius_def:
  panel_radius (r:num) e <=>
    let n=262144; j=34134; c=(2*j+1)*(2*1025641**2+1);
        a=512*4*3**78*2**80; h=r DIV 2;
        d=(7*n)**r*FACT r; m=c*(44*j)**r*(FACT h)**2
    in EVEN r /\ 0<r /\ 10*a*d + 2**220*(5*n*d + a*m) <= e*a*d
End
val _=cv_auto_trans panel_radius_def;
Definition panel_valid_def:
  (panel_valid ([]:(num#num#num#num#int list)list) <=> T) /\
  (panel_valid ((r,o1,d,e,ws)::ks) <=>
     KernelWeights$kernel_ok r o1 (&d) ws /\ panel_radius r e /\ panel_valid ks)
End

Definition observation_def:
  observation kernels (rows,jobs,mb,m,ab,a,ea,eb) =
    let rad=54315217; cut=232574976; last=235196416 in
    case load_grid rows 0 sptree$LN of NONE => NONE | SOME tab =>
    case GridSigns$repairs tab (sptree$fromList kernels) jobs sptree$LN of NONE => NONE
    | SOME fixes =>
      if (2*(512*4*3**78*2**80)+5*262144*2**220 <= rad*(512*4*3**78*2**80)) /\ 0<ea /\ ea<=2 /\ 0<eb /\ eb<=2 /\
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

Definition pair_from_heads_def:
  pair_from_heads kernels h phase bound left right <=>
    panel_valid kernels /\
    case (observation kernels left,observation kernels right) of
      (SOME (ml,al),SOME (mr,ar)) =>
        CountReceipt$pair_test h phase bound (SOME ml) (SOME al) (SOME mr) (SOME ar)
      | _ => F
End
