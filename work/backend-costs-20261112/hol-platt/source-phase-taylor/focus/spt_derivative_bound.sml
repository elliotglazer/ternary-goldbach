val _ = set_goal ([],``  !n x. abs (FST (spt_d n x)) <= 1 /\ abs (SND (spt_d n x)) <= 1``);
val _ = e (  Induct >> simp [spt_d_def,COS_BOUND,SIN_BOUND]);
val spt_derivative_bound = top_thm ();
print "CHECKED spt_derivative_bound\n";
