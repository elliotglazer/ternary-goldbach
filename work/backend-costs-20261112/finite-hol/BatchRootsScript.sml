Theory BatchRoots
Ancestors FiniteCover list
Libs cv_transLib

Definition roots_known_def:
  (roots_known tree [] <=> T) /\
  (roots_known tree (p::ps) <=> tree_contains p tree /\ roots_known tree ps)
End

Theorem roots_known_sound:
  !ps. tree_primes tree /\ roots_known tree ps ==> EVERY prime ps
Proof
  Induct >> simp [roots_known_def] >> metis_tac [tree_contains_prime]
QED

val _=cv_trans roots_known_def;
val _=print "HOL4_BATCH_ROOTS_THEORY_DONE\n";
