# Direct-order certificates for unrestricted binary anchors

2026-11-11. Mathematical certificate and operation model only. No anchor primes were searched for or evaluated, no new prime certificates were produced, and no Lean/MM0 build was run. The proposal changes the witnesses supplied for an arbitrary anchor; it does not require anchors to share a residue class or a common factored part.

## 1. The acceptance theorem

For an odd integer n>2, provide distinct already certified primes q_i and positive exponents e_i. Form

    F=product_i q_i^e_i,     F^2>n.

The intended producer uses F dividing n-1 and supplies the exact cofactor R=(n-1)/F. Keep this factorization check in the proposed input format. It is useful provenance and bounds F<=n-1, although the following direct-order soundness argument itself does not need F|n-1 once its order tests pass.

One direct witness x is accepted if

    x^F = 1 mod n,
    (x^(F/q_i)-1)*v_i = 1 mod n  for each i.         (1)

All residues are canonical bounded integers; modular products, exponents and inverse identities are actually checked. The second condition is a unit test, not merely inequality to one modulo n.

Proof: take any prime ell dividing n. Reduction of (1) modulo ell gives a nonzero x whose order d divides F. For each q_i, d does not divide F/q_i, because its corresponding inverse identity excludes x^(F/q_i)=1 modulo ell. Therefore the q_i-adic exponent of d is e_i, so d=F. The finite-field group theorem gives F|ell-1 and hence ell>=F+1>sqrt(n). If n were composite its least prime divisor would be at most sqrt(n), a contradiction. This works for repeated prime factors of n as well; squarefreeness of n is not assumed.

The verifier never needs to see or check a precursor base a with x=a^((n-1)/F). That relation is one way for an untrusted producer to find x; the direct tests alone imply primality. Omitting its verification saves real arithmetic only if the new direct tests and any additional factor proofs are cheaper than the old tests. The producer's own exponentiation still counts in end-to-end work.

### A necessary warning about the old full-Lucas adapter

`work/formal-goldbach-bench/prime-cert/PrimeSupport.lean` proves `lucasNat` with the full exponent n-1 and non-equality tests for **every prime divisor of n-1**. One cannot replace n-1 by a partial F and keep only those non-equalities. The integer counterexample is n=561, F=40|560, x=2:

    2^40=1 mod561, 2^20=67 mod561, 2^8=256 mod561,
    561=3*187, F^2>561.

The two proper-power residues are not one modulo561, but gcd(66,561)=33 and gcd(255,561)=51. Unit tests reject this composite. This is an exact arithmetic counterexample to a weakened rule, not a new prime experiment. A direct-order implementation needs its own proved partial-order theorem; the old `lucasNat` statement is not that theorem.

## 2. Separate roots for the prime-power components

An often cheaper sufficient format supplies a root x_i for each q_i^e_i. Compute

    y_i=x_i^(q_i^(e_i-1)) mod n,
    y_i^q_i=1 mod n,
    (y_i-1)*v_i=1 mod n.                            (2)

For every prime ell|n, these tests force x_i to have exact order q_i^e_i modulo ell: its q_i^e_i power is one, but its q_i^(e_i-1) power is not. Hence q_i^e_i divides ell-1 for every i. The prime powers are pairwise coprime, so their product F divides ell-1. The same least-factor argument proves n prime. In particular the tests are normalized as written; there is no extra factorial, cofactor exponent, or hidden requirement that e_i=1.

All unit conditions can use one aggregate inverse. Compute z_i=(y_i+n-1) mod n and T=product_i z_i mod n, and check T*v=1 mod n. Then no z_i can vanish modulo any prime divisor ell, so the preceding argument applies. This costs k-1 modular products to form T and one inverse-identity product: k products total, the same count as k separate inverse identities, but only one supplied inverse residue. Empty factor sets are rejected by F^2>n for n>2.

Thus the common-root format needs x plus one aggregate inverse, while the component format needs k roots plus one inverse. Each extra root uses about bitlength(n) bits before framing. Residues need not be stored as full exponentiation traces if the chosen proof system checks the actual modular arithmetic. A supplied intermediate residue is never accepted without its defining power identity.

The source proof pattern exists in target Mathlib: `NumberTheory/Fermat.lean:154–171` reduces a congruence modulo a prime, applies `orderOf_eq_prime_pow`, and then `orderOf_dvd_card_sub_one`; its special case is q=2. `GroupTheory/OrderOfElement.lean:542` supplies the general prime-power order lemma. `Ladder/Spec.lean:39–80` uses the least-prime-factor square contradiction. These are ingredients, not a claim that the new general checker has already been implemented or compiled.

