(* Refinement of the actual integer logarithm Horner program.
   Range-reduction and final raw-log regridding remain separate obligations. *)
Theory SourceLogHorner
Ancestors SourceArithmetic SourceLogTail RawPairRound real intreal integer arithmetic
Libs realLib RealField

val _ = realLib.prefer_real ();

Definition slh_ideal_def:
  (slh_ideal (v:real) 0 k = 0) /\
  (slh_ideal v (SUC n) k = 1 / &(2*k+1) + v pow 2 * slh_ideal v n (SUC k))
End

Theorem slh_ideal_append:
  !n k:num. !v:real.
    slh_ideal v (SUC n) k = slh_ideal v n k + v pow (2*n) / &(2*(k+n)+1)
Proof
  Induct
  >- simp [slh_ideal_def] >>
  rpt gen_tac >> ONCE_REWRITE_TAC [slh_ideal_def] >>
  ASM_REWRITE_TAC [] >>
  `SUC k+n = k+SUC n` by decide_tac >>
  `2*SUC n = 2*n+2` by decide_tac >>
  ASM_REWRITE_TAC [POW_ADD,POW_2] >>
  qabbrev_tac `z = (v:real) pow (2*n)` >>
  REWRITE_TAC [real_div] >> RealField.REAL_ARITH_TAC
QED

Theorem slh_partial_eq_ideal:
  !n:num. !v:real. sl_log_partial n v = 2*v*slh_ideal v n 0
Proof
  Induct
  >- simp [sl_log_partial_def,slh_ideal_def] >>
  gen_tac >> ONCE_REWRITE_TAC [sl_log_partial_def,slh_ideal_append] >>
  ASM_SIMP_TAC bool_ss [ADD_CLAUSES,POW_ADD,POW_1] >>
  qabbrev_tac `z = (v:real) pow (2*n)` >>
  REWRITE_TAC [real_div] >> RealField.REAL_ARITH_TAC
QED

Theorem slh_ratio_range:
  !A B:num. 0 < B /\ 3*A <= B ==>
    0 <= (&A:real) / &B /\ (&A:real) / &B <= 1/3 /\
    0 <= ((&A:real) / &B) pow 2 /\ ((&A:real) / &B) pow 2 <= 1/9
Proof
  rpt gen_tac >> strip_tac >>
  `0 < (&B:real) /\ 0 <= (&A:real)` by simp [] >>
  `3 * (&A:real) <= &B` by
    (REWRITE_TAC [REAL_OF_NUM_MUL,REAL_OF_NUM_LE] >> ASM_REWRITE_TAC []) >>
  `0 <= (&A:real) / &B` by simp [REAL_LE_DIV,REAL_LT_IMP_LE] >>
  `(&A:real) / &B <= 1/3` by
    (ASM_SIMP_TAC bool_ss [REAL_LE_LDIV_EQ] >> RealField.REAL_ASM_ARITH_TAC) >>
  `((&A:real) / &B) pow 2 <= (1/3:real) pow 2` by metis_tac [POW_LE] >>
  `(1/3:real) pow 2 = 1/9` by CONV_TAC RealField.REAL_RAT_REDUCE_CONV >>
  ASM_SIMP_TAC bool_ss [REAL_LE_POW2] >> metis_tac []
QED

Theorem slh_nat_square_real:
  !A:num. real_of_int ((&A:int) ** 2) = (&A:real) pow 2
Proof
  gen_tac >> REWRITE_TAC [INT_EXP,real_of_int_num] >> metis_tac [REAL_OF_NUM_POW]
QED

Theorem slh_den_positive:
  !B k:num. 0 < B ==> 0 < ((&(2*k+1):int) * &B ** 2)
