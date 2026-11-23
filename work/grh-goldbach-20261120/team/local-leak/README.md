# Gaussian leakage outside the localized prime interval

`GrhGoldbach.LocalLeak.gaussian_leak_difference_0511` in `LeakOutside.lean` applies to every real `x` with `10^15 ≤ x ≤ 10^27`. Write `v = √x`, `δ = 2.8/v`, `a = −4.5δ`, `b = a − 101/v`, and `f n = Λ n · gsm a b δ (n/x)`. The theorem proves

\[
\sum_{n=0}^{\infty} f(n) - \sum_{\lfloor x\exp(-126.2/v)\rfloor<n\le\lfloor x\rfloor} f(n)
\;\le\;0.511v.
\]

`gaussian_leak_0511` in `LeakBound.lean` states the corresponding bound directly for the exterior sum. `finite_gaussian_leak` in `LeakExchange.lean` first bounds every finite subcollection of positive exterior indices, exchanging a finite sum with the integral against the standard normal density. For `|z| ≤ 4.5` the shifted window is inside the stated interval. On its complement, `ShiftCount.lean` bounds the contribution pointwise and the two Gaussian exponential moments bound its integral. `LeakNumeric.lean` proves the final decimal constant by rational inequalities in Lean.

`GaussianSource.lean` reproduces the source from `open Complex Set Filter MeasureTheory` through the definition of `gsm` under the local namespace `GrhGoldbach.GaussianSource`. The upstream definition integrates `gpdf z` from `(b − log u)/δ` to `(a − log u)/δ`. The locally checked module uses the installed Lean 4.35 Mathlib cache. The full upstream project uses its own import graph. [Pinned GaussSmooth.lean](https://github.com/calr3/ternary-goldbach/blob/23b2d68ca344203d4384e0aff7affa4ec034bef9/TernaryGoldbach/Explicit/GaussSmooth.lean)

For a local replay, invoke `python check.py MODULE` for each of `LocalLeak`, `ShiftCount`, `GaussianSource`, `LeakNumeric`, `LeakExchange`, `LeakBound`, and `LeakOutside` in that order. The checker writes each module's source hash, invocation, exit status, and elapsed time to `MODULE.json` and its axiom printout to `MODULE.log`. The final theorem's axiom printout contains `propext`, `Classical.choice`, and `Quot.sound`.
