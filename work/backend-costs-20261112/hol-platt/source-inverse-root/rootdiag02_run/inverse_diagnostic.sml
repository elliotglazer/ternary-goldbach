open HolKernel Parse boolLib bossLib logrootTheory realTheory arithmeticTheory;
fun require b s = if b then () else raise Fail s;
val expected = ``!A D S:num. 0 < A ==>
    (source_inverse_root A D S) ** 2 * A <= D*S*S /\
    D*S*S < (SUC (source_inverse_root A D S)) ** 2 * A``;
val _ = require (aconv (#2 (proofManagerLib.top_goal ())) expected) "wrong saved target";
fun show () = List.app (fn (hs,g) =>
  (print "GOAL_BEGIN\n"; List.app (fn h => print (term_to_string h ^ "\n")) hs;
   print ("|- " ^ term_to_string g ^ "\nGOAL_END\n"))) (proofManagerLib.top_goals ());
fun step name tac = (print ("STEP," ^ name ^ "\n"); ignore (proofManagerLib.e tac); show ());
val _ = (
 print ("ROOT_LITERAL " ^ thm_to_string logrootTheory.ROOT ^ "\n");
 step "introduce" (map_every qx_gen_tac [`A`,`D`,`grid`] >> strip_tac >> REWRITE_TAC [source_inverse_root_def]);
 step "positive_degree" (`0 < (2:num)` by decide_tac);
 step "root_bounds" (`(ROOT 2 ((D*grid*grid) DIV A)) ** 2 <= (D*grid*grid) DIV A /\
    (D*grid*grid) DIV A < (SUC (ROOT 2 ((D*grid*grid) DIV A))) ** 2`
    by metis_tac [logrootTheory.ROOT]);
 ignore (proofManagerLib.e (metis_tac [X_LE_DIV,DIV_LT_X]));
 let val th = proofManagerLib.top_thm ()
     val _ = require (null (hyp th) andalso aconv (concl th) expected) "changed or open result"
 in print ("SOURCE_INVERSE_DIAGNOSTIC_EXACT_CLOSED_THEOREM " ^ thm_to_string th ^ "\n");
    OS.Process.exit OS.Process.success end)
 handle ex => (print ("SOURCE_INVERSE_DIAGNOSTIC_FAILED " ^ General.exnMessage ex ^ "\n");
               (show () handle _ => ()); OS.Process.exit OS.Process.failure);
