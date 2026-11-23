# Live allocations and normalized common energy

2026-11-11. Bounded source and mathematical audit. No Lean build, declaration, source modification, analytic evaluation or production scan was performed.

## Result

The inspected source correctly pays **two** allocation-count factors with a single prescribed small exponent, while retaining the independent inverse ideal-norm factor. The normalized common-energy estimate is a conditional transfer from actual live child energies. It does not prove those child energies small and does not introduce a new unconditional QRH conclusion.

The decisive mechanism is exact. Frozen-slot controls multiplied by live-child controls recover the parent control product, allocation by allocation. The sum therefore contributes one allocation count, in addition to the count from Cauchy–Schwarz on the original polynomial. `allocated_control_mass` applies the count estimate at half the requested exponent and squares it. The separate `1/N(C)` comes from a live frozen-window support bound on the volume reduction; it does not come from the divisor estimate.

No local mathematical defect was found in these normalizations or loss allocations. The lower source identities and summability interfaces inspected below still depend on their stated arithmetic and analytic foundations. In particular, this report does not validate an entire import closure or compatible elaboration.

## Exact target and hypotheses

The main declaration is `Moments/FirstCommonSourceBudget.common_energy_from_live_children:73`. Fix a natural slot cap `N`, real support endpoints `a,b` with `a>0`, and `eps>0`. It chooses a positive constant before every finite slot type of cardinality at most `N`, every admissible input `s`, every supported ideal `C`, puncture ideal `R`, and seed dividing `C`. The constant also precedes the character `tau`, height `t`, divisor mask `L`, Schwartz radial function `W`, positive scale `K`, and nonnegative child bound `E`.

The input includes positive plain and slot scales, nonzero finite source pools, prime slot ideals, bounded character coefficients, slot profiles supported between the declared positive lower and upper endpoints, and controls `M_i>=1`. For the energy comparison, the sampled real radial weights must be nonnegative:

`Re W(|embedding(z)|^2/K) >= 0` for all lattice points `z`.

Only allocations with nonzero actual frozen coefficient must satisfy

`childNormalizedGaussSource(B) <= E * (product M_child)^2`.

The conclusion is

`Re(commonEnergy(original s R seed))/V_s`
`    <= Cbound * N(C)^(eps-1) * E * (product M_parent)^2`.

`Supported C` in particular gives `C != 0`, so its ideal norm is positive and all divisions by that norm are legitimate. There is no extra squarefreeness assumption on `C` in this transfer. The number field and its ideal arithmetic are fixed; no uniformity across fields is claimed. The constant may depend on `N,a,b,eps`, but not on the dynamic pools, `C`, character, height, radial function or scale under the stated conditions.

The requested companion, `FirstCommonSourcePowerBudget.common_energy_power_budget:17`, adds `b>=1`. It accepts any finite number of powers, nonnegative coefficients `E_j` and exponents `alpha_j`, with actual live-child hypothesis

`childNormalizedGaussSource(B)`
`  <= (sum_j E_j * V_child(B)^alpha_j) * (product M_child)^2`.

It concludes

`Re(commonEnergy)/V_s <= Cbound * N(C)^(eps-1)`
`  * (sum_j E_j * (b^N*V_s/N(C))^alpha_j) * (product M_parent)^2`.

The fixed constant is chosen before the number of powers and their coefficients/exponents. This uniformity follows by monotonicity and finite summation, not by bounding the number of powers with an extra constant.

## What the allocations count

`CommonAllocationSum.allocationLabels:14` takes the image of the finite source tuple box under coordinatewise support extraction at `primeSupport C`. `actualAllocations:17` filters this image by the exact product condition `product B_i=C`.

Thus the count is a count of distinct extracted allocation tuples, not of original source tuples and not of occupied numerical bins. Multiple source tuples may yield the same allocation; the source coefficients inside that allocation retain their full sums. `sum_source_fibers` and `original_coefficient_allocated` express this finite partition without discarding multiplicity.

`allocation_data` proves that every coordinate ideal is nonzero. Every coordinate of an actual allocation divides `C`, by the product condition. `actualAllocations_card:79` injects an allocation into the function assigning its coordinate divisor in `idealDivisors C`. Equality of all coordinates implies equality of the original allocation. Consequently, for a finite coordinate type of cardinality `d`,

`allocationCount <= divisorCount(C)^d`.

