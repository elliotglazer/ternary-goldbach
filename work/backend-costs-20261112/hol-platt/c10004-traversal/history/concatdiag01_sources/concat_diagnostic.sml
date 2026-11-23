open HolKernel Parse boolLib bossLib arithmeticTheory listTheory;
fun require b message = if b then () else raise Fail message;
fun mark label (goal as (asl,w)) =
  (print ("CONCAT_STEP," ^ label ^ "\n");
   List.app (fn a => print ("ASSUM " ^ term_to_string a ^ "\n")) asl;
   print ("GOAL " ^ term_to_string w ^ "\n"); ALL_TAC goal);
val expected = ``!n width xs rows. ft_chunks n width xs = SOME rows ==>
  ft_concat rows = xs``;
val _ = require (aconv (#2 (proofManagerLib.top_goal ())) expected)
  "wrong initial diagnostic goal";
val _ = (ignore (proofManagerLib.e
  (Induct_on `n`
   >- (mark "base" >> rw [ft_chunks_def] >> fs [ft_concat_def]) >>
   rpt gen_tac >> mark "step" >> Cases_on `width <= LENGTH xs` >>
   mark "length_case" >>
   ASM_SIMP_TAC bool_ss [ft_chunks_def,ft_take_spec,
     optionTheory.option_case_def,optionTheory.NOT_NONE_SOME,pairTheory.pair_case_thm] >>
   mark "after_unfold" >> Cases_on `ft_chunks n width (DROP width xs)` >>
   mark "recursive_case" >>
   ASM_SIMP_TAC bool_ss [optionTheory.option_case_def,optionTheory.NOT_NONE_SOME,
     optionTheory.SOME_11] >>
   mark "before_strip" >> strip_tac >> fs [ft_concat_def] >> metis_tac [TAKE_DROP]));
  let val th = proofManagerLib.top_thm ()
      val _ = require (null (hyp th) andalso aconv (concl th) expected)
        "open or changed diagnostic theorem"
  in print ("CONCAT_DIAGNOSTIC_EXACT_CLOSED_THEOREM " ^ thm_to_string th ^ "\n");
     OS.Process.exit OS.Process.success end)
  handle ex => (print ("CONCAT_DIAGNOSTIC_FAILED " ^ General.exnMessage ex ^ "\n");
               OS.Process.exit OS.Process.failure);
