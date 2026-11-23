From Stdlib Require Import ZArith List.
Require Import StageCheck DataP343N64.
Import ListNotations.
Open Scope Z_scope.
Definition wrong := Out (pr y0+1) (pi y0) (mr y0-1) (mi y0).
Definition bad_coefficient := Inp (ur x0) (ui x0) (vr x0) (vi x0) 0 (wi x0).
Example valid : check_stage scale bound inputs outputs = true.
Proof. vm_compute. reflexivity. Qed.
Example wrong_rejected : check_stage scale bound inputs (wrong::tl outputs) = false.
Proof. vm_compute. reflexivity. Qed.
Example missing_rejected : check_stage scale bound inputs (tl outputs) = false.
Proof. vm_compute. reflexivity. Qed.
Example reordered_rejected : check_stage scale bound inputs (y1::y0::skipn 2 outputs) = false.
Proof. vm_compute. reflexivity. Qed.
Example coefficient_rejected : check_stage scale bound (bad_coefficient::tl inputs) outputs = false.
Proof. vm_compute. reflexivity. Qed.
Print Assumptions valid.
Print Assumptions wrong_rejected.
Print Assumptions missing_rejected.
Print Assumptions reordered_rejected.
Print Assumptions coefficient_rejected.
