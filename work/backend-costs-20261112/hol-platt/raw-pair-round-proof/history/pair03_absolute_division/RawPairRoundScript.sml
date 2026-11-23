(* Internal arithmetic-to-complex bridge.  Prepared source, not yet built.
   No logarithm, exponential, raw-state source enclosure or L-function theorem
   is asserted here.  Integer multiplication is exact; only the two final
   coordinates are rounded using the existing BlockRound operation. *)
Theory RawPairRound
Ancestors BlockRound intreal complex real
Libs realLib RealField

val _ = realLib.prefer_real ();

Definition pair_value_def:
  pair_value (g:int) (a:int,b:int) : complex =
    (real_of_int a / real_of_int g,
     real_of_int b / real_of_int g)
End

Definition four_product_round_def:
  four_product_round (s:int) (ur:int,ui:int) (wr:int,wi:int) =
    (round_scaled s (ur*wr-ui*wi),
     round_scaled s (ur*wi+ui*wr))
End

(* The integer residual theorem supplies the only rounding premise. *)
Theorem round_scaled_real_residual:
  !s r:int. 0 < s ==>
    abs (real_of_int r - real_of_int (round_scaled s r) * real_of_int s)
      <= real_of_int s / 2
Proof
  rpt gen_tac >> strip_tac >>
  mp_tac (Q.SPECL [`s`,`r`] round_scaled_residual) >>
  asm_rewrite_tac [] >> strip_tac >>
  `real_of_int (-s) <= real_of_int (2*(r-round_scaled s r*s)) /\
   real_of_int (2*(r-round_scaled s r*s)) < real_of_int s`
    by metis_tac [real_of_int_le,real_of_int_lt] >>
  full_simp_tac bool_ss [real_of_int_neg,real_of_int_sub,real_of_int_mul,real_of_int_num] >>
  rewrite_tac [ABS_BOUNDS] >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem round_scaled_real_error:
  !s r:int. 0 < s ==>
    abs (real_of_int (round_scaled s r) - real_of_int r / real_of_int s)
      <= 1 / 2
Proof
  rpt gen_tac >> strip_tac >>
  `0 < real_of_int s` by metis_tac [real_of_int_lt,real_of_int_num] >>
  `abs (real_of_int r - real_of_int (round_scaled s r) * real_of_int s)
      <= real_of_int s / 2` by metis_tac [round_scaled_real_residual] >>
  `real_of_int (round_scaled s r) - real_of_int r / real_of_int s =
   -(real_of_int r - real_of_int (round_scaled s r) * real_of_int s) /
     real_of_int s` by RealField.REAL_ASM_FIELD_TAC >>
  asm_simp_tac real_ss [ABS_DIV,ABS_NEG,ABS_REFL,REAL_LT_IMP_LE,
                       REAL_LE_LDIV_EQ] >>
  RealField.REAL_ASM_ARITH_TAC
QED

(* g is the output grid; s is the exact product divisor.  They need not agree. *)
Theorem round_scaled_coordinate_error:
  !g s r:int. 0 < g /\ 0 < s ==>
    abs (real_of_int (round_scaled s r) / real_of_int g -
         real_of_int r / (real_of_int s * real_of_int g))
      <= 1 / (2 * real_of_int g)
Proof
  rpt gen_tac >> strip_tac >>
  `0 < real_of_int g /\ 0 < real_of_int s`
    by metis_tac [real_of_int_lt,real_of_int_num] >>
  `abs (real_of_int (round_scaled s r) - real_of_int r / real_of_int s)
       <= 1 / 2` by metis_tac [round_scaled_real_error] >>
  `real_of_int (round_scaled s r) / real_of_int g -
      real_of_int r / (real_of_int s * real_of_int g) =
    (real_of_int (round_scaled s r) - real_of_int r / real_of_int s) /
      real_of_int g` by RealField.REAL_ASM_FIELD_TAC >>
  `1 / (2 * real_of_int g) = (1 / 2) / real_of_int g`
    by RealField.REAL_ASM_FIELD_TAC >>
  asm_simp_tac real_ss [ABS_DIV,ABS_REFL,REAL_LT_IMP_LE,
                       REAL_LE_LDIV_EQ] >>
  RealField.REAL_ASM_FIELD_TAC
QED

(* This is an upper bound for the actual Euclidean modulus of HOL complex,
   not a replacement definition of that modulus. *)
