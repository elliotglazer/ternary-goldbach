# A wheel and sparse zero-bit checker for the shared source bitmap

2026-11-11. Research design with exact scalar counts. No source sieve, prime test, analytic evaluation, Lean/MM0 build or production scan was run. The only new computation enumerated the 15015 residue classes of a fixed small wheel and evaluated integer/rational size formulas. All earlier artifacts remain unchanged.

The useful change is to check the proposed immutable source bitmap directly. For every required composite progression, check that its indicated bits are zero. The checker need not construct a mutable composite bitmap or record every clearing operation. Use a cached wheel for small divisors, cached periodic masks for moderately sized divisors, and bounded-word zero-bit checks for sparse large-divisor hits. This preserves the one-sided source-prime contract. Its advantage depends on the cost of certified word access, which remains to be measured in each acceptance system.

## 1. Exact object and surviving-prime argument

Keep the accepted geometry: J=L+2^19 source bits, bit j denotes 2j+1 for 0<=j<J, U=2J-1, Y=floor(sqrt U), and a complete recursively certified list of primes through Y. Index zero must be clear. The source bitmap need only satisfy

    B[j]=1 implies Prime(2j+1).

Extra zero bits remain permitted. Completeness of the base-prime list is still mandatory. The initial binary range below 2L, the prime 2, the endpoint of each binary block, certified anchors and the two-chunk coverage halo remain separate obligations.

Let W=3*5*7*11*13=15015. Let R[k] mean gcd(2k+1,W)=1, periodically in k. Apart from the five separately certified source positions for 3,5,7,11,13, require B to be a subset of R. These five positions may alternatively remain zero. Clear j=0 independently, since R[0]=1.

For every base prime p>13, require a zero bit at every index

    j=(p-1)/2+p*k,
    k>=(p-1)/2, j<J, gcd(2k+1,W)=1.

These are precisely the odd multiples p*(2k+1)>=p^2 whose cofactors pass the wheel. The equality 2j+1=p*(2k+1) and coprimality of p with W give

    gcd(2j+1,W)=1 iff gcd(2k+1,W)=1.

If a positive source bit represented a composite n>1, its least prime divisor p would satisfy p^2<=n<=U. Thus p is in the complete base list. A divisor among the five wheel primes contradicts the wheel condition unless n equals that prime, which is already prime. Otherwise its index occurs in the checked progression, contradicting B[j]=1. This proof requires no claim that cleared bits were actually composite, and no primality certificate for each positive source bit.

The actual source precedent is `PsiSieve3.prime_iff_PS3`, lines 113–125, using `Nat.minFac_prime`, `Nat.minFac_sq_le_self` and `Nat.minFac_dvd`. Its numerical range is specific to the old table and must be generalized; it cannot be imported unchanged for the three new U values. The corresponding cached Mathlib declarations are in `Data/Nat/Prime/Defs.lean`, lines 282,285,363. All zero, parity, p^2 and terminal-index cases belong in the generalized statement.

## 2. Cache a wheel, not every phase of every prime

One period of R occupies 1877 bytes. A template covering T+W-1 bits, T=2^18, occupies 34645 bytes. For a segment [b,b+w), w<=T, extract its wheel mask by shifting that template by b mod W and truncating to w bits. Since (b mod W)+w<=T+W-1, no missing final bit is possible. Do not allocate W separate T-bit phase masks.

The template can be constructed once from the five existing progression masks at residues (p-1)/2, then complemented within its declared bit length. `PsiSieve.lean:27–86` already defines `rep`, which doubles by shift and OR, and proves `rep_spec` and `maskP_spec`. Thus wide division is not necessary even in the baseline. The existing proof is for one residue class; the wheel interpretation follows by the five-mask union and elementary divisibility. The common period W follows because each p divides W. A reusable literal template still needs a checked equality/specification; naming a literal does not certify its bits.

