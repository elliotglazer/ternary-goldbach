# Independent review of the character manifest

2026-11-11. PASS as a paper completeness argument, source-interface plan and bounded exact-arithmetic check, with the generic-quantifier wording erratum below. The construction covers actual complex Dirichlet characters through unit homomorphisms; its coverage is not inferred from matching counts. All seven mixed-modulus pilots and the active primitive/parity totals passed independent reconstructions. This is not a Lean proof, a complete production generator manifest, an L-function evaluator or a spectral certificate.

## Frozen inputs and independent checks

Reviewed files in `agents/zero-sum/`:

| Artifact | SHA256 |
|---|---|
| `FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md` | `53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54` |
| `family_character_manifest_20261111.py` | `570FD7E9636BC9FF0337BEB80AE5053B581B6338C44462408BB225DF5EBF1F9B` |
| `family_character_manifest_20261111.json` | `DF040A89B7E2D8856023B9D36169F741B1CD05B3DB6C5D8D1D30C27E855B6EB7` |

I read the complete report, script and receipt. I did not rerun its main command, which would overwrite its receipt. Instead, two new scripts import no producer code and write only their own adjacent receipts:

| Independent artifact in `agents/integration/` | SHA256 |
|---|---|
| `review_family_character_counts_20261111.py` | `DED3D0896B12E5021F6161910446806E9A7A32B143B7C88C160028F06E1E45D8` |
| `review_family_character_counts_20261111.json` | `9C200705E1DEC81F118DB7DBAD97120B8E3517FD8C2CEAE741D342438EDA1336` |
| `review_family_character_pilots_20261111.py` | `FD03EF17A6B85759F15F3C457A107E0F1EBEEDA0DA90404CE59F67DE1DBE5395` |
| `review_family_character_pilots_20261111.json` | `B91A8AE44BCB6FAD788CADE6E98D4300324DCC86FB8F6F1DAED944ED83DA134E` |

Both scripts exited zero. Their exact assertions, not timings or floating-point comparisons, determine acceptance. Source inspection uses the report's target commit `23b2d68ca344203d4384e0aff7affa4ec034bef9` and Mathlib commit `56a005855ea17e0b0958f73ec801ae140b0a1679`. No Lean build, dependency change, author-file edit or frozen-package edit occurred.

## 1. Actual coordinate coverage

For odd `p`, source `ZMod.isCyclic_units_of_prime_pow` supplies a cyclic unit group of order `(p-1)p^(k-1)`. Once a particular unit has that exact order, its powers give the specified coordinate map, not merely a set with the same size. The numerical order test in the report is valid: if a divisor `d` of `m` is proper, some prime divisor `ell` of `m/d` makes `d` divide `m/ell`. Thus `g^m=1` and all `g^(m/ell)!=1` force order `m`. The factorization, unit property and power checks must themselves be certified for recorded generators; abstract cyclicity does not silently identify a numerical generator.

For `2^k`, `k>=3`, equality of `(-1)^e 5^f` first reduces modulo four to equality of the sign coordinates. Cancellation then reduces it to equality of powers of five. The actual source `UnitsCyclic.lean:249` proves `orderOf (5 : ZMod(2^(n+2)))=2^n`; injectivity of the unit coercion transfers this order. The coordinate map is a homomorphism and is injective on `0<=e<2`, `0<=f<2^(k-2)`. Comparing its now-identified finite domain and unit-group cardinalities proves surjectivity. This legitimate final cardinality step does not assume cyclicity of the full two-power unit group.

The small cases are necessary and correct: levels one and two have trivial unit groups, level four has its single sign coordinate, and level eight has two independent order-two coordinates. In particular no generator of order four is invented for the units modulo eight. Iterated `ZMod.chineseRemainder`, followed by `Units.mapEquiv` and the product-units equivalence, gives the actual global map. Lean will need additive cyclic groups wrapped multiplicatively where appropriate; the paper uses additive coordinate notation for the cyclic factors.

The character coverage proof is stronger than an equality of cardinalities. For any actual source character, `MulChar.equivToUnitHom` restricts it to a homomorphism on the actual unit group. Pulling back along the constructed coordinate isomorphism, each standard generator has image with its prescribed power equal to one. The source `Complex.isPrimitiveRoot_exp` and `IsPrimitiveRoot.eq_pow_of_pow_eq_one` express that value uniquely as a power of the chosen positive-exponent root. Equality on all standard generators gives equality on every coordinate tuple. The source restriction/extension equivalence then gives equality on the entire residue ring, including nonunits. `IsPrimitiveRoot.pow_inj` proves uniqueness of each label.

