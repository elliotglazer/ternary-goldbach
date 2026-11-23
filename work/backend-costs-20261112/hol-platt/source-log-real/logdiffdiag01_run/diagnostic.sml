open HolKernel Parse boolLib bossLib;
val _ = Globals.show_types_verbosely := true;
fun show label = (print ("GOAL_STATE," ^ label ^ "\n");
 List.app (fn (asl,w) => (List.app (fn a=>print("ASSUM "^term_to_string a^"\n")) asl;
 print("GOAL "^term_to_string w^"\n"))) (top_goals()));
val expected = ``!n:num. !x:real. 0 <= x /\ x < 1 ==>
    (sl_remainder n diffl (2 * x pow (2*n) / (1-x pow 2))) x``;
val _ = if null(fst(top_goal())) andalso aconv(snd(top_goal())) expected then () else raise Fail "wrong saved goal";
val _ = (
 e (Induct);
 e (SIMP_TAC real_ss [sl_remainder_def,sl_log_partial_def,sl_log_difference_diff]);
 e (gen_tac >> strip_tac);
 e (`(sl_remainder n diffl (2 * x pow (2*n) / (1-x pow 2))) x` by metis_tac []);
 e (`((\y:real. 2 * y pow (2*n+1) / &(2*n+1)) diffl (2 * x pow (2*n))) x` by metis_tac [sl_odd_term_diff]);
 e (`0 < 1+x /\ 0 < 1-x` by RealField.REAL_ASM_ARITH_TAC);
 e (`2*SUC n = 2*n+2` by decide_tac);
 e (REWRITE_TAC [sl_remainder_suc]);
 show "before_identity";
 e (W (fn (_,goal) => let
 val th = Q.SPECL [`sl_remainder (n:num)`, `\y:real. 2 * y pow (2*n+1) / &(2*n+1)`,
 `2 * (x:real) pow (2*n) / (1-x pow 2)`,`2 * (x:real) pow (2*n)`,`x:real`] limTheory.DIFF_SUB
 val (_,body) = strip_imp(concl th)
 val actual=rand(rator body)
 val wanted=rand(rator goal)
 in SUBGOAL_THEN(mk_eq(actual,wanted)) ASSUME_TAC end));
 show "identity";
 e (ASM_SIMP_TAC bool_ss [POW_ADD,POW_2]);
 show "simplified_identity";
 e (RealField.REAL_ASM_FIELD_TAC);
 show "after_field";
 OS.Process.exit OS.Process.success
 ) handle ex => (print ("DIAGNOSTIC_EXCEPTION " ^ General.exnMessage ex ^ "\n"); show "at_failure"; OS.Process.exit OS.Process.failure);
