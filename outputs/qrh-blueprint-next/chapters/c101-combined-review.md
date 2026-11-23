# Independent review of the conductor-101 Cauchy/alpha block

2026-11-11. **PASS for the stated external local nonvanishing certificate.** No blocking mathematical or implementation defect found. The accepted domain is precisely

    s=111/200+i t, 7999/8 <= t <= 8001/8,

for all 99 nonprincipal, hence primitive, characters modulo 101. This is a line segment, not a rectangle or closed contour. There is no winding, zero-count, production-height, general-family, or Lean claim.

## Frozen artifacts and execution

Reviewed inputs in `work/qrh-campaign/agents/zero-sum/`:

| File | SHA256 |
|---|---|
| `C101_CAUCHY_ALPHA_BLOCK_2026-11-11.md` | `4F73C1FA9C8D8C1C5ECCD22DB0348FCAC52108C126B840E5BC419FCD9968BF5B` |
| `c101_cauchy_alpha_block_20261111.py` | `FD75DAC17AF6735E9A5AE72E5A47096592609D2371CD5A65643B544F5B8F4E11` |
| `c101_cauchy_alpha_block_20261111.json` | `087C2577D42CFB22CA9BA2E0E00D17BD9C5C9585C4BAB854920A3E26131E2F84` |

The independent script is `agents/moebius/c101_model_review_20261111.py`, with its receipt at the same stem ending `.json`. It verified input hashes before and after execution. Full author recomputation with `--recompute` reproduced every non-timing receipt field, including every panel's image diagnostic and witness. The frozen receipt was not overwritten.

The review then independently rebuilt a model for every character using:

- 192-bit elementary interval arithmetic rather than 160 bits;
- direct scalar Hurwitz EM with N=768, M=48, instead of the alpha grid with N=512, M=40;
- natural residue order 1,...,100 and independently computed discrete-log indices;
- raw Hurwitz integral terms, not common-pole subtraction; all sample points are far from s=1;
- trigonometric root enclosures instead of complex-exponential root enclosures;
- 48 Cauchy samples/coefficients rather than 64, with its own larger exact alias bound.

All 159 stored whole-panel witnesses passed this alternative model without additional subdivision. Its exact error allowance is

    480677261974043443888714850232397
    / 54658689212084666454346088255663646965760

or approximately 8.79416006683e-9, strictly below 1e-8. The minimum accepted coordinate lower-bound diagnostic was about .00304541046. Independent processing after reusable logarithm setup took 8.920 seconds on this run; this is not a production-throughput estimate.

This is a second entire-panel enclosure/half-plane check, not merely a comparison of overlapping values. Both implementations still rely on the same FLINT elementary arithmetic and the reviewed classical EM/Cauchy mathematics. Neither is a formally verified checker.

## Exact character coverage and normalization

Trial divisibility through 10 proves 101 prime. Repeated multiplication by 2 enumerates each nonzero residue once and returns to 1 after 100 steps; 2^50=-1. The independent script checked the discrete-log identity on all 10,000 products of two units. For each k=1,...,99, weights exp(2 pi i k log_2(a)/100) therefore define a multiplicative character with value zero at residue zero. Distinct k give distinct nonprincipal characters. The only proper divisor of 101 is 1, so all are primitive. There are exactly 99, not 100, in this certificate.

Their parity is (-1)^k. Conjugation maps k to 100-k, including the real character k=50. The stored rows contain every k=1,...,99 once, with the correct parity. No same-character reflection is assumed for a nonreal character.

The positive-sign transform has no normalization factor 1/100. Its scale is 101^(-s), as in the Dirichlet/Hurwitz residue identity. The author's inputs use generator order; the independent evaluator uses numerical residue order and the checked discrete-log permutation. Both enclose the same exact character values. Root intervals need not obey algebraic root identities as interval equalities: they contain the exact roots, and the mathematical orthogonality identities refer to those exact roots. Arithmetic dependence can widen the enclosures but does not invalidate inclusion.

## Domains and actual-function growth

With center c=111/200+1000i, the radii are R=1/2, rho=1/4 and r=1/8. Their distinct sigma floors are 11/200 on the outer disk, 61/200 on the sampling circle, and 111/200 on the requested vertical segment. The code correctly changes the EM floor to 61/200 and uses 61/200+k for coefficient index k. It does not retain the earlier .555 floor at the leftmost sample.

I read the pinned `TernaryGoldbach/Explicit/LGrowth.lean` directly. Its `norm_LFunction_le` has hypotheses `[NeZero q]`, chi nonprincipal, and Re(s)>0, and concludes

    |L(s,chi)| <= (q+1)|s|/Re(s).

There is no spectral premise in this declaration. The preceding `LFunction_eq_mul_Iint` establishes the Abel-integral identity by continuation from Re(s)>1. Thus the bound applies to the actual continued L-function on the entire outer disk. With q=101 and |s|<=1000+111/200+1/2=200211/200, the exact common bound is

    M=102*(200211/200)/(11/200)=1856502.

Nonprincipal L is entire, so it is analytic on a neighborhood of the closed outer disk. No completed-L, gamma-factor, or s-1 normalization enters. M bounds actual L, not the finite EM approximation. EM only encloses sample values; it is not evaluated or assumed valid with floor .055 on the outer circle.

