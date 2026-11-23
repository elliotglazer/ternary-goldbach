# Finite coverage and prime-chain cost frontier after batched primality

The new HOL result improves a real primality implementation, but it does not justify a 138-fold reduction of the full finite budget. In the previously selected large-block Lean model, anchor checking is only 0.065 core-years out of 18.43 central core-years. The much larger uncertainty remains the production-scale coverage checker, shared source certification, and dense prime chain. The README's 55-microsecond ladder figure is still unreplicated and applies to a different, hardcoded window schedule.

This is a fixed-metadata and conditional cost audit. No build, candidate search, sieve, prime evaluation or inventory was run. Only this note and its scalar companion `FINITE_FRONTIER.json` were written. The companion pins all 13 input files and records the exact arithmetic behind the tables. A core-year means 31,557,600 CPU seconds, or 8766 core-hours. Its SHA256 is `F7FEC97B805D89BD258A673EB57C2DBDE491313870A1E9899773EAEBE89F018A`.

## What the new measurements establish

The HOL batch checks the same 1537 Lucas nodes and 7614 expanded factor occurrences, proves all 393 requested primes, and closes the same 1024-target interval. The roots comprise 283 source primes and 110 anchors. All nine controls pass in three fresh processes, with identical 2,071,826-byte exports and the four standard HOL axioms. It is not a Lean theorem or an ordinary-PA MM0 proof.

| HOL phase or boundary | CPU seconds |
|---|---:|
| Primality evaluator, median | 0.064050 |
| Root membership, median | 0.023791 |
| Projection of individual prime theorems, median | 0.084930 |
| Certificate and requested-root translation, sum of medians | 1.637213 |
| Prime-tree construction, median | 0.000828 |
| Sum of those six prime-related phase medians | 1.810812 |
| Median whole phase total | 6.005743 |
| Median complete process | 13.09 |

The old balanced primality phase was 8.849970 seconds, giving the reported 138.17 ratio. The corresponding whole-process comparison is 18.27/13.09, about 1.40. Phase medians need not sum to the median total. Export now costs 3.324970 seconds median, and witness translation remains 0.816570 seconds. Those operations are not made free by a cheaper modular evaluator. The failed earlier arrangement that checked roots one at a time spent 8.738439 seconds on membership alone; the successful batch avoids that repeated tree evaluation.

The native GMP reference checks the same supplied graph in 2.666905 milliseconds median, and membership/coverage in 0.146110 milliseconds. It has no theorem authority and does not discover the full prime set. HOL's approximately 24-fold primality-phase overhead relative to this reference is local to these algorithms and data. It is neither a universal HOL slowdown nor a rate for generating 90-bit ladder primes.

The selected stock-Lean report remains a different implementation and measurement boundary. Its complete dependency replay takes 9.4516709 seconds median, while its anchor closure takes 4.983475 seconds for 110 anchors. The latter includes prime-factor sharing, list and nonunderflow proofs; it is not an isolated modular exponentiation. The complete build takes 547.234375 CPU seconds, including imports and initial kernel admission. That build must not be added to the complete replay and described as one initial acceptance. A separate replay is an additional workflow stage. The 0.046875-second native producer is untrusted witness generation, not the build or checking time.

The HOL 13.09-second process already includes proof-producing kernel evaluation. Adding its 64.05-millisecond primality phase again would double-count it. Neither full process can be compared with Lean's warm kernel replay as though their boundaries matched. Ongoing Lean batching experiments are not assigned any speedup in this pinned audit.

## Block sharing changes which costs dominate

Let B be the binary cutoff and L the number of even targets in an outer block. Keep the prior physical envelope D=2^19 and nominal 512 anchors per block. These are proposed production parameters, not evidence that every block is covered. The source bitmap has L+D odd slots representing numbers through 2L+2D-1. It is shared across outer blocks rather than regenerated for every 1024 targets.

At B=10^16:

| L | Raw source bytes | Nominal anchor records | Old 55.078125-ms anchor proxy, core-years |
|---|---:|---:|---:|
| 2^32 | 536936448 | 596046336 | 1.04029 |
| 2^34 | 2147549184 | 149011456 | 0.26007 |
| 2^36 | 8590000128 | 37252608 | 0.06502 |

The numbers of all target words and all W=2^18 coverage tiles scarcely change with this choice. The full model counts B/2-1 even targets, including the initial L-2 targets below 2L. There are floor(B/(2L)) outer blocks. Their widths are min(L,B/2-rL+1); a divisible final endpoint creates a width-one final block, not an omitted endpoint. The all-target tile budget at B=10^16 is 19,073,486,329, including the initial obligation. Increasing L therefore changes source and anchor costs, not the requirement to cover every target.

