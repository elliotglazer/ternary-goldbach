open HolKernel Parse boolLib bossLib;
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
  `2*SUC n = 2*n+2` by decide_tac >>
  REWRITE_TAC [sl_remainder_suc] >>
  sl_use_diff (Q.SPECL [`sl_remainder (n:num)`,
    `\y:real. 2 * y pow (2*n+1) / &(2*n+1)`,
    `2 * (x:real) pow (2*n) / (1-x pow 2)`,`2 * (x:real) pow (2*n)`,`x:real`]
    limTheory.DIFF_SUB));
 let val th = top_thm() in
 if null(hyp th) andalso aconv(concl th) expected then
 print("EXACT_DERIVATIVE_DIAGNOSTIC_PASS,"^thm_to_string th^"\n")
 else raise Fail "diagnostic conclusion mismatch" end;
 OS.Process.exit OS.Process.success)
 handle ex => (print("DIAGNOSTIC_EXCEPTION "^General.exnMessage ex^"\n"); OS.Process.exit OS.Process.failure));
