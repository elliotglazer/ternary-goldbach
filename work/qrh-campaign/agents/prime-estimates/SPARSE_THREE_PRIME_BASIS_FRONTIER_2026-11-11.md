# Sparse three-prime bases: a precise obstruction and a different certificate

2026-11-11. Research only. No prime search, primality test, sieve, sumset or transform evaluation, analytic computation, proof build or source edit was performed. Only exact cardinality and representation arithmetic was run. This report follows the actual `FINITE_RANGE_COST_RESEARCH` and the newer finite-coverage frontier rather than replacing their open prime-production requirements with a distribution assumption.

**Verdict.** Sparse prime catalogues could in principle reduce the number of distinct certified primes well below a small-B ladder, but this does not give a cheap coverage proof. The simplest exact radix construction is impossible. A dense three-way convolution is much larger than the binary-prefix problem. A digit/carry covering DAG is a genuine alternative acceptance architecture; its decisive missing input is a compact complete graph for actual prime catalogues. No such graph or catalogue is asserted here, so this route does not presently supersede the adaptive binary/chain design.

## 1. Exact alternative target and its cardinality

Retain N0=989*10^24 and T=N0-1. Handle7 by2+2+3. Let A,B,C be finite sets of certified odd primes, and require

    every odd n in[9,T] belongs to A+B+C.            (1)

Membership means actual natural-number equality n=a+b+c, not equality modulo a radix or a selected prime. All catalogues bind their values to genuine primality proofs. The number of targets is

    M=N0/2-4=494499999999999999999999996.

The map from ordered catalogue triples to their sums gives the necessary condition |A||B||C|>=M. With three equal cardinalities, each needs at least790779555 elements. Among all three integer cardinalities, their minimum possible sum subject just to this product condition is2372338663, since for a fixed sum the product is largest when the sizes differ by at most one.

Catalogue overlap can reuse prime proofs. If their union has u distinct odd primes, there are at most binom(u+2,3) unordered triples with repetition. Consequently u>=1436941812 is necessary for this particular odd-prime basis covering(1). This is only a counting bound; collisions, out-of-range sums and local congruences can increase the required size substantially. It is not an assertion that a basis near that size exists. A design allowing prime2 must treat its parity cases separately; these counts are explicitly for the proposed odd-prime catalogues and the separate7 patch.

For comparison, the prior exact N0 geometry requires at least98900000000 new chain rungs for B=10^16, or49450000000 for B=2*10^16. This leaves a potential prime-certificate-count advantage for a sufficiently structured basis, but it compares necessary counts rather than produced objects or equal-cost certificates. Many general primes may have more expensive certificates than the ladder's fixed-order primes.

## 2. Why the tempting exact radix basis fails

Write odd primes as2x+1. A standard non-prime radix basis would take index sets

    X={x0+a:0<=a<h},
    Y={y0+h*b:0<=b<h},
    Z={z0+h^2*c:0<=c<h}.

Their sums cover exactly the h^3 consecutive indices starting at x0+y0+z0, with a unique digit decomposition. This would give a very short generic coverage proof from three short lists.

But its X prime catalogue consists of consecutive odd numbers2x0+1,2x0+3,... . Four consecutive odd numbers cannot all be prime. If the first exceeds3, one of the first three is a multiple of3 greater than3. If the first is3, the fourth is9; if it is1 or less, the first is not prime. An even-start analogue fails after prime2. Therefore h>=4 cannot instantiate this low-digit construction with primes. Its desired h near790 million is not a difficult prime search; the exact shape is impossible.

The obstruction extends to the other digit progressions. A progression a,a+d,...,a+(h-1)d of prime values, all exceeding h, must have every prime ell<=h dividing d. Otherwise its first ell terms run through all residues modulo ell, producing a composite multiple of ell greater than ell. This statement includes its indispensable lower-value condition; exceptional terms equal to ell cannot be silently excluded in a different range.

Another exact obstruction applies to a residue-only low digit. Suppose the middle and high catalogues each occupy one fixed residue modulo2h, and the target range contains every odd residue modulo2h. Then the low catalogue must contain a prime in every corresponding odd residue class. If an odd prime ell divides h and h/ell>=2, there are at least two such classes divisible by ell, while the only prime divisible by ell is ell itself. At least one class is impossible. Power-of-two h avoids this particular residue obstruction, but not the preceding full-progression obstruction.

These are obstructions to specified separable shapes, not a theorem that all sparse prime additive bases are impossible. Allowing prime-dependent digit lifts or corrections changes the carries, ranges and exact covering identity. Their adjustment cannot be credited as a harmless perturbation: every resulting target still needs a valid representation, and high-digit lifts can leave the permitted total range.

## 3. A dense sumset check loses the intended saving

