open HolKernel Parse boolLib bossLib sortingTheory arithmeticTheory listTheory;
fun show_goals () = List.app (fn (asl,w) =>
  (List.app (fn a => print ("ASSUM " ^ Parse.term_to_string a ^ "\n")) asl;
   print ("GOAL " ^ Parse.term_to_string w ^ "\n")))
  (proofManagerLib.top_goals ());
fun step name tac =
  ((print ("TRY " ^ name ^ "\n");
    ignore (proofManagerLib.e tac);
    show_goals (); print ("PASS " ^ name ^ "\n"))
   handle e => (print ("FAIL " ^ name ^ ": " ^ General.exnMessage e ^ "\n");
                show_goals (); OS.Process.exit OS.Process.failure));
val _ = show_goals ();
val _ = step "induct" (Induct_on `fuel`);
val _ = step "base" (Cases_on `xs` >> simp [map_num_qsort_fuel_def, QSORT_DEF]);
val _ = step "step_binders" (gen_tac >> strip_tac);
val _ = step "list_cases" (Cases_on `xs`);
val _ = step "nil" (simp [map_num_qsort_fuel_def, QSORT_DEF]);
val _ = step "name_cons" (rename1 `LENGTH (h::t) <= SUC fuel`);
val _ = step "tail_bound" (`LENGTH t <= fuel` by fs []);
val _ = step "partition_cases" (Cases_on `PARTITION (\y:num. y <= h) t`);
val _ = step "name_partition" (rename1 `PARTITION (\y:num. y <= h) t = (l1,l2)`);
val _ = step "partition_bounds"
  (qpat_x_assum `PARTITION (\y:num. y <= h) t = (l1,l2)`
     (fn part_eq =>
       let val _ = print "PART_ENTER\n"
           val part = REWRITE_RULE [PARTITION_DEF] (SYM part_eq)
           val _ = print ("PART_EQ " ^ thm_to_string part ^ "\n")
           val spec = Q.SPECL [`\y:num. y <= h`, `t`, `[]`, `[]`, `l1`, `l2`]
               PART_LENGTH_LEM
           val _ = print ("PART_SPEC " ^ thm_to_string spec ^ "\n")
           val bounds = MATCH_MP spec part
           val _ = print ("PART_BOUNDS " ^ thm_to_string bounds ^ "\n")
           val simple = SIMP_RULE (srw_ss()) [] bounds
           val _ = print ("PART_SIMPLE " ^ thm_to_string simple ^ "\n")
       in assume_tac part_eq THEN strip_assume_tac simple end));
val _ = step "left_bound" (`LENGTH l1 <= fuel` by
  (irule LESS_EQ_TRANS >> qexists_tac `LENGTH t` >> asm_rewrite_tac []));
val _ = step "right_bound" (`LENGTH l2 <= fuel` by
  (irule LESS_EQ_TRANS >> qexists_tac `LENGTH t` >> asm_rewrite_tac []));
val _ = step "induction_instances"
  (qpat_x_assum `!xs. LENGTH xs <= fuel ==> _`
     (fn ih =>
       assume_tac (MP (Q.SPEC `l1` ih) (ASSUME ``LENGTH l1 <= fuel``)) THEN
       assume_tac (MP (Q.SPEC `l2` ih) (ASSUME ``LENGTH l2 <= fuel``))));
val _ = step "finish" (asm_rewrite_tac [map_num_qsort_fuel_def, QSORT_DEF]);
val _ = print "MAP_PROOF_DIAGNOSTIC_FINISHED_NO_THEORY_EXPORT\n";
val _ = OS.Process.exit OS.Process.success;
