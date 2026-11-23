# Sum-only cyclotomic certificates

2026-11-11. New author derivation and exact polynomial/schedule arithmetic. Two researchers independently confirmed the recurrence and its generic order consequence in messages. A frozen independent review of this complete packet is still required. No modular value, prime candidate, Lean/MM0 build or computational certificate was evaluated.

## Removing an unused power output

Write S_n(y)=sum of y^j for 0<=j<n. The earlier cyclotomic schedule maintained both y^n and S_n(y). Acceptance only needs the sum. The exact identities

    S_(2m)(y)   = (1+y) S_m(y²),
    S_(2m+1)(y) = 1+(y+y²) S_m(y²)

give a cheaper recursive circuit. The first groups exponents into even/odd pairs. The second includes exponent zero and pairs exponents 2j+1 and 2j+2. Both are polynomial identities over the natural numbers and hence hold in any commutative ring and modulo any positive modulus.

Use the explicit base cases S_1=1, S_2=1+y and S_3=1+y+y². At n>=4, compute t=y² once, recursively compute S_floor(n/2)(t), and multiply it by 1+y or y+t. In the odd case add one. Every such step takes one square and one other product. The coefficient y+t reuses the square; computing y*(1+y) separately would lose the saving.

For n>=2 put l=floor(log2 n), and let epsilon be one when the leading two binary digits are 11, otherwise zero. There are l-1 recursive steps before base case 2 or 3. The resulting counts are

    squares = l-1+epsilon,
    other products = l-1,
    total = 2(l-1)+epsilon.

At n=1 the count is zero. These are circuit upper bounds, not minimal addition-chain theorems. Each recursive step also uses one addition when even and two when odd. Base cases 2 and 3 use one and two additions. Modular normalization, comparisons and proof dispatch are separate costs.

| Prime q | Sum-only squares | Other products | Total | Earlier generic sum circuit | Binary q-power plus unit product |
|---:|---:|---:|---:|---:|---:|
| 3 | 1 | 0 | 1 | 2 | 3 |
| 5 | 1 | 1 | 2 | 4 | 4 |
| 7 | 2 | 1 | 3 | 5 | 5 |
| 11 | 2 | 2 | 4 | 7 | 6 |
| 13 | 3 | 2 | 5 | 7 | 6 |
| 17 | 3 | 3 | 6 | 8 | 6 |
| 19 | 3 | 3 | 6 | 9 | 7 |
| 23 | 3 | 3 | 6 | 10 | 8 |
| 29 | 4 | 3 | 7 | 10 | 8 |
| 31 | 4 | 3 | 7 | 11 | 9 |

The earlier special formulas already attained the first two sum-only totals. The improvement extends a single recurrence to all the other primes. For large primes with few set bits, the power-plus-unit method can still be cheaper. Keep both sound branches rather than assuming cyclotomic checking always wins.

## The acceptance theorem retains its guards

Let n>1 be odd, q a certified prime, e>=1, and y=x^(q^(e-1)) modulo n. Require S_q(y)=0 modulo n and q not dividing n. For every prime r dividing n, the geometric-sum identity gives y^q=1 modulo r. If y=1 modulo r, then S_q(y)=q modulo r, forcing r=q, contrary to the nondivisibility guard. Hence y has order exactly q. The order of x is therefore exactly q^e: it divides q^e, but does not divide q^(e-1).

Apply this to distinct certified primes and their full prime powers. Their product F divides r-1 for every prime r dividing n. The bound n<(F+1)^2 excludes a composite n by its least prime factor. The current portfolio uses the stronger n<F². Repeated prime factors of n do not evade this argument.

For q=2, oddness provides the factor 2 when e=1 without a root. For e>1 check x^(2^(e-1))=-1, using e-1 squares. This supplies the full power of two. It cannot be replaced by parity alone.

The q-not-dividing-n condition is essential. The previously reviewed example n=57, q=3, e=2, x=4 passes the isolated sum test and size bound while composite, but fails that guard. Keeping F dividing n-1 makes the guard automatic for all selected q. Alternatively check the individual nondivisibilities. Neither option is free proof work.

