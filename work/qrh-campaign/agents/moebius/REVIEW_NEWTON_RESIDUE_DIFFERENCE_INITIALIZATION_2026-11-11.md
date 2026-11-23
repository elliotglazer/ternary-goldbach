# Review of Newton residue-difference initialization

2026-11-11. PASS for the conditional exact-integer initializer, its operation counts and screened-domain width proof. No correction to the frozen note is required. The author is `prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md`, SHA256 `55576F70A22E3B94108C80CE6255D312437085E08281EFC6FBA34E65147E22BC`.

This does not admit an implementation or a larger family, deduct work from the selected ledger, or establish a runtime/proof-size saving. I read the complete author note and script, its receipt, the V2 exact-difference circuit and its independent review, and the already reviewed occupancy contract. Only formal coefficient identities and integer size/count calculations were executed. No coefficient values, polynomial function samples, analytic values, transforms, primes, zeros or builds were evaluated. Frozen files are unchanged.

## 1. Same exact object and explicit domain

The new initializer consumes the **screened full-state** variant of V2 section8, not its different pruned long-block variant. The guard remains c>20G, G=2Dout, and the tie rule remains downward as in the occupancy manifest. All coefficient lookups must use that same anchor. Final sourceD4096 still delivers Dout8192 and G16384; no source-grid denominator replaces the output one.

For each coordinate, with exact center n_j/2^b, v=2c and q0=Ga0-kc,

    f(t)=sum_(j=0)^19 n_j v^(19-j)(q0+Gt)^j,
    Q=2^b v^19,
    f(t)/Q=P((q0+Gt)/v).

This is precisely the finite polynomial of the admitted stored centers. It is not a new approximation to the Hurwitz function. All source uncertainty remains in the inherited actual-function-to-polynomial comparison. Exact common-grid alignment is required; b122 cannot be assumed for arbitrary future centers.

The all-numerator traversal, unit-only exports, skipped nonunits and complete cell coverage remain unchanged. The occupancy reference's screen phi(c)>20B_c implies c>20G. The new product-only R>10B screen does not imply that guard and does not enlarge the eligible conductor set. The author explicitly retains this restriction.

## 2. Independent polynomial proof and loop order

In the binomial polynomial basis,

    t binom(t,j)=j binom(t,j)+(j+1)binom(t,j+1),
    Delta binom(t,j)=binom(t,j-1).

Consequently the coefficient D_j in this basis is Delta^j f(0). These are ordinary forward differences, not derivatives divided by factorials. The circuit needs no division by j!; factorials occur only in one proof of the polynomial identity.

At degree i, multiplying the degree i-1 partial polynomial by q0+Gt and inserting C_(19-i) gives

    new D_i = iG old D_(i-1),
    new D_j = (q0+jG)old D_j + jG old D_(j-1),  1<=j<i,
    new D_0 = q0 old D_0 + C_(19-i).

The new top must be written first. Interior indices must descend, and D0 is updated last, so every lower old entry survives until it is read. This proves by induction that the stage-i state represents

    J_i(t)=sum_(ell=0)^i n_(19-i+ell) v^(i-ell)(q0+Gt)^ell.

At i=19 this is f, so the resulting state is identically the old 20-value forward-difference state for every signed coefficient vector, including zero coefficients. The later traversal has the opposite order: ascending j updates read the old higher entry and implement Delta^j f(t+1)=Delta^j f(t)+Delta^(j+1)f(t). Confusing the two directions would invalidate the proof.

My independent formal checker treats all20 coefficients, q0 and G as indeterminates. Every partial-stage vector agrees with the Stirling/binomial closed coefficients. The final vector also agrees with an independently expanded formal 20-node difference triangle. No actual polynomial samples are used. A draft metadata formula omitted the evaluation-at-zero qualifier; the frozen script and note correctly include it.

## 3. Count comparison and small-scale costs

Stage i has i general products, i small jG scales and i additions. Summing i=1..19 gives190 of each, per complex-integer pair convention. A complex scale consists of two signed integer products, and a complex addition of two signed integer additions. Counts must not silently switch between these units.

The19 coefficient prescales n_j v^(19-j) remain separate. They multiply by much wider powers of v, not by the narrow q0+jG factors. Their geometry powers may be cached with an exact binding, but the prescaled coefficient data change with their source array. Setting up q0 and the q0+jG/jG factor tables, and accessing any caches, also remains paid work.

For binary small-scale multiplication, j appears20-j times. The explicit sums are

    sum_(j=1)^19 (20-j)(popcount(j)-1)=167 additions,
    sum_(j=1)^19 (20-j)popcount(j)=357 shifted-operand occurrences.

