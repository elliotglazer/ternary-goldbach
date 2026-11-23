# Adaptive prime chains with supplied-root batch certificates

2026-11-11. Paper acceptance contracts and exact integer geometry only. No prime search, primality evaluation, Lean/MM0 build or certificate generation was performed. All production-success and timing claims remain open.

The earlier `FINITE_RANGE_COST_RESEARCH` proposed adaptive rungs; `EFFICIENCY_MIXED_LADDER` developed actual-index jumps inside fixed windows. This report supplies the missing complete adaptive-chain contract, its compact encoding, and a stronger batch acceptance rule identified by the coordinator during this task. The main new observation is that supplied order roots remove the index progression from primality verification entirely. Indexed small-base batches remain a useful payload alternative.

## 1. Exact coverage, independent of the prime format

Fix an even binary cutoff B>=4 and a finite odd target T>=7. Suppose binary Goldbach is proved for every even integer in [4,B]. Supply a finite strictly increasing list of odd certified primes

    p_0=3 < p_1 < ... < p_r,
    p_(i+1)-p_i <= B-2,        p_r+B>=T.             (1)

For every odd n in [7,T], there is a j with p_j+4<=n<=p_j+B. Indeed p_0 covers [7,B+3]. The next interval starts at p_(j+1)+4<=p_j+B+2, which is at most the next odd integer after the previous interval's endpoint. Induction proves coverage through p_r+B. Then n-p_j is an even number in [4,B], giving the ternary representation.

There is no fixed slot index, minimum progress hypothesis, prime-density assumption or requirement to find the largest admissible prime. The producer may seek the largest convenient certified prime <=p_i+B-2. Any increasing choice satisfying (1) is sound. If it fails to supply the next prime, the certificate is incomplete. A general-prime fallback must still satisfy the same actual gap test.

For the unchanged analytic threshold N=10^27, set T=N-1. The large-N proof covers n>=N; the chain covers the remaining odd targets. If p_i+B<T, then p_i<=T-B-2, so any next prime obeying the gap test is <=T-4. Thus a producer that stops at the first successful terminal test can keep all candidates below N automatically. The verifier nevertheless checks an explicit candidate bound p<N for the formats below. If B+3>=T, the list consists of p_0 alone.

Every complete list has at least

    max(0,ceil((T-B-3)/(B-2)))                       (2)

new primes after 3. This is a necessary count, not an attainable bound. A claimed unconditional upper count requires actual data or an additional proved availability theorem, neither supplied here.

## 2. Adaptive index and deficit encoding

For an even lattice modulus F and previous endpoint p, define

    q=floor((p+B-3)/F), l=floor((p-1)/F)+1.

A lattice candidate p'=kF+1 satisfies p<p'<=p+B-2 exactly when l<=k<=q. If q<l, this lattice has no eligible candidate. Otherwise encode a deficit d=q-k with 0<=d<q-l+1 and reconstruct k=q-d and p'=kF+1. Natural subtraction must follow the checked bound d<=q; a totalized subtraction cannot silently accept an invalid record.

For a consecutive run in one F, write

    H=floor((B-2)/F), R=B-2-HF.

Then k_next=k+H-d, 0<=d<H. Its actual gap is F(H-d), and its unused gap allowance is exactly R+Fd. For a run of s transitions,

    p_end-p_start=s*HF-F*sum d_i.                    (3)

Unlike a fixed-window stride, the unused width is charged only when the selected candidate actually incurs it. Equation (3), rather than a hypothetical mean deficit, determines the realized count.

A bounded wire format can store the first k of each same-F block in at most 45 bits for F=2^45 and p<N. Subsequent d values use b=bitlength(H-1) bits. A smaller block width b0 is allowed if every recorded d<2^b0 and b0<=b; b0=0 denotes all-zero deficits. A mixed-F record uses a checked dictionary tag and the general q,l reconstruction. An arbitrary-prime record instead gives p' directly, at most 90 bits here, plus its primality certificate. No omitted or failed search is represented as an accepted gap.

To parallelize checking, each shard binds its initial predecessor and final prime. The global join checks equality with adjacent shard endpoints, the boundary gap, and the final terminal test. All records have exact global positions; regrouping by F or arithmetic method requires a checked partition of these positions. Empty batches do no modular computation. A final short shard uses its actual length. The source list need not have a predetermined number of records, but every decoded record must be certified once and every adjacent pair must be checked.

