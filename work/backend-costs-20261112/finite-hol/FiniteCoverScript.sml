(* A full finite binary-Goldbach certificate. Tree ordering is an efficiency
   convention only: successful membership always identifies an actual node. *)
Theory FiniteCover
Ancestors primeCertificate arithmetic list
Libs cv_transLib Omega

Datatype:
  prime_tree = PEmpty | PNode prime_tree num prime_tree
End

Definition tree_primes_def:
  (tree_primes PEmpty <=> T) /\
  (tree_primes (PNode l p r) <=>
    tree_primes l /\ prime p /\ tree_primes r)
End

Definition tree_contains_def:
  (tree_contains p PEmpty <=> F) /\
  (tree_contains p (PNode l q r) <=>
    if p = q then T else if p < q then tree_contains p l
    else tree_contains p r)
End

Theorem tree_primes_empty:
  tree_primes PEmpty
Proof simp [tree_primes_def]
QED

Theorem tree_primes_node:
  tree_primes l /\ prime p /\ tree_primes r ==>
  tree_primes (PNode l p r)
Proof simp [tree_primes_def]
QED

Theorem tree_contains_prime:
  !tree p. tree_primes tree /\ tree_contains p tree ==> prime p
Proof
  Induct >> simp [tree_primes_def,tree_contains_def] >>
  rpt gen_tac >> rpt strip_tac >> BasicProvers.every_case_tac >> fs []
QED

Definition binary_goldbach_def:
  binary_goldbach n <=> ?p q. prime p /\ prime q /\ p + q = n
End

Definition checked_cover_def:
  (checked_cover target tree [] <=> T) /\
  (checked_cover target tree ((p,q)::ws) <=>
    p + q = target /\ tree_contains p tree /\ tree_contains q tree /\
    checked_cover (target + 2) tree ws)
End

Theorem checked_cover_sound:
  !ws target. tree_primes tree /\ checked_cover target tree ws ==>
    !j. j < LENGTH ws ==> binary_goldbach (target + 2 * j)
Proof
  Induct >> simp [checked_cover_def] >>
  rpt gen_tac >> PairCases_on `h` >> simp [checked_cover_def] >>
  rpt strip_tac >> Cases_on `j` >> fs []
  >- (simp [binary_goldbach_def] >> metis_tac [tree_contains_prime]) >>
  `target + 2 * SUC n = 2 * n + (target + 2)` by decide_tac >>
  metis_tac []
QED

Theorem checked_cover_interval:
  target MOD 2 = 0 /\ tree_primes tree /\ checked_cover target tree ws ==>
  !n. target <= n /\ n < target + 2 * LENGTH ws /\ n MOD 2 = 0 ==>
    binary_goldbach n
Proof
  rpt strip_tac >>
  `(n - target) DIV 2 < LENGTH ws /\
   target + 2 * ((n - target) DIV 2) = n` by Omega.OMEGA_TAC >>
  metis_tac [checked_cover_sound]
QED

val _ = cv_trans tree_contains_def;
val _ = cv_trans checked_cover_def;
val _ = print "HOL4_FINITE_COVER_THEORY_DONE\n";
