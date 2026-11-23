(* Connect the actual guarded initializer and its exact integer shift to
   a complex amplitude. No source-value equality is an input premise. *)
Theory SourceInitial
Ancestors SourceArithmetic SourceStateError SourceInverseRoot RawPairRound
          complex real intreal integer arithmetic option
Libs realLib RealField

val _ = realLib.prefer_real ();

Theorem si_grid_factor:
  !a b:num. a <= b ==> 2 ** b = 2 ** a * 2 ** (b-a)
Proof
  rpt gen_tac >> strip_tac >>
  `a + (b-a) = b` by decide_tac >> metis_tac [EXP_ADD]
QED

Theorem si_shift_value:
  !r a b:num. a <= b ==>
    source_pair_value (2 ** b) ((&r:int) * &(2 ** (b-a)),0) =
      complex_of_real (&r / (2:real) pow a)
Proof
  rpt gen_tac >> strip_tac >>
  `(&(2 ** b):real) = &(2 ** a) * &(2 ** (b-a))`
    by (REWRITE_TAC [REAL_MUL,REAL_OF_NUM_EQ] >> metis_tac [si_grid_factor]) >>
  `(&(2 ** a):real) <> 0 /\ (&(2 ** (b-a)):real) <> 0` by simp [] >>
  REWRITE_TAC [source_pair_value_def,pair_value_def,real_of_int_mul,
    real_of_int_num,complex_of_real,REAL_DIV_LZERO,pairTheory.PAIR_EQ,REAL_POW] >>
  ASM_REWRITE_TAC [] >> RealField.REAL_ASM_FIELD_TAC
QED

Theorem source_initial_success:
  !A D a b initial. source_initial A D a b = SOME initial ==>
    0 < D /\ D <= A /\ a <= b /\
    initial = ((&(source_inverse_root A D (2 ** a)):int) * &(2 ** (b-a)),0)
Proof
  rpt gen_tac >> REWRITE_TAC [source_initial_def] >>
  BasicProvers.every_case_tac >> simp [] >> metis_tac []
QED

Theorem source_initial_value:
  !A D a b initial. source_initial A D a b = SOME initial ==>
    source_pair_value (2 ** b) initial =
      complex_of_real (&(source_inverse_root A D (2 ** a)) / (2:real) pow a)
Proof
  rpt gen_tac >> strip_tac >>
  imp_res_tac source_initial_success >>
  ASM_SIMP_TAC bool_ss [si_shift_value]
QED

Theorem source_amplitude_norm:
  !A D:num. 0 < D /\ D <= A ==>
    modu (complex_of_real (sqrt ((&D:real) / &A))) <= 1
Proof
  rpt gen_tac >> strip_tac >>
  `0 < A` by decide_tac >> `0 < (&A:real)` by simp [] >>
  `0 <= (&D:real) / &A` by simp [REAL_LE_DIV] >>
  `(&D:real) / &A <= 1` by
    (ASM_SIMP_TAC bool_ss [REAL_LE_LDIV_EQ,REAL_MUL_LID,REAL_OF_NUM_LE]) >>
  `0 <= sqrt ((&D:real) / &A)` by metis_tac [SQRT_POS_LE] >>
  `abs (sqrt ((&D:real) / &A)) = sqrt ((&D:real) / &A)` by metis_tac [ABS_REFL] >>
  mp_tac (Q.SPECL [`(&D:real) / &A`,`1:real`] SQRT_MONO_LE) >>
  ASM_SIMP_TAC bool_ss [SQRT_1,MODU_REAL]
QED

Theorem source_initial_accuracy:
  !A D a b initial. source_initial A D a b = SOME initial ==>
    modu (source_pair_value (2 ** b) initial -
      complex_of_real (sqrt ((&D:real) / &A))) < 1 / (2:real) pow a /\
    modu (complex_of_real (sqrt ((&D:real) / &A))) <= 1
Proof
  rpt gen_tac >> strip_tac >>
  imp_res_tac source_initial_success >>
  `0 < A` by decide_tac >> `0 < (2 ** a:num)` by simp [] >>
  `abs (&(source_inverse_root A D (2 ** a)) / (&(2 ** a):real) -
      sqrt ((&D:real) / &A)) < 1 / (&(2 ** a):real)`
    by metis_tac [source_inverse_root_real_error] >>
  `source_pair_value (2 ** b) initial =
      complex_of_real (&(source_inverse_root A D (2 ** a)) / (2:real) pow a)`
    by metis_tac [source_initial_value] >>
  conj_tac
  >- ASM_SIMP_TAC bool_ss [COMPLEX_OF_REAL_SUB,MODU_REAL,REAL_POW] >>
  metis_tac [source_amplitude_norm]
QED

Theorem source_amplitude_inverse_sqrt:
  !A D:num. 0 < A /\ 0 < D ==>
    complex_of_real (sqrt ((&D:real) / &A)) =
      complex_of_real (1 / sqrt ((&A:real) / &D))
Proof
  rpt gen_tac >> strip_tac >>
  `0 < (&A:real) /\ 0 < (&D:real)` by simp [] >>
  `0 <= (&A:real) / &D` by simp [REAL_LE_DIV] >>
  `inv ((&A:real) / &D) = (&D:real) / &A` by RealField.REAL_ASM_FIELD_TAC >>
  `sqrt ((&D:real) / &A) = inv (sqrt ((&A:real) / &D))` by metis_tac [SQRT_INV] >>
  ASM_REWRITE_TAC [real_div,REAL_MUL_LID]
QED

val _ = print "SOURCE_INITIAL_PROOFS_DONE\n";
