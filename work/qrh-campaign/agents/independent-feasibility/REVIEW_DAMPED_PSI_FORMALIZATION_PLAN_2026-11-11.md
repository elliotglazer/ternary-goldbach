# Independent review of the damped psi formalization plan

2026-11-11. **PASS at paper-proof and inspected-source-API scope.** No correction is required. The plan supplies valid finite real-abscissa Abel and finite Gaussian-tail arguments, and connects them to the actual source interfaces without adding a spectral assumption. It does not supply elaborated Lean declarations or certify the remaining spectral inputs.

Reviewed author artifact: `major-constants/DAMPED_PSI_FORMALIZATION_PLAN_2026-11-11.md`, SHA256 `E76C233D730A9E3A9FEECCDDE50B6C5620BEFD0D14CB9FACFAF94AB9F707B01E`. This review read that complete frozen file. The accepted numerical and source composition remains the separate `REVIEW_PSI_DAMPED_SHARED_STRIP_2026-11-11.md`, SHA256 `7D1315865B59B1CA84A8AB0676FF698121B665F54E2F84F81FFEA0A1B6FC7537`. Its receipts were not changed or rerun.

Only source reads and hash checks were performed in this review. There were no builds, declarations, analytic evaluations, spectral scans, dependency changes, or edits to author files.

## Newly supplied finite Abel proof

The existing `sum_mul_eq_sub_sub_integral_mul` uses natural indices and floor endpoints. It cannot be applied to actual zero ordinates by rounding them. The proposed replacement uses arbitrary real abscissae and a finite weighted count, which preserves the intended weights.

For one atom at `g`, the integral of `f'(t)*1_{g<=t}` over `[a,b]` is respectively `f(b)-f(a)`, `f(b)-f(g)`, or zero in the cases `g<=a`, `a<g<=b`, and `b<g`. The hypotheses provide continuity and interval integrability on every subinterval and the derivative on its interior. The atom identity therefore holds for signed weights as well as nonnegative ones. Summing the identities and using `integral_finsetSum` gives the stated formula.

The proof explicitly handles `g=a`, `g=b`, and `a=b`. The source `intervalIntegral.integral_indicator` is a left-ray theorem, while this atom uses a right ray. Subtracting the left-ray integral and using equality almost everywhere outside the singleton `{g}` is valid for volume. It avoids a false pointwise equality at the atom. Integrability follows by restricting an integrable continuous function to a measurable half-line, not by claiming that the discontinuous indicator product is continuous.

For the comparison lemma, retain the exact term `-f(a)N_S(a)`. The two other replacements follow from `f(b)>=0`, `-f'>=0`, and `N_S<=C`. Integration by parts yields exactly

`f(a)*(C(a)-N_S(a)) + integral_a^b f*C'`.

The optional upper-endpoint correction has the stated minus sign. Nonnegative weights are harmless additional assumptions for this comparison; the identity itself does not need them. No separate sign assumption on `C'` is needed for this step. Its positivity is supplied later when enlarging the particular damped integral.

The zeta application requires a complete positive carrier through `b`, not an arbitrary explicit-formula subset. Then its finite count agrees with the actual closed count on `[a,b]`, and in particular with the exact head count at `A`. The plan places completeness before comparison and does not substitute a partial count into that lower endpoint.

## Finite Gaussian tails

Both finite tail statements hold for every `W>=1`, including equality. Under `w=v^2`, the first integral becomes one half of the integral of `exp(-w/2)/w`. Enlarging the upper endpoint to `S=max(W^2,2)` is valid by nonnegativity. The two elementary comparisons give the exact evaluated upper bound

`exp(-1) - exp(-S/2)/2 <= exp(-1)`.

For the second integral, `log(v)<=v^2/2` and positivity of the remaining factors give the antiderivative bound `(exp(-1/2)-exp(-W^2/2))/2`. All integrands and substitutions are on compact intervals away from zero. The local-image continuity version `integral_comp_mul_deriv'` has exactly the needed domain; the global-continuity variant would impose an unsuitable condition at zero.

In the scaled statement, `c>0`, `A>c`, and `delta*A<=1` imply `R=1/delta>=A` and `Z=log(R/c)>0`. Thus enlarging `V` to `max(V,R)` and multiplying the tail bounds by `Z` preserve their direction. Splitting at `R` and using `v=delta*t` gives exactly

`(Z^2-ell^2)/2 + Z*exp(-1) + exp(-1/2)/2`.

The separate reciprocal-square integral is at most `1/A`. With the analytic count derivative these are precisely the previously accepted `Dbar` terms. No infinite-limit interchange or improper-integral convergence result is necessary for this version of the proof, and the constant has not changed.

## Multiplicity, symmetry, and the source limit

`Finset.sum_nbij'` supports the proposed finite involution identity with both maps equal to `J`. Closure on the carrier, both inverse identities there, and equality of weighted summands must all be supplied. The resulting average includes fixed points with their full weights.

