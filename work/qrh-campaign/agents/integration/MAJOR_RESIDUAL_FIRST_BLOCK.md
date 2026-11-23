# First low-conductor block of the major residual

Research only, against the primary targets in `agents/major-constants/BLUEPRINT_AVERAGES.md` and `agents/zero-sum/BLUEPRINT_MIXED_MOMENT.md`, and target source commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean source was changed and no compiler ran. The numerical target below is an open research obligation, not a new assumption in a theorem.

## Recommendation

Start with the **conductor-one contribution to Aplus**, including its induction to every squarefree modulus in the actual major-arc set. It involves one zeta residual, no nonprincipal family average, and no pair-density theorem. A sufficiently strong weighted estimate for that one residual removes the entire conductor-one block from the Aplus problem.

The precise useful first target is: for every real `x ≥ 4.9e26`, prove

`∫_{-600000}^{600000} |U(δ)|² |Z+(x,δ)|² dδ ≤ 4e-8`,

where

`Z+(x,δ) = S etaPlus x (δ/x)/x − P(δ)`,
`P(δ) = Fourier(etaPlus)(−δ)`,
`U(δ) = Fourier(etaU)(−δ/49)`.

These are the actual source smoothings, including the bandlimited etaPlus. This target implies that the **whole coprime conductor-one part of Aplus is less than 1e-7**, using only elementary weight arithmetic and the source's unconditional coprime-removal bound. It allocates 20% of the corrected total Aplus cap `5e-7`; the remaining conductors would still need at most `4e-7`. This is a sufficient allocation, not a claim that the principal part equals 20% or that this allocation is optimal.

The conclusion is materially larger in scope than merely checking q=1: it covers all squarefree q in the actual set. It leaves the separate J, Astar, Cross, and minor-arc obligations unchanged.

## Exact weights and integration domains

Let `Q = Qset 150000`; odd q run through 150000, even q through 300000. The major-arc half-width is `Dq = 1200000/qt(q)`, with `qt(q)=2q` for odd q and `qt(q)=q` for even q. Every squarefree q is uniquely one of `r,2r`, with r odd squarefree and `r ≤ 150000`. Both have

`Dq = 600000/r`, `φ(q)=φ(r)`, and `|μ(q)|=1`.

The conductor-one character is the principal character. Its Gauss norm squared is exactly 1 for squarefree q and 0 otherwise, by `MajorArcs.norm_sq_gaussSum_one`, `ArcChars.lean:177`. Define

`e+(q,1,δ) = Schar(1,coprimePart(q,cP x),δ/x)/x − P(δ)`.

The exact block of the blueprint's coprime Aplus is

`Aplus'[c=1] = Σ_{r odd squarefree≤150000} φ(r)^(-3)`
`                 * ∫_{|δ|≤600000/r} |U(δ)|²`
`                      * (|e+(r,1,δ)|² + |e+(2r,1,δ)|²) dδ`.

There is no conductor square root and no extra factor of 49 in this formula. The star scale is already inside U. The inverse-character convention makes no difference for the principal character. Endpoints can be taken closed or open once the usual measurability/integrability facts are supplied.

Before coprime removal, this becomes the one-residual integral

`∫ W3(δ) |U(δ)|² |Z+(x,δ)|² dδ`,

with the exact finite step weight

`W3(δ) = 2 Σ_{r odd squarefree≤150000, |δ|≤600000/r} φ(r)^(-3)`.

It vanishes outside `[-600000,600000]`. On the q=1,2 interval the two smallest moduli contribute weight 2; additional moduli contribute where their smaller arcs overlap. Thus a local interval such as `[-4,4]` does not represent the whole block.

## Elementary uniform weight bound and removal budget

The following bound needs no prime distribution theorem:

`W3(δ) ≤ 2 ∏_{p odd prime≤150000}(1+(p−1)^(-3)) ≤ 64/27`.

For the second inequality, the injective assignment `p−1=2m` gives

`Σ_{p odd prime≤150000}(p−1)^(-3) ≤ (1/8)Σ_{m≥1}m^(-3) ≤ 5/32`.

The last inequality follows from `1+1/8+∫_2^∞t^(-3)dt = 5/4`. For any finite family of nonnegative numbers with sum s<1, expansion into elementary symmetric sums gives `∏(1+a_i) ≤ Σ_{j≥0}s^j = 1/(1−s)`. Applying this with s≤5/32 gives 32/27. These elementary analytic/algebraic lemmas remain to be written in Lean; no new numerical certificate or zeta-zero fact is needed.

`ArcChars.lean:314`, `norm_S_sub_coprime_le`, gives

`|e+(q,1,δ) − Z+(x,δ)| ≤ 1e-15`

for every q in this block and every δ. Use `Schar_one_eq_expTsum` at line 161 to identify the principal coprime sum. The q=1 identity is exact; no removed prime powers occur there. The q=2 difference consists only of powers of 2, although the uniform source bound is already more than sufficient.

The scalar inequality `|z+d|² ≤ 1.01|z|² + 101|d|²`, the source bound `|U|≤1.2534` (`MajorTotal.lean:475`, `norm_fourier_etaUC_le`), and the interval length 1200000 give

`Aplus'[c=1] ≤ 1.01*(64/27)*4e-8`
`              + 101*(64/27)*1200000*(1.2534)^2*1e-30`
`            < 9.5762962963e-8 + 6e-22 < 1e-7`.

