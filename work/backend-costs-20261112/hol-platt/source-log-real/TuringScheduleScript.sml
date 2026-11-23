Theory TuringSchedule
Ancestors SourceLogTail real transc
Libs realLib RealField

val _ = realLib.prefer_real ();
val rat = RealField.REAL_RAT_REDUCE_CONV;

Theorem log_two_cheap:
  ln 2 <= 694/1000
Proof
  mp_tac (Q.SPECL [`SUC (SUC (SUC (SUC 0)))`, `1/3:real`]
           SourceLogTailTheory.sl_log_partial_error) >>
  PURE_REWRITE_TAC [SourceLogTailTheory.sl_log_partial_def] >>
  CONV_TAC (DEPTH_CONV (CHANGED_CONV numLib.REDUCE_CONV)) >>
  CONV_TAC rat >> simp [ABS_BOUNDS] >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem schedule_log:
  !x:real. 0 < x /\ x <= 37748736 ==> ln x < 35/2
Proof
  rpt strip_tac >>
  `0 < (37748736:real)` by CONV_TAC rat >>
  `ln x <= ln 37748736` by metis_tac[LN_MONO_LE] >>
  `ln (37748736:real) = 25 * ln 2 + ln (1+1/8)` by
    (`37748736:real = 2 pow 25 * (1+1/8)` by CONV_TAC rat >>
     pop_assum SUBST1_TAC >> simp [LN_MUL,LN_POW]) >>
  mp_tac (Q.SPEC `1/8:real` LN_LE) >>
  mp_tac log_two_cheap >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem schedule_allowances:
  !x:real. 0 < x /\ x <= 37748736 ==>
    (18397 + 1242 * ln x)/10000 < 10033/2500 /\
    (15927/1000 + (9/4)*ln x)/(314/100) < 18
Proof
  rpt strip_tac >> imp_res_tac schedule_log >> RealField.REAL_ASM_ARITH_TAC
QED

(* y is q times the upper height. The alternatives majorize both parities
   of Platt's schedule after extending the guard by at most 200. *)
Theorem conductor_height_domain:
  !q y p:real. q <= 400000 /\ 0 < y /\ 314/100 <= p /\
    (y <= 100000000 + 200*q \/ y <= 75000000 + 400*q) ==>
    0 < y/(2*p) /\ y/(2*p) <= 37748736
Proof
  rpt gen_tac >> strip_tac >>
  `0 < 2*p` by RealField.REAL_ASM_ARITH_TAC >>
  asm_simp_tac real_ss [REAL_LT_RDIV_EQ, REAL_LE_LDIV_EQ] >>
  RealField.REAL_ASM_ARITH_TAC
QED
