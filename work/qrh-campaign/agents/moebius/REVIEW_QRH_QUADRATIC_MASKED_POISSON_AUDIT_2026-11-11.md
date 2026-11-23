# Independent review: quadratic masked Poisson comparison

Status: PASS at the bounded source/mathematical cut below. I read the entire author report `integration/QRH_QUADRATIC_MASKED_POISSON_AUDIT_2026-11-11.md`, SHA-256 `A0F3A9EC4259987A358B6666FD26877F418C67EE1831ED5C7FC8D1A0D509F09D`, and independently reconstructed the substantive joins identified here. No correction is required. No Lean build, elaborated-axiom check, numerical analytic evaluation, or source modification was performed.

## Scope and exact meaning

This review concerns the actual quadratic masked comparison used by `CubicSieve/ArithmeticBins.annular_small_gcd_complete`, through `QuadraticSieve/PoissonComparison.HasSieveExponent.masked_poisson_complete`. It is distinct from the original trace-normalized radial Poisson identity. The provider source root is `work/openai-math/lean/OAI/NumberTheory/DirichletL`; the intended provider commit is `4eaee87548250b2682affda7d05d947c05554bae`.

`HasSieveExponent alpha` remains an explicit input. The comparison does not prove a new sieve exponent or supply an unconditional replacement for that input. Its constants and Schwartz seminorms are chosen before the finite columns, coefficient vector, mask, cutoff scales and test function. The conclusion bounds an actual difference, not an arbitrarily named error function.

## Independent reconstruction

### 1. Four terms, with a nonzero principal correction

`PoissonComparison.lean:156–201` defines the two centered quantities and the actual difference. Write `R_q` for a retained dual term, `D_q` for its principal density, `S` for the masked source, `D_S` for its density, `T` for the dual tail and `f` for the common Fourier zero mode. The exact identity is

`6 difference = sum_q mu(q)(6 R_q - f D_q) + 6 T - (S - f D_S) + f (sum_q mu(q)D_q - D_S)`.

Expanding gives `6 sum mu R_q + 6 T - S`, with no lost factor of six. In particular, the last term is not zero. `CuspCoercivity.lean:137` identifies its parenthesis with `sqrt(M) * actualPrincipalDifference(cols, densityColumn(a), G, K)`.

The density adapter is substantive: `PrincipalDensity.lean:534,637` uses `densityColumn_j = primePoolDensity(cols_j) * a_j`; coprime column pairs multiply their two densities to the product-ideal density, while coprimality with `G` gives the remaining mask density. The pair term is zero when the column pair is not coprime. Fixed bad primes dividing `G` ensure the masked squarefree source rows have the required admissibility. These hypotheses cannot be omitted.

The common value `f` is justified by `GaussSum/ReflectionBrackets.lean:230–305` and `Mellin/InverseContour.lean:398–489`. The latter proves a real-line partial Fourier identity by actual Fourier inversion at zero, rescales by `2/sqrt(3)`, and uses evenness and integrability to pass to the positive half-line. This is an identity for the two actual Schwartz profiles `W(x^2)` and `paperRadialFourier(W)(x^2)`, not an assumed involution. `W(0)=0` does not imply `f=0`.

### 2. The infinite dual split is justified before truncation

`QuadraticSieve/DyadicColumns.lean:562,596` first supplies summability of the full ideal Fourier series. Its two indicator series divide it by `Norm(squarefreePart) <= K` and `K < Norm(squarefreePart)`. Equality belongs to the retained side. The square-part/squarefree-part reindexing is an actual bijection, and product-series interchange uses summability. `TruncatedSecondTransfer.lean:119` then replaces the squarefree index by its exact finite range; it does not cut off the remaining square-part series without a bound.

`CommonMasks.lean:196` sums this identity over the finite coefficient pairs and divisors of `G`. The tail therefore represents the actual omitted part of the dual series. No default value of a nonsummable `tsum` is used at this cut.

### 3. Unit columns and truncation errors

