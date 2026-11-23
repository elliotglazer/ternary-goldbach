open HolKernel Parse boolLib bossLib;
fun sl_use_diff_clear th = W (fn (_,goal) =>
 let val (_,body) = strip_imp(concl th)
     val actual = rand(rator body)
     val wanted = rand(rator goal)
 in SUBGOAL_THEN(mk_eq(actual,wanted)) ASSUME_TAC
      >- (ASM_SIMP_TAC bool_ss [POW_ADD,POW_2] >>
          ASM_SIMP_TAC bool_ss [REAL_EQ_RDIV_EQ',REAL_SUB_RDISTRIB,REAL_DIV_RMUL] >>
          RealField.REAL_ARITH_TAC) >>
    mp_tac th >> ASM_SIMP_TAC real_ss []
 end);
val expected = ``  !n:num. !x:real. 0 <= x /\ x < 1 ==>
    (sl_remainder n diffl (2 * x pow (2*n) / (1-x pow 2))) x``;
val _ = if null(fst(top_goal())) andalso aconv(snd(top_goal())) expected then () else raise Fail "wrong saved goal";
val _ = ((e (  Induct
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
    limTheory.DIFF_SUB));
 let val th = top_thm() in
 if null(hyp th) andalso aconv(concl th) expected then
 print("EXACT_DERIVATIVE_DIAGNOSTIC_PASS,"^thm_to_string th^"\n")
 else raise Fail "diagnostic conclusion mismatch" end;
 OS.Process.exit OS.Process.success)
 handle ex => (print("DIAGNOSTIC_EXCEPTION "^General.exnMessage ex^"\n"); OS.Process.exit OS.Process.failure));