The old central Lean budget assigned 0.06502 core-years to anchor checking, 0.2 to source checking, 0.1 to source generation and about 0.02361 to anchor generation. Making anchor checking literally free removes only 0.353% of that declared 18.43-year total. Making both source and anchor checking free removes 1.44%. These are caps on savings inside the old accounting model, not bounds on actual source cost. Its source budgets were unmeasured; an actual implementation may reveal a much larger source bill.

As a diagnostic, dividing the HOL six-phase subtotal by 393 gives about 4.608 milliseconds per requested root. Applying that quotient to the nominal L=2^36 anchor count would cost 0.00544 core-years. The arithmetic-only quotient gives roughly 0.000192 core-years, while allocating the entire 13.09-second process to its 393 roots gives about 0.0393 core-years. These are three different boundaries, not optimistic/central/pessimistic runtime bounds. The fixture mixes small source primes and larger anchors; future batches need not have the same graph size, factor multiplicities, root widths or cache sharing. None is credited as a measured replacement for Lean or MM0.

Even a successful matched HOL replacement near the diagnostic subtotal could save at most the small old anchor bill at this L. It could be more important at smaller L, but source certification, source extraction, coverage difficulty, memory and proof lifetimes also change. Holding those costs fixed while choosing a smaller L would not establish an optimum.

Positive source bits require genuine prime evidence. A sparse source subset need not contain every prime if coverage succeeds. A survivor-sieve implementation, however, must establish completeness of its base divisors through the relevant square-root bound. The HOL Lucas batch does not supply that sieve proof, its recursive source list or its 8.59-GB bitmap. Reusing source theorems across blocks also requires a checked context or charged import/transport; discarding the source and regenerating it per outer block destroys the assumed amortization. Shared factors must not be charged as independent copies in every source and anchor closure, but their binding is not free either.

## The 55-microsecond ladder claim has a narrow contract

`work/ternary-goldbach/README.md:119` describes 254638308 primes of the form

    p_i = (111616*i - t_i)*2^45 + 1,  0 <= t_i < 2048.

It claims 15 microseconds for native hints and 55 microseconds for kernel checking per rung. Those figures multiply to about 1.061 and 3.890 core-hours for that rung count, consistent with its approximately five-hour summary. Arithmetic consistency is not replication. No matching timing receipt for this full ladder was supplied by the new binary pilots.

The actual source supports a specialized schedule. `Ladder/Check.lean:61` builds a product modulus for 32 candidates, then shares exponentiation and progression updates. The constant 111616 is in the actual loops. `Ladder/Spec.lean:207` and `:287` restrict the rung indices to below 2^28 and preserve the corresponding fixed-window contract. `LadderHints.lean:37` searches a bounded window, initially sieves 512 offsets, then tries offsets through 2047; line 58 explicitly fails if no suitable prime is found. No prime-distribution premise guarantees that every adapted window will succeed.

Write F=2^45=35184372088832. The source's worst consecutive-window gap is

    (111616+2047)*F = 3999161284732911616.

The physical window span alone is 2047F=72022409665839104. Thus retaining all 2048 offsets cannot yield the same worst-case gap guarantee at B=10^16 or 2*10^16, regardless of a positive fixed stride S. To guarantee gaps at most B-2 by the same independent-window argument, one needs S+2047 <= floor((B-2)/F).

For N0=9.89e26 and largest odd target T=N0-1, a complete increasing chain from p0=3 must have gaps at most B-2 and finish with pK+B>=T. Its necessary number of new primes is ceil((T-B-3)/(B-2)).

| B | Necessary new primes | Maximum F-lattice index jump | Largest S retaining all 2048 offsets |
|---|---:|---:|---:|
| 10^15 | 989000000000 | 28 | impossible |
| 10^16 | 98900000000 | 284 | impossible |
| 2*10^16 | 49450000000 | 568 | impossible |
| 10^17 | 9890000000 | 2842 | 795 |
| 4*10^18 | 247250000 | 113686 | 111639 |

The B=10^16 and B=2*10^16 planning cutoffs also need roughly 37-bit and 36-bit rung indices even at the necessary count, beyond the literal 28-bit theorem interface. A narrower fixed-window checker or an adaptive actual-gap checker is a plausible different construction, but its proof, hints, complete chain and timing must be supplied. A common-root certificate changes the check shape further. The existing paper criterion supports that possibility; it does not establish the README rate for it.

This is not an impossibility result for dense prime chains. It is a precise reason why the frozen source and its claimed per-rung timing cannot be used unchanged. Generic Lucas-root timing from the 393-root fixture is equally unsuitable as a direct dense 90-bit Proth rate. Failed windows, alternative bases, smooth-factor fallbacks, arbitrary-prime factorization and their proof production remain separate costs.

## Revised conditional Lean and ordinary-PA scenarios

The old low/central/high finite envelopes remain hypotheses, about 6/18/477 core-years for Lean and 185/720/13800 for conditional stock-layout ordinary PA MM0. The new HOL batch does not validate or rescale either envelope. It also gives no new PA instruction-to-time conversion and does not discharge stock MM0 proof-layout admission.

