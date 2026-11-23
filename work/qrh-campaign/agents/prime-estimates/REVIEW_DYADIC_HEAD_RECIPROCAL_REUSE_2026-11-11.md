# Independent review of shared dyadic head reciprocals

Verdict: **PASS for the original proposal together with the mandatory product-width clarification.** The downward-reciprocal replacement preserves the selected m159 seed and output error contracts. It does not establish a checking-time improvement over the existing small-denominator operation. The producer-hint alternative correctly preserves that narrower verification option.

The original report alone contains a false strict bound for a valid certificate product. The separate clarification corrects it to A*v<=2^142, requiring 143 magnitude bits at equality. I independently found this issue before reading the clarification. The reported malformed-input bound, head-product bound, digit-product subcounts, cache size and error conclusions survive the correction. No other correction is requested.

## Objects and scope

The reviewed author objects are under `work/qrh-campaign/agents/independent-feasibility`:

| Object | SHA256 |
|---|---|
|DYADIC_HEAD_RECIPROCAL_REUSE_2026-11-11.md|DB63BE813797CC0DA28F28EEBFEE394BFB2BCC34EFDFA2756F0F9718223F3FB9|
|CLARIFICATION_DYADIC_HEAD_RECIPROCAL_PRODUCT_WIDTH_2026-11-11.md|B35787874F2374A78E98C9FB231D82774FF01C46F95B1A6A10E581F449CF4620|
|dyadic_head_reciprocal_bounds_20261111.py|BCB29B2F2254051A9F22532C9576CFD59528AD5040D45454020A7AAA2FED568F|
|dyadic_head_reciprocal_bounds_20261111.json|513ABDAC87D274FB518B7E65B156199B832E52187BDE20BEA6824569F09E3D0A|

I read the complete proposal, clarification and scalar script, the actual selected joint finite-EM circuit and m159 amendment, the scaled head/error/shift construction, and the fixed-step reuse contract distinguishing fine height states from EM copies. The five predecessor pins in the receipt matched. This is an independent paper and exact-scalar review, not a new Lean elaboration, axiom audit, implemented arithmetic checker or spectral certificate.

The selected parameters are V=7000, D=4096, N=1500, P=28 and m=159. The head target is the unchanged finite sum of B_x*x^-k with B_x=x^-s, s=1/2+it, x=n+1+a, and scaled rising factor R_k. All endpoint, Bernoulli, finite-EM remainder, source/output normalization and subsequent character amplification obligations remain those of the selected predecessor.

## Reciprocal and head-error proof

For x=A/D and q=130, the witness checks A*v<=D*2^q<A*(v+1), with A>=D>0. Dividing these positive inequalities proves 0<=r=v/2^q<=D/A<=1 and 0<=D/A-r<2^-q. This also covers exact reciprocals; no positive-error lower bound is used. The witness is bound to the exact mesh numerator A, not merely to an approximate x.

Let e_k be the norm error of the rounded head term against B_x*x^-k. Because the exact term has modulus at most one and r<=1, the next error is at most e_k+2^-130+u. Starting at delta therefore gives e_k<=delta+k(u+2^-130). This uses deterministic inequalities and permits perfectly correlated repeated reciprocal errors. It does not rely on random cancellation.

The old head proof can be repeated with this bound, keeping the same rounded R and its error. The extra term is at most 5N*k*2^-130, uniformly bounded by 5NP*2^-130. It is not necessary, and generally would be incorrect, to claim the new rounded trajectory stays this close to the old rounded trajectory: each is compared separately with the exact head. The proposal's full-error use is valid under this exact-target interpretation.

I reconstructed the coefficient ledger independently. The head contributes 5N*delta+(5NP+8N+1)u. At b<=1502 the endpoint contributes (2b+3)delta+(36b+2679)u, and the final addition contributes u. Hence the total coefficients are 10507 and 278753. The exact remainder is

`R_EM=(312/635)*(7009/9006)^318`.

With delta=2^-118, u=2^-122 and eta=2^-100, the extra error is exactly `(13125/67108864)*eta`. The reconstructed full bound is strictly below .107eta and eta/4. Applying the already proved postscaled translation bound gives `2*E_new+351*2^-110<.557eta<eta`. The stored-magnitude guard `2^28*(E_new+350*2^-110)<1` also passes.

The accepted analytic shift and target Taylor bounds depend on the exact target and the delivered numerical coefficient radius, not on the particular rounded head algorithm. They therefore remain available. This does not absorb analytic shift bias into a numerical radius or assert that old saved enclosures contain the new centers.

There is no factor equal to the number of heights in this perturbation. Every head computation starts from that height's separately certified B_x copy. Only the unchanged finer state feeds the next height. Reusing head outputs as height states would violate this proof.

