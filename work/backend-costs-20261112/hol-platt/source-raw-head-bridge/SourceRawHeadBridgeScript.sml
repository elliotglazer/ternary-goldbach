(* Euclidean error of the actual grid100 raw-head formula on the retained grid120 states. *)
Theory SourceRawHeadBridge
Ancestors SourceRawStateBridge SourceRawStep SourceStateError SourceStateBounds SourceInitial SourceArithmetic RawPairRound RawStateHandoff complex transc real intreal integer arithmetic
Libs realLib RealField

val _ = realLib.prefer_real ();

Definition srh_state_def:
  srh_state (x:num) n = source_state (2**122) (THE (source_raw_initial x))
                          (source_raw_step (source_raw_log129 (logroot$LOG 2 x) x)) n
End

Theorem srh_state_error:
  !x n:num. 0<x /\ x<2**19 /\ n<=90000 ==>
    modu (source_pair_value (2**120) (srh_state x n) - srb_target x (5*(&n:real)/64)) <= 1/(2:real) pow 96
Proof
  rpt strip_tac >> mp_tac (Q.SPEC `x:num` source_raw_state_log2) >> ASM_REWRITE_TAC [] >> strip_tac >>
  ASM_REWRITE_TAC [srh_state_def,optionTheory.THE_DEF] >> metis_tac [REAL_LT_IMP_LE]
QED

Theorem srh_embed_mul:
  !x:real. !z:complex. x*z = complex_of_real x * z
Proof
  rpt gen_tac >> REWRITE_TAC [complex_scalar_lmul,complex_mul,complex_of_real,RE,IM,
    pairTheory.FST,pairTheory.SND,REAL_MUL_LZERO,REAL_ADD_RID,REAL_ADD_LID,REAL_SUB_RZERO]
QED

Theorem srh_conj_exp:
  !z:complex. conj (complex_exp z) = complex_exp (conj z)
Proof
  gen_tac >> Cases_on `z` >> REWRITE_TAC [complex_exp,complex_scalar_lmul,conj,RE,IM,
    pairTheory.FST,pairTheory.SND,COS_NEG,SIN_NEG,REAL_NEG_RMUL]
QED

Theorem srh_log_exp:
  !c:real. 0<c ==> complex_of_real c = complex_exp (complex_of_real (ln c))
Proof
  rpt strip_tac >> `exp (ln c) = c` by ASM_REWRITE_TAC [transcTheory.EXP_LN] >>
  ASM_REWRITE_TAC [complex_exp,complex_scalar_lmul,complex_of_real,RE,IM,pairTheory.FST,pairTheory.SND,
    SIN_0,COS_0,REAL_MUL_RID,REAL_MUL_RZERO]
QED

Theorem srh_target:
  !a c:num. !t:real. 0<a /\ 0<c ==>
    (&c:real) * (conj (srb_target c t) * srb_target a t) =
    complex_exp ((~(1/2),~t) * complex_of_real (ln ((&a:real) / &c)))
Proof
  rpt gen_tac >> strip_tac >> `0 < (&c:real) /\ 0 < (&a:real)` by simp [] >>
  ONCE_REWRITE_TAC [srh_embed_mul] >>
  `complex_of_real (&c:real) = complex_exp (complex_of_real (ln (&c)))` by metis_tac [srh_log_exp] >>
  ASM_SIMP_TAC bool_ss [srb_target_def,srh_conj_exp,GSYM COMPLEX_EXP_ADD,LN_DIV] >> AP_TERM_TAC >>
  REWRITE_TAC [complex_add,complex_mul,conj,complex_of_real,RE,IM,pairTheory.FST,pairTheory.SND,pairTheory.PAIR_EQ] >>
  conj_tac >> RealField.REAL_ARITH_TAC
QED

Theorem srh_rounding:
  !c:num. !U V:int#int. modu (source_pair_value (2**100) (raw_head (&c) U V) -
    (&c:real)*(conj (source_pair_value (2**120) U) * source_pair_value (2**120) V)) <= 1/(2:real) pow 100
Proof
  rpt gen_tac >> PairCases_on `U` >> PairCases_on `V` >>
  qabbrev_tac `p = (&c:int)*(U0*V0+U1*V1)` >> qabbrev_tac `q = (&c:int)*(U0*V1-U1*V0)` >>
  `0 < (&((2:num)**100):int) /\ 0 < (1393796574908163946345982392040522594123776:int)` by EVAL_TAC >>
  mp_tac (Q.SPECL [`&((2:num)**100):int`,`1393796574908163946345982392040522594123776:int`,`p:int`] round_scaled_coordinate_error) >>
  mp_tac (Q.SPECL [`&((2:num)**100):int`,`1393796574908163946345982392040522594123776:int`,`q:int`] round_scaled_coordinate_error) >>
  ASM_REWRITE_TAC [real_of_int_num,GSYM REAL_OF_NUM_POW] >> rpt strip_tac >>
  `(&c:real)*(conj (source_pair_value (2**120) (U0,U1)) * source_pair_value (2**120) (V0,V1)) =
   (real_of_int p / (1393796574908163946345982392040522594123776 * (2:real) pow 100),
    real_of_int q / (1393796574908163946345982392040522594123776 * (2:real) pow 100))` by
    (REWRITE_TAC [source_pair_value_def,pair_value_def,complex_scalar_lmul,complex_mul,conj,RE,IM,
      pairTheory.FST,pairTheory.SND,pairTheory.PAIR_EQ,real_of_int_num,GSYM REAL_OF_NUM_POW] >>
     SIMP_TAC bool_ss [Abbr`p`,Abbr`q`,real_of_int_mul,real_of_int_add,real_of_int_sub,real_of_int_num] >>
     conj_tac >> CONV_TAC RealField.REAL_RAT_REDUCE_CONV >> RealField.REAL_ARITH_TAC) >>
  ASM_REWRITE_TAC [] >>
  mp_tac (Q.SPEC `source_pair_value ((2:num)**100) (raw_head (&c) (U0,U1) (V0,V1)) -
    (real_of_int p / (1393796574908163946345982392040522594123776 * (2:real) pow 100),
     real_of_int q / (1393796574908163946345982392040522594123776 * (2:real) pow 100))` modu_le_coordinate_sum) >>
  REWRITE_TAC [source_pair_value_def,pair_value_def,raw_head_def,complex_sub,complex_add,complex_neg,
    RE,IM,pairTheory.FST,pairTheory.SND,real_of_int_num,GSYM REAL_OF_NUM_POW,GSYM real_sub] >>
  UNABBREV_ALL_TAC >>
  RealField.REAL_ASM_ARITH_TAC
QED
