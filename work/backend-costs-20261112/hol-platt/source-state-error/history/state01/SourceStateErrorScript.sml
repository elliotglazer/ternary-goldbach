(* Error propagation for the actual persistent integer source program.
   Initial/step accuracy and exact analytic time-step identities are explicit
   premises here. This module does not claim to certify those producers. *)
Theory SourceStateError
Ancestors SourceArithmetic RawPairRound complex real intreal integer arithmetic
Libs realLib RealField

val _ = realLib.prefer_real ();

Theorem ss_modu_add_square:
  !z w:complex.
    modu (z+w) pow 2 = modu z pow 2 + modu w pow 2 + 2*RE (z*conj w)
Proof
  rpt gen_tac >>
  REWRITE_TAC [MODU_POW2,complex_add,complex_mul,conj,RE,IM,
               pairTheory.FST,pairTheory.SND,POW_2] >>
  RealField.REAL_ASM_ARITH_TAC
QED

Theorem ss_modu_triangle:
  !z w:complex. modu (z+w) <= modu z + modu w
Proof
  rpt gen_tac >>
  `RE (z*conj w) <= modu z * modu w` by
    (mp_tac (Q.SPEC `z*conj w` RE_IM_LE_MODU) >>
     mp_tac (Q.SPEC `RE (z*conj w)` ABS_LE) >>
     REWRITE_TAC [MODU_MUL,MODU_CONJ] >> RealField.REAL_ASM_ARITH_TAC) >>
  `modu (z+w) pow 2 <= (modu z + modu w) pow 2` by
    (REWRITE_TAC [ss_modu_add_square,POW_2] >> RealField.REAL_ASM_ARITH_TAC) >>
  `0 <= modu (z+w) /\ 0 <= modu z + modu w` by
    (simp [MODU_POS,REAL_LE_ADD]) >>
  mp_tac (Q.SPECL [`modu (z+w) pow 2`,`(modu z + modu w) pow 2`] SQRT_MONO_LE) >>
  ASM_SIMP_TAC bool_ss [REAL_LE_POW2,POW_2_SQRT]
QED

Theorem ss_modu_sub_triangle:
  !x y z:complex. modu (x-z) <= modu (x-y) + modu (y-z)
Proof
  rpt gen_tac >>
  mp_tac (Q.SPECL [`x-y`,`y-z`] ss_modu_triangle) >>
  REWRITE_TAC [COMPLEX_SUB_TRIANGLE]
QED

