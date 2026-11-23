(* Source-only candidate: not built. Ordinary HOL4 definitions and tactics.
   No new axioms, evaluator changes, or claims about execution cost. *)
Theory NaturalOffsetRound
Ancestors BlockRound integer arithmetic
Libs intLib

val _ = intLib.prefer_int ();

val normalize_int = DEPTH_CONV (CHANGED_CONV (fn tm =>
  if type_of tm = ``:int`` then intLib.INT_POLY_CONV tm
  else raise mk_HOL_ERR "NaturalOffsetRound" "normalize_int" "not integer"));

Definition offset_decode_def:
  offset_decode (B:num) (A:num) : int = &A - &B
End

Definition offset_re_def:
  offset_re B S A E C D =
    offset_decode B A * offset_decode S C -
    offset_decode B E * offset_decode S D
End

Definition offset_im_def:
  offset_im B S A E C D =
    offset_decode B A * offset_decode S D +
    offset_decode B E * offset_decode S C
End

Definition re_pos_def:
  re_pos (B:num) S A E C D = (A+E)*C + S*E + B*D + 2*B*S
End
Definition re_neg_def:
  re_neg (B:num) S A E C D = E*(C+D) + S*A + B*C
End
Definition im_pos_def:
  im_pos (B:num) S A E C D = (A+E)*C + A*(D+2*S-C) + 4*B*S
End
Definition im_neg_def:
  im_neg (B:num) S A E C D = 3*S*A + S*E + B*C + B*D
End

(* The executable core shares P across both coordinates. The other affine
   products are retained literally, not counted as free shifts. *)
Definition offset_raw_def:
  offset_raw (B:num) S (A,E) (C,D) =
    let P = (A+E)*C;
        Q = E*(C+D);
        U = A*(D+2*S-C)
    in (P+S*E+B*D+2*B*S - (Q+S*A+B*C),
        P+U+4*B*S - (3*S*A+S*E+B*C+B*D))
End

Definition offset_round_def:
  offset_round (S:num) (R:num) = (2*R+S) DIV (2*S)
End

Definition offset_mul_round_def:
  offset_mul_round (B:num) S x y =
    let (R,I) = offset_raw B S x y
    in (offset_round S R, offset_round S I)
End

Theorem offset_decode_bound:
  !A B:num. A <= 2*B ==> ABS (offset_decode B A) <= &B
Proof
  rpt gen_tac >> strip_tac >>
  `(&A:int) <= &(2*B)` by ASM_SIMP_TAC int_ss [] >>
  REWRITE_TAC [offset_decode_def,INT_ABS_LE] >>
  FULL_SIMP_TAC int_ss [GSYM INT_MUL] >> intLib.ARITH_TAC
QED

Theorem abs_product_box:
  !x y b s:int.
    0 <= b /\ 0 <= s /\ ABS x <= b /\ ABS y <= s ==>
    ABS (x*y) <= b*s
Proof
  rpt gen_tac >> strip_tac >>
  `0 <= ABS x /\ 0 <= ABS y` by SIMP_TAC int_ss [] >>
  `0 <= b - ABS x /\ 0 <= s - ABS y` by intLib.ARITH_TAC >>
  `0 <= (b-ABS x)*ABS y` by metis_tac [INT_LE_MUL] >>
  `0 <= b*(s-ABS y)` by metis_tac [INT_LE_MUL] >>
  REWRITE_TAC [GSYM INT_ABS_MUL] >>
  RULE_ASSUM_TAC (CONV_RULE normalize_int) >>
  CONV_TAC normalize_int >> intLib.ARITH_TAC
QED

Theorem offset_product_bounds:
  !B S A E C D:num.
    A <= 2*B /\ E <= 2*B /\ C <= 2*S /\ D <= 2*S ==>
    -(2 * &B * &S) <= offset_re B S A E C D /\
    offset_re B S A E C D <= 2 * &B * &S /\
    -(2 * &B * &S) <= offset_im B S A E C D /\
    offset_im B S A E C D <= 2 * &B * &S
Proof
  rpt gen_tac >> strip_tac >>
  `ABS (offset_decode B A) <= &B /\
   ABS (offset_decode B E) <= &B /\
   ABS (offset_decode S C) <= &S /\
   ABS (offset_decode S D) <= &S` by metis_tac [offset_decode_bound] >>
  `0 <= (&B:int) /\ 0 <= (&S:int)` by SIMP_TAC int_ss [] >>
  `ABS (offset_decode B A * offset_decode S C) <= &B * &S /\
   ABS (offset_decode B E * offset_decode S D) <= &B * &S /\
   ABS (offset_decode B A * offset_decode S D) <= &B * &S /\
   ABS (offset_decode B E * offset_decode S C) <= &B * &S`
    by metis_tac [abs_product_box] >>
  FULL_SIMP_TAC bool_ss [INT_ABS_LE,offset_re_def,offset_im_def] >>
  RULE_ASSUM_TAC (CONV_RULE normalize_int) >>
  CONV_TAC normalize_int >> intLib.ARITH_TAC
