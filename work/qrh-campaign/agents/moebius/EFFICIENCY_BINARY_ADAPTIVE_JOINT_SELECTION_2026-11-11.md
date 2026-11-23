# Joint binary cutoff and adaptive ladder selection

2026-11-11. Research accounting and exact integer geometry. No prime search, primality evaluation, coverage instance, analytic evaluation, Lean/MM0 build or new formal declaration was produced. The companion JSON contains geometry and source hashes, not certificates. All earlier frozen reports remain unchanged.

The operational rule is to compare complete binary savings with the extra *actual or explicitly conditional* adaptive-chain work. Direct-order anchor checks change the binary coefficient. Supplied-root ladder checks change a different coefficient. Neither change alone justifies reducing the binary cutoff. In particular, cheaper binary anchors can favor a larger cutoff and a shorter ladder.

## 1. Exact scope and coverage

Use an even candidate binary bound B in [10^15,4*10^18], D=2^19, and L in {2^32,2^34,2^36}. The requested planning threshold is T=9.89*10^26, so the last odd target is O=T-1. Using T here does not establish the analytic theorem at that threshold. The complete analytic route and its proof cost must still be supplied; if its actual threshold is 10^27, replace T everywhere and restore that route's cost.

The binary certificate proves every even integer in [4,B]. Write E=B/2 and R=floor(E/L). The initial range has L-2 targets. Outer block r, 1<=r<=R, has width min(L,E-rL+1); the outer total is E-L+1, and the combined total is E-1. A source bit j proves primality of 2j+1 for j<L+D. An anchor has the exact value

    p=2rL-(2s+1), 0<=s<=D, p>=3,

and a source hit at t+s proves 2(rL+t)=p+[2(t+s)+1]. Thus every such anchor satisfies p<=B-1. Source facts need only be sound positive bits; they need not include all primes below U=2(L+D)-1. Residual exceptions require their own prime proofs and exact representations. A prescribed anchor count or span is a search policy, not guaranteed coverage.

An adaptive ladder starts at p0=3 and supplies increasing odd certified primes with gaps <=B-2 and terminal p_r+B>=O. It covers [7,O] by the overlapping odd intervals [p_j+4,p_j+B]. Stop at the first terminal test. Every candidate sought before that test is <=O-4<T; nevertheless the verifier checks its explicit size bound. No changed B is silently substituted into the old fixed-stride source checker.

For same-F runs with F=2^45, let H=floor((B-2)/F) and R_F=B-2-HF. The first lattice prime has index 1<=k1<=floor(B/F). Subsequent indices obey k_next=k+H-d, 0<=d<H. Their actual gaps are F(H-d). If there are s transitions,

    p_end-p_start=s*HF-F*sum d.

The required terminal index is k_target=ceil((O-B-1)/F). These are exact statements about supplied primes, not prime-availability results. All formats require at least ceil((O-B-3)/(B-2)) new primes after 3. A same-F chain requires at least

    1+max(0,ceil((k_target-floor(B/F))/H)).

If an initial lattice prime exists and every following step succeeds with d<=d_max<H, a conditional upper count is 1+max(0,ceil((k_target-1)/(H-d_max))). Without success or a proved availability result there is no unconditional upper count or complete certificate. Mixed-F and general fallback records use the general actual-gap contract and pay their actual costs.

## 2. Geometry and changes in anchor size

The table gives exact counts, with no primality evaluations. The ladder column is only the necessary all-format count. The source setup and initial range are additional to every R column.

| B | Maximum anchor bits | H | Necessary new ladder primes | R at L=2^32 | R at L=2^34 | R at L=2^36 |
|---:|---:|---:|---:|---:|---:|---:|
| 10^15 | 50 | 28 | 989000000000 | 116415 | 29103 | 7275 |
| 2*10^15 | 51 | 56 | 494500000000 | 232830 | 58207 | 14551 |
| 5*10^15 | 53 | 142 | 197800000000 | 582076 | 145519 | 36379 |
| 10^16 | 54 | 284 | 98900000000 | 1164153 | 291038 | 72759 |
| 2*10^16 | 55 | 568 | 49450000000 | 2328306 | 582076 | 145519 |
| 5*10^16 | 56 | 1421 | 19780000000 | 5820766 | 1455191 | 363797 |
| 10^17 | 57 | 2842 | 9890000000 | 11641532 | 2910383 | 727595 |
| 5*10^17 | 59 | 14210 | 1978000000 | 58207660 | 14551915 | 3637978 |
| 10^18 | 60 | 28421 | 989000000 | 116415321 | 29103830 | 7275957 |
| 4*10^18 | 62 | 113686 | 247250000 | 465661287 | 116415321 | 29103830 |

