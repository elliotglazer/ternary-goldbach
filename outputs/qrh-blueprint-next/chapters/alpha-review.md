# Independent review of the materialized Hurwitz alpha grid

2026-11-11. **PASS for the analytic enclosure construction and the bounded experiment.** No blocking mathematical or implementation defect found. The experiment evaluates deflated Hurwitz inputs on three specified panels and two diagnostic domains. It does not compute character transforms, complete a contour, exclude any zeros, establish production heights, or prove a Lean theorem.

## Frozen inputs and independent checks

Inputs under `work/qrh-campaign/agents/zero-sum/`:

| File | SHA256 |
|---|---|
| `FAMILY_ALPHA_MATERIALIZATION_2026-11-11.md` | `F6A4DBDF9D6EA212B3C93AE282CE1CA1C463A8004D67617240232F2C74958B5C` |
| `family_alpha_materialize_20261111.py` | `FD2C16F0B3C969265E61972D5F2C5772C56E9BABA41B66C34F7F82DC2DE1F0F6` |
| `family_alpha_materialize_20261111.json` | `8E50CDA44BEFE7CE2F38BA3EB3BCDCD1007CE64FC778E7F3ECBA0959FF0C3E48` |

The new review script is `work/qrh-campaign/agents/moebius/alpha_materialization_review_20261111.py`, with a JSON receipt of the same stem. It checks all input hashes before and after execution. It invokes the author's explicit `--recompute` path, which leaves the frozen receipt unchanged. All non-timing result fields, including sample strings, radii, accuracy bits and reported input-error strings, reproduced exactly.

The independent scalar evaluator uses 192 bits, N=768 and M=48, versus the author's materialization parameters 160 bits, N=512 and M=40 and comparison parameters N=640 and M=44. It computes each shifted coefficient from new scalar powers at its actual argument, rather than reusing the author's recurrence across coefficient index. It obtains Bernoulli numbers by a separate library routine and uses a degree-48 exprel expansion near the pole instead of degree 32. It calls no builtin zeta, Hurwitz-zeta, L-function, or numerical derivative routine.

All 512 coefficients on each of the three primary panels were finite and consistent with independent enclosures: 1,536 coefficient checks. All 100 residues on all five domains were also consistent: 500 checks. Exact rational checks verified every residue's cell index, offset bound, positive base, and every panel's sigma and modulus domain. The review also recomputed all 1,536 primary coefficient-input EM error bounds and directly checked each is below 7.8e-41, without trusting the author's maximum-selection routine.

**Overlap is only a consistency check.** It does not establish that either enclosure contains the intended function. That conclusion rests on the analytic derivation and interval-operation audit below. Both numerical implementations use the same FLINT elementary interval library and the same classical EM theorem. They do not constitute independent proofs of interval arithmetic or of Euler–Maclaurin.

## Coefficient identity and enclosure proof

Let D(s,b)=zeta(s,b)-1/(s-1), with its analytic removable continuation at s=1. Set A=16, G=16, K=32 and b_j=16+(2j+1)/32. The required coefficients are

    c_(j,0)=D(s,b_j),
    c_(j,k)=(-1)^k(s)_k zeta(s+k,b_j)/k!  (1<=k<32).

Differentiating the absolutely convergent Hurwitz series gives the alpha derivative identity initially in Re(s)>1. Analytic continuation gives the identity in the present region, with the pole at s=1 removed from the zeroth coefficient. Higher derivatives are nonsingular here because Re(s+k)>=.555+k>1 for k>=1.

For each j, the code initializes exp(-s log(n+b_j)), n=0,...,511, and exp(-s log B), B=512+b_j. Multiplication by 1/(n+b_j) and division by B advance exactly from s+k to s+k+1. Hence the sharing preserves the intended coefficient values. Each operation is interval arithmetic; reuse of the same s can widen the interval but cannot lose containment. The multiplier recurrence is exactly (-1)^k(s)_k/k! and is applied to the complete value **including** the coefficient-input EM error.

For u=s+k and actual Re(s)>=sigma0=111/200, Euler–Maclaurin with M=40 has remainder

    |R| <= 4 |(u)_80| B^(1-sigma0-k-80)
             / [6^80 (sigma0+k+79)].

This follows by bounding the periodic Bernoulli coefficient by 2 zeta(80)/(2 pi)^80 < 4/6^80 and integrating t^(-Re(u)-80) on [B,infinity). Positive real logarithms fix every power; there is no missing imaginary-height exponential. The denominator is positive. The direct paths use the same theorem with their own M and N. The script's exponent, Pochhammer length, denominator, endpoint half term and odd-index Bernoulli corrections all match this formula.

For k=0 the integral term is deflated before evaluation:

    (B^(1-s)-1)/(s-1) = -log(B) exprel((1-s)log(B)).

