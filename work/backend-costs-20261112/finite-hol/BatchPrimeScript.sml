(* Experimental batched certificate checker. Acceptance requires this theory
   and a complete concrete benchmark to compile; source text alone is no claim
   that the optimization works or is faster. No new axioms are introduced. *)
Theory BatchPrime
Ancestors FiniteCover primeCertificate expMod combinatorics divides list cv_std
Libs cv_transLib

Datatype:
  certificate_tree = CEmpty |
    CNode certificate_tree num num (num list) certificate_tree
End

Definition cert_contains_def:
  (cert_contains p CEmpty <=> F) /\
  (cert_contains p (CNode l q a fs r) <=>
    if p = q then T else if p < q then cert_contains p l
    else cert_contains p r)
End

Definition node_valid_def:
  node_valid tree p a fs <=>
    if p = 2 then T else
    1 < p /\ PROD fs = p - 1 /\
    EVERY (\q. q < p /\ cert_contains q tree) fs /\
    exp_mod_binary a (p - 1) p = 1 /\
    EVERY (\q. exp_mod_binary a ((p - 1) DIV q) p <> 1) fs
End

Definition tree_valid_def:
  (tree_valid full CEmpty <=> T) /\
  (tree_valid full (CNode l p a fs r) <=>
    tree_valid full l /\ node_valid full p a fs /\ tree_valid full r)
End

Theorem cert_contains_valid:
  !tree p. tree_valid full tree /\ cert_contains p tree ==>
    ?a fs. node_valid full p a fs
Proof
  Induct >> simp [tree_valid_def,cert_contains_def] >>
  rpt gen_tac >> rpt strip_tac >> BasicProvers.every_case_tac >> fs [] >>
  metis_tac []
QED

Theorem node_valid_prime:
  !p. !tree a fs. tree_valid tree tree /\ node_valid tree p a fs ==> prime p
Proof
  completeInduct_on `p` >> rpt strip_tac >>
  Cases_on `p = 2` >- fs [PRIME_2] >>
  qpat_x_assum `node_valid tree p a fs` mp_tac >>
  asm_simp_tac (srw_ss()) [node_valid_def,exp_mod_binary_eqn] >> rpt strip_tac >>
  `EVERY prime fs` by
    (fs [EVERY_MEM] >> metis_tac [cert_contains_valid]) >>
  metis_tac [prime_cert_check]
QED

Definition prime_values_def:
  (prime_values CEmpty = PEmpty) /\
  (prime_values (CNode l p a fs r) =
    PNode (prime_values l) p (prime_values r))
End

Theorem tree_valid_primes:
  !tree. tree_valid full full /\ tree_valid full tree ==>
    tree_primes (prime_values tree)
Proof
  Induct >> simp [tree_valid_def,prime_values_def,tree_primes_def] >>
  metis_tac [node_valid_prime]
QED

Theorem batch_prime_sound:
  tree_valid tree tree ==> tree_primes (prime_values tree)
Proof metis_tac [tree_valid_primes]
QED

(* First-order versions of the two list predicates for cv_compute. *)
Definition factors_known_def:
  (factors_known tree p [] <=> T) /\
  (factors_known tree p (q::fs) <=>
    q < p /\ cert_contains q tree /\ factors_known tree p fs)
End

Definition factors_mod_def:
  (factors_mod p a [] <=> T) /\
  (factors_mod p a (q::fs) <=>
    exp_mod_binary a ((p - 1) DIV q) p <> 1 /\ factors_mod p a fs)
End

Theorem factors_known_eq:
  !fs. factors_known tree p fs = EVERY (\q. q < p /\ cert_contains q tree) fs
Proof Induct >> simp [factors_known_def,CONJ_ASSOC]
QED

Theorem factors_mod_eq:
  !fs. factors_mod p a fs = EVERY (\q. exp_mod_binary a ((p - 1) DIV q) p <> 1) fs
Proof Induct >> simp [factors_mod_def]
QED

Theorem node_valid_compute:
  node_valid tree p a fs =
    (if p = 2 then T else
     1 < p /\ PROD fs = p - 1 /\ factors_known tree p fs /\
     exp_mod_binary a (p - 1) p = 1 /\ factors_mod p a fs)
Proof simp [node_valid_def,factors_known_eq,factors_mod_eq]
QED

val _ = cv_trans cert_contains_def;
val _ = cv_trans factors_known_def;
val _ = cv_trans factors_mod_def;
val _ = cv_trans combinatoricsTheory.PROD;
val _ = cv_trans node_valid_compute;
val _ = cv_trans tree_valid_def;
val _ = cv_trans prime_values_def;
val _ = print "HOL4_BATCH_PRIME_THEORY_DONE\n";