Without a generic compressed covering identity, the direct checker builds or checks a positive coefficient at every target in(1). A one-bit-per-target output already has61812500000000000000000000 bytes. This is a layout size, not an information-theoretic lower bound for every possible proof. Streaming can reduce live memory but not the number of target entries processed by that layout.

Even an optimistically indexed dense transform needs at least2^89=618970019642690137449562112 slots to distinguish M consecutive target indices. A single-prime power-of-two NTT of that length requires a root of order2^89, hence a modulus at least2^89+1 and therefore at least90 bits. One array of fixed90-bit residues would occupy6963412720980264046307573760 bytes. Full no-wrap convolution may require a larger length based on the actual sum of degrees; the2^89 figure is an optimistic lower screen, not a sufficient padding choice.

Prime/root support, transform arithmetic, inverse or full-frequency equality, coefficient bounds, carry interpretation and catalogue provenance would all remain. The accepted small binary-tile NTT proof does not make this transform native or free. A dense three-way convolution at the final N0 scale therefore does not inherit the cost advantage of the tile-level binary certificate. Any competitive basis design must avoid dense expansion through a proved structural cover or a compact symbolic certificate.

## 4. Where interval templates collapse back to the existing family

Suppose A+B is proved to contain all even values in[u,v], with u>=4 and v-u even. For a fixed odd prime r, this gives odd targets[r+u,r+v]. Consecutive such translates have no missing odd integer exactly when

    r_next-r <= v-u+2.

The number of targets per translate is(v-u)/2+1. Taking u=4,v=B is precisely the binary-prefix-plus-prime-chain architecture. Translating the pair interval away from4 may improve the ease of producing that pair-sum certificate, but its length, not its large absolute endpoint, controls how many ternary targets one high prime covers. Low targets below the first translate remain a separate obligation.

A small family of pair intervals, or pair-sum sets with holes, is a genuine generalization. It must certify the union of their actual translates, including every hole and terminal join. Counting the cardinality of A+B, or its span, does not prove that it contains an interval. A reusable source-cover template can be consumed only by blocks for which every required anchor is actually certified prime. The latest finite-cover report already isolates that admission condition; no prime-pattern existence is added here.

Thus a nominal three-level design that proves one pair interval and then shifts it by a prime ladder has not escaped the old range-length/rung-count tradeoff. This observation helps reject misleading cost comparisons before any prime search.

## 5. A genuinely different exact certificate: digit/carry coverage

There is a sound alternative to dense expansion which does not require a full affine digit basis. Fix radix beta>=2 and a digit length d with beta^d>T. Encode each finite prime catalogue as an exact padded d-digit language, read from the least significant digit. A literal trie suffices. Suffix-DAG compression is allowed only with a proved equivalence to that same catalogue; arbitrary merging must not introduce new unchecked prime values.

For a target prefix, a configuration consists of three catalogue-trie positions and an addition carry c in{0,1,2}. It means that the three chosen lower digit strings add to the target's already-read digits, with carry c into the next position. Initially there is the single configuration of the three roots and carry0. A valid one-digit step uses actual catalogue edges labelled a,b,c_digit and a target digit z satisfying

    a+b+c_digit+carry = z+beta*next_carry.           (2)

All digits lie in[0,beta-1]. The bound next_carry<=2 follows because the left side is at most3beta-1. At depth d, a successful configuration has three catalogue leaves and carry0. Induction on(2) then proves exact equality of their complete prime values to the target integer; modular equality alone is insufficient.

To certify all targets, supply a levelled covering DAG. Each node records a finite set S of configurations plus the state of a fixed finite automaton recognizing the padded target words for odd9<=n<=T. Comparisons with9,T can be read least-significant-first by retaining the comparison of the digits already read and replacing it whenever a higher digit differs. Parity and the depth bound are also explicit. This target-language adapter is a generic arithmetic proof obligation, not a list of assumed covered targets.

Every target digit branch has a child with the correct updated target-language state. Its supplied configuration set S' must be a **subset** of the valid successors of S under(2). For every member of S', provide one parent member and three genuine catalogue edges witnessing the step. Exact enumeration of every possible successor is unnecessary: this is an under-approximation preserving genuine decompositions. At a terminal node whose target word is valid, require at least one successful configuration. Invalid target words can terminate vacuously. Branch completeness must still be checked; omitted valid digits cannot be declared impossible.

The soundness invariant is that every listed configuration is reachable by actual catalogue choices for the target prefix on that graph path. It holds at the root and is preserved by the witnessed subset condition. A nonempty successful terminal then supplies a prime representation. Shared child nodes are sound only when their subset condition is checked for **each incoming edge**, not merely one parent. This avoids a subtle unsound reuse in which configurations reached on one target prefix are imported into another.

