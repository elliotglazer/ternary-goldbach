# Finite Goldbach coverage: choose the range and chain together

2026-11-11. Source reading, symbolic proofs and integer metadata only. No prime search, primality test, sieve, analytic evaluation, transform, proof build or benchmark was run. The scalar script also checks finite geometry on synthetic odd integer labels; those labels are not asserted to be primes.

The strongest current opportunity is a joint choice of binary cutoff and adaptive mixed prime chain, with reusable candidate certificates and nested binary prefixes. This can reduce an entire coverage workload rather than just its local arithmetic. It is conditional on actual complete certificates and complete producer/checker costs. No particular B is selected here.

The new concrete contribution is a certificate-pool admission rule and refinement plan. It separates discovering primes from choosing the final path, exposes the exact smallest binary cutoff supported by a supplied pool, and avoids paying for repeated successful prime certification when comparing or refining chains. It also identifies where apparently stronger sharing proposals need unsupported prime-pattern assumptions.

## 1. Keep the theorem objective explicit

Use the accepted source-level candidate N0=989*10^24 and T=N0-1, the last odd target below it. The large-number proof and its QRH/finite-spectrum/formalization obligations remain unchanged. The N0 wrapper itself is not claimed implemented by this report.

The actual source `Statement.lean:64` defines `BinaryGoldbachInput` as binary Goldbach through4*10^18. `Helfgott/SmallCases.lean:21` consumes that input and the fixed ladder to prove `ternaryGoldbachUpTo_1e27`. Its first branch uses prime3; the other branch chooses p in[n-B,n-4]. These are the exact mathematical interfaces being generalized in the research designs.

There are different cost objectives:

* If `BinaryGoldbachInput` remains a permitted hypothesis, no binary computation is required. A smaller B gives no binary production saving in that objective. The existing larger-B ladder and its shorter N0 prefix remain important comparators.
* If the task is a fully proved ternary result, a new finite reduction can consume a proved `BinaryGoldbachUpTo B` at a smaller B. This does not change the original definition or assert binary Goldbach beyond B.
* If proving `BinaryGoldbachInput` itself is required, proving only a smaller binary prefix does not meet that request. Its missing interval cannot be counted as a saving.

The rest of this report concerns the second objective. It never widens the original theorem's hypotheses or treats a smaller binary theorem as proof of the larger one.

## 2. Exact geometry sets the scale of the tradeoff

For even B>=4, a prime p covers odd targets in[p+4,p+B]. A strictly increasing list of certified odd primes

    p0=3 < p1 < ... < pK <=T-4,
    p_(i+1)-p_i<=B-2,       pK+B>=T                 (1)

therefore covers every odd target7<=n<=T, with even remainder in[4,B]. The upper bound T-4 loses no useful terminal prime; primes larger than this cannot represent T with a remainder>=4. This is the accepted adaptive-chain contract, with the threshold updated to N0.

Every such list requires at least

    Kmin(B)=max(0,ceil((T-B-3)/(B-2)))              (2)

new primes after3. This follows from pK<=3+K(B-2) and pK>=T-B. It is a lower bound. There is no claim that primes with near-maximal allowed gaps can always be found.

| B | Kmin(B) | 90-bit root-field reserve at Kmin, bytes |
|---:|---:|---:|
|10^15|989000000000|11126250000000|
|2*10^15|494500000000|5563125000000|
|10^16|98900000000|1112625000000|
|2*10^16|49450000000|556312500000|
|10^17|9890000000|111262500000|
|2*10^17|4945000000|55631250000|
|4*10^18|247250000|2781562500|

The byte column is ceil(90*Kmin/8), a fixed-field layout scenario only. It is neither a byte lower bound nor a compressibility claim. It excludes positions, tags, arithmetic proofs and multiple smooth-factor root coordinates. The actual K can be larger. An indexed-small-base format is a competing design when root I/O dominates.

For an actual path, put d_i=(B-2)-(p_i-p_(i-1))>=0. Its exact progress is

    pK-3=K(B-2)-sum d_i.                           (3)

Thus mean deficit, fallback placement and successful-prime production matter directly. A claim of K approximately N0/B needs either a proved supply theorem or actual path data. On a same-F lattice the maximum index jump is floor((B-2)/F); its unavoidable remainder loss is already present even before failed candidate tests.

The old fixed ladder restricted to N0 requires maximum index251837287, versus the optimistic247250000 in the last row. Adaptive geometry alone therefore cannot promise an order-of-magnitude reduction of that existing larger-B chain. Its possible major value is making a much smaller binary cutoff affordable without imposing a wide fixed search-window loss on every step.

## 3. A reusable pool supports an exact cutoff decision