For example, at B=10^15 the same-F necessary count is 1003895379523, rather than the all-format 989000000000. At B=4*10^18 these counts are 247251821 and 247250000. The first loss comes from lattice spacing alone, before failed searches or positive deficits. H=28 also makes a fixed deficit allowance a substantial fraction of the available advance; extrapolating the old H=113686 behavior to this regime is unjustified.

The source maxima U are 8590983167, 34360786943 and 137440002047. Their raw odd-bit capacities are 536936448, 2147549184 and 8590000128 bytes. Those are data capacities, not proof sizes or source-sieve operation counts. Source proof, source completeness if used by a sieve, decoding, persistence and repeated checking must be priced separately.

For every listed B,L, U^2>B. Consequently n-1 for an anchor n<=B-1 has at most one prime factor q>U. If it exists then q>sqrt(n); a certified exact-order-q root suffices for n, but q itself needs a prime proof. Since n is odd and q is odd, q< n/2. Repeating this argument gives at most ceil(log2((B-1)/U)) above-U edges in such a support chain, provided all needed smaller factors have actual proofs. At B=10^15 these coarse bounds are 17,15,13; at B=4*10^18 they are 29,27,25. They bound chain depth, not factorization cost, the number of distinct support nodes, or cache availability.

A retained source table may omit a needed prime, and a previously checked but discarded chunk is not a constant-cost persistent proof lookup. Charge every missing factor proof, its factor discovery, and any re-import. A certified complete factor cache through U is a separate optional design. Its cost cannot be inferred from U^2>B. Sharing a real support DAG can reduce repeated checks, but the distinct nodes and references must be counted.

## 3. Nonoverlapping cost ledger

For each proof system separately, maintain generation G and formal production/checking V columns. Keep serialized bytes and peak memory as further constraints, not interchangeable units. Define the following totals for each candidate B,L, anchor policy pi, ladder policy lambda and arithmetic backend.

| Component | Generation | Formal checking and required proof production |
|---|---|---|
| Source sieve | S_G: base-list construction, markings or positive witnesses, encoding | S_V: base prime proofs, sound sieve/bit interpretation, complete-base condition when consumed |
| Factor cache | F_G: discovery and retained cache construction | F_V: support prime DAG proofs, exact lookup/ownership, rechecks; only actual retained facts receive reuse credit |
| Binary initial range | I_G | I_V: all even targets below 2L, without duplicating already charged source facts |
| Anchors | A_G: candidate search, failures, factorization, root discovery, complement trees and CRT if used | A_V: actual bounds, selected factored F, direct-order/unit or guarded cyclotomic checks, support nodes not already in F_V |
| Coverage | C_G: anchor selection, residual search, packing and exceptions | C_V: all source reads, complete residual partition, word/packed arithmetic, exception equations and unshared exception prime proofs |
| Ladder | D_G: all candidate attempts, deficits, fallback factoring, roots and any CRT | D_V: exact primality certificates, record partition, adjacent gaps and terminal coverage |
| Assembly | J_G: serialization and proof generation not above | J_V: parsing, imports, shared-fact retention, complete binary/ladder joins and final theorem composition |

The total is common analytic/library work + new library work + the sum of all columns. A changed analytic threshold or proof architecture changes the common term too. Each independent replay is charged in its relevant V or J entry. A verifier whose arithmetic is justified by explicit multiplication/division witnesses must charge those witnesses, their production and the proof-library implementation. A native modular operation is not an ordinary MM0 proof step by default.

