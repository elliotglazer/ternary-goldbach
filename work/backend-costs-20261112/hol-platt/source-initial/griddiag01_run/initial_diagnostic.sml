open HolKernel Parse boolLib bossLib complexTheory realTheory intrealTheory;
fun require b s = if b then () else raise Fail s;
val expected = ``!a b:num. a <= b ==> 2 ** b = 2 ** a * 2 ** (b-a)``;
val _ = require (aconv (#2 (proofManagerLib.top_goal ())) expected) "wrong saved target";
fun show () = List.app (fn (hs,g) =>
  (print "GOAL_BEGIN\n"; List.app (fn h => print (term_to_string h ^ "\n")) hs;
   print ("|- " ^ term_to_string g ^ "\nGOAL_END\n"))) (proofManagerLib.top_goals ());
fun step name tac = (print ("STEP," ^ name ^ "\n"); ignore (proofManagerLib.e tac); show ());
val _ = (
 print ("UNQUALIFIED_EXP_ADD " ^ thm_to_string EXP_ADD ^ "\n");
 step "introduce" (rpt gen_tac >> strip_tac);
 step "split_exponent" (`a + (b-a) = b` by decide_tac);
 ignore (proofManagerLib.e (metis_tac [arithmeticTheory.EXP_ADD]));
 let val th = proofManagerLib.top_thm ()
     val _ = require (null (hyp th) andalso aconv (concl th) expected) "changed or open result"
 in print ("SOURCE_INITIAL_DIAGNOSTIC_EXACT_CLOSED_THEOREM " ^ thm_to_string th ^ "\n");
    OS.Process.exit OS.Process.success end)
 handle ex => (print ("SOURCE_INITIAL_DIAGNOSTIC_FAILED " ^ General.exnMessage ex ^ "\n");
               (show () handle _ => ()); OS.Process.exit OS.Process.failure);
