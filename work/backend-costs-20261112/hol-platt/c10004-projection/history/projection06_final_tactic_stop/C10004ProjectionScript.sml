(* Source-only proof candidate. Not yet compiled or accepted.
   No analytic root or cache correctness hypothesis is required. *)
Theory C10004Projection
Ancestors C10004Transform list arithmetic
Libs intLib

(* Total lookup helpers agree with EL only within the stated range. *)
Theorem txp_pair_el:
  !xs k. k < LENGTH xs ==> tx_pair k xs = EL k xs
Proof
  Induct_on `xs` >- simp [] >>
  Cases_on `k` >> simp [tx_pair_def,EL]
QED

Theorem txp_row_el:
  !xs k. k < LENGTH xs ==> tx_row k xs = EL k xs
Proof
  Induct_on `xs` >- simp [] >>
  Cases_on `k` >> simp [tx_row_def,EL]
QED

Theorem txp_pair_genlist:
  k < n ==> tx_pair k (GENLIST f n) = f k
Proof
  simp [txp_pair_el]
QED

Theorem txp_row_genlist:
  k < n ==> tx_row k (GENLIST f n) = f k
Proof
  simp [txp_row_el]
QED

(* This identity also holds on [] because tx_pair is total with zero default. *)
Theorem txp_pair_tl:
  tx_pair k (TL xs) = tx_pair (SUC k) xs
Proof
  Cases_on `xs` >> simp [tx_pair_def]
QED

Theorem txp_omit_at:
  tx_pair k (tx_omit fuel n cache xs) =
    tx_pair (k+1) (tx_full fuel n cache xs)
Proof
  simp [tx_omit_projection,txp_pair_tl,ADD1]
QED

Theorem txp_flatten_at:
  !k count width:num. !f.
  k < count * width /\ k DIV width < count ==>
  tx_pair k (tx_flatten count width (GENLIST f count)) =
    tx_pair (k MOD width) (f (k DIV width))
Proof
  simp [tx_flatten_def,txp_pair_genlist,txp_row_genlist]
QED

(* Names for the actual intermediate arrays. They reproduce the original
   definitions, rather than introducing an alternate output specification. *)
Definition txp_full2_def:
  txp_full2 cache xs = tx_flatten 2400 2
    (GENLIST (\j. tx_full 6 2 cache
      [tx_pair (2*j) xs;tx_pair (2*j+1) xs]) 2400)
End

Definition txp_selected2_def:
  txp_selected2 cache xs = tx_flatten 2400 1
    (GENLIST (\j. tx_omit 6 2 cache
      [tx_pair (2*j) xs;tx_pair (2*j+1) xs]) 2400)
End

Definition txp_full40_def:
  txp_full40 cache xs = tx_flatten 120 40
    (GENLIST (\line. tx_full 6 40 cache
      (GENLIST (\j41. tx_pair
        (2*(40*(line DIV 2)+j41)+line MOD 2)
        (txp_full2 cache xs)) 40)) 120)
End

Definition txp_selected40_def:
  txp_selected40 cache xs = tx_flatten 60 39
    (GENLIST (\j61. tx_omit 6 40 cache
      (GENLIST (\j41. tx_pair (40*j61+j41)
        (txp_selected2 cache xs)) 40)) 60)
End

Theorem txp_stage2:
  j < 2400 ==>
  tx_pair j (txp_selected2 cache xs) =
    tx_pair (2*j+1) (txp_full2 cache xs)
Proof
  strip_tac >>
  `2*j+1 < 2400*2 /\ (2*j+1) DIV 2 = j /\
    (2*j+1) MOD 2 = 1` by intLib.ARITH_TAC >>
  ASM_SIMP_TAC arith_ss [txp_selected2_def,txp_full2_def,txp_flatten_at,txp_omit_at]
QED

Theorem txp_line40:
  j61 < 60 ==>
  GENLIST (\j41. tx_pair (40*j61+j41) (txp_selected2 cache xs)) 40 =
  GENLIST (\j41. tx_pair
    (2*(40*((2*j61+1) DIV 2)+j41)+(2*j61+1) MOD 2)
    (txp_full2 cache xs)) 40
Proof
  strip_tac >>
  `(2*j61+1) DIV 2 = j61 /\ (2*j61+1) MOD 2 = 1`
    by intLib.ARITH_TAC >>
  REWRITE_TAC [GENLIST_FUN_EQ] >> qx_gen_tac `j41` >> strip_tac >>
  `40*j61+j41 < 2400` by intLib.ARITH_TAC >>
  ASM_SIMP_TAC arith_ss [txp_stage2]
QED

Theorem txp_stage40:
  j61 < 60 /\ k41 < 39 ==>
  tx_pair (39*j61+k41) (txp_selected40 cache xs) =
  tx_pair ((2*j61+1)*40+(k41+1)) (txp_full40 cache xs)