The plan correctly separates the holomorphic reflection `z -> 1-z` from complex conjugation. `analyticOrderAt_comp_of_deriv_ne_zero` supports the former but cannot be applied to the latter. Conjugating the local Taylor factorization gives an analytic factor through its conjugated convergent power series and preserves the nonzero leading factor, so it preserves the finite order. That is a valid paper proof of the missing conjugation helper, not a claim that a ready-made source theorem already implements it.

For the actual carrier, the auxiliary height must exceed the closed cutoff. The stated strict inner-disk inclusion and existing `mem_zerosIn_of_zeroD`, instantiated with `ldatum_zeta`, provide completeness. Existing divisor/order identities then identify the natural weights with genuine multiplicities. The retained RH head and `xiF_half_ne_zero` exclude the real-axis case before division by the ordinate and sign doubling. An arbitrary finite prefix is enlarged only after taking a nonnegative norm majorant. There is no claim that the prefix itself is reflection-invariant.

The actual `explicit_formula_zeta_seq` is a convergence theorem for finite sums along `goodSeqD`. A uniform norm bound for those sums passes to the limit through continuity of norm and `le_of_tendsto'`, exactly as the inspected source pattern in `PsiExplicit` does. The separate high-zero estimate is used on each finite prefix. Neither absolute convergence of an infinite zero series nor shared-strip information above the finite cutoff is introduced.

The source upper and lower sandwich lemmas consume an absolute error. Multiplying the normalized bound by `x` before applying them is necessary and is explicit in the plan. The positive upper denominator and the differing upper/lower parameter hypotheses remain to be supplied. The source pole term, principal smooth sum, and vertical integral are not omitted.

## Continuum helpers and source status

The product-derivative approach is valid and avoids unnecessary logarithms. Positivity of the factors allows multiplication of derivative bounds; the constant-plus-function step additionally needs the stated nonnegative rate. These conditions hold for the two concrete positive brackets. The formula `q=1/(500000*L^2*(L+10))` agrees with `delta^2/2`. The cosh derivative and `0<=sinh(t)<=cosh(t)` for nonnegative arguments yield the claimed derivative comparison. Closed-interval continuity plus the inspected convex-set antitonicity theorem gives the endpoint maximum. No derivative outside the interval is required.

I inspected the actual signatures for natural-index Abel summation, finite reindexing, continuous interval integrability, finite integral sums, the indicator and almost-everywhere equality rules, both integral comparison rules, FTC, integration by parts, local substitution, and antitonicity. The six Mathlib source hashes in the author table all match. The following additional source hashes were checked during this review:

| File, relative to the indicated source root | SHA256 |
|---|---|
| Mathlib `Analysis/Analytic/Order.lean` | `2426AEF2574C3DF5758D40D81DD33A6A62E07235F2B7B3F980512D4E80FDF46C` |
| Mathlib `Analysis/SpecialFunctions/Trigonometric/DerivHyp.lean` | `B8FED41002209FE4FFE7F04E0E5C4472926129B16CD1CAE7AC0B899CDFA14E54` |
| Mathlib `Analysis/Complex/Trigonometric.lean` | `9468650BCC82E9D3B944E663C03D242CE88D1DBDE6D672D71B42DA8CEE7391C6` |
| TernaryGoldbach `Explicit/Datum.lean` | `42F14B373106D5508F73080BEC1E57992FDCBCB7A0460182AD396534463ACDDE` |
| TernaryGoldbach `Explicit/WeilBridge.lean` | `285F825F4916B8D8F40256090F56E773140AB2FC2C48E3F057F68A838E17C73E` |
| TernaryGoldbach `Explicit/GaussSmooth.lean` | `40ACFCF56E61C411BAF8DD3E7B5504B3DB48F34740B256A4D03F1CDBE37FEBA8` |
| TernaryGoldbach `Explicit/ZetaExplicit.lean` | `A2252356B4A2FCE4BC0B2B0EFF9A26B43DFAEBA9B05DB94BFEAA444A423B94E2` |
| TernaryGoldbach `Explicit/PsiExplicit.lean` | `33A24C9E1606011AAC8930EC978BA027E90A2A66E0888DB18915ACC2FBF85BB1` |
| TernaryGoldbach `Explicit/PsiLarge.lean` | `D370555A164DA01E37E5BDB14EFA774DC79FE43682EED21D42C90BA2D1B165F2` |

The cached Mathlib root is `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib`; the target source root is `work/ternary-goldbach/TernaryGoldbach`. Source availability and matching signatures do not prove that a future implementation elaborates under the target imports.

The plan's new helpers still need Lean proofs, concrete source-weight casts and carrier adapters, scalar certificate replay, and final assembly. The retained head and shared strip still need their formal certificate work; the genuine global provider and transitive axiom checks retain their separate status. No extra assumption is needed by the newly supplied finite proofs. This is an accepted implementation plan with paper proofs of its new analytic helpers, not an implementation-completion claim.