Definition source_pair_value_def:
  source_pair_value (grid:num) (q:int#int) = pair_value (&grid) q
End

Theorem ss_source_mul_eq:
  !scale u v. source_mul scale u v = four_product_round (&scale) u v
Proof
  rpt gen_tac >> Cases_on `u` >> Cases_on `v` >>
  REWRITE_TAC [source_mul_def,four_product_round_def]
QED

Theorem ss_source_mul_error:
  !grid scale u v. 0 < grid /\ 0 < scale ==>
    modu (source_pair_value grid (source_mul scale u v) -
          source_pair_value grid u * source_pair_value scale v) <= 1 / (&grid:real)
Proof
  rpt gen_tac >> strip_tac >> Cases_on `u` >> Cases_on `v` >>
  REWRITE_TAC [source_pair_value_def,ss_source_mul_eq] >>
  `0 < (&grid:int) /\ 0 < (&scale:int)` by simp [] >>
  mp_tac (Q.SPECL [`&grid:int`,`&scale:int`,`q:int`,`r:int`,`q':int`,`r':int`]
    four_product_round_error) >>
  ASM_SIMP_TAC bool_ss [real_of_int_num]
QED

Theorem ss_step_norm:
  !v w:complex. !eps:real.
    modu w = 1 /\ modu (v-w) <= eps ==> modu v <= 1+eps
Proof
  rpt gen_tac >> strip_tac >>
  mp_tac (Q.SPECL [`v-w`,`w`] ss_modu_triangle) >>
  REWRITE_TAC [COMPLEX_SUB_ADD] >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem ss_product_error:
  !u v z w:complex. !err eps:real.
    0 <= err /\ 0 <= eps /\ modu z <= 1 /\ modu w = 1 /\
    modu (u-z) <= err /\ modu (v-w) <= eps ==>
    modu (u*v-z*w) <= (1+eps)*err + eps
Proof
  rpt gen_tac >> strip_tac >>
  `modu v <= 1+eps` by metis_tac [ss_step_norm] >>
  `u*v-z*w = (u-z)*v + z*(v-w)` by
    (REWRITE_TAC [COMPLEX_RE_IM_EQ,complex_mul,complex_add,complex_sub,
                  complex_neg,RE,IM,pairTheory.FST,pairTheory.SND] >>
     conj_tac >> RealField.REAL_ASM_ARITH_TAC) >>
  `modu (u-z) * modu v <= err * (1+eps)` by
    (match_mp_tac REAL_LE_MUL2 >> simp [MODU_POS]) >>
  `modu z * modu (v-w) <= 1*eps` by
    (match_mp_tac REAL_LE_MUL2 >> simp [MODU_POS]) >>
  mp_tac (Q.SPECL [`(u-z)*v`,`z*(v-w)`] ss_modu_triangle) >>
  ASM_REWRITE_TAC [MODU_MUL] >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem ss_source_update_error:
  !grid scale u v z w err eps.
    0 < grid /\ 0 < scale /\ 0 <= err /\ 0 <= eps /\
    modu z <= 1 /\ modu w = 1 /\
    modu (source_pair_value grid u-z) <= err /\
    modu (source_pair_value scale v-w) <= eps ==>
    modu (source_pair_value grid (source_mul scale u v)-z*w)
      <= (1+eps)*err + eps + 1 / (&grid:real)
Proof
  rpt gen_tac >> strip_tac >>
  `modu (source_pair_value grid (source_mul scale u v) -
          source_pair_value grid u * source_pair_value scale v) <= 1 / (&grid:real)`
    by metis_tac [ss_source_mul_error] >>
  `modu (source_pair_value grid u * source_pair_value scale v - z*w)
       <= (1+eps)*err + eps` by metis_tac [ss_product_error] >>
  mp_tac (Q.SPECL [`source_pair_value grid (source_mul scale u v)`,
    `source_pair_value grid u * source_pair_value scale v`,`z*w`] ss_modu_sub_triangle) >>
  RealField.REAL_ASM_ARITH_TAC
QED

Definition source_error_envelope_def:
  (source_error_envelope (initialError:real) (stepError:real) (roundError:real) 0 = initialError) /\
  (source_error_envelope initialError stepError roundError (SUC n) =
    (1+stepError)*source_error_envelope initialError stepError roundError n + stepError + roundError)
End

Theorem ss_envelope_nonneg:
  !initialError stepError roundError.
    0 <= initialError /\ 0 <= stepError /\ 0 <= roundError ==>
    !n. 0 <= source_error_envelope initialError stepError roundError n
Proof
  rpt gen_tac >> strip_tac >> Induct >>
  ASM_SIMP_TAC bool_ss [source_error_envelope_def] >>
  `0 <= 1+stepError` by RealField.REAL_ASM_ARITH_TAC >>
  metis_tac [REAL_LE_MUL,REAL_LE_ADD]
QED

Theorem ss_exact_state_norm:
  !exact:num->complex. !w:complex.
    modu (exact 0) <= 1 /\ modu w = 1 /\
    (!n. exact (SUC n) = exact n * w) ==>
    !n. modu (exact n) <= 1
Proof
  rpt gen_tac >> strip_tac >> Induct >>
  ASM_SIMP_TAC bool_ss [MODU_MUL,REAL_MUL_RID]
QED

Theorem source_state_error_from_initial_and_step:
  !grid scale initial step (exact:num->complex) w initialError stepError.
    0 < grid /\ 0 < scale /\ 0 <= initialError /\ 0 <= stepError /\
    modu (exact 0) <= 1 /\ modu w = 1 /\
    (!n. exact (SUC n) = exact n * w) /\
    modu (source_pair_value grid initial-exact 0) <= initialError /\
    modu (source_pair_value scale step-w) <= stepError ==>
    !n. modu (source_pair_value grid (source_state scale initial step n)-exact n)
      <= source_error_envelope initialError stepError (1 / (&grid:real)) n
Proof
  rpt gen_tac >> strip_tac >>
  `!n. modu (exact n) <= 1` by metis_tac [ss_exact_state_norm] >>
  `0 <= 1 / (&grid:real)` by simp [REAL_LE_DIV] >>
  `!n. 0 <= source_error_envelope initialError stepError (1 / (&grid:real)) n`
    by metis_tac [ss_envelope_nonneg] >>
  Induct >> ASM_SIMP_TAC bool_ss [source_state_def,source_error_envelope_def] >>
  match_mp_tac ss_source_update_error >> ASM_SIMP_TAC bool_ss []
QED

val _ = print "SOURCE_STATE_ERROR_PROOFS_DONE_CONDITIONAL_PRODUCERS\n";