### An often cheaper cyclotomic alternative

For a prime q, let `Phi_q(y)=1+y+...+y^(q-1)`. With y=x^(q^(e-1)), accept instead

    Phi_q(y)=0 mod n,       q does not divide n.     (3)

For any prime ell|n, the polynomial identity `(y-1)Phi_q(y)=y^q-1` proves y^q=1 modulo ell. If y=1 modulo ell, Phi_q(y)=q=0 there, forcing ell=q and contradicting q not dividing n. Thus y has order q, and x has order q^e. This proves the same factor of ell-1 without an inverse witness. Checking F|n-1 makes every q not dividing n immediate, which is a reason to **retain** that inexpensive relation even though the abstract inverse-based criterion does not require it. Alternatively check each n mod q is nonzero; price those divisions and their proof evidence.

For odd q, a generic exact geometric-sum schedule maintains `(P_m,S_m)=(y^m,sum_{j<m} y^j)`. Doubling uses `P_2m=P_m^2` and `S_2m=S_m*(1+P_m)`, two products. An odd extension uses `S_(2m+1)=S_2m+P_2m` and `P_(2m+1)=P_2m*y`, one extra product. Start at m=1 with `(y,1)` and omit the final unused power update. This computes Phi_q in

    2*floor(log2 q)+popcount(q)-2

modular products. The power-plus-one-unit-product method costs `floor(log2 q)+popcount(q)`, after y has been computed. The generic cyclotomic schedule therefore saves one product at q=3, ties at q=5,7, and costs `floor(log2 q)-2` extra products for larger q. It saves an inverse residue and inverse construction if no other component still needs the aggregate inverse. Modular additions, factor-provenance checks and the n mod q test or F-cofactor check remain real costs.

Small explicit polynomials improve this generic count: `Phi_3=y^2+y+1` uses one product; `Phi_5=y^2*(y^2+y+1)+y+1` uses two. Each saves two products against its power-plus-unit schedule. Such identities need a proved polynomial normalization lemma, not a numerical guess. For q=2, Phi_2=y+1 is just a comparison with -1; when e=1 the factor2 in F is already supplied by oddness of every prime divisor of n, so no root or modular check is needed. For e>1, checking x^(2^(e-1))=-1 requires e-1 squarings and proves the full2^e order factor; there is no need for the last squaring or a -2 inverse because n is odd.

A mixed certificate can choose the inverse, cyclotomic or special2 rule per component, with one aggregate inverse over only the components that need it. This is a sound finite menu; the selected rule and its exact acceptance conditions must be checked. For the largest-factor q>sqrt(n) case, geometric doubling remains O(log q), but it can cost almost one additional full squaring ladder compared with the direct power. Whether eliminating the single inverse residue and its generation saves total work depends on the actual arithmetic/payload implementation. There is no blanket preference for cyclotomic checking at large q.

## 3. Count actual exponentiation schedules

For left-to-right binary powering initialized at the base, define

    P(d)=floor(log2 d)+popcount(d)-1, d>=1,
    P(1)=0.

This is exactly the number of squarings plus nonsquare multiplications for that schedule. Include the cost of each modular reduction, operand width and proof evidence; one product is not one MM0 inference.

The component-root check can use either

    P(q_i^(e_i-1))+P(q_i),

or e_i successive q_i-th powers, costing e_i*P(q_i). The first schedule computes y_i and then y_i^q_i; it does not recompute x_i^(q_i^e_i) from scratch. Use the smaller certified schedule or another explicitly proved addition chain. For the first schedule,

    sum_i [P(q_i^(e_i-1))+P(q_i)] <= 2*floor(log2 F).

Indeed P(d)<=2 floor(log2 d), and the sum of the exponent logarithms is log2 F. Add k products for the aggregate unit check, plus factor-product/cofactor/size checks and all factor-primality obligations. This bound is independent of an assumed distribution of bits or factor sizes. For q=2 the exact component cost is e squarings plus its share of the unit check.

A common direct F-root can share its squaring ladder across exponents F and F/q_i. Its arithmetic count is

    floor(log2 F) + [popcount(F)-1]
      + sum_i [popcount(F/q_i)-1] + k,              (4)

with trivial exponent-one outputs handled directly. The original cached partial-Pocklington prototype uses the analogous shared ladder with n-1 and (n-1)/q_i, followed by gcd or inverse tests. It does **not** necessarily perform k+1 independent full exponentiations. Comparing against that exaggerated baseline would overstate the saving.

