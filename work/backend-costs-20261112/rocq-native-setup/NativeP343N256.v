From Stdlib Require Import ZArith.
Require Import StageCheck DataP343N256.
Set NativeCompute Timing.
Lemma checked : check_stage scale bound inputs outputs = true.
Proof. Time native_compute. reflexivity. Time Qed.
Lemma certified : stage_spec scale bound inputs outputs.
Proof. exact (check_stage_sound scale bound inputs outputs checked). Qed.
Print Assumptions certified.
