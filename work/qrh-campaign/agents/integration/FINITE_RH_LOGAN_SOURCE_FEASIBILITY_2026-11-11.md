# Source feasibility of the fresh finite-RH prime-gap route

2026-11-11. Bounded source and paper inventory, not a formalization approval, kernel check, or cost measurement. No Lean declarations, builds, special-function evaluations, spectral runs, or existing-file changes were made.

The useful reuse boundary is lower than “an explicit formula is available.” The target has actual principal-zeta contour and zero-order machinery, and its PNT dependency has useful proved-looking I0-series bodies. Neither supplies the required Logan theorem. In particular, the dependency's displayed real Logan definition is not the analytically continued Logan function. The smallest credible Lean project is a new, narrowly parameterized Logan kernel/contour/desmoothing layer above the existing zeta infrastructure, followed by checked head and finite-RH evidence. It must not consume the dependency's placeholder finite-RH theorems.

## 1. Exact prospective consumer

The coordinating scalar derivation is still separate from this inventory. Its communicated parameters are A=10^16, X=10^27, 1<=Q<=50, c=(log x)/2+6, epsilon=(log x)^(5/2)/(Q sqrt x), and finite RH through H=4*10^10 Q. Its proposed ordinary-theta coefficient is a(Q)=.031+2.261/Q. Q=48, H=1.92*10^12, B=2*10^16 is a candidate, not a spectral certificate. The scalar argument is not accepted here, and no published RH bootstrap is imported.

The source consumer is `Helfgott/SmallCases.lean:20–40`: for odd n>B+3, a prime in [n-B,n-4] leaves an even remainder in [4,B]. For 7<=n<=B+3, p=3 suffices. A smaller B is usable with the unchanged original `BinaryGoldbachInput` through 4*10^18 by range weakening. This does not replace or add a hypothesis to the unconditional large ternary root, or silently prove the original binary input. It replaces the prime-ladder ingredient only if the analytic bound and its spectral premises are actually proved.

The proposed theorem must be about the **ordinary** prime-counting weight used by that consumer, or must include a proved endpoint adapter. Half-weight conventions at prime powers, strict versus closed zero heights, both ordinate signs, and analytic multiplicity cannot be inferred from a theorem title.