This is not the binary-prefix-plus-chain proof: it follows three simultaneous prime choices through all digits, allows overlapping catalogue sums and can use different decompositions for each target. It also does not presuppose a new prime-distribution theorem. Its acceptance premise is finite concrete data plus independently checked primality and digit transitions.

### Conditional cost and the precise missing input

Let U be the number of distinct consumed prime values, H the number of covering-DAG nodes, E the total number of successor-configuration witness occurrences across all checked incoming edges, and Kcat the size of the exact catalogue representation. A possible checking schedule pays

    prime certificates for U values
      + catalogue binding/lookup for Kcat
      + complete target branches, at most beta*H
      + E bounded digit-sum/carry and parent/edge membership checks
      + terminal and root/range assembly.                (3)

Bit widths, indexed lookup, proof terms and context management still determine each cost. There is no claim that an MM0 rule or Lean kernel performs the entire schedule as a native automaton call. Hashes do not replace previously proved catalogue or transition facts. Generation pays construction of the catalogues, failed prime/root attempts, DAG discovery, compression and any unsuccessful plans. Proving the generator optimal is unnecessary; proving the supplied graph sound is mandatory.

For this alternative to win, the **actual** E,H,Kcat and complete production costs must be substantially smaller than the competing binary word work plus chain work. A naive graph has exponentially many target-prefix nodes, or enormous configuration sets, and gains nothing. Sparse input cardinalities alone give no bound on H or E. Prime catalogues can have irregular digits even when their membership proofs are cheap. The report provides no catalogue demonstrating useful sharing. Discovering a compact complete DAG is therefore the critical unresolved mathematical/algorithmic interface, not a rounding or modular-multiplication optimization.

## 6. Safe partial adoption and decision

A proposed compressed cover may fail on some target-language branches. Preserve those branches exactly, and supply either a complete conventional interval-cover theorem restricted to them or explicit prime triples. A witnessed prefix partition proves that the successful compressed leaves and the fallback leaves cover the full target language. A missing or unproved leaf rejects the certificate. The fallback costs must be charged; a large residual can erase the whole gain.

The useful next *research* question is therefore narrow: can any exact prime-catalogue shape supply a compact digit/carry covering graph without forcing impossible full prime progressions? A later bounded experiment, separately authorized, would need catalogue primality, all digit branches, a nontrivial merged node checked against each parent, and an explicit failed-branch fallback. It must report the realized graph sizes rather than extrapolating the cardinality minimum. This task authorizes no such search or run.

Until that interface has evidence, the accepted adaptive binary-prefix/prime-chain plan remains the better-supported design. The present work rules out two shortcuts: the balanced affine radix basis is mathematically impossible, and a dense final-scale convolution trades away the hoped-for proof reduction. It leaves a sound, genuinely different compressed-cover contract without claiming that suitable primes or compression exist.

## Sources and exact metadata

The primary prior inventory read was `independent-feasibility/FINITE_RANGE_COST_RESEARCH_2026-11-11.md`, SHA256 `0D4A300D37845AE20EB3242F89F08ED5984C0048646B60C1EECD2874945D8D48`. Its interval-cover argument is used only for the explicit comparison in section4; its historical numerical forecasts are not adopted.

The newer `prime-estimates/FINITE_GOLDBACH_GLOBAL_COST_FRONTIER_2026-11-11.md` has SHA256 `F950F36C3361A4BABB253B502168B613893DB5DCD002599A7BC261A950A16FC6`, with independent review `independent-feasibility/REVIEW_FINITE_GOLDBACH_GLOBAL_COST_FRONTIER_2026-11-11.md`, SHA256 `283E3BBB776CDCAC851448B0211C6C351C2FD1BC1C53FF58119FF07EE9FD57A9`. Its current N0 and complete-coverage distinctions are preserved.

The finite convolution comparison uses the previously reviewed `prime-estimates/EFFICIENCY_MM0_PACKED_NTT_2026-11-11.md`, SHA256 `9B212F658CCDE0E72FD255C751604C969A54D5B231D661BC5183E66E8E8368CA`, and `prime-estimates/EFFICIENCY_NTT_GRID_REUSE_2026-11-11.md`, SHA256 `84F02A3867A371313E81CC89664293986C52EC515EED2B2046BFCB0D94097738`. No new transform value or modulus is supplied.

New exact scalar script `three_prime_basis_sizes_20261111.py`: SHA256 `1628102F9719F8670899BE642E59B7D4F90FC719ABF5FADEA34673ECDB8719B8`. Receipt `three_prime_basis_sizes_20261111.json`: SHA256 `066B84F47AE77195B5EF6C1C2FB7B4E4E4FECC9BBFD15672F5CFA04AA00F8F0C`. These calculations establish only integer counting thresholds and explicit layout sizes. The polynomial/radix obstruction and covering-DAG soundness are paper proofs, not new Lean declarations or kernel-validated theorems.