For anchors, retain a histogram by actual modulus bit length, certificate format and factor support. For a prime-power component q^e, binary powering costs P(q^(e-1))+P(q), where P(d)=floor(log2 d)+popcount(d)-1 and P(1)=0. The alternative repeated schedule costs e*P(q). Across components, the first schedule uses at most 2 floor(log2 F) products, plus k aggregate-unit products when k unit components are present. The new format omits the verifier's a^((n-1)/F), not its producer's witness construction. Largest-factor, common-root, grouped-root and cyclotomic formats have different costs and payloads; select by their proved schedules, not by an assumed multiplier on the old full Lucas benchmark. The q-not-dividing-n gate remains required for an isolated cyclotomic component.

All ladder primes remain below T<2^90 even when B shrinks, so their largest bit width does not shrink with the binary anchors. A direct supplied-root F=2^45 ladder check costs 44 modular squares per prime before bounds/encoding/assembly. A batch of n roots costs 44 squares at up to 90n bits plus its exact product. Under an illustrative w^a modular-square cost, the batch/direct ratio is n^(a-1), before production and other checks. Fewer operations at larger widths are not automatically cheaper.

## 4. Operational comparison and break-even boundaries

First reject any candidate without a sound complete coverage/checker plan, domain-valid primality formats, or an explicit strategy for unfilled search obligations. Successful searches are not assumed. Then populate the disjoint ledger from exact operation schedules or clearly labeled scenarios. Let Binary(B,L) comprise S,F,I,A,C and the binary share of J. Let Ladder(B) comprise D and its share of J. A smaller bound B1 beats B0 exactly when

    Ladder(B1)-Ladder(B0) < Binary(B0,L0)-Binary(B1,L1).

This rule works with nonlinear costs, changing factor-cache scope and real fallback data. Unknown costs remain variables; a necessary rung count alone is not a predicted Ladder value.

For a local illustrative model, put alpha=A_G+A_V per outer block, beta=C_G+C_V per outer target, and setup S+F+I+J. Then

    Binary = setup + alpha*floor(B/(2L)) + beta*(B/2-L+1).

Alpha includes the actual number of searched and certified anchors per block. It is not a fixed 512-anchor guarantee. Beta depends on selected spans, residual density, exception work and backend. Both depend on anchor/source bit widths and can change with B or L.

Within a fixed regime, ignoring only the block floor, write Binary=H_L+a_L B with a_L=(beta+alpha/L)/2. If a completed same-F scenario has mean deficit dbar, its transition mean is F(H-dbar). Define kappa=F(H-dbar)/(B-2). The approximation Ladder=c*T/(kappa*B) uses complete mean generation/checking/assembly cost c per rung. It is a scenario to test, not an availability theorem. Mixed formats require a weighted gap/cost calculation or direct record totals.

With fixed a,c,kappa, the continuous minimizer satisfies

    B_*^2 = c*T/(kappa*a).

For two cutoffs B_small<B_large, the larger wins exactly when c/a > kappa*B_small*B_large/T in this model. At kappa=1 the exact rational thresholds are stored in the receipt. Examples are 10^31/T for 10^15 versus 10^16; 2*10^32/T for 10^16 versus 2*10^16; and 8*10^34/T for 2*10^16 versus 4*10^18. These are ratios of cost coefficients, not times. Different kappas instead give

    a*(B_large-B_small) < c*T*(1/(kappa_small*B_small)-1/(kappa_large*B_large)).

If c also changes, keep its two separate values. In particular, failed searches can raise c when H becomes small even while a narrower root reduces checking cost.

Suppose a new anchor format multiplies alpha by r_A and a new ladder format multiplies c by r_D, with all other local parameters fixed. Then

    B_new/B_old = sqrt(r_D*(beta+alpha/L)/(beta+r_A*alpha/L)).

This exposes the competing effects. If only anchors get cheaper, B_* rises. If only the ladder gets cheaper, B_* falls. Coverage-dominated regimes barely respond to anchor improvements. This formula is not valid across changed source or fallback regimes without restoring those terms.

At fixed B, ladder costs cancel between L choices. L1>L0 wins precisely when its change in source/cache/initial/assembly costs plus its actual coverage change is less than the saved anchor cost. With common alpha,beta this becomes

    Delta(setup)-beta*(L1-L0) < alpha*(R(B,L0)-R(B,L1)).

The receipt supplies the exact R differences. Moving L from 2^32 to 2^34 removes about three quarters of the outer blocks but quadruples raw source capacity; moving to 2^36 repeats that trade. Direct-order anchor improvements reduce the benefit on the right side. Better retention or cheaper source proof reduces the left side. Both effects must be measured separately.