Suppose a finite pool of actual certified primes is sorted as

    3=q0<q1<...<qM<=T-4.

Define

    Bpool=max(4, T-qM, max_(i=1..M)(q_i-q_(i-1)+2)). (4)

All terms are even. The pool supports a path satisfying(1) if and only if B>=Bpool.

Sufficiency uses the whole pool. For necessity, the terminal condition requires T-qM<=B. If a consecutive pool gap q_i-q_(i-1)>B-2 occurs, every path reaching q_i or later must cross that gap with a step at least as large. A path stopping before it cannot already cover T: because q_i<=T-4, such early coverage would imply q_i-q_(i-1)<=B-4, a contradiction. Hence no subset path avoids the obstruction. This also handles a pool consisting only of3.

Equation(4) is a useful exact admission test. It does not assert that a search will produce a sufficiently rich pool. A pool with only proposed primality witnesses becomes a certified pool only after their actual acceptance; a native probable-prime result does not meet this premise.

For a fixed admitted B, repeatedly choosing the farthest available q<=p+B-2 gives a minimum-number path within this fixed pool. Inductively its reached prime after j steps is at least that of any competing j-step path. If a competing next endpoint is already behind the greedy position, no extra advance is needed; otherwise it is within the greedy position's allowed window and no farther than the greedy next choice. Reaching a farther point never worsens the terminal condition.

Minimum number is not always minimum complete cost. For independently checked direct-root certificates with additive nonnegative node costs w_j, use the acyclic graph of edges i<j with q_j-q_i<=B-2:

    cost[j]=w_j+min cost[i] over permitted predecessors,

then minimize over terminal nodes. A sliding range-minimum data structure can reduce naive quadratic search, but its generation/selection cost remains real. No proof of this optimizer's optimality is needed by the final Goldbach checker: it verifies only the selected actual primes, every gap and the terminal condition. Common-product batches introduce nonadditive costs and require batch-aware selection or a conservative additive direct-root comparison. This report does not incorrectly assign their cost independently per prime.

### Refinement without recertifying every old prime

If a coarse pool supports Bhigh, test(4) at Blow. Search only inside pool gaps that violate Blow-2 and beyond the last point if its terminal deficit violates Blow. Preserve previous successful certificates and add new ones. A gap of length g needs at least ceil(g/(Blow-2))-1 inserted points when its endpoints are retained. The terminal extension needs at least

    max(0,ceil((T-Blow-qM)/(Blow-2)))

new points. These remain necessary geometric counts, not existence or upper-work bounds. Every incomplete gap stays explicitly unresolved.

New prime witnesses can be proposed by Proth, a smooth-F lane or a general-primality fallback. The final selected path need not serialize unused successful candidates. Their discovery and any checking already performed are still producer costs. Failed searches cannot disappear from the account merely because they are absent from the final certificate.

Likewise, a chunked binary certificate can expose genuine nested range theorems and a restricted last chunk. Different B comparisons can reuse their common certified prefix. Checking only a smaller conclusion from an import that computes the entire larger range saves no work. Previously generated larger prefixes are sunk producer work; retrospective selection does not refund them. The benefit is avoiding duplicate work and allowing a future bounded decision before committing to a full larger run.

## 4. Symbolic break-even tests at N0

For each system S separately, price the complete candidate as

    C_S(B)=source_S(B,L)+initial_S(L)+anchors_S(B,L)
           +coverage_S(B,L,actual residuals)
           +chain_generation_S(actual pool/search)
           +selected_chain_check_S(actual path/formats)
           +library/import/range/I/O costs.                (5)

Some source terms depend primarily on L rather than B; do not multiply them by B automatically. General anchor primality, ladder order certificates and word coverage have different costs. Ordinary PA proof production, ordinary MM0 checking and Lean elaboration/kernel reduction are separate components; a native array or modular operation is not a shared unit cost.

To screen, define W(B)=ceil((B/2-1)/64), the number of 64-bit target words in the entire binary prefix, including the initial range. In the explicitly ideal sensitivity model

    C(B)=W(B)c_word+Kmin(B)c_rung+constant,

a smaller Blo beats Bhi precisely when

    c_rung/c_word < [W(Bhi)-W(Blo)]/[Kmin(Blo)-Kmin(Bhi)]. (6)

Here c_word must pay complete average coverage work per target word, not one Boolean instruction, and c_rung must pay search, witnesses, checking and data handling. Formula(6) assumes ideal path lengths and constant costs. It is not a sufficient criterion for actual data. Replace both K and the remaining terms by actual complete costs before making a choice.

