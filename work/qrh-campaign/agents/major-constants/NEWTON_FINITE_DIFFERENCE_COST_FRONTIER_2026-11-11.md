# Newton finite-difference cost frontier

2026-11-11. Exact metadata and conditional arithmetic schedules only. No coefficient, function, prime or transform values were evaluated; no Lean declarations or builds were made. Frozen predecessors are unchanged.

The useful conclusion is a price inequality for each conductor and active height band. The accepted ten-guard extension enlarges the valid polynomial domain, but it does not establish savings. In particular, the newly admitted third-band cohort fails even the equal-general-product, otherwise-free screen. The first two bands have conditional candidates, with explicit reserves from which every omitted cost must still be paid.

## 1. Fixed schedule and domains

Use the ties-down, full-state schedule of the exact circuit and Newton initializer, not the separate trimmed or unit-run schedule. Write F=2D_out, r=phi(c), b for the number of nonempty all-numerator buckets and a=c-1-b for the number of numerator advances. Every integer numerator 1 through c-1 is traversed inside its bucket, including nonunits and buckets with no unit output. Only the r unit numerators are exported.

The two separately recorded domains are

    old_guard: c>20F;
    new_only: 10F<c<=20F.

The second has its own accepted source-domain and integer-width proof. Neither domain changes the in-cell analytic target or permits extrapolation of that target. Auxiliary Newton arguments are arguments of an exact finite polynomial only.

For all conductors, the exact bucket count is c-1 if c<=F, and otherwise

    b=F-1 + 1_{c>=2F} + 1_{c>2F}.

Indeed the interior anchor intervals partition the numerator range, while the two endpoint intervals first acquire a numerator at c>=2F and c>2F respectively under the asymmetric tie convention. In either admitted domain, b=F+1. The source occupancy receipt supplies the full interval formulas and endpoint checks; the new script independently recomputes its aggregate totals.

Per bucket, Newton initialization has 190 general products, 357 additions after the prescribed binary expansion of small factors, 357 shifted-operand occurrences and 19 coefficient prescales. Traversal adds 19 operations per advance. This gives the following per-height schedule for one conductor:

|Type|Count|
|---|---:|
|General products|190b|
|Wide additions|357b+19a=338b+19(c-1)|
|Shifted operands|357b|
|Coefficient prescales|19b|
|Bucket setup/binding instances|b|
|Final complex conversions|r|
|Original complete rounded Horner stages|19r|

These are vector or complex-coordinate schedule labels inherited from the source circuit, not a claim that one such operation equals one machine instruction. A scalar-coordinate backend must expand both competitors consistently.

The old guard has signed live-state/Newton-intermediate bounds b_grid+400 bits and advance temporary bound b_grid+401. The new-only guard has b_grid+406 and b_grid+407. Thus the respective pairs are 500/501 and 506/507 on the optional b_grid=100 representation, or 522/523 and 528/529 on b_grid=122. General integer factors remain below 2^19. These are maximum widths, not widths of every partial-degree product. Exact degree-dependent pricing may replace the coarse prices below. Final conversion is performed only in-cell and keeps the original final-rounding contract.

## 2. Exact price test

Fix a conductor, band, admitted coefficient representation and backend schedule. Let w>0 be the number of active height nodes in that band. Let C_H>0 price one complete stage of the selected original rounded Horner comparator. This includes precisely the stage operations being replaced; it must not be identified with a general integer product without a separate backend model.

Let C_G,C_A,C_S,C_P,C_K,C_R be nonnegative prices for the six new rows above, with C_R the final complex conversion price. Let T cover additional differential geometry, binding, source conversion, storage, traffic, cache, policy and proof-reconstruction costs that are not already included in those prices. Let D be a separately justified baseline-only cost credit. Both T and D must be explicit; the supplied core projections set neither to an inferred measured value.

For this fixed charged schedule, the exact saving is

    Delta = 19wr C_H + D
      - w[190b C_G +(357b+19a) C_A +357b C_S
            +19b C_P+b C_K+r C_R] - T.                 (1)

