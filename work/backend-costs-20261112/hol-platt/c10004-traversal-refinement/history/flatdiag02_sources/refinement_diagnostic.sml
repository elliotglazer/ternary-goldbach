open HolKernel Parse boolLib bossLib arithmeticTheory listTheory;
fun require b message = if b then () else raise Fail message;
fun mark label (goal as (asl,w)) =
  (print ("REFINE_STEP," ^ label ^ "\n");
   List.app (fn a => print ("ASSUM " ^ term_to_string a ^ "\n")) asl;
   print ("GOAL " ^ term_to_string w ^ "\n"); ALL_TAC goal);
val expected = ``!width rows. EVERY (\row. LENGTH row = width) rows ==>
  ft_concat rows = tx_flatten (LENGTH rows) width rows``;
val _ = require (aconv (#2 (proofManagerLib.top_goal ())) expected)
  "wrong initial diagnostic goal";
val _ = (ignore (proofManagerLib.e
  (  rpt gen_tac >> strip_tac >> mark "start" >>
  `GENLIST (\i. GENLIST (\j.
      tx_pair (width*i+j) (tx_flatten (LENGTH rows) width rows)) width)
      (LENGTH rows) = rows` by
    (match_mp_tac GENLIST_EL >> conj_tac >- REFL_TAC >>
     qx_gen_tac `i` >> strip_tac >> mark "outer_index" >>
     `LENGTH (EL i rows) = width` by
       (mark "row_length" >> FULL_SIMP_TAC bool_ss [EVERY_EL] >> ASM_SIMP_TAC bool_ss []) >>
     mark "inner_list" >> CONV_TAC (DEPTH_CONV BETA_CONV) >> match_mp_tac GENLIST_EL >> conj_tac >- ASM_REWRITE_TAC [] >>
     qx_gen_tac `j` >> strip_tac >> mark "inner_index" >>
     ASM_SIMP_TAC bool_ss [ftr_flatten_at_left,txp_row_el,txp_pair_el]) >>
  mark "rows_reconstructed" >>
  `GENLIST (\k. tx_pair k (tx_flatten (LENGTH rows) width rows))
      (LENGTH rows * width) = tx_flatten (LENGTH rows) width rows` by
    (mp_tac (Q.SPEC `tx_flatten (LENGTH rows) width rows` ftr_genlist_pair) >>
     SIMP_TAC bool_ss [tx_flatten_def,LENGTH_GENLIST]) >>
  mark "flatten_reconstructed" >>
  mp_tac (Q.SPECL [`LENGTH (rows:(int # int) list list)`,`width`,
    `\k. tx_pair k (tx_flatten (LENGTH rows) width rows)`] ft_concat_blocks) >>
  mark "blocks_specialized" >> ASM_SIMP_TAC bool_ss []));
  let val th = proofManagerLib.top_thm ()
      val _ = require (null (hyp th) andalso aconv (concl th) expected)
        "open or changed diagnostic theorem"
  in print ("REFINE_DIAGNOSTIC_EXACT_CLOSED_THEOREM " ^ thm_to_string th ^ "\n");
     OS.Process.exit OS.Process.success end)
  handle ex => (print ("REFINE_DIAGNOSTIC_FAILED " ^ General.exnMessage ex ^ "\n");
               OS.Process.exit OS.Process.failure);
