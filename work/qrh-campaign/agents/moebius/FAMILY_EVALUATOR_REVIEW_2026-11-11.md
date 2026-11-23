# Independent review of the conductor-five family pilot

2026-11-11. Verdict: **PASS for the stated external, bounded certificate and the rational interpolation budget.** No mathematical or acceptance-code defect was found. This is not a Lean theorem, a production-height certificate, or a successful computation for the complete conductor family.

The author report and its four inputs were SHA256-checked before independent evaluation. All paths below are relative to `work/qrh-campaign/agents/`.

| Frozen input under `zero-sum/` | SHA256 |
|---|---|
| `FAMILY_EVALUATOR_INTERFACE_2026-11-11.md` | `DCA03CD8C62E19FBA574F92CF0AEAA818D7DE4A6954B5D8CDF4150C4F62FDD5E` |
| `c5_family_dft_certificate_20261111.py` | `C5125697833CC998C79D854F73D8D6D80B442C6972885C1AC35675F128851FC8` |
| `c5_family_dft_certificate_20261111.json` | `E2CB12AD11F75CF64957864B1D64E88B347611EB09C4A3C419BF95B07A5D60E2` |
| `family_hurwitz_grid_budget_20261111.py` | `A21FC69B86E5F947BEF854BD92B6DE3896C81723E07EBF120A487485CE01A586` |
| `family_hurwitz_grid_budget_20261111.json` | `EEE412CC1DE72F6C0AB487825559F1E4F5D186685C7A059AF97DFE3DB3E579D5` |

## Independent execution and scope

The author's `--replay` completed with exit 0, all 3,034 panels accepted and factor windings `[0,0,0]`, in 1.381 seconds. No builtin zeta or L evaluation occurs on this replay path.

The new `moebius/c5_family_review_20261111.py` independently checked all rational geometry and every whole panel. It used 192-bit elementary FLINT balls, N=80 and M=24, instead of the author's 128 bits, N=64 and M=20. It used natural residue order `[1,2,3,4]` and direct Hurwitz integral pole terms, avoiding the author's common-subtraction and exprel implementation. The boundary boxes avoid s=1, so these direct terms are legitimate there. Bernoulli numbers came from the library's Bernoulli routine instead of the author's rational recurrence. No builtin zeta or L routine is called.

This alternative evaluator accepted all original half-plane witnesses after subdivision into 4,872 leaves, maximum additional depth 3, with 6,710 vector calls. It completed in 4.612 seconds. An independent exact winding calculation using a ray rotated by 90 degrees gave `[0,0,0]`; positive/negative crossing counts were `[1,1]`, `[0,0]`, `[2,2]`. The exact side lengths were `289/200,24,289/200,24`. Results are in `moebius/c5_family_review_20261111.json`.

The two implementations still share the underlying FLINT elementary interval library and the classical Euler–Maclaurin theorem. This is an independent formula/parameter/topology replay, not a second independently implemented interval arithmetic library. Acceptance establishes, externally and subject to those analytic/arithmetic foundations, absence of zeros for all three nonprincipal characters modulo 5 in the **closed** rectangle `[111/200,2] × [-12,12]`. The report does not establish any production Hcert, any larger height, or the general manifest's completeness by this pilot.

## Characters, pole cancellation and source correspondence

The powers of 2 modulo 5 give every unit exactly once: `[1,2,4,3]`. For k=1,2,3 the definition chi_k(2^j)=i^(kj) gives all three nonprincipal characters. As 5 is prime, a character induced from a proper divisor would be principal; these three are primitive. In natural residue order their exponents of i are respectively `[0,1,3,2]`, `[0,2,2,0]`, `[0,3,1,2]`. The independent script verifies multiplicativity on all 16 unit products, their distinct nonprincipal indices, parity, and conjugation. Their values at -1 are -1,+1,-1. Conjugation exchanges k=1 and k=3 and fixes k=2. No negative-height reuse within a fixed nonreal character is assumed.

The DFT is a positive-sign character sum with **no factor 1/4**. Its only normalization is 5^(-s), as follows by splitting the absolutely convergent Dirichlet series into residues for Re(s)>1. All roots of unity are exact Gaussian integers. The report's wording “all-zero character” means the zero dual index k=0, i.e. the principal character; it does not denote an identically zero character.

Write B_alpha=N+alpha, B0=N+1/5 and d=log(B_alpha)-log(B0). The integral-term difference is

    (B_alpha^(1-s)-B0^(1-s))/(s-1)
      = -B0^(1-s) d exprel((1-s)d).

The minus sign is correct. At s=1 its removable value is -d. Every character sum has zero coefficient on the common term B0^(1-s)/(s-1), so the pole cancels for all three factors. The author's exprel polynomial ends at degree 18. Its omitted terms are bounded by exp(r) r^19/20!, since (20+j)! >= 20! j!, uniformly for |z|<=r. The coordinate error square contains the complex error disk.

**Formal adapter restriction:** identify the computed nonprincipal combinations with the source L-functions first on Re(s)>1 and then by analytic continuation. Do not identify each individual pole-subtracted input at s=1 with Mathlib's totalized `hurwitzZeta` value. The source regularization subtracts `1/((s-1) Gammaℝ(s))` instead of `1/(s-1)`; the resulting difference at the pole is independent of alpha and cancels in the nonprincipal sum. The pilot's analytic pole cancellation is valid without assuming equality of those individual totalized values. Its interior analyticity follows from the entire nonprincipal L-functions, not from evaluating raw Hurwitz zeta at its pole.

