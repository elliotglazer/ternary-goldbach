# All-theta time-length choices and conditional cost pruning

2026-11-11. Exact scalar and conductor metadata research. No analytic values, FFTs, signs, prime or zero computations, builds or source changes were made. The current baseline remains unchanged pending review and selection.

There are one or two distinct admitted time-FFT lengths at each of the29996 conductor/scenario rows. Retaining the smallest theta at each length leaves44585 candidates instead of1949740 theta choices. This is a complete dimension/budget frontier under the cost conditions below, not an unconditional runtime or proof-size Pareto theorem.

A substantive new finding is that18 rows admit a length smaller than both endpoint choices. At main conductor745, theta127 admits2097152 while theta64 and theta128 both require4194304. The earlier smallest-theta-at-N128 result remains correct. It did not prove that N128 was the shortest length among all admitted theta values.

## 1. Exact candidate set

Retain the accepted130 parameter sets, indexed by conductor cohort and integer theta64 through128. Their X=10, n0=8192, complete tail tests, K,L, seed and shared-circuit budgets are unchanged. Cohort parity is conductor parity, not character parity. Both actual character channels, all primitive labels and the fixed canonical phases remain.

For each conductor and extra grid index e in {0,167,320,640}, use its same exact height Hc and closed top index

    m=ceil(64Hc/5)+e, V=5m/64.

For each admitted theta define N(theta) as the least power of two at least8 satisfying

    N*theta >=2m*K(theta),
    5N >=5m+128K(theta),
    5N >=384.                                            (1)

These are exactly `N*Delta>=max(2V*K/theta,V+2K,6)`. Enumerate all65 values; do not assume monotonicity. Group them by identical N and retain the least theta in each group as its dimension/budget representative.

The owned receipt stores every row as `[conductor,closed_top_index,[[N,theta_min],...]]`. The earlier selected-theta lists are checked independently against their original rule, the first theta with N(theta)<=N128, and still match exactly.

| Extra nodes | One-length rows | Two-length rows | Retained representatives |
|---:|---:|---:|---:|
|0|3870|3629|11128|
|167|3862|3637|11136|
|320|3849|3650|11149|
|640|3826|3673|11172|

Every two-length row has a factor-two length difference. Its larger length has representative theta64. A smaller length requires a larger theta, hence a stricter Gaussian seed budget. Fewer loops and coarser precision are competing coordinates. This note does not choose between them by assuming equal operation prices.

## 2. All18 endpoint exceptions

Every exceptional smaller length occurs only at theta127. In its odd-conductor cohort, K127=231 and K128=233. Thus231/127<233/128: rounding the tail parameter K creates a small rise in the first period constraint at theta128. The exact dyadic ceiling detects it.

The table records Nsmall and three integer slacks. The first two prove the theta127 period conditions; the last shows theta128 fails at that N. In every row, 5Nsmall-384 is positive, the next smaller power fails the first constraint, and all other theta values require2Nsmall. Those facts and the full theta groups are retained in the receipt.

| e | c | m | Nsmall | 127Nsmall-462m | 5Nsmall-5m-29568 | 128Nsmall-466m |
|---:|---:|---:|---:|---:|---:|---:|
|0|745|576448|2097152|19328|7573952|-189312|
|0|2945|144116|524288|2984|1871292|-49192|
|0|2947|144013|524288|50570|1871807|-1194|
|0|5999|72052|262144|4264|920892|-21800|
|0|6001|72026|262144|16276|921022|-9684|
|0|6003|72013|262144|22282|921087|-3626|
|167|1461|288052|1048576|89128|3773052|-14504|
|167|2949|144091|524288|14534|1871417|-37542|
|167|6015|72039|262144|10270|920957|-15742|
|167|6017|72014|262144|21820|921082|-4092|
|320|1461|288205|1048576|18442|3772287|-85802|
|320|2953|144052|524288|32552|1871612|-19368|
|320|6027|72052|262144|4264|920892|-21800|
|320|6029|72026|262144|16276|921022|-9684|
|640|1463|288141|1048576|48010|3772607|-55978|
|640|2959|144077|524288|21002|1871487|-31018|
|640|6055|72052|262144|4264|920892|-21800|
|640|6057|72026|262144|16276|921022|-9684|

For the first example, the first period ratio is266318976/127, below2097152, while theta128 requires268624768/128, above it. This is an exact finite-selector effect, not a numerical transform observation.

## 3. What smaller theta dominates at fixed N

Fix a row and an identical N. Then J=ceil(25N/192), R=J+1, the Gaussian work envelope, output index geometry, character dimensions and every listed loop count are fixed. K and L are admission constants; after admission they do not create extra loops when X,n0,N are fixed.

