# Independent review of the retuned final shared seed band

2026-11-11. PASS for the conditional paper construction and exact metadata. No correction requested. The replacement `(V,D,N)=(7000,8192,2387)` preserves the accepted m64, P27-to-P20, scaled-coefficient and height-recurrence contracts for the four specified coupled-height prefixes. It does not produce any seed value, prove that a sign test succeeds, or establish runtime or kernel acceptance.

## Frozen objects and review method

The reviewed author objects, under `work/qrh-campaign/agents/independent-feasibility`, are:

| Object | SHA256 |
|---|---|
| RETUNED_FINAL_SHARED_SEED_BAND_2026-11-11.md | 8F08560DDB2BDFEBEABA0D4D5A44FCBCC625BFD43D1027AF05BF62233863FD9B |
| retuned_final_seed_band_20261111.py | DDDD2CB0C0E25D8BCFF43DE142EBEED4C1DAFFDB35FED01ECA914B671ADD1FE3 |
| retuned_final_seed_band_20261111.json | 51EF63920A6E298F21FEC3EE228B9DB75302700847D64532ADA76D1240A15B7D |

I read the complete author note and script, compared the retained formulas with the shared EM and scaled-seed reports, and checked the height-recurrence, selected-order and elementary-anchor constructions directly. All nine input pins in the author receipt match their current bytes. These include the actual coupled-height inventory and its independent review. This is a review of that conditional inventory, not a new proof that its finite RH or auxiliary certificates exist.

The separate script `review_retuned_seed_band_20261111.py` imports no producer code or evaluator. It passed 3317 integer/Fraction checks. It reconstructs every new and old band category for all four scenarios, their totals, differences and ratios; every logarithm-anchor block; all coefficient remainder envelopes; and the complete error allocations. Polynomial degrees and rational error bounds are checked without evaluating logarithms, exponentials, Hurwitz functions or transforms.

| Independent object | SHA256 |
|---|---|
| review_retuned_seed_band_20261111.py | 27C7E64BF11FDCFBADED1706BC1BEDC29EF7584607C1B7107A5D253B27316A90 |
| review_retuned_seed_band_20261111.json | 222FD2950009356040E770B0C2EB31FEC44AE90AF62E51B20BE8BC464EC2B0F2 |

## Function, remainder and rounded circuit

The actual function remains the continued Hurwitz function at `s=1/2+it`, with alpha in `[0,1]`. The coefficients remain `U_k=(-1)^k(s)_k zeta(s+k,1+alpha)/(8192^k k!)`. In particular, decreasing N changes the finite EM approximant; it does not change this exact target. Midpoint translation uses the same D and the final scaled displacement has absolute value at most 1/4.

For the final band, `b=N+1+alpha` lies in `[2388,2389]`. Every required rising factor is bounded by `W=7160`. The exact cutoff is `ceil(W/3)=2387`, so `W/b<3` and `W/(6b)<1/2`. Joining the two rising products in the differentiated EM remainder gives the stated factor of length `k+128`. The largest k is 26. Its real integrability denominator is `k+127.5>0`. The pole-type denominator `s+k-1` has norm at least 1/2 for every real t, including zero. The full pole-type term, half term and all 64 signed Bernoulli corrections remain present.

The raw coefficient remainder is bounded by

`4 sqrt(b)/(k+127.5) * (W/b)^k/k! * (W/(6b))^128`.

Using `sqrt(b)<=2389`, `3^k/k!<27` and `D>=1` gives the stated common scaled remainder `108*2389/127.5 * 2^-128 < 2^-116`. The independent check matches all 27 tighter per-k rational envelopes in the receipt. This uses the accepted analytic EM remainder theorem; successful scalar checks alone would not establish that theorem.

