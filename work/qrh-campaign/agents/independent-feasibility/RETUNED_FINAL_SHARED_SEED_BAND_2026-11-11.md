# One smaller final shared-seed band

2026-11-11. Conditional paper construction with exact rational and integer checks. **Replace only the last shared-seed band by `(V,D,N)=(7000,8192,2387)`** for the reviewed coupled-height main and +167/+320/+640 schedules. Keep coarse order P27, final order P20, m=64 Bernoulli corrections and every existing error target. This is one conservative choice, not an optimization over N, D, precision or Taylor order. Independent review is pending.

The new band has 19562497 arguments instead of 27754497, and its endpoint is 2389 instead of 3389. At the main prefix it removes 4665153911000 head reciprocal scales, 4844588804000 head additions and 179404800000 fine-state updates. The log setup removes 172031055 Horner stages. These are operation counts, not measured time or complete proof-cost reductions. No analytic value, zero, prime candidate, transform or seed was evaluated; no build, Lean declaration or frozen artifact was changed.

## 1. Exact coverage and preserved interfaces

The coupled-height inventory has largest main index 85901, at conductor 10004. With 640 extra nodes its largest index is 86541 and its last height is

    5*86541/64 = 432705/64 < 6762 < 7000.

The four prefix lengths are 85902, 86069, 86222 and 86542. The lower four bands remain exactly

    (V,D,N,H) = (500,512,220,6401),
                 (1000,1024,387,6400),
                 (2000,2048,720,12800),
                 (5000,4096,1720,38400).

Their final index is 64000. The new last band starts at index 64001 and has 21901, 22068, 22221 or 22541 heights. It covers all remaining requested nodes, including the main-grid ceiling overshoot and every specified auxiliary node. No smaller finite-RH height is inferred from this computational retune. Larger future auxiliary ranges require a new coverage check.

At anchor `a=j/D` the actual function and coefficient remain

    f(a)=zeta(s,1+a),  s=1/2+it,
    U_k(a)=(-1)^k (s)_k zeta(s+k,1+a)/(D^k k!), 0<=k<27.

Only twenty coefficients are needed at the final coarse endpoint a=1. Midpoint coefficients use the same original D, not 2D. Final evaluation uses the exact displacement `h=D(alpha-b)` with `|h|<=1/4`. The exported coefficient radius remains eta=`2^-100`, and the isolated character-summed alpha error remains below `2^-82`. The finite approximants and rounded centers may change when N changes. This construction does not claim identity with, or containment in, old numerical coefficient boxes.

## 2. Complete finite formula and uniform EM remainder

Write `z=1+a`, `b=N+z`, so `1<=z<=2` and `2388<=b<=2389`. For `w=s+k`, retain the complete Hurwitz EM formula

    sum_(n=0)^(N-1) (n+z)^(-w)
      + b^(1-w)/(w-1) + b^(-w)/2
      + sum_(r=1)^64 [B_(2r)/(2r)!] (w)_(2r-1)b^(1-w-2r)
      + R_64(w,b).

Here `Re(w)+128>1` and `|w-1|>=1/2`, including k=0,t=0. Thus no pole-value convention or nonzero-height assumption is needed. Multiplication by `(-1)^k(s)_k/k!` joins the remainder's rising product to `(s)_(k+128)`. Dividing by `D^k` cannot enlarge its absolute bound.

The existing periodic-Bernoulli remainder proof gives, with `W=V+32+128=7160`,

    error_k <= 4 sqrt(b)/(k+127.5)
                 * (W/b)^k/k! * (W/(6b))^128.

All relevant rising factors have norm at most W. The selected cutoff is exactly `ceil(W/3)=2387`; hence `W/b<3` and `W/(6b)<1/2`. The bound `3^k/k!<27`, together with `sqrt(b)<=b<=2389`, yields the common rational remainder

    R <= 108*2389/127.5 * 2^-128
       = 21501/3615500148534971174298355203962537246720
       < 2^-116.

This is a uniform bound on actual coefficients for all `|t|<=7000` and every real `a in [0,1]`, not just the requested discrete nodes. The receipt separately checks the finite envelope for each k=0,...,26 against R. The analytic EM identity and Bernoulli bound are retained from the reviewed source construction; the rational checks do not replace those proofs.

## 3. Scaled circuit and complete seed error

Use the same scaled circuit:

    R_k=(-1)^k(s)_k/(D^k k!),
    D_k=sum_(n<N) B_(n+z)(n+z)^(-k),  B_x=x^(-s),
    E_l=(s)_l/(6b)^l,
    lambda_k=(-1)^k(6/D)^k/k!,
    gamma_r=6^(2r)B_(2r)/(2r)!,
    S_k=sum_(r=1)^64 gamma_r E_(k+2r-1),
    Z_k=b E_k/(s+k-1)+E_k/2+S_k/6,
    U_k^(EM)=R_k D_k+B_b lambda_k Z_k.

