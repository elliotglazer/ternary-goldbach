# Retaining prime-power roots during ladder generation

2026-11-11. A bounded extension of the frozen heuristic portfolio note, which remains unchanged. This note separates exact finite-group sampling calculations from heuristic prime availability and unknown arithmetic costs. No candidate, prime, modular root, CRT value, or analytic function was evaluated. No Lean/MM0 code or declaration was added.

The concrete new option is to retain successful full prime-power components and retry only missing components. This can shorten root-completion searches without increasing the final number of supplied root coordinates: completed components may be multiplied into one root or any coarser checker partition. Generation partition and checker partition should therefore be optimized separately.

## Exact construction and acceptance distinction

Write F=product q^e with distinct prime q, and let a candidate n=kF+1 satisfy the existing strict size bound. For production, form

    u_q = a^((n-1)/q^e) mod n.

The quotient is exact because q^e divides F. A valid retained component is accompanied by the actual modular conditions

    u_q^(q^e)=1 mod n,
    gcd(u_q^(q^(e-1))-1,n)=1.

For q=2 the stronger convenient condition u_2^(2^(e-1))=-1 mod n supplies both conditions when n is odd. When e=1, u_2=-1 is a literal valid component for every odd candidate; no search, supplied coordinate or power evaluation is needed for that component alone.

These checks are valid before n is known to be prime. A nonzero residue is insufficient: for a composite modulus, the leaf-minus-one value must be a unit. On a true prime, nonzero and unit coincide, which is why the sampling calculation below uses the simpler nontriviality event. A probable-prime screen is not a proof of that equivalence for an arbitrary candidate.

Every prime divisor ell of n sees u_q of exact order q^e. If all components are obtained, F divides ell-1. The same least-prime-factor argument used by the accepted order-root designs proves n prime from its strict square bound. Partial completion can occur for composites and is not evidence of primality. An unsuccessful search leaves an incomplete record.

If the producer starts with z=a^k, the full component is z^(F/q^e). The old common-root leaf z^(F/q) generally has only order q. When e>1 it cannot replace the full q^e component. Producing and retaining the latter projection has a separate exponent schedule and cost.

Completed components commute and have pairwise coprime orders in every prime residue field. Their product over a group G therefore has order d_G=product_{q in G}q^e in each field. At the full modulus the component power identities also imply the group power identity. Thus the producer may multiply components into a common F root or any selected group roots. This argument does not require guessing a common original base. It also justifies the grouped unit predicates for those roots.

The final checker still verifies its selected root powers, exact candidate product/bounds, aggregate unit inverse and coverage. It need not verify the producer's search or component construction. Retention improves an untrusted producer schedule; it does not weaken acceptance.

Coarsening changes unit residues. An inverse of u_q^(q^(e-1))-1 is generally not an inverse of the new group leaf-minus-one value. The producer must recompute the selected group's unit residues and obtain the actual aggregate inverse, or provide a separately costed algebraic transformation. For the unchanged atomic checker, retained individual inverse witnesses can be multiplied to obtain its aggregate inverse. Neither case makes inverse production or its final checked identity free.

## Conditional sampling facts

Now condition explicitly on n=p being prime. Suppose each fresh a is sampled independently and uniformly from the nonzero residues modulo p. This is a declared randomized producer policy, not a claim about a fixed list of small bases. Sampling/rejection and random-bit costs remain outside the modular counts below.

The cyclic group of order p-1 shows that a^((p-1)/q^e) has full order q^e with exact probability 1-1/q. Extra q factors in k do not change this proportion. Events for distinct prime-power components of a are independent. The same facts hold if a^k is shared first and then projected.

For the eleven primes through 31 define

    R = product q/(q-1) = 86822723/13271040.

Discarding every trial unless all components succeed at once gives mean R, about 6.54227, fresh whole-root trials. Retaining successes changes the process. If all unresolved components are tried using each new common a, the completion time T is the maximum of independent geometric component times, with

    P(T>t)=1-product_q(1-q^(-t)),
    E[T]=sum_{t>=0} P(T>t),
    E[total component evaluations]=sum_q q/(q-1).

