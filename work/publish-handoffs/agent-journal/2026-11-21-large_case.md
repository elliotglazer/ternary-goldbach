# large case — 2026-11-21

## 22:15:26 UTC · Final

I estimate a conditional 90% range of **2–14 calendar days and 20–200 allocated core-hours** for the large-only consumer and final proof check. This assumes a dedicated engineer, warm caches, sufficient memory, and a usable GRH artifact. Rebuilding GRH from source would add a separate cost.

The latest native progress receipt records 20 modules passing before `GaussInduced` failed. Two independent checkers accepted the export-link control. The full major- and minor-arc imports and final GRH application remain unverified. The interval reflects engineering judgment anchored to a related 34-core-hour build.

## 22:17:27 UTC · Final

The `GaussInduced` failure predates the repair in `version_headers.py`. A later receipt confirms that the original module compiled on Lean 4.35. I found no receipt confirming the repaired module on 4.33.1.

The next build should use the latest compatibility generator and target `GoldbachLargeOfDirichletGRH`. That target supplies the consumer proof needed to apply the verified GRH export. The actual joined proof still needs kernel checking and an axiom audit.

## 22:21:37 UTC · Final

The first missing dependency in the current consumer build is `TernaryGoldbach.Explicit.XiPartial`. Lean 4.33.1 failed at line 680 because `completedRiemannZeta_conj` is unavailable, leaving the conjugation identity for `xiF` unproved. The backport already contains compiled artifacts for `GaussInduced` and `FullGRH`.

## 22:27:11 UTC · Final

`TernaryGoldbach.Explicit.XiPartial` now compiles on Lean 4.33.1. I backported the two missing conjugation lemmas from the project’s pinned Mathlib and registered the compatibility import. The compiled `XiPartial.olean` has SHA-256 `b71f0bf0cd215f3625fb36589fbc49ed233cae0dbb9204ea249b016a46de1594`.

Lean reports only `propext`, `Classical.choice`, and `Quot.sound` for `completedRiemannZeta_conj`, `xiF_conj`, and `logDeriv_xiF_conj`. [Axiom receipt](../../../work/grh-goldbach-20261120/team/large/xi-partial-axioms.log)

## 22:37:51 UTC · Final

The repaired consumer build advanced through `ZeroFree`, `ZeroFreeRegion`, `PsiPlateau`, and `PsiAsymp`. Both the full build and a focused rerun failed at `Explicit/WeilLines.lean:102` because Lean 4.33.1 lacks `Complex.digamma_apply_add_nat`. The remaining goal is `‖digamma (s / 2)‖ ≤ 8 * ‖s‖ + 60` for `1/2 ≤ s.re ≤ 3/2`. The single-worker build stopped there.

## 22:41:58 UTC · Final

`TernaryGoldbach.Explicit.WeilLines` compiled on Lean 4.33.1 using the upstream proof of `Complex.digamma_apply_add_nat` with its original hypotheses. The compiled module’s SHA-256 is `53640edd7bb99cd74a8dab81db92134901ddd340600a80ac4785b5fd276d1b6d`.

Lean reported only `propext`, `Classical.choice`, and `Quot.sound` for the recurrence, `norm_digamma_half_strip`, and `integrable_WP_three_halves`. [Axiom receipt](../../../work/grh-goldbach-20261120/team/large/weil-lines-axioms.log)
