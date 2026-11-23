open HolKernel Parse boolLib bossLib arithmeticTheory listTheory;
fun require b message = if b then () else raise Fail message;
fun mark label (goal as (asl,w)) =
  (print ("REFINE_STEP," ^ label ^ "\n");
   List.app (fn a => print ("ASSUM " ^ term_to_string a ^ "\n")) asl;
   print ("GOAL " ^ term_to_string w ^ "\n"); ALL_TAC goal);
val expected = ``!width rows. EVERY (\row. LENGTH row = width) rows ==>
  ft_transpose width rows = SOME
    (GENLIST (\j. GENLIST (\i. tx_pair j (tx_row i rows)) (LENGTH rows)) width)``;
val _ = require (aconv (#2 (proofManagerLib.top_goal ())) expected)
  "wrong initial diagnostic goal";
val _ = (ignore (proofManagerLib.e
  (rpt gen_tac >> strip_tac >>
   `GENLIST (\i. GENLIST (\j. tx_pair j (tx_row i rows)) width)
       (LENGTH rows) = rows` by metis_tac [ftr_rectangular] >>
   mark "rectangular" >>
   mp_tac (Q.SPECL [`width`,`LENGTH (rows:(int # int) list list)`,`\i j. tx_pair j (tx_row i rows)`]
     ft_transpose_genlist) >>
   mark "instantiated" >> ASM_SIMP_TAC bool_ss [] >>
   mark "simplified" >> metis_tac []));
  let val th = proofManagerLib.top_thm ()
      val _ = require (null (hyp th) andalso aconv (concl th) expected)
        "open or changed diagnostic theorem"
  in print ("REFINE_DIAGNOSTIC_EXACT_CLOSED_THEOREM " ^ thm_to_string th ^ "\n");
     OS.Process.exit OS.Process.success end)
  handle ex => (print ("REFINE_DIAGNOSTIC_FAILED " ^ General.exnMessage ex ^ "\n");
               OS.Process.exit OS.Process.failure);
