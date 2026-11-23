Theory RateConsumer
Ancestors RateJoin RateMeaning ModeMoments FourierStencil FourierJet MomentTransfer MomentRates RadiusBudget WeightedSample intreal real integer arithmetic list
Libs realLib intLib RealField
Definition subfrequency_def:
 subfrequency = (&(44*68267):real) / &(4096*7*524288)
End
Theorem budget_factor:
 !n cap m. budget n cap subfrequency m = (&n*cap)*rate_weight m
Proof
 rpt gen_tac >>
 PURE_REWRITE_TAC [budget_def,subfrequency_def,rate_weight_def,factorial_scale_def,
   REAL_POW_DIV,REAL_OF_NUM_POW] >>
 `!a b:real. !p q f:num. a*(b*(&p / &q)) / &f = (a*b)*(&p / &(q*f))` by
   (rpt gen_tac >> PURE_REWRITE_TAC [GSYM REAL_OF_NUM_MUL] >> RealField.REAL_FIELD_TAC) >>
 first_x_assum MATCH_ACCEPT_TAC
QED

Theorem factor_series:
 !k c u v. series k (\m. c*u m) v = c*series k u v
Proof
 Induct >> simp [series_def,REAL_LDISTRIB] >> realLib.REAL_ARITH_TAC
QED
Theorem factor_absolute:
 !zs c g. absolute_row zs (\x. c*g x) = c*absolute_row zs g
Proof
 Induct >> simp [absolute_row_def,REAL_LDISTRIB] >> realLib.REAL_ARITH_TAC
QED
Theorem analytic_numerator:
 !n w a b cap. 0<=cap /\
 (!j. j<n ==> abs(a j)+abs(b j)<=cap /\ abs(w j)<=subfrequency) ==>
 !k zs. abs(row (cast_row zs) (finitejet n 0 w a b)) <=
 (&n*cap)*(real_of_int(numer k 0 0 1 zs) / factorial_scale k)
Proof
 map_every qx_gen_tac [`n`,`w`,`a`,`b`,`cap`] >> strip_tac >>
 map_every qx_gen_tac [`k`,`zs`] >>
 `0<=subfrequency` by simp [subfrequency_def] >>
 mp_tac (Q.SPECL [`n`,`w`,`a`,`b`,`cap`,`subfrequency`] finite_fourier_stencil) >>
 ASM_REWRITE_TAC [] >>
 disch_then (mp_tac o Q.SPECL [`k`,`cast_row zs`]) >>
 `budget n cap subfrequency = (\m. (&n*cap)*rate_weight m)` by simp [FUN_EQ_THM,budget_factor] >>
 `signed_term zs = (\m. abs(row (cast_row zs) (\x. x pow m)))` by simp [FUN_EQ_THM,signed_term_def] >>
 PURE_ASM_REWRITE_TAC [exact_normalization,signed_term_def,end_term_def,factor_series] >>
 BETA_TAC >>
 `(\x:real. (&n*cap*rate_weight k)*abs(x pow k)) =
  (\x:real. (&n*cap*rate_weight k)*(\t. abs(t pow k)) x)` by simp [] >>
 mp_tac (Q.SPECL [`cast_row zs`,`&n*cap*rate_weight k`,`\x:real. abs(x pow k)`] factor_absolute) >>
 BETA_TAC >> realLib.REAL_ASM_ARITH_TAC
QED


