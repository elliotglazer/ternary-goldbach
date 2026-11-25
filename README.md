# Ternary Goldbach with the compact GRH proof

This source package targets Lean 4.35.0. Its solution states that every odd natural number above five is the sum of three primes. The arithmetic and analytic argument is assembled in `CompletedFiniteRows.lean`. The final application in `CompletedGoldbach.lean` uses `riemannHypothesis` and `LFunction_eq_zero_re_of_isPrimitive` from the upstream `Main` module.

The `CompactGRH` library builds all 794 modules of Sernau’s compact packaging of Levent Alpöge’s GRH proof with Claude. Each source received a Lean module header and public imports so the Goldbach solution can import `Main`. The upstream and ported SHA-256 hashes are in `CompactGRH/module-source-manifest.json`. The original license, notice and attribution accompany the sources in `CompactGRH/`. Mathlib is pinned to the same commit as the original compact project. [Upstream compact source](https://github.com/leanprover-community/riemann-hypothesis/tree/72fead102f663d5c7a407964a13dc0cf9d977207/grh-compact)

Use `lake build GoldbachSolution` to build the solution and `lake build GoldbachChallenge` to build the independent theorem statement. Comparator inputs appear in `comparator.json`. A protected verification must pin its own trusted statement and comparator configuration.

**Verification in progress.** Full replay of the Goldbach solution on Lean 4.35.0 and protected Comparator verification are pending. The earlier Lean 4.37 port tests are recorded in `verification/build-evidence.md`. The historical Lean 4.33.1 release used different GRH proof artifacts.

Source hashes are in `source-manifest.json`. Historical attribution is in `NOTICE` and the upstream licenses and notices are in `licenses/`.
