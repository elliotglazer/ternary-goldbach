# Compare QRH against the original proof's actual finite-RH needs

2026-11-11. This changes the computational comparison baseline, not the final theorem. It contains integer metadata and source-level reasoning, not zero computations, a compiled refactor or a newly discharged finite-RH obligation.

The proposed working baseline is to keep the original analytic estimates and certify only the finite-RH domain consumed by the final proof. QRH should be compared against that restricted route. Comparing a carefully optimized QRH domain against every conductor in the broader `PlattGRH` declaration would overstate the savings attributable to QRH.

## The domains being compared

The source declaration in `Statement.lean:55-60` requires primitive characters at odd conductor c<=300000 through H=1e8/c, and even conductor c<=400000 through H=max(1e8/c,200+7.5e7/c). All heights are closed, and the real-part conclusion is exactly 1/2 for zeros in the critical strip.

The source-level consumer audit identifies a smaller candidate sufficient domain:

- Odd c<=150000, H=1e8/c.
- Even c<=300000, H=max(1e8/c,200+7.5e7/c).
- The principal conductor c=1 retains H=1e8.

This restriction requires localized consumer refactoring. It is not a proof of the original broader `PlattGRH` proposition, and one cannot instantiate the old global Fact from the smaller data. The goal permits this change because the target is the final ternary theorem, not the name of an intermediate hypothesis. Every remaining finite-RH fact must ultimately be proved by a checked certificate.

The comparison QRH profile is the previously selected finite strip domain. It uses the same active conductors as the smaller original-RH candidate, upper real-part bounds .555 for c<=100000 and .56 above that, and these heights:

    qt(c)=2c if c is odd, otherwise c;
    H(c)=min(200+max(1000,ceil(844800000/(7*qt(c)))),1e8/c), c<=100000;
    H(c)=5e7/c, c>100000 odd;
    H(c)=9.9e7/c, c>100000 even.

It additionally requires the global QRH provider and its changed analytic consumers. Its principal strip is not the original proof's H=1e8 critical-line condition; the QRH route retains its separately specified principal head/count/moment obligations. They must not be conflated when comparing workloads.

## What the source evidence establishes

The coordinator inspected the following decisive bodies:

- `MajorArcs/Thm714.lean:568-649` uses the principal c=1 case, odd conductors only through 150000, and even conductors through 300000. The low even range asks for height 1e8/c; the high even branch uses the larger original height.
- `MajorArcs/ArcCharsStar.lean:139-223` starts with qt(q)<=300000 and passes to a primitive conductor c dividing q. When q is odd, q<=150000. When q is even and c is odd, c<=q/2<=150000. Even c is at most q<=300000.
- `MinorArcs/BaseGap2.lean:185-227` obtains q from the two actual major-arc branches, with odd q<=r0=150000 or even q<=2r0. Its current `gap_point` result forgets that distinction and exports only q<=300000. Retaining the branch information allows the same conductor restriction downstream without strengthening a numerical estimate.
- `MajorArcs/Cor713.lean` currently provides a generic result for all c<=300000 from the broad global Fact. An explicit finite-RH premise at its actual c,H lets production consumers use the narrower data. Its numerical bounds remain usable; the generic theorem's broad signature alone is not evidence that every conductor in it is used by the final proof.

A complete source audit must also trace the principal psi, E1 and Mertens uses, indirect wrappers and the final assembly. The delegated report is responsible for this closure. The metadata calculations below do not establish domain sufficiency by themselves. In particular, an uninspected theorem carrying the broad Fact may have a live use and cannot simply be declared dead.

There are no primitive characters at conductors c=2 modulo 4. Metadata excludes those empty rows. The restricted finite-RH obligation may equivalently quantify over all even c and discharge the empty cases formally; skipping them in certificate generation requires the corresponding mathematical theorem.

## Exact size comparison

The number A(c) of primitive complex Dirichlet characters satisfies

    sum_{d|c} A(d)=phi(c),   sum_{d|c} phi(d)=c.

The new [metadata script](rh_domain_cost_metadata_20261111.py) computes both sequences by integer divisor-sum inversion. It does not evaluate primes, characters, L-functions or zeros. It then computes directed rational bounds for the positive-height quantity V=sum_c A(c)*H(c), using integer rounding at scale 1e6.

| Profile | Nonempty conductor rows | Primitive-character labels | V, approximately |
|---|---:|---:|---:|
| Original declared domain | 250,000 | 18,068,152,606 | 11,808,455,664,209 |
| Smaller original-RH candidate | 150,000 | 5,543,640,188 | 6,285,356,689,343 |
| Selected QRH strips | 150,000 | 5,543,640,188 | 4,559,691,844,047 |

The exact enclosing ratios in [the result file](rh_domain_cost_metadata_20261111.json) give

    .532275 <= V(smaller original)/V(declared original) <= .532276;
    .725446 <= V(QRH strips)/V(smaller original) <= .725447.

Thus restricting the original consumers removes about 46.8% of this height-weighted metadata quantity. The QRH strips reduce it by a further approximately 27.5% relative to the appropriate smaller original-RH baseline, while retaining every primitive-character label in that baseline.

These are not zero counts or runtime ratios. The number of zeros includes conductor/height-dependent logarithms, the evaluator must pay for shared transforms and precision, Turing or contour certificates require completeness and auxiliary work, and the two profiles use different analytic conclusions and checking algorithms. Principal head work is also separately specified in the QRH route. Neither percentage is a promised compute saving.

## Consequences for the proof plan

The original-analysis route now has a stronger case as the conservative baseline. It can potentially discard substantial conductor overcoverage while retaining the existing estimates and avoiding the global QRH formalization. The selected QRH route must justify its remaining height reduction and weaker finite conclusion against the cost of its additional analytic provider and certificate design.

Do not discard QRH: a consumer-weighted estimate that removes whole conductor ranges could change the comparison. But do not price its current finite strips as if their lower height alone established a faster checker. Compare complete batched critical-line/Turing and strip/hybrid certificates on the same retained family, with all auxiliary heights and hard cases included.

The finite Goldbach optimization is compatible with either spectral route. The smaller binary cutoff, mixed multi-base ladder and blockwise existence certificates therefore remain useful independent work. This separation allows the proof plan to improve without committing prematurely to the more expensive analytic dependency.

Current status: exact metadata computed; selected source callsites inspected; complete delegated consumer-domain report pending. No Lean source was edited, no numerical analytic evaluator ran, and no finite-RH fact was newly proved.