A narrow Lean update is possible: re-anchor the central anchor-checking proxy to the selected new Lean closure, 4.983475/110 seconds per root. Holding every other old assumption fixed changes the central total from 18.4306234 to 18.4190858 core-years. The new anchor bill is 0.05348 rather than 0.06502 years. This is an illustrative proxy at different widths and sharing, not a statistically established improvement. It does not materially alter the rounded 18-year central estimate. There is no evidence here to tighten its low/high generation, fallback or coverage multipliers.

The dense-ladder rate has much more influence. The following table changes only the assumed successful special-rung checking time, uses that new Lean anchor proxy, and retains the old central native generation, 0.1% fallback fraction, fallback costs, K=1.2*Kmin, coverage, source and setup budgets. The entries are total core-years, not measured forecasts.

| Assumed special-rung checking | B=10^16 | B=2*10^16 | B=10^17 |
|---|---:|---:|---:|
| 55 microseconds | 18.01 | 30.17 | 138.38 |
| 165 microseconds, old central assumption | 18.42 | 30.38 | 138.42 |
| 1 millisecond | 21.56 | 31.95 | 138.74 |
| 10 milliseconds | 55.41 | 48.87 | 142.12 |
| 100 milliseconds | 393.87 | 218.10 | 175.97 |

The selected B depends on the actual complete path and its amortized production-plus-checking cost. Under the old central nonladder budgets, changing B from 10^16 to 2*10^16 breaks even near 7.28 milliseconds total work per rung for Lean, and near 41.2 milliseconds in the old ordinary-PA model. The next move to 10^17 breaks even near 72.8 and 412 milliseconds respectively. These thresholds hold the deficit and nonladder assumptions fixed; an actual change in prime availability or fallback share changes them. They are not a license to choose B before a complete certificate exists.

In the old central MM0 scenario at B=2*10^16, anchor checking is only 2.361 core-years of 720.483. Its equal assumed proof-generation surcharge adds another 2.361 years. Even deleting both would save under 0.66% of that model. HOL batching supplies no justification for deleting either PA term. The much larger MM0 dense-ladder and coverage expansion assumptions remain unmeasured ordinary-rule implementations.

## HOL has a measured component, not yet a whole finite estimate

There is no defensible measured HOL low/central/high whole-range total from this fixture. In particular, multiplying 13.09 seconds by the number of 1024-target blocks would discard the intended source and anchor sharing. Conversely, borrowing Lean's large packed-cover rate or its unreplicated Proth timing would conflate distinct implementations.

A useful explicit frontier at B=10^16 and L=2^36 is

    C_H = 6.437 core-years of the retained native mask-search assumption
        + (19073486329*c_tile + 118680000000*c_ladder
           + 37252608*c_anchor) / 31557600
        + C_source + C_initial + C_setup + C_exceptions + C_other_production.

The c quantities are seconds per complete admitted tile, rung and anchor at their actual shared lifetimes. They must include the appropriate data translation and construction, or those costs must appear in C_other_production exactly once. If c_ladder is checking only, all native and proof-producing ladder work remains additional. The 6.437-year search term is the old native planning assumption, not a new HOL measurement.

For scale, c_tile=1/10/100 milliseconds costs about 0.604/6.044/60.44 core-years. A c_ladder of 0.1/1/10/100 milliseconds costs 0.376/3.761/37.61/376.1 core-years. Neither rate has been measured for the proposed full production objects. These partial sensitivities show what a complete HOL budget must determine; they are not alternative completed estimates. A common 6/18/477 envelope for Lean, HOL or another foundation could be imposed as a resource target, but cannot be presented as a forecast justified by this batch result.

## Remaining obligations and interpretation

The complete finite result still requires every even target from 4 through B, exact source/anchor identity, checked interval seams, the initial range and the final short block, plus a successful prime chain with every gap and terminal condition verified. Nominal 512-anchor pools and the old fallback fractions are not existence theorems. A supplied subset that misses one target cannot be rescued by a favorable average cost.

The production model must pay failed searches, primality witnesses, recursive source coverage, source extraction, retained theorem contexts, construction, export, cold support and exception proofs. It must distinguish first admission from optional independent replay. Huge numbers of fresh global theorem declarations, or a proof file imported by hash without its required trusted semantics, are not free amortization mechanisms. The new HOL representation improvement is concrete evidence that these choices matter; it is not a proof that all future representation costs vanish.

The supported revision is therefore modest at the previously chosen large L: a much better HOL primality component, a near-unchanged Lean anchor proxy, no PA timing transfer, and a sharper warning about the unreplicated dense-ladder extrapolation. The current finite totals remain conditional planning scenarios with unresolved source and production terms. No global finite-range proof, optimized backend selection or completed ternary-Goldbach theorem is claimed.
