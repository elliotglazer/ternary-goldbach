(* Source-only experiment.  No evaluator or kernel changes.
   The new quotient is used only at a strictly positive denominator. *)
Theory RoundSpecialization
Ancestors BlockRound DependentBlock integer arithmetic
Libs intLib

val _ = intLib.prefer_int ();

val normalize_int = DEPTH_CONV (CHANGED_CONV (fn tm =>
  if type_of tm = ``:int`` then intLib.INT_POLY_CONV tm
  else raise mk_HOL_ERR "RoundSpecialization" "normalize_int" "not an integer"));

(* For -(a+1), use the ordinary natural quotient of a.  The remainder
   d-1-(a MOD d) belongs to [0,d); MOD occurs in this proof, not in the
   executable replacement below. *)
Theorem positive_den_negative_successor:
  !a d:num. 0 < d ==>
    ((-(&(SUC a)):int) / &d = -&(a DIV d) - 1)
Proof
  rpt gen_tac >> strip_tac >>
  `a = a DIV d * d + a MOD d /\ a MOD d < d` by
    metis_tac [DIVISION] >>
  `(&a:int) = &(a DIV d) * &d + &(a MOD d)` by
    (REWRITE_TAC [INT_ADD,INT_MUL,INT_INJ] >> metis_tac []) >>
  `(&(a MOD d):int) < &d` by ASM_SIMP_TAC int_ss [] >>
  `0 <= (&(a MOD d):int)` by SIMP_TAC int_ss [] >>
  MATCH_MP_TAC INT_DIV_UNIQUE >>
  qexists_tac `(&d:int) - 1 - &(a MOD d)` >>
  SIMP_TAC int_ss [ADD1,GSYM INT_ADD] >>
  RULE_ASSUM_TAC (CONV_RULE normalize_int) >>
  CONV_TAC normalize_int >> intLib.ARITH_TAC
QED

Theorem positive_den_negative_nonzero:
  !a d:num. a <> 0 /\ 0 < d ==>
    ((-(&a):int) / &d = -&((a - 1) DIV d) - 1)
Proof
  rpt gen_tac >> strip_tac >>
  `SUC (a - 1) = a` by DECIDE_TAC >>
  metis_tac [positive_den_negative_successor]
QED

Definition positive_den_div_one_def:
  positive_den_div_one (n:int) (d:num) =
    if n < 0 then -&((Num (-n) - 1) DIV d) - 1
    else &(Num n DIV d)
End

Theorem positive_den_div_one_correct:
  !n:int. !d:num. 0 < d ==> positive_den_div_one n d = n / &d
Proof
  rpt gen_tac >> strip_tac >>
  STRUCT_CASES_TAC (Q.SPEC `n` INT_NUM_CASES) >>
  ASM_SIMP_TAC int_ss
    [positive_den_div_one_def,INT_DIV,positive_den_negative_nonzero]
QED

Definition round_scaled_one_def:
  round_scaled_one (s:int) (r:int) =
    positive_den_div_one (2*r+s) (Num (2*s))
End

Theorem round_scaled_one_correct:
  !s r:int. 0 < s ==> round_scaled_one s r = round_scaled s r
Proof
  rpt gen_tac >> strip_tac >>
  `0 <= 2*s` by intLib.ARITH_TAC >>
  `(&(Num (2*s)):int) = 2*s` by ASM_SIMP_TAC int_ss [] >>
  `0 < (&(Num (2*s)):int)` by intLib.ARITH_TAC >>
  `0 < (Num (2*s):num)` by FULL_SIMP_TAC int_ss [] >>
  ASM_SIMP_TAC int_ss
    [round_scaled_one_def,positive_den_div_one_correct,round_scaled_def]
QED

Theorem round_scaled_one_residual:
  !s r:int. 0 < s ==>
    -s <= 2*(r-round_scaled_one s r*s) /\
    2*(r-round_scaled_one s r*s) < s
Proof
  metis_tac [round_scaled_one_correct,round_scaled_residual]
QED

(* The three products and their presums are exactly those of BlockRound.
   In particular the sign branch uses 2*r+s, not r. *)
Definition rounded_butterfly_one_def:
  rounded_butterfly_one (s:int) (ur,ui) (vr,vi) (wr,wi) =
    let t = wr*(vr+vi);
        u = vi*(wr+wi);
        v = vr*(wi-wr);
        qr = round_scaled_one s (t-u);
        qi = round_scaled_one s (t+v)
    in ((ur+qr,ui+qi),(ur-qr,ui-qi))
End

Theorem rounded_butterfly_one_correct:
  !s u v w. 0 < s ==>
    rounded_butterfly_one s u v w = rounded_butterfly s u v w
Proof
  rpt gen_tac >> strip_tac >>
  PairCases_on `u` >> PairCases_on `v` >> PairCases_on `w` >>
  ASM_SIMP_TAC bool_ss
    [rounded_butterfly_one_def,rounded_butterfly_def,LET_THM,
     round_scaled_one_correct]
QED

Theorem rounded_butterfly_one_residual:
  !s u v w. 0 < s ==>
    local_residual s u v w (rounded_butterfly_one s u v w)
Proof
  metis_tac [rounded_butterfly_one_correct,rounded_butterfly_residual_pairs]
QED