## Sample enclosure and alpha errors

The coefficient construction was reviewed in `moebius/FAMILY_ALPHA_MATERIALIZATION_REVIEW_2026-11-11.md`, SHA256 `34567872FFA5DA524F265D09C6E597B4D3EEC68FBB4B568F4F5619A8D91D1D50`. The EM source bridge was reviewed in `moebius/EM_SOURCE_PROOF_REVIEW_2026-11-11.md`, SHA256 `5D261401E8D4490DCE78CF284418E840253EB47ADBF0C9654E4A794B75C87CF1`. Their analytic arguments apply with the new sigma floor; their earlier numerical domain is not silently reused.

Every exact sampling point has sigma>=61/200 and |s|<1002. For each coefficient the EM bound uses the shifted real-part floor, positive denominator, complete Pochhammer length, and propagated interval multiplication. At alpha-grid centers >=16, the real-alpha Taylor remainder has bracket

    16^(-sigma-32)+16^(1-sigma-32)/(sigma+31)
      < 2*16^(-32),

because sigma>0 and 16/(61/200+31)<1. Thus the same rational E remains valid, now for a newly justified domain:

    E=2 product_(j=0)^31(1002+j)/(512^32*32!) <2.660e-26.

All coefficient EM errors, exprel errors, root errors, and elementary arithmetic rounding remain in the intervals before and after E is added. The whole-sample disk is not inferred from its center. Rounded root boxes may protrude infinitesimally beyond the exact circle, but only exact sample points require the analytic sigma and modulus bounds; the formula arithmetic encloses those points.

The author uses ordinary deflated Hurwitz finite parts. Their nonprincipal combination equals actual L by the convergence-region series identity and analytic continuation, or by the source's entire Hurwitz differences. This does not identify individual deflated values at s=1 with Mathlib's differently totalized Hurwitz convention. The independent evaluator avoids this numerical cancellation by using raw Hurwitz terms at sample points far from the pole, while relying on the same source correspondence for their nonprincipal sums.

The auxiliary alpha-only budget is valid: each square error has norm <=2E; 100 unit-modulus weights contribute <=200E, the scale has norm <=1, and the normalized Cauchy-polynomial amplification is less than sum_(n>=0)(r/rho)^n=2. Hence this contribution is <400E<1.064e-23. It is already carried in the sample and coefficient intervals; adding it again is unnecessary. This estimate does not cover other errors by itself.

## Cauchy aliasing and every-panel acceptance

Write the actual Taylor series at c as f(c+z)=sum_l a_l z^l. Cauchy's estimate on radius R gives |a_l|<=M/R^l. For m equally spaced exact roots omega_j, the normalized discrete coefficients satisfy

    b_n=(1/m) sum_j f(c+rho omega_j) omega_j^(-n)
       =sum_(ell>=0) a_(n+ell*m) rho^(n+ell*m), 0<=n<m.

Absolute convergence at rho<R justifies interchanging series and the finite sum. The model polynomial is sum_(n<m) b_n(z/rho)^n. The true Taylor tail contributes at most `M(r/R)^m/(1-r/R)`. Aliases contribute at most

    M/(1-r/R) * (rho/R)^m/(1-(rho/R)^m).

Their sum is exactly the report's formula. The independent script verified the author's exact Fraction and its bound below 1.4e-13, then applied the same derivation with m=48 for its alternative model. The larger independent bound is still amply small enough to accept every stored panel.

Each computed sample interval encloses the actual f value. Transforming those intervals with enclosed exact roots encloses every exact b_n, including sample and rounding errors. Horner evaluation on the full imaginary interval encloses the entire polynomial image; adding the analytic error square encloses the actual L image. A strict coordinate sign then excludes zero at every point of that interval. The proof uses the enclosure argument, not the author's 297 endpoint/center overlap diagnostics.

Exact checks verify ordered, nonempty panels, starting at -1/8 and ending at 1/8, with matching adjacent endpoints for each character. Every stored witness is a valid axis/sign pair. Each character is independently allowed its own partition. The accepted interval endpoints are included because the closed interval boxes and strict half-plane tests include them. No image-vertex homotopy or winding calculation is needed for this local claim.

## Interpretation and remaining obligations

The reported 159 accepted panels, 219 model calls, maximum three panels per character and depth two reproduced. Exact work counts 64*99*100 and 99*64*64 match the stated direct transforms. Timings remain host-specific. The sample/alias accuracy comparison is useful for this block, but does not prove future blocks accept or estimate a production runtime.

The result answers the bounded method question: with a source-supported actual-L growth bound, alpha interpolation and Cauchy modeling can overcome the raw s-interval conditioning seen in the earlier experiment while retaining the full quarter-unit target. It does not establish a whole contour, zero count, larger height range, or any production certificate. The JSON stores panel summaries; sample values and coefficient tables are regenerated, not independently serialized as a formal proof object.

Remaining Lean work includes the finite character adapter, source-faithful EM and Cauchy coefficient theorems, interval elementary operations and root-enclosure semantics, and a checker for the regenerated strict inequalities. Full contour assembly and general-conductor/high-height evaluation are separate tasks. No canonical source, frozen artifact, or existing package was edited.

Reproduce the independent check with:

    work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/moebius/c101_model_review_20261111.py
