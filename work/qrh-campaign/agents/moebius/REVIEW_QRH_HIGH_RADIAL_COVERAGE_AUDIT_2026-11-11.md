# Independent review: high-radial coverage and consumption

Verdict: **PASS for the bounded source/mathematical implication.** No mathematical correction to the author report is required. This document makes no Lean build, axiom-closure or full QRH validation claim.

Reviewed author: `integration/QRH_HIGH_RADIAL_COVERAGE_AUDIT_2026-11-11.md`, SHA-256 `D8188C5E8AA59E979BEC024567255CF28845215117F2426C70C31D93F60EBA4D`, read in full. All 25 whole-file source pins match the current bytes. Two nonblocking locator corrections are recorded without changing the frozen author: `original_physical_tail_rapid` starts at `InitialHighFrequencyTailRapid.lean:14`, and `retained_window_bound` at `InitialRetainedWindow.lean:21`.

The supporting checker and receipt are `moebius/check_high_radial_coverage_source_20261111.py` (SHA-256 `981D6A5B57823CF14A37A8E92C10027BD8E00B17FB8C9636DDAAA0041D634436`) and its `.json` receipt (SHA-256 `6C41750CDC64AAAA2AAC1768DEED065B30E988883CC075F0D65B19F95D7E1E3E`). They bind the 22 files whose relevant bodies were independently inspected and verify five elementary exact scalar identities/inequalities. These checks contain no analytic function evaluation and are not a substitute for the proofs described below. Whole-file hashes do not imply every unrelated declaration in those files was audited.

Source root: `work/openai-math/lean/OAI/NumberTheory/DirichletL`, expected commit `4eaee87548250b2682affda7d05d947c05554bae`. Paths and line numbers below are relative to that root. The preceding global-tail review is `moebius/REVIEW_QRH_GLOBAL_TAIL_ANALYTIC_AUDIT_2026-11-11.md`, SHA-256 `468EA90C5E52C933700F6E59F1DDB28358B6876D86D6B009103A92E0E6C768CA`.

## Actual partition and endpoint coverage

`Moments/SectorLocalization.lean:13–140` defines the smooth decreasing cutoff, annulus `cutoff(x)-cutoff(2*x)`, and real weights `w_n(q)=annulus(q/2^n)`. The weights are nonnegative, supported in the open interval `(2^n/4,2^n)`, and sum to one for every positive q. This last assertion is proved by the two adjacent active scales and exact telescoping, including the case where q itself is a dyadic endpoint. It is not an unevaluated infinite-sum assertion: the active support is finite before the sum identity is used.

`Moments/DyadicCount.lean:13–44,84–92` uses the finite integer interval from `ceil(log_2(a))` to `floor(log_2(4*b))`. For q in the **closed** interval [a,b], a>0, every nonzero weight lies in this finite index set. Thus the finite weight sum is exactly one, even at a or b. There is no assumption that a and b are dyadic. Empty or reversed boxes cannot contain a live q and cause no exception to the stated implication.

`Inversion/InitialDyadicAssembly.lean:20–76` takes the product of four such weights on the actual source coordinates: common norm, divisor norm, overlap norm, and squared lattice-frequency norm. The scales satisfy `Z^(exponent Z n)=2^n` for Z>1. These are actual source coordinates, independent of the two fresh support choices (`InitialDyadicAssemblySourceCaps.lean:20`).

`InitialDyadicAssemblyRetained.lean:13–27` partitions the **finite window index set** by `radialCenter<=L` and `L<radialCenter`. Equality belongs to the retained part. This is not a disjoint partition of physical points: overlapping smooth windows are intentional. `InitialDyadicAssemblyTail.lean:16–97` merges the tail windows into their real nonnegative mass. On a closed source box, this mass is at most one, so multiplying the source weight by it preserves its norm bound. The exact finite-sum interchange at lines 58–88 gives the tail block. No tail window-cardinality factor is incurred.