The original input with `n` slots has `n+2` coordinates, including the two plain factors. `allocated_control_mass` passes the cap `N+2`; omitting these coordinates would be an incorrect count bound.

## The small-power divisor and allocation estimates

I read the body of `QuadraticSieve/FiniteOperator.ideal_divisor_small_power:339`, together with its divisor-count, prime-norm, geometric-growth and norm-factorization lemmas. This estimate is not supplied by the sharp quadratic or cubic sieve.

The divisor count injects into the submultisets of the normalized prime-factor multiset, hence is at most `product_P(e_P+1)`. Every prime ideal in the support has norm at least two. For a requested exponent `delta>0`, choose a finite norm cutoff so that `N(P)^delta>=2` above it. Large primes satisfy `e+1<=2^e<=N(P)^(delta*e)`. At the finitely many small primes, setting `b0=2^delta>1` and `c0=1+1/(b0-1)` gives

`e+1 <= c0*b0^e <= c0*N(P)^(delta*e)`.

The number of small ideals is finite by ideal norm finiteness. Their accumulated constant is at most `c0^(number of small ideals)`. Multiplication of norm powers gives exactly `N(C)^delta`. The source therefore proves a positive constant independent of the nonzero ideal `C`. It does not provide a numerical effective threshold in this audit, nor is one needed for this existential transfer.

`AllocationCost.actualAllocations_uniform_small_power:14` handles a varying finite coordinate type of cardinality at most `Q`. It applies the divisor theorem at `delta=eta/(Q+1)`, enlarges the base to `(1+D)*N(C)^delta >= 1`, and increases the exponent from the actual cardinality to `Q+1`. Therefore

`allocationCount <= (1+D)^(Q+1) * N(C)^eta`.

The extra one avoids division by a zero cardinality and covers empty coordinate types. It is not an extra norm exponent: `delta*(Q+1)=eta` exactly. This bound is uniform in the finite pools. Its proof uses only the divisor injection, `N(C)>=1`, and the fixed-field divisor estimate.

## Raw volume and the inverse-norm factor

For an allocation `B`, a slot is live precisely when `B_(inl i)=1`. Define

`plainNorm(B)=N(B_(inr 0))*N(B_(inr 1))`,

`rawReduction(B)=plainNorm(B)*product_(frozen slots i) P_i`.

`CommonRawScale` proves this quantity positive and establishes the exact identity

`V_child(B) * rawReduction(B) = V_parent`.

The child keeps the live slot scales and divides each plain scale by the norm of the corresponding plain allocation ideal. It keeps the original profiles with those changed scales. The source verifies equality of the resulting finite columns and coefficient functions, rather than identifying the child only by comparable support.

On a live allocation, the frozen coefficient is nonzero. Each frozen slot profile is therefore nonzero at `N(B_i)/P_i`. Its support gives `N(B_i)<=b*P_i`; live slots have `N(B_i)=1`. Multiplying, and including the two plain factors exactly, gives

`N(C) <= max(1,b)^n * rawReduction(B)`.

The source also proves a lower comparison using `min(1,a)^n`, though the inverse-norm upper bound here uses the displayed upper comparison. Nonzero frozen coefficient is essential to this support argument. Dead coefficients are handled as zero terms, not by applying a support bound without its premise.

The frozen coefficient itself is bounded by the product of the controls of frozen slots, since character factors have norm at most one and the coprimality indicator has norm at most one. Thus `FirstAllocationGaussEnergy.frozen_normalized_bound:153` gives

`|frozenCoefficient(B)|^2/rawReduction(B)`
`  <= max(1,b)^N/N(C) * frozenControl(B)^2`.

This is the origin of the inverse-norm factor. All divisions use positive raw reduction and positive ideal norm. The estimate includes the zero coefficient case directly.

## Actual common energy, positivity and the two counts

`FirstPhysicalSourceOriginalData.common_gauss_allocation:57` gives equality of the actual common Gauss polynomial with a sum of actual allocated Gauss polynomials multiplied by their frozen coefficients. Its proof keeps the divisor-mask condition `L|I`, the source puncture, the coprimality selector and the same height coefficient. It invokes the finite source-column allocation and the reindexing of live Gauss polynomials. Those arithmetic identities are lower inputs described below; they are not consequences of an abstract cardinality estimate.

