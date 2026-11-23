e(rpt gen_tac >> strip_tac >> drule rounding_sum >> strip_tac >>
 `0<=scale` by REAL_ASM_ARITH_TAC >>
 `abs scale=scale` by simp[abs] >>
 `scale*abs(y-ideal xs)<=scale*radius` by metis_tac[REAL_LE_LMUL_IMP] >>
 `scale*y-real_of_int(idot xs)=scale*(y-ideal xs)+(scale*ideal xs-real_of_int(idot xs))`
 by REAL_ARITH_TAC >>
 `abs(scale*y-real_of_int(idot xs)) <= real_of_int(margin scale radius xs)` by
  (pop_assum SUBST1_TAC >>
   mp_tac (Q.SPECL [`scale*(y-ideal xs)`,`scale*ideal xs-real_of_int(idot xs)`] ABS_TRIANGLE) >>
   mp_tac (Q.SPEC `scale*radius` INT_CEILING_BOUNDS') >>
   mp_tac (Q.SPEC `real_of_int(vnorm xs)/2` INT_CEILING_BOUNDS') >>
   asm_simp_tac bool_ss [margin_def,real_of_int_add,ABS_MUL] >> REAL_ASM_ARITH_TAC) >>
 fs[ABS_BOUNDS] >> conj_tac >> strip_tac >| [
    `real_of_int(margin scale radius xs)<real_of_int(idot xs)` by
      (rewrite_tac[real_of_int_lt] >> asm_rewrite_tac[]) >>
    `0<scale*y` by REAL_ASM_ARITH_TAC >> metis_tac[REAL_LT_LMUL,REAL_MUL_RZERO],
    `real_of_int(idot xs)<real_of_int(-margin scale radius xs)` by
      (rewrite_tac[real_of_int_lt] >> asm_rewrite_tac[]) >>
    pop_assum (mp_tac o REWRITE_RULE[real_of_int_neg]) >> strip_tac >>
    `scale*y<0` by REAL_ASM_ARITH_TAC >> metis_tac[REAL_LT_LMUL,REAL_MUL_RZERO]]);
