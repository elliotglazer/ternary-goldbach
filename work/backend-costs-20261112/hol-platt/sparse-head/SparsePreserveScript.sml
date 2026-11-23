Theory SparsePreserve
Ancestors SparseHead sptree arithmetic
Theorem row_preserves_prefix:
 !len b m x s u t t' i. i < b /\ SparseHead$load_row len b m x s u t = SOME t' ==>
    sptree$lookup i t' = sptree$lookup i t
Proof
 Induct >> rpt gen_tac >> simp [SparseHeadTheory.load_row_def] >>
 strip_tac >> gvs[AllCaseEqs()] >>
 metis_tac [sptreeTheory.lookup_insert,DECIDE ``!i b:num. i<b ==> i<SUC b /\ i<>b``]
QED
Theorem grid_preserves_prefix:
 !rows b t t' i. i < b /\ SparseHead$load_grid rows b t = SOME t' ==>
    sptree$lookup i t' = sptree$lookup i t
Proof
 Induct >> rpt gen_tac >- (simp[SparseHeadTheory.load_grid_def] >> strip_tac >> gvs[AllCaseEqs()]) >>
 PairCases_on `h` >> simp[SparseHeadTheory.load_grid_def] >>
 strip_tac >> gvs[AllCaseEqs()] >>
 metis_tac[row_preserves_prefix,DECIDE ``!i b:num. i<b ==> i<b+64``]
QED