Pointwise Cauchy–Schwarz on this finite allocation sum contributes one factor `A_C=allocationCount`. Multiplication by the nonnegative sampled radial weight preserves the inequality. `FirstAllocationGaussEnergy.common_energy_allocation:57` then passes finite lattice partial sums to the actual energies. The allocated `HasSum` statement and nonnegativity justify this step. It does not assume that the square norm of a sum equals the sum of square norms.

The exact raw-volume identity converts the resulting terms to

`|frozenCoefficient(B)|^2/rawReduction(B) * childNormalizedGaussSource(B)`.

The child energies are nonnegative under the radial hypothesis. Applying the preceding frozen-coefficient estimate is therefore legitimate. One obtains

`Re(commonEnergy)/V_parent`
` <= max(1,b)^N * A_C/N(C)`
`    * sum_(live B) frozenControl(B)^2 * childEnergy(B)`.

The source's word "live" at this stage means nonzero frozen coefficient. It must not be confused with the subset of live slots within an allocation.

Now use the actual child hypothesis. `FirstPhysicalSourceAllocationControl.frozen_live_control:19` proves by complementary products that

`frozenControl(B) * product_(live slots) M_i = product_(all slots) M_i`.

The child control vector is exactly the parent vector restricted to live slots. Squaring gives the identity

`frozenControl(B)^2 * (product M_child)^2 = (product M_parent)^2`.

It holds for every allocation, without a positivity division or an assumption that any control is nonzero. Enlarging the live sum to all allocations costs no sign problem because `E>=0` and all squared controls are nonnegative. Therefore the sum contributes a **second** factor `A_C`.

`allocated_control_mass:40` invokes the allocation bound with coordinate cap `N+2` and exponent `eps/2`. If that bound is `A_C<=D*N(C)^(eps/2)`, then

`A_C^2/N(C) <= D^2*N(C)^(eps-1)`.

The source squares the bound explicitly and uses the real-power identity with positive ideal norm. It does not pay only one count while using two. The final common-energy constant is `max(1,b)^N*D^2`, with the intermediate source name for `D` adjusted by the allocation-mass theorem.

## Power extension and edge cases

For a nonzero frozen coefficient and `b>=1`, `AmplificationChildSourceCaps.common_volume_le:58` applies the same raw-reduction comparison to prove

`V_child <= b^N*V_parent/N(C)`.

The power theorem uses `alpha_j>=0` to raise this inequality and `E_j>=0` to sum it. No statement with arbitrary signed exponents or coefficients follows. The bound also works for zero exponents and an empty finite power family. Its separate linear-volume specialization obtains the extra factor `1/N(C)` from this same volume inequality; it is not part of the basic `eps-1` transfer.

If there are no allocations, the exact polynomial allocation identity forces the common polynomial to vanish, and the finite sums are empty. If `C` is the unit ideal, its norm is one and the inequalities remain meaningful. `C=0`, a zero physical scale, and negative sampled radial weights are outside the energy theorem's hypotheses. No limit in these excluded variables is supplied here.

`commonData` fills inherited generic row fields with an empty set and zero weight. This does not trivialize the energy being estimated: `childNormalizedGaussSource` is defined from `sourceGaussEnergy`, the actual finite columns and coefficients, and the full radial lattice sum, divided by positive child volume. It is not the separate generic `Data.energy` on those unused row fields. I inspected these definition bodies and the `allocated_input_energy` equality.

## Remaining proof cut

The allocation-count bound, complementary-control identity, live support estimate, two-count payment, normalized volume algebra and nonnegative-power extension have now been reconstructed. They do not require the radial Fourier envelope or a later improved sieve/QRH conclusion.

The exact source-to-allocation coefficient identities still rely on support extraction, residual tuple reindexing, the prime-slot fact that a frozen slot leaves residual factor one, and the masked live-profile identities. I inspected the immediate calls and finite rearrangements in `CommonAllocationSum`, `SourceLiveColumn` and `FirstPhysicalSourceOriginalData`; I did not reprove all lower tuple, ideal, character or profile identities in this task. The explicit lower interfaces are `sourceFiber_product_sum`, `residual_source_profile`, `original_source_punctured_column`, and `live_gaussPolynomial`.

Energy existence and positivity use `gaussEnergy_hasSum_re`, whose immediate proof comes from `gaussEnergy_summable`; the latter's full analytic proof is outside this audit. The divisor estimate uses fixed-number-field ideal finiteness, unique factorization and norm multiplicativity. These standard/library and arithmetic foundations are retained explicitly.