Generation remains sequential inside a greedy chain. Parallel generation can use separately certified anchor endpoints and fill their intervening segments; anchor discovery and all anchor joins are additional producer work. A proposed anchor is not evidence that its segment can be filled.

## 3. Supplied-root Proth acceptance removes progression

For F=2^45 and D=2^44, let a nonempty batch contain the exact odd candidates p_j with

    1<p_j<N<F^2<(F+1)^2,
    M=product_j p_j.

Supply one natural X with X<M. Starting with X, perform 44 checked modular squarings and require the final residue to equal M-1. This proves

    M divides X^D+1.                                (4)

Each p_j divides M, so p_j divides X^D+1. The existing source theorem `Ladder/Spec.lean:38`, `prime_of_dvd_pow_add_one`, proves every p_j prime from exactly oddness, 1<p_j, the strict size bound and this divisibility. Its body uses a least prime factor r: the congruence gives order_r(X)=F, hence r>=F+1, contradicting r^2<=p_j for a composite candidate.

No separate gcd(X,M), offset power, k-th powering, per-factor modular reduction, fixed stride, CRT identity or pairwise-coprimality premise is needed by acceptance. In particular X=0 fails the required negative-one test because M>1. It would be unsound to replace the 44 checked squarings by an arbitrary unproved residue. Exact product construction and each factor's bounds are indispensable.

The representation p_j=k_jF+1 is convenient for search and compression, but the source criterion itself does not require that representation. A successful order-F test forces the relevant congruence of every prime factor. For production on the lattice, one may find a base a_j satisfying a_j^((p_j-1)/2)=-1 modulo p_j, put x_j=a_j^k_j modulo p_j, and CRT the x_j to X. Those per-prime powers, searches and CRT are producer work; the verifier consumes only (4). The strictly increasing global chain supplies distinct primes when the intended data are correct. Without distinctness, CRT roots modulo individual primes do not automatically lift to repeated prime powers, although an actual accepted product congruence would still be sound.

A direct supplied-root format is the n=1 version: supply x_j<p_j and check 44 squares modulo p_j. This avoids CRT generation and wide-product arithmetic while using essentially the same worst-case total root payload. It should be a primary comparator, especially for an explicit-arithmetic MM0 backend.

## 4. Indexed small-base alternative

If minimizing supplied-root payload matters, retain an actual-index batch. For a common base a or supplied X, set V=X^D mod M and U_1=V^k_1 mod M. For sorted exponents k_1<...<k_n, let g_j=k_(j+1)-k_j and update

    U_(j+1)=U_j*V^g_j mod M.

Check U_j mod p_j=p_j-1. This directly proves (X^k_j)^D=-1 modulo p_j. It again needs no separate gcd, because no offset factor is cancelled. This differs from the older U+V^t=0 test, where coprimality was essential.

Let G be the distinct positive jumps. A shared binary ladder for V reaches max(k_1,max G). With leading-one binary exponentiation, its square count is

    44+floor(log2(max(k_1,max G))) <=88,

and a sufficient other-multiplication count is

    popcount(k_1)-1
      +sum_(g in G)(popcount(g)-1)+(n-1).            (5)

The initial power and jump table share squares. Repeated jumps reuse their assembled power. Each factor also needs reduction of U_j from the product modulus. Grouping across other bases or F tags uses the actual k difference; it must not pretend the skipped gap is one transition of a fixed stride. All k_j<F under the fixed source size guard, including grouped subsequences, so the 88 bound remains valid.

One may instead use centered jumps V^H*(V^-1)^d in same-F runs. This needs a checked inverse modulo M, then its own inverse-power table and multiplication count. It is not a free signed-exponent optimization. The forward schedule above avoids that extra premise and suffices for the comparison. No particular deficit distribution is assumed.

At equal product width, the supplied-root test removes at least this progression work and its factor reductions. It adds a potentially product-sized root witness and may require CRT generation. A small common base also has cheap early powers, whereas a supplied root may be full-width from its first square.

## 5. Smooth-F portfolio and fallback

