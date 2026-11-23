Theory ComplexTail
Ancestors ComplexRemainder PeriodicKernel PeriodicMass integral real_topology nets complex lim
Libs realLib RealField

open realTheory pairTheory;
val _ = realLib.prefer_real ();

Theorem cr_mono_limit:
  !curve:real->real. !cap. (!b. 0<=b ==> curve b<=cap) /\
   (!a b. 0<=a /\ a<=b ==> curve a<=curve b) ==>
   ?l. l<=cap /\ !e. 0<e ==> ?a. 0<=a /\ !b. a<=b ==> abs(curve b-l)<e
Proof
  rpt strip_tac >> qabbrev_tac `pred = (\i:real. ?b:real. 0<=b /\ i=curve b)` >>
  qexists_tac `sup pred` >>
  `?i. pred i` by (qexists_tac `curve 0` >> unabbrev_all_tac >> BETA_TAC >>
                  qexists_tac `0:real` >> simp[]) >>
  `!i. pred i ==> i<=cap` by (unabbrev_all_tac >> BETA_TAC >> metis_tac[]) >>
  `!z. (?i. pred i /\ z<i) <=> z<sup pred` by (match_mp_tac REAL_SUP_LE >> metis_tac[]) >>
  conj_tac >- metis_tac[REAL_IMP_SUP_LE] >> rpt strip_tac >>
  `?v. pred v /\ sup pred-e<v` by
    (qpat_x_assum `!z. _ <=> _` (fn th => rewrite_tac[Q.SPEC `sup pred-e` th]) >>
     RealField.REAL_ASM_ARITH_TAC) >>
  `?a. 0<=a /\ v=curve a` by (qpat_x_assum `pred v` mp_tac >> simp[Abbr`pred`]) >>
  qexists_tac `a:real` >> asm_rewrite_tac[] >> rpt strip_tac >>
  `curve a <= curve b` by metis_tac[] >>
  `pred (curve b)` by (simp[Abbr`pred`] >> metis_tac[REAL_LE_TRANS]) >>
  `curve b <= sup pred` by
    (qpat_x_assum `!z. _ <=> _` (mp_tac o Q.SPEC `sup pred`) >>
     metis_tac[REAL_LT_REFL,REAL_NOT_LT]) >>
  simp[ABS_BOUNDS_LT] >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem cr_eps_net:
 !f:real->real. !l.
   (!e. 0<e ==> ?a. 0<=a /\ !b. a<=b ==> abs(f b-l)<e) ==>
   (f --> l) at_posinfinity
Proof
 rpt strip_tac >> PURE_REWRITE_TAC[LIM_AT_POSINFINITY,metricTheory.dist,real_ge] >>
 metis_tac[]
QED

Theorem cr_shift_limit:
 !f g:real->real. !cap m.
  (g --> m) at_posinfinity /\ (!b. 0<=b ==> f b<=cap /\ g b<=cap) /\
  (!a b. 0<=a /\ a<=b ==> abs(f b-f a)<=g b-g a) ==>
  ?l. (f --> l) at_posinfinity
Proof
 rpt gen_tac >> strip_tac >>
 `!b. 0<=b ==> f b+g b<=cap+cap` by
   (rpt strip_tac >> 
    `f b<=cap /\ g b<=cap` by metis_tac[] >> RealField.REAL_ASM_ARITH_TAC) >>
 `!a b. 0<=a /\ a<=b ==> f a+g a<=f b+g b` by
   (rpt strip_tac >> `abs(f b-f a)<=g b-g a` by metis_tac[] >>
    fs[ABS_BOUNDS] >> RealField.REAL_ASM_ARITH_TAC) >>
 mp_tac (Q.SPECL [`\b:real. f b+g b`,`cap+cap:real`] cr_mono_limit) >>
 asm_simp_tac bool_ss [] >> strip_tac >>
 `((\b. f b+g b) --> l) at_posinfinity` by
   (match_mp_tac cr_eps_net >> asm_simp_tac bool_ss []) >>
 qexists_tac `l-m:real` >>
 mp_tac (Q.SPECL [`at_posinfinity`,`\b:real. f b+g b`,`g:real->real`,
                  `l:real`,`m:real`] real_topologyTheory.LIM_SUB) >>
 asm_simp_tac real_ss [ETA_THM]
QED

