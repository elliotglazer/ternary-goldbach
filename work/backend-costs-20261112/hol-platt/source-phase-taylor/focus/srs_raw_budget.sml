val _ = set_goal ([],``  1/(2:real) pow 122 + 9/2 pow 131 + 2 pow 74 / &(FACT 73) + 2*((5/64)*(1/2 pow 128)) <= 1/2 pow 120``);
val _ = e (  REWRITE_TAC [EVAL ``FACT 73``] >> CONV_TAC RealField.REAL_RAT_REDUCE_CONV);
val srs_raw_budget = top_thm ();
print "CHECKED srs_raw_budget\n";
