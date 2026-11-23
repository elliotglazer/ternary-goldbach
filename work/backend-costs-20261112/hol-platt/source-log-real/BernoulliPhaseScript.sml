Theory BernoulliPhase
Ancestors real
Libs realLib RealField

val _ = realLib.prefer_real ();
fun trace n g = (print (n ^ "\n"); ALL_TAC g);

Definition phase_B4_def:
  phase_B4 x = (x:real) pow 4 - 2*x pow 3 + x pow 2 - 1/30
End

Theorem phase_B4_bounds:
  !x:real. 0 <= x /\ x <= 1 ==>
    -(1/30) <= phase_B4 x /\ phase_B4 x <= 7/240
Proof
  gen_tac >> strip_tac >>
  trace "step1" >>
  `0 <= 1-x` by RealField.REAL_ASM_ARITH_TAC >>
  trace "step2" >>
  `0 <= x*(1-x)` by (match_mp_tac REAL_LE_MUL >> asm_rewrite_tac[]) >>
  trace "step3" >>
  `1/4 - x*(1-x) = (x-1/2) pow 2` by
    RealField.REAL_ARITH_TAC >>
  trace "step4" >>
  `x*(1-x) <= 1/4` by
    (mp_tac (Q.SPEC `x-1/2` REAL_LE_POW2) >> RealField.REAL_ASM_ARITH_TAC) >>
  trace "step5" >>
  `x*(1-x)*(x*(1-x)) <= (1/4)*(1/4)` by
    (match_mp_tac REAL_LE_MUL2 >> asm_simp_tac real_ss []) >>
  trace "step6" >>
  `0 <= x*(1-x)*(x*(1-x))` by
    (match_mp_tac REAL_LE_MUL >> asm_rewrite_tac[]) >>
  trace "step7" >>
  `phase_B4 x = x*(1-x)*(x*(1-x))-1/30` by
    (PURE_REWRITE_TAC[phase_B4_def] >> RealField.REAL_ARITH_TAC) >>
  trace "step8" >>
  pop_assum SUBST1_TAC >>
  RealField.REAL_ASM_ARITH_TAC
QED

Theorem phase_B4_absolute:
  !x:real. 0 <= x /\ x <= 1 ==> abs(phase_B4 x) <= 1/30
Proof
  rpt strip_tac >> imp_res_tac phase_B4_bounds >>
  simp [ABS_BOUNDS] >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem phase_B4_sharp:
  phase_B4 0 = -(1/30) /\ phase_B4 (1/2) = 7/240
Proof
  PURE_REWRITE_TAC[phase_B4_def] >> CONV_TAC RealField.REAL_RAT_REDUCE_CONV
QED

(* All error magnitudes are scaled by y^3, where y=Im z>0.
   The analytic input is domination of the order-four periodic integral
   by m*pi/4 for every valid uniform absolute bound m on B4. *)
Theorem scaled_stirling_remainder:
  !p kernel err:real.
    p <= 4 /\
    (!m:real. (!x:real. 0 <= x /\ x <= 1 ==> abs(phase_B4 x) <= m) ==>
       kernel <= m*p/4) /\
    err <= 1/360 + kernel/4 ==> err <= 1/90
Proof
  rpt strip_tac >>
  trace "step9" >>
  `kernel <= (1/30)*p/4` by metis_tac[phase_B4_absolute] >>
  RealField.REAL_ASM_ARITH_TAC
QED


