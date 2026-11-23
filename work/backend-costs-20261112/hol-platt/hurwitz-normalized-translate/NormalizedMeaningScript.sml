Theory NormalizedMeaning
Ancestors real arithmetic
Libs realLib RealField
val _=realLib.prefer_real();
Theorem normalized_term:
 !r d c k n q. 0<r ==>
 c*(2/r) pow k*(d/r) pow n =
 (c*2 pow k*d pow n*r pow q)/(r pow (q+(k+n)))
Proof
 rpt gen_tac >> strip_tac >> rewrite_tac[REAL_POW_DIV,POW_ADD] >>
 `r pow k<>0 /\ r pow n<>0 /\ r pow q<>0` by metis_tac[POW_NZ,REAL_LT_IMP_NE] >>
 RealField.REAL_ASM_FIELD_TAC
QED
Theorem derivative_term:
 !r d c k m D. 0<r /\ k<=m /\ m<=D ==>
 c*(2/r) pow k*(d/r) pow (m-k) =
 (c*2 pow k*d pow (m-k)*r pow (D-m))/(r pow D)
Proof
 rpt gen_tac >> strip_tac >>
 `D-m+(k+(m-k))=D` by decide_tac >>
 mp_tac(SPECL [``r:real``,``d:real``,``c:real``,``k:num``,``(m:num)-k``,``(D:num)-m``] normalized_term) >>
 asm_rewrite_tac[]
QED
Theorem radius_closed:
 !d r:real. 0<r /\ -r<=d /\ d<=r ==> abs(d/r)<=1
Proof
 rpt gen_tac >> strip_tac >> asm_simp_tac (srw_ss()) [ABS_BOUNDS,REAL_LE_LDIV_EQ,REAL_LE_RDIV_EQ]
QED
Theorem coordinate_rounding_error:
 !z v h e:real. abs(z-v)<=e /\ abs(v-h)<=1/2 ==> abs(z-h)<=e+1/2
Proof
 rpt gen_tac >> rw[abs] >> RealField.REAL_ASM_FIELD_TAC
QED
