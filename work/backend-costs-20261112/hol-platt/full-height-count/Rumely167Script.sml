Theory Rumely167
Ancestors arithmetic

(* a / 2^30 is the supplied phase upper bound. w is in units 5/2^18.
   Per-channel allowance is 385174/100000. Width is 835/64. *)
Definition strict167_def:
  strict167 a w k <=>
    100000 * a + 2 * 385174 * 1073741824 <
    100000 * (20480 * w + 14008975360 * (k + 1))
End

Theorem fixed_even_167:
  strict167 445408744777471 23453697 31760
Proof
  rw [strict167_def] >> EVAL_TAC
QED

Theorem fixed_odd_167:
  strict167 445415749265151 22450176 31762
Proof
  rw [strict167_def] >> EVAL_TAC
QED
