(* Unbuilt refinement candidate. Every result below requires construction. *)
Theory C10004TraversalRefinement
Ancestors C10004TraversalBase C10004Projection list arithmetic option
Libs intLib

val _ = numLib.prefer_num ();

Theorem ftr_genlist_pair:
  !xs. GENLIST (\i. tx_pair i xs) (LENGTH xs) = xs
Proof
  gen_tac >> match_mp_tac GENLIST_EL >> simp [txp_pair_el]
QED

Theorem ftr_pairs_any:
  !n xs. LENGTH xs = 2*n ==>
  ft_pairs xs = SOME (GENLIST (\j.
    tx_sub (tx_pair (2*j) xs) (tx_pair (2*j+1) xs)) n)
Proof
  rpt gen_tac >> strip_tac >>
  `GENLIST (\i. tx_pair i xs) (2*n) = xs` by
    metis_tac [ftr_genlist_pair] >>
  mp_tac (Q.SPECL [`n`,`\i. tx_pair i xs`] ft_pairs_genlist) >>
  ASM_SIMP_TAC bool_ss []
QED

Theorem ftr_chunks_any:
  !n width xs. LENGTH xs = n*width ==>
  ft_chunks n width xs = SOME
    (GENLIST (\i. GENLIST (\j. tx_pair (width*i+j) xs) width) n)
Proof
  rpt gen_tac >> strip_tac >>
  `GENLIST (\i. tx_pair i xs) (n*width) = xs` by
    metis_tac [ftr_genlist_pair] >>
  mp_tac (Q.SPECL [`n`,`width`,`\i. tx_pair i xs`] ft_chunks_genlist) >>
  ASM_SIMP_TAC bool_ss []
QED

Theorem ftr_rectangular:
  !width rows. EVERY (\row. LENGTH row = width) rows ==>
  GENLIST (\i. GENLIST (\j. tx_pair j (tx_row i rows)) width)
    (LENGTH rows) = rows
Proof
  rpt gen_tac >> strip_tac >>
  match_mp_tac GENLIST_EL >> conj_tac >- REFL_TAC >>
  qx_gen_tac `i` >> strip_tac >>
  `LENGTH (tx_row i rows) = width` by
    (FULL_SIMP_TAC bool_ss [EVERY_EL] >>
     ASM_SIMP_TAC bool_ss [txp_row_el]) >>
  `GENLIST (\j. tx_pair j (tx_row i rows)) width = tx_row i rows` by
    metis_tac [ftr_genlist_pair] >>
  ASM_SIMP_TAC bool_ss [txp_row_el]
QED

Theorem ftr_transpose_any:
  !width rows. EVERY (\row. LENGTH row = width) rows ==>
  ft_transpose width rows = SOME
    (GENLIST (\j. GENLIST (\i. tx_pair j (tx_row i rows)) (LENGTH rows)) width)
Proof
  rpt gen_tac >> strip_tac >>
  `GENLIST (\i. GENLIST (\j. tx_pair j (tx_row i rows)) width)
      (LENGTH rows) = rows` by metis_tac [ftr_rectangular] >>
  mp_tac (Q.SPECL [`width`,`LENGTH rows`,`\i j. tx_pair j (tx_row i rows)`]
    ft_transpose_genlist) >>
  ASM_SIMP_TAC bool_ss [] >> metis_tac []
QED

Theorem ftr_flatten_at:
  !n width rows i j. i < n /\ j < width ==>
  tx_pair (i*width+j) (tx_flatten n width rows) = tx_pair j (tx_row i rows)
Proof
  rpt gen_tac >> strip_tac >>
  `SUC i <= n` by intLib.ARITH_TAC >>
  `SUC i * width <= n * width` by
    (match_mp_tac LESS_MONO_MULT2 >> ASM_SIMP_TAC arith_ss []) >>
  `i*width+j < n*width` by
    (FULL_SIMP_TAC bool_ss [MULT_CLAUSES] >> intLib.ARITH_TAC) >>
  ASM_SIMP_TAC bool_ss [tx_flatten_def,txp_pair_genlist,DIV_MULT,MOD_MULT]
QED

Theorem ftr_flatten_at_left:
  !n width rows i j. i < n /\ j < width ==>
  tx_pair (width*i+j) (tx_flatten n width rows) = tx_pair j (tx_row i rows)
Proof
  rpt gen_tac >> strip_tac >> ONCE_REWRITE_TAC [MULT_COMM] >>
  match_mp_tac ftr_flatten_at >> ASM_REWRITE_TAC []
QED

