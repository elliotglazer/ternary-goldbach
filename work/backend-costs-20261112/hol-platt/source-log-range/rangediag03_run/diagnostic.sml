fun checked name expected tactic =
  ((set_goal ([],expected); e tactic;
    let val th = top_thm ()
    in if null (hyp th) andalso aconv (concl th) expected
       then (print ("RANGE_DIAGNOSTIC_PASS," ^ name ^ "\n"); th)
       else raise Fail (name ^ ": root mismatch") end)
   handle ex => (print ("RANGE_DIAGNOSTIC_FAIL," ^ name ^ "," ^ General.exnMessage ex ^ "\n");
                 (print (PolyML.makestring (top_goals ()) ^ "\n") handle _ => ());
                 OS.Process.exit OS.Process.failure));
val slr_domain_bounds = checked "slr_domain_bounds" ``!A D k:num. source_log_domain A D k ==>
    0 < D /\ 0 < (2:num) ** k * D /\ 0 < A /\
    0 < A + (2:num) ** k * D /\
    3 * (A - (2:num) ** k * D) <= A + (2:num) ** k * D`` (
  rpt gen_tac >> REWRITE_TAC [source_log_domain_def] >> strip_tac >>
  `0 < (2:num) ** k * D` by simp [] >>
  FULL_SIMP_TAC bool_ss [GSYM MULT_ASSOC] >>
  qabbrev_tac `scale = (2:num) ** k * D` >> decide_tac
);
val slr_reduced_ratio = checked "slr_reduced_ratio" ``!A D k:num. source_log_domain A D k ==>
    (1 + (&(A - (2:num) ** k * D):real) / &(A + (2:num) ** k * D)) /
    (1 - (&(A - (2:num) ** k * D):real) / &(A + (2:num) ** k * D)) =
    (&A:real) / &((2:num) ** k * D)`` (
  rpt gen_tac >> strip_tac >>
  drule slr_domain_bounds >> strip_tac >>
  `((2:num) ** k * D) <= A` by fs [source_log_domain_def] >>
  `(&(A - (2:num) ** k * D):real) = &A - &((2:num) ** k * D)`
    by metis_tac [REAL_OF_NUM_SUB] >>
  `0 < (&((2:num) ** k * D):real) /\
   0 < (&(A + (2:num) ** k * D):real)` by simp [] >>
  `(&(A - (2:num) ** k * D):real) / &(A + (2:num) ** k * D) <= 1/3`
    by metis_tac [slh_ratio_range] >>
  `0 < 1 - (&(A - (2:num) ** k * D):real) / &(A + (2:num) ** k * D)`
    by RealField.REAL_ASM_ARITH_TAC >>
  FULL_SIMP_TAC bool_ss [GSYM REAL_OF_NUM_ADD] >>
  RealField.REAL_ASM_FIELD_TAC
);
val slr_log_decomposition = checked "slr_log_decomposition" ``!A D k:num. source_log_domain A D k ==>
    ln ((&A:real) / &D) = (&k:real) * ln 2 +
      ln ((&A:real) / &((2:num) ** k * D))`` (
  rpt gen_tac >> strip_tac >>
  drule slr_domain_bounds >> strip_tac >>
  `0 < (&A:real) /\ 0 < (&D:real) /\
   0 < (&((2:num) ** k * D):real) /\ 0 < (2:real) pow k /\ 0 < (2:real)` by simp [POW_POS_LT] >>
  `ln (&((2:num) ** k * D):real) = (&k:real) * ln 2 + ln (&D)` by
    (ASM_SIMP_TAC std_ss [GSYM REAL_OF_NUM_MUL,GSYM REAL_OF_NUM_POW,LN_MUL,LN_POW]) >>
  ASM_SIMP_TAC bool_ss [LN_DIV] >> RealField.REAL_ASM_ARITH_TAC
);
val slr_reduced_center_error = checked "slr_reduced_center_error" ``!grid A D k:num. 0 < grid /\ source_log_domain A D k ==>
    abs (real_of_int (source_log_center grid
      (A - (2:num) ** k * D) (A + (2:num) ** k * D) 45) / (&grid:real) -
      ln ((&A:real) / &((2:num) ** k * D))) <= slr_error_bound grid`` (
  rpt gen_tac >> strip_tac >>
  drule slr_domain_bounds >> strip_tac >>
  mp_tac (Q.SPECL [`grid`,`A - (2:num) ** k * D`,`A + (2:num) ** k * D`]
    source_log_center45_error) >>
  ASM_SIMP_TAC bool_ss [slr_reduced_ratio,slr_error_bound_def]
);
val slr_abs_sub_triangle = checked "slr_abs_sub_triangle" ``!a b c:real. abs (a-c) <= abs (a-b) + abs (b-c)`` (
  rpt gen_tac >>
  mp_tac (Q.SPECL [`a-b:real`,`b-c:real`] ABS_TRIANGLE) >>
  REWRITE_TAC [REAL_SUB_TRIANGLE]
);
val slr_affine_error = checked "slr_affine_error" ``!k a b c d e:real. 0 <= k /\ abs (a-c) <= e /\ abs (b-d) <= e ==>
    abs ((k*a+b)-(k*c+d)) <= (k+1)*e`` (
  rpt gen_tac >> strip_tac >>
  `abs k = k` by metis_tac [ABS_REFL] >>
  `k * abs (a-c) <= k*e` by metis_tac [REAL_LE_LMUL_IMP] >>
  `abs (k*(a-c)+(b-d)) <= abs (k*(a-c))+abs (b-d)` by metis_tac [ABS_TRIANGLE] >>
  `(k*a+b)-(k*c+d) = k*(a-c)+(b-d)` by RealField.REAL_ARITH_TAC >>
  FULL_SIMP_TAC bool_ss [ABS_MUL] >> RealField.REAL_ASM_ARITH_TAC
);
val slr_numerator_error = checked "slr_numerator_error" ``!grid A D k:num. 0 < grid /\ source_log_domain A D k ==>
    abs (real_of_int (slr_numerator grid k A D) / (&grid:real) -
      ln ((&A:real) / &D)) <= ((&k:real)+1) * slr_error_bound grid`` (
  rpt gen_tac >> strip_tac >>
  `0 < (&grid:real) /\ 0 <= (&k:real)` by simp [] >>
  `abs (real_of_int (source_log_center grid 1 3 45) / (&grid:real) - ln 2)
    <= slr_error_bound grid` by metis_tac [source_log_two45_error,slr_error_bound_def] >>
  `abs (real_of_int (source_log_center grid (A-(2:num)**k*D) (A+(2:num)**k*D) 45) /
    (&grid:real) - ln ((&A:real) / &((2:num)**k*D))) <= slr_error_bound grid`
    by metis_tac [slr_reduced_center_error] >>
  `real_of_int (slr_numerator grid k A D) / (&grid:real) =
    (&k:real) * (real_of_int (source_log_center grid 1 3 45) / (&grid:real)) +
    real_of_int (source_log_center grid (A-(2:num)**k*D) (A+(2:num)**k*D) 45) / (&grid:real)` by
    (REWRITE_TAC [slr_numerator_def,real_of_int_add,real_of_int_mul,real_of_int_num] >>
     RealField.REAL_ASM_FIELD_TAC) >>
  ASM_REWRITE_TAC [] >>
  `ln ((&A:real)/&D) = (&k:real)*ln 2 + ln ((&A:real)/&((2:num)**k*D))`
    by metis_tac [slr_log_decomposition] >>
  ASM_REWRITE_TAC [] >> match_mp_tac slr_affine_error >> ASM_REWRITE_TAC []
);
val slr_from_two_numerator = checked "slr_from_two_numerator" ``!grid out_div k A D:num.
    source_log_from_two grid 45 out_div (source_log_center grid 1 3 45) k A D =
      round_scaled (&out_div) (slr_numerator grid k A D)`` (
  REWRITE_TAC [source_log_from_two_def,slr_numerator_def]
);
val slr_raw_regrid_error = checked "slr_raw_regrid_error" ``!k x:num.
    abs (real_of_int (source_raw_log129 k x) / (2:real) pow 129 -
      real_of_int (slr_numerator ((2:num) ** 137) k x 1) / (2:real) pow 137)
      <= 1 / (2:real) pow 130`` (
  rpt gen_tac >>
  `0 < (&((2:num) ** 129):int) /\ 0 < (256:int)` by simp [] >>
  mp_tac (Q.SPECL [`&((2:num)**129):int`,`256:int`,
    `slr_numerator ((2:num)**137) k x 1`] round_scaled_coordinate_error) >>
  ASM_REWRITE_TAC [real_of_int_num,GSYM REAL_OF_NUM_POW] >>
  `256 * (2:real) pow 129 = (2:real) pow 137 /\
   2 * (2:real) pow 129 = (2:real) pow 130`
    by CONV_TAC RealField.REAL_RAT_REDUCE_CONV >>
  ASM_REWRITE_TAC [source_raw_log129_def,slr_from_two_numerator]
);
val slr_raw_budget = checked "slr_raw_budget" ``!k:num. k <= 18 ==>
    ((&k:real)+1) * slr_error_bound ((2:num) ** 137) + 1 / (2:real) pow 130
      < 1 / (2:real) pow 128`` (
  rpt gen_tac >> strip_tac >>
  `(&k:real) <= 18` by simp [] >>
  `(&k:real)+1 <= 19` by RealField.REAL_ASM_ARITH_TAC >>
  `0 <= slr_error_bound ((2:num)**137)` by
    (REWRITE_TAC [slr_error_bound_def,GSYM REAL_OF_NUM_POW] >>
     CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  `((&k:real)+1)*slr_error_bound ((2:num)**137) <= 19*slr_error_bound ((2:num)**137)`
    by metis_tac [REAL_LE_RMUL_IMP] >>
  `19*slr_error_bound ((2:num)**137) + 1/(2:real) pow 130 < 1/(2:real) pow 128` by
    (REWRITE_TAC [slr_error_bound_def,GSYM REAL_OF_NUM_POW] >>
     CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >> RealField.REAL_ASM_ARITH_TAC
);
val source_raw_log129_error = checked "source_raw_log129_error" ``!k x:num. source_log_domain x 1 k /\ k <= 18 ==>
    abs (real_of_int (source_raw_log129 k x) / (2:real) pow 129 - ln (&x))
      <= 1 / (2:real) pow 128`` (
  rpt gen_tac >> strip_tac >>
  mp_tac (Q.SPECL [`(2:num)**137`,`x:num`,`1:num`,`k:num`] slr_numerator_error) >>
  ASM_SIMP_TAC std_ss [EXP_POS,GSYM REAL_OF_NUM_POW,REAL_DIV_1] >> strip_tac >>
  mp_tac (Q.SPECL [`k:num`,`x:num`] slr_raw_regrid_error) >> strip_tac >>
  mp_tac (Q.SPEC `k:num` slr_raw_budget) >> ASM_REWRITE_TAC [] >> strip_tac >>
  mp_tac (Q.SPECL [`real_of_int (source_raw_log129 k x) / (2:real) pow 129`,
    `real_of_int (slr_numerator ((2:num)**137) k x 1) / (2:real) pow 137`,
    `ln (&x:real)`] slr_abs_sub_triangle) >> RealField.REAL_ASM_ARITH_TAC
);
val _ = print "RANGE_DIAGNOSTIC_ALL_DONE\n";
val _ = OS.Process.exit OS.Process.success;
