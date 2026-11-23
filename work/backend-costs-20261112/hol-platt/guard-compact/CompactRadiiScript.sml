Theory CompactRadii
Ancestors CompactSign FallbackScore real intreal integer list
Libs realLib RealField
val _ = realLib.prefer_real();
Definition admitted_r_def:
 (admitted_r scale [] = T) /\
 (admitted_r scale ((k:int,v:int,f:real,a:real,r:real)::xs) <=>
    0<=r /\ abs(a-real_of_int v)<=r /\ abs(scale*f-real_of_int k)<=1/2 /\ admitted_r scale xs)
End
Definition nodes_def:
 (nodes [] = []) /\
 (nodes ((k:int,v:int,f:real,a:real,r:real)::xs) = (k,v,f,a)::nodes xs)
End
Definition weighted_def:
 (weighted [] = 0:real) /\
 (weighted ((k:int,v:int,f:real,a:real,r:real)::xs) = abs(real_of_int k)*r + weighted xs)
End
Definition values_def:
 (values [] = 0:real) /\
 (values ((k:int,v:int,f:real,a:real,r:real)::xs) = abs(real_of_int v)+r+values xs)
End
Theorem rounding_r_one:
 !scale f a kc vc r:real. abs(a-vc)<=r /\ abs(scale*f-kc)<=1/2 ==>
   abs(scale*f*a-kc*vc) <= abs kc*r + (abs vc+r)/2
Proof
 rpt gen_tac >> strip_tac >>
 mp_tac (Q.SPECL [`kc:real`,`vc:real`,`scale*f:real`,`a:real`,`1/2:real`,`r:real`] product_radius) >>
 simp[] >> REAL_ASM_ARITH_TAC
QED
Theorem rounding_r_sum:
 !xs scale. admitted_r scale xs ==>
   abs(scale*ideal (nodes xs)-real_of_int (idot (nodes xs))) <= weighted xs + values xs/2
Proof
 Induct >- simp[ideal_def,idot_def,nodes_def,weighted_def,values_def] >>
 rpt gen_tac >> PairCases_on `h` >>
 simp[admitted_r_def,nodes_def,ideal_def,idot_def,weighted_def,values_def] >>
 strip_tac >> first_x_assum drule >>
 mp_tac (Q.SPECL [`scale:real`,`h2:real`,`h3:real`,`real_of_int h0`,`real_of_int h1`,`h4:real`] rounding_r_one) >>
 impl_tac >- simp[] >>
 `scale*(h2*h3+ideal(nodes xs))-(real_of_int h0*real_of_int h1 + real_of_int(idot(nodes xs))) =
   (scale*h2*h3-real_of_int h0*real_of_int h1)+(scale*ideal(nodes xs)-real_of_int(idot(nodes xs)))`
 by REAL_ARITH_TAC >> pop_assum SUBST1_TAC >>
 mp_tac (Q.SPECL [`scale*h2*h3-real_of_int h0*real_of_int h1`,
                  `scale*ideal(nodes xs)-real_of_int(idot(nodes xs))`] ABS_TRIANGLE) >>
 REAL_ASM_ARITH_TAC
QED
Theorem target_error:
 !xs scale radius y. 0<scale /\ admitted_r scale xs /\ abs(y-ideal(nodes xs))<=radius ==>
   abs(scale*y-real_of_int(idot(nodes xs))) <= scale*radius+weighted xs+values xs/2
Proof
 rpt gen_tac >> strip_tac >> drule rounding_r_sum >> strip_tac >>
 `0<=scale` by REAL_ASM_ARITH_TAC >> `abs scale=scale` by simp[abs] >>
 `scale*abs(y-ideal(nodes xs))<=scale*radius` by metis_tac[REAL_LE_LMUL_IMP] >>
 `scale*y-real_of_int(idot(nodes xs))=scale*(y-ideal(nodes xs))+(scale*ideal(nodes xs)-real_of_int(idot(nodes xs)))`
 by REAL_ARITH_TAC >> pop_assum SUBST1_TAC >>
 mp_tac (Q.SPECL [`scale*(y-ideal(nodes xs))`,`scale*ideal(nodes xs)-real_of_int(idot(nodes xs))`] ABS_TRIANGLE) >>
 asm_simp_tac bool_ss [ABS_MUL] >> REAL_ASM_ARITH_TAC
QED
Definition rmargin_def:
 rmargin scale radius xs = INT_CEILING(scale*radius+weighted xs+values xs/2)
End
Theorem stencil_r_sign:
 !xs scale radius y. 0<scale /\ admitted_r scale xs /\ abs(y-ideal(nodes xs))<=radius ==>
 (rmargin scale radius xs < idot(nodes xs) ==> 0<y) /\
 (idot(nodes xs) < -rmargin scale radius xs ==> y<0)
Proof
 rpt gen_tac >> strip_tac >>
 `abs(scale*y-real_of_int(idot(nodes xs))) <= scale*radius+weighted xs+values xs/2`
 by metis_tac[target_error] >>
 `scale*radius+weighted xs+values xs/2 <= real_of_int(rmargin scale radius xs)`
 by simp[rmargin_def,INT_CEILING_BOUNDS'] >>
 fs[ABS_BOUNDS] >> conj_tac >> strip_tac >| [
 `real_of_int(rmargin scale radius xs)<real_of_int(idot(nodes xs))`
 by (rewrite_tac[real_of_int_lt] >> asm_rewrite_tac[]) >>
 `0<scale*y` by REAL_ASM_ARITH_TAC >> metis_tac[REAL_LT_LMUL,REAL_MUL_RZERO],
 `real_of_int(idot(nodes xs))<real_of_int(-rmargin scale radius xs)`
 by (rewrite_tac[real_of_int_lt] >> asm_rewrite_tac[]) >>
 pop_assum (mp_tac o REWRITE_RULE[real_of_int_neg]) >> strip_tac >>
 `scale*y<0` by REAL_ASM_ARITH_TAC >> metis_tac[REAL_LT_LMUL,REAL_MUL_RZERO]]
QED
