# A small smooth-factor portfolio for prime-ladder certificates

2026-11-11. Paper proof and exact integer geometry/exponent schedules only. No candidate prime was evaluated, searched for, or factored. The scalar script checks only the eleven fixed factors through 31, finite lattice formulas and integer exponent identities. No Lean/MM0 build, accepted computational extension, runtime estimate, or completed ladder is supplied.

## Concrete proposal

Put P=primorial(31)=200560490130 and allow F=mP for m in {160,162,165,168,175,180}. Search the same physical ladder window in these six lattices p=1 mod F, with ordinary Proth and arbitrary-prime fallback still available. A successful chosen F and a directly supplied root witness suffice; the checker need not reconstruct the producer's base or k-th powering. Failed searches remain producer cost and cannot be erased from an end-to-end comparison. The direct-root simplification below was identified during independent review before this note was frozen.

Every F has F^2>10^27. Their complete prime factorizations use only the same eleven primes 2,3,5,7,11,13,17,19,23,29,31. The following table lists powers exceeding those already present once in P:

| m | F | Prime powers replacing those in P |
|---:|---:|---|
|160|32089678420800|2^6,5^2|
|162|32490799401060|2^2,3^5|
|165|33092480871450|3^2,5^2,11^2|
|168|33694162341840|2^4,3^2,7^2|
|175|35098085772750|5^3,7^2|
|180|36100888223400|2^3,3^3,5^2|

All unlisted primes retain exponent one. The receipt contains every exponent and the positive margin F^2-10^27. This factor cache is tiny and can be proved once independently of the binary source bitmap. There is no need to enlarge that bitmap to certify these factors. The smallest lattice spacing is only about nine percent below 2^45; the larger geometric candidate pool comes mainly from using several distinct lattices, not from a dramatic spacing reduction.

This proposal concerns a prime ladder used with a separately certified binary cutoff B. It has no binary-anchor odd-residue obstruction: the remaining even number is handled by the binary theorem. It does not improve or establish that theorem.

## Same-window coverage, independent of the chosen modulus

For the five cutoffs below take S=B/2 and D=B/2-2. All listed S divide N=10^27. Require one certified odd prime

    p_i in [iS-D,iS],  i=1,...,K=N/S.

These intervals are disjoint and increasing. Consecutive chosen primes satisfy

    p_(i+1)-p_i <= S+D=B-2.

The base prime 3 covers odd numbers from 7 through B+3 by the binary theorem. Since p_1<=S, its interval [p_1+4,p_1+B] meets that coverage without an odd gap. Adjacent prime intervals have no odd gap because their starts differ by at most B-2. Finally p_K>=N-D, so p_K+B>=N. This proves the same ternary coverage once every rung is actually supplied. For a nondivisible endpoint, using K=floor(N/S) already gives p_K+B>N, since N-KS<S; that variant needs its own exact last-index check.

The checker should consume this interval-prime interface, not a global Proth offset formula. Existing Ladder.Spec.prime_of_runsOK hardcodes the old window; reusing its final logical coverage requires a generic interval adapter, not changing an old theorem's meaning. Both smooth-F and general-prime records must prove membership in the same interval and primality.

## Exact candidate counts and collisions

For an even upper endpoint e and even width D, the number of lattice candidates in [e-D,e] is

    C_F(e,D)=floor((e-1)/F)-ceil((e-D-1)/F)+1.

It lies between floor(D/F) and ceil(D/F). Neither endpoint is 1 modulo the even F. This counts integers, not primes or successful certificates.

An intersection of several portfolio lattices is exactly p=1 mod lcm(F_i). Therefore the union count has a 63-term inclusion-exclusion formula. It is incorrect to sum six list lengths and call them distinct candidates. Using floors for positive terms and ceilings for negative terms gives a uniform lower bound; swapping gives an upper bound. The common period is 1000716621552648000 and exactly 161084 residue classes in it belong to the union. This is an exact periodic-set statistic, not a prime-density statement.

| B | Required rungs K | Portfolio candidates, any window lower/upper | Portfolio at e=N | Six-list total at e=N | Proth 2^45 at e=N |
|---:|---:|---:|---:|---:|---:|
|10^15|2000000000000|52 / 115|82|90|15|
|2*10^15|1000000000000|132 / 195|162|178|29|
|5*10^15|400000000000|371 / 434|401|445|72|
|10^16|200000000000|774 / 837|805|890|143|
|2*10^16|100000000000|1579 / 1642|1609|1781|285|

The conservative any-window bounds need no enumeration of the enormous period. The top-window figures are one exact geometry example; no candidate was tested. Even the positive lower candidate bounds prove no successful rung. Compared with the earlier fixed-Proth geometry (S=157*2^45 or 313*2^45), these common physical windows also change the number of rungs. Their row counts cannot be silently replaced by the earlier 181029996372 / 90804183483 counts.

## Pocklington proof, including repeated factors shared with k

For p=kF+1<=N, k>=1, require a common base a and

    a^(p-1)=1 mod p,
    gcd(a^((p-1)/q)-1,p)=1 for every distinct q dividing F.

