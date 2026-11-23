(* Accuracy of the actual ROOT-based rational inverse-root producer.
   No externally supplied square-root witness is assumed. *)
Theory SourceInverseRoot
Ancestors SourceArithmetic logroot real arithmetic
Libs realLib RealField

val _ = realLib.prefer_real ();

Theorem source_inverse_root_adjacent_squares:
  !A D S:num. 0 < A ==>
    (source_inverse_root A D S) ** 2 * A <= D*S*S /\
    D*S*S < (SUC (source_inverse_root A D S)) ** 2 * A
Proof
  map_every qx_gen_tac [`A`,`D`,`grid`] >> strip_tac >> REWRITE_TAC [source_inverse_root_def] >>
  `0 < (2:num)` by decide_tac >>
  `(ROOT 2 ((D*grid*grid) DIV A)) ** 2 <= (D*grid*grid) DIV A /\
    (D*grid*grid) DIV A < (SUC (ROOT 2 ((D*grid*grid) DIV A))) ** 2`
    by metis_tac [ROOT] >>
  metis_tac [X_LE_DIV,DIV_LT_X]
QED

Theorem source_sqrt_bracket:
  !r:num. !t:real.
    0 <= t /\ (&r) pow 2 <= t /\ t < (&r+1) pow 2 ==>
    &r <= sqrt t /\ sqrt t < &r+1
Proof
  rpt gen_tac >> strip_tac >>
  `0 <= (&r:real) /\ 0 <= (&r:real)+1` by simp [] >>
  conj_tac
  >- (mp_tac (Q.SPECL [`(&r:real) pow 2`,`t:real`] SQRT_MONO_LE) >>
      ASM_SIMP_TAC bool_ss [REAL_LE_POW2,POW_2_SQRT]) >>
  mp_tac (Q.SPECL [`t:real`,`((&r:real)+1) pow 2`] SQRT_MONO_LT) >>
  ASM_SIMP_TAC bool_ss [POW_2_SQRT]
QED

Theorem source_inverse_root_scaled_enclosure:
  !A D S:num. 0 < A ==>
    &(source_inverse_root A D S) <= &S * sqrt ((&D:real)/&A) /\
    &S * sqrt ((&D:real)/&A) < &(source_inverse_root A D S)+1
Proof
  map_every qx_gen_tac [`A`,`D`,`grid`] >> strip_tac >>
  `0 < (&A:real)` by simp [] >>
  `0 <= (&D:real)/&A` by simp [REAL_LE_DIV] >>
  `(&(source_inverse_root A D grid):real) pow 2 * &A <= &D*&grid*&grid /\
    &D*&grid*&grid < (&(SUC (source_inverse_root A D grid)):real) pow 2 * &A` by
    (REWRITE_TAC [REAL_POW,REAL_MUL,REAL_OF_NUM_LE,REAL_OF_NUM_LT] >>
     metis_tac [source_inverse_root_adjacent_squares]) >>
  `(&(source_inverse_root A D grid):real) pow 2 <= (&D*&grid*&grid)/&A /\
    (&D*&grid*&grid)/&A < (&(source_inverse_root A D grid)+1) pow 2` by
    (ASM_SIMP_TAC bool_ss [REAL_LE_RDIV_EQ,REAL_LT_LDIV_EQ,REAL_OF_NUM_SUC]) >>
  `(&D*&grid*&grid)/(&A:real) = (&grid:real) pow 2 * ((&D:real)/&A)`
    by RealField.REAL_ASM_FIELD_TAC >>
  `0 <= (&D*&grid*&grid)/(&A:real)` by simp [REAL_LE_DIV,REAL_LE_MUL] >>
  `&(source_inverse_root A D grid) <= sqrt ((&D*&grid*&grid)/(&A:real)) /\
    sqrt ((&D*&grid*&grid)/(&A:real)) < &(source_inverse_root A D grid)+1`
    by metis_tac [source_sqrt_bracket] >>
  `sqrt ((&D*&grid*&grid)/(&A:real)) = &grid * sqrt ((&D:real)/&A)` by
    (ASM_SIMP_TAC bool_ss [SQRT_MUL,REAL_LE_POW2,POW_2_SQRT,REAL_POS]) >>
  metis_tac []
QED

Theorem source_inverse_root_real_error:
  !A D S:num. 0 < A /\ 0 < S ==>
    abs (&(source_inverse_root A D S)/&S - sqrt ((&D:real)/&A)) < 1 / &S
Proof
  map_every qx_gen_tac [`A`,`D`,`grid`] >> strip_tac >>
  `0 < (&grid:real)` by simp [] >>
  `&(source_inverse_root A D grid) <= &grid * sqrt ((&D:real)/&A) /\
    &grid * sqrt ((&D:real)/&A) < &(source_inverse_root A D grid)+1`
    by metis_tac [source_inverse_root_scaled_enclosure] >>
  `&(source_inverse_root A D grid)/&grid <= sqrt ((&D:real)/&A) /\
    sqrt ((&D:real)/&A) < (&(source_inverse_root A D grid)+1)/&grid` by
    (ASM_SIMP_TAC bool_ss [REAL_LE_LDIV_EQ,REAL_LT_RDIV_EQ,REAL_MUL_COMM]) >>
  `(&(source_inverse_root A D grid)+1)/(&grid:real) =
     &(source_inverse_root A D grid)/&grid + 1/&grid` by RealField.REAL_ASM_FIELD_TAC >>
  `0 < 1 / (&grid:real)` by simp [REAL_LT_DIV] >>
  REWRITE_TAC [ABS_BOUNDS_LT] >> RealField.REAL_ASM_ARITH_TAC
QED

val _ = print "SOURCE_INVERSE_ROOT_PROOFS_DONE\n";
