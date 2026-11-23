# Map03 quicksort specialization repair

13 November 2026. Source-only successor for coordinator review. No build, finite evaluation, or generator run was performed by this author. The proposed helper proofs and translation still need a successful build.

Map03 passed the earlier numerical identity translation point and translated coordinates, labels, and their list checks. It then failed while automatic specialization attempted to define `QSORT____unit_map_1_def`. Its generated recursion had two sublists from PARTITION; automatic HOL termination could not establish their decrease. This occurs before evaluating the finite map and does not refute any map assertion.

The successor adds a natural-list quicksort adapter. It uses the same pivot, the same `PARTITION (\y. y <= h) t`, and the same concatenation order as stock `QSORT`. An explicit natural fuel argument decreases on both recursive calls. Fuel zero returns the empty list, but that branch cannot truncate a public result: the public wrapper starts with `LENGTH xs`, and the proposed generic proof establishes

```
LENGTH xs <= fuel ==>
  map_num_qsort_fuel fuel xs = QSORT ($<=) xs.
```

The proof is by fuel induction. On a nonempty list, stock `PART_LENGTH_LEM`, through `PARTITION_DEF`, bounds both partition lengths by the tail length. Each therefore fits within the predecessor fuel. Empty lists and fuel zero are explicit. This proves exact equality, not merely sortedness or a permutation relation. A `[cv_inline]` theorem rewrites the original `QSORT ($<=) xs` to the wrapper only after that proof.

All existing definitions, including `finite_checks`, remain byte-identical. All final theorem statements and proofs remain byte-identical. Removing the inserted adapter block and its explicit translation call recovers the complete map03 source. No supplied sorted data, new hypothesis, or weaker coverage predicate is introduced. The existing check comparing QSORT's result with the independent gcd-filtered list is still the asserted source proposition.

## Why this form

The inspected `cv_transLib.sml` first constructs a HOL specialization for higher-order arguments. Its `inst_ho_args` uses an automatically terminated temporary definition. Supplying a CV termination tactic only to the outer `finite_checks` translation does not repair that earlier HOL specialization failure.

A directly recursive natural-only quicksort would solve that first issue, but its encoded CV recursion could still require a separate partition-size theorem. The fuel adapter makes termination explicit at both levels. Its HOL definition uses `measure FST`; CV translation then sees a decreasing numerical fuel instead of relying on the size of encoded partition outputs. No special termination oracle or admitted theorem is used. Translation may still expose unrelated library obligations; this source change does not predict a successful whole build.

The stock references read for this design are `sortingScript.sml:655–674` for PART length bounds and `:740–758` for PARTITION/QSORT and the original measure proof; `cv_transLib.sml:102–130` for CV definition/termination handling, `:737–797` for higher-order specialization, and `cv_repLib.sml:203–204` for proved inline rewriting. These belong to the pinned HOL checkout.

## Cost and evidence boundary

This introduces a generic helper definition, generic correctness proof, inline transport theorem, and one explicit helper translation before the finite check. Their construction/translation cost must be distinguished from finite map evaluation when reading the next log. Fuel decrement/branch work is part of this executable adapter; it is not a free or faster-sort claim. No dependency build is authorized. The unchanged runner retains the existing per-phase resource bounds.

The layout author was warned that source `GENLIST I` needs the proved identity registration. Any later layout using QSORT must likewise consume an actually compiled adapter or prove its own connection. It cannot treat this pending source note as theorem evidence.

The previous source and map03 outer/inner logs are preserved under `history/map03_qsort_translation/` with a hash manifest. Previous run receipts are untouched.

| Artifact | SHA256 |
| --- | --- |
| map03 source | 1915881A88C625BD70ED70F6F86DFBA80368D4A2C13C3F45777BD3A570D338BE |
| Successor C10004MapScript.sml | 5E18B255AD5B22D1AE56DE083F68206E99DCDF1927D7FA0F068AE4B41126CA05 |
| map03_theory.log | F0D6C6F9F04668463272D97E2FB2ECB6A0069B406961BE260C7A4A28A709D3E0 |
| map03_theory.time | 2C40D5F78565CE45FA6B4D9A14E75F79318CD88FAD5D08CF97FAFBB2CD44B9D2 |
| Archived inner theory log | B71F307834DA3EBEEB38E12B6C2BD5697CFA495A2BD1A7B12CDE84D8D77544AC |
| sortingScript.sml | 47F7E4CC622495E5D5A58A75E9D28F8F7A5F47C576D086C4D38DA053D83EFFD4 |
| cv_transLib.sml | 182DABE3CDFD677E1EC8ED4DDD0E8EA3F6D6584D801CAE7F13EE01A203C5647F |
| cv_repLib.sml | 4B1ADF399CA233B0B1394CA6A6D1F8063D4AF793D72435308BB5D123B268F66C |

This is a source repair, not a compiled finite-map, character, or DFT result.
