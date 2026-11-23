open HolKernel Parse boolLib bossLib;
fun sl_use_diff_clear th = W (fn (_,goal) =>
 let val (_,body) = strip_imp(concl th)
     val actual = rand(rator body)
     val wanted = rand(rator goal)
 in SUBGOAL_THEN(mk_eq(actual,wanted)) ASSUME_TAC
      >- (ASM_SIMP_TAC bool_ss [POW_ADD,POW_2] >>
          ASM_SIMP_TAC bool_ss [REAL_EQ_RDIV_EQ',REAL_SUB_RDISTRIB,REAL_DIV_RMUL] >>
          REWRITE_TAC [REAL_SUB_LDISTRIB,REAL_MUL_RID,REAL_SUB_SUB2,REAL_MUL_ASSOC]) >>
    mp_tac th >> ASM_SIMP_TAC real_ss []
 end);


fun checked (name,expected,tac) =
 ((set_goal ([],expected); e tac;
   let val th = top_thm() in
     if null(hyp th) andalso aconv(concl th) expected then
       (print("TAIL_DIAGNOSTIC_PASS,"^name^","^thm_to_string th^"\n"); th)
     else raise Fail ("changed diagnostic root "^name)
   end)
 handle ex => (print("TAIL_DIAGNOSTIC_FAIL,"^name^","^General.exnMessage ex^"\n");
 List.app (fn(asl,w)=>(List.app(fn a=>print("ASSUM "^term_to_string a^"\n"))asl;
 print("GOAL "^term_to_string w^"\n"))) (top_goals());
 OS.Process.exit OS.Process.failure));
val sl_remainder_diff = checked("sl_remainder_diff",``  !n:num. !x:real. 0 <= x /\ x < 1 ==>
    (sl_remainder n diffl (2 * x pow (2*n) / (1-x pow 2))) x``,(  Induct
  >- (SIMP_TAC real_ss [sl_remainder_def,sl_log_partial_def,sl_log_difference_diff]) >>
  gen_tac >> strip_tac >>
  `(sl_remainder n diffl (2 * x pow (2*n) / (1-x pow 2))) x`
    by metis_tac [] >>
  `((\y:real. 2 * y pow (2*n+1) / &(2*n+1)) diffl
      (2 * x pow (2*n))) x` by metis_tac [sl_odd_term_diff] >>
  `0 < 1+x /\ 0 < 1-x` by RealField.REAL_ASM_ARITH_TAC >>
  `0 < (1-x)*(1+x)` by (match_mp_tac REAL_LT_MUL >> ASM_REWRITE_TAC []) >>
  `0 < 1-x*x` by RealField.REAL_ASM_ARITH_TAC >>
  `1-x*x <> 0` by RealField.REAL_ASM_ARITH_TAC >>
  `2*SUC n = 2*n+2` by decide_tac >>
  REWRITE_TAC [sl_remainder_suc] >>
  sl_use_diff_clear (Q.SPECL [`sl_remainder (n:num)`,
    `\y:real. 2 * y pow (2*n+1) / &(2*n+1)`,
    `2 * (x:real) pow (2*n) / (1-x pow 2)`,`2 * (x:real) pow (2*n)`,`x:real`]
    limTheory.DIFF_SUB)));
val sl_remainder_mvt = checked("sl_remainder_mvt",``  !n:num. !v:real. 0 < v /\ v <= 1/3 ==>
    ?c:real. 0 < c /\ c < v /\
      sl_remainder n v = v * (2 * c pow (2*n) / (1-c pow 2))``,(  rpt gen_tac >> strip_tac >>
  `!x:real. 0 <= x /\ x <= v ==>
    (sl_remainder n diffl (2 * x pow (2*n) / (1-x pow 2))) x` by
    (rpt gen_tac >> strip_tac >> match_mp_tac sl_remainder_diff >>
     RealField.REAL_ASM_ARITH_TAC) >>
  `!x:real. 0 <= x /\ x <= v ==> sl_remainder n contl x`
    by metis_tac [limTheory.DIFF_CONT] >>
  `!x:real. 0 < x /\ x < v ==> sl_remainder n differentiable x` by
    (rpt gen_tac >> strip_tac >> REWRITE_TAC [limTheory.differentiable] >>
     qexists_tac `2 * (x:real) pow (2*n) / (1-x pow 2)` >>
     match_mp_tac sl_remainder_diff >> RealField.REAL_ASM_ARITH_TAC) >>
  mp_tac (Q.SPECL [`sl_remainder (n:num)`,`0:real`,`v:real`] limTheory.MVT) >>
  ASM_SIMP_TAC bool_ss [] >>
  DISCH_THEN (qx_choose_then `ell` (qx_choose_then `c` strip_assume_tac)) >>
  `0 <= c /\ c < 1` by RealField.REAL_ASM_ARITH_TAC >>
  `(sl_remainder n diffl (2 * c pow (2*n) / (1-c pow 2))) c`
    by metis_tac [sl_remainder_diff] >>
  `ell = 2 * c pow (2*n) / (1-c pow 2)` by metis_tac [limTheory.DIFF_UNIQ] >>
  qexists_tac `c:real` >>
  full_simp_tac bool_ss [sl_remainder_zero,REAL_SUB_RZERO]));
val sl_remainder_derivative_bound = checked("sl_remainder_derivative_bound",``  !n:num. !x:real. 0 <= x /\ x <= 1/3 ==>
    0 <= 2 * x pow (2*n) / (1-x pow 2) /\
    2 * x pow (2*n) / (1-x pow 2) <= (9/4) * (1/3) pow (2*n)``,(  rpt gen_tac >> strip_tac >>
  `x pow 2 <= (1/3:real) pow 2` by metis_tac [POW_LE] >>
  `(1/3:real) pow 2 = 1/9` by (CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  `8/9 <= 1-x pow 2 /\ 0 < 1-x pow 2` by RealField.REAL_ASM_ARITH_TAC >>
  `0 <= x pow (2*n)` by metis_tac [POW_POS] >>
  `x pow (2*n) <= (1/3:real) pow (2*n)` by metis_tac [POW_LE] >>
  `0 <= (1/3:real) pow (2*n)` by simp [POW_POS] >>
  `(8/9) * (1/3:real) pow (2*n) <= (1-x pow 2) * (1/3:real) pow (2*n)`
    by metis_tac [REAL_LE_RMUL_IMP] >>
  conj_tac
  >- (match_mp_tac REAL_LE_DIV >> simp [REAL_LE_MUL,REAL_LT_IMP_LE]) >>
  ASM_SIMP_TAC bool_ss [REAL_LE_LDIV_EQ] >> RealField.REAL_ASM_ARITH_TAC));
val sl_remainder_bound = checked("sl_remainder_bound",``  !n:num. !v:real. 0 <= v /\ v <= 1/3 ==>
    abs (sl_remainder n v) <= (9/4) * (1/3:real) pow (2*n+1)``,(  rpt gen_tac >> strip_tac >> Cases_on `v = 0`
  >- (ASM_REWRITE_TAC [sl_remainder_zero,ABS_0] >>
      match_mp_tac REAL_LE_MUL >> conj_tac
      >- CONV_TAC RealField.REAL_RAT_REDUCE_CONV >>
      match_mp_tac POW_POS >> CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  `0 < v` by RealField.REAL_ASM_ARITH_TAC >>
  `?c:real. 0 < c /\ c < v /\
      sl_remainder n v = v * (2 * c pow (2*n) / (1-c pow 2))`
    by metis_tac [sl_remainder_mvt] >>
  pop_assum (qx_choose_then `c` strip_assume_tac) >>
  `0 <= c /\ c <= 1/3` by RealField.REAL_ASM_ARITH_TAC >>
  `0 <= 2 * c pow (2*n) / (1-c pow 2) /\
    2 * c pow (2*n) / (1-c pow 2) <= (9/4) * (1/3:real) pow (2*n)`
    by metis_tac [sl_remainder_derivative_bound] >>
  `0 <= sl_remainder n v` by metis_tac [REAL_LE_MUL] >>
  `v * (2 * c pow (2*n) / (1-c pow 2)) <=
    (1/3) * ((9/4) * (1/3:real) pow (2*n))` by
    (match_mp_tac REAL_LE_MUL2 >> ASM_SIMP_TAC bool_ss []) >>
  `abs (sl_remainder n v) = sl_remainder n v` by metis_tac [ABS_REFL] >>
  ASM_REWRITE_TAC [POW_ADD,POW_1] >> RealField.REAL_ASM_ARITH_TAC));
val sl_log_partial_error = checked("sl_log_partial_error",``  !n:num. !v:real. 0 <= v /\ v <= 1/3 ==>
    abs (ln ((1+v)/(1-v)) - sl_log_partial n v)
      <= (9/4) * (1/3:real) pow (2*n+1)``,(  rpt gen_tac >> strip_tac >>
  `0 < 1+v /\ 0 < 1-v` by RealField.REAL_ASM_ARITH_TAC >>
  mp_tac (Q.SPECL [`n:num`,`v:real`] sl_remainder_bound) >>
  ASM_SIMP_TAC bool_ss [sl_remainder_def,LN_DIV]));
val sl_log_partial45_error = checked("sl_log_partial45_error",``  !v:real. 0 <= v /\ v <= 1/3 ==>
    abs (ln ((1+v)/(1-v)) - sl_log_partial 45 v) <= 1 / (2:real) pow 135``,(  gen_tac >> strip_tac >>
  `(9/4) * (1/3:real) pow (2*45+1) <= 1 / (2:real) pow 135`
    by (CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  metis_tac [sl_log_partial_error,REAL_LE_TRANS]));
val sl_log_two45_error = checked("sl_log_two45_error",``  abs (ln 2 - sl_log_partial 45 (1/3)) <= 1 / (2:real) pow 135``,(  `(1+(1/3:real))/(1-1/3) = 2` by (CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  mp_tac (Q.SPEC `1/3:real` sl_log_partial45_error) >>
  ASM_SIMP_TAC real_ss []));
val _ = print "ALL_SEVEN_TAIL_DIAGNOSTICS_PASS\n";
val _ = OS.Process.exit OS.Process.success;