Most importantly, the bound on each nonzero frozen child's actual normalized energy remains a premise. The amplified child-energy producer, its admission conditions, and the calling induction must provide it. This finite allocation transfer is now distinguished from that analytic obligation; no progress schedule or global provider is inferred from it.

## Pinned sources

Paths are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL`. Hashes freeze files; only the named bodies and ranges discussed above are within scope.

| Source | SHA256 | Read scope |
|---|---|---|
| `Moments/FirstCommonSourceBudget.lean` | `C409066589A7187C223E1A60088B1E8BC4E6F0A8FFC444FD94DF45DF393E3A4C` | Full child-positivity and live-common-energy assembly |
| `Moments/FirstCommonSourcePowerBudget.lean` | `F369306E785677A776C3BAF09EAE64B6D834141E294F504F690FE1054DC346D1` | Full power and linear-volume transfers |
| `Moments/FirstPhysicalSourceAllocationControl.lean` | `0C0BC48310A6D5A18A79372A2B9CCF9137A0B23F3F5A0F76DB799EEC590B2EC9` | Full complementary-control and count-squared proof |
| `Moments/AllocationCost.lean` | `8B42C5DAA737360A53E2DED445FEA04C273ED8C567EE92E181C31A0DB8567E0C` | Uniform small-power allocation count |
| `Moments/CommonAllocationSum.lean` | `7630E12A9729D0820E7D3DDA157E59DE6D311CC26F2B541850C632C8B2647B7F` | Definitions, finite partition, divisor injection and count |
| `QuadraticSieve/FiniteOperator.lean` | `4A8A56A5AC5A218C00616F40749B33A1942DC65F579BB6DF216F039EC2BA32BF` | IdealDivisorBound, lines 276–410 only |
| `Moments/CommonRawScale.lean` | `9167B10E42D1321F176FC86CA23BA89EC8758E34CF71B9413D4C06067D79067B` | Full raw-scale and support/norm comparison |
| `Moments/FirstAllocationGaussEnergy.lean` | `816D14E0E9E9FEA44DA0BD6A3434869A91423BFFEC65BF849157BA48E542A6C1` | Actual energy, summability adapters, normalization and coefficient bound |
| `Moments/FirstPhysicalSourceAllocatedInput.lean` | `F8BE7972BD1604B5682330EA9B6720644FDD6B5E5B28DD0FE79A469531AD534C` | Actual child column/energy/volume adapters |
| `Moments/FirstPhysicalSourceOriginalData.lean` | `F3DD66FE9B2A1B65422FCAD04DBD0DB99E0C22583BF1F93D7EC1317C67D961BB` | Allocated-data definition and common_gauss_allocation |
| `Moments/AmplificationChildSourceCaps.lean` | `2E8C744EBA824E73580216150557A7AC8525C405823997675D2F6918C18DBF8B` | Common volume identity and bound through line 75 |
| `Moments/AmplificationChildInput.lean` | `EF430B59F9C352E98CC2B7DE3C0B3045D93E3A4F3110B723268730EDB9976EC0` | Definitions, child pool/profile/column and energy identities |
| `Moments/CommonRadialData.lean` | `20CD6C8F88BEC6A294DBCB3EE0C80EEAA74A095452B2353F2B36D58774B96E6B` | Input definition and commonData fields |
| `Moments/CommonProfile.lean` | `79A92558A50057439C252B603D45C1CB5D7044457D8041B4A0289B168007DA26` | Live slots, complementary products and immediate profile splitting |
| `Moments/SourceLiveColumn.lean` | `86DB65FAB3858521F724456A3CDB61D6C17062A4E3E788FD3F371D070FDB8F30` | Frozen coefficient and immediate source-column reindexing |
| `Moments/SmoothedWindowEnergy.lean` | `448DFDA39CD97DB6E875F0CE4D885FE5600F90498ED5797C087BE1969B459575` | gaussEnergy_hasSum_re interface only |
| `Moments/EligibleEnergy.lean` | `A482485229654996866B3BA2230533521D9CACB553524D29A6DB49B9AD25C0D2` | Data definition and distinction from separate finite-row energy |
| `Moments/ActiveDivisorShell.lean` | `7615F59BDBA12C6766FF35EA65E1045DD88E2F22BE75F3E3129ECCC49746221A` | Source structure only |

All parameters and energy hypotheses above are retained. These eighteen source pins are not a full dependency closure. Earlier positive-band and whole-product reports remain unchanged.
