open HolKernel Parse boolLib bossLib arithmeticTheory listTheory;
fun require b message = if b then () else raise Fail message;
val expected = ``  !cache xs.
  GENLIST (\j. GENLIST (\i. tx_pair j (tx_row i (ftr_rows40 cache xs))) 60) 39 =
  GENLIST (\j. GENLIST (\i. tx_pair (39*i+j) (txp_selected40 cache xs)) 60) 39``;
val _ = require (aconv (#2 (proofManagerLib.top_goal ())) expected)
  "wrong initial diagnostic goal";
val _ = (ignore (proofManagerLib.e (  rpt gen_tac >> REWRITE_TAC [GENLIST_FUN_EQ] >>
  qx_gen_tac `j` >> strip_tac >>
  CONV_TAC (DEPTH_CONV BETA_CONV) >> REWRITE_TAC [GENLIST_FUN_EQ] >>
  qx_gen_tac `i` >> strip_tac >>
  ASM_SIMP_TAC bool_ss [ftr_selected40,ftr_flatten_at_left]));
  let val th = proofManagerLib.top_thm ()
      val _ = require (null (hyp th) andalso aconv (concl th) expected)
        "open or changed diagnostic theorem"
  in print ("REFINE_DIAGNOSTIC_EXACT_CLOSED_THEOREM " ^ thm_to_string th ^ "\n");
     OS.Process.exit OS.Process.success end)
  handle ex => (print ("REFINE_DIAGNOSTIC_FAILED " ^ General.exnMessage ex ^ "\n");
               OS.Process.exit OS.Process.failure);