| Blo | Bhi | Exact ratio in(6) lies between |
|---:|---:|---:|
|10^15|2*10^15|15 and16|
|2*10^15|10^16|157 and158|
|10^16|2*10^16|1579 and1580|
|2*10^16|10^17|15798 and15799|
|10^17|2*10^17|157987 and157988|
|2*10^17|4*10^18|6319514 and6319515|

For the useful10^16 versus2*10^16 comparison, the ideal saving is78125000000000 target words and the ideal extra chain length is49450000000 rungs. For10^15 versus2*10^15, the much smaller ratio warns that driving B down indefinitely will eventually lose unless rung cost also falls. The script stores the exact ratios. No measured producer/checker rate has been inserted.

The more general exact decision between two supplied designs is simply

    saved complete binary cost
      > extra complete chain cost + other net setup/I/O cost. (7)

This retains changes in deficit distributions, fallback work, source L, proof context and payload. One may also compare a uniform prime-interval theorem replacing the chain: its extra principal certification, analytic formalization and range assembly must be less than the avoided complete chain cost at the same B, or include the actual binary-cost difference at different B. The historical spectral and ladder rates are not interchangeable proof measurements. This report adds no height or core-hour estimate.

## 5. What the accepted arithmetic changes do and do not remove

The existing `Ladder/Spec.lean:38` proves the power-of-two order criterion used by direct or product-modulus supplied roots. At N0, F=2^45 still satisfies N0<F^2. A direct Proth-order witness costs44 checked modular squares, together with exact candidate bounds and factor binding. This removes high-level index progression from primality acceptance, not root discovery or the need for a successful candidate. Product-modulus batches save the number of square calls but increase their widths and require CRT production; fewer wide calls are not automatically less total work.

The accepted sum-only cyclotomic route has a stronger mathematical role than shaving a few multiplies: it makes the six smooth-F search lanes available without depending on arbitrary factorization of each successful p-1. The m160 lane has33 squares and22 other products with11 supplied roots; the other accepted lane schedules are comparable. Every odd-q nondivisibility guard, prime-power exponent and root certificate remains. This is a useful fallback *candidate*, not evidence of a bounded failure rate. Retain only the successful chosen lane in a final per-prime certificate, while charging all unsuccessful searches and root attempts in production. Multiple root coordinates can dominate I/O.

The binary source-sieve, residual coverage and NTT work remain necessary at their respective boundaries. At B=10^16 and L=2^32,2^34,2^36, the planning512-anchor pools contain596046336,149011456,37252608 records, while the ideal ladder already has98900000000 rungs. Thus anchor work matches ladder work only if its per-record cost is roughly166,664,2655 times the ladder per-record cost, respectively. These are planning comparisons, not bounds on actual anchors or their cost. Increasing L by16 reduces nominal anchors by about16, but leaves essentially the same total target words and increases the source table by about16.

For W=2^18,D=2^19, complete NTT sharing leaves about22020097 modular products and44040192 modular additions per cell even in the asymptotic one-transform limit. It cannot remove the new coefficient transform for every distinct checked pair. The broad shared-grid bound must still be compared with actual sparse residual word updates and narrow-span alternatives. A complete ordinary-PA acceptance path is required for each. Treating the new NTT sharing as zero per-cell coverage work would distort(5).

## 6. A tempting stronger reuse needs new evidence

Could one prove a few source-mask covers once and reuse them across many binary outer blocks? A fixed offset template S proves source coverage independently of r, but block r may consume it only when every anchor 2rL-(2s+1), s in S, is genuinely prime. No accepted report supplies this prime-pattern condition across many blocks.

A deletion-resilient variant also has a precise obstacle. For a fixed candidate offset pool of size M, let H_t be the offsets whose source bits are prime at target t. To guarantee a hit for *every* possible retained p-element anchor subset, it is necessary and sufficient that |H_t|>M-p for every t. Otherwise choose a retained subset inside the complement. This is much stronger than knowing the number of retained prime anchors or a source density. One can instead certify a restricted menu of actual subsets, but generating that menu, all actual matches and all residual fallbacks remains work. Neither reuse idea receives a cost saving in this report.

This contrasts with exact NTT input reuse, whose array-equality premise is already explicit. It also prevents assuming that512 anchors, a narrow span, or a common template always covers a block.

## 7. Prioritized next obligations