Let Wbar=A/theta with A=40000000 or80000000, and eps=2^-80/(4*3^theta). Moving theta to theta+1 divides eps by3. For any a,b>=0 not both zero,

    [eps(theta)/(a*Wbar(theta)^2+b)]
      /[eps(theta+1)/(a*Wbar(theta+1)^2+b)]
      >=3*theta^2/(theta+1)^2 >2,                         (2)

for theta>=64. This proves the direction for time-gate, omega and positive-scale recurrence allocations, rather than comparing epsilon alone.

For all130 actual selectors the exact checker also verifies that `delta/16<1/Wbar` and that the selected sigma equals

    sigma=delta/[1024*(3^11+1)^4].

Thus the opposing `1/Wbar` branch of the minimum is inactive. Seed delta and sigma decrease by at least a factor two per theta step. At fixed N the radial, root/setup and Gauss tolerances are fixed positive multiples or minima of multiples of sigma. The character tolerance is a minimum of fixed safety constants and a multiple of eps. Hence all eight named local tolerances are nonincreasing with theta. Bucket, prefactor, coefficient-final-round and time-final-round allowances are proportional to eps; the final Y round allowance is fixed. All required rounding operations remain charged.

If adaptive interpolation is selected, M/eps increases with theta by (2), so its sufficient minimal even order is nondecreasing. The finite130-row order table confirms this. A smaller theta may also deliberately reuse a larger theta's already checked higher-order kernel: its remainder condition is weaker, and every available kernel norm remains below4. Therefore pruning need not force a new kernel order or setup purchase. Choosing the smallest available order remains a separate setup-versus-query decision.

These facts prove dominance for the following explicit sufficient-circuit score model. At a fixed N, use the same circuit templates and common valid magnitude envelopes; assign costs nondecreasing in required fractional precision; retain the full setup charge or a reusable setup plan with no larger cost after replacing theta. A smaller theta can then use every more demanding tolerance and, if convenient, the same interpolation kernel as the discarded theta. It has identical or no greater counts. One representative per N is sufficient for minimizing that model.

This is not a conclusion about arbitrary actual implementation costs. The time-input magnitude bound `2Wbar^2+1` grows when theta decreases. Its integer-width effect, actual angle reduction, proof representation, exact constant witnesses and cache reuse must be priced. One sound conservative score uses the common theta64 magnitude envelope for all theta at that fixed N; that changes the pricing bound, not the valid error tolerances. A common bound does not establish an ordering between separately optimized implementations.

For simple fixed-point bounds proportional to `a*Wbar^2+b`, adjacent magnitude ratios are below2 while the error allowances in (2) differ by more than2. This explains why one integer bit can be offset by at least one fractional bit in that limited model. It does not prove the same statement for every raw product, division, kernel rational, transcendental argument or proof term. Such a blanket width conclusion is not needed for the conditional frontier.

Shared caches are another genuine qualification. Different tilts can have different actual angle leaves. A cached expensive leaf at a larger theta may be cheaper to reuse than a newly produced smaller-theta leaf. The smaller-theta per-N pruning is not valid for a price model granting that reuse unless the comparison includes it. Preserve all65 choices when those conditions cannot be justified. Likewise, different tilts and approximation centers can have different successful sign margins and repair costs. A common tau guarantee does not make success probabilities or repair workloads equal.

## 4. Complete conditional price rule

The metadata retains counts for the following categories, rather than pricing only the time FFT:

* Gaussian terms and unit gates, seed contractions, rounded buckets, odd-integer scales, outer exponentials, radial updates, cutoffs, prefactor construction and contraction.
* Character butterflies, extra products, inverse dyadic scales, roots and Bluestein kernel builds/entries; the separate Gauss transform and fixed phase, conductor-root, division and K-cache setup.
* Time butterflies, all N output slots, roots, conjugate-frequency copies, and any explicit omega output scaling.
* Numerical-Y positive-scale seed, shared recurrence and output products when that interface is requested; interpolation kernels, all query arithmetic, sample-access union and final sign/count work when selected.

The last interpolation and consumer terms are explicit optional additions, not concealed in the base-loop totals. For a candidate a at row i, let C_i(a) be the sum of these local categories priced at their actual permitted tolerances and widths. Let C_shared(a_1,...,a_s) charge the union of reusable roots, kernels, constants and proofs at the finest needed precision, plus transport and retention. A valid selection rule is

    minimize C_shared(a_1,...,a_s)+sum_i C_i(a_i).          (3)