The paper sources for the new work are [Johnston v2, §2](https://arxiv.org/pdf/2109.02249v2), [Büthe's partial-RH paper v4](https://arxiv.org/pdf/1410.7015v4), and [Büthe's analytic method v2, Proposition 2](https://arxiv.org/pdf/1511.02032v2). Johnston's stated main-theorem bootstraps are outside this proposal. His Lemma 2.2 uses a fixed low-zero calculation at 5000; it is a certificate obligation, not an analytic consequence of high finite RH alone.

## 2. What the inspected APIs actually accept

All paths in this table are relative to `work/ternary-goldbach/TernaryGoldbach/`, except the explicitly labeled OAI/PNT paths. These are source bodies inspected, not claims that their complete dependency closures have been checked in this task.

| Source interface | Actual contract and reuse | Missing Logan join |
|---|---|---|
| `Explicit/ExplicitFormula.lean:51–56`, `GoodSmoothing` | Continuity at positive arguments, Mellin convergence at 3/2, analytic Mellin transform on Re(s)>-1, and a bound K exp(-d abs(Im s)) on [-1/2,3/2], with d>0. `SsumG_eq_line:176` gives the prime series/vertical integral normalization. | Logan's polynomial-decay transform is not a supplied instance of this exponential-decay predicate. A compactly supported kernel is not automatically such an instance. |
| `Explicit/ZetaExplicit.lean:122–179`, `explicit_formula_zeta_seq`, `explicit_formula_zeta` | Actual principal zeta formula, finite divisor-weighted zero sums tending along good heights, main term Mellin(phi,1)x and an explicit left-line integral. The body subtracts the s-1 datum to restore the pole. | Still requires `GoodSmoothing`. It does not directly give the Logan formula or its numerical constant2. The nonprincipal restriction of `explicit_formula_gen:988` is therefore not the absence of a principal API, but the smoothing restriction remains. |
| `Explicit/WeilRect.lean:21–53`, `rectZerosXi`, `GoodH`, `rectInt_xi_eq` | Genuine finite rectangle identity for any entire h, actual multiplicities, good-height zero avoidance and horizontal log-derivative bounds. This is the most economical candidate starting point. | Supply the correct entire Logan-weighted h, line integrability, all boundary limits, arithmetic-side inversion, and archimedean residues/bounds. |
| `Explicit/WeilFormula.lean:125–174`, `weil_formula:142` | Polynomial-decay contour handling exists, but is specialized to `WH` from a sinc-power window, with m>=2 and exp(2m ell)<2. | Cannot substitute Logan for `WH` without generalizing and reproving each estimate. The small-support hypothesis also explains why this particular formula has no general prime contribution. |
| `Explicit/WeilTest.lean:74–117` | Entire `sincC`, its removable value, and bounds; `WB`/`WH` special test functions. | `sincC(sqrt(z))` with an unexamined complex square-root branch is not a satisfactory entire definition. An even power series avoids that issue. |
| `Explicit/ZetaZeroSums.lean:23–24,39`, `Explicit/WeilBridge.lean:38–95` | Closed-height `RHBelow H` on actual strict-strip zeta zeros; finite-carrier/order transport. | A new certificate must establish that predicate at H, with completeness. The old `rh_upto_1e8:29` consumes `PlattGRH` and is not fresh evidence for H. |
| OAI `Hecke/PrimeDyadic.lean:107–117`, `polynomial_mellin` | Compact support in a positive interval **and ContDiff infinity**; ideal-indexed Hecke coefficients, Mellin normalization1/(2pi). | The actual compact Logan eta has a nonzero endpoint limit and is not continuous after extension by zero. Its convolutional cutoff does not become C-infinity automatically. Nor are ideal Hecke coefficients the ordinary zeta prime-power coefficients without an identification theorem. |
| `Prelim/ThetaExplicit.lean:33,42–45,121–126` | Actual theta/psi finite sums and elementary conversion; the inspected general bound is psi-theta<=2.001 log(N) sqrt(N). | This weaker bound cannot be substituted for a sharper prime-power allowance used in a small proposed theta constant. That sharper estimate and ordinary/half-weight conversion need separate proofs. |

The source-level conclusion is **not** that no other useful theorem exists anywhere. It is that these inspected candidate entry points do not already discharge the stated Logan obligations. No claim about an entire import closure follows from this bounded search.

## 3. The existing Logan-named code: a concrete obstruction and safe reuse

The PNT dependency is at commit `c39a751132c88b6e8080b74c74023fd95b3d8be0`; exact bytes below are authoritative. In `PrimeNumberTheoremAnd/IEANTN/BKLNW/BKLNW_app.lean:693–696`, the definition `ell` (Unicode `ℓ`) is a function of three **real** variables:

    (c / sinh c) * sin(sqrt((xi*epsilon)^2-c^2))
                  / sqrt((xi*epsilon)^2-c^2).

For c>0 and |epsilon*xi|<c, the real square root is zero; totalized division then makes this expression zero. In particular its value at xi=0 is zero. The correct normalized Logan function has value1 there. At a zero radicand the source expression also fails to insert the removable sinc value. This is an exact symbolic diagnosis, not a numerical counterexample. Do not use this `ell` in a purported proof of the requested formula.

A source-faithful replacement definition can use the entire series

    L(c,epsilon,z) = (c/sinh c) * sum_{n>=0}
                       (c^2-(epsilon*z)^2)^n/(2n+1)!.

The ratio majorant proves local uniform convergence; termwise analytic limits give an entire even function. At z=0 the series equals sinh(c)/c, so L(c,epsilon,0)=1. At the radicand boundary it has the correct value c/sinh(c). These are paper proofs of the definition repair, not new Lean declarations. Proving the Fourier transform and bounds still remains.

There is useful independent material in the same file: `besselI0:701–702`, `besselI0_summable:763`, positivity/monotonicity at774–791, continuity833–851, eta measurability853, bounds861, integrability879–893, and partial-sum inequalities1039–1076. These use the actual positive series and the separately defined closed-form eta723–726, not the defective `ell` bridge. They are candidates for a small dependency-clean reuse slice; importing a file containing unrelated placeholders does not make those placeholders permissible dependencies. Eta's endpoint convention must be reconciled with half-weight formulas; values at two endpoints do not affect a Lebesgue integral, but pointwise identities need explicit treatment.

The file itself says at719–721 that the Fourier identity is an obligation. `bklnw_thm_16:1128–1158` ends in `sorry` and consumes the above `ell`. `Inputs.default:30–35` chooses a historical RH theorem; `IEANTN/ZetaSummary.lean:103,113,123` gives Platt/GW/PT finite-RH statements by `sorry`. None is available as a standard-axioms proof or as fresh spectral data. This is a new route-specific source issue, not a claim that these placeholders occur in every selected QRH export.

## 4. Minimal analytic work package

The cheapest credible architecture found here has five reusable analytic gates, followed by two finite gates. “Cheapest” means the smallest identified source dependency surface, not a measured time advantage.

1. **Correct kernel.** Entire L and its normalization at i/2, a positive compact Bessel kernel eta, Fourier-sign/2pi identity, and convolutional definition of the exact smoothed psi. Prove convergence before using tsum or interchanging integral/sum. The I0 fragment above helps; I1, its integral/derivative relation, and the monotonic bounds needed for desmoothing are additional work.
2. **Logan explicit formula.** Reuse `rectInt_xi_eq` and actual-order carriers. A natural entire test uses the removable expression `(x^s-1)/s` times L((s-1/2)/i), divided by its normalization. Prove its precise relation to the arithmetic smoothing, including trivial-zero/archimedean terms, rather than writing an unproved generic “explicit formula” adapter. Polynomial decay must be strong enough for both vertical integrability and good-height horizontal limits.
3. **Simplified constant and zero tails.** The older Büthe formula has `(x^rho-1)/rho`; the later Proposition2 supplies the `x^rho/rho` formula with error2. Its proof uses reflection with multiplicities, an inverse-square zero bound, and explicit elementary constants. Thus the constant2 is not free merely because a contour identity is available. The finite-RH window and unconditional exterior tail require distinct estimates. [Büthe v2, Proposition2–3](https://arxiv.org/pdf/1511.02032v2).
4. **Desmoothing and prime powers.** Prove the positive-kernel short-interval estimate with its B0>1 domain, then I1/sinh comparison and the exact prime-power conversion used by the selected scalar allocation. Existing Gaussian sandwich bounds do not imply it. The compact Bessel kernel and its bounds are treated in [Büthe v4](https://arxiv.org/pdf/1410.7015v4); no numerical table from that paper is accepted here.
5. **Continuum specialization.** Prove every c(x),epsilon(x),H,Q domain and uniform scalar inequality on A<=x<=X. Exact rational endpoint witnesses plus proved monotonicity are appropriate; checking a grid of x is not. Adopt major_constants' final allocation only after its separate review. A change of smoothing constants must propagate to the gap inequality.
6. **Low-zero finite gate.** Johnston's reciprocal-head estimate through5000 and any inverse-square estimate used in gate3 need actual multiplicity-aware enclosures/counts and checked rational sums, or a replacement analytic bound with a newly checked budget. RH location alone does not give the numerical sum.
7. **High finite-RH gate.** Actual zeta zeros through the selected H must be on the critical line, with no missing or off-line zeros and closed endpoint handling. Point estimates, a bibliography entry, and high-height sign density are insufficient. This remains the potentially dominant generation and verification workload.

A proof via smooth approximants is another possible architecture, but it adds uniform estimates and a limit passage. It does not turn the Logan kernel into `GoodSmoothing` or `ContDiff infinity`. The concrete contour route above is the narrower identified starting point; feasibility of completing its sharp constants is still open.

## 5. Low-range patch: exact existing Bertrand interface

The target manifest pins Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`. The inspected local checkout has that exact HEAD. `Mathlib/NumberTheory/Bertrand.lean:225–226` states:

    Nat.exists_prime_lt_and_le_two_mul (m : Nat) (hm : m != 0) :
      exists p, Nat.Prime p and m < p and p <= 2*m.

Its body uses the proved large-case combinatorial bound and a small fixed prime list; it does not require finding all primes up to A. This is an existential theorem, not an algorithm whose runtime is proportional to A.

Here is the complete low-range paper adapter. Let B>=8 and A<=B/2. For odd n>B+3 put y=n-B. If y<A (or y<=A), then y>=4 and Bertrand gives prime p with y<p<=2y. Since y<=B/2<=B-4, we have 2y<=B+y-4=n-4. Thus p belongs to [n-B,n-4], and p>4 makes it odd. Consequently n-p is even and 4<=n-p<=B. At y=A either branch can be used when both domains are closed. For 7<=n<=B+3, take p=3. Natural subtraction is legitimate in both branches by the displayed inequalities.

For y>=A, a positive ordinary theta difference theta(n-4)-theta(n-B)>0 yields a prime in (n-B,n-4], stronger than needed. If the proof instead uses half-weight theta, positivity still yields a prime in the closed interval, but the error and endpoint convention must first be proved. No ladder, dense primality table, or Logan evaluation is required by the Bertrand patch itself.

## 6. End-to-end proof cost boundary

For Lean, compare total costs as

    analytic library development + build/import/kernel checking
    + RH certificate generation/checking + head generation/checking
    + scalar certificate generation/checking + final theorem assembly.

The new layer can share kernel, tail, desmoothing and continuum lemmas across all x. There should be no per-integer proof from A to X. It can consume a single checked finite-RH theorem and a small head certificate. That removes the ladder only conditionally; it does not price away the high-RH evidence. Existing source bodies, source hashes and compiled libraries are different objects, and this task did not measure any of their costs.

For **ordinary MM0**, the same theorem requires an actual formal analysis library: reals/complex numbers, integration and convergence, analytic continuation/zeros with orders, zeta, Fourier/Mellin or equivalent explicit-formula foundations, then the seven gates above. The currently inspected PA limb/modular-squaring library does not supply these. Encoding analysis in the chosen foundation or translating a suitable verified library is a major additional generation and checking project; no numeric multiplier or runtime estimate is justified here. Bertrand also requires an ordinary-rule proof/translation, even though Mathlib already has it for Lean. Reusing an arithmetic proof circuit for spectral certificates does not remove the analytic bridge cost.

A same-rule wider/streaming MM0 implementation remains an ordinary-verifier candidate, with implementation assurance comparable to that expected of Lean's kernel. A trusted native special-function checker, imported Lean theorem as an axiom, or external analytic certificate oracle is a different trust boundary and must be costed and labeled separately. Nothing in this report authorizes such an extension.

The next useful bounded milestone is the **correct entire Logan definition, Fourier kernel identity, and a precise polynomial-decay principal contour contract**, with an independent statement audit. This tests the real missing analytic join before committing to an enormous finite-RH campaign. It is a proposal for later authorized formal work, not a new declaration or an approved proof anchor.

## 7. Source pins

Prefixes: T=`work/ternary-goldbach/TernaryGoldbach/`; P=`work/qrh-dependencies/PrimeNumberTheoremAnd/PrimeNumberTheoremAnd/`; O=`work/openai-math/lean/OAI/NumberTheory/DirichletL/`; M=`C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/`. Paths and lines above refer to these exact bytes. Hashes are provenance, not theorem acceptance.

| File | SHA256 |
|---|---|
| `work/ternary-goldbach/lake-manifest.json` | `EA138F9D252387A27424093EF9BE6D65E1AF2638A51212ACA408385029549C82` |
| T `Helfgott/SmallCases.lean` | `61B94AFA308E82B7C8D9DA927CE5EB18F8847F9D58554589E4A28F5A2B7BF359` |
| T `Explicit/ExplicitFormula.lean` | `8CDDDBE6934871CA37260E435BE639A49AC33F4A8D92CBB2E33AB9D330869C35` |
| T `Explicit/ZetaExplicit.lean` | `A2252356B4A2FCE4BC0B2B0EFF9A26B43DFAEBA9B05DB94BFEAA444A423B94E2` |
| T `Explicit/WeilRect.lean` | `65F15EE260D474D56443A8338585DA4890639CF2EBB1576502043691BE662248` |
| T `Explicit/WeilFormula.lean` | `5168EC73138BD02D607C318FFADFEACBDBAD40B4521AA15DD187C60870187119` |
| T `Explicit/WeilTest.lean` | `98E7C7F9BCD7FCAD99FD5E26BB117E8515703F3FF343FCAB383EBF6F9629029C` |
| T `Explicit/ZetaZeroSums.lean` | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| T `Explicit/WeilBridge.lean` | `285F825F4916B8D8F40256090F56E773140AB2FC2C48E3F057F68A838E17C73E` |
| T `Prelim/ThetaExplicit.lean` | `F30571CFFF146129180D9A1865BAE879027CB5E1F9BCC4B3C8D1912983A45F93` |
| P `IEANTN/BKLNW/BKLNW_app.lean` | `2959F94E3537FBB4C2AC71B74C19827F28D8A947898EAC8B50BD3F356F62955F` |
| P `IEANTN/ZetaSummary.lean` | `854A5C0EFCDDAC8681AC115874F02CB9A5142E6A83C46EE79B59A085C82B2738` |
| O `Hecke/PrimeDyadic.lean` | `31806E0A1915B831ECE1B5F6F761D57C494C57DE5BF977E214050F9C1A8AF9E7` |
| M `NumberTheory/Bertrand.lean` | `91AED0AE5E324993157982FF06A5EB8002FD7224C2A3FA1B47DB937650CEF9DD` |

No independent review of this new inventory is claimed. The coordinating fresh scalar proof and all spectral evidence retain their separate status.
