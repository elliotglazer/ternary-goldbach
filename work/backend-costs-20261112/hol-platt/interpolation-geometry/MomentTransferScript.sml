open HolKernel Parse boolLib bossLib;
open arithmeticTheory realTheory listTheory pairTheory;

val _ = new_theory "MomentTransfer";

(* A row includes the target with weight 1 and every node with its
   negative normalized interpolation weight. *)
Definition row_def:
 (row ([]:(real # real) list) (f:real->real) = 0) /\
 (row (z::zs) f = FST z * f (SND z) + row zs f)
End

Definition absolute_row_def:
 (absolute_row ([]:(real # real) list) (f:real->real) = 0) /\
 (absolute_row (z::zs) f = abs(FST z) * f (SND z) + absolute_row zs f)
End

Definition series_def:
 (series 0 (d:num->real) (v:num->real) = 0) /\
 (series (SUC k) d v = series k d v + d k * v k)
End

Definition polynomial_def:
 polynomial k d x = series k d (\m. x pow m)
End

Theorem row_add:
 !zs f g. row zs (\x. f x + g x) = row zs f + row zs g
Proof
 Induct >> simp [row_def,REAL_LDISTRIB] >> realLib.REAL_ARITH_TAC
QED

Theorem row_scale:
 !zs c f. row zs (\x. c * f x) = c * row zs f
Proof
 Induct >> simp [row_def,REAL_LDISTRIB] >> realLib.REAL_ARITH_TAC
QED

Theorem row_zero:
 !zs. row zs (\x. 0) = 0
Proof
 Induct >> simp [row_def]
QED

fun see s (g as (_,t)) = (print(s ^ " " ^ term_to_string t ^ "\n"); ALL_TAC g);
Theorem signed_moments:
 !k zs d. row zs (polynomial k d) =
 series k d (\m. row zs (\x. x pow m))
Proof
 Induct >- (map_every qx_gen_tac [`zs`,`coef`] >> see "base" >>
   `polynomial 0 coef = (\x:real. 0:real)` by simp [FUN_EQ_THM,polynomial_def,series_def] >>
   see "base-fun" >> ASM_REWRITE_TAC [row_zero,series_def]) >>
 map_every qx_gen_tac [`zs`,`d`] >> see "succ" >>
 `polynomial (SUC k) d =
   (\x. polynomial k d x + d k * x pow k)` by simp [FUN_EQ_THM,polynomial_def,series_def] >>
 see "polysucc" >> ASM_REWRITE_TAC [series_def] >> BETA_TAC >> see "normalized" >>
 PURE_REWRITE_TAC [BETA_RULE (Q.SPECL [`zs`,`polynomial k d`,`\x:real. d k * x pow k`] row_add)] >>
 PURE_REWRITE_TAC [BETA_RULE (Q.SPECL [`zs`,`d k:real`,`\x:real. x pow k`] row_scale)] >>
 see "distributed" >> ASM_REWRITE_TAC []
QED

Theorem row_error:
 !zs f g e. (!x. abs(f x - g x) <= e x) ==>
  abs(row zs f - row zs g) <= absolute_row zs e
Proof
 Induct >- simp [row_def,absolute_row_def] >>
 rpt gen_tac >> strip_tac >>
 `abs(row zs f - row zs g) <= absolute_row zs e` by metis_tac [] >>
 PURE_REWRITE_TAC [row_def,absolute_row_def] >>
 `FST h * f (SND h) + row zs f - (FST h * g (SND h) + row zs g) =
   FST h * (f (SND h) - g (SND h)) + (row zs f - row zs g)` by realLib.REAL_ARITH_TAC >>
 ASM_REWRITE_TAC [] >>
 irule REAL_LE_TRANS >> qexists_tac `abs(FST h*(f(SND h)-g(SND h))) + abs(row zs f-row zs g)` >>
 conj_tac >- metis_tac [ABS_TRIANGLE] >>
 PURE_REWRITE_TAC [ABS_MUL] >> irule REAL_LE_ADD2 >>
 conj_tac >- (irule REAL_LE_LMUL_IMP >> simp [ABS_POS]) >> ASM_REWRITE_TAC []
QED

Theorem series_majorant:
 !k d D v. (!m. abs(d m)<= D m) ==>
 abs(series k d v) <= series k D (\m. abs(v m))
Proof
 Induct >- simp [series_def] >>
 map_every qx_gen_tac [`coef`,`bound`,`vals`] >> strip_tac >>
 `abs(series k coef vals) <= series k bound (\m. abs(vals m))` by metis_tac [] >>
 PURE_REWRITE_TAC [series_def] >> BETA_TAC >>
 irule REAL_LE_TRANS >>
 qexists_tac `abs(series k coef vals) + abs(coef k * vals k)` >>
 conj_tac >- metis_tac [ABS_TRIANGLE] >>
 irule REAL_LE_ADD2 >> conj_tac >- ASM_REWRITE_TAC [] >>
 PURE_REWRITE_TAC [ABS_MUL] >> irule REAL_LE_RMUL_IMP >> simp [ABS_POS]
QED

Theorem stencil_taylor_error:
 !zs f k d D e. (!m. abs(d m)<=D m) /\
 (!x. abs(f x - polynomial k d x) <= e x) ==>
 abs(row zs f) <=
 series k D (\m. abs(row zs (\x. x pow m))) + absolute_row zs e
Proof
 map_every qx_gen_tac [`zs`,`f`,`k`,`d`,`bound`,`e`] >> strip_tac >> see "startbound" >>
 `abs(row zs f - row zs (polynomial k d)) <= absolute_row zs e` by metis_tac [row_error] >> see "err" >>
 `abs(row zs (polynomial k d)) <= series k bound (\m. abs(row zs (\x. x pow m)))` by
   (PURE_REWRITE_TAC [signed_moments] >>
    mp_tac (BETA_RULE (Q.SPECL [`k`,`d:num->real`,`bound:num->real`,`\m. row zs (\x. x pow m)`] series_majorant)) >>
    ASM_REWRITE_TAC []) >>
 see "series" >> mp_tac (Q.SPECL [`row zs f - row zs (polynomial k d)`,`row zs (polynomial k d)`] ABS_TRIANGLE) >>
 simp [REAL_SUB_ADD] >> realLib.REAL_ASM_ARITH_TAC
QED

Theorem series_sum:
 !k d v. series k d v = sum (0,k) (\m. d m * v m)
Proof
 Induct >> simp [series_def,realTheory.sum]
QED
val _ = export_theory();






