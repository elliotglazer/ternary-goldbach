# Independent review of the sparse three-prime basis frontier

2026-11-11. PASS at paper and exact-cardinality scope. No correction requested. This does not certify any catalogue, compressed graph, prime supply, achieved cost reduction or formal implementation. No prime search, primality evaluation, sumset evaluation, transform or build was run.

The reviewed author file is `prime-estimates/SPARSE_THREE_PRIME_BASIS_FRONTIER_2026-11-11.md`, SHA256 `F394A98D39555F0AAA4AA033004DE07C8EC136B0659AD17FF4519BAB947CBA89`. I read the complete report and its scalar source/receipt, reconstructed the mathematical implications below, and independently checked the reported integer thresholds without importing or executing the author script. The prior interval-cover/frontier files were consulted for the chain comparison only.

## Exact obstructions

The affine index construction is a bijection from digits (a,b,c) in [0,h)^3 to a+hb+h^2c in [0,h^3). This follows by repeated Euclidean division. Its translated X catalogue requires h consecutive odd primes. For h>=4 this is impossible: among any three consecutive odd integers one is divisible by 3; when all exceed 3 that term is composite. Starting at 3 gives 9 as the fourth term; starting at 1 or below already fails primality. This disproves the specified construction, not all prime additive bases.

For a progression of h prime values all greater than h, take any prime ell<=h. If ell does not divide the step, multiplication by that step permutes the residue field; the first ell terms include zero. That term is greater than h>=ell and therefore is not prime. Hence every such ell divides the step. The lower-value hypothesis is essential, and the author retains it. No prime-distribution assertion enters this proof.

For the residue obstruction, modulo 2h there are exactly h/ell odd classes divisible by an odd prime ell dividing h. If h/ell>=2, at most one contains the value ell; no other class contains a prime divisible by ell. Two fixed odd residues for the middle/high catalogues sum to an even shift, so their required low classes run through every odd residue when the targets do. This proves the claimed failure. Powers of two avoid this particular odd-divisor argument but do not repair consecutive odd prime progressions.

For a pair interval [u,v] of even values, a prime translate covers odd integers [r+u,r+v]. The next required integer is r+v+2. For increasing r, the necessary and sufficient adjacent-translate condition is r_next+u<=r+v+2. This is exactly the displayed bound r_next-r<=v-u+2. Pair cardinality or span without interval containment cannot replace the hypothesis.

## Cardinalities and layout comparisons

There are M=N0/2-4 odd targets from 9 through N0-1. Mapping ordered catalogue triples to their sums yields |A||B||C|>=M even with collisions. For a fixed sum of three nonnegative integer sizes, balancing two sizes differing by at least two strictly increases their product unless the third is zero; the maximal product is attained at three sizes differing by at most one. The reported threshold 2372338663 is therefore the minimum sum under this product constraint. The equal-size threshold is 790779555.

If the union has u elements, every sum has an unordered size-three multiset from that union. The number of such multisets is u(u+1)(u+2)/6, regardless of which labelled catalogue assignments actually exist. This gives the necessary union threshold 1436941812. Repetitions are correctly allowed. None of these lower bounds supplies a prime catalogue or near-injectivity of its sums.

The independent script checks both sides of every threshold, the bit-mask size, 2^88<M<=2^89, and the 90-bit dense-array size. For a prime-field transform with an element of order 2^89, Lagrange's theorem requires 2^89 dividing p-1, hence p>=2^89+1. This is only the specified single-prime transform model. It is not a lower bound on every compressed proof or convolution implementation. The author correctly leaves no-wrap padding as a further requirement. The two chain minima agree with ceil((N0-1-B-3)/(B-2)); they compare geometric necessary counts, not available primes or equal proof costs.

## Coverage-DAG proof

Use exact d-digit catalogue languages with beta^d>T. A catalogue DAG must recognize precisely the certified finite catalogue, including padding and acceptance. When suffix positions are merged, this is a language-equivalence obligation; a graph that accepts a new uncertified number is invalid.

