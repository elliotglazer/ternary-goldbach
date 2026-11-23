Theory ComplexRemainder
Ancestors PeriodicKernel PeriodicMass PhaseMass integral complex real_topology lim
Libs realLib RealField

open realTheory pairTheory;
val _ = realLib.prefer_real ();

Definition cr_dot_def:
  cr_dot (w:complex) z = RE w * RE z + IM w * IM z
End

Theorem cr_dot_bound:
  !w z:complex. cr_dot w z <= modu w * modu z
Proof
  rpt gen_tac >>
  mp_tac (Q.SPEC `(w:complex)*conj(z:complex)` RE_IM_LE_MODU) >>
  PURE_REWRITE_TAC [MODU_MUL,MODU_CONJ,cr_dot_def,complex_mul,conj,RE,IM,FST,SND] >>
  PURE_REWRITE_TAC [ABS_BOUNDS] >> RealField.REAL_ARITH_TAC
QED

Definition cr_int_def:
  cr_int a b (f:real->complex) =
    (integral(a,b) (\u. RE(f u)),integral(a,b) (\u. IM(f u))):complex
End

Theorem cr_integral_dot:
  !a b f w z. Dint(a,b) (\u. RE(f u)) (RE z) /\
    Dint(a,b) (\u. IM(f u)) (IM z) ==>
    Dint(a,b) (\u. cr_dot w (f u)) (cr_dot w z)
Proof
  rpt gen_tac >> strip_tac >> PURE_REWRITE_TAC[cr_dot_def] >>
  mp_tac (Q.SPECL [`\u:real. RE w*RE(f u)`,`\u:real. IM w*IM(f u)`,
    `a:real`,`b:real`,`RE w*RE z`,`IM w*IM z`] DINT_ADD) >>
  BETA_TAC >> disch_then match_mp_tac >> conj_tac
  >- (mp_tac (Q.SPECL [`\u:real. RE(f u)`,`a:real`,`b:real`,`RE w`,`RE z`] DINT_CMUL) >>
      asm_simp_tac bool_ss []) >>
  mp_tac (Q.SPECL [`\u:real. IM(f u)`,`a:real`,`b:real`,`IM w`,`IM z`] DINT_CMUL) >>
  asm_simp_tac bool_ss []
QED

Theorem cr_norm_integral:
  !a b f z m. a<=b /\ Dint(a,b) (\u. RE(f u)) (RE z) /\
    Dint(a,b) (\u. IM(f u)) (IM z) /\ Dint(a,b) (\u. modu(f u)) m ==>
    modu z <= m
Proof
  rpt gen_tac >> strip_tac >>
  `Dint(a,b) (\u. cr_dot z (f u)) (cr_dot z z)` by metis_tac[cr_integral_dot] >>
  `Dint(a,b) (\u. modu z * modu(f u)) (modu z * m)` by
    (mp_tac (Q.SPECL [`\u:real. modu(f u)`,`a:real`,`b:real`,`modu z`,`m:real`] DINT_CMUL) >>
     asm_simp_tac bool_ss []) >>
  `cr_dot z z <= modu z * m` by
    (mp_tac (Q.SPECL [`\u. cr_dot z (f u)`,`\u. modu z * modu(f u)`,`a:real`,
      `b:real`,`cr_dot z z`,`modu z*m`] DINT_LE) >>
     asm_simp_tac bool_ss [cr_dot_bound]) >>
  `0 <= m` by
    (mp_tac (Q.SPECL [`\u:real. 0:real`,`\u. modu(f u)`,`a:real`,`b:real`,
      `0:real`,`m:real`] DINT_LE) >>
     asm_simp_tac bool_ss [MODU_POS] >> disch_then match_mp_tac >>
     mp_tac (Q.SPECL [`a:real`,`b:real`,`0:real`] DINT_CONST) >> simp[]) >>
  `cr_dot z z = modu z * modu z` by
    (PURE_REWRITE_TAC [cr_dot_def,GSYM POW_2,MODU_POW2] >> REFL_TAC) >>
  Cases_on `modu z=0` >- asm_rewrite_tac[] >>
  `0<modu z` by metis_tac [MODU_POS,REAL_LE_LT] >>
  metis_tac [REAL_LE_LMUL]
QED

val basic_cont = REPEAT (FIRST [MATCH_ACCEPT_TAC periodic_B4_continuous,
  MATCH_ACCEPT_TAC CONTINUOUS_CONST,MATCH_ACCEPT_TAC CONTINUOUS_AT_ID,
  FIRST (map HO_MATCH_MP_TAC [CONTINUOUS_NEG,CONTINUOUS_SUB,CONTINUOUS_ABS,
    CONTINUOUS_ADD,CONTINUOUS_MUL,CONTINUOUS_POW]),CONJ_TAC]);
