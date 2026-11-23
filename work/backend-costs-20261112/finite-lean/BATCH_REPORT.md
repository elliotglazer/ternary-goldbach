# Stock-Lean batched prime certificate

13 November 2026 UTC. The new bounded batch proof compiles and proves the same
1,537-node Lucas certificate graph, all 393 requested root primes and the closed
1,024-target binary Goldbach interval. It is slower to recheck than the earlier
explicit-prime certificate. Three fresh processes give a median
18.516011 elapsed seconds, versus
9.451671 seconds previously,
or 1.959 times as long.
Fewer declarations do not imply cheaper conversion.

## Mathematical result

`FiniteBatch1024.complete` proves a conjunction of primality for every member
of `BatchData1024.roots` and

```lean
∀ n : Nat,
  3999999997356537860 ≤ n → n < 3999999997356539908 → n % 2 = 0 →
  ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ p + q = n
```

The final theorem and `BatchPrime.nodeValid_prime` depend on exactly
`propext`, `Classical.choice` and `Quot.sound`. There is no primality premise,
coverage premise, `sorry` or `native_decide` in this certificate.

The Boolean checker verifies a complete p-1 factor product, smaller factor
labels present in the supplied tree, and the Lucas modular conditions.
Strong induction on p proves primality; merely appearing in the tree is
insufficient. The base case is p=2. Lookup ordering can affect success but
does not allow a successful lookup to return a different prime label.
The generic cover theorem binds each exact pair to its consecutive target.

`audit_batch_data.py` independently parses all generated tree and list
definitions. It matches 1,537 nodes, 7,614 expanded factor occurrences,
393 roots, 1,024 witness pairs and both endpoints against the original fixture.
The pair witnesses use only 231 of the 393 requested roots. The additional
162 preserve the matched fixture; this is not a minimal interval certificate.

## Measurement

| Replay closure | Declarations | Median kernel elapsed seconds | Median whole-process CPU seconds |
|---|---:|---:|---:|
| full | 265 | 18.516011 | 52.187500 |
| primality | 255 | 17.397992 | 48.875000 |
| roots | 2 | 0.297301 | 15.000000 |
| cover | 2 | 0.338538 | 13.953125 |

Full replay samples are 18.6024854, 17.3168339, 18.5160106 seconds. Phase measurements are diagnostic
closures, not components to add blindly to the full time. `roots` checks the
membership Boolean; its soundness also needs the separately proved tree.
`cover` checks the pair/target/membership Boolean; it likewise needs primality
before giving a Goldbach conclusion.

Every replay renames the entire theorem dependency closure within
`FiniteBatch1024`, including generated proof helpers, and rejects surviving
references to the original local theorem names. It submits each declaration
at kernel trust level zero to a fresh extension of the imported environment.
Each fresh process first performs an untimed warmup, then one timed replay.
Generic `BatchPrime`, `PrimeBitmap`, `PrimeSupport`, Mathlib and literal data
definitions remain imported. This is not a fresh check of the whole library.
Kernel-loop timings are elapsed time. Whole-process CPU includes imports,
warmup, the measured replay and process overhead.

Successful construction of the new generic checker, data, eight subtree
modules and final block totals
209.500000 CPU seconds and
268.038147 wall seconds.
This is an incremental project build with prebuilt common support and Mathlib.
It excludes failed attempts, audits, controls and optional replays. The earlier
547.234375-CPU-second project construction also included its common bitmap
bridge build. Different module/import layouts contribute to this construction
comparison, which should not be mistaken for a pure arithmetic speed ratio.

The first single full Boolean proof exceeded the 4 GiB limit. Eight bounded
modules prove leaf subtrees and compose internal nodes through
`treeValid_node`; their successful builds fit the limit. The earlier namespace
collision in generated data was corrected before successful measurements.
Failed attempt receipts remain alongside the successful records.

Five positive and nine negative kernel controls pass. The positive tests cover
a small prime tree, full root membership, full pair coverage, width and endpoint.
False tests cover certificate mutations and coverage errors. Some fail at an
earlier guard, so they do not isolate every check. The helper records success
versus kernel error, not the error kind; false markers alone do not distinguish
definitional failure from a resource failure. The checked source predicates are
false, matching positive controls pass, and all process caps are recorded.

## Consequence

HOL's batched primality speedup does not transfer to this stock-Lean
implementation. Retain the earlier explicit-prime form when replay time is
the objective; account for this alternative's cheaper measured construction
when first admission is the objective. Neither result estimates production
source reuse, a dense prime ladder, full finite coverage or the spectral work.
Further finite tuning has lower priority than a complete actual source-to-sign
block and its input/setup costs.

Reproduce the checks with `audit_batch_data.py`, `summarize_batch.py` and this
report writer. `run_batch_measurements.py` documents the fresh-run sequence;
its labels are exclusive and should not overwrite existing evidence.
`BATCH_RESULTS.json` retains every sample, build component and limitation.
