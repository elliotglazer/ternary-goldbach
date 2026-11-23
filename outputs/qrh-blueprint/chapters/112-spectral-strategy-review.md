# Independent review of the spectral certificate strategy

Date: 2026-11-11. Result: the rectangle certificate, factorwise checker design, and separate dynamic base-gap height lemma are mathematically sound as sufficient conditions. **One local scope correction is required in section 3's aggregate Euler identity at conductor one.** No actual finite spectral assertion is established, and no performance improvement is certified.

## Frozen inputs

Reviewed `agents/zero-sum/` files:

| File | SHA256 |
|---|---|
| `RESUME_SPECTRAL_CERTIFICATE_STRATEGY_2026-11-11.md` | `9eadb2e516e16c33ab0b0b618c771723712716aba38b54f4965a37bf158a46cb` |
| `resume_spectral_strategy_20261111.py` | `ecc6c0547eddcfec870f76894428f9c170a93703238c9ee3067dae53221f631c` |
| `resume_spectral_strategy_20261111.json` | `2ca6c4c7f949c658284f85a77da5d7d3470d80b80d04447d047e1fca9c8b386f` |

No frozen input was changed. The independent bounded script and JSON are `moebius/spectral_strategy_review_20261111.py` and `.json`. It uses integer ceiling quotients and cross multiplication to verify every q from 1 through 150000, and reproduces the exact minimum margin. It does not import the author's code or evaluate an L-function.

## Rectangle implication

For c>1, every primitive character is nonprincipal, so each factor L(s,chi) is entire. Their finite product is entire. Boundary nonvanishing also ensures the product is not identically zero. For c=1 the correct function is the entire regularization zetaF, not raw zeta. In the pinned source, `Explicit/ZetaGrowth.lean:17` defines zetaF by updating `(s-1)*riemannZeta(s)` to 1 at s=1; `zetaF_one` at line 22 and `differentiable_zetaF` at line 30 supply precisely the needed facts. `DirichletCharacter.differentiable_LFunction` is already used for nonprincipal factors in `Explicit/Datum.lean:700` and `Explicit/ExplicitFormula.lean:314`.

Let b=111/200, H=Hp(c), and T>H. The positively oriented boundary of `[b,2] + i[-T,T]` is a simple closed piecewise smooth contour. Holomorphy on a neighborhood of its closure, nonvanishing on the contour, and winding number zero imply zero interior zeros counted with multiplicity. The positivity of holomorphic zero orders rules out cancellation between factors. A factor zero with b<beta<1 and |gamma|<=H lies strictly inside, including when gamma=0 or |gamma|=H. Thus every requested nontrivial zero has beta<=b.

The certificate is sufficient but stronger than the target: it also demands nonvanishing at beta=b on the contour. A true zero there would prevent this particular certificate from succeeding while remaining consistent with the target. The note correctly forbids shifting the left edge right without treating the missed strip. It correctly retains T>H when moving the horizontal edges. Neither global QRH nor a prior zero list is needed for this implication.

The rectangle also includes s=1. The value zetaF(1)=1 prevents a spurious zero or pole there. Other zeros inside the rectangle, if any, would also prevent acceptance; counting more possible zeros does not weaken a successful zero-count certificate. The source's nontrivial-zeta carrier bridge is visible in `Explicit/ZetaZeroSums.lean:39`; for the requested implication alone, multiplication by the nonzero factor s-1 at a strict-strip zero suffices.

## Required checker details

The factorwise panel method is valid with these explicit interpretation requirements:

1. The primitive-character enumeration is exhaustive and correctly indexed. Its normalization must agree with the analytic L-functions, not just with a library's names.
2. The contour panels cover the entire boundary in positive order, with no omitted segment. At each junction there is one shared rational polygon vertex, used by both neighboring panels; the first and last vertex agree.
3. A panel's strict rational separating half-plane contains every true function value along that panel and both corresponding polygon vertices. The polygon segment then lies there by convexity. Straight-line interpolation between the true image and polygon image stays nonzero, and the shared endpoints make these panel homotopies a continuous homotopy of closed curves.
4. Exact winding computation handles all ray and vertex degeneracies, as the note requires. No endpoint-only enclosure can replace the uniform panel theorem.
5. Holomorphy on the enclosed region and boundary nonvanishing connect each polygon winding to a nonnegative zero count. Summing exact winding integers to zero then forces every factor's count to vanish. This last step cannot be replaced by an assumption that approximate winding estimates are nonnegative.

These clarify the proposed contract; they are not claims that such a checker exists. Shared vertices are implicit in the note's word "polygon" and must become explicit data constraints in an implementation. A batch-level record is equally valid only if its analytic theorem supplies the corresponding holomorphic product, boundary nonvanishing, and winding identity.