The companion `SMOOTH_FACTOR_LADDER_PORTFOLIO` uses F=m*200560490130 for m in {160,162,165,168,175,180}, with a proved factorization and F^2>N. Adaptive encoding uses the same q,l formula for each selected tag. No candidate count or density statement proves that any interval contains a suitable prime.

Its supplied-root extension is compatible with this chain. For a same-F product M, require X^(F/2)=-1 modulo M and that each X^(F/q)-1 is a unit modulo M for every odd prime q|F. Every prime divisor r of a candidate then gives an element of order exactly F in its residue field; r>=F+1 and p<(F+1)^2 prove primality. The negative-one equality supplies both the Fermat relation and the q=2 condition. No k progression is needed.

The ten odd-q unit conditions can be checked by one inverse for their product. The companion derives a tree of 128 modular squares, 46 through 50 other tree products and ten products for this aggregate unit check. All are at the actual product-modulus width. This is heavier successful-prime verification than the 44-square Proth format, and supplies both X and an inverse. Its potential benefit is additional search candidates and less general-prime factoring, not a cheaper equal-width root test. Its paper review is separate from this report.

General fallback accepts an actual primality certificate at p<p'<p+B-1 without assuming p'-1 has a chosen factorization. The exact gap and order checks are unchanged. A certificate for a factored divisor of p'-1 must retain its full Pocklington size/factor/gcd conditions and close the factor-prime DAG. Failed searches, successful arbitrary-base Proth roots, smooth-F searches and genuinely general fallbacks should be counted separately in producer telemetry.

## 6. Exact geometry screen

The companion script runs integer arithmetic only. For N=10^27 and F=2^45 it obtains:

| B | H | Deficit bits | Earlier fixed S | Earlier fixed-window count | Necessary same-F records |
|---:|---:|---:|---:|---:|---:|
| 10^16 | 284 | 9 | 157 | 181029996372 | 100076441656 |
| 2*10^16 | 568 | 10 | 313 | 90804183483 | 50038220828 |
| 4*10^18 | 113686 | 17 | 111616 | 254638308 | 250001842 |

The last column is a lower bound, not a constructed chain. It uses first k<=floor(B/F), terminal k>=ceil((T-B-1)/F), and jumps<=H. The all-format necessary counts from (2) are respectively 100000000000, 50000000000 and 250000000. Thus the potential saving is large for the previous narrow B choices and small for the old B=4*10^18 geometry.

For a conditional upper screen, suppose the initial lattice prime exists and every next chosen same-F prime has deficit <=dmax until the terminal test. There are then at most

    1+ceil(max(0,k_target-1)/(H-dmax))               (6)

records. For B=10^16, dmax=16,64,127 gives 106051154591,129189588320,181029996372. For B=2*10^16, dmax=16,64,255 gives 51488604041,56392280616,90804183483. These are consequences of stated per-step success, not availability predictions. In particular the worst earlier search widths recover the earlier conservative count. Adaptation helps only insofar as actual deficits or fallback gaps are better.

For actual data equation (3), with the exact first and final k, is the useful audit identity. A proposed empirical average is not inserted as a theorem. The old fixed-window proof pays its window width in every global stride even if every selected offset happens to be small; the adaptive join does not.

## 7. Operation, payload and proof costs

For n candidates below 2^90, a product batch has at most 90n bits. Its root has at most that many bits. Product construction takes n-1 integer multiplications, preferably a balanced tree with explicit factor membership. Common-root acceptance adds 44 product-modulus squares, their reductions, one global negative-one test and the candidate bounds. A raw modular square has up to 180n bits before reduction. The count of 44 is not a bit-cost or timing estimate.

| n | Product bits, upper bound | Common-root squares | Direct-root squares | Root payload bits, upper bound |
|---:|---:|---:|---:|---:|
| 1 | 90 | 44 | 44 | 90 |
| 8 | 720 | 44 | 352 | 720 |
| 16 | 1440 | 44 | 704 | 1440 |
| 32 | 2880 | 44 | 1408 | 2880 |
| 64 | 5760 | 44 | 2816 | 5760 |
| 128 | 11520 | 44 | 5632 | 11520 |