Theorem modu_le_coordinate_sum:
  !z:complex. modu z <= abs (RE z) + abs (IM z)
Proof
  gen_tac >>
  `0 <= abs (RE z) * abs (IM z)` by simp [REAL_LE_MUL] >>
  `0 <= RE z pow 2 + IM z pow 2` by simp [REAL_LE_ADD,REAL_LE_POW2] >>
  `RE z pow 2 + IM z pow 2 <= (abs (RE z) + abs (IM z)) pow 2`
    by (mp_tac (Q.SPEC `RE z` REAL_POW2_ABS) >>
        mp_tac (Q.SPEC `IM z` REAL_POW2_ABS) >>
        rewrite_tac [POW_2] >> RealField.REAL_ASM_ARITH_TAC) >>
  `sqrt (RE z pow 2 + IM z pow 2) <=
     sqrt ((abs (RE z) + abs (IM z)) pow 2)`
    by metis_tac [SQRT_MONO_LE] >>
  `0 <= abs (RE z) + abs (IM z)` by simp [REAL_LE_ADD] >>
  fs [modu,POW_2_SQRT]
QED

Theorem pair_value_exact_product:
  !g s ur ui wr wi:int. 0 < g /\ 0 < s ==>
    pair_value g (ur,ui) * pair_value s (wr,wi) =
    pair_value (s*g) (ur*wr-ui*wi,ur*wi+ui*wr)
Proof
  rpt gen_tac >> strip_tac >>
  `0 < real_of_int g /\ 0 < real_of_int s`
    by metis_tac [real_of_int_lt,real_of_int_num] >>
  simp_tac bool_ss [COMPLEX_RE_IM_EQ,pair_value_def,complex_mul,RE,IM,
             FST,SND,real_of_int_mul,real_of_int_sub,real_of_int_add] >>
  conj_tac >> RealField.REAL_ASM_FIELD_TAC
QED

Theorem four_product_coordinate_errors:
  !g s ur ui wr wi:int. 0 < g /\ 0 < s ==>
    abs (RE (pair_value g (four_product_round s (ur,ui) (wr,wi)) -
             pair_value g (ur,ui) * pair_value s (wr,wi)))
      <= 1 / (2 * real_of_int g) /\
    abs (IM (pair_value g (four_product_round s (ur,ui) (wr,wi)) -
             pair_value g (ur,ui) * pair_value s (wr,wi)))
      <= 1 / (2 * real_of_int g)
Proof
  rpt gen_tac >> strip_tac >>
  `pair_value g (ur,ui) * pair_value s (wr,wi) =
   pair_value (s*g) (ur*wr-ui*wi,ur*wi+ui*wr)`
    by metis_tac [pair_value_exact_product] >>
  asm_simp_tac bool_ss [four_product_round_def,pair_value_def,
                        complex_sub,complex_add,complex_neg,RE,IM,
                        FST,SND,real_of_int_mul] >>
  metis_tac [round_scaled_coordinate_error,real_sub]
QED

Theorem four_product_round_error:
  !g s ur ui wr wi:int. 0 < g /\ 0 < s ==>
    modu (pair_value g (four_product_round s (ur,ui) (wr,wi)) -
          pair_value g (ur,ui) * pair_value s (wr,wi))
      <= 1 / real_of_int g
Proof
  rpt gen_tac >> strip_tac >>
  `0 < real_of_int g` by metis_tac [real_of_int_lt,real_of_int_num] >>
  mp_tac (Q.SPECL [`g`,`s`,`ur`,`ui`,`wr`,`wi`]
    four_product_coordinate_errors) >>
  asm_rewrite_tac [] >> strip_tac >>
  mp_tac (Q.SPEC
    `pair_value g (four_product_round s (ur,ui) (wr,wi)) -
     pair_value g (ur,ui) * pair_value s (wr,wi)` modu_le_coordinate_sum) >>
  `1 / (2 * real_of_int g) + 1 / (2 * real_of_int g) =
   1 / real_of_int g` by RealField.REAL_ASM_FIELD_TAC >>
  RealField.REAL_ASM_ARITH_TAC
QED

(* The same integer program is the existing handoff's raw_mul at s=2^122.
   This file deliberately does not depend on a successful handoff build. *)
val _ = print "RAW_PAIR_ROUND_ANALYTIC_BRIDGE_DONE\n";