All q are the eleven certified small primes. There is no gcd(k,F)=1 premise and no need to factor k. For any prime divisor r of p, the order of a modulo r divides p-1. The unit test prevents that order from dividing (p-1)/q, so its q-adic valuation is the full valuation of p-1, including any extra q powers in k. Consequently F divides r-1. Thus r>=F+1>sqrt(p), contradicting the least-prime-divisor bound for composite p. This also covers repeated prime factors of p.

Do not divide the exponent by q^e instead of by q: that would lose precisely the full-valuation argument. F^2>N alone is not a primality test; every modular condition still has to pass. The small factor facts must be proved, not just recorded in a factor string or accepted from a hash.

The general acceptance rule is explained by work/mm0-efficient/primality.md, but that file's native prototype is restricted to n<=4*10^18 and 64-bit arithmetic. It cannot directly certify these up-to-90-bit ladder primes. Its timings are not a Lean or stock-MM0 forecast. Ladder/Spec.lean:38 has the narrower power-of-two criterion already; the smooth-factor order argument and its executable soundness adapter remain new work.

## Shared exponent tree

For a selected candidate first compute x=a^k mod p and y=x^m mod p. Let the leaves of a binary tree be the eleven distinct factors of P. A node labelled by a subset Q carries

    z_Q=y^(P/product(Q)) mod p.

At a split Q=Q_left disjoint-union Q_right, form

    z_left=z_Q^product(Q_right),
    z_right=z_Q^product(Q_left).

The leaf at q is exactly y^(P/q)=a^((p-1)/q). The exponents delete one q, while the initial m retains every repeated factor of F. The receipt contains all ten internal splits; a separate exact recursion checks every leaf exponent. A finite dynamic program selected a tree minimizing the sum of binary-method square and multiply counts. This is a schedule choice, not a theorem about weighted machine or kernel time.

For comparison, one can instead store x^(2^j) and multiply selected powers separately for all twelve outputs F,F/q. The counts below exclude the initial x, inverse checks, reductions/encoding setup, and factor/interval checks:

| m | Shared powers: squares / other products | Complement tree including y and Fermat: squares / other products |
|---:|---:|---:|
|160|44 / 227|129 / 46|
|162|44 / 233|129 / 47|
|165|44 / 236|129 / 48|
|168|44 / 219|129 / 47|
|175|44 / 259|129 / 50|
|180|45 / 233|129 / 48|

The complement tree trades more squarings for far fewer selected products. Both are reproducible schedules, not an established speed winner. Computing x by leading-one binary powering needs at most 44 squares and 44 other products because k<2^45. Actual k gives smaller counts.

A useful sufficient specialization saves another square and witness: require the q=2 leaf to equal -1 modulo p. Its square gives the Fermat equality automatically, and its difference from 1 is -2, a unit since p is odd. Thus only the ten odd q unit checks remain. The tree then costs 128 squares plus 46 through 50 other products. For a prime p a primitive root would satisfy this specialization, but the producer must find and check an actual successful base; no finite small-base guarantee is asserted.

The ten unit tests can share one inverse witness. Multiply their ten leaf-minus-one residues to form A modulo p using nine products, and check A*v=1 modulo p using one more. A product is a unit iff every factor is a unit, so this is equivalent to the ten unit tests. It uses ten modular products, like ten separate inverse checks, but only one inverse numeral instead of ten. This optional refinement was suggested by the independent reviewer; it is a paper acceptance rule, not implemented by the scalar script.

## Primary acceptance: a supplied root, including whole-product checks

The a^k initialization above is useful for producing a root, but is unnecessary for accepting it. Supply x directly and compute y=x^m and the same complement tree. Require x^(F/2)=-1 modulo the claimed odd p>1, and an inverse for the product of the ten odd-q values x^(F/q)-1. The q=2 equality implies x^F=1. For every prime divisor r of p, ord_r(x) divides F and does not divide F/q for any q|F. Hence it is exactly F. The strict bound p<(F+1)^2 proves primality. No equality x=a^k, factorization of k, or separate gcd(x,p) is needed. Our global p<=N<F_min^2 suffices for that strict bound.

This also works for a whole same-F batch. Bind M to the exact product of its claimed odd candidates p_j>1, each below (F+1)^2. Supply 0<=X<M, compute the complete tree modulo M, require its q=2 leaf to equal M-1, and check one modular inverse of the product of its ten odd-q leaf-minus-one residues. All these identities descend to each p_j because p_j divides M. The order argument then proves every p_j prime. There is no per-candidate modular-power replay, k progression or separate gcd after this global acceptance; exact product construction, factor membership, bounds and interval/slot coverage are still mandatory.

The accepted arithmetic per group is therefore 128 squares, 46 through 50 other tree products, and ten aggregate-unit products, all modulo the actual M. X and the aggregate inverse each have at most 90n bits for n candidates, before any tighter size bound. Multiplication inputs/results and reductions must be priced at that size. The scalar receipt verifies the exponent-tree schedule; this general product acceptance is a paper lemma, not an implementation.

