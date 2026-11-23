Theory PeriodicKernel
Ancestors BernoulliPhase PhaseMass intreal complex integral real
Libs realLib RealField

val _ = realLib.prefer_real ();

Definition periodic_kernel_def:
  periodic_kernel (a:real) (y:real) (u:real) =
    complex_of_real (phase_B4 (frac u)) / (((u+a,y):complex) pow 4)
End

Theorem periodic_B4_abs:
  !u:real. abs(phase_B4 (frac u)) <= 1/30
Proof
  gen_tac >> match_mp_tac phase_B4_absolute >> PURE_REWRITE_TAC[frac_def] >>
  mp_tac (Q.SPEC `u:real` INT_FLOOR_BOUNDS') >> RealField.REAL_ARITH_TAC
QED

Theorem translated_fourth_power:
  !a y u:real. 0<=a /\ 0<y /\ 0<=u ==>
    0<(u*u+y*y) pow 2 /\ (u*u+y*y) pow 2 <= modu ((u+a,y):complex) pow 4
Proof
  rpt gen_tac >> strip_tac >>
  `0<u*u+y*y` by metis_tac [pm_positive] >>
  conj_tac >- (match_mp_tac REAL_POW_LT >> asm_rewrite_tac[]) >>
  `0<=u*a /\ 0<=a*a` by
    (conj_tac >> match_mp_tac REAL_LE_MUL >> asm_rewrite_tac[]) >>
  `u*u+y*y <= (u+a) pow 2+y pow 2` by RealField.REAL_ASM_ARITH_TAC >>
  `modu ((u+a,y):complex) pow 4 = ((u+a) pow 2+y pow 2) pow 2` by
    (mp_tac (Q.SPEC `(u+a,y):complex` MODU_POW2) >>
     simp [RE,IM] >> disch_tac >>
     mp_tac (Q.SPECL [`modu ((u+a,y):complex)`,`2:num`,`2:num`] REAL_POW_POW) >>
     asm_simp_tac bool_ss [arithmeticTheory.MULT_CLAUSES] >>
     CONV_TAC (DEPTH_CONV (CHANGED_CONV numLib.REDUCE_CONV)) >> metis_tac[]) >>
  pop_assum SUBST1_TAC >> match_mp_tac POW_LE >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem periodic_kernel_majorant:
  !a y u:real. 0<=a /\ 0<y /\ 0<=u ==>
    modu (periodic_kernel a y u) <= (1/30) * (1/(u*u+y*y) pow 2)
Proof
  rpt gen_tac >> strip_tac >>
  `((u+a,y):complex) <> complex_of_num 0` by
    (simp [complex_of_num,complex_of_real] >> RealField.REAL_ASM_ARITH_TAC) >>
  `((u+a,y):complex) pow 4 <> complex_of_num 0` by metis_tac[COMPLEX_POW_NZ] >>
  asm_simp_tac bool_ss [periodic_kernel_def,MODU_DIV,MODU_COMPLEX_POW,MODU_REAL,
                        real_div,REAL_MUL_LID] >>
  mp_tac (Q.SPECL [`a:real`,`y:real`,`u:real`] translated_fourth_power) >>
  asm_simp_tac bool_ss [] >> strip_tac >>
  match_mp_tac REAL_LE_MUL2 >> rpt conj_tac
  >- simp [REAL_ABS_POS]
  >- (match_mp_tac REAL_LE_INV >> RealField.REAL_ASM_ARITH_TAC)
  >- metis_tac[periodic_B4_abs,REAL_MUL_LID,real_div]
  >> match_mp_tac REAL_LE_INV2 >> asm_rewrite_tac[]
QED

(* The caller supplies existence of the integral of the particular real
   channel. Its value is bounded here using the stock gauge-integral order. *)
Theorem finite_channel_upper:
  !a y b f mass. 0<=a /\ 0<y /\ 0<=b /\ Dint(0,b) f mass /\
    (!u. 0<=u /\ u<=b ==> f u <= modu(periodic_kernel a y u)) ==>
    mass <= (1/30)*(1/y pow 3)
Proof
  rpt gen_tac >> strip_tac >>
  qabbrev_tac `g = (\u:real. 1/(u*u+y*y) pow 2)` >>
  `Dint(0,b) g (pm_cutoff y b)` by
    (unabbrev_all_tac >> PURE_REWRITE_TAC[pm_cutoff_def] >> match_mp_tac kernel_integral_exists >>
     RealField.REAL_ASM_ARITH_TAC) >>
  `Dint(0,b) (\u. (1/30)*g u) ((1/30)*pm_cutoff y b)` by (irule DINT_CMUL >> asm_rewrite_tac[]) >>
  `mass <= (1/30)*pm_cutoff y b` by
    (mp_tac (Q.SPECL [`f:real->real`,`\u:real. (1/30)*g u`,`0:real`,`b:real`,
                       `mass:real`,`(1/30)*pm_cutoff y b`] DINT_LE) >>
     asm_simp_tac bool_ss [] >> disch_then match_mp_tac >> rpt strip_tac >>
     unabbrev_all_tac >> BETA_TAC >> metis_tac[periodic_kernel_majorant,REAL_LE_TRANS]) >>
  `pm_cutoff y b <= 1/y pow 3` by metis_tac[cutoff_bound] >>
  RealField.REAL_ASM_ARITH_TAC
QED

Theorem finite_modulus_upper:
  !a y b mass. 0<=a /\ 0<y /\ 0<=b /\
    Dint(0,b) (\u. modu(periodic_kernel a y u)) mass ==> mass <= (1/30)*(1/y pow 3)
Proof
  rpt strip_tac >>
  mp_tac (Q.SPECL [`a:real`,`y:real`,`b:real`,`\u:real. modu(periodic_kernel a y u)`,
                   `mass:real`] finite_channel_upper) >>
  asm_simp_tac bool_ss [REAL_LE_REFL]
QED

