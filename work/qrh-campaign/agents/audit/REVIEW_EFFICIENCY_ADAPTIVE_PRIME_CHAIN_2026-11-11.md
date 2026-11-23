# Independent review of adaptive prime-chain certificates

2026-11-11. Verdict: **PASS at paper certificate-contract and exact integer-geometry scope.** No correction is required. This review supplies no prime chain, successful search bound, runtime result or Lean/MM0 proof.

Reviewed the complete `major-constants/EFFICIENCY_ADAPTIVE_PRIME_CHAIN_2026-11-11.md`, SHA256 `77ADA365011EA6069D3D2F8131950AD65ECAD285400BBD5C307C7444F0093785`. The geometry source is `91169CD49E29789793E30B305B0D9C1E961F805360B3532F86669BF16D9B8340`, receipt `E5388691D293161EF4E8FC863AAF4E1C2C2419632CD555D2CD320F6709FEABF5`. Existing artifacts remain unchanged. No prime or modular-power evaluation, analytic evaluation, build or Lean edit was performed.

## Actual coverage and the terminal endpoint

For even B>=4, each odd prime p covers exactly the odd integers in [p+4,p+B] via the binary theorem. Starting with p0=3 gives [7,B+3]. The condition p_next-p<=B-2 makes the next first odd integer at most two above the previous last odd integer. This proves coverage by induction without a minimum-progress premise. Strict increase makes the list finite and ordered as claimed; its supplied final test p_last+B>=T completes the argument.

The specialization T=10^27-1 correctly covers every odd integer below the unchanged analytic threshold. The parity step in the proposed production bound is valid: p+B and T are odd, so p+B<T implies p<=T-B-2. Any permitted next prime is then at most T-4. The verifier nevertheless retains p<10^27, so correctness does not depend on trusting the producer's stopping policy.

The all-format count ceil((T-B-3)/(B-2)), clipped at zero, is necessary because r transitions can advance at most r(B-2) from 3. It proves no attainable count. In particular no maximal prime, prime-density conclusion or guaranteed next prime is assumed. Exhausting every preferred format without a successful fallback leaves an incomplete certificate.

## Decoding and shard boundaries

The exact integer equivalence is

`p<kF+1<=p+B-2 iff floor((p-1)/F)+1<=k<=floor((p+B-3)/F)`.

Thus the stated q,l and deficit d=q-k decoder are correct. The bound on d precedes natural subtraction. Empty ranges must be rejected. In a genuine same-F run, substituting p=kF+1 gives q=k+H and l=k+1, with H=floor((B-2)/F). Therefore `0<=d<H`, `k_next=k+H-d` and the telescoping deficit identity are exact. When H=0 there is no such transition; the format must take its empty-range branch rather than attempt a deficit width for H-1.

Mixed-F decoding uses the actual previous prime. A shard's predecessor is a binding to that same global decoded list, not a free initial value. Checked predecessor equality, the cross-shard gap, exact position partition and the final terminal test suffice to join independently checked shards. Sorting arithmetic batches cannot replace any of these checks. Each indexed arithmetic group fixes its base and modulus tag; a subsequence skipping other groups uses the actual k difference, not a recurrence shared across different bases or F values.

For the three displayed Proth rows, the first k requires at most 45 bits and deficits require 9, 10 or 17 bits. A smaller width is sound only with its stated per-record bound; a zero-bit block means every deficit is zero. Unused bit patterns must not bypass `d<H`. A directly encoded arbitrary prime needs at most 90 bits under the explicit range bound. These are width bounds, not claims that all data attain or compress to them.

## Supplied-root and indexed primality checks

I reread `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean:38–57`, SHA256 `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F`. Its actual generic theorem requires only an odd candidate greater than one, the strict square bound, and divisibility by X^(2^44)+1. It does not require the old offset certificate or base 3.

For a nonempty batch, exact factor binding gives M>1 and p_j divides M. Starting from supplied X<M, 44 checked squarings with final residue M-1 give that divisibility for every candidate. An odd prime divisor r then sees X of order exactly 2^45. The least-prime-factor square argument proves primality. Unit conditions follow from the congruence. No gcd, k-th powering, per-factor modular evaluation or checked CRT construction is needed. The direct-root variant is the same argument with one factor. A supplied final residue without the checked powering chain would not establish it.

The producer's roots a_j^k_j satisfy the desired half-order identity, and ordinary CRT is justified for distinct primes. Strict increase supplies distinct candidate integers. The report correctly separates this producer construction from acceptance, which remains sound even for a repeated product if its stronger congruence actually holds.

The indexed alternative also checks out: V=X^(2^44), U_j=V^k_j, and the actual jump recurrence prove U_j=(X^k_j)^(2^44). No offset cancellation occurs, so no separate gcd is needed there either. All exponents and positive jumps are below 2^45, giving the stated shared-square upper bound of 88 for a nonempty group. A singleton uses only k1; the empty jump set needs no maximum. A negative-power optimization would require the explicit inverse that the note already retains.

The smooth-F branch is compatible with this same coverage contract. Its distinct prime-power order conditions and product-modulus transfer are covered by the separate review `REVIEW_SMOOTH_FACTOR_LADDER_PORTFOLIO_2026-11-11.md`, SHA256 `A51F4408037C3A49A0B59D3144113D8B01D186915444CD7A215ED98443CBBA1E`. Neither smooth-F candidate counts nor a general-prime fallback certificate alone supplies a missing gap check.

## Independent saved-integer check and comparison

The owned `review_adaptive_prime_chain_geometry_20261111.py` reads the frozen JSON and independently recomputes all three geometry rows, four decoder boundary examples and six batch-width rows. It checks the terminal k ceiling on both sides, first-index bound, necessary same-F counts, conditional deficit upper counts, actual old fixed-window indices, widths and product/direct operation counts. It performs no primality or modular-power tests.

The replay passed. Script SHA256: `78C84CA3E9FA3FF55FD77CDBE947C44D6C4D065A1EC0EB8169C954AD30CBC3D2`. Receipt SHA256: `A056A5B814885FD574819B57F69BFE6DB0BE558FBD95372003729380B0016D4E`.

The old fixed-window count agrees with the maximum consumed index floor((T-5)/(S*2^45)), as used by `Helfgott/SmallCases.lean:31–40`. The adaptive count bounds do not silently replace those already constructed windows. The proposed improvement changes the geometric acceptance contract and still needs new data and a new decoder/coverage proof. The conditional upper screen assumes a successful initial prime and a successful bounded-deficit choice at every required transition. Those are explicit availability premises for that screen, not established facts.

The product/root bound of 90n bits and raw-square bound of 180n bits are valid. Forty-four product-modulus squares may cost more than 44n small-modulus squares. The illustrative n^(alpha-1) ratio states its equal-width homogeneous-cost assumption and excludes product construction. Root payload, CRT generation, arithmetic proof witnesses, all failures and final coverage remain real costs. This packet establishes a sound wider acceptance format and a conditional opportunity to reduce rung count, not an end-to-end efficiency winner.

The final theorem and original binary-input contract remain unchanged. Source proof bodies and this paper review do not replace compatible kernel validation or actual finite certificate production.