QED

Theorem offset_algebra:
  !B S A E C D:num. C <= 2*S ==>
    (&(re_pos B S A E C D):int) - &(re_neg B S A E C D) =
      offset_re B S A E C D + 2 * &B * &S /\
    (&(im_pos B S A E C D):int) - &(im_neg B S A E C D) =
      offset_im B S A E C D + 2 * &B * &S
Proof
  rpt gen_tac >> strip_tac >>
  `C <= D+2*S` by DECIDE_TAC >>
  `(&(D+2*S-C):int) = &(D+2*S)-&C` by metis_tac [INT_SUB] >>
  ASM_REWRITE_TAC [re_pos_def,re_neg_def,im_pos_def,im_neg_def,
    offset_re_def,offset_im_def,offset_decode_def,GSYM INT_ADD,GSYM INT_MUL] >>
  CONV_TAC normalize_int >> REWRITE_TAC []
QED

Theorem offset_no_underflow:
  !B S A E C D:num.
    A <= 2*B /\ E <= 2*B /\ C <= 2*S /\ D <= 2*S ==>
    re_neg B S A E C D <= re_pos B S A E C D /\
    im_neg B S A E C D <= im_pos B S A E C D
Proof
  rpt gen_tac >> strip_tac >>
  imp_res_tac offset_product_bounds >> imp_res_tac offset_algebra >>
  `(&(re_neg B S A E C D):int) <= &(re_pos B S A E C D) /\
   (&(im_neg B S A E C D):int) <= &(im_pos B S A E C D)`
    by intLib.ARITH_TAC >> FULL_SIMP_TAC int_ss []
QED

Theorem offset_raw_correct:
  !B S A E C D:num.
    A <= 2*B /\ E <= 2*B /\ C <= 2*S /\ D <= 2*S ==>
    (&(FST (offset_raw B S (A,E) (C,D))):int) =
      offset_re B S A E C D + 2 * &B * &S /\
    (&(SND (offset_raw B S (A,E) (C,D))):int) =
      offset_im B S A E C D + 2 * &B * &S
Proof
  rpt gen_tac >> strip_tac >>
  imp_res_tac offset_no_underflow >> imp_res_tac offset_algebra >>
  `offset_raw B S (A,E) (C,D) =
    (re_pos B S A E C D - re_neg B S A E C D,
     im_pos B S A E C D - im_neg B S A E C D)`
    by REWRITE_TAC [offset_raw_def,re_pos_def,re_neg_def,im_pos_def,im_neg_def,
                   LET_THM] >>
  ASM_REWRITE_TAC [FST,SND] >> metis_tac [INT_SUB]
QED

Theorem offset_raw_range:
  !B S A E C D:num.
    A <= 2*B /\ E <= 2*B /\ C <= 2*S /\ D <= 2*S ==>
    FST (offset_raw B S (A,E) (C,D)) <= 4*B*S /\
    SND (offset_raw B S (A,E) (C,D)) <= 4*B*S
Proof
  rpt gen_tac >> strip_tac >>
  imp_res_tac offset_raw_correct >> imp_res_tac offset_product_bounds >>
  `(&(FST (offset_raw B S (A,E) (C,D))):int) <= &(4*B*S) /\
   (&(SND (offset_raw B S (A,E) (C,D))):int) <= &(4*B*S)` by
    (ASM_REWRITE_TAC [GSYM INT_MUL] >>
     CONV_TAC normalize_int >> intLib.ARITH_TAC) >>
  FULL_SIMP_TAC int_ss []
QED

(* This identity is valid for every R, without a coordinate range premise.
   Integer division is floor division. It preserves negative half-ties. *)
Theorem offset_round_correct:
  !B S R:num. 0 < S ==>
    offset_decode (2*B) (offset_round S R) =
    round_scaled (&S) ((&R:int)-2 * &B * &S)