| Format | Exponents that actually get checked | Prime support needed |
|---|---|---|
| Existing full Lucas/Pratt | n-1 and (n-1)/q for every prime q|n-1 | Complete factorization and all recursive prime proofs |
| Existing cached partial Pocklington | n-1 and (n-1)/q for selected q in F | Selected factors only; no factorization of R required |
| Common direct F-root | F and F/q for selected q | Same selected support as partial Pocklington |
| Component roots | q^(e-1), then q for each selected prime power | Same selected support, more supplied residues |
| One large factor q>sqrt(n) | q, plus unit(x-1) | A genuine prime proof for q |
| Cyclotomic component | q^(e-1), then Phi_q | Same selected support, plus q not dividing n; no inverse for that component |

The component construction removes the potential k*log F exponent-selection cost in favor of a bound of roughly2 log F products, but uses more witness data and may require more producer work. A grouped-root compromise is being analyzed separately by major-constants; its soundness must use the group's lcm/product order conditions and its actual schedule. No grouped implementation is assumed here.

For planned anchors n<=6e17<2^60, F<=n-1 gives at most118 products for the component powers. The crude distinct-factor bound k<=18 follows from F>=product_{j=1}^k(j+1)=(k+1)! and20!>6e17. Thus136 is a conservative bound for powers plus aggregate unit products at one node. It excludes factor construction, scalar checks, modular/proof overhead, lookup and recursive nodes. It is not a throughput estimate or an assertion that all inputs attain this bound.

## 4. The largest-prime-factor case

If the producer finds a certified q|n-1 with q^2>n, choose F=q. The acceptance input needs only x and one inverse v with x^q=1 and (x-1)v=1 modulo n. The unproved cofactor R need not be factored. The power uses the bits of q rather than the bits of n-1. There is no requirement that different anchors have the same q.

The size of q matters. If q is just above sqrt(n), its bit length is near half the anchor's. If q is close to(n-1)/2, the exponent length is nearly the full anchor length and the saving can be small. More importantly, q itself may require a large recursive certificate. Selecting the largest factor is not necessarily the lowest complete-cost choice: a slightly larger product of already cached small factors can avoid that chain.

For n<=6e17 and the L=2^32 source limit U=8590983167, a large factor lying in (sqrt(n),U] has at most34 bits. Its direct power and unit check cost at most67 modular products. A coarse worst-case bound for the old one-selected-factor shared full-exponent schedule is148 products including its inverse check: at most59 squarings,59 accumulator products for n-1,29 for(n-1)/q<sqrt(n), and one unit product. These are two upper bounds, not a proved factor-of-148/67 speedup on any actual anchor. A very sparse exponent or a larger q changes the exact comparison.

Conditional expected witness search is also explicit. If n is prime and a is uniform in its nonzero residues, x=a^((n-1)/q^e) is uniform in the subgroup of order q^e. It has that exact order with probability1-1/q; independent per-component searches therefore have expected q/(q-1)<=2 trials each. A common F-root succeeds with probability product_{q|F}(1-1/q). These statements use cyclicity of the prime field and concern already-prime n; they do not predict how often searched anchor candidates are prime, how difficult factorization is, or how many failed candidates production encounters.

Producing roots independently may cost k large powers with exponents(n-1)/q^e. Alternatively, after obtaining one common F-root x=a^((n-1)/F), derive component roots x^(F/q^e), potentially sharing a complement-product/exponentiation tree. That still costs arithmetic. The producer-generation and CRT/payload analysis is assigned separately to prime-estimates; do not delete those costs because the verifier does not check the precursor relation.

## 5. Source prime facts and remaining chains

The binary source range for block length L is

    U=2(L+D)-1, D=2^19.

A set bit proves primality of its corresponding odd number. It does not make every integer<=U prime, nor does a subset-sound bitmap prove that every prime<=U is present. To use q from that source, the checker must obtain a positive bit with its actual index and retained prime-soundness theorem. Prime2 is a separate base fact. If a source chunk was discarded, retain a checked factor-prime handle, use an indexed immutable proof, provide a separate factor certificate, or charge a new source pass. A cached number or hash is not enough.

There is nevertheless a useful structural bound when U^2>=B. At any odd node n<=B, n-1 has at most one prime factor greater than U; two such factors would have product>U^2>=n. If such a factor q is found, q>sqrt(n), so q alone suffices as F. Also q<=(n-1)/2 because n-1 is even and q is an odd divisor. Therefore, **provided every needed smaller factor has an available genuine cache/source proof**, the unresolved above-U support can be chosen as a single chain per root, shrinking by at least a factor two at each step. It terminates at a cached prime or at a node whose sufficient factored part is composed entirely of cached primes.