The generic comparison permits the unit ideal, whereas the earlier `ConstantDirichletSeries.dualPrincipalIdeal_eq_lattice` has a nonprincipal-pair condition. The comparison uses the different theorem `RetainedDualBounds.lean:186–232`, `dualPrincipalIdeal_truncated_all_conductors`. Its lattice function explicitly vanishes at zero, is summable and unit invariant; `tsum_unit_invariant_of_zero` gives the factor six even for the pair `(1,1)`. There is no unproved transfer of the nonprincipal formula to that pair.

The truncation error is initially a residual by definition, but this is not the only justification for bounding it. `Poisson/PrincipalTruncation.lean:239–269` rewrites it into small-divisor dual, middle-divisor frequency, and large-divisor source tails, then applies actual tail estimates. `MaskedPrincipalBounds.lean:487–525` chooses order `m+3`, truncation scales `X0/T`, `T X0`, and frequency scale `T^4`. `Eisenstein/GreenIdentity.lean:185–250` verifies the domain and scalar reduction: the first two terms are at most `2^(m+3)/T^m` each; numerator `<=2T`, minimum denominator factor `>=1/(2T)` and frequency factor `>=T` give a third term `<=8/T^m`. Their sum fits `2^(m+10)/T^m`. The prime-support cardinal bound then pays for the mask uniformly.

The retained-dual centering still has four bounded pieces: a large-principal term, a small-principal term multiplied by the transformed profile's value at zero, a truncated middle term, and the truncation error. The transformed value at zero cannot be removed merely from `W(0)=0`.

### 4. Constants, norms and uniformity

`RetainedDualBounds.lean:239–292` retains the finite row/column cardinal charge `16384 B N` and the prefactor `2M/(F N)`. Its global version partitions the finite squarefree rows into dyadic ranges; nonempty ranges satisfy `B <= 2K`, and empty ranges contribute zero. The comparison charges `columnDyadicLength(K)+1`; it does not replace this by a universal constant. The source global bound in `PrincipalDensity.lean:396` has the analogous finite partition. Monotonicity at this join uses `alpha >= 1/2`.

In `ScaleCaps.lean:370–493`, for a divisor `q` of the nonzero mask, `1 <= Norm(q) <= Norm(G)`. Thus the actual tail parameter is at least `t0=M/(Norm(G)N^2)>0`. The divisor character/Mobius factor has norm at most one. The pair prefactor is bounded by `2M/N`; finite coefficient Cauchy and `card(columns) <= 128N` yield the stated `256M`, not a cardinal-free pair estimate. The denominator `(min(1,t0))^2 (1+t0 K)^A` remains in the bound.

`MaskedPrincipalBounds.lean:256` obtains the actual principal-difference estimate using `HasSieveExponent.reverse`. That reverse theorem pays the source factor `262144` inside its constant. Its final scale is

`sqrt(M/K) N + sqrt(M) K^(alpha-1/2)`.

The divisor-count square, support constant, subpower factors, and coefficient energy remain present. Passing from `densityColumn(a)` to `a` uses the density norm bound `<=1`; it is not an equality of energies.

The four constants/seminorms in `PoissonComparison.lean:333` are selected before all later mask, scale, finite-family and test-function data. The arbitrary positive support-loss epsilon is consumed by its explicit support constant rather than hidden in those choices.

### 5. Active gcd blocks supply the needed domain

`ArithmeticBins.lean:400,415` identifies the actual gcd/ray block with the comparison on residual columns `I/D` and effective column length `X/Norm(D)`. Restricting to `gcdRaySupport` removes only zero coefficient or wrong gcd/ray contributions. `CommonMasks.lean:607` supplies injectivity, admissibility, common ray and coprimality with the common mask for those residual columns.

The shell lower endpoint is strict: a nonzero coefficient has `X/2 < Norm(I)`, while the small-gcd regime has `Norm(D) <= X/2`. Consequently `I != D`; residual unit diagonals are excluded where the nonprincipal source Poisson identity actually needs exclusion. Also `D != 0` and the small-gcd inequality ensure `X/Norm(D) >= 2`, enough for the comparison's length requirement. The original parameters `M,K>=1` and `T>=4` are preserved. The annular cutoff supplies `W(0)=0`.

