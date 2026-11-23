open HolKernel Parse boolLib bossLib complexTheory realTheory;
fun require b s = if b then () else raise Fail s;
val expected = ``!u v z w:complex. !err eps:real.
    0 <= err /\ 0 <= eps /\ modu z <= 1 /\ modu w = 1 /\
    modu (u-z) <= err /\ modu (v-w) <= eps ==>
    modu (u*v-z*w) <= (1+eps)*err + eps``;
val _ = require (aconv (#2 (proofManagerLib.top_goal ())) expected) "wrong saved target";
fun show () = List.app (fn (hs,g) =>
  (print "GOAL_BEGIN\n"; List.app (fn h => print (term_to_string h ^ "\n")) hs;
   print ("|- " ^ term_to_string g ^ "\nGOAL_END\n"))) (proofManagerLib.top_goals ());
fun step name tac = (print ("STEP," ^ name ^ "\n"); ignore (proofManagerLib.e tac); show ());
val _ = (
 step "introduce" (rpt gen_tac >> strip_tac);
 step "step_norm" (`modu v <= 1+eps` by metis_tac [ss_step_norm]);
 step "decomposition" (`u*v-z*w = (u-z)*v + z*(v-w)` by
    (REWRITE_TAC [COMPLEX_RE_IM_EQ,complex_mul,complex_add,complex_sub,
                  complex_neg,RE,IM,pairTheory.FST,pairTheory.SND] >>
     conj_tac >> RealField.REAL_ASM_ARITH_TAC));
 step "first_product" (`modu (u-z) * modu v <= err * (1+eps)` by
    (match_mp_tac REAL_LE_MUL2 >> simp [MODU_POS]));
 step "second_product" (`modu z * modu (v-w) <= 1*eps` by
    (match_mp_tac REAL_LE_MUL2 >> simp [MODU_POS]));
 step "triangle" (mp_tac (Q.SPECL [`(u-z)*v`,`z*(v-w)`] ss_modu_triangle));
 step "rewrite" (ASM_REWRITE_TAC []);
 print ("MODU_MUL_LITERAL " ^ thm_to_string complexTheory.MODU_MUL ^ "\n");
 step "modulus_product" (PURE_REWRITE_TAC [complexTheory.MODU_MUL]);
 ignore (proofManagerLib.e RealField.REAL_ASM_ARITH_TAC);
 let val th = proofManagerLib.top_thm ()
     val _ = require (null (hyp th) andalso aconv (concl th) expected) "changed or open result"
 in print ("SOURCE_STATE_DIAGNOSTIC_EXACT_CLOSED_THEOREM " ^ thm_to_string th ^ "\n");
    OS.Process.exit OS.Process.success end)
 handle ex => (print ("SOURCE_STATE_DIAGNOSTIC_FAILED " ^ General.exnMessage ex ^ "\n");
               (show () handle _ => ()); OS.Process.exit OS.Process.failure);