Further small groups can be cached independently. For example, 17*19*23=7429 and 29*31*37=33263 give two more bounded periods. Their wheel filters replace six per-prime passes with two group passes. They need not be multiplied into one enormous wheel. This report's operation bounds conservatively do not take credit for those extra groups. Nor does it assume that their intersection reduces the sparse events by an unproved density factor.

For each medium prime 13<p<=P0, cache a template through T+p-1 bits. A scalar phase b mod p selects the segment. Apply the cutoff j>=(p^2-1)/2, then check that B AND the resulting forbidden mask is zero. Once a segment lies beyond p^2, the lower cutoff disappears. Existing `maskP` doubling supplies the template without a large quotient. Its final doubling can temporarily use fewer than 2*(T+P0) bits before truncation. Only scalar division/remainder is needed per phase. This removes repeated wide division but still performs wide arithmetic per active medium-prime/segment pair.

Sharing must be real in the chosen proof representation. `PsiSieve3.lean:129–131` says the kernel builds its patterns once per declaration. That does not promise cross-declaration memoization or repeated-expression caching. Certify literal patterns once, bind their semantics, and measure import/reduction reuse rather than assume it. This design also avoids the old `pcL` population count: source soundness needs a subset/zero-bit check, not a prime count.

## 3. Sparse large divisors: read-only acceptance

For p>P0, enumerate the allowed cofactor indices k by the cyclic wheel's sorted residues and gaps. Start at the first allowed k>=(p-1)/2; stop exactly when j>=J. Every jump must follow the proved cyclic gap table. The table must cover all wheel-unit residues, including its wraparound gap. Monotonicity alone would not prove that a generator skipped no required hit.

At each hit, check the corresponding bit of the immutable proposed B is zero. A proposed location, native clear-bit result or checksum is not sufficient. The checker either recomputes the progression or checks its complete recurrence and endpoints. This eliminates mutable sieve-state refinement from this particular acceptance algorithm, while leaving immutable indexing and progression completeness as real proof obligations.

Use 64-bit leaves rather than a single T-bit natural for sparse access. A full T-bit chunk contains 4096 words. A balanced binary tree has depth 12; a proved lookup can follow 12 branches and then perform bounded arithmetic on one word. This is a concrete representation option, not a claim that Lean `Array` lookup or an MM0 memory access already has this cost. A linked-list lookup can be linear. A `testBit` on a large natural may repeatedly reduce or shift a large operand. Both would undermine the intended sparse advantage.

Bind these leaves to the same source object used by Goldbach coverage. A later packed source chunk or dilated coverage input needs its own exact relation to these leaves. Do not silently replace the checked words with a new packed literal. Process local chunks internally rather than introducing a global theorem declaration for every word or hit.

There are two schedules with different costs:

* A simple segment-major checker visits every base prime for each chunk, but sparse primes do only scalar start tests and bounded-word checks. Its Q*P scalar setup is still charged.
* A bucketed checker carries the first unvisited hit and wheel position for each active prime, dispatching a prime only when a hit enters the current chunk. Its invariant must account for every complete-base-list prime, initial p^2 activation, bucket moves and all pending next hits. It may reduce setup to events plus prime/chunk administration, but that reduction is not available merely by changing a native loop. A persistent queue/tree adds its own certified access cost.

Neither schedule needs a stored event log if the concrete checker recomputes the exact recurrence. If events are supplied as witnesses instead, they must be checked for completeness and their bytes must be counted. Sorting a list of witnessed marks does not prove it is the same complete list without an actual permutation or generation argument.

The algorithm may select a dense or sparse proof for an individual prime/chunk pair according to a measured crossover. Both prove the same zero-bit proposition. There is no mathematical reason to force one fixed cutoff when hit count, final chunk length or p^2 activation makes the other representation cheaper.

## 4. Conservative exact work bounds, without enumerating base primes

The scalar script counts only residues coprime to the fixed W. It never classifies a number as prime. If C(n) counts wheel units among indices 0<=k<n, then

    C(qW+r)=q*5760+C(r), 0<=r<W.

Thus rho=5760/15015=384/1001. Let e(r)=C(r)-rho*r. Exact residue arithmetic gives

    max e - min e = 6718/1001.

