# Review of size-band supplied-root certificates

2026-11-11. PASS at paper/source and exact integer-metadata scope. No correction requested to `prime-estimates/FINITE_LADDER_SIZE_BAND_CERTIFICATES_2026-11-11.md`, SHA256 `14F7E2E2E16342FC9D30CD6EEBA2E2FE968C1EF7B1AB21EE9625097FE1E50AA3`. This accepts the proposed implication and charged comparison, not an implemented checker, any primality instance, or a measured speedup.

## Source criterion and strict threshold

I read the actual `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean:38–55` proof and the pinned Mathlib `Mathlib/NumberTheory/Fermat.lean:154–174` body. The latter theorem already quantifies over arbitrary natural exponent n. For a prime r!=2 dividing y^(2^m)+1 it proves r=k*2^(m+1)+1, deriving the nonzero residue and exact order internally. No additional gcd assumption is missing.

For an odd composite p>1, its least prime factor r is odd and satisfies r^2<=p. The divisibility passes from p to r. Since r>1, k>=1, hence r>=2^(m+1)+1. This contradicts p<(2^(m+1)+1)^2. The author's generic criterion is therefore the literal generalization of the source argument. The m=0 edge is valid: odd integers p with 1<p<9 are covered. The strict comparison is indispensable for untrusted inputs; the argument cannot silently accept equality with the composite square.

I separately checked N0=989*10^24<(2^45+1)^2 and all 132 threshold-adjacent metadata cases. These are integer comparisons only. They do not test any candidate for primality.

The implementation must keep the mathematical exponent symbolic behind the generic theorem. A Boolean modular-squaring checker should prove its modular invariant and apply that theorem, rather than ask Lean to normalize the literal natural y^(2^44). The new paper neither supplies that implementation nor claims the enormous literal power is cheap. Ordinary MM0 likewise needs the proved generic criterion and ordinary arithmetic inference rules, not a new primality axiom.

## Suffix and array binding

For s=44-m, the producer's state y=x^(2^s) mod p satisfies the suffix congruence after m squares whenever its original test succeeds. The arbitrary-y criterion means the final certificate need not contain or prove the omitted prefix. This is sound proof compression, not a missing hypothesis. Canonical y has the same capacity as the old canonical x field.

The claimed generation saving is appropriately limited. Retaining a known intermediate state during the original test requires an exposed trace. An old file containing x alone requires conversion work, and a compact small-base certificate still needs either the omitted exponentiation or the larger supplied root. Unsuccessful search work and root discovery are not removed by shorter acceptance.

For increasing candidates, the last candidate in a nonempty band suffices for its strict upper threshold. Empty bands are harmless. Lower bounds are unnecessary: a nonminimal exponent only makes the proof longer. Interpret the at-most-44 stored endpoints together with an implicit final endpoint K; if the final endpoint is serialized too, its extra field must be charged. The paper's header reserve is correct for the former convention.

The sortedness, root-array length, exact candidate references, shard predecessor equality and first gap are still mandatory. A claimed ordering without those checks cannot justify the reduced number of threshold comparisons. The source paper explicitly retains them.

## Coverage and forced savings

Let T=N0-1 and D=B-2. The binary interval for a prime p is the odd targets in [p+4,p+B]. Its even remainder stays in [4,B]. Because consecutive odd primes differ by at most D, these intervals cover without missing an odd target. The fixed p0=3 starts at 7; pK+B>=T closes the upper end. This does not establish the stronger original BinaryGoldbachInput at a smaller chosen B.

For A_j=(2^j+1)^2 and the first l with p_l>=A_j, p_l<=3+lD implies l>=ceil((A_j-3)/D). Exactly l-1 new records precede that crossing. Summing these lower bounds proves the displayed forced square-call saving. The identity sum_i(44-e(p_i))=sum_j #{i:p_i<A_j} is just counting the same finite pairs by their two coordinates. No prime density or regular-gap premise enters.

My independent metadata check obtains the hypothetical maximum-step counts directly from 3+iD<A_j, namely floor((A_j-4)/D), capped at K. It reconstructs all seven rows, all band populations, the exact savings and the header bits. It also verifies the terminal and pK<=T-4 inequalities on these hypothetical integer grids. Those grids are not asserted prime. The geometric minimum K does not bound actual K from above; the roughly one-percent sensitivity is not a guaranteed percentage of an actual mixed-format computation.

The direct comparison correctly weights each omitted modular square by the candidate's actual width. It subtracts library, array, band and I/O costs rather than treating the calls as CPU instructions. A selected sequence containing other certificate formats only saves the eligible supplied-root squares.

## Product batches and costs

A batch using m=max e(p_i) has the same sufficient per-factor size guard. A checked congruence modulo the exactly bound product implies each factor's congruence regardless of whether the generator used CRT. Intended CRT production does need compatible local roots, in particular distinct primes or a proper repeated-prime-power treatment. The paper keeps this distinction.

Splitting a list into b<=45 band runs increases the number of q-sized batches by at most b-1<=44, since sum ceil(length_i/q)<=ceil(K/q)+b-1. The new product widths, trees, CRT work and final-short-batch payload must then be recomputed. Keeping original batches and using their maximum exponent is also sound but saves fewer squares. Neither choice is a proof that product batching beats direct roots.

The empirical question remains the complete cost of a modular square and its reduction evidence at each width, plus setup and serialization. Lean and ordinary MM0 can use different cost functions. The note makes no unsupported instruction-count speed comparison.

## Independent evidence and scope

Owned script `integration/review_ladder_size_bands_20261111.py`, SHA256 `9FEAE3D57A5B035DC5490826E0427B2F2770690114A7954E7FAA936D7402C141`, performs 8424 exact integer/rational checks. This count includes bounded examples of the batch ceiling identity; its universal proof is given above. It imports neither author generator nor a numerical evaluator. Output `integration/review_ladder_size_bands_20261111.json` has SHA256 `27E8C4C6A9EE8C42D06C74C7CAD55753D9D3F83D4CB8CD7D4253E25E484A6350`.

All eight author/source/support pins were independently rehashed and are retained with absolute paths in that receipt. In particular:

| Source | SHA256 |
|---|---|
| Ladder/Spec.lean | 0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F |
| Mathlib/NumberTheory/Fermat.lean | 6A20F4E26D0345801E5CD7286CCA8A0A05130FFEAD8BDF4F501D09A2B4FD97A5 |
| Author metadata script | A7B4BCFE1426A651FC37BB5CB010E29E63DA6CA3F7D40AB2A820B51DDBDE02F4 |
| Author metadata receipt | E013872F1D68BF17E391F041CD289CB674CBF8A4AB7344AA6C77ED8E68B63781 |

I also checked the corresponding supplied-root, adaptive-chain and global finite-coverage interfaces cited in the author report. No new prime witness, modular residue, analytic value, build or Lean declaration was produced. All frozen predecessor files remain unchanged.
