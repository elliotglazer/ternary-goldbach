val _ = set_goal ([],``  !x:num. 0<x ==> ?initial. source_raw_initial x = SOME initial``);
val _ = e (  rpt strip_tac >> `1<=x` by decide_tac >> simp [source_raw_initial_def,source_initial_def]);
val srb_initial_exists = top_thm ();
print "CHECKED srb_initial_exists\n";
