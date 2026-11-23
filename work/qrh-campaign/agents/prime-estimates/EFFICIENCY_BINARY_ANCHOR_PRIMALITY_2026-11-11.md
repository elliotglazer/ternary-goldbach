# Binary anchor certificates, factor reuse and structured-halo costs

2026-11-11. Paper research and exact integer geometry only. No anchor prime was searched for or tested, no factorization was performed, and no sieve, Lean/MM0 build or analytic evaluation ran. The new scalar script checks size and endpoint formulas. Earlier reports remain unchanged.

Use cache-aware partial Pocklington as the reference certificate for arbitrary anchors. Its large-factor dependencies have a useful nonbranching structure at these source sizes. Pure power-of-two structured anchors admit a cheaper certificate, but the aligned binary origins exclude every such candidate from the old halo at the required global exponents. Enlarging the halo enough for 512 lattice candidates already changes source storage and coverage span substantially, before any prime-availability question is answered.

## 1. Fixed geometry and exact occurrence counts

Let B be 10^16 or 2*10^16, L one of 2^32,2^34,2^36, D0=2^19 and A=512. An anchor for block r has

    q=2rL-(2s+1), 0<=s<=D0, q>=3.

The source index for target n=2(rL+t) is j=t+s. The shared source ceiling is U=2(L+D0)-1. There are R=floor(B/(2L)) outer blocks, including the last partial block, and the separate initial range 4<=n<2L. The exact partition identity remains

    (L-2)+(R-1)L+(B/2-RL+1)=B/2-1.

The following are nominal occurrences if A anchors are reserved for every block; neither primality nor full coverage by that pool is assumed.

| B | L | Outer blocks R | A*R | Anchor bit bound |
|---:|---:|---:|---:|---:|
| 10^16 | 2^32 | 1,164,153 | 596,046,336 | 54 |
| 10^16 | 2^34 | 291,038 | 149,011,456 | 54 |
| 10^16 | 2^36 | 72,759 | 37,252,608 | 54 |
| 2*10^16 | 2^32 | 2,328,306 | 1,192,092,672 | 55 |
| 2*10^16 | 2^34 | 582,076 | 298,022,912 | 55 |
| 2*10^16 | 2^36 | 145,519 | 74,505,728 | 55 |

With D0<L, the anchor intervals of different outer blocks are disjoint. Therefore there is no cross-block root-prime deduplication in this exact geometry. If each block actually selects A distinct roots, all A*R are distinct. Factor certificates can still be shared, and a partial final block may choose fewer roots. The old overlapping test fixtures do not establish a root-deduplication rate here.

## 2. Partial Pocklington and a bounded large-factor chain

For an odd claimed prime n, use already proved distinct primes p_i and positive exponents e_i, F=product p_i^e_i, n-1=F*R, and F^2>n. Check a^(n-1)=1 modulo n and, for each p_i, a unit witness for a^((n-1)/p_i)-1 modulo n. A modular inverse witness can replace a gcd. The unselected R need not be factored or coprime to F.

The source note `work/mm0-efficient/primality.md` gives the elementary order argument: for every prime divisor r of n, the unit condition forces the full p_i-adic valuation of n-1 into the order of a modulo r. Thus F divides r-1. Every prime divisor would exceed sqrt(n), impossible for a composite. A common base is sufficient; separate bases are a legitimate fallback, with their separate exponentiation cost. This general checker is a proposed formal subsystem with native prototypes, not a currently accepted Lean or stock-MM0 implementation.

For all six rows above, U^2>B. Hence n-1 has at most one distinct prime factor p>U, and its exponent is one. If one is present, p alone already satisfies p^2>n. A certificate may choose F=p and ignore the factorization of the cofactor entirely. Since n is odd and p is odd,

    n-1=p*R, R>=2, p<n/2.

Every above-U recursive dependency therefore has outdegree at most one when this certificate policy is used. It is a strictly halving chain, possibly merging with chains from other anchors. This is a certificate-shape bound, not a claim that finding the large factor is cheap.

Let h be the least integer with 2^h U>=B. The number of above-U nodes on any chain, including its root, is at most h. When a node has no above-U factor, it becomes a terminal certificate whose selected factors are at most U. Any internal one-large-factor node has second exponent R< B/U.

