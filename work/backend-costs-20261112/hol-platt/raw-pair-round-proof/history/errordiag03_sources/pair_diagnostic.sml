open HolKernel Parse boolLib bossLib realTheory intrealTheory;
fun require b s = if b then () else raise Fail s;
val expected = ``!s r:int. 0 < s ==>
    abs (real_of_int (round_scaled s r) - real_of_int r / real_of_int s)
      <= 1 / 2``;
val _ = require (aconv (#2 (proofManagerLib.top_goal ())) expected) "wrong saved target";
fun show () = List.app (fn (hs,g) =>
  (print "GOAL_BEGIN\n"; List.app (fn h => print (term_to_string h ^ "\n")) hs;
   print ("|- " ^ term_to_string g ^ "\nGOAL_END\n"))) (proofManagerLib.top_goals ());
fun step name tac = (print ("STEP," ^ name ^ "\n"); ignore (proofManagerLib.e tac); show ());
val _ = (
 step "introduce" (rpt gen_tac >> strip_tac);
 step "positive_grid" (`0 < real_of_int s` by metis_tac [real_of_int_lt,real_of_int_num]);
 step "real_residual" (`abs (real_of_int r - real_of_int (round_scaled s r) * real_of_int s)
      <= real_of_int s / 2` by metis_tac [round_scaled_real_residual]);
 step "field_identity" (`real_of_int (round_scaled s r) - real_of_int r / real_of_int s =
   -(real_of_int r - real_of_int (round_scaled s r) * real_of_int s) /
     real_of_int s` by RealField.REAL_ASM_FIELD_TAC);
 step "abs_division" (asm_simp_tac bool_ss [REAL_ABS_DIV,ABS_NEG,ABS_REFL,REAL_LT_IMP_LE,REAL_LE_LDIV_EQ]);
 ignore (proofManagerLib.e RealField.REAL_ASM_ARITH_TAC);
 let val th = proofManagerLib.top_thm ()
     val _ = require (null (hyp th) andalso aconv (concl th) expected) "changed or open result"
 in print ("RAW_PAIR_DIAGNOSTIC_EXACT_CLOSED_THEOREM " ^ thm_to_string th ^ "\n");
    OS.Process.exit OS.Process.success end)
 handle ex => (print ("RAW_PAIR_DIAGNOSTIC_FAILED " ^ General.exnMessage ex ^ "\n");
               (show () handle _ => ()); OS.Process.exit OS.Process.failure);