The number of above-U nodes on a chain is at most ceil(log2(B/U)) when B>U; for B<=U it is zero only if the root's positive source/cache proof is actually available. Distinct roots can share chain nodes through an acyclic certificate DAG, but no amount of sharing is assumed. Missing small-factor cache entries require their own proofs and destroy the claimed *available-support* chain simplification until supplied.

For B<=6e17, the source limits at L=2^32,2^34,2^36 all exceed sqrt(B). The conservative maximum chain-node counts are respectively27,25,23. Increasing L sixteenfold therefore reduces this worst-case chain bound by only four nodes while increasing source storage/proof work. This is not the expected chain distribution; it is enough to reject the claim that a larger source makes every large factor free. Actual saved support proofs, source cost and reduced outer-block count decide the L tradeoff.

Select F to minimize marginal complete work against the **currently retained** certificate DAG, subject to F^2>n, rather than optimizing factor count alone. Each selected prime-power item has exponent-check cost, witness bytes and an incremental factor-prime proof cost. Exact products determine feasibility; no logarithmic rounding may certify F^2>n. Shared DAG costs make this a cache-dependent optimization. A bounded heuristic with a full-checking fallback is sufficient for soundness, but all unsuccessful factor/search work remains in generation cost.

## 6. What the old55 ms benchmark does and does not price

The earlier Lean report measured55.078 ms CPU per anchor for a32-root full Lucas/Pratt cohort, including250 prime nodes and1105 auxiliary declarations. It explicitly did not implement partial-factor Pocklington, these direct roots, or an optimized alternative evaluator. It is neither a lower bound nor a measurement of (1) or (2). A new source-cache policy can also change the recursively required closure. Do not divide55 ms by an operation-count ratio or by7.81 nodes/root and call that the new rate.

The native cached partial-Pocklington prototype already shares squarings and already has an inverse-witness variant. Its microsecond rates are not stock Lean/MM0 rates. A fair comparison must implement the new mathematical rule, check its full factor-provenance closure and actual modular arithmetic, and report generation, elaboration/emission, independent checking, bytes and import costs separately. A specialized arithmetic backend needs its own sound execution path; no new trusted native rule is assumed.

For a complete campaign at B,L, replace the anchor term in the prior joint frontier by

    sum distinct anchor/support nodes [factor discovery + witness generation
      + certified modular schedule + prime-fact lookup + parser/assembly]
      + source/factor-cache establishment and persistence not charged elsewhere.

Faster anchor checks can make smaller L competitive because the saving from reducing the number of anchors becomes less important relative to source proof cost. Conversely, an expensive unresolved factor chain can favor a larger cache or a different F. Coverage masks need not change when only the certificate representation changes; this is the principal advantage over restricting anchors to smooth residue classes. If the producer changes which primes it selects to obtain cheaper certificates, the altered coverage/residual costs must be measured too.

## 7. Minimal next comparison and proof obligations

After separate authorization, use the same small immutable anchor cohort and prime-factor evidence to compare full Lucas, cached partial Pocklington, common direct roots, and component/grouped roots. Include one large-factor cache hit, one unresolved large-factor chain, and one multi-factor case. Count actual exponent schedules and all auxiliary declarations rather than only named root bodies. Preserve the producer's costs for roots and factorization and the verifier's exact prime handles. No new anchor search is necessary to test certificate format on an existing cohort, but the proposed task here has not executed even that test.

Required generic proof: the direct-order rule, the component/aggregate-inverse and cyclotomic variants, a bounded parser and acyclic provenance invariant, modular arithmetic correctness in the chosen acceptance implementation, and complete root-list consumption. Negative cases must include the weakened non-equality counterexample, a composite/missing factor handle, a wrong aggregate inverse, a missing prime-power component, a cyclotomic test without the required q-not-dividing-n condition, insufficient F and an evicted-source lookup. No finite benchmark establishes the expected factor distribution or a global runtime bound.

Evidence read: `work/mm0-efficient/primality.md`; `work/formal-goldbach-bench/prime-cert/REPORT.md` and `PrimeSupport.lean`; target Mathlib `NumberTheory/Fermat.lean` and `GroupTheory/OrderOfElement.lean`; `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean`. The companion integer-only size script binds these files and checks the source-size/chain bounds. It performs no prime search or primality-certificate evaluation.