This includes the pole-type term and all signed corrections. `lambda_k E_k=R_k/b^k` proves the exact normalization. `|gamma_r|<4` is unchanged. The largest required E index is `P+126=153`; its final update uses l=152. Its factors remain below 1/2. The scaled R factors have first bound `(V+32)/D<5/4` and subsequent bound below 5/8. The lambda factors are at most `6/D`. Head reciprocal factors satisfy `1/x<=1`.

Keep each base-power error below delta=`2^-118` and each indicated complex rounding error below u=`2^-122`. Exact additions still require their common dyadic grid and sufficient integer capacity. The same recurrence inductions give errors `3u`, `2u`, `2u` for R, E and lambda. The existing detailed multiplication estimates now give

    head error <= 11935 delta + 329407 u,
    endpoint error <= 4779 delta + 38479 u.

One final rounded addition contributes u. Including the actual-function remainder above,

    seed error <= 16714 delta + 367887 u + R
               = (432032981/2852126720) eta
               < eta/4.

Every coefficient therefore meets the unchanged eta contract. Smaller b and N do not conceal new exact arithmetic: the rational factors, exact Bernoulli constants, all recurrence products and all rounding witnesses remain part of acceptance.

The finite coefficient majorant has `C=3N+5=7166` and `A=(V+32)/D<5/4`. The reviewed translation argument bounds shifted stored centers by `4C+1=28665<2^16`, after its perturbation allowance. Thus the old conservative stored-magnitude cap remains valid; no additional mantissa saving is claimed. Raw products, rational divisions, phase arguments and exponent fields retain their separate bounds.

## 4. Taylor, shift and elementary contracts

The mesh D did not shrink and the height bound did. The original real-segment Taylor arguments therefore retain the bounds

    E_target <1266(5/16)^20/20!,
    E_shift  <1266(15/16)^27/27!.

For P27 the pruned midpoint translation has 330 half-scale/add updates. Its nonnegative suffix-matrix argument still gives `633*330*u_T` after the character sum; the seed contribution is at most `2532*eta`. With exact rational final displacement, Horner contributes `1688*u_H`. Keep `u_T=2^-110` and `u_H=2^-100`. The entire isolated alpha budget, including both distinct Taylor remainders, equals at most the already selected fraction

    10065943424467492228678097495
      /32076363635089380005973590016

of `2^-82`, which is below one third. The lower bands retain the same proof and parameters. No new full sign precision or transform error claim follows from this isolated allocation.

For height propagation retain log error `2^-144`, initial B error below `2^-120`, step and update errors `2^-140`, and separate EM-copy rounding `2^-122`. There are fewer than 128000 steps. The original bound therefore remains `701/1024` of delta. The step budget is unchanged at `517/1024` of `2^-140`. Do not feed an EM copy back into the fine-state recurrence.

All elementary arguments now lie in `[1,2389]`, a subset of the former `[1,3389]` domain, and all initialization heights satisfy the old bound. Thus the existing 74-term initial-leaf and 83-term step-cis constructions, pi/range-reduction requirements and 144-bit shared logs remain sufficient. This note neither evaluates those leaves nor optimizes their degrees. The original 144-bit signed-coordinate state/step layout also remains sufficient.

## 5. Nested argument union and setup

At a height in a band, the union of all heads and endpoints is exactly

    x=1+j/D, 0<=j<=(N+1)D.

It has `(N+1)D+1` points. The new final D=8192 is divisible by the preceding D=4096, and its N=2387 exceeds 1720. Therefore it contains every lower-band argument exactly. The new complete union has **19562497** points; the old one had 27754497. Each of the 8192000 omitted arguments removes one initialization, one step-cis certificate and one step-grid conversion. Old arguments are still updated at the transition; only newly introduced arguments initialize at their first required height.

Apply the same log-anchor partition to the truncated integer grid `8192<=n<=2389*8192`. Each block starts at n0 and has length `min(floor(n0/128), end-n0+1)`. It covers the grid disjointly, and every relative offset is at most 1/128. The exact construction uses 1001 anchors instead of 1046. These anchors are a prefix of the old anchor list, with only the last block possibly truncated. Each point still depends directly on its anchor, not on a preceding approximate log.

The same degree 21 meets the 144-bit log target. Its nonanchor work is now `21*(19562497-1001)=410791416` Horner stages, compared with 582822471. The saving is 172031055. Anchor certificates, per-point assembly and rounding remain real work. If amplitudes use the independent integer-square-witness route, there are correspondingly fewer point witnesses; no amplitude-polynomial route is silently selected here. Bernoulli and shared pi setup are unchanged.