val four = prove(``4 = SUC(SUC(SUC(SUC 0)))``, EVAL_TAC);

Theorem cr_poly_components:
  !h y x:real. (\u. RE (((u+h,y):complex) pow 4)) continuous at x /\
               (\u. IM (((u+h,y):complex) pow 4)) continuous at x
Proof
  rpt gen_tac >> conj_tac >>
  PURE_REWRITE_TAC [four,complex_pow,complex_mul,complex_of_num,complex_of_real,RE,IM,FST,SND] >>
  basic_cont
QED

val cont_inv = REWRITE_RULE [combinTheory.o_DEF] CONTINUOUS_AT_INV;
val rational_cont = REPEAT (FIRST [FIRST_ASSUM MATCH_ACCEPT_TAC,
  MATCH_ACCEPT_TAC periodic_B4_continuous, MATCH_ACCEPT_TAC CONTINUOUS_CONST,
  MATCH_ACCEPT_TAC CONTINUOUS_AT_ID, FIRST (map HO_MATCH_MP_TAC
    [CONTINUOUS_NEG,CONTINUOUS_SUB,CONTINUOUS_ADD,CONTINUOUS_MUL,CONTINUOUS_POW,cont_inv]),
  CONJ_TAC]);

Theorem cr_component_cont:
  !h y x:real. 0<y ==> (\u. RE(periodic_kernel h y u)) continuous at x /\
                         (\u. IM(periodic_kernel h y u)) continuous at x
Proof
  rpt gen_tac >> strip_tac >> qabbrev_tac `w = (\u:real. ((u+h,y):complex) pow 4)` >>
  `(\u. FST(w u)) continuous at x /\ (\u. SND(w u)) continuous at x` by
    (unabbrev_all_tac >> BETA_TAC >> MATCH_ACCEPT_TAC (PURE_REWRITE_RULE[RE,IM] cr_poly_components)) >>
  `w x <> complex_of_num 0` by
    (simp[Abbr`w`] >> match_mp_tac COMPLEX_POW_NZ >> simp[complex_of_num,complex_of_real] >>
     RealField.REAL_ASM_ARITH_TAC) >>
  `0<modu(w x)` by metis_tac[MODU_NZ] >>
  `(FST(w x)) pow 2+(SND(w x)) pow 2 <> 0` by
    (mp_tac (Q.SPEC `(w:real->complex) x` MODU_POW2) >> PURE_REWRITE_TAC[RE,IM] >>
     metis_tac[REAL_POS_NZ,POW_NZ]) >>
  `!u. periodic_kernel h y u = complex_of_real(phase_B4(frac u)) / w u` by
    simp[Abbr`w`,periodic_kernel_def] >>
  pop_assum (fn th=>PURE_REWRITE_TAC[th,complex_div,complex_mul,complex_inv,complex_of_real,
                                     RE,IM,FST,SND,real_div]) >> rational_cont
QED

Theorem cr_component_integrals:
  !h y a b:real. 0<y ==>
    Dint(a,b) (\u. RE(periodic_kernel h y u)) (RE(cr_int a b (periodic_kernel h y))) /\
    Dint(a,b) (\u. IM(periodic_kernel h y u)) (IM(cr_int a b (periodic_kernel h y)))
Proof
  rpt gen_tac >> strip_tac >> PURE_REWRITE_TAC [cr_int_def,RE,IM,FST,SND] >>
  conj_tac >> match_mp_tac INTEGRABLE_DINT >> match_mp_tac INTEGRABLE_CONTINUOUS >>
  rpt strip_tac >> PURE_REWRITE_TAC [contl_eq_continuous_at] >>
  metis_tac[cr_component_cont,RE,IM]
QED

Theorem cr_finite_kernel_norm:
  !h y a b:real. 0<y /\ a<=b ==> modu(cr_int a b (periodic_kernel h y)) <=
    integral(a,b) (\u. modu(periodic_kernel h y u))
Proof
  rpt strip_tac >> mp_tac (Q.SPECL [`a:real`,`b:real`,`periodic_kernel h y`,
    `cr_int a b (periodic_kernel h y)`,`integral(a,b) (\u. modu(periodic_kernel h y u))`]
    cr_norm_integral) >> asm_simp_tac bool_ss [modulus_finite] >>
  metis_tac[cr_component_integrals]
QED