| B | L | Above-U chain nodes <=h | Second exponent R <= | Its bits <= |
|---:|---:|---:|---:|---:|
| 10^16 | 2^32 | 21 | 1,164,011 | 21 |
| 10^16 | 2^34 | 19 | 291,029 | 19 |
| 10^16 | 2^36 | 17 | 72,759 | 17 |
| 2*10^16 | 2^32 | 22 | 2,328,022 | 22 |
| 2*10^16 | 2^34 | 20 | 582,058 | 20 |
| 2*10^16 | 2^36 | 18 | 145,518 | 18 |

These are worst-case shape bounds. They do not predict chain length, number of distinct merged nodes or factorization cost. Multiplying h by the nominal root count is only a conservative bound for the above-U part of unmerged chains.

There is an important cache qualification. The accepted source bitmap contract is one-sided: a positive bit proves primality, but a zero bit need not mean composite. Therefore U is not automatically a complete certified-prime cache. Each factor p<=U must actually have a checked positive source bit, an existing factor-prime theorem, or an additional certificate. The nonbranching statement applies to factors above U; unproved or absent below-U cache entries remain additional work. A producer that chooses the restricted chain format must reject or fall back when its terminal cache references are unavailable. This does not follow from a hash or from unverified sieve completeness.

Retain factor facts independently of source eviction. A valid reference must identify the exact p and its checked prime theorem. Cross-shard reuse needs a checked dependency mechanism. Rebuilding a small factor's proof in every shard or resolving it by a linear source-list lookup can erase sharing benefits.

## 3. Arithmetic counts at equal acceptance boundaries

Let b be the bit bound for n, and k the number of selected distinct Pocklington factors. Reusing a^(2^j) modulo n gives at most b-1 ladder squares, at most b selected products for the Fermat exponent, at most b for each factor exponent, and one extra modular product per inverse witness. A simple upper bound is

    (k+2)*b+k-1 modular products,

excluding Montgomery setup/conversion, factor-product/divisibility checks, parsing, lookup and proof dispatch. Squaring and multiplication are both counted as modular products here, not priced equally in seconds.

For a one-large-factor node, the second exponent has only the bits in the table. The corresponding bound is 2b+bits(R), namely 129,127,125 for B=10^16 and 132,130,128 for B=2*10^16. This is materially different from assuming two unrelated full-length powers or fully factoring n-1. Terminal nodes with several cached factors need their actual exponent set and cache costs.

A power-of-two structured anchor can use a single negative-one congruence, at most 2b-3 modular products by ordinary binary exponentiation, or 105 and 107 at the two B values. These bounds alone do not establish a net saving, and specialized batching can change both sides. All node moduli here have at most 54 or 55 bits, unlike the prior 61/62-bit anchor fixtures. The old measured native microseconds and the Lean full-Pratt measurement are not transferable conversion factors.

For strict Lean acceptance, price the actual closed modular-arithmetic reductions and symbolic soundness proof. For ordinary MM0, price concrete arithmetic proof generation/checking and sharing. For a new justified machine checker, separately pay its admissibility and exact executable-refinement work. Native C modular multiplication is not automatically any of these accepted proof operations.

## 4. The aligned-origin obstruction for cheap structured anchors

Take F=2^m and candidates q=kF+1, 1<=k<F. The source ladder's elementary power-plus-one argument gives primality from a suitable negative-one congruence, once q<(F+1)^2. The global sufficient choices F^2>B are m=27 at B=10^16 and m=28 at B=2*10^16. They work for either parity of k. Strict Proth terminology often requires k odd; that narrower family has twice the lattice spacing.

Put g=F/2. Since every candidate L is divisible by g,

    q=2rL-2s-1 is 1 modulo F iff s=g-1 modulo g.

The allowed source offsets are therefore g-1,2g-1,3g-1,... . The number in [0,D] is exactly floor((D+1)/g), before imposing q>=3. At the old D0=2^19 this number is zero for m=27 and m=28. This is an exact obstruction for every outer block with these global exponents. It does not depend on any assertion about prime density.