Theorem ftr_concat_shape:
  !width rows. EVERY (\row. LENGTH row = width) rows ==>
  ft_concat rows = tx_flatten (LENGTH rows) width rows
Proof
  rpt gen_tac >> strip_tac >>
  `GENLIST (\i. GENLIST (\j.
      tx_pair (width*i+j) (tx_flatten (LENGTH rows) width rows)) width)
      (LENGTH rows) = rows` by
    (match_mp_tac GENLIST_EL >> conj_tac >- REFL_TAC >>
     qx_gen_tac `i` >> strip_tac >>
     `LENGTH (EL i rows) = width` by
       (FULL_SIMP_TAC bool_ss [EVERY_EL] >> ASM_SIMP_TAC bool_ss []) >>
     match_mp_tac GENLIST_EL >> conj_tac >- ASM_REWRITE_TAC [] >>
     qx_gen_tac `j` >> strip_tac >>
     ASM_SIMP_TAC bool_ss [ftr_flatten_at_left,txp_row_el,txp_pair_el]) >>
  `GENLIST (\k. tx_pair k (tx_flatten (LENGTH rows) width rows))
      (LENGTH rows * width) = tx_flatten (LENGTH rows) width rows` by
    (mp_tac (Q.SPEC `tx_flatten (LENGTH rows) width rows` ftr_genlist_pair) >>
     SIMP_TAC bool_ss [tx_flatten_def,LENGTH_GENLIST]) >>
  mp_tac (Q.SPECL [`LENGTH rows`,`width`,
    `\k. tx_pair k (tx_flatten (LENGTH rows) width rows)`] ft_concat_blocks) >>
  ASM_SIMP_TAC bool_ss []
QED

Theorem ftr_omit2:
  !cache x y. tx_omit 6 2 cache [x;y] = [tx_sub x y]
Proof
  rpt gen_tac >> EVAL_TAC
QED

Theorem ftr_selected2_length:
  !cache xs. LENGTH (txp_selected2 cache xs) = 2400
Proof
  SIMP_TAC arith_ss [txp_selected2_def,tx_flatten_def,LENGTH_GENLIST]
QED

Theorem ftr_selected2_values:
  !cache xs. txp_selected2 cache xs = GENLIST (\j.
    tx_sub (tx_pair (2*j) xs) (tx_pair (2*j+1) xs)) 2400
Proof
  rpt gen_tac >>
  REWRITE_TAC [txp_selected2_def,ftr_omit2,tx_flatten_def] >>
  SIMP_TAC arith_ss [] >> REWRITE_TAC [GENLIST_FUN_EQ] >>
  qx_gen_tac `j` >> strip_tac >>
  ASM_SIMP_TAC arith_ss [txp_row_genlist,tx_pair_def]
QED

Theorem ftr_pairs_selected:
  !cache xs. LENGTH xs = 4800 ==>
    ft_pairs xs = SOME (txp_selected2 cache xs)
Proof
  rpt gen_tac >> strip_tac >>
  mp_tac (Q.SPECL [`2400`,`xs`] ftr_pairs_any) >>
  ASM_SIMP_TAC arith_ss [ftr_selected2_values]
QED

Definition ftr_rows40_def:
  ftr_rows40 cache xs = GENLIST (\j61. tx_omit 6 40 cache
    (GENLIST (\j41. tx_pair (40*j61+j41) (txp_selected2 cache xs)) 40)) 60
End

Definition ftr_rows60_def:
  ftr_rows60 cache xs = GENLIST (\k41. tx_omit 6 60 cache
    (GENLIST (\j61. tx_pair (39*j61+k41) (txp_selected40 cache xs)) 60)) 39
End

Theorem ftr_rows40_shape:
  !cache xs. LENGTH (ftr_rows40 cache xs) = 60 /\
    EVERY (\row. LENGTH row = 39) (ftr_rows40 cache xs)
Proof
  SIMP_TAC arith_ss [ftr_rows40_def,LENGTH_GENLIST,EVERY_GENLIST,tx_omit_length]
QED

Theorem ftr_rows60_shape:
  !cache xs. LENGTH (ftr_rows60 cache xs) = 39 /\
    EVERY (\row. LENGTH row = 59) (ftr_rows60 cache xs)
Proof
  SIMP_TAC arith_ss [ftr_rows60_def,LENGTH_GENLIST,EVERY_GENLIST,tx_omit_length]
QED

Theorem ftr_selected40:
  !cache xs. txp_selected40 cache xs = tx_flatten 60 39 (ftr_rows40 cache xs)
Proof
  REWRITE_TAC [txp_selected40_def,ftr_rows40_def]