The R recurrence still has first factor below 5/4 and later factors below 5/8. All E updates through stored index 153 have factor below 1/2, and lambda has factor at most `6/8192`. Thus the prior rounded recurrence bounds `3u,2u,2u` apply without strengthening their hypotheses. The exact identity `lambda_k E_k=R_k/b^k` verifies the normalization of the full correction. Common-grid additions require sufficient integer capacity as before.

I obtain the same complete bound

`11935 delta +329407u +4779delta +38479u +u + remainder`

`= (432032981/2852126720) eta < eta/4`,

where `delta=2^-118`, `u=2^-122`, and `eta=2^-100`. Both endpoint and final rounding are paid. The factorial majorant has `C=7166`; the positive translation-matrix argument and accumulated-error allowance give stored magnitude below `4C+1=28665<2^16`. This is not a bound on raw integer products, rational denominators or phase arguments.

## Translation, height and elementary setup

The largest height is `5*86541/64=432705/64<6762<7000`. The lower bands, including their boundary heights, are unchanged. The final band starts at index 64001. The four final-band lengths are 21901, 22068, 22221 and 22541. None approaches the retained 128000-step recurrence bound.

The P27 shift still has exactly 330 updates. The two distinct Taylor remainders, source coefficient errors, shift rounding and final Horner rounding give the previously selected fraction

`10065943424467492228678097495/32076363635089380005973590016 <1/3`

of the isolated `2^-82` alpha budget. Retaining D8192 and lowering V preserves the derivative bounds that justify these remainders. A change to D4096 or a different source order would require a separate proof; it is not accepted here.

For the height recurrence, exact steps have unit modulus but stored steps need not. The prior induction explicitly allows their error. Initial total error is below delta/4, the step bound is `517/1024` of `2^-140`, and update plus separate EM-copy rounding gives `701/1024` of delta. The low-precision copy must not feed back into the state. Initialization is at each argument's first required height, not automatically at t=0.

All initial and step leaves now use arguments in `[1,2389]` and heights within their former domain. Thus the accepted 74-term initialization and 83-term step constructions, log error `2^-144`, shared pi precision and range-reduction witnesses remain sufficient. This domain inclusion is essential; fewer recurrence steps alone would not certify initialization.

## Exact reuse and work accounting

The argument union is precisely `1+j/D` for `0<=j<=(N+1)D`. The new final grid contains all earlier grids because its denominator is divisible by theirs and its endpoint is larger. Its 19562497 points each require one initialization and one step certificate under the selected recurrence schedule. Old points update at the first height of a new band; new points initialize there. Independently counting these cases gives `H*X-(X-X_old)` updates in a band, and total updates equal total height/argument pairs minus the final argument count.

The logarithm blocks cover every integer numerator from 8192 through `2389*8192`, with no gap or overlap. Their 1001 anchors are a prefix of the previous anchor sequence; only the last block is truncated. Relative offsets remain below 1/128. Degree21 therefore remains sufficient for the stronger 144-bit log target. The 410791416 nonanchor Horner stages, 172031055-stage saving and raw dense state/step size 1408499784 bytes all match. The byte count excludes proofs, indexing, caches, workers, alignment and intermediate buffers.

For each of the four scenarios I independently reconstructed both P27 interior-anchor and P20 endpoint contributions. The N-dependent head work falls; source coefficient slots, E stages, Bernoulli work, midpoint translations and delivered P20 slots do not. Fine-state updates fall by `8192000*(H-1)`, whereas argument pairs and EM-copy conversions fall by `8192000*H`. This distinction is handled correctly. No height reduction is counted twice.

## Acceptance limits

The retune is a valid smaller conditional computation for these exact four prefixes. It does not shrink the mathematical spectrum target or authorize longer auxiliary intervals. Actual elementary enclosures, arithmetic witnesses, transformed values, signs, zero counts, full downstream error composition and ordinary Lean/MM0 acceptance remain required. New approximant centers need not equal, or lie in, old saved boxes. The counts are useful schedule comparisons, not timing or total proof-cost estimates.