Even A=512 lattice candidates require

    D>=A*g-1,

so D>=2^35-1 or 2^36-1. This only provides 512 integers of the right shape. It gives no prime among them, much less 512 primes or a covering anchor pool. Restricting k to odd requires D>=(2A-1)g-1 instead. The report's optimistic structured comparison uses the broader family.

| B | Minimum D for 512 lattice sites | First possible positive block r, L=2^32/34/36 |
|---:|---:|---:|
| 10^16 | 34,359,738,367 | 9 / 3 / 1 |
| 2*10^16 | 68,719,476,735 | 17 / 5 / 2 |

The last candidate is q=2rL-2Ag+1, so positivity q>=3 requires rL>=Ag+1. Those early blocks cannot be filled even with 512 hypothetical prime lattice sites. They need a separate arbitrary-anchor route, a smaller block-local m, or an enlarged initial proof. A block-local m can reduce spacing early, but supplies no uniform prime-availability or coverage theorem.

The current source `Ladder/Spec.lean:38–53` fixes exponent 45; it cannot be invoked literally with 27 or 28. Its proof uses the general Mathlib prime-factor congruence and minimum-factor inequality, so a parameterized version has the same elementary proof. The fixed source batch format, index bounds and base cancellation still need their own generalization and checking. This report supplies none of those new Lean declarations.

## 5. Halo, span and reuse costs cannot be omitted

At the optimistic minimum D=Ag-1, raw one-bit source storage becomes:

| B | L | Old source bytes | Structured source bytes |
|---:|---:|---:|---:|
| 10^16 | 2^32 | 536,936,448 | 4,831,838,208 |
| 10^16 | 2^34 | 2,147,549,184 | 6,442,450,944 |
| 10^16 | 2^36 | 8,590,000,128 | 12,884,901,888 |
| 2*10^16 | 2^32 | 536,936,448 | 9,126,805,504 |
| 2*10^16 | 2^34 | 2,147,549,184 | 10,737,418,240 |
| 2*10^16 | 2^36 | 8,590,000,128 | 17,179,869,184 |

The complete source sieve also has a larger ceiling 2(L+D)-1 and base sqrt bound, recorded exactly in the receipt. Its generation and proof cost are additional. Larger U can shorten the large-factor chains, but those saved steps are not a reason to ignore the new source proof.

For a contiguous coverage tile of T=2^18 target bits, the simple [a,a+T+D) source window now spans 131073 source chunks at B=10^16 or 262145 at B=2*10^16, rather than three. Normalizing away the minimum selected offset reduces these optimistic counts only to 130817 or 261633. The A consecutive lattice sites still have offset span (A-1)g. Actual prime selection can have a much larger span.

This does not force a checker to load that whole contiguous window. With offsets s_i=s0+g*k_i, split target indices as t=b+g*a, 0<=b<g. Define r_b=(b+s0) mod g and c_b=floor((b+s0)/g). Then

    B[t+s_i] = B[r_b+g*(a+c_b+k_i)].

A proved residue-class layout can check coverage in the compressed k coordinate, with span max k_i-min k_i rather than g times that span. However it creates g residue rows: 67,108,864 or 134,217,728. Full-block target lengths per row are respectively 64/256/1024 and 32/128/512 for the three L choices. Total targets remain L. The source transpose/rank mapping and each row's boundaries must be proved; this is a different representation to benchmark, not permission to apply the old packed-convolution timing to huge offsets.

When D>=L, anchor intervals overlap and root-prime facts may be reused. A given anchor can belong to at most floor(D/L)+1 outer intervals. For the minimum structured halos this upper bound is 8/2/1 at B=10^16 and 16/4/1 at B=2*10^16. It bounds possible reuse only; it does not show that a shared pool covers those blocks. Anchor-reference bytes and coverage work remain for every consuming block. The original small-halo disjointness no longer applies.

## 6. Other structured factors and a residue obstruction

Requiring a fixed smooth F to divide every q-1 can lower certificate cost, but any odd prime ell dividing F makes all anchors congruent to 1 modulo ell. For targets n=1 modulo ell, the other summand p=n-q is divisible by ell. A prime p must then equal ell, so that target requires the particular anchor q=n-ell. A fixed A-anchor pool can cover at most A such targets in a block. If the block has more than A targets in that residue class, this family alone is impossible, irrespective of the halo or producer speed.

