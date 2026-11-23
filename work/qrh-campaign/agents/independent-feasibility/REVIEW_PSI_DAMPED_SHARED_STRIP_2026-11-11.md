# Independent review: damped shared-strip psi bound

2026-11-11. **PASS at conditional paper/source and exact-scalar scope.** No mathematical defect remains in the reviewed composition. The new argument yields the finite-range constant `.0096`, and the retained large-range argument yields the common `.01/log x` envelope for every real `x >= 5e9`. This removes the extra narrow principal strip through one million and its weighted moment from this consumer. It does not prove the shared finite spectral input, turn external head evidence into a Lean proof, or change other consumers automatically.

No Lean declarations, builds, spectral evaluations, scans, or frozen-file changes were made. The independent numerical work here consists only of rational elementary-series inequalities. Hash verification is provenance evidence, not mathematical certification by itself.

## Frozen scope

Paths below are relative to `work/qrh-campaign/agents/`.

| Reviewed artifact | SHA256 |
|---|---|
| `prime-estimates/PSI_DAMPED_SHARED_STRIP_2026-11-11.md` | `8764E3EFDC940A4F302A761CFD2DE51778A91A5BF30F059F39CD0911F00CF5D0` |
| `major-constants/PSI_DAMPED_SCALAR_BUDGET_2026-11-11.md` | `062E77E41EF43DC783A6CFAF319454C406897A322FA7D095BCC4C0E610F54209` |
| `major-constants/psi_damped_scalar_budget_20261111.py` | `FD27172A20940A71C4C1D5DEF0EFE5B140729BAD243562945A206F5CD9EFA4C5` |
| `major-constants/psi_damped_scalar_budget_20261111.json` | `7D137201A4452F1C7E739EFB781C150DA2B8299720AFDF2718ADC06ECC107DFE` |
| `zero-sum/PSI_DAMPED_SYMMETRY_SOURCE_JOIN_2026-11-11.md` | `7574552D55981DCEC5CF5A419D6CEEB6FC7A264FE4A81CBAA8D0C3880F6DAFBE` |

I read the complete final main, scalar, and symmetry notes, inspected the scalar implementation, and checked the source contracts and inherited head/count/error arguments. The final pin receipt below checks these artifacts, eight other input/evidence files, and the ten Lean source files listed in the main note: **23 frozen inputs, all matching**. The Lean source tree is the pinned ternary-goldbach revision `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

## Actual zeros, finite carriers, and the head

The selected inputs are RH through closed height `A=1500`, the actual positive count `N(A)=1069`, and the independent reciprocal datum

`Q_A = sum m_rho*(1/gamma - 1/A) < 417/250`.

They give the positive-ordinate head bound `H_A < 3571/1500`. The subtraction term is restored exactly. Neither RH nor the count alone implies the stated reciprocal bound. The accepted head-count review and the sign-saturation review supply different parts of this input; no data on `(1500,2000]` are needed.

For the finite shared range take `H=60343058`, an auxiliary `U=H+1`, and the complete closed-height filter of `zerosRectD zetaF U`. The strict enclosing disk and rectangle contain every nontrivial root with `|gamma| <= H`: `|rho-2| < 2+H < U+3`. Local analytic-order transport makes its natural divisor weight the true multiplicity, independently of the enclosing disk. This also transports weights from each finite good-height explicit-formula sum.

Conjugation and `rho -> 1-conj(rho)` preserve the analytic order, not just zero membership. The local power-series/factorization argument in the notes justifies that assertion, using the actual `xiF_one_sub` and `xiF_conj` identities. The second map preserves positive ordinates and each selected band. Reindexing the full weighted finite sum and taking its arithmetic mean handles critical-line fixed points without halving their multiplicity.

An arbitrary selected subset must first be enlarged in the nonnegative norm majorant to this complete carrier. It need not be invariant itself. The notes do this. A real nontrivial zero is excluded by the retained closed RH head together with `xiF_half_ne_zero`; the optional unconditional real-axis proof is not an additional selected premise. Thus division by `|gamma|` and subsequent doubling omit no real-axis term.

## The source Mellin expression and both endpoints

The refined bound follows directly from `GaussSmooth.norm_cexp_gauss` and `norm_intExp_le'`, applied to the actual `Mg`. It does not follow by pretending the coarser `norm_Mg_strip_le` retained the endpoint information. With `L=log x`, `a=+/-a0`, `a0=.002/L`, `b=log(1000)-L`, and `q=delta^2/2`, the normalized summand is bounded by

`exp(q*(beta^2-gamma^2))*(exp(a*beta)+exp(b*beta))*exp((beta-1)*L)/|rho|`.

First replace `1/|rho|` by `1/|gamma|` and `exp(q*beta^2)` by `exp(q)`. The two reflected zeros generally have different norms; the proof never equates them. Weighted reflection then gives the main endpoint factor

`exp(-L/2+a0/2)*cosh(.055*(L+a0))`,

and, separately, the lower endpoint factor

`sqrt(1000)*exp(-L)*cosh(.055*log(1000))`.

The latter follows from the exact cancellation of `L` inside the beta exponent. The two-sided inequality is valid for either smoothing sign. The head uses cosh equal to one and drops only its ordinate damping. Conjugation contributes exactly one factor two. This reproduces equation (3) of the main note with no phase cancellation assumption.

## Closed-count Abel identity and damping

For `f(t)=exp(-q*t^2)/t`, the exact finite identity is

`D = f(H)N(H)-f(A)N(A)+integral_A^H (-f')N`.

It assigns a zero at `A` to the head and a zero at `H` to the shared tail, with full weights. Expanding the count as a finite sum of indicators proves the endpoint convention directly. Since `-f'>0`, the unconditional analytic count envelope `B` can replace `N` except in the exact lower boundary term. Integration by parts then gives