When a fixed common cache is already budgeted and all remaining costs are separable, (3) reduces to comparing the one or two local candidate scores. Otherwise it is a coupled finite selection problem; independently minimizing each row can miss shared setup costs. All prices are symbolic here. Equal-price, zero-setup and free-cache assumptions are not made.

The exact receipt reconstructs every base category for the all-theta64 policy and the prior N128 policy and matches both frozen inventories. It also records the all-minimum-length base counts for comparison, without selecting that policy. In the main scenario, the six new smaller-length choices reduce the listed Gaussian unit-gate upper count by1678745600, character butterflies by68286103168, and time butterflies by61264625664 relative to N128. They leave all exported grid counts unchanged. These reductions are offset by different tolerances if compared with the former theta64 choice at those rows. They are not a net runtime claim.

## 5. Admission at the newly available lengths

For every retained candidate the exact checks verify V>=2theta, 1<=cV/theta<=Wbar, all three period constraints (1), J<N/2, the complete closed prefix m+1<=N and N greater than the selected interpolation order. All minimum lengths remain at least2^18. The130 previously reviewed Gaussian/tail/circuit admissions depend on the same theta/cohort constants and continue to apply. In particular their use did not require N to equal N128.

The improved interpolation bandwidth `pi*J/N<160919/393216` is checked for every candidate. Its selected adaptive remainder therefore applies at a newly shorter length. The raw-sign version additionally retains H_omega=44/(7P), H_omega*C_U<M, the `/8` raw time allocation, and rational sign threshold109eps*P/704. The required raw sample radius is below1 at every new candidate. This is an admission theorem for a future bound array, not an ability to reuse an old longer transform or old coefficient centers. A different N changes omega and the coefficient sampling grid, so a fresh source-bound coefficient/transform certificate is required.

Raw-sign omission of output scales is optional and remains the separately reviewed interface. The base price counts keep the numerical-Y categories so they cannot disappear accidentally. If raw signs are selected, remove those categories once, preserve the actual raw widths, and add its precise sample and threshold contract. The dimension frontier itself grants no extra scale savings.

Principal obligations, both nonreal positive channels, canonical phases, actual sign/count completeness and all original theorem inputs remain unchanged. There is no new mathematical premise or production authorization.

## 6. Exact evidence and scope

Owned script `audit/small_theta_length_frontier_20261111.py` has SHA256 `10793282DD8C990CCE2C66D987115233EEE86DB7DE4237C62FD6183038E3A91B`. Its final receipt `audit/small_theta_length_frontier_final_20261111.json` has SHA256 `97DB46A0EEA2BFB064433F425D828BA309B85287A312B19BBCEE3D2C516DD78D`. It enumerates1949740 theta/row combinations and passes344678 exact checks. The1077898-byte receipt contains all44585 representatives, all18 exception groups and integer period slacks, unchanged-policy category reconciliations and the optional minimum-length counts. The earlier exploratory receipt is preserved but is not the final bound evidence.

Frozen input pins are:

| Input, relative to agents | SHA256 |
|---|---|
|prime-estimates/small_family_minimal_theta_20261111.json|25E4BF80119B05A5C0FF25BDB7AECACEBC7495B5A00097B991E11C3DBF77D422|
|audit/REVIEW_MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md|58215EA3A0D697D229AD746F6FCE340DE913165D63599DC197798E705392308B|
|prime-estimates/small_family_theta_inventory_final_20261111.json|26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69|
|prime-estimates/adaptive_small_theta_interpolation_20261111.json|3E6F184E7C7D2F13915F925C6687E3970204990035487DAC8BD41D9991C283A2|

The adaptive-order review is `integration/REVIEW_ADAPTIVE_SMALL_THETA_INTERPOLATION_ORDER_2026-11-11.md`, `EACC35D6B7B05B808C93515665D2616FC322DD65802CB67B0BB2782A150D4948`. The raw/adaptive composition is `audit/RAW_ADAPTIVE_SMALL_THETA_COMPOSITION_2026-11-11.md`, `0FF513632780E8DF9FA544E5B8AA8B919126BA8FD482D862B4761093D0996C81`, together with its erratum `36B98744446E0CC527F69C9B4F1D64A41F5CA0D5266B9ED3FA265121BECABD35` and independent review `zero-sum/REVIEW_RAW_ADAPTIVE_SMALL_THETA_COMPOSITION_2026-11-11.md`, `327E2AE13C5604079976B9A109BAF721A996F3A6C293B370B831215833570A77`. Their proof interfaces, not their output data, are reused.

This is a complete enumeration of the declared finite selectors and a qualified cost-pruning rule. It does not prove a globally optimal algorithm, actual numerical acceptance, Lean/MM0 proof size or runtime. Independent review and an explicit policy choice remain required before changing the current baseline.
