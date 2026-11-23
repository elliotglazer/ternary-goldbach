Theory PhaseMass
Ancestors integral real lim
Libs realLib RealField Diff

val _ = realLib.prefer_real ();

Definition pm_den_def:
  pm_den y u = ((u+y)*(u*u+y*y):real)
End

Definition pm_slope_def:
  pm_slope y u = ((u*u+y*y)+(u+y)*(u+u)) / (pm_den y u pow 2)
End

Theorem pm_positive:
  !y u:real. 0<y /\ 0<=u ==> 0<u+y /\ 0<u*u+y*y /\ 0<pm_den y u
Proof
  rpt gen_tac >> strip_tac >>
  `0<y*y` by (match_mp_tac REAL_LT_MUL >> asm_rewrite_tac[]) >>
  `0<=u*u` by (match_mp_tac REAL_LE_MUL >> asm_rewrite_tac[]) >>
  `0<u+y /\ 0<u*u+y*y` by RealField.REAL_ASM_ARITH_TAC >>
  PURE_REWRITE_TAC [pm_den_def] >> metis_tac [REAL_LT_MUL]
QED

val deriv = SIMP_RULE real_ss []
  (Diff.DIFF_CONV ``\u:real. -(1/((u+y)*(u*u+y*y)))``);
val _ = print (thm_to_string deriv ^ "\n");

Theorem pm_primitive:
  !y u:real. 0<y /\ 0<=u ==>
    ((\t. -(1/pm_den y t)) diffl pm_slope y u) u
Proof
  rpt gen_tac >> strip_tac >> imp_res_tac pm_positive >>
  `(u+y)*(u*u+y*y) <> 0` by metis_tac[pm_den_def,REAL_POS_NZ] >>
  `-((0-(u*u+y*y+(u+u)*(u+y)))/((u+y)*(u*u+y*y)) pow 2) =
      pm_slope y u` by
    (PURE_REWRITE_TAC[pm_slope_def,pm_den_def,real_div] >>
     RealField.REAL_ARITH_TAC) >>
  mp_tac (Q.SPEC `u:real` deriv) >>
  ASM_SIMP_TAC bool_ss [pm_den_def]
QED

Theorem pm_dominates:
  !y u:real. 0<y /\ 0<=u ==> 1/(u*u+y*y) pow 2 <= pm_slope y u
Proof
  rpt gen_tac >> strip_tac >> imp_res_tac pm_positive >>
  `0 < pm_den y u pow 2 /\ 0 < (u*u+y*y) pow 2 /\ 0 < (u+y) pow 2`
    by (rpt conj_tac >> match_mp_tac REAL_POW_LT >> asm_rewrite_tac[]) >>
  `1/(u*u+y*y) pow 2 = (u+y) pow 2 / (pm_den y u pow 2)` by
    (PURE_REWRITE_TAC [pm_den_def,POW_MUL] >>
     mp_tac (Q.SPECL [`(u+y) pow 2`,`1:real`,`(u*u+y*y) pow 2`] REAL_DIV_LMUL_CANCEL) >>
     asm_simp_tac real_ss [REAL_POS_NZ]) >>
  pop_assum SUBST1_TAC >> PURE_REWRITE_TAC [pm_slope_def] >>
  asm_simp_tac bool_ss [REAL_LE_RDIV_CANCEL] >>
  mp_tac (Q.SPEC `u:real` REAL_LE_POW2) >> RealField.REAL_ARITH_TAC
QED

Theorem finite_mass_bound:
  !y b i:real. 0<y /\ 0<=b /\
    Dint(0,b) (\u. 1/(u*u+y*y) pow 2) i ==> i <= 1/y pow 3
Proof
  rpt gen_tac >> strip_tac >>
  `Dint(0,b) (pm_slope y) (-(1/pm_den y b) - -(1/pm_den y 0))`
    by (mp_tac (Q.SPECL [`\t:real. -(1/pm_den y t)`,`pm_slope y`,`0:real`,`b:real`] FTC1) >>
        ASM_SIMP_TAC bool_ss [pm_primitive]) >>
  `i <= -(1/pm_den y b) - -(1/pm_den y 0)` by
    (mp_tac (Q.SPECL [`\u:real. 1/(u*u+y*y) pow 2`,`pm_slope y`,
      `0:real`,`b:real`,`i:real`,`-(1/pm_den y b) - -(1/pm_den y 0)`] DINT_LE) >>
     ASM_SIMP_TAC bool_ss [pm_dominates]) >>
  `pm_den y 0 = y pow 3` by
    (PURE_REWRITE_TAC [pm_den_def] >> RealField.REAL_ARITH_TAC) >>
  `0 < pm_den y b` by metis_tac [pm_positive] >>
  `0 <= 1/pm_den y b` by (match_mp_tac REAL_LE_DIV >> RealField.REAL_ASM_ARITH_TAC) >>
  qpat_x_assum `i <= _` mp_tac >> ASM_SIMP_TAC bool_ss [] >>
  RealField.REAL_ASM_ARITH_TAC
QED

val kernel_derivative = SIMP_RULE real_ss []
  (Diff.DIFF_CONV ``\u:real. 1/(u*u+y*y) pow 2``);

Theorem kernel_integral_exists:
  !y a b:real. 0<y /\ 0<=a /\ a<=b ==>
    Dint(a,b) (\u. 1/(u*u+y*y) pow 2) (integral(a,b) (\u. 1/(u*u+y*y) pow 2))