Consequently any cofactor-index interval of length h contains at most rho*h+6718/1001 wheel units. This is an all-interval bound, not an average density assertion. The mathematical proof uses periodicity; the finite maximum remains an external exact scalar check, not a new Lean theorem.

Write P_s and P_l for the actual counts of base primes in (13,P0] and (P0,Y]. Upper bounds replace them by all odd integers coprime to W in those ranges, with 1 removed. For each dyadic bin (a,b] of the latter range, its exact wheel-unit count c gives sum(1/p)<=c/a. Let Sbar be the sum of these rational bin bounds. Ignoring the beneficial p^2 cutoff gives the valid sparse-event bound

    Z_large <= ceil(rho*J*Sbar + (rho+6718/1001)*P_l_bar).

The extra rho allows a progression interval length at most J/p+1. Repeated hits by different primes are counted separately. This is deliberately conservative; no prime number theorem or observed prime density is used.

For P0=4096, P_s<=785. Cached medium templates occupy at most 26,124,800 bytes using the common bound T+P0 bits per template. This excludes proof metadata, parsed numerals, base facts and temporaries.

| L | Chunks Q | Old all-odd dense pair bound | Medium wide-pair bound | Sparse zero-bit hit bound | 64-bit source leaves |
|---:|---:|---:|---:|---:|---:|
| 2^32 | 16,386 | 759,376,398 | 12,863,010 | 1,395,095,925 | 67,117,056 |
| 2^34 | 65,538 | 6,074,192,916 | 51,447,330 | 6,843,850,082 | 268,443,648 |
| 2^36 | 262,146 | 48,592,431,144 | 205,784,610 | 32,431,121,662 | 1,073,750,016 |

The sparse and wide columns are different operations and must not be added as if they had equal cost. The old column was already a loose upper bound; a smaller new bound is not a measured reduction from an actual old run. Even applying only the wheel to the base-count upper bound changes the all-wide pair bounds to 291,277,536, 2,330,072,514 and 18,641,202,060. That comparison helps separate improved counting bounds from a changed algorithm.

The receipt also covers P0=256 and 1024. Their medium-template storage bounds are 1,574,400 and 6,414,720 bytes. At L=2^36 their medium wide-pair bounds are 12,583,008 and 51,118,470, but sparse-hit bounds rise to 52,653,240,080 and 42,561,490,635. A larger cache trades fewer sparse hits for more repeated wide checks. These bounds do not select a winner.

The original source sizes, base completeness and square-root witnesses are unchanged. The three Y values remain 92687,185366,370729. Index arithmetic and next-hit products fit within the stated 64-bit source bounds when checked before overflow; the proof should use naturals or explicit bounded-word lemmas. No wide-mask operation can be priced as a scalar 64-bit operation.

## 5. What to measure before choosing a checker

Use the same exact source contract, complete base-list theorem, bit ordering and concrete source chunk in each implementation. Include a low chunk with wheel-prime exceptions, a chunk crossing p^2, an ordinary interior chunk, and a final partial chunk. The benchmark itself needs separate authorization; none ran here.

First compare the cached-doubling all-wide baseline with the wheel/medium/sparse read-only checker. Vary P0 over 256,1024,4096 and the source chunk length over 2^12,2^15,2^18. Test complete acceptance, including decoding, indexed-word interpretation and final assembly. Microbenchmarks of one shift or native clear-bit operation are insufficient.

For an individual pair, measure

    C_dense = phase + template extraction + cutoff + wide zero intersection,
    C_sparse = setup + number_of_hits*(checked lookup + bounded bit test).

If buckets are used, add their actual transition cost and prove their completeness. The empirical crossover C_dense>C_sparse, measured under one fixed trust boundary, determines the split. Pay one-time template proof/generation separately. With balanced word trees, measure whether repeated lookup paths share any actual work; do not assume memoization from the mathematical tree depth.

