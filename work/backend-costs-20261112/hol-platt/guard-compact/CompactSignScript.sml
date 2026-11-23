Theory CompactSign
Ancestors FallbackScore real intreal integer list
Libs realLib RealField intLib
val _ = realLib.prefer_real();

Definition admitted_def:
 (admitted scale [] = T) /\
 (admitted scale ((k:int,v:int,f:real,a:real)::rest) <=>
    abs(a-real_of_int v)<=1 /\ abs(scale*f-real_of_int k)<=1/2 /\ admitted scale rest)
End
Definition ideal_def:
 (ideal [] = 0:real) /\
 (ideal ((k:int,v:int,f:real,a:real)::rest) = f*a+ideal rest)
End
Definition idot_def:
 (idot [] = 0:int) /\
 (idot ((k:int,v:int,f:real,a:real)::rest) = k*v+idot rest)
End
Definition knorm_def:
 (knorm [] = 0:int) /\
 (knorm ((k:int,v:int,f:real,a:real)::rest) = ABS k+knorm rest)
End
Definition vnorm_def:
 (vnorm [] = 0:int) /\
 (vnorm ((k:int,v:int,f:real,a:real)::rest) = ABS v+1+vnorm rest)
End

Theorem cast_abs:
 !k:int. real_of_int (ABS k) = abs(real_of_int k)
Proof
 Cases >> simp[INT_ABS,abs,real_of_int_num,real_of_int_neg]
QED

Theorem rounding_one:
 !scale f a kc vc:real. abs(a-vc)<=1 /\ abs(scale*f-kc)<=1/2 ==>
   abs(scale*f*a-kc*vc) <= abs kc + (abs vc+1)/2
Proof
 rpt gen_tac >> strip_tac >>
 mp_tac (Q.SPECL [`kc:real`,`vc:real`,`scale*f:real`,`a:real`,`1/2:real`,`1:real`] product_radius) >>
 simp[] >> REAL_ASM_ARITH_TAC
QED

Theorem rounding_sum:
 !xs scale. admitted scale xs ==>
   abs(scale*ideal xs-real_of_int (idot xs)) <=
   real_of_int (knorm xs) + real_of_int (vnorm xs)/2
Proof
 Induct >- simp[ideal_def,idot_def,vnorm_def,knorm_def] >>
 rpt gen_tac >> PairCases_on `h` >>
 simp[admitted_def,ideal_def,idot_def,vnorm_def,knorm_def,cast_abs] >>
 strip_tac >> first_x_assum drule >>
 mp_tac (Q.SPECL [`scale:real`,`h2:real`,`h3:real`,`real_of_int h0`,`real_of_int h1`] rounding_one) >>
 impl_tac >- simp[] >>
 `scale*(h2*h3+ideal xs)-(real_of_int h0*real_of_int h1 + real_of_int(idot xs)) =
   (scale*h2*h3-real_of_int h0*real_of_int h1)+(scale*ideal xs-real_of_int(idot xs))`
 by RealField.REAL_ARITH_TAC >>
 pop_assum SUBST1_TAC >>
 mp_tac (Q.SPECL [`scale*h2*h3-real_of_int h0*real_of_int h1`,
                  `scale*ideal xs-real_of_int(idot xs)`] ABS_TRIANGLE) >>
 REAL_ASM_ARITH_TAC
QED

Definition margin_def:
 margin scale radius xs = INT_CEILING(scale*radius) + knorm xs + INT_CEILING(real_of_int(vnorm xs)/2)
End
Theorem stencil_sign:
 !xs scale radius y. 0<scale /\ admitted scale xs /\ abs(y-ideal xs)<=radius ==>
   (margin scale radius xs < idot xs ==> 0<y) /\
   (idot xs < -margin scale radius xs ==> y<0)
Proof
 rpt gen_tac >> strip_tac >> drule rounding_sum >> strip_tac >>
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
    `scale*y<0` by REAL_ASM_ARITH_TAC >> metis_tac[REAL_LT_LMUL,REAL_MUL_RZERO]]
QED