Theory TranslationWeights
Ancestors DirectTranslate combinatorics arithmetic list
Theorem starting_weight:
 !n. 0<n ==> !k. choice n k=binomial n k
Proof
 gen_tac >> strip_tac >> Induct_on `k`
 >- simp[choice_def,binomial_n_0] >>
 asm_rewrite_tac[choice_def,ADD1] >> metis_tac[binomial_right,MULT_COMM,ADD1]
QED
Theorem descending_weight:
 !m k. 0<m ==> (binomial m k*(m-k)) DIV m=binomial (m-1) k
Proof
 metis_tac[binomial_up,MULT_COMM]
QED