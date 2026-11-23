# Independent review: primitive-output character transforms

2026-11-11. PASS for the stated exact circuit identities, character coverage, conditional rounding transfer and integer operation inventory. No correction remains in the frozen version reviewed. This is not a transform execution, spectral certificate, runtime estimate or Lean verification.

## Frozen scope

Author: `zero-sum/PRIMITIVE_OUTPUT_PRUNING_EFFICIENCY_2026-11-11.md`, SHA256 `CB4085D00AED0BFDA9ADC1BB7306DB24EF052502C99F30D45E15AEF6EEC3F8B8`.

Author script: `zero-sum/primitive_output_pruning_inventory_20261111.py`, SHA256 `EFA92DB65FC1419243CF9A6FF1DE063E19718E5AE4ADCB297D195B34D25F41D5`. Author receipt: same basename `.json`, SHA256 `407DB4730F9A31811D4B95184225C0619630FAD69B22B106CA565B3444C5E0DA`.

I read the full frozen report, inspected its integer circuit implementation, and independently reconstructed the inventory. The arithmetic character bridge is the previously reviewed `FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md` (`53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54`); the full reference circuit is `MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md` (`C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01`). Their historical analytic profiles are not substituted for the fixed R138000 inventory.

The new review does not re-prove the underlying unit-group classification or the prior full FFT error theorem. It checks that the restrictions and circuit reductions satisfy those established interfaces.

## Character indices and inverse coverage

For odd p and e>=2, the kernel of reduction from units modulo p^e to units modulo p^(e-1) has order p. A character indexed by k in the specified cyclic generator is nontrivial on this kernel exactly when p does not divide k. For e=1 the only character induced from conductor one is k=0. Thus the two odd-prime restrictions in the report are different and correct.

At conductor 4 the sign index must be 1. At 2^e, e>=3, the -1 coordinate is unrestricted while the power-of-5 coordinate must be odd. In particular the full two-point sign transform must not be deleted. CRT makes the local primitive restrictions a Cartesian product. The inventory correctly excludes exact two-adic exponent one and treats conductor one separately.

Negation modulo each cyclic length preserves the restrictions: p divides n, so p divides k iff p divides n-k; zero is fixed under negation; odd indices remain odd in an even-length axis. Consequently all inverse labels remain. This is not identification of conjugate characters, deletion of one positive-height channel, or permission to drop central zeros. Output reordering must still map the tuple back to the fixed manifest label.

## Exact retained dependencies

For n=rm, input index j=a+rb and output index k=v+mu, direct expansion gives

    jk/n = bv/m + au/r + av/n + bu.

The integer bu has no Fourier effect. The second transform for a fixed v only consumes that v from all first transforms. Thus retaining the projection V of the requested k set, and retaining precisely the requested u set for each v, is sufficient and loses no predecessor.

If only k=0 is omitted, all first-transform v outputs remain necessary; only the second transform at v=0 omits u=0. This proves the author's equation (2). If q<n and q divides m, k mod q=v mod q. One can omit all v divisible by q, and all u remain necessary for every surviving v. This proves equation (3).

The q|m condition is not a general CT fact. It holds here because the smallest-prime-factor schedule removes the factors of p-1 before the p-power part; the p-power case reaches q=n at the final p leaf. The same reasoning applies to powers of two. A Bluestein leaf stops this recursion. The independent reconstruction asserts this condition for every actual request.

The direct-prime leaf retains every operation of each requested row. Omitting row zero saves its r-1 additions, not its nonexistent nonidentity twiddle products. The n=2 restricted leaf is the original subtraction. The Bluestein rule retains all input chirps, both padded transforms, all P nonunit point products, and the complete inverse normalization; only unnecessary final chirps are removed. In particular it does not reuse a pruned inverse FFT or assume the Fourier-transformed convolution kernel has unit norm.

At the outer tensor level, later axes mix only entries sharing each completed-axis prefix. A discarded local imprimitive prefix cannot be needed by any primitive final tuple. Hence the line count is exactly the product of previous retained sizes and subsequent full sizes. All original unit-residue inputs remain, and normalization remains the product of full axis lengths, not the primitive-output count.

## Axis order and rounding

For two adjacent axes i,j the difference between their two G costs, after cancelling positive outside factors, is

    G_i (m_j-r_j) - G_j (m_i-r_i).

Sorting G_i/(m_i-r_i), with zero deficits last, therefore minimizes G among orders of these fixed separable circuits. The adjacent-swap argument proves precisely this limited optimization. It proves neither globally optimal Fourier circuits nor minimum bit cost. Secondary addition-cost tie breaking does not change the G optimum.

The frozen report now explicitly gives the necessary rounded-subgraph contract: same inputs, coefficient enclosures, arithmetic formulas, row summation order and rounding at every retained gate. Under that contract induction in topological order shows equality of retained stored values to the chosen full reference. Merely sharing the same exact Fourier formula would not suffice.

For the original axis order this transfers the existing full-circuit peak and error bounds. Reordering axes changes the full reference. The earlier product-axis error bound is permutation invariant in its full-node coefficients, so its fractional precision condition transfers. Its fixed-order intermediate-width bound is not permutation invariant: prefixes have changed. The report expressly leaves this width comparison open. This resolves the review concern raised before freeze. The .708022 product ratio must not be reported as a bit-cost saving with unchanged old widths. The same-order .708532 ratio is available without that particular reordered-prefix issue.

## Independent metadata checks

I used a separate linear smallest-prime-factor sieve, rebuilt the full and restricted recurrences, and reconstructed all conductor axes and tensor counts without importing the author's program. No transform, root of unity, character value or special function was evaluated. The independent script and receipt are:

* `major-constants/review_primitive_output_counts_20261111.py`, SHA256 `B4857F8698F242DBEE9DAC07351CB073E12FDDF464842A672F02B1B73F336B74`;
* `major-constants/review_primitive_output_counts_20261111.json`, SHA256 `CB10F62270D69177CCEA738A1B32FAA81C4DF2A5790C276BF3D749A318304743`.

The independent run matched every all/large/small total and every stored example. It checked 12,960 top-level restrictions, 13,221 recursive requests and 210 additional finite indexing/inverse/CT identities through length 256. The finite checks supplement the general proofs above; they do not replace them.

For c>10000, full G is 2,736,537,742,659,260; same-order restricted G is 1,938,924,872,313,744; reordered G is 1,937,530,158,480,010. Reordered additions are 3,982,154,589,952,312 versus 5,668,480,164,659,994. These reproduce the displayed ratios. Filtering only between full axis transforms already gives G=1,941,517,858,969,426, supporting the author's attribution of most of the gain to completed-axis filtering.

The same fixed J(c)=ceil(64H(c)/5)+1 multiplies every compared circuit. There remain 130,500 large-branch conductors, 4,673,659,621 primitive labels and 103,868,439,142,446 coarse residue-height inputs. The script preserves the original piecewise height rule, including the even-conductor transition at 125000. This is a comparison at R138000, not a silently recomputed R132900 inventory.

## Remaining obligations

Actual source coefficients, elementary enclosures, retained gate implementations and their refinement to this circuit, reordered intermediate widths, auxiliary coverage and spectral sign/count success remain separate. No new savings in input contractions or full kernel setup are proved. The small-conductor theta/time branch is unchanged. Induced-character consumers still need conductor descent rather than values of the discarded imprimitive outputs. End-to-end generation and verification costs cannot be inferred from the character-transform operation ratio alone.

No author artifact was changed. No Lean build or numerical transform was run.