For any fixed graph path with target digits z_0,...,z_(k-1), the invariant is existential for each listed configuration. There are three genuine catalogue paths with the recorded positions and digits whose lower values A_k,B_k,C_k satisfy

    A_k+B_k+C_k = sum_(i<k) z_i beta^i + beta^k carry_k.

At the root all lower values and the carry are zero. For a child configuration, its witnessed parent plus three catalogue edges and the digit equation establish the invariant after multiplying that equation by beta^k and adding it. Thus a subset of valid successors is sufficient. No enumeration of omitted decompositions is required. Each successful terminal configuration has accepting catalogue endpoints and carry zero; the invariant then gives natural-number equality with the target, not a congruence. Since the largest digit sum plus incoming carry is 3(beta-1)+2=3beta-1, a legal next carry is always at most 2.

All target words must have a path through checked branches. The range automaton can read least significant digits first: maintain the comparison of the truncated value with each truncated bound, overwrite that comparison whenever the new higher digit differs, and otherwise retain it. For parity, track the accumulated digit value modulo 2; simply inspecting the first digit would be insufficient for odd beta. Depth is part of the state. These rules give an exact finite adapter for odd 9<=n<=T, as required by the author's generic adapter obligation.

At depth d, every accepting target state requires a nonempty successful configuration. Rejected complete words need no representation. Early omission is safe only with an independently checked proof that the prefix has no accepted completion; a currently undecided comparison is not rejection. The author already requires complete valid branching and does not authorize this shortcut.

At a shared child, the subset witness must hold for every incoming edge. Induction then proves reachability for every path into that node separately; the catalogue witnesses may depend on the path. Equality of stored configuration sets or target-automaton states alone is insufficient. A concrete illustration uses binary targets 11 and 13 in [9,63]. After three digits both prefixes are odd, greater than the lower bound's suffix 1, and less than the upper bound's suffix 7. They therefore have the same comparison state. The fixed catalogue triple (3,3,5) has lower sum 11, residue 3 and carry 1. It is reachable for the prefix of 11 but not the prefix of 13, whose residue is 5. Their remaining target digits agree. Reusing that configuration without checking the incoming edge from 13 would falsely supply a representation of 13 by this fixed triple. The required incoming-edge witness rejects exactly this error.

This proves the complete-cover implication. It also explains why witness occurrences E must count all incoming edges, not just distinct shared nodes. Membership/lookup, indexed binding, arbitrary integer lengths and catalogue equivalence remain checked work. The expression beta*H bounds branch slots, not their machine or kernel cost. A fallback must cover the exact remaining target language; calling its span covered while omitting holes would be invalid.

## Scope and evidence

The architectural verdict is supported. The separable affine shortcut is impossible, the dense layout is enormous under its stated model, and a checked covering DAG is sound. The unknown quantities are actual catalogue production, H, E, representation cost and fallback size. The note credits no actual compression, measured speed or existence of a competitive sparse basis. This review does not promote that conditional architecture into a produced certificate.

Independent script `zero-sum/review_sparse_three_prime_basis_20261111.py`, SHA256 `76BC2DBB2D04E5FF33E7F040F254EC929F81929F70D8E58FC15A44F9BBAC8283`, exited with `PASS_EXACT_COUNTS_AND_EDGE_CHECKS` and 16 exact checks. Receipt `zero-sum/review_sparse_three_prime_basis_20261111.json`, SHA256 `3F6BF37D40242C52F3CA8FED4F12AA26B806D9EB439DFE021795ABAD3A77AA84`. It verified the author note, scalar source `1628102F9719F8670899BE642E59B7D4F90FC719ABF5FADEA34673ECDB8719B8`, and scalar receipt `066B84F47AE77195B5EF6C1C2FB7B4E4E4FECC9BBFD15672F5CFA04AA00F8F0C`. No author file was changed.
