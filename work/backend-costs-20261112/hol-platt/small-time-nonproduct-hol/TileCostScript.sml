Theory TileCost
Ancestors integer arithmetic
Libs cv_transLib intLib

Definition lane_def:
  lane w s = if EVEN s then (&(2 ** (w-3) + s):int) else -(&(2 ** (w-3) + s))
End
Definition pack_def:
  (pack 0 w s = lane w s) /\
  (pack (SUC k) w s =
   pack k w (2*s+1) + &(2 ** (w*2**k))*pack k w (2*s+2))
End
(* Repeated blocks give dense signed operands in O(log T) recursive calls. *)
Definition dense_def:
  (dense 0 w s = lane w s) /\
  (dense (SUC k) w s = let z=dense k w s in
    z + &(2 ** (w*2**k))*(if EVEN k then -z else z))
End
Definition split_def:
  split (b:int) z = if b=0 then (z,0) else let hi=(z+b/2)/b in (z-hi*b,hi)
End
val split_p_def = cv_trans_pre "tile_split_pre" split_def;
Theorem split_ok[cv_pre]:
  !b z. tile_split_pre b z
Proof
  simp[split_p_def] >> intLib.ARITH_TAC
QED
Definition sample_def:
  sample (a:int) b c s =
    let r=a-b; i=c-a-b;
        u= r * (&1208925819614629174706176 + &s) -
           i * (&604462909807314587353088 - &s)
    in if (u + &1208925819614629174706176) / &2417851639229258349412352 < 0 then 1:num else 0
End
val sample_p_def = cv_trans_pre "tile_sample_pre" sample_def;
Theorem sample_ok[cv_pre]:
  !a b c s. tile_sample_pre a b c s
Proof
  simp[sample_p_def]
QED
Definition consume_def:
  (consume 0 w a b c s = sample a b c s) /\
  (consume (SUC k) w a b c s =
   let base = &(2 ** (w*2**k)):int;
       (al,ah)=split base a; (bl,bh)=split base b; (cl,ch)=split base c
   in consume k w al bl cl (2*s+1) + consume k w ah bh ch (2*s+2))
End
Definition benchfn_def:
  benchfn (mode:num) (k:num) (w:num) (s:num) =
    let a=dense k w s; b=dense k w (s+1); c=dense k w (s+2) in
    if mode=0 then (a+b+c<>0)
    else if mode=1 then pack k w s <> 0
    else if mode=2 then
      (let base= &(2 ** (w*2**k)):int; z=a+base*b;
           (lo,hi)=split base z in lo+c+hi<>0)
    else if mode=3 then
      (let base= &(2 ** (w*2**k)):int; z=a+base*b in z+c<>0)
    else if mode=4 then consume k w a b c s <= 2**k
    else a+b+c+a<>0
End
val _ = cv_auto_trans benchfn_def;