Proof
  rpt gen_tac >> strip_tac >>
  `0 < (&B:real) /\ 0 < (&(2*k+1):real)` by simp [] >>
  `0 < (&B:real) pow 2` by simp [POW_POS_LT] >>
  `0 < real_of_int ((&(2*k+1):int) * &B ** 2)` by
    (REWRITE_TAC [real_of_int_mul,real_of_int_num,slh_nat_square_real] >>
     match_mp_tac REAL_LT_MUL >> ASM_REWRITE_TAC []) >>
  metis_tac [real_of_int_lt,real_of_int_num]
QED

Theorem slh_unrounded_value:
  !grid A B k:num. !w:int. 0 < B ==>
    real_of_int ((&grid:int) * &B ** 2 + &(2*k+1) * &A ** 2 * w) /
      real_of_int ((&(2*k+1):int) * &B ** 2) =
    (&grid:real) / &(2*k+1) + ((&A:real) / &B) pow 2 * real_of_int w
Proof
  rpt gen_tac >> strip_tac >>
  `0 < (&B:real) /\ 0 < (&(2*k+1):real)` by simp [] >>
  REWRITE_TAC [real_of_int_add,real_of_int_mul,real_of_int_num,slh_nat_square_real,POW_2] >>
  RealField.REAL_ASM_FIELD_TAC
QED

Theorem slh_actual_step_error:
  !grid A B n k:num. 0 < B ==>
    abs (real_of_int (source_log_horner grid A B (SUC n) k) -
      ((&grid:real) / &(2*k+1) + ((&A:real) / &B) pow 2 *
        real_of_int (source_log_horner grid A B n (SUC k)))) <= 1/2
Proof
  rpt gen_tac >> strip_tac >>
  mp_tac (Q.SPECL [`(&(2*k+1):int) * &B ** 2`,
    `(&grid:int) * &B ** 2 + &(2*k+1) * &A ** 2 * source_log_horner grid A B n (SUC k)`]
    round_scaled_real_error) >>
  ASM_SIMP_TAC bool_ss [slh_den_positive,slh_unrounded_value,source_log_horner_def]
QED

Theorem slh_affine_contraction:
  !a b c u h:real. 0 <= c /\ c <= 1/9 /\
    abs (u-h) <= 1 /\ abs (a-(b+c*u)) <= 1/2 ==>
    abs (a-(b+c*h)) <= 1
Proof
  rpt gen_tac >> strip_tac >>
  `abs c = c` by metis_tac [ABS_REFL] >>
  `c * abs (u-h) <= c*1` by metis_tac [REAL_LE_LMUL_IMP] >>
  `abs (c*(u-h)) <= c` by FULL_SIMP_TAC bool_ss [ABS_MUL,REAL_MUL_RID] >>
  `a-(b+c*h) = (a-(b+c*u)) + c*(u-h)` by RealField.REAL_ARITH_TAC >>
  mp_tac (Q.SPECL [`(a:real)-(b+c*u)`,`(c:real)*(u-h)`] ABS_TRIANGLE) >>
  ASM_REWRITE_TAC [] >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem source_log_horner_error:
  !grid A B:num. 0 < B /\ 3*A <= B ==>
    !n k:num. abs (real_of_int (source_log_horner grid A B n k) -
      (&grid:real) * slh_ideal ((&A:real) / &B) n k) <= 1
Proof
  rpt gen_tac >> strip_tac >>
  `0 <= ((&A:real) / &B) pow 2 /\ ((&A:real) / &B) pow 2 <= 1/9`
    by metis_tac [slh_ratio_range] >>
  Induct
  >- simp [source_log_horner_def,slh_ideal_def] >>
  gen_tac >>
  `abs (real_of_int (source_log_horner grid A B (SUC n) k) -
      ((&grid:real) / &(2*k+1) + ((&A:real) / &B) pow 2 *
        real_of_int (source_log_horner grid A B n (SUC k)))) <= 1/2`
    by metis_tac [slh_actual_step_error] >>
  `(&grid:real) * slh_ideal ((&A:real) / &B) (SUC n) k =
    (&grid:real) / &(2*k+1) + ((&A:real) / &B) pow 2 *
      ((&grid:real) * slh_ideal ((&A:real) / &B) n (SUC k))` by
    (REWRITE_TAC [slh_ideal_def,POW_2,real_div] >> RealField.REAL_ARITH_TAC) >>
  ASM_REWRITE_TAC [] >> match_mp_tac slh_affine_contraction >>
  qexists_tac `real_of_int (source_log_horner grid A B n (SUC k))` >>
  ASM_SIMP_TAC bool_ss []
