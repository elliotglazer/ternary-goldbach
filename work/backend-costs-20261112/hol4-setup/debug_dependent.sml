e (Induct_on `ws` >> Cases_on `xs` >> simp [block_layer_def]);
e (Cases_on `t` >> simp [block_layer_def]);
e (rpt gen_tac >> pairarg_tac >> simp []);
top_goals ();
OS.Process.exit OS.Process.success;