## Rounding, widths and correction

A nearest coordinate grid of spacing u has complex Euclidean rounding error at most u/sqrt(2)<u. The exact dyadic sum of head terms must retain enough integer capacity. The term norm is below two, so each coordinate numerator on the 2^-122 grid has magnitude below 2^123. The head sum norm is below 3000, fitting 134 magnitude bits on that grid. This argument presumes the initial EM copy is on the common grid, as explicitly permitted and charged by the predecessor; it does not discretize the fine height state more coarsely.

For nonunit x, v<2^130. Thus the exact U*v product fits 253 magnitude bits before rounding. A has at most 23 bits, so a bounded but unaccepted reciprocal witness requires a 153-bit A*v capacity. The valid bound is A*v<=2^142, with 143 bits possible. A=2^13 and v=2^129 give equality at x=2. This is the precise issue repaired by the clarification. It has no effect on the separate U*v estimate.

The old rounded rational operation can instead be checked by `2*abs(A*V-D*U)<=A`, with A>0 and the chosen tie convention. This is exactly a nearest-integer certificate for V to D*U/A. The signed case follows from the same absolute inequality, including U=0. Because the exact target lies between -abs(U) and abs(U), a nearest V has abs(V)<=abs(U). Therefore its core product is at most a 23-by-123-bit product. Shifts, signed subtraction, comparison, tie checking and numerator binding remain actual proof work.

The radix256 subcounts 272, 48 and 51 correctly use the operand capacities for, respectively, U*v, A*V and A*v. They are not complete arithmetic-event counts. The corrected 143-bit valid result cannot be used to truncate an unaccepted 153-bit product; the clarification explicitly preserves this distinction.

For the producer-only hint, the reciprocal approximation perturbs D*U/A by less than 1/128. Nearest rounding the hint therefore puts V0 less than 1/2+1/128 from the exact target. Any nearest integer for the exact target differs from V0 by at most one. Comparing A*V0-D*U with the signed half-denominator thresholds determines the correction and tie rule; updating the product by plus or minus A avoids a second multiplication. Verification can ignore the hint entirely and accept only the final exact nearest-rounding witness. A bad untrusted hint cannot establish the final identity.

## Counts, reuse and costs

The head intervals for the 4097 coarse anchors have union A=4096,...,1501*4096, containing 6,144,001 integers. Their 1500*4097 occurrences repeat 1499 integer boundary arguments. Exactly one occurrence is x=1. Removing its 27 identity scales leaves 165,928,473 nonunit complex scales per height. All four prefix counts in the author receipt match independent reconstruction.

There are 6,144,000 nonunit reciprocal entries. Packing each in 130 bits gives 99,840,000 raw bytes. This is neither an entire proof-state size nor a RAM bound: lookup, proof transport, decoding, indexes, temporaries and context lifetime remain additional costs. The larger EM argument union includes endpoints that do not need these head reciprocals. A shared entry must still be bound to each exact argument index.

The comparison `2H*U_head*(C_div-C_dyad)>G*C_setup+Delta` is a valid additive common-price break-even condition, where Delta must include all remaining differences and setup is counted with its actual multiplicity. If a tiled proof discards checked reciprocal facts, repeated certification must be charged. The inequality needs distinct instantiated prices for native generation, proof construction and ordinary checking. It provides no speed conclusion without those prices. In particular, a longer reciprocal mantissa may increase checking work despite eliminating a producer division.

The hint/correction alternative is useful precisely because the producer and verifier need not use the same arithmetic method. It makes no reciprocal cache or producer-CRT-style derivation a prerequisite of the final arithmetic witness. Its generator still pays hint formation, the exact correction check and any setup; it is not automatically cheaper than direct division.

## Independent evidence

`review_dyadic_head_reciprocal_20261111.py` imports no author code. It checks the three original artifact pins and five predecessor pins, reconstructs the source ledger, all 28 order/error conditions, output and magnitude guards, four prefix schedules, union and cache counts, digit capacities, and the nonunit equality case. It performs 141 exact integer/rational checks, all passing. The clarification was read and its hash checked separately.

| Independent object, in this directory | SHA256 |
|---|---|
|review_dyadic_head_reciprocal_20261111.py|A3AAA4D4E0A04A82E0AED04103A565230D0BD548C33A7BFC6C0566304243B3FF|
|review_dyadic_head_reciprocal_20261111.json|D1F684C078081544193F59AC565A7C2AC2A06714DA937773FD59B8E9FEA8CEA8|

No reciprocal table, elementary value, spectral value, transform or candidate prime was computed. No build was run and no frozen author object was modified. Acceptance is of the combined paper/error/cost model; actual production, exact arithmetic acceptance and performance remain untested.