QED

Theorem slh_center_unscaled_error:
  !grid A B n:num. 0 < B /\ 3*A <= B ==>
    abs (real_of_int (source_log_center grid A B n) -
      (&grid:real) * sl_log_partial n ((&A:real) / &B)) <= 7/4
Proof
  rpt gen_tac >> strip_tac >>
  `0 <= (&A:real) / &B /\ (&A:real) / &B <= 1/3`
    by metis_tac [slh_ratio_range] >>
  `0 < (&B:int)` by simp [] >>
  `0 < (&B:real)` by simp [] >>
  `abs (real_of_int (source_log_horner grid A B n 0) -
       (&grid:real) * slh_ideal ((&A:real) / &B) n 0) <= 1`
    by metis_tac [source_log_horner_error] >>
  `real_of_int ((2:int) * &A * source_log_horner grid A B n 0) / (&B:real) =
    2 * ((&A:real) / &B) * real_of_int (source_log_horner grid A B n 0)` by
    (REWRITE_TAC [real_of_int_mul,real_of_int_num] >> RealField.REAL_ASM_FIELD_TAC) >>
  `abs (real_of_int (source_log_center grid A B n) -
    2 * ((&A:real) / &B) * real_of_int (source_log_horner grid A B n 0)) <= 1/2` by
    (mp_tac (Q.SPECL [`&B:int`,`(2:int) * &A * source_log_horner grid A B n 0`]
       round_scaled_real_error) >>
     ASM_SIMP_TAC bool_ss [source_log_center_def,real_of_int_num]) >>
  `0 <= 2 * ((&A:real) / &B)` by RealField.REAL_ASM_ARITH_TAC >>
  `abs (2 * ((&A:real) / &B)) = 2 * ((&A:real) / &B)` by metis_tac [ABS_REFL] >>
  `2 * ((&A:real) / &B) *
    abs (real_of_int (source_log_horner grid A B n 0) -
      (&grid:real) * slh_ideal ((&A:real) / &B) n 0) <= 2 * ((&A:real) / &B) * 1`
    by metis_tac [REAL_LE_LMUL_IMP] >>
  `abs (2 * ((&A:real) / &B) *
    (real_of_int (source_log_horner grid A B n 0) -
      (&grid:real) * slh_ideal ((&A:real) / &B) n 0)) <= 2 * ((&A:real) / &B)`
    by FULL_SIMP_TAC bool_ss [ABS_MUL,REAL_MUL_RID] >>
  `real_of_int (source_log_center grid A B n) -
      (&grid:real) * sl_log_partial n ((&A:real) / &B) =
    (real_of_int (source_log_center grid A B n) -
      2 * ((&A:real) / &B) * real_of_int (source_log_horner grid A B n 0)) +
    2 * ((&A:real) / &B) *
      (real_of_int (source_log_horner grid A B n 0) -
        (&grid:real) * slh_ideal ((&A:real) / &B) n 0)` by
    (REWRITE_TAC [slh_partial_eq_ideal] >> RealField.REAL_ARITH_TAC) >>
  mp_tac (Q.SPECL [
    `real_of_int (source_log_center grid A B n) - 2 * ((&A:real) / &B) * real_of_int (source_log_horner grid A B n 0)`,
    `2 * ((&A:real) / &B) * (real_of_int (source_log_horner grid A B n 0) - (&grid:real) * slh_ideal ((&A:real) / &B) n 0)`]
    ABS_TRIANGLE) >>
  ASM_REWRITE_TAC [] >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem source_log_center_error:
  !grid A B n:num. 0 < grid /\ 0 < B /\ 3*A <= B ==>
    abs (real_of_int (source_log_center grid A B n) / (&grid:real) -
      sl_log_partial n ((&A:real) / &B)) <= 7 / (4 * (&grid:real))