The raw dense state-plus-step arrays shrink from 1998323784 to 1408499784 bytes under the old four signed 18-byte coordinate layout, a difference of 589824000. This excludes alignment, proofs, seed buffers, indexing, worker copies, storage traffic and transposes. It is not a Lean or MM0 peak-memory estimate. Argument numerators still fit the old 25-bit cap, so no limb-width change is assumed.

## 6. Counts at the four already reviewed prefixes

Only N changes in the final band. Source coefficient slots, E recurrence stages, the 64 Bernoulli terms per coefficient, midpoint shifts, final P20 deliveries, shared R stages and anchor instances do not change. Both P27 and the twenty-coefficient endpoint are retained in the head formulas.

| Extra nodes | Final-band heights | New head reciprocal scales | New head additions | New fine-state updates |
|---:|---:|---:|---:|---:|
|0|21901|18746496140777|19467550607228|721276307853|
|167|22068|18831408502696|19555728936544|724543244852|
|320|22221|18909202463017|19636515070588|727536306893|
|640|22541|19071908785257|19805479533948|733796305933|

The comparator is the same coupled-height schedule using the old final N=3387. For final-band length H, exact savings are

    head scales:       1000 H (26*8192+19),
    head additions:    1000 H (27*8192+20),
    argument pairs:    8192000 H,
    fine-state updates:8192000 (H-1).

Each new total of argument pairs also equals its fine-state updates plus 19562497 initializations. Every pair still incurs its separate state-to-EM conversion. At +640, pair/conversion savings are 184655872000 and fine-state savings are 184647680000. The separate receipt records all old and new band categories and exact ratios.

Transform, P20 residue contraction, conductor grids, primitive labels, principal and small-conductor work are unchanged. This retune complements the height reduction; it does not count the height saving a second time. It also does not remove any downstream output, sign, interpolation, zero-count or auxiliary-success requirement.

## 7. Evidence and remaining acceptance work

The new script `retuned_final_seed_band_20261111.py`, SHA256 `DDDD2CB0C0E25D8BCFF43DE142EBEED4C1DAFFDB35FED01ECA914B671ADD1FE3`, writes only its new same-stem receipt, SHA256 `51EF63920A6E298F21FEC3EE228B9DB75302700847D64532ADA76D1240A15B7D`. It passed 2343 exact checks. It verifies each coefficient-envelope inequality, all allocations, four old-ledger reconciliations, all new ledgers, nesting, coverage and every anchor block. It imports no evaluator or author code and refuses receipt overwrite.

Its nine pinned inputs are:

| Input | SHA256 |
|---|---|
| integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md | 1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E |
| prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md | 251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231 |
| integration/REVIEW_SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md | 043E2E1630B19EC8EED9496FAA5D9AE6AF9C20944F7F2F5589B48E5A119C4F26 |
| qrh-blueprint/SELECTED_SCALED_SEED_ORDER_2026-11-11.md | 579AAEC28BD4C1DB8FB83F3CDB1E4782160D3D35FA8AB2B8DC83BFF956ACBCD1 |
| qrh-blueprint/SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md | 8ABDD8A1F991AF9FEACE49908E5BA865EC3FD5804311CAE73AB9D80A4456D413 |
| zero-sum/GRID_ELEMENTARY_ANCHOR_REUSE_2026-11-11.md | E564A8DDEC5F0AD69F5CF22DFC89147F81EA165B6E6D17B4CF0EFB0EEA3824AF |
| independent-feasibility/REVIEW_GRID_ELEMENTARY_ANCHOR_REUSE_2026-11-11.md | 335D5B97A2071E9AFBEFF363C9FA4542CB974B8EB4D0F66B33A4E4FCECC17A29 |
| major-constants/coupled_plus_height_inventory_20261111.json | 676388307D0353800DB72B85ED9252C83E3BA4F62F3D54F63A5C3B43A7DB4267 |
| independent-feasibility/REVIEW_COUPLED_PLUS_HEIGHT_CONDITIONAL_COST_2026-11-11.md | 222CE080714E39E73398B23AF28E67D37F709A9BAD895FD0D32E2F9F9CB20165 |

Agent paths are relative to `work/qrh-campaign/agents`; the two qrh-blueprint paths are relative to `work`. The exact input objects and hashes are also recorded in the receipt. The reusable analytic EM, derivative, Taylor and elementary identities still need ordinary-rule formal implementations, and their actual finite enclosures have not been generated. The change is ready for independent paper/metadata review, not a completed spectral or end-to-end theorem certificate.