At conductor one the empty tuple is handled separately and correctly. Zero in `ZMod 1` is a unit, so the extension-by-zero-on-nonunits rule does not incorrectly turn the unique level-one character into the zero function. The character's spectral row remains the separate principal/pole-cancelled zeta case.

I checked the actual source definitions and binders in `MulChar/Basic.lean:152,159,183`, `DirichletCharacter/Basic.lean:39,49,114,149`, `RootsOfUnity/Complex.lean:93` and `RootsOfUnity/PrimitiveRoots.lean:138,566`. They supply the stated interfaces. The new packaged equivalences are still unimplemented.

## 2. Conductor formulas and their edge cases

At odd `p^k`, reduction of the chosen generator to `p^j`, `1<=j<=k`, generates the entire target unit group because the reduction map is surjective. Its image therefore has order `phi(p^j)`. The kernel is exactly the subgroup generated by `g^phi(p^j)`: that power is in the kernel, and every exponent in the kernel is divisible by the image order. This does not require the separately recorded generator at `p^j` to be the reduction of the generator at `p^k`.

The coordinate character is trivial on this kernel exactly when

`(p-1)p^(k-1) divides r*(p-1)p^(j-1)`,

equivalently `p^(k-j)` divides `r`. For nonzero `r`, minimizing `j>=1` gives `p^max(1,k-v_p(r))`. Reduction to modulus one requires the whole character to be trivial, equivalently `r=0`. This proves the stated conductor and the two distinct primitive conditions: `r!=0` for `k=1`, and `p` not dividing `r` for `k>=2`.

At two-powers, reduction to `2^j`, `j>=3`, preserves the sign coordinate and reduces the five-power coordinate modulo `2^(j-2)`. Its kernel is generated by `5^(2^(j-2))`, so the condition is `2^(k-j)` dividing `f`. Reduction to four requires `f=0`; reduction to two or one additionally requires `e=0`. For `f!=0` in its allowed range, `v_2(f)<=k-3`, hence the minimal conductor exponent `k-v_2(f)` is at least three. There is no collision with the sign-only conductor-four case. Thus primitive labels at `2^k`, `k>=3`, are exactly odd `f` with either sign. There is no primitive character at conductor two.

For a divisor of a general modulus, CRT makes the reduction kernel the product of these local kernels. A product character is trivial on the product exactly when each local character is trivial on its own kernel: to prove necessity, set all other local coordinates to the identity. Therefore the character factors through exactly those divisors divisible by the product `C` of local conductors. This identifies the source conductor as `C`, rather than introducing a separate numerical definition. Source `factorsThrough_iff_ker_unitsMap` and `mem_conductorSet_iff_conductor_dvd` have the positive-level hypotheses needed here. All active levels are positive.

Conjugation negates the exponent labels, as independently checked on complete rows. This preserves the reduction-kernel conditions and hence the conductor. A row is real exactly when every generator value has order at most two, namely `2*r_i=0 mod m_i`. At odd prime powers, the chosen generator's half-order power is the unique element of order two, `-1`; at two-powers its coordinates are `(1,0)`. Thus parity is the stated sign coordinate plus the odd-prime labels modulo two. Source `MulChar.star_eq_inv` confirms conjugation equals character inversion for this finite unit group. A nonreal conjugate pair is never silently treated as a single character.

## 3. Ambient coverage and wording erratum

Section 5 says, "Every primitive character of an ambient modulus induces from its source conductor c." For the intended consumer, read this as **every character of an ambient modulus, including imprimitive characters**. This is a nonblocking wording correction, not a new hypothesis or a missing proof argument.

The actual `DirichletCharacter.primitiveCharacter`, `primitiveCharacter_isPrimitive` and `changeLevel_primitiveCharacter` at `Basic.lean:306,310,313` apply to arbitrary `chi`; none assumes `IsPrimitive chi`. Therefore any character at a positive ambient level `q` is the lift of the primitive character at `c=chi.conductor`. The report's final uniqueness paragraph already uses this general induced-character case. The frozen text remains unchanged, and this review records the stronger required quantifier explicitly.