Proof
  rpt gen_tac >> strip_tac >>
  `0 < (&grid:real)` by simp [] >>
  `abs (&grid:real) = (&grid:real)` by metis_tac [ABS_REFL,REAL_LT_IMP_LE] >>
  `abs (real_of_int (source_log_center grid A B n) -
      (&grid:real) * sl_log_partial n ((&A:real) / &B)) <= 7/4`
    by metis_tac [slh_center_unscaled_error] >>
  `real_of_int (source_log_center grid A B n) / (&grid:real) -
      sl_log_partial n ((&A:real) / &B) =
    (real_of_int (source_log_center grid A B n) -
      (&grid:real) * sl_log_partial n ((&A:real) / &B)) / (&grid:real)`
    by RealField.REAL_ASM_FIELD_TAC >>
  `7 / (4 * (&grid:real)) = (7/4) / (&grid:real)` by RealField.REAL_ASM_FIELD_TAC >>
  ASM_SIMP_TAC bool_ss [REAL_ABS_DIV,REAL_LE_LDIV_EQ] >> RealField.REAL_ASM_FIELD_TAC
QED

Theorem source_log_center45_error:
  !grid A B:num. 0 < grid /\ 0 < B /\ 3*A <= B ==>
    abs (real_of_int (source_log_center grid A B 45) / (&grid:real) -
      ln ((1 + (&A:real) / &B) / (1 - (&A:real) / &B)))
      <= 7 / (4 * (&grid:real)) + 1 / (2:real) pow 135
Proof
  rpt gen_tac >> strip_tac >>
  `0 <= (&A:real) / &B /\ (&A:real) / &B <= 1/3` by metis_tac [slh_ratio_range] >>
  `abs (real_of_int (source_log_center grid A B 45) / (&grid:real) -
    sl_log_partial 45 ((&A:real) / &B)) <= 7 / (4 * (&grid:real))`
    by metis_tac [source_log_center_error] >>
  `abs (ln ((1 + (&A:real) / &B) / (1 - (&A:real) / &B)) -
    sl_log_partial 45 ((&A:real) / &B)) <= 1 / (2:real) pow 135`
    by metis_tac [sl_log_partial45_error] >>
  `abs (sl_log_partial 45 ((&A:real) / &B) -
    ln ((1 + (&A:real) / &B) / (1 - (&A:real) / &B))) <= 1 / (2:real) pow 135`
    by metis_tac [ABS_SUB] >>
  mp_tac (Q.SPECL [
    `real_of_int (source_log_center grid A B 45) / (&grid:real) - sl_log_partial 45 ((&A:real) / &B)`,
    `sl_log_partial 45 ((&A:real) / &B) - ln ((1 + (&A:real) / &B) / (1 - (&A:real) / &B))`]
    ABS_TRIANGLE) >>
  REWRITE_TAC [REAL_SUB_TRIANGLE] >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem source_log_two45_error:
  !grid:num. 0 < grid ==>
    abs (real_of_int (source_log_center grid 1 3 45) / (&grid:real) - ln 2)
      <= 7 / (4 * (&grid:real)) + 1 / (2:real) pow 135
Proof
  gen_tac >> strip_tac >>
  `(1+(1/3:real))/(1-1/3) = 2` by CONV_TAC RealField.REAL_RAT_REDUCE_CONV >>
  mp_tac (Q.SPECL [`grid:num`,`1:num`,`3:num`] source_log_center45_error) >>
  ASM_SIMP_TAC real_ss []
QED

val _ = print "SOURCE_LOG_HORNER_PROOFS_DONE\n";