For the quadrature alternative, the normalized contour integral is `(2*pi*i)^(-1) integral F'/F`. After boundary nonvanishing and the argument principle prove it is an integer, an enclosure of its real value inside (-1/2,1/2) forces zero. A complex interval implementation may instead bound its real part and use proved integrality. This does not license ignoring quadrature errors or poles.

## Conjugation and the conductor-one correction

Conjugation permutes primitive characters of fixed conductor and satisfies `L(conj(s),chi)=conj(L(s,conj(chi)))`. Therefore the full product has real-conjugation symmetry. It can reuse reflected evaluations, but individual complex factors need not be symmetric themselves. A reflected panel reverses contour orientation, so the checker must transport orientation as well as function values. The full rectangle argument includes both signs and real zeros; no unsupported doubling is needed. Later reflection of the zero strip preserves conductor and absolute ordinate and uses the conjugate character when appropriate. The common all-character finite premise is enough for this step.

**Correction:** section 3 writes the aggregate Euler-series formula without excluding c=1, although section 1 defines F_1=zetaF. For Re(s)>1 the correct formula at that conductor is

    -F_1'(s)/F_1(s)
      = sum_(n>=1) Lambda(n)n^(-s) - 1/(s-1).

The displayed uncorrected formula is valid for c>1. This follows directly from the product definition and is supported by `Explicit/ZetaDatum.lean:222`, `logDeriv_zetaF_eq`. Restricting the displayed aggregate formula to c>1 and handling c=1 separately repairs it. The rectangle proof, factorwise checker, and height lemma do not use the erroneous conductor-one specialization and remain valid. A future aggregate evaluator must include this correction. Likewise the additive deflation `zeta(s)-1/(s-1)` is not itself zetaF and cannot silently replace it as the counted function.

## Producer APIs and limits

The [Arb 2.23 documentation](https://arblib.org/acb_dirichlet.html) confirms that `acb_dirichlet_l_vec_hurwitz` produces the full phi(c)-length vector via Hurwitz zeta and a DFT, in lexicographically ordered Conrey logs. It documents Taylor jets and additive pole deflation separately. These are producer components, not a proof of a whole-panel remainder bound or an exhaustive primitive filter. The implementation must verify the index conversion and primitive mask. I also checked the successor FLINT page; the older explicit API already supports the note's limited availability claim.

The Hurwitz expansion for nonprincipal characters requires analytic cancellation at s=1. The proposed deflated handling is mathematically appropriate when accompanied by that proof. The absolutely convergent aggregate Euler series only applies to Re(s)>1; it supplies no evaluation on the left edge .555. The direct-product relative enclosure `(1+rho)^n-1` is a valid worst-case bound, so the stated loss for that particular rule is real. It is not an algorithmic lower bound. No Galois-orbit shortcut for transcendental L-values follows from character-value conjugacy alone.

[Büthe's paper](https://arxiv.org/abs/1308.6704) presents a separate completeness method for proposed zero lists; its availability is correctly distinguished from possessing a list or checker for this family. The prior independently reviewed Platt-domain comparison remains applicable. No historical computation is used as a premise of the proposed rectangle implication.

## Separate dynamic-height lemma

Retain `1 <= q <= 150000`, `0 <= U <= 1200000`, and positive primitive c on actual Gauss support. The frozen pointwise note has original modulus m=q or 2q, c divides m, and hence c<=2q. Its cutoff is

    H(q,U)=max(250,ceil(242U/(7q))).

Monotonicity in U reduces the bound to `A=290400000/(7q)`. The difference from `50000000/q` is `59600000/(7q)>56`. Since ceil(A)<A+1, the ceiling has more than 55 of strict spare height. Also `50000000/q >= 1000/3 > 250`, so the floor has more than 83 of spare height. Consequently

    H(q,U) < 50000000/q <= 100000000/c.

This is an analytic proof for every allowed U, not a sampling argument. The independent all-q integer check reproduces the minimum full-prefix difference `8364774/149767`, attained at q=149767 with H=278. It also confirms the reported input hashes.

A finite upper-real-part bound through the common height `1e8/c` would therefore cover every zero used by this particular base-gap cutoff, including both signs and the closed endpoint. All conjugate characters have the same conductor and common height, so the reflected .445 lower bound and the already reviewed 13/8 transform bound retain their hypotheses. The pointwise cutoff itself and its high-zero tails do not change. This height implication does not reduce the major-moment original Hp profile, prove a finite strip, replace global QRH for high zeros, or discharge the smoothing/explicit-formula analytic bridges.

## Review disposition

Accept the rectangle sufficiency and dynamic-height implication as research mathematics. Carry the conductor-one Euler correction into any successor specification, and make shared vertices, orientation, exhaustive character indexing, holomorphy, and uniform panel errors explicit checker obligations. Actual contour data, a numerical producer with measured costs, and the formal checker remain unbuilt. The frozen reports and proof package were left unchanged; no Lean build or canonical edit occurred.
