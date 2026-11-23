(* A dependent arithmetic network, not a certified FFT or zero counter.
   Each layer pairs adjacent values; rotation connects different pairs at the
   next layer. Coefficients are arbitrary integers with positive scale. *)
Theory DependentBlock
Ancestors BlockRound StageCheck integer list
Libs intLib cv_transLib

val _ = intLib.prefer_int ();

Definition block_layer_def:
  (block_layer s [] xs = xs) /\
  (block_layer s (w::ws) [] = []) /\
  (block_layer s (w::ws) [u] = [u]) /\
  (block_layer s (w::ws) (u::v::xs) =
    let (p,m) = rounded_butterfly s u v w
    in p::m::block_layer s ws xs)
End

Definition block_rotate_def:
  (block_rotate [] = []) /\
  (block_rotate (x::xs) = xs ++ [x])
End

Definition block_run_def:
  (block_run s ws 0 xs = xs) /\
  (block_run s ws (SUC n) xs =
    block_run s ws n (block_rotate (block_layer s ws xs)))
End

Definition layer_contract_def:
  (layer_contract s [] xs ys <=> xs = ys) /\
  (layer_contract s (w::ws) [] ys <=> F) /\
  (layer_contract s (w::ws) [u] ys <=> F) /\
  (layer_contract s (w::ws) (u::v::xs) ys <=>
    ?p m zs. ys = p::m::zs /\ local_residual s u v w (p,m) /\
      layer_contract s ws xs zs)
End

Definition block_contract_def:
  (block_contract s ws 0 xs ys <=> xs = ys) /\
  (block_contract s ws (SUC n) xs ys <=>
    ?zs. layer_contract s ws xs zs /\
      block_contract s ws n (block_rotate zs) ys)
End

Theorem block_layer_length:
  !ws xs. LENGTH (block_layer s ws xs) = LENGTH xs
Proof
  Induct_on `ws` >> Cases_on `xs` >> simp [block_layer_def] >>
  Cases_on `t` >> simp [block_layer_def] >>
  rpt gen_tac >> pairarg_tac >> simp []
QED

Theorem block_rotate_length[simp]:
  !xs. LENGTH (block_rotate xs) = LENGTH xs
Proof
  Cases >> simp [block_rotate_def]
QED

Theorem block_run_length:
  !n xs. LENGTH (block_run s ws n xs) = LENGTH xs
Proof
  Induct_on `n` >> simp [block_run_def,block_layer_length]
QED

Theorem rounded_butterfly_residual_pairs:
  0 < s ==> local_residual s u v w (rounded_butterfly s u v w)
Proof
  PairCases_on `u` >> PairCases_on `v` >> PairCases_on `w` >>
  metis_tac [rounded_butterfly_residual]
QED

Theorem block_layer_sound:
  !ws xs. 0 < s /\ LENGTH xs = 2 * LENGTH ws ==>
    layer_contract s ws xs (block_layer s ws xs)
Proof
  Induct_on `ws` >> Cases_on `xs` >>
  simp [block_layer_def,layer_contract_def] >>
  Cases_on `t` >> simp [block_layer_def,layer_contract_def] >>
  rpt strip_tac >> pairarg_tac >> simp [] >>
  metis_tac [rounded_butterfly_residual_pairs]
QED

Theorem block_run_sound:
  !n xs. 0 < s /\ LENGTH xs = 2 * LENGTH ws ==>
    block_contract s ws n xs (block_run s ws n xs)
Proof
  Induct_on `n` >> simp [block_run_def,block_contract_def] >>
  rpt strip_tac >>
  qexists_tac `block_layer s ws xs` >>
  simp [block_layer_sound,block_layer_length]
QED

Definition block_bound_def:
  (block_bound (b:int) [] <=> T) /\
  (block_bound b ((r,i)::xs) <=>
    within b r /\ within b i /\ block_bound b xs)
End

Definition block_checksum_def:
  (block_checksum [] = (0:int)) /\
  (block_checksum ((r,i)::xs) = r + 3*i + 9*block_checksum xs)
End

Definition block_accept_def:
  block_accept s ws n xs b expected <=>
    0 < s /\ LENGTH xs = 2 * LENGTH ws /\
    let ys = block_run s ws n xs
    in block_bound b ys /\ block_checksum ys = expected
End

Theorem block_accept_sound:
  block_accept s ws n xs b expected ==>
    ?ys. LENGTH ys = LENGTH xs /\ block_contract s ws n xs ys /\
      block_bound b ys /\ block_checksum ys = expected
Proof
  simp [block_accept_def,LET_THM] >> rpt strip_tac >>
  qexists_tac `block_run s ws n xs` >>
  simp [block_run_length,block_run_sound]
QED

val layer_pre_def = cv_trans_pre "block_layer_pre" block_layer_def;

Theorem block_layer_pre_ok[cv_pre]:
  !ws xs. 0 < s ==> block_layer_pre s ws xs
Proof
  Induct_on `ws` >> Cases_on `xs` >> simp [Once layer_pre_def] >>
  Cases_on `t` >> simp [Once layer_pre_def,rounded_butterfly_pre_ok]
QED

val _ = cv_trans block_rotate_def;
val run_pre_def = cv_trans_pre "block_run_pre" block_run_def;

Theorem block_run_pre_ok[cv_pre]:
  !n xs. 0 < s ==> block_run_pre s ws n xs
Proof
  Induct_on `n` >> simp [Once run_pre_def,block_layer_pre_ok]
QED

val _ = cv_trans block_bound_def;
val _ = cv_trans block_checksum_def;
val accept_pre_def = cv_trans_pre "block_accept_pre" block_accept_def;

Theorem block_accept_pre_ok[cv_pre]:
  0 < s ==> block_accept_pre s ws n xs b expected
Proof
  simp [accept_pre_def,block_run_pre_ok]
QED

val _ = print "HOL4_DEPENDENT_BLOCK_THEORY_DONE\n";
