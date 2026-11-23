From Stdlib Require Import ZArith.
Set NativeCompute Timing.
Example native_smoke : (137 * 239)%Z = 32743%Z.
Proof. Time native_compute. reflexivity. Time Qed.
Print Assumptions native_smoke.
