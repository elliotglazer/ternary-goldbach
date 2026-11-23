# Independent review: finite-family heights and the published Platt domain

Date: 2026-11-11. Finding: **pass for source conventions and exact domain arithmetic**. The frozen comparison requires no correction. This review does not import a finite GRH computation as a proof, establish the proposed finite .555 strip, or infer anything about zeros outside the published guarantee.

## Frozen inputs and independent check

Inputs under `agents/major-constants/`:

| File | SHA256 |
|---|---|
| `PLATT_DOMAIN_COMPARISON_2026-11-11.md` | `e3ba0524a5466415aa0478bb227b2fa4508252bf45b3ae840fc71d1a2659756f` |
| `platt_domain_comparison_20261111.py` | `336def293a2226eccbe9e0066d51639ce12217fbbc6054c4955a2054843fbf40` |
| `platt_domain_comparison_20261111.json` | `60eeb3d554476b5bb14fac88c036eb7282b83795bf321db4e8e2ee1855a88169` |
| `platt_domain_comparison_20261111_sets.json` | `4d1d356178be8a47f3ca0ecad3e6b4ab35e6a064a23c72c12f2356b9dfcee6aa` |
| `platt_domain_comparison_20261111_original_exceptions.csv` | `44b9a211c50b5b4aa3af92a125b87d0f9353df38011ae92435fafde2839904df` |

The independent script `moebius/platt_domain_review_20261111.py` completed with exit code 0 and produced its own JSON. It does not import or execute the author's script. It generates totients by a sieve, then obtains primitive-character counts by divisor-sum inversion of

    phi(n) = sum_{d divides n} a(d).

This differs from the author's smallest-prime-factor and prime-power recurrence. It constructs the active set explicitly, evaluates heights using integer ceiling quotients, and uses exact rational published heights. It compares all four complete exception lists, every reported statistic and sample, every one of the 108333 CSV rows, and the directed weighted-height sums. All agree. No frozen file was modified.

## Primary source and endpoint conventions

I retrieved [Platt's arXiv v1 preprint](https://arxiv.org/pdf/1305.3087v1) directly. Theorem 7.1, printed page 14, covers primitive moduli at most 400000. Its parity branch is explicitly the modulus q, not the character's value at -1. The exact height is

    Tpub(c) = max(100000000/c, 200 + K/c),
    K = 75000000 for even c, and 37500000 for odd c.

Theorem 3.2 defines its counted zeros using both signs, multiplicities, and `|Im(s)| <= t0`; its computational setup excludes a zero at the boundary. This supports the inclusive interpretation of the theorem's stated height. The accepted-manuscript PDF returned HTTP 403 in this review, so the independently checked primary anchor is v1 rather than a claim to have reread that manuscript.

The pinned `TernaryGoldbach/Statement.lean:55` also explicitly uses inclusive ordinate bounds and strict `0 < Re(rho) < 1`. Its odd-modulus limit is 300000 with height `1e8/c`; its even limit is 400000 with the stated even maximum. On every active odd conductor here, `c <= 150000`, and `200c + 37500000 < 100000000`. Thus the odd paper branch reduces exactly to the repository height on this family. All active conductors fit both relevant modulus ceilings.

The requested natural height H is contained when **H <= Tpub(c)**. Tpub must remain rational; replacing it by its ceiling enlarges the guarantee. The original-plus comparison has no equality cases, so its 108333 classification is independent of any residual wording question at an exact boundary. Original star has exactly one equality, c=100000, included under the inclusive convention. Both reduced profiles have no equality cases.

## Family and multiplicities

The source definitions `MinorArcs/LargeSieveWeights.lean:26` (`qt`) and `MinorArcs/LargeSieveArcs.lean:34` (`Qset`) give odd moduli through 150000 and even moduli through 300000. Primitive conductors of 2-adic valuation one have no characters. The active primitive set is therefore exactly

    {odd c: 1 <= c <= 150000} union {4k: 1 <= k <= 75000}.

Every member contributes: it can itself be used as its inducing modulus with nonzero primitive Gauss sum. Divisors of active moduli introduce no larger odd conductor or larger multiple of four. Conductor one contributes the single zeta character. For primitive characters the modulus being compared is the conductor; no imprimitive-modulus height has been substituted.

The independent inversion gives 150000 active conductors and 5543640188 primitive characters. It agrees with the familiar local formula `a(p)=p-2`, `a(p^k)=p^(k-2)(p-1)^2` for k>=2, but does not use that formula to generate its counts.

## Heights and exact classifications

The comparison correctly transcribes the selected heights from `RESUME_FAMILY_CAPS_2026-11-11.md` and the separate reduced proposal from `RESUME_CUTOFF_OPTIMIZATION_2026-11-11.md`. With `D=1200000/qt(c)`, the four heights are

    original plus: ceil(200 + max(1000,704D/7)),
    original star: ceil(max(1000,704D/343)),
    reduced plus:  ceil(200 + max(300,484D/7)),
    reduced star:  ceil(max(250,484D/343)).

Moving the integer 200 outside the ceiling and moving integer floors outside a ceiling are exact identities here.

| Profile | Contained conductors | Outside conductors | Outside primitive characters |
|---|---:|---:|---:|
| Original plus | 41667 | 108333 | 4402936349 |
| Original star | 75000 | 75000 | 3695775113 |
| Reduced plus | 96233 | 53767 | 1699761198 |
| Reduced star | 150000 | 0 | 0 |

For original plus, every active even c fails containment before rounding: the sloping lower bound is `200 + (844800000/7)/c`, which exceeds each of the two published branches. For odd c, the slope is `(422400000/7)/c`. In its sloping regime, c<=60342, the ceiling is at most `201+(422400000/7)/c < 1e8/c`. From c=60343 the floor gives exactly 1200, contained precisely when `1200c <= 1e8`. Thus the complete exception set is all 75000 active even conductors and the 33333 odd conductors from 83335 through 149999. The independent script checks set equality, not merely cardinality. The largest excess is 5171629 at c=4; the largest ratio is 8/3 at c=300000. Incorrectly ceiling Tpub would hide 34 exceptions.

Original-star exceptions are exactly active c>100000. Its floor is 1000; the sloping term remains safely within the published height below that threshold. Above it both published branches are below 1000. The equality at c=100000 is retained.

Reduced-plus exceptions are all even, beginning at 84748. The exact list, not a single rounded threshold, is required near the transition. Its maximum excess is `2021735/31239` at c=124956, and maximum ratio is 10/9 at c=300000. Every reduced-star height is strictly contained. All these conclusions, plus the directed primitive-character-weighted height sums, were independently reproduced. Those sums measure only arithmetic height deficits, not a number of zeros, runtime, memory, or proof volume.

## Accepted interpretation

The original selected shared assertion requests taller rectangles than the published theorem guarantees on 108333 active conductors. That is a precise obstacle to reusing that stated guarantee alone. It neither refutes finite .555 in those rectangles nor says the historical computation produced no useful auxiliary data there. Turing windows beyond a reported endpoint cannot be silently promoted to an exported theorem.

Inside the reported domain, a correctly formalized finite GRH result would imply the weaker .555 bound after the required function and zero-set correspondence. This review supplies no such formal result or replayable zero certificate. The reduced profile remains a separate analytic proposal; this domain comparison does not select it. No Lean build, canonical source change, finite-zero computation, or change to the frozen proof package occurred.
