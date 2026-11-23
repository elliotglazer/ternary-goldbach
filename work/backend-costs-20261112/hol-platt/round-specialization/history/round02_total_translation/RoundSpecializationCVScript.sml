(* Separate translation experiment: no closed evaluation or benchmark here.
   Use the proved definition, not the signed-division specification, as the
   translated body.  Keep all generated preconditions explicit. *)
Theory RoundSpecializationCV
Ancestors RoundSpecialization integer
Libs intLib cv_transLib

val _ = intLib.prefer_int ();

val positive_den_pre_def =
  cv_trans_pre "positive_den_div_one_pre" positive_den_div_one_def;

Theorem positive_den_div_one_pre_ok[cv_pre]:
  !n:int. !d:num. 0 < d ==> positive_den_div_one_pre n d
Proof
  simp [positive_den_pre_def]
QED

val one_round_pre_def =
  cv_trans_pre "round_scaled_one_pre" round_scaled_one_def;

Theorem round_scaled_one_pre_ok[cv_pre]:
  !s r:int. 0 < s ==> round_scaled_one_pre s r
Proof
  rpt gen_tac >> strip_tac >>
  `0 <= 2*s` by intLib.ARITH_TAC >>
  `(&(Num (2*s)):int) = 2*s` by ASM_SIMP_TAC int_ss [] >>
  `0 < (&(Num (2*s)):int)` by intLib.ARITH_TAC >>
  `0 < (Num (2*s):num)` by FULL_SIMP_TAC int_ss [] >>
  ASM_SIMP_TAC bool_ss [one_round_pre_def,positive_den_pre_def]
QED

val one_butterfly_pre_def =
  cv_trans_pre "rounded_butterfly_one_pre" rounded_butterfly_one_def;

Theorem rounded_butterfly_one_pre_ok[cv_pre]:
  !s u v w. 0 < s ==> rounded_butterfly_one_pre s u v w
Proof
  rpt gen_tac >> strip_tac >>
  PairCases_on `u` >> PairCases_on `v` >> PairCases_on `w` >>
  ASM_SIMP_TAC bool_ss
    [one_butterfly_pre_def,round_scaled_one_pre_ok]
QED
