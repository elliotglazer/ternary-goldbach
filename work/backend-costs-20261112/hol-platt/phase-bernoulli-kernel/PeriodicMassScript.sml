Theory PeriodicMass
Ancestors PeriodicKernel BernoulliPhase PhaseMass intreal complex integral real_topology lim
Libs realLib RealField

open realTheory;
val _ = realLib.prefer_real ();

Theorem phase_B4_reflect:
  !x:real. phase_B4 (1-x) = phase_B4 x
Proof
  gen_tac >> PURE_REWRITE_TAC[phase_B4_def] >> RealField.REAL_ARITH_TAC
QED

Theorem periodic_B4_chart:
  !k:int. !u:real. real_of_int k-1 < u /\ u < real_of_int k+1 ==>
    phase_B4 (frac u) = phase_B4 (abs(u-real_of_int k))
Proof
  rpt gen_tac >> strip_tac >> Cases_on `real_of_int k <= u`
  >- (`INT_FLOOR u=k` by (simp[INT_FLOOR'] >> RealField.REAL_ASM_ARITH_TAC) >>
      `0<=u-real_of_int k` by RealField.REAL_ASM_ARITH_TAC >>
      asm_simp_tac bool_ss [frac_def,realTheory.abs]) >>
  `INT_FLOOR u=k-1` by (simp[INT_FLOOR'] >> RealField.REAL_ASM_ARITH_TAC) >>
  `~(0<=u-real_of_int k)` by RealField.REAL_ASM_ARITH_TAC >>
  `abs(u-real_of_int k) = real_of_int k-u` by
    (asm_simp_tac bool_ss [realTheory.abs] >> RealField.REAL_ARITH_TAC) >>
  `frac u = 1-(real_of_int k-u)` by
    (asm_simp_tac bool_ss [frac_def,real_of_int_sub,real_of_int_num] >> RealField.REAL_ARITH_TAC) >>
  asm_rewrite_tac[phase_B4_reflect]
QED

val continuous_algebra = REPEAT (FIRST [
  MATCH_ACCEPT_TAC CONTINUOUS_CONST, MATCH_ACCEPT_TAC CONTINUOUS_AT_ID,
  FIRST (map HO_MATCH_MP_TAC [CONTINUOUS_SUB,CONTINUOUS_ABS,CONTINUOUS_ADD,
                              CONTINUOUS_MUL,CONTINUOUS_POW]), CONJ_TAC]);

Theorem periodic_B4_continuous:
  !x:real. (\u. phase_B4(frac u)) continuous (at x)
Proof
  gen_tac >> qabbrev_tac `k = INT_FLOOR x` >>
  `real_of_int k <= x /\ x < real_of_int k+1` by
    (unabbrev_all_tac >> mp_tac (Q.SPEC `x:real` INT_FLOOR_BOUNDS') >> RealField.REAL_ARITH_TAC) >>
  qabbrev_tac `d = real_of_int k+1-x` >>
  `0<d /\ d<=1` by (qunabbrev_tac `d` >> RealField.REAL_ASM_ARITH_TAC) >>
  mp_tac (Q.SPECL [`\u. phase_B4(abs(u-real_of_int k))`,`\u. phase_B4(frac u)`,
                    `x:real`,`d:real`] CONTINUOUS_TRANSFORM_AT) >>
  asm_simp_tac bool_ss [] >> disch_then match_mp_tac >> conj_tac
  >- (gen_tac >> PURE_REWRITE_TAC[metricTheory.dist] >> strip_tac >> irule EQ_SYM >>
      match_mp_tac periodic_B4_chart >>
      fs [ABS_BOUNDS_LT,Abbr`d`] >> RealField.REAL_ASM_ARITH_TAC) >>
  PURE_REWRITE_TAC [phase_B4_def] >> continuous_algebra
QED

Theorem modulus_scalar:
  !a y u:real. 0<y ==> modu(periodic_kernel a y u) =
    abs(phase_B4 (frac u)) / (((u+a) pow 2 + y pow 2) pow 2)
Proof
  rpt strip_tac >>
  `((u+a,y):complex) <> complex_of_num 0` by
    (simp [complex_of_num,complex_of_real] >> RealField.REAL_ASM_ARITH_TAC) >>
  `((u+a,y):complex) pow 4 <> complex_of_num 0` by metis_tac[COMPLEX_POW_NZ] >>
  asm_simp_tac bool_ss [periodic_kernel_def,MODU_DIV,MODU_COMPLEX_POW,MODU_REAL] >>
  `modu ((u+a,y):complex) pow 4 = ((u+a) pow 2+y pow 2) pow 2` by
    (mp_tac (Q.SPEC `(u+a,y):complex` MODU_POW2) >> simp [RE,IM] >> disch_tac >>
     mp_tac (Q.SPECL [`modu ((u+a,y):complex)`,`2:num`,`2:num`] REAL_POW_POW) >>
     asm_simp_tac bool_ss [arithmeticTheory.MULT_CLAUSES] >>
     CONV_TAC (DEPTH_CONV (CHANGED_CONV numLib.REDUCE_CONV)) >> metis_tac[]) >>
  asm_rewrite_tac[]
QED

Theorem modulus_contl:
  !a y x:real. 0<y ==> (\u. modu(periodic_kernel a y u)) contl x
Proof
  rpt strip_tac >> asm_simp_tac bool_ss [modulus_scalar] >>
  HO_MATCH_MP_TAC CONT_DIV >> rpt conj_tac
  >- (PURE_REWRITE_TAC [contl_eq_continuous_at] >> HO_MATCH_MP_TAC CONTINUOUS_ABS >>
      MATCH_ACCEPT_TAC periodic_B4_continuous)
  >- (PURE_REWRITE_TAC [contl_eq_continuous_at] >> continuous_algebra) >>
  `0<y pow 2` by (match_mp_tac REAL_POW_LT >> asm_rewrite_tac[]) >>
  mp_tac (Q.SPEC `x+a:real` REAL_LE_POW2) >>
  `!v:real. 0<v ==> v pow 2 <> 0` by metis_tac[POW_NZ,REAL_POS_NZ] >>
  disch_tac >> first_x_assum match_mp_tac >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem modulus_finite:
  !h y a b:real. 0<y ==>
   Dint (a,b) (\u. modu(periodic_kernel h y u))
              (integral (a,b) (\u. modu(periodic_kernel h y u)))
Proof
  rpt strip_tac >> match_mp_tac INTEGRABLE_DINT >> match_mp_tac INTEGRABLE_CONTINUOUS >>
  metis_tac[modulus_contl]
QED

Definition periodic_cutoff_def:
  periodic_cutoff h y b = integral (0,b) (\u. modu(periodic_kernel h y u))
End

Theorem periodic_cutoff_bound:
  !h y b:real. 0<=h /\ 0<y /\ 0<=b ==> periodic_cutoff h y b <= (1/30)*(1/y pow 3)
Proof
  rpt strip_tac >> PURE_REWRITE_TAC [periodic_cutoff_def] >>
  mp_tac (Q.SPECL [`h:real`,`y:real`,`b:real`,
            `integral(0,b) (\u. modu(periodic_kernel h y u))`] finite_modulus_upper) >>
  asm_simp_tac bool_ss [modulus_finite]
QED

val mag = ``\u:real. modu(periodic_kernel h y u)``;
val nonnegative_integral = ISPECL [``\u:real. 0:real``,mag,``a:real``,``b:real``,
  ``0:real``,``integral(a,b) (\u. modu(periodic_kernel h y u))``] DINT_LE;

Theorem periodic_cutoff_mono:
  !h y a b:real. 0<y /\ 0<=a /\ a<=b ==> periodic_cutoff h y a <= periodic_cutoff h y b
Proof
  rpt gen_tac >> strip_tac >> PURE_REWRITE_TAC [periodic_cutoff_def] >>
  `0<=integral(a,b) (\u. modu(periodic_kernel h y u))` by
    (mp_tac nonnegative_integral >> asm_simp_tac bool_ss [modulus_finite,MODU_POS] >>
     disch_then match_mp_tac >> mp_tac (Q.SPECL [`a:real`,`b:real`,`0:real`] DINT_CONST) >> simp[]) >>
  `integrable(0,b) (\u. modu(periodic_kernel h y u))` by
    (PURE_REWRITE_TAC[integrable] >>
     qexists_tac `integral(0,b) (\u. modu(periodic_kernel h y u))` >>
     match_mp_tac modulus_finite >> asm_rewrite_tac[]) >>
  mp_tac (ISPECL [mag,``0:real``,``a:real``,``b:real``] INTEGRAL_COMBINE) >>
  asm_simp_tac bool_ss [] >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem periodic_modulus_improper:
  !h y:real. 0<=h /\ 0<y ==> ?L. L <= (1/30)*(1/y pow 3) /\
    !e. 0<e ==> ?a. 0<=a /\ !b. a<=b ==> abs(periodic_cutoff h y b - L)<e
Proof
  rpt strip_tac >> qabbrev_tac `pred = (\i:real. ?b:real. 0<=b /\ i=periodic_cutoff h y b)` >>
  qexists_tac `sup pred` >>
  `?i. pred i` by (qexists_tac `periodic_cutoff h y 0` >> unabbrev_all_tac >> BETA_TAC >>
                  qexists_tac `0:real` >> simp[]) >>
  `!i. pred i ==> i<=(1/30)*(1/y pow 3)` by (unabbrev_all_tac >> BETA_TAC >> metis_tac[periodic_cutoff_bound]) >>
  `!z. (?i. pred i /\ z<i) <=> z<sup pred` by (match_mp_tac REAL_SUP_LE >> metis_tac[]) >>
  conj_tac >- metis_tac[REAL_IMP_SUP_LE] >> rpt strip_tac >>
  `?v. pred v /\ sup pred-e<v` by
    (qpat_x_assum `!z. _ <=> _` (fn th => rewrite_tac[Q.SPEC `sup pred-e` th]) >>
     RealField.REAL_ASM_ARITH_TAC) >>
  `?a. 0<=a /\ v=periodic_cutoff h y a` by (qpat_x_assum `pred v` mp_tac >> simp[Abbr`pred`]) >>
  qexists_tac `a:real` >> asm_rewrite_tac[] >> rpt strip_tac >>
  `periodic_cutoff h y a <= periodic_cutoff h y b` by metis_tac[periodic_cutoff_mono] >>
  `pred (periodic_cutoff h y b)` by (simp[Abbr`pred`] >> metis_tac[REAL_LE_TRANS]) >>
  `periodic_cutoff h y b <= sup pred` by
    (qpat_x_assum `!z. _ <=> _` (mp_tac o Q.SPEC `sup pred`) >>
     metis_tac[REAL_LT_REFL,REAL_NOT_LT]) >>
  simp[ABS_BOUNDS_LT] >> RealField.REAL_ASM_ARITH_TAC
QED


