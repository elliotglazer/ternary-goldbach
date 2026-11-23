# Independent review of the source-faithful Euler–Maclaurin derivation

2026-11-11. **PASS as a paper-level derivation and source-faithful implementation plan.** No blocking mathematical defect found. The identities and error bounds are supported by the argument below, with the stated domains. They are not existing proved evaluator declarations, verified interval operations, or a completed Lean checker. No numerical regeneration or Lean build was performed for this review.

## Frozen scope and source checks

The reviewed report is `agents/major-constants/EM_SOURCE_PROOF_PLAN_2026-11-11.md`, SHA256 `A02698DDD8A5965551CC6A09AA2CF275FE12F2C0236264CB3AD10BF77ABC8485`.

I independently checked the two evaluator hashes and read their implementation:

- `agents/mellin/psi_head_counts_20261111.py`: `D7F187FA357EACA184A2214F8952B396B9D2DF42348580993005B7DA00252A9A`.
- `agents/zero-sum/c5_family_dft_certificate_20261111.py`: `C5125697833CC998C79D854F73D8D6D80B442C6972885C1AC35675F128851FC8`.

The Lean target is the pinned `work/ternary-goldbach` source. Mathlib source was read from the report's manifest-matched checkout at `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`. Direct inspection confirmed the cited statements in HurwitzZeta, Bernoulli, ZetaValues, interval IntegrationByParts, ImproperIntegrals, ParametricIntegral and Analytic/Uniqueness, as well as the target's definition and differentiability theorem for zetaF. This review checked their signatures and mathematical applicability; it did not elaborate a composed Lean proof.

## Finite formula, signs and Bernoulli constant

For one cell, integration by parts gives

    integral_n^(n+1) (t-n-1/2) f'(t)
      = (f(n+1)+f(n))/2 - integral_n^(n+1) f(t).

Summing therefore yields the report's initial formula with a **positive** integral of B1 f'. Repeatedly using `(B_(r+1)/(r+1)!)'=B_r/r!` gives, after degree 2M,

    sum_(n=N)^(L-1) f(n)
      = integral_N^L f + (f(N)-f(L))/2
        + sum_(k=1)^M B_(2k)/(2k)! [f^(2k-1)(L)-f^(2k-1)(N)]
        - integral_N^L B_(2M)({t}) f^(2M)(t)/(2M)!.

The negative final sign is correct. Polynomial integration on individual cells avoids differentiating periodic B1 at its discontinuities. For degrees >=2 endpoint values match; the interior boundary terms telescope, and odd endpoint values above degree 1 vanish. At integers, replacing cell polynomials by their periodic representative is valid either by matching endpoint values or by almost-everywhere congruence. The cited interval integration-by-parts theorem accepts the required complex-valued factors.

With f(t)=(t+a)^(-s), its rth real derivative is `(-1)^r(s)_r(t+a)^(-s-r)`. Thus lower-endpoint odd derivatives contribute positive Bernoulli corrections, while the even derivative preserves the negative remainder sign. The correction indexed k=M has rising factorial length 2M-1 and power B^(1-s-2M). The remainder uses length 2M. The displayed finite sum excludes n=N, so its endpoint B=N+a is correct.

The source `sum_bernoulli (n+1)` isolates `(n+1) B_n` and produces exactly the scripts' recurrence, including B1=-1/2. There is no switch to the other Bernoulli convention. The Fourier formula in ZetaValues has normalized sum

    sum_(n in Z) n^(-2M) fourier_n(x)
      = -(2 pi i)^(2M) B_(2M)(x)/(2M)!.

The zero index is zero, each Fourier factor has norm 1, and positive/negative indices supply the essential factor 2. Summability permits the norm inequality. For M>=1 the positive sum is bounded by the p=2 sum, and `sum_(n=2)^L 1/n^2 <= 1-1/L` supplies a bound of 2 after adding n=1 and taking the limit. Hence

    |B_(2M)(x)|/(2M)! <= 4/(2 pi)^(2M) <= 4/6^(2M).

Using pi>3 gives the report's coarse constant; no numerical zeta-value assumption is required. The weaker non-strict inequality is sufficient throughout.

## Improper integral and analyticity

The remainder is

    R(s)=-(s)_(2M)/(2M)! integral_N^infinity
           B_(2M)({t}) (t+a)^(-s-2M) dt.

For 0<a<=1, N>=1, B=N+a>1 and sigma>1-2M, positivity of t+a gives the exact complex norm `(t+a)^(-sigma-2M)`. The Fourier bound and the elementary power integral prove absolute integrability and

    |R(s)| <= 4 |(s)_(2M)| B^(1-sigma-2M)
                  / [6^(2M)(sigma+2M-1)].

The domain and positive denominator are sharp for this particular absolute-integrability argument; no assertion is made at sigma=1-2M. On Re(s)>1, the finite-cell formula passes to the limit: the derivative endpoint terms vanish, the finite sums converge by the Hurwitz HasSum theorem, and integrability justifies convergence of the truncated remainder integrals, for example by dominated convergence on their indicator functions. Translating t to t+a gives the cited power integral with lower endpoint B. This establishes the EM identity in the convergence half-plane.

