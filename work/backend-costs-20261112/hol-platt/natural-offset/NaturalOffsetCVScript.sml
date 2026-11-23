(* Unbuilt source candidate. Translate only executable natural operations.
   Signed interpretation follows from HOL equivalences, not an evaluator oracle. *)
Theory NaturalOffsetCV
Ancestors NaturalOffsetRound option
Libs intLib cv_transLib

val _ = intLib.prefer_int ();

Definition offset_valid_def:
  offset_valid (B:num) S (A,E) (C,D) <=>
    0 < S /\ A <= 2*B /\ E <= 2*B /\ C <= 2*S /\ D <= 2*S
End
Definition offset_checked_def:
  offset_checked (B:num) S x y =
    if offset_valid B S x y then SOME (offset_mul_round B S x y)
    else NONE
End
(* Q has offset 2B. Return to offset B only if its actual value fits.
   NONE is inconclusive for this bound. There is no clamping. *)
Definition offset_rebias_def:
  offset_rebias (B:num) (Qr,Qi) =
    if B <= Qr /\ Qr <= 3*B /\ B <= Qi /\ Qi <= 3*B
    then SOME (Qr-B,Qi-B) else NONE
End
Definition offset_checked_rebias_def:
  offset_checked_rebias (B:num) S x y =
    case offset_checked B S x y of
      NONE => NONE
    | SOME q => offset_rebias B q
End

Theorem offset_checked_sound:
  !B S x y q. offset_checked B S x y = SOME q ==>
    offset_valid B S x y /\
    (offset_decode (2*B) (FST q), offset_decode (2*B) (SND q)) =
    (round_scaled (&S)
       (offset_re B S (FST x) (SND x) (FST y) (SND y)),
     round_scaled (&S)
       (offset_im B S (FST x) (SND x) (FST y) (SND y)))
Proof
  rpt gen_tac >> PairCases_on `x` >> PairCases_on `y` >>
  Cases_on `offset_valid B S (x0,x1) (y0,y1)` >>
  ASM_SIMP_TAC bool_ss [offset_checked_def,optionTheory.SOME_11,
                       optionTheory.NOT_NONE_SOME] >>
  strip_tac >> fs [offset_valid_def] >>
  metis_tac [offset_mul_round_correct]
QED

Theorem offset_rebias_coordinate:
  !B Q:num. B <= Q /\ Q <= 3*B ==>
    Q-B <= 2*B /\
    offset_decode B (Q-B) = offset_decode (2*B) Q
Proof
  rpt gen_tac >> strip_tac >> conj_tac >- DECIDE_TAC >>
  `(&(Q-B):int) = &Q-&B` by metis_tac [INT_SUB] >>
  ASM_REWRITE_TAC [offset_decode_def,GSYM INT_MUL] >> intLib.ARITH_TAC
QED

Theorem offset_rebias_sound:
  !B q r. offset_rebias B q = SOME r ==>
    FST r <= 2*B /\ SND r <= 2*B /\
    (offset_decode B (FST r),offset_decode B (SND r)) =
    (offset_decode (2*B) (FST q),offset_decode (2*B) (SND q))
Proof
  rpt gen_tac >> PairCases_on `q` >> PairCases_on `r` >>
  REWRITE_TAC [offset_rebias_def] >>
  Cases_on `B <= q0 /\ q0 <= 3*B /\ B <= q1 /\ q1 <= 3*B` >>
  ASM_SIMP_TAC bool_ss [optionTheory.SOME_11,optionTheory.NOT_NONE_SOME,
                       PAIR_EQ,FST,SND] >>
  rpt strip_tac >> fs [] >> metis_tac [offset_rebias_coordinate]
QED

Theorem offset_checked_rebias_sound:
  !B S x y r. offset_checked_rebias B S x y = SOME r ==>
    offset_valid B S x y /\ FST r <= 2*B /\ SND r <= 2*B /\
    (offset_decode B (FST r),offset_decode B (SND r)) =
    (round_scaled (&S)
       (offset_re B S (FST x) (SND x) (FST y) (SND y)),
     round_scaled (&S)
       (offset_im B S (FST x) (SND x) (FST y) (SND y)))
Proof
  rpt gen_tac >> Cases_on `offset_checked B S x y` >>
  ASM_SIMP_TAC bool_ss [offset_checked_rebias_def,optionTheory.option_CLAUSES] >>
  metis_tac [offset_checked_sound,offset_rebias_sound]
QED

(* Natural DIV is total. A total CV representation does not remove the
   positive-denominator and box premises of the semantic equivalence.
   The checked entry tests those premises. No signed specification is registered. *)
val _ = cv_trans offset_raw_def;
val _ = cv_trans offset_round_def;
val _ = cv_trans offset_mul_round_def;
val _ = cv_trans offset_valid_def;
val _ = cv_trans offset_checked_def;
val _ = cv_trans offset_rebias_def;
val _ = cv_trans offset_checked_rebias_def;
val _ = print "NATURAL_OFFSET_TRANSLATION_DONE_GENERIC_ONLY\n";
