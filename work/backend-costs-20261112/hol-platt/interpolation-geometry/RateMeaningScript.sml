Theory RateMeaning
Ancestors MomentRates MomentTransfer WeightedSample intreal real integer arithmetic list
Libs realLib intLib RealField

Definition factorial_scale_def:
 factorial_scale k = (&((4096*7*524288)**k * FACT k):real)
End
Definition initial_term_def:
 initial_term k acc = &(k*(4096*7*524288)) * real_of_int acc / factorial_scale k
End
Definition moment_tail_def:
 (moment_tail 0 k p zs = real_of_int(p*mass T zs) / factorial_scale k) /\
 (moment_tail (SUC n) k p zs = real_of_int(p*ABS(mass F zs)) / factorial_scale k +
    moment_tail n (SUC k) (p * &(44*68267)) (step zs))
End
Theorem scale_positive:
 !k. 0 < factorial_scale k
Proof
 simp [factorial_scale_def,FACT_LESS]
QED
Theorem scale_suc:
 !k. factorial_scale (SUC k) = &(SUC k * (4096*7*524288)) * factorial_scale k
Proof
 gen_tac >> PURE_REWRITE_TAC [factorial_scale_def,EXP,FACT,REAL_OF_NUM_MUL] >>
 AP_TERM_TAC >> CONV_TAC (AC_CONV (MULT_ASSOC,MULT_COMM))
QED

Theorem prefix_step:
 !k acc z. initial_term (SUC k) (&(k*(4096*7*524288))*acc + z) =
 initial_term k acc + real_of_int z / factorial_scale k
Proof
 rpt gen_tac >>
 `factorial_scale k <> 0` by metis_tac [scale_positive,REAL_LT_IMP_NE] >>
 `(&(SUC k * (4096*7*524288)):real) <> 0` by simp [] >>
 PURE_REWRITE_TAC [initial_term_def,scale_suc,real_of_int_add,real_of_int_mul,real_of_int_num] >>
 RealField.REAL_ASM_FIELD_TAC
QED
Theorem numerator_value:
 !n k acc p zs.
 real_of_int(numer n k acc p zs) / factorial_scale(k+n) =
 initial_term k acc + moment_tail n k p zs
Proof
 Induct >- (simp [numer_def,moment_tail_def,initial_term_def,real_div,REAL_ADD_RDISTRIB] >>
             realLib.REAL_ARITH_TAC) >>
 rpt gen_tac >>
 `k+SUC n = SUC k+n` by DECIDE_TAC >>
 ASM_REWRITE_TAC [numer_def,moment_tail_def,prefix_step] >> realLib.REAL_ARITH_TAC
QED