## No silent loss through source filtering

`InitialDyadicAssemblyLive.lean:24–62` removes an out-of-box source only when every individual source/ray summand is zero. `InitialDyadicAssemblySourceCaps.lean:31–85` supplies that premise from the actual nonzero summand and physical support bounds. In particular, it does not use cancellation of the whole source sum to infer a pointwise support statement.

`InitialRetainedSupport.lean:18–69` extracts the two actual W factors from a nonzero physical term. Their support bounds give both whole-column inequalities. The five ideal norms are at least one, and divisor containment supplies the divisor cap. The primary congruence hypothesis `goodLambda^2 divides p_i-1` is used in the extraction and remains present in the high-tail theorem. It is not discharged merely by nonzero ideal norms.

`InitialDyadicAssemblyTail.lean:126–166` similarly restricts a physical block to points having a nonzero individual weighted ray term. A source with a nonzero term is never removed. On this live set, nonzero product implies both a nonzero physical term and a nonzero tail mass. Inactive points need not satisfy the geometric gate.

The exact identity `actual_physical_retained_tail` at lines 180 onward retains the entire retained block and the merged tail block, after the justified cap filter. It has no omitted intermediate radial region.

## Scalar gate for the original Fourier argument

Write the positive ideal norms as C,d,v,n1,n2, and the squared frequency norm as Hf. The original radial Fourier argument is

`t = Z^m * Hf / (d*v^2*n1*n2)`.

The live whole-column bounds are `C*v*n1<=bW*Z^D` and `C*v*n2<=bW*Z^D`. Therefore

`t >= Z^m * C^2 * Hf / (d*(bW*Z^D)^2)`.

A nonzero tail mass has at least one live window (`InitialDyadicAssemblyTail.lean:99–124`). If its exponents are B,theta,V,H, the open supports imply `C>Z^B/4`, `d<Z^theta`, and `Hf>Z^H/4`. Relaxing these strict inequalities gives

`t >= Z^(m+H-theta-2D+2B)/(64*bW^2)`.

The three quarter factors are C squared and Hf once; no quarter factor for the overlap coordinate is needed. This is exactly `InitialHighFrequencyTailAnnulus.lean:10–58` and `InitialDyadicTailGates.lean:58`.

Tail membership gives `radialCenter>4*eta+tau`. Under eta>=0 and `64*bW^2<=Z^eta`, this implies t>=Z^tau. In fact eta+tau would suffice for this isolated scalar implication; the source's larger threshold is conservative and is shared with the retained-window argument. The proof makes only a pointwise finite existential choice of a live window, then proves a window-independent inequality. No measurable selection, globally fixed window, or summation of individual window bounds is required.

## Uniform high-tail application and finite consumer

`InitialDyadicTailBound.lean:15–122` chooses the finite Schwartz seminorm set and constant from `original_physical_tail_rapid(Lcap,saving,tau)` before the remaining data. It applies that theorem to the live finite set with

`L = max(1,bW*Z^D)`.

The assumption Lcap>=0 is essential to infer `1<=Z^Lcap`, so the supplied upper bound on `bW*Z^D` also bounds L. The actual five support keys lie in the same finite pool; both whole-column bounds and the radial gate are checked. Tail mass preserves the original Gamma bound. This establishes a bound independent of the finite source size and the number of dyadic windows. It is still a finite-source theorem.

`InitialFiniteEnergy.lean:19–152` consumes it with `Lcap=2*cap+2`, saving=1, bW=max(1,b0). Its eventual Z threshold ensures bW<=Z and `64*bW^2<=Z^eta`. The source assumptions give `0<=m<=cap`, `D>=-cap`, and `D<=cap`; hence `-m<=Lcap`, `m-D<=Lcap`, and `bW*Z^D<=Z^Lcap`. Smooth clipped functions retain the required global norm and upper-support bounds. All primary, oddness and injectivity inputs are supplied by the actual prime-pool construction.