The exact rational calculation bounds E[T] between 2.548496836356 and 2.548496836357. The mean component evaluation count is 739157/55440, about 13.33256. This is fewer fresh-base rounds but more individually identified component operations than one whole-root test. It is not a timing ratio.

For the ten odd primes alone, the mean completion rounds are between 1.948958799386 and 1.948958799387, and the mean component evaluations are 628277/55440, about 11.33256. This case applies directly when the 2-part of F is exactly 2. It also describes the modular rounds after guaranteeing the 2-component with a first base sampled uniformly conditional on being a quadratic nonresidue. The odd components of that first base retain their uniform distribution. Subsequent fresh bases need no quadratic condition once the 2-component has been stored. Obtaining a uniformly conditioned first base costs, on average, two raw uniform draws; its Jacobi/filter work must be counted.

For comparison, conditioning every whole-root trial on the quadratic condition gives mean R/2, about 3.27113, expensive whole-root trials. This is a stronger common-root baseline than unconditionally retrying all components. A small-base Jacobi lookup may be cheaper than uniform sampling, but it does not inherit these exact frequency statements automatically.

At a cap of 32 fresh rounds, conditional true-prime incompletion probabilities are:

| Schedule | Incompletion after 32 rounds |
|---|---:|
| Fresh whole F root, no retention | about .00495103 |
| Fresh whole odd-part root after quadratic selection | about 8.5001e-6 |
| Retained eleven components | about 2.3284e-10 |
| Retained ten odd components | about 5.3966e-16 |

These are exact-model consequences for true primes and uniform draws. They are not empirical rates, guarantees of termination within the cap, or probabilities that candidates are prime. A capped failure may reject a true prime, and all retained data still require actual checks. A composite cannot complete the full valid component set under the size guard, so it may consume the entire cap; this cost belongs in the generation model.

The arithmetic script bounds each infinite expectation by a finite 256-term sum and a geometric union-tail bound. It calls no probability/transcendental evaluator. Exact finite-field counting proves the input probabilities; implementing the chosen random sampling policy is a separate producer task.

## Retained groups and the existing checker frontier

For any partition into disjoint groups G, put

    s_G=product_{q in G}(1-1/q), f_G=1-s_G.

Retaining a successful whole group and retrying only missing groups gives mean group evaluations sum_G 1/s_G and

    P(T_groups>t)=1-product_G(1-f_G^t).

The calculation below uses some of the actual m=160 partitions selected by the frozen checker schedule. It assumes the producer uses those same groups only to illustrate the tradeoff; that restriction is unnecessary for the final design.

| Groups/roots | Checker modular operations | Root-plus-inverse coordinates | Mean group evaluations | Mean fresh-base rounds |
|---:|---:|---:|---:|---:|
| 1 | 184 | 2 | 6.54227 | 6.54227 |
| 2 | 130 | 3 | 5.12243 | 3.53544 |
| 4 | 92 | 5 | 6.70850 | 3.03766 |
| 6 | 81 | 7 | 8.41682 | 2.65821 |
| 10 | 70 | 11 | 12.36590 | 2.59460 |
| 11 | 70 | 12 | 13.33256 | 2.54850 |

The last row remains dominated in the check-operation/coordinate projection by ten roots, but it can be a useful internal generation decomposition. Its atomic components can be coarsened into the ten-root, four-root or one-root output. Component evaluation costs differ by group size; the fourth column is not an arithmetic-work count. The published DP optimizes a stated equal-weight schedule family, not these expected generator costs or total proof cost.

For m=165 and 175 the 2-part is exactly 2, so the free literal -1 component should be removed from generation and payload. The remaining ten prime-power groups still have their actual exponents and projection costs. Do not charge eleven independent root searches uniformly across all six F choices.

## An explicit producer work model

At a true prime, a shared-round producer can do the following:

1. Draw one fresh unit a and compute z=a^k.
2. Project z only to unresolved full prime-power components or groups.
3. Test their actual powers and unit conditions; retain successful roots and needed local data.
4. At completion, compose the desired checking groups, compute their actual aggregate inverse, then CRT the selected coordinates across candidate primes if using a product batch.

Let C_k be the cost of z=a^k; let C_proj(U) price a valid projection schedule for the currently unresolved set U; let C_test,q price the component power and unit tests. For atomic retention, a useful decomposition is

    E[T] C_k
      + sum_{t>=0} sum_{nonempty U} P(U_t=U) C_proj(U)
      + sum_q [q/(q-1)] C_test,q
      + composition + aggregate inverse + CRT.

Here

    P(U_t=U)=product_{q in U}q^(-t)
                * product_{q notin U}(1-q^(-t)).

All costs must include their actual operand widths and reductions. A full projection tree on every round is one upper schedule; independent binary projection only for missing components is another. A producer may choose a cheaper verified exponent identity for the actual subset. No correctness assumption about its optimization enters the final checker.

For m=160, the simple independent-projection schedule from shared z has expected 537.28565 squares and 252.61278 other products. Performing the full component power tests on every attempted component adds 46.31357 squares and 24.25046 other products, before unit computations. Thus projections plus power tests cost expected

    147067/252 squares,
    15349297/55440 other products,

or about 583.60 and 276.87. Add E[T] copies of C_k, at most 44 squares and 44 other products each under the existing k<2^45 bound, plus units and composition. This is a concrete upper schedule, not a minimized one. Early rejection and shared projection trees may lower it.

In comparison, unconditionally repeating the full m=160 common-root schedule would cost at most R copies of 172 squares and 100 other products, about 1125.28 and 654.23, plus its inverse work. The quadratic-conditioned common-root baseline reduces these modular-trial counts roughly by half while adding filtering costs. These upper schedules are not inequalities between optimal running times. They show why reducing fresh-base rounds alone is insufficient to select the retained-component algorithm.

The twelve-coordinate atomic output in the payload packet is especially expensive to CRT and serialize. Once completed components are available, producing r grouped roots takes eleven-minus-r modular multiplications in the generic all-nontrivial-component case. The selected unit residues and inverse then need their own work. With a free parity component, use the actual count and any explicit negation schedule. Whole-product CRT shares its modulus inversions across coordinates, but each coordinate still requires its own modular and lifting products. The fixed q=32 raw capacities of 4.7625 TB for common smooth roots versus 27.2 TB for eleven roots at B=10^16 remain capacities for that packet's fixed geometry, not resident-memory or compressed-size forecasts.

A one-common-root output can therefore use retained atomic generation while preserving the smaller payload. A four-root or six-root output can use the same completed components and trade bytes for cheaper checking. There is no reason to require the producer's success-retention partition to equal the checker partition.

## Candidate screening, capped completion and coverage

The preceding probabilities condition on a true prime. A complete search model must separately charge:

* residue sieving and probable-prime screening, including rejected candidates;
* true-prime root completion under the chosen sampling and cap;
* composite survivors that can stall on missing components until rejection;
* construction and checking of the final root/unit certificate;
* fallback search and its full certificate, if no candidate is completed within the declared stage budget.

Let rho be the earlier explicitly heuristic probability that a raw lattice candidate is prime. Let s_root be the true-prime completion probability within the root budget. Under the additional independent-candidate planning model the chance of a completed certificate per raw candidate is rho*s_root, and a window with n candidates has modeled failure `(1-rho*s_root)^n`. This merely refines the old model. It does not turn rho into a theorem or remove cross-candidate correlations.

Let a screen pass with probability alpha and let pi_cond be the conditional prime probability among survivors, both still unmeasured. The per-raw-candidate generation cost is

    C_screen + alpha [pi_cond E(C_root | prime)
                            +(1-pi_cond) E(C_root | composite, cap)].