## 5. Exact cutoff pruning for a fixed lattice

There is a useful discrete optimization before any cost fitting. Fix F and O, restrict to chains on this one lattice after p0=3, and define

    h=floor((B-2)/F), f=floor(B/F), k=ceil((O-B-1)/F).

For fixed h,f,k, the admissible first indices, subsequent index increments, and terminal index are identical. Therefore the set of accepted prime chains is identical. The integer cell is the intersection

    hF+2 <= B <= (h+1)F+1,
    fF <= B <= (f+1)F-1,
    O-1-kF <= B <= O-2-(k-1)F.

Intersect this with even B and the chosen search range. Under a fixed truncatable binary architecture whose cost is nondecreasing in B, only the least even B in each nonempty cell need be considered. Any larger member has no ladder feasibility advantage and permits the same certificates, so it cannot improve the optimum. This is not a claim about measured nonmonotone caching or search heuristics. The receipt checks both endpoints for every tabulated B.

For a finite portfolio of F tags, refine by all corresponding floor/ceiling gates. Arbitrary-prime fallback can change its admitted candidates at every even B, so this coarse pruning no longer follows for that component. Also preserve anchor bit-length and backend thresholds when fitting costs. The fixed-F cells and exact block-count thresholds prevent a smooth square-root model from hiding substantial rounding losses at small B.

## 6. Small future measurements that resolve the unknowns

No experiment is authorized by this note. The following are the smallest useful *types* of future evidence; none proves full-range search success.

| Unknown | Bounded evidence needed | What it would resolve |
|---|---|---|
| Source/cache versus L | One complete certified source segment with its base-prime proof, retained lookups and proof bytes; record algorithmic operation counts as well as timings | Marginal S_G,S_V,F_V, without calling a positive-only bitmap a complete cache |
| Direct-order anchors | One shared anchor/support cohort at each relevant bit-width regime, same values checked by competing formats; include failed search/factoring and actual reuse | A_G and A_V, support-DAG savings and root payload, without transporting the old full-Lucas rate |
| Coverage/span choice | One complete block or bounded complete tiles with residual histograms, exceptional witnesses and all source accesses | C_G,C_V and whether narrower selected spans repay extra anchor search |
| Adaptive ladder | A bounded contiguous segment with every attempted candidate, actual deficits, failures, fallback proofs and root generation counted | Joint gap/cost distribution and its dependence on H; never a uniform global success guarantee |
| Direct versus batch ladder | The same certified candidates, including CRT/product generation and all proof bytes, at two batch sizes | Whether wide arithmetic outweighs reduced dispatch/operation counts |
| Assembly | One complete multi-block shard imported and joined, with immutable shared facts retained under the intended backend | J and repeated-proof/import costs that isolated arithmetic omits |

Use interval-valued coefficients if these observations are uncertain. Candidate A robustly beats B only if A's complete upper cost bound is below B's complete lower bound under the same obligations. Otherwise report the switching inequality and the missing statistic. Source-prime soundness, complete residual coverage, factor-prime provenance and a complete ladder remain mandatory regardless of the cost comparison.

## Pins and reproducibility

The companion `binary_adaptive_joint_metadata_20261111.py` computes only exact integer geometry, rational switching thresholds and hashes. Its JSON pins the adaptive-chain author, reviewed direct-order anchor note and review, residual-coverage design and earlier joint frontier. The adaptive author pin is `77ADA365011EA6069D3D2F8131950AD65ECAD285400BBD5C307C7444F0093785`; the direct-order author/review pins are `98DE51CD347FE90B51E70F946E1A5AAD8FF367C26CFF933EEC5E6A655E3AF959` and `360503B0FF3AB98EC473D5D64822FDDFB6FD94AF95A037F88595146BF2510EF4`.

The actual prime criterion remains `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean:38`, pinned by the adaptive report. The new generalized binary/ladder assembly and chosen arithmetic checker still require implementation and formal verification. Historical forecast headlines and the old 55.078 ms full-Lucas experiment do not calibrate this new end-to-end design. No final runtime estimate or full proof closure is asserted here.