Proof
  rpt strip_tac >> match_mp_tac INTEGRABLE_DINT >>
  match_mp_tac INTEGRABLE_CONTINUOUS >> rpt strip_tac >>
  `0<=x` by RealField.REAL_ASM_ARITH_TAC >>
  `0<x*x+y*y` by metis_tac [pm_positive] >>
  mp_tac (Q.SPEC `x:real` kernel_derivative) >>
  asm_simp_tac real_ss [REAL_POS_NZ,POW_NZ] >> metis_tac [DIFF_CONT]
QED

Definition pm_cutoff_def:
  pm_cutoff y b = integral(0,b) (\u:real. 1/(u*u+y*y) pow 2)
End

Theorem cutoff_bound:
  !y b:real. 0<y /\ 0<=b ==> pm_cutoff y b <= 1/y pow 3
Proof
  rpt strip_tac >> PURE_REWRITE_TAC [pm_cutoff_def] >>
  mp_tac (Q.SPECL [`y:real`,`0:real`,`b:real`] kernel_integral_exists) >>
  mp_tac (Q.SPECL [`y:real`,`b:real`,`integral (0,b) (\u. 1/(u*u+y*y) pow 2)`] finite_mass_bound) >>
  asm_simp_tac bool_ss [REAL_LE_REFL] >> metis_tac[]
QED

Theorem positive_mass_sup_bound:
  !y:real. 0<y ==> sup (\i. ?b. 0<=b /\ i=pm_cutoff y b) <= 1/y pow 3
Proof
  rpt strip_tac >> match_mp_tac REAL_IMP_SUP_LE >> BETA_TAC >> conj_tac
  >- (qexists_tac `pm_cutoff y 0` >> qexists_tac `0:real` >> simp[]) >>
  metis_tac[cutoff_bound]
QED

val integrand = ``\u:real. 1/(u*u+y*y) pow 2``;
val subinterval_exists = Q.SPECL [`y:real`,`a:real`,`b:real`] kernel_integral_exists;
val compare_zero = ISPECL [``\u:real. 0:real``, integrand,``a:real``,``b:real``,
  ``0:real``,``integral(a,b) (\u. 1/(u*u+y*y) pow 2)``] DINT_LE;

Theorem cutoff_mono:
  !y a b:real. 0<y /\ 0<=a /\ a<=b ==> pm_cutoff y a <= pm_cutoff y b
Proof
  rpt gen_tac >> strip_tac >> PURE_REWRITE_TAC[pm_cutoff_def] >>
  `0<=integral(a,b) (\u. 1/(u*u+y*y) pow 2)` by
    (mp_tac compare_zero >> asm_simp_tac bool_ss [subinterval_exists] >>
     disch_then match_mp_tac >> conj_tac
     >- (mp_tac (Q.SPECL [`a:real`,`b:real`,`0:real`] DINT_CONST) >> simp[]) >>
     rpt strip_tac >> match_mp_tac REAL_LE_DIV >> simp[REAL_LE_POW2]) >>
  `integrable(0,b) (\u. 1/(u*u+y*y) pow 2)` by
    (PURE_REWRITE_TAC[integrable] >> qexists_tac `integral(0,b) (\u. 1/(u*u+y*y) pow 2)` >>
     match_mp_tac kernel_integral_exists >> RealField.REAL_ASM_ARITH_TAC) >>
  mp_tac (ISPECL [integrand,``0:real``,``a:real``,``b:real``] INTEGRAL_COMBINE) >>
  asm_simp_tac bool_ss [] >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem improper_mass_bound:
  !y:real. 0<y ==> ?L. L <= 1/y pow 3 /\
    !e. 0<e ==> ?a. 0<=a /\ !b. a<=b ==> abs(pm_cutoff y b - L)<e
Proof
  rpt strip_tac >> qabbrev_tac `pred = (\i:real. ?b:real. 0<=b /\ i=pm_cutoff y b)` >>
  qexists_tac `sup pred` >>
  `?i. pred i` by (qexists_tac `pm_cutoff y 0` >> unabbrev_all_tac >> BETA_TAC >>
                  qexists_tac `0:real` >> simp[]) >>
  `!i. pred i ==> i<=1/y pow 3` by (unabbrev_all_tac >> BETA_TAC >> metis_tac[cutoff_bound]) >>
  `!z. (?i. pred i /\ z<i) <=> z<sup pred` by (match_mp_tac REAL_SUP_LE >> metis_tac[]) >>
  conj_tac >- metis_tac[REAL_IMP_SUP_LE] >> rpt strip_tac >>
  `?v. pred v /\ sup pred-e<v` by
    (qpat_x_assum `!z. _ <=> _` (fn th => rewrite_tac[Q.SPEC `sup pred-e` th]) >>
     RealField.REAL_ASM_ARITH_TAC) >>
  `?a. 0<=a /\ v=pm_cutoff y a` by (qpat_x_assum `pred v` mp_tac >> simp[Abbr`pred`]) >>
  qexists_tac `a:real` >> asm_rewrite_tac[] >> rpt strip_tac >>
  `pm_cutoff y a <= pm_cutoff y b` by metis_tac[cutoff_mono] >>
  `pred (pm_cutoff y b)` by (simp[Abbr`pred`] >> metis_tac[REAL_LE_TRANS]) >>
  `pm_cutoff y b <= sup pred` by
    (qpat_x_assum `!z. _ <=> _` (mp_tac o Q.SPEC `sup pred`) >>
     metis_tac[REAL_LT_REFL,REAL_NOT_LT]) >>
  simp[ABS_BOUNDS_LT] >> RealField.REAL_ASM_ARITH_TAC
QED

