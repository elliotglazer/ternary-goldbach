# Independent review of family root phases

2026-11-11. Verdict: PASS as a mathematical and source-interface proof plan. No blocking defect was found. This review does not certify any computed family phase, sign, central derivative, zero count, or Lean theorem.

## Reviewed inputs

The reviewed producer is `agents/zero-sum/FAMILY_ROOT_PHASE_PROOF_PLAN_2026-11-11.md`, SHA256 `27B8ED6864E51BECEFA5402CC49E85B8A11F7F3BA620E7A7D1E6A682BBDD8C68`. Paths in this report are relative to `work/qrh-campaign` unless specified otherwise.

The arithmetic-manifest input is `agents/zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md`, SHA256 `53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54`. Its independent review is `agents/integration/REVIEW_FAMILY_CHARACTER_MANIFEST_2026-11-11.md`, SHA256 `EEE3BAE662500804EAEC0268A8612D0E01ED1C2FAF5D0208D442A97739794664`.

The completion and Fourier normalization input is `agents/zero-sum/FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md`, SHA256 `5FED76F0F59A6422977D968DD7F2018FEDAE0A175DE1ECD43D956EFDEDF44F41`. Its independent review is `agents/integration/REVIEW_FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md`, SHA256 `098171B14232E392AAA0C4BDD083C0E737D459315E23039F624C862B8E06C577`.

These are reviewed paper inputs. Their use here does not upgrade them to compiled results.

## Actual source convention