For analyticity on Omega_M={Re(s)>1-2M}, choose a neighborhood of s0 with a real-part lower bound sigma_min strictly inside Omega_M. The derivative of the exponential kernel introduces log(t+a). Choose `0<epsilon<sigma_min+2M-1`; then

    log(t+a)(t+a)^(-sigma_min-2M)
      <= (1/epsilon)(t+a)^(-sigma_min-2M+epsilon)

is integrable. The polynomial factor and its derivative have uniform bounds on a closed local ball. Alternatively prove the integral alone analytic and multiply by the polynomial afterward. The periodic factor is bounded and measurable. These facts supply the uniform neighborhood derivative majorant, base integrability and measurability required by `hasDerivAt_integral_of_dominated_loc_of_deriv_le`. Despite its prose referring to a real parameter, the actual signature uses an RCLike scalar and supports the complex parameter here. Complex differentiability on the open half-plane implies local analyticity.

The subsequent box bound uses B>1 to replace sigma by its lower bound in the numerator and the positive denominator. Bounding each |s+j| by S+j is valid. An error disk of radius E is contained in the coordinate square [-E,E]^2, so the scripts' square insertion needs no extra square-root-of-two factor. The converse bound is not used.

## Actual function correspondence across 1

For the head evaluator, a=1, the head sum is exactly 1,...,N and B=N+1. With M=32 the finite entire expression is

    g(s)=(s-1) F[1,N,32](s)+B^(1-s).

The code includes correction lengths 1,3,...,63 and uses length 64 for its error. At height 1500 the chosen N is 500. The target source defines `zetaF` by updating `(s-1) riemannZeta s` to value 1 at s=1 and proves it differentiable everywhere. The Hurwitz shift 1 agrees with shift 0 on UnitAddCircle, and the source identifies shift 0 with riemannZeta.

On Re(s)>1, multiplication of EM gives `zetaF=g+(s-1)R`. All three terms are analytic on Re(s)>-63, an open convex half-plane. They agree near 2, so the cited identity principle extends the equality throughout that half-plane. At 1 the right side is exactly 1. This uses no value of totalized riemannZeta at 1 and creates no extra zero there. The actual contour's sigma floor -.1 is well inside the remainder domain.

For c5 the base order `[64+1/5,64+2/5,64+4/5,64+3/5]` and shared reference B0 match the code. Writing ell_j=log B_j-log B0, the correction

    -B0^(1-s) ell_j exprel((1-s)ell_j)
      = [B_j^(1-s)-B0^(1-s)]/(s-1)

has the correct sign and removable value -ell_j. It subtracts the **same** pole from each component. The resulting Q_j is analytic on Re(s)>-39. Individual Q_j(1) must not be equated to the source's assigned Hurwitz value at 1: the source differentiable regularization uses `1/(s-1)/Gammaℝ(s)`. The report correctly avoids that statement.

Instead, Q_j-Q_0 agrees with the source Hurwitz difference on Re(s)>1. Both are analytic on the full half-plane, since the source explicitly proves every Hurwitz difference entire. Analytic uniqueness extends the equality through 1. A coefficient sum of zero reduces to such differences. The three positive-sign DFT vectors each have zero sum, use all units in generator-2 order, and carry precisely the factor 5^(-s), with no division by 4. The source `ZMod.LFunction` identity therefore has the correct normalization. Constructing and identifying the three actual characters remains a formal task. Their parity is odd/even/odd, with conjugation swapping the two odd characters; the report makes no false same-character conjugation claim.

## Exprel and the separate finite-function Taylor layer

The c5 recurrence gives degrees 0 through 18, not 19. The bound

    |exprel(z)-sum_(r=0)^18 z^r/(r+1)!|
      <= exp(|z|)|z|^19/20!

follows from `(20+j)!>=20!j!`; it includes z=0. The error must propagate through multiplication by B0^(1-s) ell_j and through the DFT, as it does in the script. Pole cancellation does not cancel arbitrary interval errors. The report correctly states that a weaker generic exponential tail lemma is not a substitute for this factorial-normalized bound.

The head Taylor layer expands only g, which is entire. A radius-1 disk may extend left of the actual contour floor -.1 without invalidating that Taylor argument. The termwise majorant bounds every positive-base power using Re(s)>=Re(c)-1, every rising factor by |c|+1+j, and |s-1| by |c|+2. These are the quantities in `outer_bound`.

For h<=.1, Cauchy estimates give the degree-23 tail `C h^24/(1-h)` on the inner disk. The actual EM error is bounded separately at contour points using S=|c|+h, then added to this tail. No EM identity on the larger outer disk is required. However, the mathematical coefficients still need to be identified with the truncated-series arithmetic output. Calling `acb_series` is not a proof of that identification, and the report explicitly leaves the corresponding wrapper and interval semantics unimplemented.

## Status and implementation boundary

The report supplies a complete paper argument for the two analytic evaluator identities and their displayed remainders, with a correct route to the actual named source functions. The source ingredients exist at the cited APIs. The finite-cell theorem, coefficient recurrence adapter, Fourier norm wrapper, improper-limit and parameter-integral assemblies, exprel theorem, exact c5 character construction, finite-g Taylor coefficient bridge and error wrappers are still new Lean work.

Verified interval exp/log/series operations, rational/dyadic arithmetic, whole-panel half-plane interpretation and the argument-principle/polygon checker are further obligations. No success of an external Arb computation discharges them. The review adds no spectral assumption or numerical zero-count conclusion. Frozen reports, evaluator scripts and canonical sources were left unchanged.
