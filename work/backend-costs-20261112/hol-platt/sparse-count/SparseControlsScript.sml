Theory SparseControls
Ancestors SparseCount
Libs cv_transLib meter

val _=List.app (fn (name,goal) =>
  let val th=EQT_ELIM(cv_eval goal) in
    if closed th then ignore(save_thm(name,th)) else raise Fail name end)
  [("missing_raw_rejected", ``load_row 1 0 1 [] sptree$LN = NONE``),
   ("mask_outside_row_rejected", ``load_row 1 0 2 [] sptree$LN = NONE``),
   ("raw_outside_word_rejected", ``load_row 1 0 1 [2**256] sptree$LN = NONE``),
   ("repeated_time_rejected", ``chunk 1 0 4096 1 [] = NONE``)];

val _=print "SPARSE_CONTROLS_DONE\n";