`D <= (B(A)-1069)f(A)+integral_A^H f*B'`.

The discrepancy is nonnegative, so dropping its damping is in the correct direction. Extending this positive ordinary integral to infinity only enlarges the bound for the finite shared sum. It does **not** apply the shared beta strip to actual roots above `H`.

I checked the substitution `R=1/delta`, the split at `R>A`, the `5/A` term, and both improper-integral bounds. For `I0`, the chord bound on `1/w` over `[1,2]` and the bound `1/2` thereafter integrate to `exp(-1)`, with the correct factors after `w=v^2`. For `Ilog`, `log v <= v^2/2` gives `exp(-1/2)/2`. Consequently the stated `.368` and `.304` yield exactly the displayed `Dbar(L)`, with all integrals convergent and positive where used.

## Continuum maximum and independent exact arithmetic

Here `delta=.002/(L*sqrt(L+10))`; its dependence on `L` is retained. On the entire interval `[22.33,35]`, `R>A`, `0<Z<11`, and

`0<Dbar'=(Z+.368)*Z'/(2*pi)<3/L`.

The independent rational check gives `Dbar(22.33)>1`; monotonicity therefore gives `Dbar'/Dbar<3/L` throughout. The main bracket has logarithmic derivative at most `.055+3/L`; adding its other factors gives the strict upper bound `4/L+.055-1/2<0`. The lower-endpoint bracket gives `4/L-1<0`. Positive constant head terms only improve these bounds. This is a continuum proof, not an interpolation from a grid.

My independent scalar script uses a different, coarser pi bracket `[3.14159,3.14160]`, twenty alternating Machin terms, forty atanh terms with powers-of-two reduction, and degree-64 positive exponential Taylor bounds. It imports no author code and evaluates no zeta, L, Gamma, or spectral function. Its upper bounds are:

| Quantity | Independent rational upper bound |
|---|---:|
| `Dbar(22.33)` | `626213549827027/125000000000000` |
| Main L-scaled endpoint | `7379699456579/1000000000000000` |
| Lower L-scaled endpoint | `44515901/20000000000000` |
| Complete L-scaled error | `2392484205639/250000000000000` |

The last value is `.009569936822556`. In particular,

`.0096 - 2392484205639/250000000000000 = 7515794361/250000000000000 > 0`.

The original independent receipt labels the looser safe cap `.0099`. The final pin/comparison script explicitly checks the stronger `.0096` inequality above without modifying that frozen receipt. Thus this review certifies the useful `.0096` cap independently; it does not claim to reproduce the author's slightly sharper final decimal bit-for-bit. At the artificial lower logarithmic endpoint the proof uses an enclosure of `exp(22.33/2)`, not the unjustified substitution `sqrt(5e9)`.

## Remaining errors, all real x, and dependency cut

The inherited high tail starts strictly above `H` and uses the global strip. The new delta is at least the old `.001/L^(3/2)` because `4L >= L+10`, so the retained Gaussian tail and geometric denominator improve; the endpoint prefactor remains within its stated bound. The vertical estimate is unconditional and retains the real lower-endpoint contribution `x^-1/sqrt(1000)`, rather than incorrectly replacing it by `x^-3/2`.

The source good-height limit receives a uniform bound for each finite sum with true multiplicities. The actual upper and lower `PsiLarge` sandwiches have the parameter inequalities recorded in the main note. Their inherited allowances total `.002188002001`; the unnecessary old intermediate `1e-12` is harmless positive slack, not an omitted zero band. The factor `1.000001` conservatively covers the upper sandwich denominator. Both smoothing signs and both sandwiches are covered.

The endpoint fact `exp(22.33)<5e9` embeds the desired finite interval. At `exp(35)` the new estimate overlaps the previously reviewed shared-strip/global estimate `.0081/log x`, which covers every larger real x. The wrapper is the actual floor-based `psiR`, and its natural specialization is separate. No unproved extrapolation of the finite-L monotonicity is needed. The finite prime-certificate work below `5e9` is unchanged.

No narrow-strip or weighted-moment premise from the old low/intermediate argument survives this replacement. The analytic count envelope itself is unconditional and is not the later narrow-strip application of that envelope. The retained head reciprocal certificate remains necessary for this particular improved bound.

## Reproducibility and remaining status

Independent files, in this review's directory:

| File | SHA256 |
|---|---|
| `psi_damped_scalar_independent_20261111.py` | `2D58F1A3ABD679F74CEB043B40A7A6C05E50CA674E4A13CD36B7B16B280F9774` |
| `psi_damped_scalar_independent_20261111.json` | `45E80E90DA51AF9C04DA068B19EBCC9000868CDAEE457972A29698C89CECF151` |
| `psi_damped_final_pin_review_20261111.json` | `237C11C8C84CBE072C2000E6D5F6C980B2637D63A14E1978161BF0CE11EE9E75` |

`psi_damped_final_pin_review_20261111.py` performs the 23 pin checks and the additional exact `.0096` comparison. Its receipt contains all checked paths, hashes, and byte counts. Both independent scripts create their own adjacent receipt exclusively; neither should be rerun over a frozen receipt.

The remaining mathematical inputs and implementation work remain explicit: prove the shared finite spectral certificate; formally replay the retained head; validate the genuine global provider and its transitive axioms; formalize the analytic count, actual-order symmetry, finite Abel identity and scalar integrals; and insert the bounds into the source explicit-formula limit and sandwiches. These are not new authorized axioms. This review accepts a completed conditional paper derivation and its dependency reduction, **not a completed Lean proof, actual shared-strip verification, or Goldbach theorem**.
