val _ = set_goal ([],``  !n u. sum (0,SUC n) (\j. SND (spt_d j 0) / &(FACT j) * u pow j) = IM (seh_ideal u n 0)``);
val _ = e (  rpt gen_tac >> mp_tac (Q.SPECL [`n:num`,`0:num`,`u:real`,`\j. SND (spt_d j 0)`] spt_sum_horner) >>
  simp [spt_d_def,FACT,COS_0,SIN_0,pow]);
val srt_sin_poly = top_thm ();
print "CHECKED srt_sin_poly\n";
