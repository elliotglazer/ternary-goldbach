let ibutterfly = new_definition
 `Ibutterfly (s:int) (b:int) (ur:int) (ui:int) (vr:int) (vi:int) (wr:int) (wi:int)
             (pr:int) (pi:int) (mr:int) (mi:int) <=>
  Iwithin b ur /\ Iwithin b ui /\ Iwithin b vr /\ Iwithin b vi /\
  Iwithin s wr /\ Iwithin s wi /\
  Iwithin (&4*b) pr /\ Iwithin (&4*b) pi /\ Iwithin (&4*b) mr /\ Iwithin (&4*b) mi /\
  Iwithin s (&2*(ur*s+(vr*wr-vi*wi)-pr*s)) /\
  Iwithin s (&2*(ui*s+(vr*wi+vi*wr)-pi*s)) /\
  Iwithin s (&2*(ur*s-(vr*wr-vi*wi)-mr*s)) /\
  Iwithin s (&2*(ui*s-(vr*wi+vi*wr)-mi*s))`;;
let int_normalize = DEPTH_CONV (CHANGED_CONV (fun tm ->
  if type_of tm = `:int` then INT_POLY_CONV tm else failwith "not integer"));;
let residual_pair = prove
 (`!s a r p m:int. p+m = &2*a /\ --s <= &2*(r-(p-a)*s) /\
    &2*(r-(p-a)*s) < s ==>
    Iwithin s (&2*(a*s+r-p*s)) /\ Iwithin s (&2*(a*s-r-m*s))`,
  REPEAT GEN_TAC THEN STRIP_TAC THEN
  SUBGOAL_THEN `p*s + m*s = &2*(a*s):int` ASSUME_TAC THENL
   [ASM_REWRITE_TAC [GSYM INT_ADD_RDISTRIB] THEN CONV_TAC INT_RING;ALL_TAC] THEN
  REWRITE_TAC [iwithin] THEN
  RULE_ASSUM_TAC (CONV_RULE int_normalize) THEN
  CONV_TAC int_normalize THEN ASM_INT_ARITH_TAC);;
let three_real = prove
 (`(wr:int)*(vr+vi)-vi*(wr+wi) = vr*wr-vi*wi`,CONV_TAC INT_RING);;
let three_imag = prove
 (`(wr:int)*(vr+vi)+vr*(wi-wr) = vr*wi+vi*wr`,CONV_TAC INT_RING);;
let icheck_sound = prove
 (`Icheck s b ur ui vr vi wr wi pr pi mr mi ==>
   Ibutterfly s b ur ui vr vi wr wi pr pi mr mi`,
  REWRITE_TAC [icheck;ibutterfly;LET_DEF;LET_END_DEF;three_real;three_imag] THEN
  STRIP_TAC THEN ASM_REWRITE_TAC [] THEN
  MP_TAC (SPECL [`s:int`;`ur:int`;`vr*wr-vi*wi:int`;`pr:int`;`mr:int`] residual_pair) THEN
  MP_TAC (SPECL [`s:int`;`ui:int`;`vr*wi+vi*wr:int`;`pi:int`;`mi:int`] residual_pair) THEN
  ASM_REWRITE_TAC [] THEN MESON_TAC []);;
check_axioms ();;
print_string "RESIDUAL_SOUND_DONE\n";;