I inspected the pinned Mathlib source at revision `56a005855ea17e0b0958f73ec801ae140b0a1679` and Goldbach source at `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

Mathlib `NumberTheory/LSeries/DirichletContinuation.lean:271` defines `rootNumber` as the Gauss sum divided by `I` to the parity and by the positive-conductor complex power with exponent one half. For positive conductor this last factor is the positive real square root. `Analysis/SpecialFunctions/Complex/CircleAddChar.lean:83,86` fixes `stdAddChar` with the positive exponential convention. Goldbach `Prelim/GaussInduced.lean:168` identifies the finite sum with that same convention. Thus the producer's

`W = (sum_r chi(r) exp(2*pi*i*r/c)) / (i^a sqrt(c))`

matches the actual source root number, not its inverse or conjugate.

Goldbach `Prelim/GaussInduced.lean:175`, `norm_sq_gaussSum_of_isPrimitive`, applies to primitive characters at general positive conductors. `Explicit/LGrowthLeft.lean:221`, `norm_rootNumber`, supplies the exact norm-one identity. The inspected norm theorem does not require a Platt hypothesis. I have not compiled it or audited its transitive axioms in this task.

The manifest fixes exact positive-exponent roots of unity and the inverse-label involution. Mathlib `NumberTheory/MulChar/Lemmas.lean:61,73,79` identifies conjugation with character inversion. Changing the summation variable from r to -r proves

`conj(tau_chi) = (-1)^a tau_chibar`, hence `W_chibar = conj(W_chi)`.

This uses a permutation of `ZMod c` and remains valid for composite c. The note correctly avoids a finite-field-only Gauss-sum theorem.

The primitive functional equation in `DirichletContinuation.lean:283` is stated for the source completed L-function with a conductor power. Multiplication by `c^((s+a)/2)` gives the producer's conductor-completed functional equation. Consequently the factor `c^(it/2)` in its equivalent formula for F is necessary and present. The current phase plan covers primitive nonprincipal c>1. It does not apply an entire nonprincipal completion theorem to the principal conductor-one channel.

## Square-root charts and interval acceptance

For exact W=u+iv of norm one, the two formulas are correct:

* If u>-1/2, set r=sqrt((1+u)/2) and epsilon=r-i*v/(2r).
* If u<1/2, set r=sqrt((1-u)/2) and epsilon=-v/(2r)+i*r.

Each r is strictly greater than 1/2. Substituting v^2=1-u^2 gives norm(epsilon)=1 and epsilon^2=u-iv. Thus epsilon^2 W=1 exactly. The real square-root identities, rather than a numerical residual, prove these equations.

The rational rectangle test is sound. A real-part interval U containing u accepts the first chart if inf U>-1/2 and the second if sup U<1/2. If width U<1 and both tests failed, U would contain both -1/2 and 1/2, a contradiction. The strict tests provide a positive denominator margin. At W=1 the applicable chart gives epsilon=1; at W=-1 it gives epsilon=i.

Squared rational bounds for the radicand produce a sound positive r interval. The resulting rectangle contains the exact chosen epsilon. Its midpoint need not be a unit or a square root. A fixed chart tag for the entire character channel is essential, and the note requires it. Its eventual selection claim is explicitly conditional on convergent sound interval primitives; it does not claim that all finite Gauss-sum enclosures exist already.

## Real values, inverse reuse, and the tilt

The reviewed completion conjugation identity and functional equation imply on the critical line that Lambda_chi=W_chi*conj(Lambda_chi). From epsilon^2 W=1 and norm(epsilon)=1 one obtains epsilon W=conj(epsilon). Therefore Z=epsilon Lambda is real. The factor `c^(-k/2) exp(bt)` is strictly positive and preserves signs.

For a nonreal inverse pair, assigning the partner phase as the conjugate of the representative phase is valid. The `conjugate_of` tag correctly avoids claiming that this phase equals the partner's independently selected chart.

For independent valid phases, kappa=epsilon_chi*epsilon_chibar satisfies kappa^2=1, hence is exactly +1 or -1. The resulting identity is

`Z_chi(-t) = kappa Z_chibar(t)`.

The negative-sign example is correct. If epsilon=(5+12i)/13, then W=(-119-120i)/169. The positive-imaginary chart for conj W returns (-5+12i)/13, and the two phases have product -1. Selecting the positive-imaginary chart independently for both channels therefore cannot justify sign reuse with kappa=1.

With b=pi*eta/4, multiplying by the positive tilt gives precisely

`F_eta,chi(-t) = kappa F_-eta,chibar(t) = kappa exp(-2bt) F_eta,chibar(t)`.

The sign can be reused with kappa. Numerical values and absolute error bounds need the displayed magnitude factor. The note retains that requirement and does not substitute an alias estimate for the wrong tilt.

## Self-conjugate channels and multiplicity

The manifest criterion `2*r_i=0 mod m_i` identifies self-conjugate characters. Root-number conjugation then gives W in {+1,-1}. In this one-channel case kappa=epsilon^2=W, so Z(-t)=W Z(t). The note correctly separates it from the two-channel convention. It does not silently assert the stronger quadratic Gauss-sum result W=1.

The conditional W=-1 branch gives an odd Z and a forced central zero. The W=1 branch gives an even Z. Neither symmetry establishes exact central order. A central order record must prove that all lower derivatives vanish and the specified derivative does not vanish. An interval containing zero proves no derivative equality. A nonzero value at the center also does not exclude other real zeros off the critical line.

The analytic-order interfaces in Mathlib `Analysis/Analytic/Order.lean:472,524,588` support the proposed derivative criterion, multiplication by nonzero analytic completion factors, and the affine substitution with derivative i. Their hypotheses remain necessary. On the critical line the Gamma argument has real part 1/4 or 3/4; `Gamma/Deligne.lean:69` supplies a suitable nonvanishing interface. Entire nonprincipal completion is available at `DirichletContinuation.lean:249`.

Conjugation pairs negative-height zeros of chi with positive-height zeros of chibar and preserves multiplicity. Consequently the lower count for the fixed chi channel is `K_chi^+ + K_chibar^+ + r_chi`; for a self-conjugate channel it is `2*K_chi^+ + r_chi`. The central order occurs once. Saturation still needs the separate full count, including possible off-critical real zeros.

## Bounded independent arithmetic checks

I ran an inline Python `Fraction` diagnostic, without importing producer code or generating family data. It used 13 rational points on the unit circle, including the axis cases and rational parametrizations. Exact integer square tests constructed the relevant chart roots. All 22 admissible chart instances satisfied norm one and epsilon^2 W=1. All 40 admissible inverse-chart pair products were exactly +1 or -1. It also checked the author's negative-kappa example, the self-conjugate endpoint charts, and chart selection for enclosing real intervals of width at most 4/5. The process exited zero.

These finite tests supplement the symbolic proof above. They are not a proof for every root number and do not provide any spectral certificate.

## Acceptance scope and remaining work

The source normalization, chart algebra, branch tests, inverse-channel signs, tilt scaling, and central-multiplicity rules pass this review. No requested correction remains.

The implementation still needs the finite Gauss-sum interval producer and its root-of-unity proofs, the rational interval checker, the completion conjugation adapter, the fixed orbit-phase assignment, and analytic-order transfer. Actual central derivative equalities, sign records, complete counts, and saturation remain separate obligations. No Lean files, builds, finite scans, or frozen producer changes were made for this review.
