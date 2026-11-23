# Review of the finite Goldbach global cost frontier

2026-11-11. **PASS at mathematical geometry and symbolic-cost scope, with no correction requested.** The cutoff admission equivalence is exact for the specified fixed pool; the greedy rule minimizes its selected prime count. Neither result proves a globally cheapest design or supplies missing primes. No prime search, primality evaluation, analytic evaluation or build was performed.

## Frozen inputs and checks

Author: `prime-estimates/FINITE_GOLDBACH_GLOBAL_COST_FRONTIER_2026-11-11.md`, SHA256 `F950F36C3361A4BABB253B502168B613893DB5DCD002599A7BC261A950A16FC6`.

Author script `finite_cover_frontier_20261111.py`: `442F8F28378576DF95CD051ED130ACFCA83366F0C726FEE8EE634DF282FD2CE4`. Author receipt: `22AF246A4D7764EC9C35D22D62E4FC8E4B103900713092FAEDAEF655426384CC`.

I read the complete note and script, directly checked `TernaryGoldbach/Statement.lean`, `Helfgott/SmallCases.lean` and the order criterion in `Ladder/Spec.lean`, and checked the cited threshold, cyclotomic and NTT count passages. All twelve source/support pins in the author table match. Those pins are retained in the independent receipt.

Independent script `independent-feasibility/review_finite_goldbach_frontier_20261111.py`: `E4096FE0B56CCE911692C1B5585AA5FFDAEBA8E8544CE69709335F0AC6828775`.

Independent receipt `independent-feasibility/review_finite_goldbach_frontier_20261111.json`: `82EA85D391347CFB8A42A4545B9033B8AF94DB27F0DF76A2F60079E8648B5D79`.

The independent run passed 9,420 exact checks. It verifies seven large-integer geometry rows, all 21 block rows and six rational tradeoffs. For 2,304 synthetic pool/cutoff cases, it enumerates every subset path and compares direct target coverage, admission, greedy length and weighted dynamic programming. The labels are not claimed prime. These finite examples test the implementation of the formulas; the following arguments establish their general validity.

## Coverage and exact admission

The source binary predicate covers every even integer from 4 through B, inclusively. For an odd prime p and odd target n, p+4<=n<=p+B therefore gives a valid binary remainder. Consecutive intervals leave no missing odd integer precisely when the next prime is at most p+B-2: the next allowed target after p+B is p+B+2. This explains the essential minus two, rather than a continuous-interval overlap requirement.

Starting at p0=3 covers target 7. Ending with pK+B>=T covers the largest target T=989*10^24-1. Restricting candidates to q<=T-4 loses nothing for this finite target range, since larger q cannot contribute even the minimum remainder. The transition to the large-number theorem still needs its accepted N0 wrapper; this review supplies no new large-range theorem.

For a finite sorted pool starting at 3 and ending at qM<=T-4, let Bpool be the maximum of 4, T-qM and every consecutive gap plus two. For the singleton pool the gap collection is empty, so this means max(4,T-3), with no undefined empty maximum. Every term is even. If B>=Bpool the full pool is a valid chain. Conversely, a valid chain forces the terminal inequality. Any consecutive pool gap greater than B-2 blocks all paths crossing it. A path stopping below that gap also fails: if its endpoint covered T, then q_i<=T-4 would force the obstructing gap to be at most B-4. Thus the admission equivalence is genuine, including terminal and singleton cases.

The geometric bound K>=max(0,ceil((T-B-3)/(B-2))) follows by comparing pK<=3+K(B-2) with pK>=T-B. It is only a lower bound on successful prime chains. The deficit identity is exact. Inserting points while retaining a gap's endpoints needs at least ceil(g/(B-2))-1 points; the terminal extension formula is likewise a necessary progress bound, not a search guarantee.

## Selection and optimality limits

Farthest-reachable greedy is valid for uniform maximum step and terminal threshold in this sorted pool. After j steps it reaches at least as far as any competing j-step path, allowing a stopped or already overtaken path to remain in place for the comparison. A farther point cannot make a later forward target unreachable if it was reachable from the smaller one. Hence greedy reaches the terminal condition with minimum selected count.

For additive nonnegative node costs, initialize cost[0]=0, use infinity for unreachable states, and take the stated minimum over earlier admissible predecessors. Every increasing path ends in exactly one such edge, giving the recurrence by induction. Minimize over all terminal nodes, including node zero when it already suffices. This minimizes the supplied additive cost only. It does not handle shared batch costs, globally cached proofs, candidate-discovery costs or different prime pools without enlarging the optimization state. The final correctness checker needs no optimizer proof: certified selected primes and verified endpoints suffice.

Reusing successful certificates can avoid duplicate future checking, but it does not refund their discovery or sunk certification cost. Unused or failed candidates do not become free because they disappear from the selected path. The author consistently preserves these distinctions.

## Cost arithmetic and useful decision rule

The seven Kmin values, fixed 90-bit reserve scenarios and target-word counts agree. In particular B=10^16 versus 2*10^16 changes ideal length by 49,450,000,000 and binary words by 78,125,000,000,000, giving exact ratio 1,562,500/989, strictly between 1,579 and 1,580. The block formula includes the initial range and the inclusive last block; it neither drops the terminal target nor double-counts its boundary. The 512-anchor counts remain a planning assumption, not a coverage theorem.

The break-even inequality follows by subtracting the two explicitly ideal linear cost models, assuming positive word cost. Its application to an actual design requires actual selected lengths and complete costs. It is not a sufficient test when both Kmin lower bounds are substituted for unknown chain lengths. The final more general comparison—complete binary saving against extra complete chain and setup/I/O cost—is the defensible decision rule.

The direct 44-square criterion remains a source-supported primality acceptance mechanism for eligible odd candidates below its size bound; it does not generate their roots or guarantee suitable candidates. The smooth-lane and NTT counts are cited as their specific accepted schedules, not universal operation lower bounds. Fixed-field reserve bytes are not information-theoretic certificate-size lower bounds.

The deletion-resilient source-mask criterion is also correct for 0<=p<=M: every retained p-subset hits H exactly when the complement has fewer than p elements. A source density or merely having p prime anchors is insufficient. Actual shared-template applicability must still be certified.

## Scope retained

The source currently defines `BinaryGoldbachInput` through 4*10^18. A proved smaller binary prefix can support a newly assembled full ternary proof, but cannot prove that larger binary input itself. Keeping the binary input as a hypothesis also changes the cost objective. The report explicitly separates these cases. No new assumption, prime availability claim, global optimum, throughput or Lean/MM0 runtime ratio is accepted here. Frozen author and source files are unchanged.