Proof
  rpt gen_tac >> strip_tac >>
  `0 < 2*S` by DECIDE_TAC >>
  `2*R+S = (2*R+S) DIV (2*S) * (2*S) + (2*R+S) MOD (2*S) /\
   (2*R+S) MOD (2*S) < 2*S` by metis_tac [DIVISION] >>
  `(&(2*R+S):int) = &((2*R+S) DIV (2*S)) * &(2*S) +
                         &((2*R+S) MOD (2*S))` by
    (REWRITE_TAC [INT_ADD,INT_MUL,INT_INJ] >> metis_tac []) >>
  `0 <= (&((2*R+S) MOD (2*S)):int) /\
   (&((2*R+S) MOD (2*S)):int) < &(2*S)` by ASM_SIMP_TAC int_ss [] >>
  `~((2 * &S:int) < 0)` by SIMP_TAC int_ss [] >>
  REWRITE_TAC [offset_decode_def,offset_round_def,round_scaled_def,
               GSYM INT_MUL] >>
  CONV_TAC SYM_CONV >> MATCH_MP_TAC INT_DIV_UNIQUE >>
  qexists_tac `&((2*R+S) MOD (2*S))` >>
  ASM_REWRITE_TAC [] >>
  RULE_ASSUM_TAC (REWRITE_RULE [GSYM INT_ADD,GSYM INT_MUL]) >>
  RULE_ASSUM_TAC (CONV_RULE normalize_int) >>
  CONV_TAC normalize_int >> intLib.ARITH_TAC
QED

Theorem offset_mul_round_correct:
  !B S A E C D:num.
    0 < S /\ A <= 2*B /\ E <= 2*B /\ C <= 2*S /\ D <= 2*S ==>
    (offset_decode (2*B) (FST (offset_mul_round B S (A,E) (C,D))),
     offset_decode (2*B) (SND (offset_mul_round B S (A,E) (C,D)))) =
    (round_scaled (&S) (offset_re B S A E C D),
     round_scaled (&S) (offset_im B S A E C D))
Proof
  rpt gen_tac >> strip_tac >> imp_res_tac offset_raw_correct >>
  Cases_on `offset_raw B S (A,E) (C,D)` >>
  FULL_SIMP_TAC bool_ss [FST,SND,offset_mul_round_def,LET_THM] >>
  ASM_SIMP_TAC bool_ss [offset_round_correct,PAIR_EQ] >>
  conj_tac >> AP_TERM_TAC >> intLib.ARITH_TAC
QED

Theorem offset_round_range:
  !B S R:num. 0 < S /\ R <= 4*B*S ==>
    offset_round S R <= 4*B
Proof
  rpt gen_tac >> strip_tac >>
  `0 < 2*S` by DECIDE_TAC >>
  `(&R:int) <= &(4*B*S) /\ 0 < (&S:int)` by ASM_SIMP_TAC int_ss [] >>
  `(&(2*R+S):int) < &((4*B+1)*(2*S))` by
    (REWRITE_TAC [GSYM INT_ADD,GSYM INT_MUL] >>
     RULE_ASSUM_TAC (REWRITE_RULE [GSYM INT_ADD,GSYM INT_MUL]) >>
     RULE_ASSUM_TAC (CONV_RULE normalize_int) >>
     CONV_TAC normalize_int >> intLib.ARITH_TAC) >>
  FULL_SIMP_TAC int_ss [offset_round_def,DIV_LE_X]
QED

(* Sign-sensitive residual: left endpoint included, right endpoint excluded.
   In particular a negative half tie rounds toward positive infinity. *)
Theorem offset_round_residual:
  !B S R:num. 0 < S ==>
    -(&S) <= 2*((&R-2 * &B * &S)-
                 offset_decode (2*B) (offset_round S R) * &S) /\
    2*((&R-2 * &B * &S)-
       offset_decode (2*B) (offset_round S R) * &S) < &S
Proof
  rpt gen_tac >> strip_tac >>
  `0 < (&S:int)` by ASM_SIMP_TAC int_ss [] >>
  ASM_SIMP_TAC bool_ss [offset_round_correct,round_scaled_residual]
QED

Theorem round_scaled_half_tie:
  !s r k:int. 0 < s /\ 2*r = (2*k+1)*s ==>
    round_scaled s r = k+1
Proof
  rpt gen_tac >> strip_tac >>
  `~(2*s < 0)` by intLib.ARITH_TAC >>
  REWRITE_TAC [round_scaled_def] >> MATCH_MP_TAC INT_DIV_UNIQUE >>
  qexists_tac `0` >> ASM_REWRITE_TAC [] >>
  RULE_ASSUM_TAC (CONV_RULE normalize_int) >>
  CONV_TAC normalize_int >> intLib.ARITH_TAC
QED
