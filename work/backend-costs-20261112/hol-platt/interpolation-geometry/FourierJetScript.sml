open Diff;
open HolKernel Parse boolLib bossLib;
open arithmeticTheory realTheory transcTheory limTheory listTheory;
val _ = new_theory "FourierJet";

Definition wave_def:
 wave (w:real) a b = (\x. a * cos(w*x) + b * sin(w*x))
End

Theorem wave_diffl:
 !w a b x. (wave w a b diffl wave w (w*b) (-(w*a)) x) x
Proof
 rpt gen_tac >> PURE_REWRITE_TAC [wave_def] >> BETA_TAC >>
 (fn g as (_,t) =>
   let val th = SPEC (rand t) (Diff.DIFF_CONV (rand (rator (rator t))))
       val eq = prove(mk_eq(rand(rator(concl th)),rand(rator t)),realLib.REAL_ARITH_TAC)
   in ACCEPT_TAC (SUBS [eq] th) g end)
QED

Definition modejet_def:
 (modejet 0 (w:real) a b = wave w a b) /\
 (modejet (SUC r) w a b = modejet r w (w*b) (-(w*a)))
End

Theorem modejet_diffl:
 !r w a b x. (modejet r w a b diffl modejet (SUC r) w a b x) x
Proof
 Induct >- (PURE_REWRITE_TAC [modejet_def] >> ACCEPT_TAC wave_diffl) >> rpt gen_tac >> RULE_ASSUM_TAC (PURE_REWRITE_RULE [modejet_def]) >> PURE_REWRITE_TAC [modejet_def] >> first_x_assum MATCH_ACCEPT_TAC
QED

Theorem wave_bound:
 !w a b x. abs(wave w a b x) <= abs a + abs b
Proof
 rpt gen_tac >> simp [wave_def] >>
 irule REAL_LE_TRANS >> qexists_tac `abs(a*cos(w*x)) + abs(b*sin(w*x))` >>
 simp [ABS_TRIANGLE,ABS_MUL] >> irule REAL_LE_ADD2 >>
 conj_tac >> metis_tac [REAL_LE_LMUL_IMP,ABS_POS,REAL_MUL_RID,COS_BOUND,SIN_BOUND]
QED

Theorem modejet_bound:
 !r w a b x. abs(modejet r w a b x) <= (abs a + abs b) * abs w pow r
Proof
 Induct >- (simp [modejet_def,pow] >> metis_tac [wave_bound]) >> PURE_REWRITE_TAC [modejet_def,pow] >>
 rpt gen_tac >> irule REAL_LE_TRANS >>
 qexists_tac `(abs(w*b) + abs(-(w*a))) * abs w pow r` >>
 conj_tac >- metis_tac [] >> PURE_REWRITE_TAC [ABS_NEG,ABS_MUL] >>
 
 realLib.REAL_ARITH_TAC
QED

Definition finitejet_def:
 (finitejet 0 r w a b = (\x:real. 0:real)) /\
 (finitejet (SUC n) r w a b = (\x. modejet r (w n) (a n) (b n) x + finitejet n r w a b x))
End

Theorem finitejet_diffl:
 !n r w a b x. (finitejet n r w a b diffl finitejet n (SUC r) w a b x) x
Proof
 Induct >> rpt gen_tac >> PURE_REWRITE_TAC [finitejet_def] >> BETA_TAC
 >- metis_tac [DIFF_CONST]
 >> irule DIFF_ADD >> metis_tac [modejet_diffl]
QED

fun watch s (g as (_,t)) = (print(s ^ " " ^ term_to_string t ^ "\n"); ALL_TAC g);
Theorem finitejet_bound:
 !n r w a b cap omega. 0<=cap /\ 0<=omega /\
 (!j. j<n ==> abs(a j)+abs(b j)<=cap /\ abs(w j)<=omega) ==>
 !x. abs(finitejet n r w a b x)<= &n * (cap * omega pow r)
Proof
 Induct >- simp [finitejet_def] >>
 map_every qx_gen_tac [`r`,`w`,`a`,`b`,`cap`,`freqcap`] >> strip_tac >> qx_gen_tac `x` >> watch "base" >>
 `!j. j<n ==> abs(a j)+abs(b j)<=cap /\ abs(w j)<=freqcap` by metis_tac [DECIDE ``j<n ==> j<SUC n``] >> watch "range" >>
 `abs(finitejet n r w a b x)<= &n * (cap * freqcap pow r)` by metis_tac [] >> watch "IH" >>
 `abs(a n)+abs(b n)<=cap /\ abs(w n)<=freqcap` by metis_tac [DECIDE ``n<SUC n``] >> watch "atn" >>
 `abs(w n) pow r <= freqcap pow r` by metis_tac [POW_LE,ABS_POS] >> watch "power" >>
 `(abs(a n)+abs(b n))*abs(w n) pow r <= cap*freqcap pow r` by
   (irule REAL_LE_MUL2 >> simp [ABS_POS,REAL_LE_ADD,POW_POS]) >> watch "mul" >>
 `abs(modejet r (w n) (a n) (b n) x)<=cap*freqcap pow r` by metis_tac [modejet_bound,REAL_LE_TRANS] >> watch "mode" >>
 PURE_REWRITE_TAC [finitejet_def,GSYM REAL_OF_NUM_SUC] >> BETA_TAC >>
 mp_tac (Q.SPECL [`modejet r (w n) (a n) (b n) x`,`finitejet n r w a b x`] ABS_TRIANGLE) >>
 realLib.REAL_ASM_ARITH_TAC
QED
Theorem finitejet_taylor:
 !n w a b x k. ?t. abs t <= abs x /\
 finitejet n 0 w a b x =
 sum(0,k) (\m. (finitejet n m w a b 0 / &(FACT m)) * x pow m) +
 (finitejet n k w a b t / &(FACT k)) * x pow k
Proof
 rpt gen_tac >>
 mp_tac (Q.SPECL [`finitejet n 0 w a b`,`\m. finitejet n m w a b`]
    MCLAURIN_ALL_LE) >>
 BETA_TAC >> PURE_REWRITE_TAC [finitejet_diffl] >> metis_tac []
QED
val _ = export_theory();