The parallel source inventory supplies precise adapter APIs in `Mathlib/NumberTheory/LSeries/HurwitzZeta.lean`: `differentiableAt_hurwitzZeta_sub_one_div` (line 90), `tendsto_hurwitzZeta_sub_one_div_nhds_one` (97), and especially `differentiable_hurwitzZeta_sub_hurwitzZeta` (104). Express each nonprincipal sum using differences against alpha0=1/5 and sum chi=0. These differences are entire in the source convention. The identity from Re(s)>1 can then extend across 1 using analytic uniqueness, for example `AnalyticOnNhd.eqOn_of_preconnected_of_eventuallyEq` in `Mathlib/Analysis/Analytic/Uniqueness.lean` (224). These source pointers were supplied by the independent major-constants inventory; this review did not execute a Lean adapter.

The pinned [FLINT vector source](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/l_vec_hurwitz.c) confirms the report's conjugate/DFT/conjugate convention and the special deflation at exactly s=1. The [indexed DFT source](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/dft.c) labels its indexing lexicographic Conrey and uses a product transform. The pilot defines its own indices; it does not rely on an unproved correspondence to those library indices. A general adapter must still prove that correspondence.

## Euler–Maclaurin enclosure and complete boundary

For B=N+alpha>1, M>=1 and actual sigma>=sigma0 with sigma0+2M>1, the classical Hurwitz Euler–Maclaurin remainder obeys

    |R| <= 4 |(s)_(2M)| B^(1-sigma0-2M)
           / (6^(2M) (sigma0+2M-1)).

Indeed the periodic Bernoulli coefficient is bounded by 2 zeta(2M)/(2 pi)^(2M) < 4/6^(2M); integrate t^(-sigma-2M) from B to infinity. The positive real base uses its real logarithm, so no extra ordinate exponential appears. Both evaluators use this valid bound with sigma0=111/200, their respective M, and interval Pochhammer products. Outward rounding can extend a box slightly left of the exact path; the analytic claim only needs the actual rational path, whose points satisfy sigma>=sigma0. The arithmetic boxes enclose these actual points and all formula evaluations.

Exact parsing verifies adjacent domain endpoints, closure at `(111/200,-12)`, permitted axis-aligned sides, strict counterclockwise direction, and the entire length of each side. It checks three witnesses and three vertex pairs per row, and exact sharing of image vertices for every character. Thus there is neither a missing side segment nor an omitted primitive factor.

Each strict coordinate half-plane contains the true image of the whole panel and both chosen rational polygon vertices. Convexity supplies a homotopy from the true image path to the polygon edge avoiding zero. Consecutive panels share the same chosen vertex; hence these homotopies fit continuously. Vertices need not equal the true endpoint values. Further subdivisions in the independent replay keep the same witness, so preserve this argument. Exact half-open ray crossing counts the closed polygon even when a vertex lies on the ray. Entirety and the argument principle then identify winding with the number of interior zeros including multiplicity. The boundary is separately nonvanishing, which also covers both height endpoints. No RH, simple-zero, spacing, builtin-L, or sampled-zero assumption enters.

## Residue-grid error

The reported bound is valid for real interpolation in alpha, not an unproved complex-alpha estimate. After shifting by A=16, the 16 cell centers give |d|<=1/32 and every intermediate argument is >=16. For K=32,

    d_alpha^K zeta(s,alpha) = (-1)^K (s)_K zeta(s+K,alpha).

The final Hurwitz series is absolutely convergent since sigma+K>1. The real-interval Taylor remainder, using the series followed by the integral test, gives

    |R_K| <= |(s)_K| h^K/K!
       * [16^(-sigma-K)+16^(1-sigma-K)/(sigma+K-1)].

Subtracting 1/(s-1) does not change any positive-order alpha derivative; the k=0 coefficient must be regularized at s=1. On the specified region sigma in [.555,2], |t|<=1000, we have |s|<1002. The bracket is <2*16^(-K), because 16^(-sigma)<=1 and 1+16/(sigma+31)<2. The independent exact arithmetic verifies cell endpoints, these inequalities, and

    E = 2 product_(j=0..31)(1002+j)/(512^32 32!)
      < 2.660e-26,
    300000 E < 7.978e-21.

Its diagnostic value is 2.6591856068560343e-26. These are stronger checks than the author's script assertions E<1e-25 and 300000E<1e-19, and match the sharper written claims. Absolute errors sum through the character transform since |chi|=1; c^(-sigma)<=1 is harmless. This bound does not include coefficient errors, elementary rounding, s-direction panel errors, or relative error near a zero.

The [precomputation initializer](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/hurwitz_precomp_init.c) and [evaluator](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/hurwitz_precomp_eval.c) support the stated shifted midpoint-grid pattern. The count of 512 precomputed coefficients is 16*32. Each residue then needs its 16 initial powers and a degree-31 polynomial evaluation, before the DFT. These operation counts are not timings, and the c5 contour did not implement that interpolation optimization.

## Remaining obligations

Production requires the exact conductor/character manifest and source identification, rigorous coefficient enclosures and s-block errors, sufficient heights for every manifest entry, complete accepted contours, and all transform-index adapters. Elementary interval arithmetic and the argument-principle checker remain to be formalized. The paper's proposed manifest and critical-line alternative are feasibility contracts, not completed certificates. The general-character growth and high-height evaluators are not supplied by this small pilot. No frozen input or canonical Lean source was changed during this review.

Reproduce the independent check with the existing interpreter:

    work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/moebius/c5_family_review_20261111.py