Theorem cr_additive:
 !f:real->real. !a b. 0<=a /\ a<=b /\ (!x. f contl x) ==>
  integral(0,b) f - integral(0,a) f = integral(a,b) f
Proof
 rpt strip_tac >>
 `integrable(0,b) f` by (match_mp_tac INTEGRABLE_CONTINUOUS >> metis_tac[]) >>
 mp_tac (Q.SPECL [`f:real->real`,`0:real`,`a:real`,`b:real`] INTEGRAL_COMBINE) >>
 asm_simp_tac bool_ss [] >> RealField.REAL_ARITH_TAC
QED

Theorem cr_increment:
 !h y a b. 0<y /\ 0<=a /\ a<=b ==>
   abs(RE(cr_int 0 b (periodic_kernel h y))-RE(cr_int 0 a (periodic_kernel h y))) <=
      periodic_cutoff h y b-periodic_cutoff h y a /\
   abs(IM(cr_int 0 b (periodic_kernel h y))-IM(cr_int 0 a (periodic_kernel h y))) <=
      periodic_cutoff h y b-periodic_cutoff h y a
Proof
 rpt gen_tac >> strip_tac >>
 `!x. (\u. RE(periodic_kernel h y u)) contl x /\ (\u. IM(periodic_kernel h y u)) contl x`
  by (PURE_REWRITE_TAC[contl_eq_continuous_at] >> metis_tac[cr_component_cont]) >>
 mp_tac (Q.SPEC `cr_int a b (periodic_kernel h y)` RE_IM_LE_MODU) >>
 mp_tac (Q.SPECL [`h:real`,`y:real`,`a:real`,`b:real`] cr_finite_kernel_norm) >>
 asm_simp_tac bool_ss [] >>
 PURE_REWRITE_TAC [periodic_cutoff_def,cr_int_def,RE,IM,FST,SND] >>
 `!x. (\u. FST(periodic_kernel h y u)) contl x /\
       (\u. SND(periodic_kernel h y u)) contl x` by metis_tac[RE,IM] >>
 asm_simp_tac bool_ss [cr_additive,modulus_contl] >>
 metis_tac[REAL_LE_TRANS]
QED

Theorem cr_closed_disk:
 !q:real->complex. !z cap. 0<=cap /\
   ((\b. RE(q b)) --> RE z) at_posinfinity /\
   ((\b. IM(q b)) --> IM z) at_posinfinity /\
   (!b. 0<=b ==> modu(q b)<=cap) ==> modu z<=cap
Proof
 rpt gen_tac >> strip_tac >>
 `((\b. cr_dot z (q b)) --> cr_dot z z) at_posinfinity` by
   (PURE_REWRITE_TAC[cr_dot_def] >> HO_MATCH_MP_TAC real_topologyTheory.LIM_ADD >>
    conj_tac >> HO_MATCH_MP_TAC real_topologyTheory.LIM_CMUL >> asm_rewrite_tac[]) >>
 `eventually (\b. cr_dot z (q b) <= modu z * cap) at_posinfinity` by
   (PURE_REWRITE_TAC[EVENTUALLY_AT_POSINFINITY,real_ge] >> BETA_TAC >>
    qexists_tac `0:real` >> rpt strip_tac >>
    `modu z * modu(q x) <= modu z * cap` by
      (match_mp_tac REAL_LE_LMUL_IMP >> metis_tac[MODU_POS]) >>
    metis_tac[cr_dot_bound,REAL_LE_TRANS]) >>
 `cr_dot z z <= modu z * cap` by
   (mp_tac (Q.SPECL [`at_posinfinity`,`\b:real. cr_dot z (q b)`,`cr_dot z z`,
     `modu z * cap`] (GEN_ALL (SPEC_ALL LIM_COMPONENT_UBOUND))) >>
    asm_simp_tac bool_ss [TRIVIAL_LIMIT_AT_POSINFINITY]) >>
 `cr_dot z z = modu z * modu z` by
   (PURE_REWRITE_TAC[cr_dot_def,GSYM POW_2,MODU_POW2] >> REFL_TAC) >>
 Cases_on `modu z=0` >- asm_rewrite_tac[] >>
 `0<modu z` by metis_tac[MODU_POS,REAL_LE_LT] >>
 metis_tac[REAL_LE_LMUL]
QED




