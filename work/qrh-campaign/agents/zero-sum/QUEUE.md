# Validation queue

Status: all Lean drafts in this directory are uncompiled. Independent mathematical review passed for the original strip-count derivation, unconditional low-zero bound, and fixed-gap argument. The new `sum_mult_zeta_low_sharp_le` uses the parent's checked logarithmic-count calculation and still needs term-level validation. No compiler is owned by this worker.

Integration is building the original pinned project closure, serially, into `../integration/artifacts`. Last confirmed progress: LogDerivL (12/31) passed in 455.3 seconds; ExplicitFormula (13/31) was running. Integration will extend the closure by five modules, to 36, including ZetaLowZeroFree. No import narrowing has been applied. Wait for explicit compiler-slot handoff before running Lean.

On reactivation, run the prepared `check_scratch.py` with arguments, in this order:

    ZeroSumStrip ZetaLowUnconditional ZeroFreeFixedGap Audit

The script uses Lean v4.35.0 with `-j 2`, the shared artifacts, compatible pre-existing package artifacts, and this directory's own artifacts. It writes only this directory's `artifacts/` and `logs/`. Stop on the first error, repair the exact proof while preserving its statement, and rerun the necessary target. Run `Audit` only after all three imports compile. Report actual exit codes, theorem axiom output, and any remaining failures. No upstream source edits, sorries, axioms, dependency changes, or full builds.

The new tight count API is:

    sum_mult_zeta_low_sharp_le {T : Real} (S : Finset Complex)
      (hS : S subset zerosRectD zetaF T)
      (hre : forall u in S, 0 <= u.re and u.re <= 1)
      (him : forall u in S, abs u.im <= 1e8)
      : sum u in S, (multRectD zetaF T u : Real) <= 3e10

The file uses normal Lean Unicode notation. All earlier coarse count APIs remain unchanged. The new count follows from log_BPz2_le', logarithm arguments below 1.3e8 <= exp19, numerator <= 200.24, denominator >= 1/2, ZStrip <= 401, and Jl <= 3e7.

The prime-estimates worker's saved fixed-gap and range assemblies consume these files. Coordinate artifact paths and validated APIs with the parent and that worker after successful compilation. The fixed-gap provider remains `zeta_zero_re_le_fixed`: genuine nontrivial zeta zero with abs(im)<=1e8 implies re<=249/250. Its unconditional height-floor dependency is `abs_im_ge_of_nontrivial_zero`, giving abs(im)>=2.39. Independent fixed-gap draft hash before subsequent unrelated count edits was 1DECBC841B33388BCAD64C0B66E3C0FBECB818A376EBB40F1188C103F14FFFA0.

This is a far-asymptotic/adjacent-range psi sublemma route. It does not close the original full Goldbach objective or the major-arc estimates.