Both direct and common roots allocate roughly 90 bits per rung in this worst-width representation. This is additional to deficits, tags, shard headers and arithmetic proof witnesses. At 10^11 records, that allocation alone is about 1.125*10^12 bytes. It is an upper-width storage screen, not a lower bound on compressibility or the actual payload. The old short-offset format did not have this root field. Streaming reduces resident memory but does not delete input or proof-generation work.

Let Csq(w) price a proved modular square and reduction at width w, separately for Lean and MM0. Ignoring product construction, direct roots cost 44*sum Csq(bitlength p_j); the common root costs 44*Csq(bitlength M). Under the illustrative homogeneous schoolbook model Csq(w) proportional to w^2 and equal-width factors, the common/direct square-work ratio is n. Under a model w^alpha it is n^(alpha-1). These are conditional algebraic comparisons, not claims about an implementation. They show why fewer wide squares can cost more. The accepted MM0 arithmetic note retains explicit quotient/remainder and multiplication proofs; no native modular result is an axiom.

The full comparison must also price producer root discovery and exponentiation, CRT and its failed attempts, certificate serialization, checked partition and coverage, proof-library setup, Lean elaboration/kernel checking, and MM0 generation/verification. Common-root acceptance does not need a checked CRT trace, but CRT generation still costs time. A direct-root format avoids that generation. Product-modulus arithmetic may amortize prover dispatch or fit an optimized native kernel, but neither benefit is established by these counts.

The recommended bounded design space therefore includes direct roots, common-root batches at several sizes, and indexed small-base groups when payload dominates. The producer may select a valid plan using measured complete costs later. The verifier checks the chosen exact plan. No method or batch size is declared the winner.

## 8. Rejection rules and remaining work

Reject a shard for a missing primality proof, an undecoded bit field, a noncanonical or out-of-range dictionary/index value, repeated or descending endpoints, a gap>B-2, a mismatched predecessor, or a terminal endpoint below T-B. Reject a batch for a mismatched exact product, omitted/duplicated position assignment, a failed factor bound, or a failed root/unit test. A hash or successful external script exit does not replace any of these propositions.

The finite prime-order argument is already present for F=2^45. Generalizing it to other powers of two or smooth F, proving the new packed decoder and shard-cover induction, and implementing the selected modular arithmetic proofs remain work. No full prime chain, bounded successful search schedule, fallback fraction, root-compression rate or end-to-end throughput has been established. This is a sharper conditional checker and cost contract than the prior adaptive suggestion; its production benefit must be measured on supplied certificates.

## Source and scalar pins

Source paths below are under `work/ternary-goldbach/TernaryGoldbach`.

| Source | Relevant body | SHA256 |
|---|---|---|
| `Ladder/Spec.lean` | prime criterion at 38; offset cancellation at 60; product/squaring congruences at 96-125 | `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F` |
| `Ladder/Main.lean` | old fixed-window theorem at 20 | `A68289240152DDF2D6ADBD98A0055B45284D924F4F64820D851C01CA6FA250E9` |

Artifact paths are under `work/qrh-campaign/agents`.

| Artifact | SHA256 |
|---|---|
| `independent-feasibility/FINITE_RANGE_COST_RESEARCH_2026-11-11.md` | `0D4A300D37845AE20EB3242F89F08ED5984C0048646B60C1EECD2874945D8D48` |
| `independent-feasibility/EFFICIENCY_MIXED_LADDER_2026-11-11.md` | `9AACAF7FC0B5DCD9145AB3006D40248A2C7D57319677C57600890D21E5F75783` |
| `prime-estimates/SMOOTH_FACTOR_LADDER_PORTFOLIO_2026-11-11.md` | `5C49B39D44D432A71F7A5F45E924F6C76E9E173666DB6301EF0469F1AAD5F59A` |
| `integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md` | `3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227` |
| `major-constants/adaptive_prime_chain_geometry_20261111.py` | `91169CD49E29789793E30B305B0D9C1E961F805360B3532F86669BF16D9B8340` |
| `major-constants/adaptive_prime_chain_geometry_20261111.json` | `E5388691D293161EF4E8FC863AAF4E1C2C2419632CD555D2CD320F6709FEABF5` |

The script checks only integer endpoint geometry, encoding boundary cases and symbolic operation counts. It produces zero prime certificates. The report's group proofs were read against the actual source criterion; no elaboration or new checker acceptance is claimed.