Proof
  strip_tac >>
  `39*j61+k41 < 60*39 /\
    (39*j61+k41) DIV 39 = j61 /\
    (39*j61+k41) MOD 39 = k41 /\
    (2*j61+1)*40+(k41+1) < 120*40 /\
    ((2*j61+1)*40+(k41+1)) DIV 40 = 2*j61+1 /\
    ((2*j61+1)*40+(k41+1)) MOD 40 = k41+1 /\
    2*j61+1 < 120` by intLib.ARITH_TAC >>
  ASM_SIMP_TAC bool_ss [txp_selected40_def,txp_full40_def,txp_flatten_at,
        txp_line40,txp_omit_at]
QED

Theorem txp_line60:
  k41 < 39 ==>
  GENLIST (\j61. tx_pair (39*j61+k41) (txp_selected40 cache xs)) 60 =
  GENLIST (\j61. tx_pair
    ((2*j61+(2*(k41+1)+1) MOD 2)*40+(2*(k41+1)+1) DIV 2)
    (txp_full40 cache xs)) 60
Proof
  strip_tac >>
  `(2*(k41+1)+1) MOD 2 = 1 /\
    (2*(k41+1)+1) DIV 2 = k41+1` by intLib.ARITH_TAC >>
  REWRITE_TAC [GENLIST_FUN_EQ] >> qx_gen_tac `j61` >> strip_tac >>
  ASM_SIMP_TAC arith_ss [txp_stage40]
QED

Theorem txp_selected_expand:
  tx_tensor_selected cache xs = tx_flatten 39 59
    (GENLIST (\k41. tx_omit 6 60 cache
      (GENLIST (\j61. tx_pair (39*j61+k41)
        (txp_selected40 cache xs)) 60)) 39)
Proof
  REWRITE_TAC [tx_tensor_selected_def,txp_selected40_def,txp_selected2_def,LET_THM] >>
  CONV_TAC (DEPTH_CONV BETA_CONV) >> REFL_TAC
QED

Theorem txp_full_expand:
  tx_tensor_full cache xs = tx_flatten 80 60
    (GENLIST (\line. tx_full 6 60 cache
      (GENLIST (\j61. tx_pair
        ((2*j61+line MOD 2)*40+line DIV 2)
        (txp_full40 cache xs)) 60)) 80)
Proof
  REWRITE_TAC [tx_tensor_full_def,txp_full40_def,txp_full2_def,LET_THM] >>
  CONV_TAC (DEPTH_CONV BETA_CONV) >> REFL_TAC
QED

Theorem txp_stage60:
  !cache xs k41 k61. k41 < 39 /\ k61 < 59 ==>
  tx_pair (59*k41+k61) (tx_tensor_selected cache xs) =
  tx_pair ((2*(k41+1)+1)*60+(k61+1)) (tx_tensor_full cache xs)
Proof
  rpt gen_tac >> strip_tac >>
  `59*k41+k61 < 39*59 /\
    (59*k41+k61) DIV 59 = k41 /\
    (59*k41+k61) MOD 59 = k61 /\
    (2*(k41+1)+1)*60+(k61+1) < 80*60 /\
    ((2*(k41+1)+1)*60+(k61+1)) DIV 60 = 2*(k41+1)+1 /\
    ((2*(k41+1)+1)*60+(k61+1)) MOD 60 = k61+1 /\
    2*(k41+1)+1 < 80` by intLib.ARITH_TAC >>
  ASM_SIMP_TAC bool_ss [txp_selected_expand,txp_full_expand,txp_flatten_at,
        txp_line60,txp_omit_at]
QED

(* Input length is not needed: only the bounded generated-array accesses
   above are simplified. Original input access stays the same on both sides. *)
Theorem tx_tensor_selected_project_all:
  !cache xs.
    tx_tensor_selected cache xs = tx_project (tx_tensor_full cache xs)
Proof
  rpt gen_tac >> match_mp_tac LIST_EQ >> conj_tac
  >- simp [tx_tensor_selected_length,tx_project_length] >>
  qx_gen_tac `x` >> strip_tac >>
  `x < 2301` by fs [tx_tensor_selected_length] >>
  `x DIV 59 < 39 /\ x MOD 59 < 59 /\
    59*(x DIV 59)+x MOD 59 = x` by intLib.ARITH_TAC >>
  `EL x (tx_tensor_selected cache xs) =
    tx_pair x (tx_tensor_selected cache xs)` by
      simp [txp_pair_el,tx_tensor_selected_length] >>
  mp_tac (Q.SPECL [`cache`,`xs`,`x DIV 59`,`x MOD 59`] txp_stage60) >>
  ASM_SIMP_TAC arith_ss [tx_project_def,EL_GENLIST,tx_tensor_selected_length,ADD_COMM]
QED

Theorem tx_tensor_selected_project:
  !cache xs. LENGTH xs = 4800 ==>
    tx_tensor_selected cache xs = tx_project (tx_tensor_full cache xs)
Proof
  simp [tx_tensor_selected_project_all]
QED

val _ = print "C10004_TENSOR_PROJECTION_PROOF_DONE\n";
