# Disjoint explicit-bounds proof alternative

Prepared while map04 is active. No active source, run, or process was changed. This is an uncompiled tactic proposal, not a diagnosis that the running proof has failed. The saved-definition marker alone does not identify the current tactic.

The current final `metis_tac [LESS_EQ_TRANS]` sees the general induction hypothesis, partition facts and arithmetic relations. The following replacement restricts the proof to one partition-length theorem application, two explicit transitivity applications, and two induction-hypothesis instantiations. It changes neither the statement nor the recursion. It may be applied only after the current attempt is terminal and the coordinator has reviewed it.

```
Proof
  Induct_on `fuel`
  >- (Cases_on `xs` >> simp [map_num_qsort_fuel_def, QSORT_DEF])
  >> gen_tac >> strip_tac
  >> Cases_on `xs`
  >- simp [map_num_qsort_fuel_def, QSORT_DEF]
  >> rename1 `LENGTH (h::t) <= SUC fuel`
  >> `LENGTH t <= fuel` by fs []
  >> Cases_on `PARTITION (\y:num. y <= h) t`
  >> rename1 `PARTITION (\y:num. y <= h) t = (l1,l2)`
  >> qpat_x_assum `PARTITION (\y:num. y <= h) t = (l1,l2)`
       (fn part_eq =>
         let
           val part = REWRITE_RULE [PARTITION_DEF] (SYM part_eq)
           val bounds = MATCH_MP
             (Q.SPECL [`\y:num. y <= h`, `t`, `[]`, `[]`, `l1`, `l2`]
               PART_LENGTH_LEM) part
         in
           assume_tac part_eq THEN
           strip_assume_tac (SIMP_RULE (srw_ss()) [] bounds)
         end)
  >> `LENGTH l1 <= fuel` by
       (irule LESS_EQ_TRANS >> qexists_tac `LENGTH t` >> asm_rewrite_tac [])
  >> `LENGTH l2 <= fuel` by
       (irule LESS_EQ_TRANS >> qexists_tac `LENGTH t` >> asm_rewrite_tac [])
  >> qpat_x_assum `!xs. LENGTH xs <= fuel ==> _`
       (fn ih =>
         assume_tac (MP (Q.SPEC `l1` ih) (ASSUME ``LENGTH l1 <= fuel``)) THEN
         assume_tac (MP (Q.SPEC `l2` ih) (ASSUME ``LENGTH l2 <= fuel``)))
  >> asm_rewrite_tac [map_num_qsort_fuel_def, QSORT_DEF]
QED
```

`ASSUME` here refers to the two exact local inequalities just proved; it does not add a new public premise. If generated case-variable names or equality orientation differ, only the local matching syntax should be adapted after observing a terminal build. Do not replace a missing bound by an assumption.

The source reference is `sortingTheory.PART_LENGTH_LEM`, with argument order `P,L,l1,l2,p,q`, giving each output length at most `LENGTH L + LENGTH l1 + LENGTH l2`. The two initial accumulators are empty. `arithmeticTheory.LESS_EQ_TRANS` has the exact premise `m <= n /\ n <= p`, so there is no need for general transitivity search. Only after the two recursive results are established does the final rewrite expand the nonempty QSORT equation.

The active source remains SHA256 `5E18B255AD5B22D1AE56DE083F68206E99DCDF1927D7FA0F068AE4B41126CA05`. The helper proof, translation, and finite evaluation costs remain separate and unmeasured by this preparation.