The finite frequency cap is explicitly `1+sum_S frequencyNormSquared` (`InitialDyadicAssemblyTail.lean:168–177`), so it may depend on S. This is harmless: the rapid bound does not depend on it, and `retained_card_subpower` has constants and eventual Z threshold **before** arbitrary T. The retained radial inequality bounds the frequency exponent independently of T (`InitialDyadicAssemblyRetained.lean:29–53`); the other exponents come from the physical caps. Thus the retained index set injects into a fixed polynomial-scale window box, with cardinal at most C Z^loss.

`InitialRetainedSum.lean:18–140` preserves this quantifier order. It calls the deeper `retained_window_bound`, then absorbs the retained cardinality by Z^loss. The new finite consumer adds retained and tail constants and uses `Z^-1<=Z^(m+15*eta+pi+eps+loss)`, together with clipping factors at least one. It does not claim an independent proof of the retained analytic estimate.

## Infinite frequency and zero-mode boundary

`InitialPhysicalReassembly.lean:85–168` codes every common/divisor/overlap choice and every member of the arbitrary finite frequency set. The coding is injective, so the Finset image does not lose multiplicity. Its fresh left/right rectangle does not require disjoint left/right sets. `InitialPhysicalMeasure.original_ray_common_insertion` (line 304) supplies the exact Mobius reindexing from the original disjoint pair sum; `rectangle_restore_common` (line 52 of InitialPhysicalReassembly) adds only terms killed by the actual common-prime coprimality mask. I checked these bodies and the final finite reassembly, rather than inferring coverage from theorem names.

The immediate infinite consumer is `InitialTotalEnergy.original_input_bound` (line 20). Its step from finite frequencies to the full nonzero-frequency sum is legitimate only because `InitialPhysicalLimit.physicalFrequency_hasSum` (line 49) first proves actual summability. It uses `InitialRayAttachment.initialPhysicalMode_summable` (line 298), which transfers the separate `secondPairRadialMode_summable` theorem through the exact normalization identity and fixed scalar factors. This review checks that use and its hypotheses, not the deeper Poisson/summability proof itself.

At one additional level, `QuadraticSieve/PrimePools.lean:472–505` constructs that mode's summable norm majorant from the radial lattice kernel at positive scale `Y/(norm(e)^2*norm(n)^2)`, nonzero ideal products, and a frequency-independent finite Gauss factor bound. It first proves domination by an already summable nonnegative function, then invokes `Summable.of_norm`. Thus the named summability input is genuine; this check does not independently reprove the imported radial Fourier or local Gauss foundations.

`InitialPhysicalLimit.nonzero_frequency_norm_le` (line 92) then removes the zero index, converts every finite frequency sum through `physicalFrequency_finite` (line 26), and applies a norm bound to the already summable function. It does not rely on Lean's default value for a nonsummable tsum. The finite prime pool remains fixed during this frequency limit; no infinite-prime-pool passage is asserted here.

Finally `original_input_zero_nonzero` (line 76) explicitly splits off frequency zero, and `InitialTotalEnergy.lean` adds the separate `physical_marked_zero_bound`. The conjugated clipping function is correctly converted to the same clipping parameter with phase -theta. The two phase factors give the displayed doubled exponent. Zero frequency, low/retained radial scales, and high radial scales are therefore all represented in the consumer.

## Limits of this review

The covered implication is the exact finite partition, live-source gate, uniform rapid-tail application, and its finite/infinite consumer interfaces. The lower retained-window estimate, zero-mode estimate, original normalized Poisson identities and actual radial-mode summability are separate analytic obligations. The previous global-tail review covers the Schwartz/lattice coefficient estimate at its own stated source cut. No theorem here is declared kernel-checked, and neither this report nor a clean source inspection establishes the full global 7/8 provider or removal of PlattGRH from the final Lean root.
