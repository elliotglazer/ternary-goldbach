val _ = set_goal ([],``  source_inverse_root 10004 1 (2**98) = 3168492865354689069166240814``);
val _ = e (  REWRITE_TAC [source_inverse_root_def] >> match_mp_tac ROOT_UNIQUE >> EVAL_TAC);
val srh_c_root = top_thm ();
print "CHECKED srh_c_root\n";