`CommonMasks.lean:423–447` and the original high-source definition use the genuinely summable original source minus its low piece. Thus the active identity has not silently replaced an infinite source by a finite surrogate.

### 6. Additional middle-frequency and sector claims in the frozen report

I checked `MiddleWindows.lean:98–177,309–357,432–485,584–620` against the report's section 5. Both windows are nonnegative and dominated by the corresponding actual all-frequency quantities. The source explicitly obtains summability before comparing their sums. If the original divisor gate `D1 D2 <= 2 U sqrt(M/B)` or the dual gate `D1 D2 <= 2 U N sqrt(F/(MB))` fails, its support predicate is impossible and the window is identically zero. In the supported case the appropriate `HasSieveExponent` block estimate is applied. The two finite dyadic divisor partitions pay `(columnDyadicLength(N)+1)^2`; finite-to-infinite domination is not being used on an unproved convergent sum.

`Eisenstein/SeedDefects.lean:360–496` handles retained squarefree rows that are not admissible. On each nonempty bad-prime sector it proves good-row injectivity and admissibility, replaces `B` by `B/Q` and `M` by `MQ`, twists the coefficients by norm-at-most-one row values, and has the exact outside factor `1/Q`. Nonemptiness supplies `B/Q>=1`; the empty case is handled separately. The scale inequality and `alpha>=1/2` give the claimed bound, and the four sectors are explicitly summed. This is not an assumption that all squarefree rows avoid the bad primes.

I also checked `PrincipalDifference.lean:114–173` and `CrossFactorization.lean:633–696`. They expand the actual principal difference into the stated two finite divisor sums of coprime Gram forms, use the weight bound `1/sqrt(K)`, then restrict the actual matrix operator to the sieve norm. The report correctly leaves the underlying coprime Gram inequality and normalized-pair boundary identity as lower inputs.

The four `LatticeEnvelopes.lean:215,277,408,436` entry statements have the claimed scales and quantifiers. Their deeper radial/block derivation is outside this review; inspection of their immediate use is not promoted to validation of that derivation.

## Boundary of this review

The inspected join is a bounded source-level implication. Its lower inputs include the canonical quadratic character/row and Gauss identities, original quadratic source Poisson theorem, square-part decomposition, the three radial truncation-tail bounds, underlying ideal/lattice and prime-support counting, the large/small/middle principal estimates and the actual principal-difference sieve estimate. I checked their stated consumption, and several immediate proof bodies above, not every foundational proof beneath them. Scalar optimization after `annular_small_gcd_complete` is a separate audit. No full provider proof, elaborated axiom closure, or ternary Goldbach closure is certified here.

## Frozen evidence

All 22 source pins and six supporting-report pins in the author's frozen report were independently rehashed and matched. Three additionally inspected sources are pinned below. These hashes bind the bytes, not a claim that every declaration in each file was reviewed.

| Additional source | SHA-256 |
|---|---|
| Eisenstein/GreenIdentity.lean | 11C68726B5B43F1619491FE0AC702B638B10236AF250A41F2B64A66C8CF42544 |
| Eisenstein/ConstantDirichletSeries.lean | 4233AA15801704D2E0DF7C07888408C62BA44BDA421FD3E36D34FB57B23ABC85 |
| QuadraticSieve/TruncatedSecondTransfer.lean | 946E8749B8833DE99853879BD0D8D8912F7D6781076E5357239578BA32F5629F |

Owned byte-reconciliation artifacts:

- `check_quadratic_masked_poisson_source_20261111.py`: `41A3AE0977142C2A15C8E9A91B607F1E4192F6507644E408CFBCB1B0315301A3`.
- `check_quadratic_masked_poisson_source_20261111.json`: `F7977954AE1CBD4073707F9B19A748BD5A9EB6B652EB258733400CE84F617F76`.

The checker performs only file hashing and receipt serialization; it does not run Lean or evaluate an analytic function. The verdict remains a source-level implication conditional on the expressly retained lower estimates and `HasSieveExponent` input.