QED

Theorem ftr_selected60:
  !cache xs. tx_tensor_selected cache xs = tx_flatten 39 59 (ftr_rows60 cache xs)
Proof
  REWRITE_TAC [txp_selected_expand,ftr_rows60_def]
QED

Theorem ftr_chunks40:
  !cache xs. ft_chunks 60 40 (txp_selected2 cache xs) = SOME
    (GENLIST (\i. GENLIST (\j. tx_pair (40*i+j) (txp_selected2 cache xs)) 40) 60)
Proof
  rpt gen_tac >> match_mp_tac ftr_chunks_any >>
  SIMP_TAC arith_ss [ftr_selected2_length]
QED

Theorem ftr_map40:
  !cache xs. ft_rows40 cache
    (GENLIST (\i. GENLIST (\j. tx_pair (40*i+j) (txp_selected2 cache xs)) 40) 60) =
    ftr_rows40 cache xs
Proof
  rpt gen_tac >>
  REWRITE_TAC [ft_rows40_def,ftr_rows40_def,MAP_GENLIST,combinTheory.o_DEF] >>
  CONV_TAC (DEPTH_CONV BETA_CONV) >> REFL_TAC
QED

Theorem ftr_columns40:
  !cache xs.
  GENLIST (\j. GENLIST (\i. tx_pair j (tx_row i (ftr_rows40 cache xs))) 60) 39 =
  GENLIST (\j. GENLIST (\i. tx_pair (39*i+j) (txp_selected40 cache xs)) 60) 39
Proof
  rpt gen_tac >> REWRITE_TAC [GENLIST_FUN_EQ] >>
  qx_gen_tac `j` >> strip_tac >>
  qx_gen_tac `i` >> strip_tac >>
  ASM_SIMP_TAC bool_ss [ftr_selected40,ftr_flatten_at_left]
QED

Theorem ftr_transpose40:
  !cache xs. ft_transpose 39 (ftr_rows40 cache xs) = SOME
    (GENLIST (\j. GENLIST (\i. tx_pair (39*i+j) (txp_selected40 cache xs)) 60) 39)
Proof
  rpt gen_tac >>
  mp_tac (Q.SPECL [`39`,`ftr_rows40 cache xs`] ftr_transpose_any) >>
  SIMP_TAC bool_ss [ftr_rows40_shape,ftr_columns40]
QED

Theorem ftr_map60:
  !cache xs. ft_rows60 cache
    (GENLIST (\j. GENLIST (\i. tx_pair (39*i+j) (txp_selected40 cache xs)) 60) 39) =
    ftr_rows60 cache xs
Proof
  rpt gen_tac >>
  REWRITE_TAC [ft_rows60_def,ftr_rows60_def,MAP_GENLIST,combinTheory.o_DEF] >>
  CONV_TAC (DEPTH_CONV BETA_CONV) >> REFL_TAC
QED

Theorem ft_tensor_refines:
  !cache xs. LENGTH xs = 4800 ==>
    ft_tensor cache xs = SOME (tx_tensor_selected cache xs)
Proof
  rpt gen_tac >> strip_tac >>
  `ft_pairs xs = SOME (txp_selected2 cache xs)` by
    metis_tac [ftr_pairs_selected] >>
  `ft_concat (ftr_rows60 cache xs) = tx_flatten 39 59 (ftr_rows60 cache xs)` by
    (mp_tac (Q.SPECL [`59`,`ftr_rows60 cache xs`] ftr_concat_shape) >>
     SIMP_TAC bool_ss [ftr_rows60_shape]) >>
  ASM_SIMP_TAC bool_ss [ft_tensor_def,ftr_chunks40,ftr_map40,ftr_transpose40,
    ftr_map60,optionTheory.option_CLAUSES,ftr_selected60]
QED

Theorem ft_checked_refines:
  !roots xs. ft_checked roots xs = tx_checked roots xs
Proof
  rpt gen_tac >> Cases_on `tx_roots_ok roots /\ tx_input_ok xs`
  >- (`LENGTH xs = 4800` by fs [tx_input_ok_def] >>
      ASM_SIMP_TAC bool_ss [ft_checked_def,tx_checked_def,ft_tensor_refines,
        optionTheory.option_CLAUSES,LET_THM] >>
      CONV_TAC (DEPTH_CONV BETA_CONV) >> REFL_TAC) >>
  ASM_SIMP_TAC bool_ss [ft_checked_def,tx_checked_def]
QED

val _ = print "C10004_TRAVERSAL_REFINEMENT_PROOF_DONE\n";
