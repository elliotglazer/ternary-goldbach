top_goals();
e (Induct >> simp [checked_cover_def]);
e (rpt gen_tac >> PairCases_on `h` >> simp [checked_cover_def]);
e (rpt strip_tac >> Cases_on `j` >> fs []);
e (simp [binary_goldbach_def] >> metis_tac [tree_contains_prime]);
e (`target + 2 * SUC n = 2 * n + (target + 2)` by decide_tac >> metis_tac []);
val checked_cover_sound = top_thm();
val checked_cover_interval = prove (
 ``target MOD 2 = 0 /\ tree_primes tree /\ checked_cover target tree ws ==>
   !n. target <= n /\ n < target + 2 * LENGTH ws /\ n MOD 2 = 0 ==>
     binary_goldbach n``,
 rpt strip_tac >>
 `(n - target) DIV 2 < LENGTH ws /\
  target + 2 * ((n - target) DIV 2) = n` by Omega.OMEGA_TAC >>
 metis_tac [checked_cover_sound]);
val _ = cv_transLib.cv_trans tree_contains_def;
val _ = cv_transLib.cv_trans checked_cover_def;
val _ = print "DEBUG_COVER_COMPLETE\n";
