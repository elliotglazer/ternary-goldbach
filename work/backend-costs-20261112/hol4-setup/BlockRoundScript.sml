(* Experimental output-producing arithmetic. This file is not a certified FFT:
   coefficient/root enclosures and whole-network propagation are separate. *)
Theory BlockRound
Ancestors StageCheck integer list
Libs intLib cv_transLib

val _ = intLib.prefer_int ();

Definition round_scaled_def:
  round_scaled (s:int) (r:int) = (2*r+s) / (2*s)
End

val int_normalize = DEPTH_CONV (CHANGED_CONV (fn tm =>
  if type_of tm = ``:int`` then intLib.INT_POLY_CONV tm
  else raise mk_HOL_ERR "BlockRound" "int_normalize" "not an integer"));

Theorem round_scaled_residual:
  !s r:int. 0 < s ==>
    -s <= 2*(r-round_scaled s r*s) /\
    2*(r-round_scaled s r*s) < s
Proof
  rpt gen_tac >> strip_tac >>
  `~(2*s=0)` by intLib.ARITH_TAC >>
  `~(2*s<0)` by intLib.ARITH_TAC >>
  mp_tac (Q.SPEC `2*r+s`
    (MATCH_MP (Q.SPEC `2*s` INT_DIVISION) (ASSUME ``~(2*s=0):bool``))) >>
  ASM_REWRITE_TAC [round_scaled_def] >> strip_tac >>
  RULE_ASSUM_TAC (CONV_RULE int_normalize) >>
  CONV_TAC int_normalize >> intLib.ARITH_TAC
QED

Definition rounded_butterfly_def:
  rounded_butterfly (s:int) (ur,ui) (vr,vi) (wr,wi) =
    let t = wr*(vr+vi);
        u = vi*(wr+wi);
        v = vr*(wi-wr);
        qr = round_scaled s (t-u);
        qi = round_scaled s (t+v)
    in ((ur+qr,ui+qi),(ur-qr,ui-qi))
End

Definition local_residual_def:
  local_residual (s:int) (ur,ui) (vr,vi) (wr,wi) ((pr,pi),(mr,mi)) =
    (within s (2*(ur*s+(vr*wr-vi*wi)-pr*s)) /\
    within s (2*(ui*s+(vr*wi+vi*wr)-pi*s)) /\
    within s (2*(ur*s-(vr*wr-vi*wi)-mr*s)) /\
    within s (2*(ui*s-(vr*wi+vi*wr)-mi*s)))
End

Theorem rounded_butterfly_residual:
  !s ur ui vr vi wr wi. 0 < s ==>
    local_residual s (ur,ui) (vr,vi) (wr,wi)
      (rounded_butterfly s (ur,ui) (vr,vi) (wr,wi))
Proof
  rpt gen_tac >> strip_tac >>
  SIMP_TAC bool_ss [rounded_butterfly_def,local_residual_def,LET_THM,
                   three_real,three_imag,within_def] >>
  mp_tac (Q.SPECL [`s`,`vr*wr-vi*wi`] round_scaled_residual) >>
  mp_tac (Q.SPECL [`s`,`vr*wi+vi*wr`] round_scaled_residual) >>
  ASM_REWRITE_TAC [] >> rpt strip_tac >>
  RULE_ASSUM_TAC (CONV_RULE int_normalize) >>
  CONV_TAC int_normalize >> intLib.ARITH_TAC
QED

val round_pre_def = cv_trans_pre "round_scaled_pre" round_scaled_def;

Theorem round_scaled_pre_ok[cv_pre]:
  0 < s ==> round_scaled_pre s r
Proof
  simp [round_pre_def] >> intLib.ARITH_TAC
QED

val butterfly_pre_def =
  cv_trans_pre "rounded_butterfly_pre" rounded_butterfly_def;

Theorem rounded_butterfly_pre_ok[cv_pre]:
  0 < s ==> rounded_butterfly_pre s u v w
Proof
  PairCases_on `u` >> PairCases_on `v` >> PairCases_on `w` >>
  simp [butterfly_pre_def,round_pre_def] >> intLib.ARITH_TAC
QED

val _ = print "HOL4_ROUNDED_BUTTERFLY_THEORY_DONE\n";
