# Review of mixed-radix character-transform efficiency

2026-11-11. Verdict: PASS at bounded finite-algebra and exact-metadata scope. The specified mixed circuit saves arithmetic relative to the specified whole-axis Bluestein baseline on the unchanged coarse grid. No correction is required. This is not evidence of an improvement over Platt's optimized implementation, a measured runtime ratio, sufficient numerical precision, or a completed spectral certificate.

## Frozen inputs and independent evidence

Paths are relative to `work/qrh-campaign/agents/`.

| File | SHA256 |
|---|---|
| zero-sum/MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md | C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01 |
| zero-sum/mixed_radix_character_inventory_20261111.py | 405864B2DF656C24111A21331592A255B92C6CE238E789D4B494BD8CE30865CD |
| zero-sum/mixed_radix_character_inventory_20261111.json | 2AC4DBAF9D0C41D1DFD8006AC280619DFF6C3059D7DA7FAEF6F1C477D2CE4D3F |
| independent-feasibility/review_mixed_radix_inventory_20261111.py | 54287157682B18D6F36A702151AB85519E402170467445EF8B44345E65A23F00 |
| independent-feasibility/review_mixed_radix_inventory_20261111.json | 83E85F7BD67CD05D5085339AF5A4931D3F72C012047A03B397BF0F0EC4C33575 |

I read the full report and code and independently reconstructed the operation inventory. The separate implementation counts radix-two work stage by stage, classifies cheap chirps by the parity of their lattice index, counts cross roots using divisors, and derives primitive counts by divisor subtraction from totients. It imports no producer code. One metadata-only execution passed 650 checks covering all five conductor ranges, all five operation categories, active-tree counts, kernel setup, small exact root classifications and the stated ratio intervals. No roots of unity, transforms, characters, primes under test, L-values or zeros were evaluated. No Lean build was run.

## Transform identity and scale

For n=rm, substituting j=a+rb and k=v+mu gives jk/n=bv/m+au/r+av/n+bu. The last term is integral. Thus the positive unnormalized transform is exactly r length-m transforms, the av/n cross factors, and m length-r transforms, followed by the stated placement k=v+mu. There is no hidden r or m multiplier in this unnormalized identity. Conversely a normalized library transform requires its explicit length factor.

Factoring a single cyclic axis by this identity differs from applying independent transforms on the CRT unit-group axes. The latter already have a product-group character pairing, so they need no additional cross factor. The input/output permutations and the sign of the character exponent are essential. A negative convention would label the inverse character; numerical equality cannot be inferred by silently changing that convention.

The inspected FLINT v3.6 factor step contains the cross-twiddle multiplication and final reorder, while its product-group setup sets the cross-twiddle pointer to null. Its Bluestein routine caches a transformed kernel and performs forward/product/inverse work per input. These support the architectural comparison, not an instruction-level identity with this separately specified circuit. Sources: [factor step](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dft/step.c), [product-group setup](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dft/prod.c), [Bluestein implementation](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dft/bluestein.c).

## Fair operation accounting

For radix two, each stage has n/2 butterflies and n additions/subtractions. Summing stage identity twiddles gives n-1, and summing quarter turns gives n/2-1. Subtracting both from nk/2 proves G=nk/2-3n/2+2. No separate negation is added to the already counted subtraction. This agrees with the independent stagewise construction.

For odd prime r, precisely the nonzero-input/nonzero-output pairs have nonidentity coefficients. There are (r-1)^2 such products and r(r-1) additions. The direct prime circuit is a valid conservative choice; it is not an optimized radix-three or radix-five implementation.

At a cross stage, 0<av<n for nonzero a,v, so a nontrivial cross factor cannot equal 1. The only cheaper fourth roots occur at av=n/4,n/2,3n/4. This proves the quarter-turn, negation and remaining general-product partition used by the metadata.

For a chirp exp(pi*i*j^2/n), a fourth root occurs exactly when n divides 2j^2. The divisibility condition is equivalent to j being a multiple of d=product p^ceil(v_p(n/gcd(n,2))/2). Independently, write j=d*l. Then 2d^2/n is integral and l^2 modulo 4 is zero for even l and one for odd l. This gives the same identity/quarter-turn/negation partition without the author's loop over each cheap j. Small-length direct integer checks through n=300 agree.

Bluestein's quadratic identity has the correct signs for the positive transform. Its internal convolution inverse contributes division by padded length P, hence P exact dyadic scalings in the specified schedule. There is no final division by n. The two chirp applications have the same operation classification, and the two radix-two transforms use the same counts. Both baseline and replacement apply these identical cheap-root rules. The improvement therefore does not arise from pricing identity or quarter-turn roots only in the new circuit.

The comparison remains specific to these circuits. Charging every transformed-kernel point product as general is conservative in both; special values or fused operations could change either cost. The new selection rule limits G and A relative to whole-axis Bluestein, not every cost category or every precision policy. The independently reproduced aggregate happens to decrease all five categories.

## Reproduced saving and unchanged domain

For c>10000 the old and new operation vectors, ordered as general products, additions, quarter turns, negations and dyadic scalings, are:

    old = (4890157406463512, 11446911736111484,
           587381965694890, 2976648965674, 577076958982144)
    new = (3041383327064694, 6301213142003526,
           279797486233036, 66590728284, 271405257746112)

The product ratio lies in [0.621939,0.621940], and the addition ratio in [0.550472,0.550473]. Twice the prior 5723455868055742 butterfly count equals the old addition total exactly. The new baseline thus remains consistent with the earlier inventory after resolving its cheap-root categories.

The same 142500 conductors, 5525163079 primitive labels, 114223068442718 residue-height inputs and 75730502011007 coarse output slots are retained. All phi(c) transform outputs are produced before primitive filtering. No imprimitive deletion, negative-channel deletion, relaxed height, fewer ordinary sign tests or lower precision explains the saving. The all-conductor totals are an alternative point-transform schedule; they cannot be added to a separately charged small-conductor theta/time schedule.

Kernel setup and active-tree counts also match. The smaller Bluestein cache does not eliminate cross-root generation, direct-prime roots, permutations or guard precision. The sum of kernel entries is neither peak memory nor proof input size. Streaming and reuse require actual retained root enclosures at the required precision.

## Remaining implementation and cost obligations

The finite identity proves the exact mathematical circuit. To certify approximate outputs, a checker still needs outward gate bounds or a sound per-node error recurrence. Unnormalized child errors amplify by lengths; twiddle uncertainty multiplies actual intermediate magnitude. Bluestein padding can increase intermediate norms. The old radix-two precision budget is not automatically valid after this replacement.

The Hurwitz lattice, alpha contractions, root-number and Hardy normalization, interpolation, exceptional repairs, Turing work and complete-count acceptance are unchanged. These obligations retain the scope recorded in the preceding independent Platt cost review, E2C984CC219E5EA3B3AC1C41623A14B7EF0C3517313BE1BE3FE641318342179F.

For a decision, insert the new five-category circuit and setup counts into the same end-to-end ledger, with actual operand widths and proof representations. A reduction in this circuit's arithmetic is established. A total runtime or Lean/MM0 verification improvement requires the unchanged costs, new setup and precision policy. Historical software already used algorithmic optimizations; this packet makes no justified comparison against its actual execution time. The next meaningful implementation comparison should hold the input enclosures and output accuracy fixed and charge all root setup and proof work.