Whole-product acceptance is sound as well. Bind M to the exact product of the claimed bounded odd candidates. Check all component congruences modulo M, and establish that every selected q does not divide M. For a homogeneous-F batch whose candidates satisfy F dividing n-1, this follows from those candidate equalities. Congruences descend to every candidate and its prime divisors. Each component now needs its own supplied root but no inverse witness. Ordinary producer CRT still requires distinct candidates or appropriate prime-power lifts; this recurrence does not change that requirement.

## The six smooth-factor formats

Use the reviewed F=m*primorial(31), m in {160,162,165,168,175,180}. For odd q with exponent e, the receipt uses leading-one binary powering to form x^(q^(e-1)), then the sum-only circuit. The prepower is not omitted. For q=2 it uses the negative-one rule above. At e=1 it omits the parity root. All six rows require 52 sum-circuit additions, beyond the displayed products, plus reductions and guards.

| m | Supplied roots | Inverse fields | Squares | Other products | Total products |
|---:|---:|---:|---:|---:|---:|
| 160 | 11 | 0 | 33 | 22 | 55 |
| 162 | 11 | 0 | 33 | 23 | 56 |
| 165 | 10 | 0 | 32 | 25 | 57 |
| 168 | 11 | 0 | 32 | 24 | 56 |
| 175 | 10 | 0 | 32 | 25 | 57 |
| 180 | 11 | 0 | 33 | 23 | 56 |

These totals are below the earlier reviewed ten-root-plus-inverse schedules, whose equal-weight totals were 70,71,72,71,72,71. For m=160 the old schedule had 38 squares and 32 other products including units; the new schedule has 33 and 22. Both allocate eleven full-width witness coordinates, though one contains ten roots and an inverse and the other eleven roots. At m=165 and175 the new schedule uses ten coordinates instead of eleven. The new circuit does not prove overall cost dominance: additions, nondivisibility checks, root-generation work and exact arithmetic proof costs differ.

A useful conditional comparison for m=160 at a fixed modulus width is the saving of five modular squares and ten modular products, weighed against the extra addition/normalization and guard cost and the change in production. Fifty-two additions are a conservative upper charge for the new sum portion; the old circuit's subtractions and guards should also be accounted for before computing a net difference. No conversion from these counts to seconds is made.

Repeated q-power prepower chains can change the square/product balance. For example, q=3,e=5 permits four repeated cube operations instead of binary powering to 81. Both use eight products in total but have different square counts. The table deliberately fixes one schedule. A weighted optimizer may retain both, with exact exponent proofs.

The 44-square Proth branch remains a distinct, cheaper-count alternative with one root coordinate. The smooth portfolio's purpose is more search candidates and less general factorization; this new schedule improves its successful-certificate cost without proving its prime availability or net advantage. For unrestricted binary anchors, the same recurrence is an additional choice for each factored component, with all recursive prime-factor proofs retained.

## Production, formalization and evidence

The producer still finds roots of the required prime-power orders. On actual primes, the previous component-root construction supplies such witnesses, but failed trials, projection powers and CRT cost remain. Removing the inverse witness avoids its generation and serialization only for an all-cyclotomic packet. A mixed packet with inverse-based components still needs its aggregate inverse.

The generic formal proof needs the two polynomial recurrences, modular-circuit soundness, the prime-order/cyclotomic implication with its nondivisibility guard, factor/product binding and the least-factor argument. Concrete checking must use bounded modular recursion. It need not normalize literal ordinary powers or construct all coefficients of a degree-q polynomial. The scalar script expands only the small fixed symbolic polynomials as an independent identity check; that is not the proposed verifier.

The companion `cyclotomic_sum_only_schedules_20261111.py` verifies coefficient identities for the ten fixed odd primes, derives exact schedule counts and reconstructs all six factorizations and size inequalities. It uses no candidate primality test or modular power. The receipt `cyclotomic_sum_only_schedules_20261111.json` has SHA256 `F30C91250F8210F8FB0600757028C5C3CB629F0EC0144E6AE5AD66D6B582EE14` and binds the prior author/review sources. All prior reports remain unchanged.

DRAFT_ANCHORS: 0 created
UNREGISTERED_SORRIES: 0 introduced
DRAFT_IMPORT_VIOLATIONS: 0 introduced
SEALED_THIS_TURN: 0