Then compare end-to-end source acceptance, including generation, certificate bytes, elaboration or proof translation, kernel checking, peak memory, loading/reuse and any source repacking needed by coverage. Preserve the root cost inequality involving saved complete anchor certificates, changed initial-range proof and changed coverage. Source certification still grows with L and is not free merely because each source chunk can be reused.

Keep three acceptance cases separate:

1. Strict Lean kernel arithmetic/reflection with proved checker semantics and a closed checked result. Record elaboration and kernel checking separately. `native_decide` is not silently substituted for that boundary.
2. Ordinary MM0/MMB proof checking with the arithmetic and indexed-memory steps expanded or shared under its actual proof language. A bit operation or tree lookup is not one free MMB inference.
3. A PA-preserving specialized checker, or a foundation-preserving Lean accelerator, with an admissibility/translation argument and a correctness proof for the exact executable. Its development and bootstrap checking are part of total production cost. An abstract correct sieve plus an unverified native run does not implement this case.

The last case may support efficient mutable word marking instead of read-only rejection. It is a separate implementation and proof obligation. The existing MM0 soundness plan documents that its proposed executable/refinement chain is unfinished. No system time ratio or runtime forecast follows from this report.

## 6. Concrete recommendation and remaining work

The next small implementation comparison should retain the source theorem and change only the finite acceptance representation: cached wheel plus medium masks versus read-only sparse zero-bit checks on indexed 64-bit words. The substantive simplification is removal of mutable composite-state certification, not removal of complete divisor coverage. Reject a prototype that hides an unproved event skip, index lookup, source repacking or repeated global proof import.

New proof work is confined to the generalized complete-base survivor theorem, wheel/template interpretation, complete wheel-gap recurrence, immutable word/chunk binding and whichever scheduler is selected. Existing periodic-mask and minimum-factor lemmas give direct source precedents. No new mathematical prime estimate or assumption is needed.

## Evidence and reproducibility

The Python scalar script ran exit 0 using `work/qrh-campaign/interval-env/Scripts/python.exe`. A separately implemented tool-side BigInt/rational calculation of the same formulas agreed before the Python run. Both implementations were written by this author; this is not an independent-agent review. Neither computation generated a source bitmap or evaluated primality. The JSON contains every dyadic reciprocal-count bin and all three cutoff alternatives.

| File | SHA256 |
|---|---|
| `work/qrh-blueprint/BINARY_BLOCK_SCALING_2026-11-11.md` | `982115AD458F718039B391DAEA714E25C5E80823C49B537ED78FEC8F155480CD` |
| `work/qrh-campaign/agents/independent-feasibility/BINARY_SOURCE_BITMAP_COST_DESIGN_2026-11-11.md` | `4B877FC2377CEB81C60CE139331ED5380AB0CB78011DE500D8768B2F837B99EA` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/PsiSieve.lean` | `B4FB6979014B6B2AD516E775A45EAD01DD544BF9828948C7F512DCDC16596652` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/PsiSieve3.lean` | `36309975B0656C69E2659A685963BD1955B24096AC99BA8A23B7193A48111ED3` |
| Cached Mathlib `Data/Nat/Prime/Defs.lean` | `BF752D4B4A5DA283E8BB1549AA67773982047EFA1C0CE478920F9CA12DB064A1` |
| `work/mm0-efficient/soundness.md` | `C967F8059920C80635238FC2955C9D4FAD55327B26B1BAB6F2746F7440661FD8` |
| `efficiency_source_sieve_sizes_20261111.py` in this directory | `0C46B460A9B3DE54126802EB03F2AA58BC2AABEA3DF462CE02B0EC28EB8A3184` |
| `efficiency_source_sieve_sizes_20261111.json` in this directory | `417FB7D5849794C97852BE6BD8C15D12E4004F1B6A198CD66C267D7513E6C3CE` |

Source references are to target Goldbach commit `23b2d68ca344203d4384e0aff7affa4ec034bef9` and the available cached Mathlib revision `56a005855ea17e0b0958f73ec801ae140b0a1679`. Reading those files does not establish a new compiled checker or an axiom audit.