Choose Newton only if Delta>0. Equality uses the fallback. Identical work cancels once, rather than appearing as both a new cost and a baseline credit. In particular the separately evaluated alpha^(-s) term, downstream character transforms and sign/completeness processing are unchanged by this local replacement.

If only upper prices for Newton and a lower price for the comparator are available, positivity of the corresponding lower bound for Delta is sufficient. Subtracting two unrelated upper cost bounds does not prove a saving. This note's exact examples compare specified charged schedules, not elapsed time or merely asymptotic upper bounds.

Normalize p=C_G/C_H, z=C_A/C_H, s=C_S/C_H, v=C_P/C_H, k=C_K/C_H and f=C_R/C_H. With D=0 and T/C_H=t, (1) becomes

    w[(19-f)phi(c)-190pb-(357b+19a)z-357bs-19bv-bk]>t. (2)

In either guard it can equivalently be written

    (19-f)phi(c) > 19z(c-1)
       +(F+1)(190p+338z+357s+19v+k)+t/w.              (3)

This is the requested conductor/band price frontier. All prices may depend on conductor, degree, band, grid and guard tier. Formula (2) is a coarse specialization if the component widths are charged by a single price; an exact implementation may substitute sums of degree-specific prices. At f>=19 there is no strict saving in this nonnegative-price, zero-credit model. For other fixed prices, the sharp allowed wide-add price is

    z < [w((19-f)phi(c)-190pb-357bs-19bv-bk)-t]
          /[w(357b+19a)],                            (4)

when its numerator is positive. This exposes the cost of traversing nonunits rather than hiding it in the output count.

The familiar phi(c)>10b condition is exactly (2) only in the artificial projection p=1 and all other costs zero. It is an optimistic necessary screen for that projection, not sufficient priced eligibility. In a different product-price model its threshold changes. The ten-guard theorem validates the polynomial geometry when that screen holds; it does not remove the remaining terms of (1).

## 3. Setup and representation sharing

Geometry powers and conductor-dependent factors can be prepared once per conductor/band when the chosen implementation permits that sharing. The receipt separately counts these instances and the bucket/height instances. Source arrays vary with height and anchor. The optional b100 construction requires 20 complex coefficient conversions per DISTINCT selected source polynomial, with source/grid/cache identity checked. Its independent analytic/grid admission is separate from the occupancy calculation. A norm-error bound alone does not imply any common grid.

If conversion caching is not used, a conservative actual schedule converts 20 coefficients per bucket per height, and the receipt records 20 times its weighted bucket count. If caching is claimed, replace that schedule by the cardinality of the actual source-object union and charge lookup, retention and any rechecks. Do not count both schedules. The conductor-dependent v^i prescales cannot be shared merely because the source array is shared.

A source-object cache can couple conductor choices. Consequently, independent positive-Delta selection is optimal only within the model where all differential costs have already been assigned to independent conductor/band decisions. In that model, maximizing total saving amounts to summing max(0,Delta); this is a piecewise-linear convex function of prices, with piecewise-constant selected subsets. It is not a global optimization theorem for a shared-cache or memory-constrained evaluator.

A prospective rounded-product/exact-add b100 Horner circuit is a different comparator. Its narrower accumulator could change C_H and baseline extras. This frontier keeps C_H symbolic so that such a reviewed competitor can be inserted without pretending its price equals the older rounded Horner stage.

## 4. Exact occupancy reconstruction

The script reconstructs phi by divisor inversion, not by prime testing. It reconstructs all 125400 conductors, sum phi=7133015232, and their reviewed odd/even target heights. For each e in {0,167,320,640}, it clips each conductor's last index to the five source bands and compares all active, height-weighted unit, bucket and advance totals with the accepted occupancy receipt. These four scenarios are alternatives, not quantities to add together. No auxiliary closure success is asserted.

Main-scenario guard totals are:

