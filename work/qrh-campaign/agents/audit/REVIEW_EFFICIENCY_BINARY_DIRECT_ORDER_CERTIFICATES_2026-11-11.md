# Independent review of binary direct-order certificates

2026-11-11. Verdict: **PASS at paper soundness, source-interface and operation-model scope.** No correction is required to `moebius/EFFICIENCY_BINARY_DIRECT_ORDER_CERTIFICATES_2026-11-11.md`, SHA256 `98DE51CD347FE90B51E70F946E1A5AAD8FF367C26CFF933EEC5E6A655E3AF959`.

I read the full note, its integer size script and receipt, and the cited order/Lucas source bodies. All six source pins in the receipt match current files. The script is `C858EE842A45CF5541BEF38B7EE296996522C66B2B0E8931A8933E4648DE6644`; receipt `881CC9D1E195774F3C8B8DB86183F668DE74ABA292362A0D6044046659D1A544`. I did not execute the author script or evaluate prime candidates or modular certificates. No builds, Lean edits or analytic evaluations occurred.

## Cyclotomic acceptance and the exceptional characteristic

For a certified prime q and e>=1, put y=x^(q^(e-1)). The exact polynomial identity

`(y-1)*(1+y+...+y^(q-1))=y^q-1`

shows that Phi_q(y)=0 modulo n implies y^q=1 modulo each prime divisor ell of n. If y=1 modulo ell, the same sum is q modulo ell, so ell=q. The retained condition q does not divide n excludes precisely this case. Thus y has order q and x has order q^e. Different components supply pairwise coprime prime powers dividing ell-1; their product F does too. The strict size condition excludes a composite n by its least prime factor.

The q-divisor exclusion is necessary for this isolated rule, even when F^2>n. A concrete integer counterexample is n=57=3*19, q=3, e=2, F=9, x=4. Then y=7 modulo 57, and Phi_3(y)=49+7+1=57, while F^2=81>57. The frozen rule rejects it because 3 divides 57. These equalities are a short algebraic counterexample, not an evaluation campaign.

Checking F divides n-1 and q divides F gives q not dividing n immediately. Alternatively the individual nondivisibility checks suffice. A different collective theorem can sometimes derive these exclusions from all component tests together, but no such theorem is silently consumed here. The factorization/cofactor relation also bounds each recursive factor below its parent and provides a useful well-founded dependency order.

The inverse-based rule does not require F divides n-1 mathematically. Its unit tests exclude equality separately modulo every prime divisor, rather than merely modulo n. The warning about the full-Lucas adapter is correct: `PrimeSupport.lean:4–13` quantifies over every prime divisor of n-1, so it cannot certify a partial-F rule with only non-equalities. The displayed 561 counterexample is consistent with that distinction.

## Prime-power normalization and special cases

The exponent q^(e-1) is essential. The checked q-th power of y makes x a unit and its order divide q^e; y not equal to 1 forces the order not to divide q^(e-1). No coprimality between F and the leftover cofactor is needed. Repeated factors of n do not evade the least-factor argument.

For q=2, the negative-one test supplies its own unit condition only because n is odd. The free factor-two case applies at e=1; for e>1 the required e-1 squarings cannot be omitted. A mixed rule menu must record which rule certifies each full prime-power component. Aggregate inversion applies only to components using inverse conditions. If none do, there is no inverse witness or product to charge.

The relevant actual source ingredients are `Mathlib/NumberTheory/Fermat.lean:154–171`, SHA256 `6A20F4E26D0345801E5CD7286CCA8A0A05130FFEAD8BDF4F501D09A2B4FD97A5`, and `Mathlib/GroupTheory/OrderOfElement.lean:542`, SHA256 `7917220EA246CE1405ED904BB0259F9134C8BD6DAD1008357EAD794221BBFAA9`. Their order reasoning agrees with the proposed generalization. They do not themselves implement the new partial-order parser or checker. The existing source power-of-two least-factor argument remains a special case.

## Operation counts

For an odd q with binary length l+1 and h set bits, the geometric-sum recurrence uses two products per remaining digit and one additional product per nonleading set bit. Omitting the final unused power update gives exactly 2l+h-2. The power-plus-unit schedule uses l+h. Their difference is l-2, agreeing with the stated generic comparison. The special Phi_3 and Phi_5 polynomial identities use one and two products respectively; their expansions are exact. Additions, reductions, q-exclusion and proof evidence are excluded from those product counts, as the note states.

The component-power bound also checks: each binary power costs at most twice the floor of its exponent's logarithm. Summing the two exponent logarithms per component gives log2 F. Hence the total is at most 2 floor(log2 F). Under F<=n-1<2^60 this is 118. Distinct factors and (k+1)!<=F, together with 20!>6*10^17, give the conservative k<=18 and total 136 including unit products. These are single-node arithmetic bounds, not complete-certificate costs.

For the cached large-factor example, the 34-bit factor bound gives at most 67 products including its unit check. The comparison 148 is a separate upper bound on the old shared full-exponent schedule, not a measured ratio or lower bound on old work. The report correctly avoids exaggerating the old implementation as independent full exponentiation for every leaf.

## Cache support and recursive completeness

With U^2>=B and n<=B, two factors greater than U, even two copies of one such factor, cannot divide n-1. Any available factor q>U therefore exceeds sqrt(n) and alone suffices as F. Since n is odd and q is odd, q<=(n-1)/2. Recursing only on this unresolved large factor gives at most ceil(log2(B/U)) above-U nodes. The three source sizes and 27, 25, 23 upper counts agree with the integer inequalities encoded in the size script.

This is not a bound on all proof work unless the smaller selected factors really have retained certified support. A source bit must be positive at its exact indexed number and carry the source soundness theorem. A number below U, a discarded chunk, a cache identifier or a hash is not a prime proof. A missing small factor can introduce additional dependencies, and a root below U still needs an actual cache/source proof. The final note states these qualifications. Any shared proof DAG must be acyclic and consume every selected factor's prime proof; prospective factor discovery does not provide such evidence.

The conditional expected trial count is correctly restricted to an already-prime n and uniform independent nonzero residues. It is not a candidate-prime success rate, factorization estimate or guarantee about a finite small-base search. The old 55.078 ms measurement belongs to its recorded 32-root full-Lucas closure, including 250 prime nodes and 1105 auxiliaries. It cannot price this new rule by division or an operation-count ratio.

The accepted conclusion is a sound alternative certificate format for unrestricted anchors, with explicit local arithmetic tradeoffs. Complete source/cache establishment, factor and root generation, all failed work, modular proof implementation, parser/DAG checks and actual coverage remain required. No completed binary proof, final-premise change or end-to-end speedup is established.
