open HolKernel Parse boolLib bossLib complexTheory realTheory;
fun require b s = if b then () else raise Fail s;
val expected = ``!z w:complex. modu (z+w) <= modu z + modu w``;
val _ = require (aconv (#2 (proofManagerLib.top_goal ())) expected) "wrong saved target";
fun show () = List.app (fn (hs,g) =>
  (print "GOAL_BEGIN\n"; List.app (fn h => print (term_to_string h ^ "\n")) hs;
   print ("|- " ^ term_to_string g ^ "\nGOAL_END\n"))) (proofManagerLib.top_goals ());
fun step name tac = (print ("STEP," ^ name ^ "\n"); ignore (proofManagerLib.e tac); show ());
val _ = (
 step "introduce" (rpt gen_tac);
 step "cross_term" (`RE (z*conj w) <= modu z * modu w` by
    (metis_tac [RE_IM_LE_MODU,ABS_LE,MODU_MUL,MODU_CONJ,REAL_LE_TRANS]));
 step "square_bound" (`modu (z+w) pow 2 <= (modu z + modu w) pow 2` by
    (REWRITE_TAC [ss_modu_add_square,POW_2] >> RealField.REAL_ASM_ARITH_TAC));
 step "nonnegative" (`0 <= modu (z+w) /\ 0 <= modu z + modu w` by
    (simp [MODU_POS,REAL_LE_ADD]));
 step "sqrt_monotone" (mp_tac (Q.SPECL [`modu (z+w) pow 2`,`(modu z + modu w) pow 2`] SQRT_MONO_LE));
 ignore (proofManagerLib.e (ASM_SIMP_TAC bool_ss [REAL_LE_POW2,POW_2_SQRT]));
 let val th = proofManagerLib.top_thm ()
     val _ = require (null (hyp th) andalso aconv (concl th) expected) "changed or open result"
 in print ("SOURCE_STATE_DIAGNOSTIC_EXACT_CLOSED_THEOREM " ^ thm_to_string th ^ "\n");
    OS.Process.exit OS.Process.success end)
 handle ex => (print ("SOURCE_STATE_DIAGNOSTIC_FAILED " ^ General.exnMessage ex ^ "\n");
               (show () handle _ => ()); OS.Process.exit OS.Process.failure);