1. Establish a bounded complete end-to-end comparison on the same actual admissible prime-chain and binary inputs, before selecting B. It must report unsuccessful candidate/root attempts, actual path deficits, successful formats, producer time/work, serialization, and separate Lean and ordinary-MM0 acceptance costs. The current research authorizes no run. A complete small segment does not prove a whole-range success rate.
2. Implement the generic pool/path and nested-prefix acceptance interfaces. The checker needs only actual selected prime certificates, monotone endpoint reconstruction, every gap, prefix coverage and the final join at T. It need not verify a producer's optimizer or CRT construction. Preserve all unresolved gaps and residual bits on failure.
3. Compare direct Proth roots, compact small-base groups and retained-component smooth fallback using their actual widths and payloads. General-prime fallback remains available but cannot be assigned the success frequency or cost of a smooth lane. This makes lower B plausible without asserting it achievable.
4. For the binary side, first determine the actual complete residual cost per target word, including source provenance and exceptions. Then choose L and a proved residual backend. Enlarging L or choosing NTT before this measurement can optimize a non-dominant component.
5. Consider removing the explicit chain by a prime-interval theorem only after its full incremental spectral/analytic cost passes(7). A smaller quoted RH height alone does not decide it, and none of the nonprincipal obligations disappears.

The controlling unknown is now explicit: the complete cost of an admitted mixed chain and a complete binary prefix, at compatible B values. The most promising substantial reduction is reducing the binary range enough that those two bills balance, using adaptive paths and reusable production. It is not a proved optimum or an assumed successful ladder.

## 8. Pins and bounded checks

The script `finite_cover_frontier_20261111.py` has SHA256 `442F8F28378576DF95CD051ED130ACFCA83366F0C726FEE8EE634DF282FD2CE4`; its receipt has SHA256 `22AF246A4D7764EC9C35D22D62E4FC8E4B103900713092FAEDAEF655426384CC`. It computes seven N0 geometry rows,21 binary block geometries, six exact sensitivity ratios, and3584 synthetic odd-label pool/greedy checks. No labels in that final test are claimed prime. The universal arguments above, rather than those finite examples, establish the proposed geometry lemmas.

Relevant frozen inputs, paths relative to work unless otherwise specified:

| Input | SHA256 |
|---|---|
| qrh-blueprint/THRESHOLD_AND_LADDER_REPLACEMENT_RECONCILIATION_2026-11-11.md | D6A48DCEE1AFB8B2F00145A814CA49BD2728A77E64DA6DF1500AE6ED7EA0E673 |
| qrh-blueprint/BINARY_BLOCK_SCALING_2026-11-11.md | 982115AD458F718039B391DAEA714E25C5E80823C49B537ED78FEC8F155480CD |
| agents/major-constants/EFFICIENCY_ADAPTIVE_PRIME_CHAIN_2026-11-11.md, under qrh-campaign | 77ADA365011EA6069D3D2F8131950AD65ECAD285400BBD5C307C7444F0093785 |
| qrh-blueprint/CYCLOTOMIC_SUM_ONLY_CERTIFICATES_2026-11-11.md | 1289E9B4DFBB20B3FC84BB85CD35A676227DDFBFC4A3266A6FAB4A6CC3C27927 |
| agents/moebius/REVIEW_CYCLOTOMIC_SUM_ONLY_CERTIFICATES_2026-11-11.md, under qrh-campaign | E47FE2FDD2651772B7448FA9E3C05460DE3C8939787FE653CE1F43F576D3D074 |
| agents/prime-estimates/SUPPLIED_ROOT_PRODUCTION_PAYLOAD_2026-11-11.md, under qrh-campaign | EA13551BB8A8C572F983A26EC57E4F3FCD3E658F86DCE8252BABF70002814044 |
| agents/moebius/EFFICIENCY_BINARY_COVERAGE_2026-11-11.md, under qrh-campaign | EEED5871CE2A7737F01D92CDBC0D362BA42307FF58D0A1192892989C4FBF8436 |
| agents/prime-estimates/EFFICIENCY_NTT_GRID_REUSE_2026-11-11.md, under qrh-campaign | 84F02A3867A371313E81CC89664293986C52EC515EED2B2046BFCB0D94097738 |
| agents/moebius/REVIEW_EFFICIENCY_NTT_GRID_REUSE_2026-11-11.md, under qrh-campaign | 7301FB9AEBEF376903826333A559ABCF7195801F505E2ED191ADC6A5D2C24779 |
| ternary-goldbach/TernaryGoldbach/Statement.lean | 3F61837D2C3A0DDE3A1997F05AF21C20C7FE6EE13E29891125495F6947596BF8 |
| ternary-goldbach/TernaryGoldbach/Helfgott/SmallCases.lean | 61B94AFA308E82B7C8D9DA927CE5EB18F8847F9D58554589E4A28F5A2B7BF359 |
| ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean | 0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F |

The old threshold reconciliation contains historical pending candidates. This report consumes its accepted N0 geometry only, not a claim that every historical optional spectral route has since closed. No new kernel theorem, source declaration or allowed premise is introduced.
