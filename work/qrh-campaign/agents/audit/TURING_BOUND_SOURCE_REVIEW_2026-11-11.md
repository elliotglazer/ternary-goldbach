# Independent review of the proposed Turing integral bound

2026-11-11. **PASS as a published mathematical target and source ledger, with the stated analytic proof obligations retained.** The canonical normalization, conductor and height domain, conservative rational constants, and proposed almost-everywhere adapter are sound. This does not prove Turing's theorem, validate a numerical family certificate, or supply a Lean theorem. No build, dependency edit, or frozen-file edit occurred.

## Pins and primary-source inspection

Reviewed `agents/independent-feasibility/TURING_BOUND_PRIMARY_SOURCE_AUDIT_2026-11-11.md`, SHA256 `39770248BAFA0EA935FAAB2660FE90E7DB6B0A6C01A1C0021DE0D33F68BD55F0`, and the separate `agents/zero-sum/FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md`, SHA256 `6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4`.

I independently downloaded and read the actual accessible primary PDFs, rather than relying only on quotations of Rumely's OCR:

* Trudgian, [Improvements to Turing's Method, arXiv:0903.1885v3](https://arxiv.org/pdf/0903.1885), local `trudgian_turing_0903_1885.pdf`, SHA256 `E8D021A3C083D0F07427760661478E47390D446D06714257DEE702246FACC878`.
* Platt, [Numerical Computations Concerning the GRH, arXiv:1305.3087](https://arxiv.org/pdf/1305.3087), local `platt_turing_1305_3087.pdf`, SHA256 `8FD109AA21345BC3FEAC4FDE2FAA7DFB51B4EF1FC9A430F643323612A39EF417`.

Extracted text and rendered pages are retained in this audit directory. I visually checked Trudgian pp11,12,15 and Platt p5, including absolute-value signs which text extraction can lose. The original Rumely PDF was not independently recovered in this review. Accordingly its exact endpoint-limit arrow remains unauthenticated; this limitation is correctly stated in the reviewed ledger.

## Confirmed target and normalization

For a primitive character of conductor c>1, real T>50 and h>0, the supported target is

```
abs (integral_T^(T+h) S_chi(t) dt)
  <= 18397/10000 + (621/5000)*log(c*(T+h)/(2*pi)).
```

Trudgian §3.2 sets the standing primitive-conductor condition with both parities. Theorem 3.1 and the following sentence explicitly record Rumely's triple (1.8397,.1242,50). Lemma 3.4 states the horizontal-log identity with the factor 1/pi, in the order I(t2)-I(t1). Theorem 3.8 is a parameterized alternative, with t2>t1>t0>50, 1<c_parameter<=5/4, and 1/2<d<=1. The parameter c in that alternative must not be confused with the conductor c in the campaign interface.

Platt Theorem 3.2 explicitly defines S_chi as `(1/pi)*Im integral_infinity^(1/2) L'_chi/L_chi`, and Theorem 3.3 prints the same absolute integral bound for T>50, h>0. This supports the campaign's Euler-log normalization from infinity. It is not an arbitrary principal argument of L at the endpoint. Trudgian describes a path through 2 and 2+it; its starting argument must be compatible with the Euler logarithm. A nonreal L(2,chi) cannot be assigned argument zero. The analytic Euler logarithm on Re(s)>1 gives the required equivalence of the far-right and vertical-then-horizontal paths once that starting value is fixed.

No root-number phase belongs in S_chi. The root-number/gamma phase enters the completed-function or counting formula separately. There is no conductor upper bound, integrality-of-height premise, RH premise, simplicity premise, or supplied zero-list premise in this target. The c=1 principal/zeta case is excluded and needs its own result. Conjugating chi preserves conductor and primitivity, so the bound applies twice to a pair; in the real-character case two equal contributions are still two contributions.

## Exact rational rounding

Given the source horizontal bounds in the ledger and `Z_j=log(c*t_j/(2*pi))`, monotonicity gives `0<Z_1<=Z_2`. Both signs of I(t2)-I(t1) are at most `5.7795+.39*Z_2`. Division by pi is therefore justified with the selected rational constants. An independently written Fraction script checks a Machin-series lower bound pi>3.14159 and obtains

```
(18397/10000)*3.14159 - 5.7795 = 83123/10^9 > 0,
(621/5000)*3.14159 - .39 = 92739/(5*10^8) > 0.
```

It also independently reproduces the two final arithmetic combinations 3.450608<3.4507 and 2.3286546875<2.3288, certifying the logarithm upper estimate by a positive exponential Taylor sum. No floating-point comparison decides acceptance. These computations assume the analytic horizontal bounds; they do not prove their zeta-integral, gamma, convexity, or Hadamard-product inputs.

Independent script `turing_bound_independent_review_20261111.py` SHA256 `372F10606EA39C632B4F85A147F083E24D643CAA67C4A23AD9FF5524D52F0E2E`; JSON `E287369779AE1EA1CF5F85AEEE5D3477C4F7B9ECA619F8E4FE845FA5B9B78E5F`. Exit zero.

Two documentary cautions do not defeat this conservative target. Trudgian p12 corrects the separate Gram-weighted example 4.824. On p15, §3.5 reconstructs a smaller slope .1212 and footnote 6 calls a printed number “1.1242” a rounding error; that printed number itself appears mistyped. Neither passage warrants treating .1242 as a sharper new theorem or discarding it: the selected .1242 is independently larger than .39/pi and is explicitly corroborated by both primary papers. The proof ledger should retain the horizontal estimates as the arithmetic provenance.

## Endpoint conventions and the closed-count addendum

Platt p5 explicitly chooses a right limit at exceptional ordinates. This settles what that accessible version prints, not what the inaccessible Rumely arrow was. It is unnecessary to settle the latter to consume an integral: locally finitely many zero ordinates form a null set. Once local integrability and agreement off that set are proved, left-limit, right-limit, midpoint or other finite assigned values give the same integral. This adapter also covers an exceptional lower or upper integration endpoint. It does not identify different pointwise counting conventions.

The optional addendum is mathematically valid under its explicit a.e. count identity and integrability assumptions, independently of a separately certified nonzero top boundary. If C_chi(t) counts all nontrivial zeros with |gamma|<=t, including multiplicities and real zeros, then for every t>T,

```
C_chi(t) = C_chi(T) + A_chi(T,t] + A_barchi(T,t].
```

Conjugation accounts for negative ordinates and preserves multiplicity. A zero at |gamma|=T belongs to the base count; one at T+h affects the integrand only at the final singleton. Integrating the a.e. argument-principle identity yields the stated closed-count formula. Each disjoint auxiliary sign interval (u,v) strictly inside (T,T+h) supplies a zero r<v and hence contributes at least T+h-v to the auxiliary integral. The subtraction sign in the upper bound U is correct.

With K_main certified zeros strictly below T and an exact central contribution, K_main<=C_chi(T). If U<K_main+1, integer saturation proves equality. A previously uncounted zero at |gamma|=T would contradict that equality, so boundary nonvanishing can be a consequence rather than an extra input. The two channels remain necessary for real characters. Real zeros cannot be discarded.

This is a derived mathematical interface, not permission to delete hypotheses from Platt's printed Theorem 3.2, which explicitly assumes nonexceptional endpoints. A formal implementation must prove the a.e. identity/local integrability and closed-count decomposition, or a justified limiting version. I do not import Platt's printed count formula or half-open count conventions as an already checked normalization theorem; this review is confined to S, its integral bound, and the addendum's conditional counting algebra.

## Remaining proof work and verdict limits

The campaign still owes the source L-function identification, normalized Euler-log construction, Littlewood identity, full horizontal estimates with certified numerical inputs, integrability, local finiteness/multiplicity transport, and the closed-count argument principle. The actual family evidence must then satisfy the resulting checker and saturation criterion. No historical GRH computation is an input here, and no analytic producer is marked proved by this source review.

The published target can be retained. No blocking defect was found in the reviewed source ledger or endpoint addendum at their stated scope. The documentary original-arrow gap remains visible and is logically bypassed only through the still-to-prove a.e. adapter, not by guessing an endpoint convention.
