(* Only layer/run/accept are copied. Rotation, bounds, checksum and the
   semantic contract remain the original DependentBlock constants. *)
Theory RoundDependent
Ancestors RoundSpecialization RoundSpecializationCV DependentBlock integer list
Libs intLib cv_transLib

val _ = intLib.prefer_int ();

Definition round_block_layer_def:
  (round_block_layer s [] xs = xs) /\
  (round_block_layer s (w::ws) [] = []) /\
  (round_block_layer s (w::ws) [u] = [u]) /\
  (round_block_layer s (w::ws) (u::v::xs) =
    let (p,m) = rounded_butterfly_one s u v w
    in p::m::round_block_layer s ws xs)
End

Theorem round_block_layer_correct:
  !ws xs. 0 < s ==> round_block_layer s ws xs = block_layer s ws xs
Proof
  Induct_on `ws` >> Cases_on `xs` >>
  simp [round_block_layer_def,block_layer_def] >>
  Cases_on `t` >>
  simp [round_block_layer_def,block_layer_def,rounded_butterfly_one_correct]
QED

Definition round_block_run_def:
  (round_block_run s ws 0 xs = xs) /\
  (round_block_run s ws (SUC n) xs =
    round_block_run s ws n (block_rotate (round_block_layer s ws xs)))
End

Theorem round_block_run_correct:
  !n xs. 0 < s ==> round_block_run s ws n xs = block_run s ws n xs
Proof
  Induct_on `n` >>
  simp [round_block_run_def,block_run_def,round_block_layer_correct]
QED

Definition round_block_accept_def:
  round_block_accept s ws n xs b expected <=>
    0 < s /\ LENGTH xs = 2 * LENGTH ws /\
    let ys = round_block_run s ws n xs
    in block_bound b ys /\ block_checksum ys = expected
End

Theorem round_block_accept_correct:
  0 < s ==>
    (round_block_accept s ws n xs b expected <=>
     block_accept s ws n xs b expected)
Proof
  simp [round_block_accept_def,block_accept_def,round_block_run_correct]
QED

Theorem round_block_accept_sound:
  round_block_accept s ws n xs b expected ==>
    ?ys. LENGTH ys = LENGTH xs /\ block_contract s ws n xs ys /\
      block_bound b ys /\ block_checksum ys = expected
Proof
  strip_tac >>
  `0 < s` by metis_tac [round_block_accept_def] >>
  metis_tac [round_block_accept_correct,block_accept_sound]
QED

(* The alternate arithmetic is total and has no CV precondition.  The
   positive-scale requirement remains in the definitions and proof contracts. *)
val _ = cv_trans round_block_layer_def;
val _ = cv_trans round_block_run_def;
val _ = cv_trans round_block_accept_def;

val _ = print "HOL4_ROUND_DEPENDENT_THEORY_DONE\n";