The sign is correct and the removable value at s=1 is -log B. When |z|<1, the author's exprel polynomial includes degrees 0 through 32, with error exp(|z|)|z|^33/34!. The factorial inequality (34+j)!>=34!j! proves this remainder. Outside that branch the script explicitly checks that s-1 excludes zero before dividing. For k>=1 Re(s+k-1)>=.555, so the undeflated integral term is nonsingular. The whole box through s=1 uses the analytic series branch for k=0; no subtraction of infinite interval values occurs.

Every rational is converted to an outward enclosure. Exponentials, logarithms, powers, Pochhammer factors and coefficient sums retain their interval errors. The `eb` helper adds an axis-aligned square containing the complex disk of the claimed radius. In particular, the tiny EM errors are not discarded before multiplication by large coefficient factors. The max-input-error diagnostic is explicitly **before** Pochhammer/factorial multiplication and is not presented as a final coefficient error.

The actual requested domains have sigma>=111/200 and |s|<1002. For the pole box sigma>=511/512. The review checked the exact rational corner norm bounds, including the height-1000 panel's upper endpoint. A rounded ball may include spurious points infinitesimally left of the rational sigma floor; the EM theorem is asserted for actual panel points, all of which are enclosed by the arithmetic balls. No theorem for the larger spurious rounded domain is required.

## Alpha interpolation and restoration

For each alpha=a/101, 1<=a<=100, the exact cell index is floor(16a/101); all 16 cells are used and every offset from its midpoint has magnitude <=1/32. Horner evaluation of the 32 interval coefficients therefore encloses the degree-31 Taylor polynomial at that alpha.

The real-alpha integral remainder uses

    d_alpha^32 zeta(s,alpha)=(s)_32 zeta(s+32,alpha).

Every intermediate shifted alpha is at least 16 and Re(s+32)>1. The convergent series and integral test bound the derivative factor by

    |(s)_32| [16^(-sigma-32)+16^(1-sigma-32)/(sigma+31)].

The common pole term is independent of alpha, so the same bound applies to D. Using |s+j|<=1002+j, h=1/32 and

    16^(-sigma) [1+16/(sigma+31)] < 2

gives the exact uniform error

    E = 2 product_(j=0..31)(1002+j)/(512^32 32!)
      < 2.660e-26.

The script adds E as a complex error square before restoring the 16 initial powers (n+alpha)^(-s). The shift identity then yields D(s,alpha). This is a uniform entire-panel enclosure argument; no derivative or remainder is evaluated only at the center. Coefficient uncertainty and arithmetic rounding are already present, and E is an additional analytic truncation bound.

## Conditioning and limits of the evidence

The original whole panels remain the acceptance domains. The additional point and radius-2^-20 cases are clearly separated diagnostics. The replay reproduced the author's minimum accuracy figures: grid/direct 0/0 bits at height 100, -2/-2 bits on the wide height-1000 panel, 2/2 bits through the pole, 80/137 bits at the height-1000 point, and 9/9 bits on its narrow panel.

The independent direct evaluator obtained 0, -3, 2, 169 and 8 minimum bits respectively. Its maximum coordinate-radius sums were about .636, .618, 2.005, 1.71e-52 and .000303. Larger N can increase interval dependency width even at higher precision. Thus this check supports the report's practical distinction between a well-resolved point and poorly resolved wide panels. It does not identify an exact split between true function variation and interval overestimation, prove that every future s-model will succeed, or measure transform conditioning.

At the point, the author's grid radius is essentially 2E, as expected from adding E to each coordinate, while the independent scalar enclosure is far narrower. On the wide panels the radii are many orders of magnitude larger. Increasing precision alone cannot remove actual s-variation or dependency width from this interval-expression representation. The interpolation budget is not the observed wide-panel bottleneck.

The receipt records summaries and samples, not 512 serialized coefficient certificates. Deterministic recomputation really constructs all coefficients and evaluates all residues, but a proof checker would need an independently specified enclosure contract and verified arithmetic. No DFT or character output modulo 101 is computed here (the group has 100 characters, of which 99 are nonprincipal). Overlap therefore supplies no zero-free or character-cancellation conclusion. The modest measured cost comparison is a local observation with different N/M choices, not an asymptotic or production-runtime claim.

## Source convention and remaining work

The report correctly distinguishes D's ordinary finite-part continuation from Mathlib's totalized Hurwitz value at s=1. The source regularization involving `1/((s-1) Gammaℝ(s))` can assign a different scalar value there. For a nonprincipal sum, use common-reference Hurwitz differences, prove the identity in Re(s)>1, and extend analytically; the alpha-independent correction cancels because sum chi=0. The previous independent family review records the exact source APIs. A principal combination needs its own pole-cancelled zetaF adapter.

Next-stage work remains a rigorous s-direction analytic model, character transforms with exact indexing and propagated errors, output conditioning checks, complete contours at required heights, and eventual formalization of the arithmetic and analytic adapters. None is supplied by this materialization experiment. No frozen inputs, canonical Lean files, or existing package artifacts were changed.

Reproduce with:

    work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/moebius/alpha_materialization_review_20261111.py
