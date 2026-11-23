Theory RateJoin
Ancestors RateMeaning ModeMoments FourierStencil MomentTransfer MomentRates WeightedSample intreal real integer arithmetic list
Libs realLib intLib RealField
Definition rate_weight_def:
 rate_weight k = &((44*68267)**k) / factorial_scale k
End
Definition signed_term_def:
 signed_term zs m = abs(row (cast_row zs) (\x. x pow m))
End
Definition end_term_def:
 end_term zs m = rate_weight m * absolute_row (cast_row zs) (\x. abs(x pow m))
End

fun watch s (g as (_,t)) = (print (s^" "^term_to_string t^"\n"); ALL_TAC g);
Theorem one_signed:
 !k zs. real_of_int (&((44*68267)**k) * ABS(mass F (weighted_powers zs k))) / factorial_scale k =
 rate_weight k * signed_term zs k
Proof
 rpt gen_tac >> PURE_REWRITE_TAC [rate_weight_def,signed_term_def,real_of_int_mul,real_of_int_num,
   GSYM cast_abs,row_monomial,real_div] >> realLib.REAL_ARITH_TAC
QED

Theorem one_absolute:
 !k zs. real_of_int (&((44*68267)**k) * mass T (weighted_powers zs k)) / factorial_scale k =
 end_term zs k
Proof
 rpt gen_tac >> PURE_REWRITE_TAC [rate_weight_def,end_term_def,real_of_int_mul,real_of_int_num,
   terminal_monomial,real_div] >> watch "absolute" >> CONV_TAC (AC_CONV (REAL_MUL_ASSOC,REAL_MUL_COMM))
QED

Theorem suffix_value:
 !n k zs. moment_tail n k (&((44*68267)**k)) (weighted_powers zs k) =
 series (k+n) rate_weight (signed_term zs) - series k rate_weight (signed_term zs) +
 end_term zs (k+n)
Proof
 Induct >- (PURE_REWRITE_TAC [moment_tail_def,one_absolute,ADD_CLAUSES,REAL_SUB_REFL,REAL_ADD_LID] >> watch "zero" >> simp []) >>
 map_every qx_gen_tac [`k`,`zs`] >>
 `k+SUC n = SUC k+n` by DECIDE_TAC >>
 `(&((44*68267)**k):int) * &(44*68267) = &((44*68267)**SUC k)` by simp [EXP] >>
 ASM_REWRITE_TAC [moment_tail_def,step_power,one_signed,series_def] >>
 realLib.REAL_ARITH_TAC
QED

Theorem exact_normalization:
 !k zs. real_of_int(numer k 0 0 1 zs) / factorial_scale k =
    series k rate_weight (signed_term zs) + end_term zs k
Proof
 rpt gen_tac >>
 mp_tac (Q.SPECL [`k`,`0`,`0:int`,`1:int`,`zs`] numerator_value) >>
 mp_tac (Q.SPECL [`k`,`0`,`zs`] suffix_value) >>
 simp [initial_term_def,series_def,initial_powers]
QED