The second expectation can matter even when true-prime completion is cheap. A valid component never makes the remaining composite tail disappear. Candidate screening quality must not be inferred from the finite-group success proportions.

For an IID window model, if p_cert=rho*s_root and mean raw-trial generation cost is g, expected generation through the first certificate or exhaustion is

    g * [1-(1-p_cert)^n]/p_cert.

The same model assumptions are needed for this stopping formula. Checking work uses only the selected completed certificate; failed attempts are generation work. A finite cap is operationally sensible but no rejected slot becomes accepted merely because the model assigned it a tiny probability.

For fixed windows the exact K and interval contract do not change when a different root-generation policy is chosen. For the adaptive chain, substitute p_cert for rho in the conditional deficit model only if its independent-candidate approximation is being used. Cheaper completion can permit a larger search budget, but its effect on progress and rung count remains model-dependent. Switching F or taking a general-prime fallback changes the next lattice phase and requires the actual interval reconstruction. Actual gaps and final coverage, not mean progress, remain the certificate authority.

The stage test from the earlier note remains valid with the revised generator cost: smooth fallback beats immediate general fallback only if

    g_S < (1-f_{S|P})(G-c_S),

under the same conditional window model. Retention can reduce g_S, reduce root-budget failures within f_{S|P}, or change c_S through a different output partition. Each change must be priced separately. Prime availability and the exact candidate collision counts are unaffected by changing the root search policy.

## Recommended comparison

Compare three generation policies on the same candidate set once a bounded experiment is separately authorized: fresh quadratic-conditioned common roots; retained prime-power components with subset projection sharing; and retained two- or four-group roots. Feed completed components into several checker partitions without repeating candidate search. Record actual projection/test work, failed composite and base attempts, retained-state size, composition, aggregate inverse, CRT and bytes. Include direct per-candidate supplied roots to avoid hiding a costly CRT assumption.

The new conditional sampling facts justify adding retention to the efficiency frontier. They do not establish that all-atomic generation or an eleven-root output is cheapest. The strongest actionable separation is to choose candidate geometry, retention policy, output partition and checker batch size independently, then compare their combined costs under the same exact final theorem.

## Frozen evidence

Paths are relative to `work/qrh-campaign/agents`.

| Artifact | SHA256 |
|---|---|
| `independent-feasibility/HEURISTIC_MIXED_LADDER_PORTFOLIO_2026-11-11.md` | `D75CF9950644A9ECFE7E42578C9847238AB785BA29C51EE219CCCAF19B780CD0` |
| `prime-estimates/SUPPLIED_ROOT_PRODUCTION_PAYLOAD_2026-11-11.md` | `EA13551BB8A8C572F983A26EC57E4F3FCD3E658F86DCE8252BABF70002814044` |
| `major-constants/EFFICIENCY_GROUPED_ORDER_ROOTS_2026-11-11.md` | `94CEE16A312EE0535E57827BA5241AC768464EB0DE4654500A3A8B7B84C8F5C4` |
| `major-constants/grouped_order_root_schedules_20261111.json` | `C0E1AAAC2EF8D90CAA841288ACCD5B3938DB981D3C3F3F3AC010CE37B1225BFC` |
| Owned `retained_root_generation_model_20261111.py` | `05077A3081C919526420BB17A9F9562E521CC5A5174F99D512A716F101ADBF28` |
| Owned `retained_root_generation_model_20261111.json` | `B07D4A7CFACD01F1E2755D8EB96D0607C7DB441849F86C4B87C678DD71E6E999` |

The new exact arithmetic script reads the pinned schedule JSON as data, never imports or executes its producer, and records six m=160 partition models plus eleven fixed component projection schedules. A separate read-only check verified pairwise disjoint masks and exact coverage of all eleven factors. The power-test additions above were independently evaluated by integer bitlength/popcount arithmetic. No modular power was evaluated. These are exact consequences of the stated finite-group model and schedules, not observations about ladder candidates or a Lean/MM0 acceptance run.