These additions are additional to the190 recurrence additions. Every bit term multiplies the same coordinate by a nonnegative power of two, so all partial sums have the input's sign and magnitude no greater than the final small-scale product. This handles negative and zero coordinates as well. The shifts and their proof/data movement are not free.

Thus the stated initialization is190 general products,357 total additions and357 shifted operands, plus19 prescales and setup. The reference is380 general products and570 additions/subtractions, plus its own setup and the same prescale/output obligations. For an untrimmed full-state length L bucket, the new additions total19L+338 versus19L+551. The general-product reduction and213-addition reduction are typed circuit counts, not a cost ranking against old rounded Horner or a new aggregate saving. The old pruned long-block advance count must not be substituted here.

## 4. Raw temporary proof

The final-state identity alone would not bound intermediate products. The author supplies the required partial-polynomial invariant. Under c>20G and |q0|<=v/4, for0<=t<=19,

    |q0+Gt|/v <29/40<3/4.

With |n_j|<=C2^b this implies

    |J_i(t)|<4C2^b v^i,
    |Delta^j J_i(0)|<4C2^(b+j)v^i.

The second inequality uses only supporting polynomial values and the sum2^j of binomial magnitudes. It does not apply an actual Hurwitz bound outside the cell. For an interior update, the previous stage has degree i-1, while |q0+jG|<3v/4 and jG<v/2. Therefore the two raw products are respectively below

    3C2^(b+j)v^i and C2^(b+j)v^i.

Their sum fits the next-stage bound before any cancellation. The new top obeys the second bound with j=i. For j=0, the product and inserted coefficient each fit C2^b v^i, so their sum fits the same uniform bound with slack. Small-scale partial sums remain bounded as above. This accounts for the actual intermediate arithmetic rather than bounding only the final difference state.

At c<=265800, v^19 has at most362 bits. For C=2^16, initialization and stored full differences fit signed b+400 bits, and raw traversal additions fit b+401. These become522 and523 at an admitted b122 grid. Prescales fit b+379 signed bits. The general multiplier's magnitude is below398700, hence at most19 magnitude bits plus sign. Exact variable-degree prices may be smaller, but none are assumed. Denominator powers, alignment, signed operations and the final quotient/round witness still need ordinary-rule implementations and costs.

## 5. Error and acceptance consequence

The initializer computes exactly the same differences and rational output as the V2 reference. It therefore inherits its final output conversion and actual-function error comparison without a new numerical radius. It does not claim identity to the older rounded Horner center. No seed error is repeatedly injected into the exact difference state: the original source-to-finite-polynomial comparison is consumed once at each admitted unit target.

This paper identity does not certify the supplied coefficient array, concrete products, unit/anchor manifest, final rounding or later spectral result. Those remain checked inputs and computations. It also does not remove the elementary head, conductor factor, character transform, sign/count completeness or any principal requirement. Only initialization of this same integer polynomial is replaced.

## 6. Exact evidence pins

The independent script passed432 formal-coefficient and integer checks. This is distinct from the author's1550 checks, which were read but not rerun. All author and predecessor hashes listed below were verified. No source dependency or frozen artifact was mutated.

| Artifact under work/qrh-campaign/agents | SHA256 |
|---|---|
| prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md | `55576F70A22E3B94108C80CE6255D312437085E08281EFC6FBA34E65147E22BC` |
| prime-estimates/newton_residue_initialization_20261111.py | `0252255539BCA950E3E296FE8D62CF89F3665E0D50BCF678999FAACF3D0755D6` |
| prime-estimates/newton_residue_initialization_20261111.json | `2DDC7485982B885DD0D122865DC662FE5983F600F7E2E8352EC75F0CC9B754BE` |
| integration/EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2_2026-11-11.md | `691A9B744FCCE7C7A8F0D8F18F08F70A68C758D2FFFF1C5E826F138E1257D025` |
| audit/REVIEW_EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_2026-11-11.md | `A21A7B16BFF97898E0D6C8F1FFBB3D39C231C1553BE2B9CF77B8770F5819261D` |
| prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md | `99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1` |
| moebius/REVIEW_LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md | `C6096D0C677E09F850065EDD2103B0348E28392D482CCEE568136B387768C86E` |
| moebius/review_newton_residue_initialization_20261111.py | `212FC0A78B817B12F91CF1DEC1B128273D2AF1E5C02560BC9C6D4E3F167817C3` |
| moebius/review_newton_residue_initialization_20261111.json | `70B2F13A139D16C9DD86CCA6D9F8997AD40CDFB0322BEFDEDA20311AF47B6C13` |

The accepted result is the exact initializer identity and its stated sufficient bounds on the screened domain. The existing occupancy frame remains frozen. A complete priced replacement still requires an explicit subset/circuit policy, concrete ordinary arithmetic, storage and binding costs, and the actual certificates.