A producer can generate individual roots x_j=a_j^k_j, then CRT-lift them to X. That preparation is not an acceptance premise, but its cost is real. Successful prime candidates in our disjoint windows are distinct, allowing ordinary CRT. A generic batch with repetitions must deduplicate or construct compatible roots modulo the full prime powers; merely CRT-lifting modulo distinct primes is insufficient for the repeated product. The acceptance theorem itself remains sound with repeated factors whenever its stronger product congruences actually pass.

The direct common-root Proth comparator is especially simple: with F=2^45, a supplied X satisfying X^(2^44)=-1 modulo M costs 44 product-modulus squares, and the existing Spec.lean:38 criterion proves each bounded odd factor prime. It needs neither k progression nor a unit witness. The smooth portfolio has a visibly heavier common-root test at equal group size. Its proposed advantage is more geometric candidates and avoidance of large-factor discovery, not cheaper successful-prime verification than this Proth comparator. Whether that outweighs root generation, failed searches, CRT, the extra inverse witness and proof infrastructure remains unmeasured.

## Alternative batching with actual k jumps

For selected candidates using the same F and base, form M=product p_j. Compute U_1=a^k_1 modulo M and advance

    U_(j+1)=U_j*a^(k_(j+1)-k_j) modulo M.

Use actual k jumps, not an old fixed S*i invariant. A jump table can share powers of a for repeated jumps. Reduce U_j to p_j and run the fixed small-modulus complement tree there. Every p_j divides M; pairwise coprimality is unnecessary for this direction of reduction. The correct actual product object and each factor membership must be checked.

An alternative precomputes a^(F/q) modulo M and advances eleven exponent sequences indexed by k. That may amortize fixed exponent work, but pays eleven wide updates/reductions instead of one wide update plus the small-modulus tree. A common CRT-selected base can group candidates more broadly, but its actual congruences must be verified; the CRT construction is a producer hint, not acceptance evidence. Different F groups have different k scales and cannot share an unproved common progression.

All proposed schedules retain exact slot identity and interval membership. Reordering by F/base must come with a checked partition, including general fallbacks and the last batch. In the primary supplied-root format the certificate needs the selected F tag, exact candidate list/product, X, and aggregate inverse; a base and its search history are unnecessary. Intermediate residues may be witnesses or recomputed through a proved schedule. Unsuccessful portfolio candidates need not be recorded, but producer accounting must nevertheless include them.

## End-to-end comparison and stop conditions

The three relevant paths are:

1. Multi-base Proth: cheapest elementary fixed-factor test, but fewer geometric candidates in these same windows. Failed bases on a prime may be repaired by another base; an empty prime lattice cannot.
2. Smooth portfolio: no large-factor discovery, eleven reusable small-prime facts, and the explicit exponent tree above. It adds search lists, collision deduplication, base attempts, modular tests and a new checker theorem.
3. Arbitrary prime fallback: widest search set, with partial Pocklington or another complete primality certificate; factor discovery and certificate DAG dependencies remain producer and checker costs.

Stop a portfolio search according to a declared work budget and fall back; do not accept a missing rung. Failure statistics must separate exhausted candidate sets, composite candidates rejected cheaply, successful prime candidates lacking a found common base, and expensive certificate failures. A proper comparison holds physical windows and completed coverage fixed, and records failed-search work, candidate deduplication, actual F/base groups, factor setup, proof construction, serialization, elaboration, kernel checking and memory separately.

This can reduce dependence on arbitrary factorization, but no rate of such reduction is established. The billion/trillion rung counts in the table remain. At B=10^15 there are two trillion required windows in this particular fixed geometry even though each has at least 52 portfolio lattice integers. No native modular-arithmetic count is automatically a Lean reduction count or ordinary MM0 proof-check count. The theorem-level improvement is a sound additional certificate branch with explicit geometry and arithmetic sharing; its end-to-end benefit still needs matched measurements and actual prime successes.

## Frozen inputs and exact-only receipt

SHA256:

- smooth_factor_ladder_geometry_20261111.py: BF15FD32B8B933DD463159810F84248CCC2DEFF2211F1F285E832DE3DF6B2B01
- smooth_factor_ladder_geometry_20261111.json: 122AD820955BC6753C3DFB5550D3451693848410A295A2EC8B47D61499C72655
- work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean: 0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F
- work/mm0-efficient/primality.md: 003B53ABCC7C40D98B85C0735546220A55EFFBA27FCF7A7D0B09B1CCD68C226A
- work/qrh-blueprint/MULTIBASE_PROTH_RESEARCH_2026-11-11.md: 555DA959A4591205291DB862E1FE1FBA885545C4E3EC920D2FDF48F8A200D337
- independent-feasibility/EFFICIENCY_MIXED_LADDER_2026-11-11.md: 9AACAF7FC0B5DCD9145AB3006D40248A2C7D57319677C57600890D21E5F75783

The exact-only script exited 0. It performs no candidate primality evaluation or modular-power tests; its bounded trial division concerns only the fixed eleven factor primes. All prior artifacts remain unchanged.
