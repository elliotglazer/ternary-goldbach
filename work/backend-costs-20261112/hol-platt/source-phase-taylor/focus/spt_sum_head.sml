val _ = set_goal ([],``  !f (k:num) n. sum(k,SUC n) f = f k + sum(SUC k,n) f``);
val _ = e (  rpt gen_tac >> mp_tac (Q.SPECL [`f:num->real`,`k:num`,`1:num`,`n:num`] SUM_SPLIT) >>
  simp [SUM_1,ADD1,ADD_COMM]);
val spt_sum_head = top_thm ();
print "CHECKED spt_sum_head\n";