Source `LargeSieveWeights.lean:26` defines `qt(q)` as `q` for even q and `2q` for odd q. Source `LargeSieveArcs.lean:34` includes exactly positive q with `qt(q)<=2R`. If `c|q`, then `qt(c)<=qt(q)`; when c is odd and q is even, the quotient is an even positive integer, so `2c<=q`. The local conductor classification removes levels with exact two-adic exponent one. Consequently every induced primitive conductor lies in the selected union of odd `c<=150000` and four-divisible `c<=300000`. Conversely every member of that union has primitive labels and occurs at its own permitted ambient level. No induced character is lost by discarding the empty conductor class `2 mod 4`.

For uniqueness, `conductor_changeLevel` forces any primitive inducing level to equal the actual conductor, and `changeLevel_injective` gives uniqueness at that level. The local character bijection then fixes the label. This uniqueness does not say that the same primitive label appears at only one ambient modulus; it says each induced character is indexed by the same unique conductor-label key. The existing Gauss weights still control appearances in the analytic sums.

## 4. Independent pilots and aggregate counts

The pilot review constructs global generators by CRT idempotents, then evaluates their products to reconstruct the coordinate map on actual residues. This differs from the producer's separate local residue lookups. It checks the full group law, then evaluates every character as an exact rational phase modulo one. Conductors are determined directly from every divisor's reduction kernel, without calling the producer's valuation formula. All primitive labels, conductor histograms, parity flags, conjugate labels and real-character flags match the frozen receipt.

| Level | Independently lifted global generators | All rows | Primitive rows | Divisor-kernel checks |
|---|---|---:|---:|---:|
| 4 | 3 | 2 | 1 | 6 |
| 8 | 7, 5 | 4 | 2 | 16 |
| 16 | 15, 5 | 8 | 4 | 40 |
| 27 | 2 | 18 | 12 | 72 |
| 40 | 31, 21, 17 | 16 | 6 | 128 |
| 72 | 55, 37, 65 | 24 | 8 | 288 |
| 120 | 31, 61, 41, 97 | 32 | 6 | 512 |

For the aggregate check I independently computed Euler phi and the Moebius function through 300000, then used `a(n)=sum_(k*d=n) mu(k)*phi(d)`. This avoids the producer's prime-power recurrence. Parity was independently inverted from character orthogonality: the sum of all character values at `-1` is `phi(d)` for d dividing two and zero otherwise. Therefore the primitive even-minus-odd difference is `mu(n)+[2|n]mu(n/2)`. The totals agree exactly:

| Quantity | Independent total |
|---|---:|
| Active primitive characters, including conductor one | 5,543,640,188 |
| Odd-conductor primitive characters | 3,695,775,215 |
| Four-divisible-conductor primitive characters | 1,847,864,973 |
| Even primitive characters | 2,771,820,069 |
| Odd primitive characters | 2,771,820,119 |

These integer checks corroborate the paper classification. They do not enumerate all 5.54 billion rows and do not substitute for the actual-character bijection proved in sections 1 and 2 of this review.

## 5. Exact height dispatch and remaining scope

The height rewrite is exact because 200 and 1000 are integers:

`ceil(200+max(1000,a)) = 200+max(1000,ceil(a))`.

The independent script checked that equality on all 150000 active conductors using Fraction arithmetic, and matched every saved sample height. `Hcert(c)` remains the exact rational minimum with `10^8/c`. In particular the nonintegral heights at 120 and 300000 are `2500000/3` and `1000/3`; they are not rounded upward. Embedding these rationals into Lean's reals must preserve the inclusive `|Im rho|<=Hcert(c)` condition. A later contour may use a larger height only if it is separately certified to cover the required region.

The positive root convention, CRT factor order, residue permutation and FFT scaling still need a precise source-to-numeric adapter. A negative-exponent FFT changes the character label to its inverse unless corrected; a normalized inverse transform requires its normalization to be undone. The note explicitly leaves these obligations open and does not infer an actual L-function identity from a list of phase rows. Common-pole cancellation for nonprincipal characters must use the source-compatible analytic continuation, while conductor one remains the separate principal case.

No further mathematical correction is requested. The generic coverage argument is accepted at paper level with the section-5 wording erratum. Production factorization and generator witnesses, the Lean coordinate/conductor equivalences, the exact evaluator bridge and all analytic zero-exclusion certificates remain missing. Nothing in this manifest reduces the selected family, supplies zero locations or permits a new permanent premise in the final Goldbach theorem. Both frozen research packages remain unchanged.