The companion `major_first_block_arithmetic.json` verifies the final strict comparison with exact fractions, using the looser `(1.2534)^2<2`. The source removal and Fourier-bound declarations used here have no Platt binder; their proofs use summability, smoothing bounds and Gaussian integrals. This is source evidence, not a new kernel audit.

## What is already available for conductor one

The unconditional analytic entry point is `Explicit.explicit_formula_zeta_seq` in `ZetaExplicit.lean:122`. With `goodSmoothing_fP`, its fixed sequence of finite zero rectangles gives the actual zeta residual plus an explicit vertical-line remainder. The exact finite carriers are `zerosRectD zetaF T` and `multRectD zetaF T`; the pole term is exactly the P term above. `zerosRectD_zetaF_strip` excludes trivial zeros, and `zetaF_zero_ne_zero` excludes a spurious zero at zero.

The existing `EtaPlusBound.norm_SsumG_fP_zeta_le`, line 173, does **not** close the new target: it explicitly assumes every nontrivial zeta zero up to T0 is on the critical line. It also requires `200 + max(10π|δ|,50) ≤ T0`. Reusing that declaration without discharging its RH premise would retain the forbidden dependency.

The campaign's paper route in `mellin/BLUEPRINT_PRINCIPAL.md` targets only

`∫_{-4}^4 |Z+(x,δ)|² dδ ≤ 8e-6`.

Even if completed, multiplication by the available Fourier supremum gives only a local weighted bound `1.2534²*8e-6 = 1.256809248e-5`, over 300 times the proposed `4e-8` full-interval target. This is a comparison of sufficient upper bounds, not a lower bound or an impossibility result for the actual residual. The proposed K85 quartet bound and mass `.07` are likewise not a weighted broad-twist estimate.

The Mellin worker confirmed that no stronger weighted broad-twist principal estimate, and no conductor-three-specific estimate, has been obtained in the current research. Its separate broad principal-energy task is ongoing. We have not established the absence of such a theorem from the mathematical literature; this report identifies what the available source and campaign arguments actually supply.

## The next analytic calculation

Use the zeta explicit formula in the Hilbert space with measure

`1_{[-600000,600000]}(δ) |U(δ)|² dδ`.

Retain the real zeta conjugate/reflected zero packets, multiplicities, and the phase `exp(i γ log x)`. Compute or bound the weighted Gram kernel of the **actual** etaPlus Mellin transforms in this space, with a rigorous high-height remainder. The source etaU Fourier decay can help outside the central twist range; it must be applied inside this integral, rather than replaced everywhere by the constant 1.2534. The etaPlus bandlimit shifts Gaussian Mellin heights by up to 200, which must be retained in any separation estimate.

A total positive zero mass alone is not a proof of the required Gram bound. A finite low-zero rectangle certificate, a sharper actual-zeta moment, or a demonstrably sufficient Gram estimate would be new analytic work. Checking a few zeros numerically is not enough: the final inequality is uniform for every `x≥4.9e26`, so phases cannot be frozen at the endpoint. Uniform operator bounds or explicit phase-independent estimates are legitimate; assumed monotonicity of the oscillatory residual in x is not.

The proposed first milestone is therefore a **certified weighted principal Gram/tail bound strong enough to prove the displayed 4e-8 residual integral**, with all explicit-formula remainders included. It does not require proving a family zero-density theorem for every conductor. No cutoff, zero spacing, or numerical kernel constant is assumed by this report.

## Why conductor three is the next block, not a shortcut

There is one primitive nonprincipal character modulo 3, the real odd character χ₋₃. For the pair q=3,6, the arc is `|δ|≤200000`, and the primitive conductor-three coefficient in Aplus or Astar is exactly

`2*3/φ(3)^3 = 3/4`.

For all inducing squarefree moduli, its exact step weight is

`W3,c=3(δ) = 6 Σ_{r odd squarefree≤150000, 3|r, |δ|≤600000/r} φ(r)^(-3)`.

The residual has no principal pole subtraction, and χ₋₃ is its own inverse. However, a useful bound still needs the actual L-function zero information and transform estimates. Reality permits a genuine quartet argument, but neither reality nor the absence of a pole proves cancellation. The available generic source explicit-formula bound is conditional on its low-height critical-line hypothesis; no source specialization removes it for modulus 3. Thus conductor 3 adds a new L-function without avoiding the unresolved analytic step already present at conductor one.

For Astar+Cross, the truly smallest isolated modulus block is q=1,2: each modulus has only one character, so its contribution is exactly

`Σ_{q=1,2} ∫_{|δ|≤600000}`
`  ( |P(δ)|² |e*(q,1,δ)|² + |e+(q,1,δ)|² |e*(q,1,δ)|² ) dδ`.

This is an alternative first target if the actual etaU transform yields a much stronger bound. It needs two smoothings and a product estimate, whereas the recommended Aplus block needs one weighted second moment. Controlling only the conductor-one/conductor-one part of Cross at larger q is insufficient: Cross also contains principal/nonprincipal and nonprincipal/principal pairs at the same modulus. Those terms must remain in the residual problem.

## Status

The finite weight reduction and its budget are proved here as paper algebra with exact rational checks. The central `4e-8` analytic estimate is open. This report supplies a bounded next research target and precise integration back into the corrected major coefficient 1.0404; it does not claim a completed major-residual estimate or a Lean proof.