|Band|Guard|Active c|Weighted r|Weighted b|Weighted a|
|---|---|---:|---:|---:|---:|
|1|old|117540|44119273211886|760739845375|81144760923925|
|1|new-only|7680|510088341652|50388672000|704687626240|
|2|old|75886|8363159673304|420881436633|16025257581492|
|2|new-only|15360|2038320170068|201331496433|2816680559655|
|3|old|0|0|0|0|
|3|new-only|9696|781932802080|150703417062|1778615932640|

Bands 4 and 5 have no admitted guard cohort in the main scenario. The JSON retains all four scenarios, including any changed activity under auxiliary extensions. Each guarded cohort has separate operation fields, and no cost selection merges its widths with another cohort.

The metadata also records 18 core-price sections, p in {1,2,4}, z in {0,1/16,1/4}, f in {0,1}. They select strict positivity of

    w[(19-f)r-190pb-(357b+19a)z].                      (5)

This is a projection before shifts, prescales and other costs. Positive (5) is the SAME remaining reserve from which all those costs must be paid. It is not yet a positive value of (1). The parameters may be different in the old/new width classes; assigning the same numbers in a table is a hypothetical price choice only.

For orientation, selected conductor counts in the main scenario are:

|Band/guard|p=1,z=0,f=0|p=1,z=1/16,f=1|p=2,z=1/16,f=1|p=4,z=1/16,f=1|
|---|---:|---:|---:|---:|
|1 old|116000|112744|98504|65994|
|1 new-only|3613|2048|0|0|
|2 old|72807|66314|38571|2437|
|2 new-only|7240|4095|0|0|
|3 new-only|0|0|0|0|

For p=1, z=1/16, f=1, exact main reserves in units of C_H are respectively

    8606216840996633/16, 11014866903278/16,
    774162402185283/16, 43979653031284/16, 0.

The JSON includes the complete selected operation vectors alongside each reserve so the omitted costs can be priced against it. Aggregate reserve can justify a chosen aggregate schedule if every included cost is charged, but it does not prove that every member individually remains profitable after those costs. A backend requiring per-conductor savings must reevaluate (1) per conductor.

## 5. Verification and status

The author script completed 2065413 exact assertions. It checked the six input hashes, family/totient totals, every source-cohort occupancy total, guard bucket identities and all projected reserve identities. Its output includes a digest of the ordered guarded conductor-band records. These checks involve integer metadata only; they do not certify any source coefficient or primality claim.

The present result makes a cost-aware adoption test concrete and identifies where the extra domain can matter. It does not price large-integer arithmetic, final division, proof checking, memory or source conversions. No runtime forecast, production choice or saved end-to-end operation total follows without those inputs. In particular the new third-band geometry produces no candidate in even the most optimistic listed price section.

Pins below are relative to work/qrh-campaign/agents. The script embeds and checks the six predecessor pins; the note/script/receipt form a new packet.

|Artifact|SHA-256|
|---|---|
|prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md|99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1|
|prime-estimates/large_residue_bucket_occupancy_20261111.json|19E0AC3EB1F860A38151F46F792595DEDE7BA7D0180A244425C6C969EFBF58DB|
|prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md|55576F70A22E3B94108C80CE6255D312437085E08281EFC6FBA34E65147E22BC|
|moebius/REVIEW_NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md|995BADD0DDBA1F915A768DC34AAEE70BD9E356EE73A665594A6871ECAC83E234|
|major-constants/RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md|AFA91F89C51BFC62FAB135997C6ED9FC7FCEAE3FBF6062F973F65AE69ADAC054|
|independent-feasibility/REVIEW_RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md|0FC1801726CE19F28E0B512C3B24FA8D88B1531E3360E8566A1A799A8F955711|
|major-constants/newton_cost_frontier_20261111.py|3AD9E2B2C9A6F35649CB9CDA86A4876C40442B54C07E01B746854CBD3B5AFC4E|
|major-constants/newton_cost_frontier_20261111.json|81853F0B8E8994AA81ABC711667C9F29E2018C579A82860FEC97B35CAFF1DD3F|