Thus smooth fixed moduli with odd factors need additional anchor residue families or arbitrary fallbacks. Local residue coverage can be checked as a finite necessary condition, but cannot prove actual source/anchor primality or full coverage. Pure powers of two avoid this particular obstruction because every candidate source prime is odd. They still face the lattice and span costs above.

A less restrictive approach is to search the original halo for ordinary primes, then prefer those whose n-1 has cheap already-cached factors. That changes producer selection without fixing one forbidden residue class or enlarging D. The producer should optimize marginal certificate-DAG cost, not just smoothness or the largest numerical factor. Unsuccessful factorization, failed bases, rejected prime candidates and discarded cheap-but-unhelpful anchors must all be charged. A hard resource cap may produce an unresolved block; it is not a proof of that block.

## 7. End-to-end decision and bounded next tests

For each block, record the actual candidate attempts, prime-search failures, factor attempts, modular-base attempts, selected roots and offsets, selected factor exponents, new factor-DAG nodes, cache hits/misses and successful coverage. Then use one cost model with all terms:

    C = shared source/factor setup
        + candidate and factor generation, including failed work
        + accepted root/factor proof production and checking
        + source enlargement/repacking and coverage
        + initial/exceptional ranges, storage, imports and final assembly.

For a structured proposal, compare its saved total accepted-certificate cost against all added search, source, span and boundary costs. No prime-density hypothesis may supply an assumed success fraction. A family with zero lattice candidates in the old halo must change its geometry before such a comparison is even meaningful.

The next authorized benchmark should first implement partial Pocklington on arbitrary anchors at these 54/55-bit scales, with actual cached source references and the one-large-factor chain policy. Compare against the same roots' full Pratt certificates and a cost-preferred subset within the same halo. Only then test an enlarged structured halo, reporting every failure and the residue-layout costs. Use the same proof acceptance boundary and complete block coverage on each side. Current native fixture rates are useful historical evidence about a different algorithm/input size; this note makes no time prediction from them.

The exact geometry already rules out silently substituting 512 globally chosen Proth-style anchors into the old halo. The partial-factor chain reduction is available without that substitution and without any new analytic assumption. Whether it yields the cheapest complete certificate remains an implementation and measured-production question.

## Pins and scalar evidence

The new integer-only script ran exit 0. It checked square thresholds, aligned offsets, positivity of the 512th lattice site, chain bounds and all six exact target partitions. It evaluated no candidate for primality and imported no evaluator.

| File | SHA256 |
|---|---|
| `work/qrh-blueprint/BINARY_BLOCK_SCALING_2026-11-11.md` | `982115AD458F718039B391DAEA714E25C5E80823C49B537ED78FEC8F155480CD` |
| `work/mm0-efficient/primality.md` | `003B53ABCC7C40D98B85C0735546220A55EFFBA27FCF7A7D0B09B1CCD68C226A` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean` | `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F` |
| `work/qrh-blueprint/MULTIBASE_PROTH_RESEARCH_2026-11-11.md` | `555DA959A4591205291DB862E1FE1FBA885545C4E3EC920D2FDF48F8A200D337` |
| This directory's `EFFICIENCY_SOURCE_SIEVE_2026-11-11.md` | `55052C31D2DEFD00CAB9DB99CC1E947C4E14E509FDF0ED376E20374A1F6C0F54` |
| `efficiency_binary_anchor_geometry_20261111.py` | `0623956CA4BFE555B550D9141812E632349F9F30735372BA4DD7601B9D0E6227` |
| `efficiency_binary_anchor_geometry_20261111.json` | `89771FA060EE673F195B7E4A051BAEE3ABD9C89C40FD51476ED1EE62BCCF88FD` |

The source-sieve report now has independent review `audit/REVIEW_EFFICIENCY_SOURCE_SIEVE_2026-11-11.md`, SHA256 `14CF4667B624DCADADDBE341E2849FB974AA42CD5DC25C84E18A67DCA8325CB7`. That review does not validate this new anchor proposal or any implementation.
