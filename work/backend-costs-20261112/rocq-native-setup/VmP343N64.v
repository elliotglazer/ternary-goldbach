From Stdlib Require Import ZArith.
Require Import StageCheck DataP343N64.
Lemma checked : check_stage scale bound inputs outputs = true.
Proof. Time vm_compute. reflexivity. Time Qed.
Lemma certified : stage_spec scale bound inputs outputs.
Proof. exact (check_stage_sound scale bound inputs outputs checked). Qed.
Print Assumptions certified.
