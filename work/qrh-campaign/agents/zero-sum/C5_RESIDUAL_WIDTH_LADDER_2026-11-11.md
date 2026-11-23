# Fixed-width expansion of the four conductor-5 residual models

2026-11-11. Exactly32 panel evaluations were performed, with no refit, new center, new boundary search or complete contour claim. The unchanged candidate admits substantially wider certified panels at the three left-edge centers. The right-edge center is already at its geometric width limit. Failures below are failures of sufficient upper bounds, not detected zeros or lower bounds on the exact residual.

## Protocol fixed before evaluation

The four centers and the385-pole candidate are those of the accepted `C5_RESIDUAL_TAYLOR_PANELS_2026-11-11.md`, SHA256 `91AFE6E39AE15CC85DC5A8C7E74D18A8CFBF60F2106DACD361946002A43D371A`, independently reviewed at `EAB2CD5C2F08E7400C8565DB2B4C4361F50E7A2F7C58D39F67F1C7333CA23CFA`. The candidate receipt remains `02C623629D3DF9218AFB7689F39698AF5C4F4D6FB6776056C4B275220D148E6E`.

The proposed half-width ladder, sent before execution, was

    rho = 1/2048, 1/1024, 1/512, 1/256, 1/128, 1/64, 1/32, 3/64.

It was applied once at each of the same four centers, for32 evaluations total. Each test is the entire vertical segment from center-i*rho to center+i*rho, with the orientation of its original edge. No adaptive widths, alternate degrees or additional centers were tested. The finite-g and rational-candidate degrees stay12; their product residual degree stays24; the finite-g control radius stays1/4. Computation uses192-bit balls with the inherited128-bit constant enclosures.

| Saved center identifier | Exact center | Geometric half-width limit | Certified distance to nearest candidate pole, approximately |
| --- | --- | --- | ---: |
|29999|111/200 - (67569/16384)i|129039/16384|.0550076|
|3871|111/200 + (93051/8192)i|5253/8192|.0573462|
|457|2 - (765/64)i|3/64|1.500081|
|24860|111/200 + (3/2048)i|24573/2048|.0550195|

All32 tests are geometrically admissible. Every half-width is at most3/64, strictly below11/200, the uniform horizontal pole clearance, and below1/4. At center457 the largest segment touches the original bottom endpoint2-12i exactly; a larger symmetric segment would leave the authorized rectangle. Its smaller ladder entries are therefore width comparisons rather than expansions beyond the previous largest panel.

The radius1/4 belongs to the finite entire EM function's Cauchy estimate. It is NOT a claimed pole-free radius for the rational candidate. The candidate Taylor remainder uses its separately checked pole distances and rho<distance. At left centers the finite-g outer disk uses the actual sigma floor61/200; each target-disk EM bound is recomputed with111/200-rho. No bound valid only at real part111/200 is reused on a wider disk. These analytic control disks do not themselves receive nonvanishing or spectral claims.

## Result

The l1 test passes28 of the32 panels. The direct interval-convolution T16 test passes27. Here is the largest passing width on this fixed ladder, not a claimed optimum:

| Center | Largest l1 half-width | Full segment length | l1 upper at that width | Largest raw T16 half-width |
| --- | --- | --- | ---: | --- |
|29999|1/32|1/16|.775917|1/64|
|3871|1/64|1/32|.455232|1/64|
|457|3/64|3/32|.024519|3/64|
|24860|1/32|1/16|.175291|1/32|

Every smaller ladder width passes the l1 test. Center29999 fails the l1 sufficient bound at3/64, with upper9.040273. Center3871 fails at1/32 and3/64, with upper2.335660 and15.743634. Center24860 fails at3/64, with upper1.600921. No domain or pole-clearance test failed. The receipt contains all exact rational upper bounds, rather than only rounded numbers or the largest successes.

The discrepancy between l1 and raw T16 at center29999,rho=1/32 is demonstrably interval overestimation in the convolution-power evaluation. For the exact primitive-supported residual there are exactly three character channels, so

    T16 = sum_{k=1}^3 |rhat_k|^32 <= 3 ||r||_1^32.

The saved l1 bound therefore gives another rigorous T16 upper bound. A separate exact Fraction-only postprocessor takes the minimum of this propagated bound and the raw interval-convolution bound. It performs zero new panel evaluations. This certifies T16 on the same28 panels as l1, including center29999,rho=1/32. The raw failing result is retained and labeled; it is not silently replaced in the primary receipt.

## Error sources at the width limit

The same proved error decomposition as the accepted four-panel packet is used:

    E_L = E_actual_L_minus_g(rho) + M_g (rho/R)^13/(1-rho/R),
    E_res,k = E_L (P_bound,k + E_B,k) + G_bound,k E_B,k.

The rational-candidate tail is

    E_B,k = sum_p |w_kp| rho^13 /
                     (|s0-p|^13 (|s0-p|-rho)).

Jets and degree24 residual coefficients are cached once per center. Every width recomputes its own actual-L error, finite-g Cauchy tail, rational tail, polynomial bounds and image enclosure. Only exact width-independent data are reused.

At rho=3/64, the left-center finite-g Taylor tails are less than2.860e-8. Their actual-L-minus-g errors are less than2.3e-38, and much smaller near the real axis. These errors are not the main size obstacle at that width. The respective largest rational tails at centers29999,3871,24860 are approximately13.482,1.103,.214; their largest residual analytic errors are approximately1.487,1.329,.136. The factor1/(pole_distance-rho) and the degree12 geometric tail deteriorate sharply as rho approaches the nearest pole distance.

At center3871,rho=1/32, however, the largest residual analytic error is only.002720 while the l1 upper bound exceeds2.33. The scalar error disks add at most sqrt(2)*sum_k E_res,k to the group l1 enclosure. Thus their contribution is below.012 there. Most of this failed upper bound is in the degree24 polynomial range enclosure, not in the explicit analytic tails. The saved data do not decide how much comes from actual polynomial variation and how much from interval Horner overestimation. Raising the Taylor degree alone is therefore not established as a cure.

At the right-edge center457, the rational poles are much farther away. Its largest-width rational tail is below2.268e-20, and residual analytic error below1.672e-9. That test passes comfortably; geometry, rather than the tested analytic bound, stops symmetric expansion there.

The common finite-g control bound is exactly the accepted one with the absolute-log treatment of initial Hurwitz bases below1. Negative-log terms are not bounded at the wrong real endpoint. The residual is still the actual1-L_k(s)B_k(s); no sampled fit error or candidate correctness is assumed.

## Cost and scope

The one author run recorded.15513 seconds preparing the four cached models and.09284 seconds evaluating all32 widths, with.26110 seconds total after imports. These are one-run measurements, not a production forecast. Different widths reuse the same center models; a fresh complete boundary would need many new centers and could encounter different behavior.

Recorded source-loop counts are1048 truncated-series exponentials for the four finite-g jets,60060 rational-jet coefficient products,20020 inverse-power updates,2028 products to construct residual polynomials, and128 four-component convolutions containing2048 products for the32 raw T16 tests. There are4 outer control-bound calls and32 width-specific control-bound calls, plus36960 width-specific rational-tail summands. Four rational-tail calculations made while constructing the initial jets are discarded and explicitly counted. Scalar error-bound exponentials, interval operations and input preparation are additional costs. There are no extra actual-L point calls or old-bound recomputations in this run.

The author performed one32-panel numerical pass, respecting the hard cap. The later postprocessing uses only exact saved rational bounds. The numerical script provides a read-only `--recompute` mode for independent review; it was not used to add another author pass within this experiment.

The result supports testing cached centered residual models in a future separately capped complete conductor-5 attempt. Full width1/32 passes at these four centers, but this is not a uniform boundary-width theorem. No count of sufficient global panels or successful complete contour follows. The earlier capped global receipt remains incomplete. Any later run must retain the exact candidate, check every new panel, refine or stop on failures, and prove full closed-boundary coverage before applying the global inverse argument.

## Frozen files

* `c5_residual_width_ladder_20261111.py`: SHA256 `BF30372824E93C45FD61BF952E8ACB6B30DB9ABF380AE9C4692DEE3E8425A3F3`.
* `c5_residual_width_ladder_20261111.json`: `7B0138E4C9455A844ADD83D8EF8ED078A933682AF58A26D24F819ABA85E1142C`,153396 bytes.
* `c5_residual_width_summary_20261111.py`: `45FF286131CCEBC6C1BBDA4076B08B2661B4BB59357712BFE690BB3C1E68C1B1`.
* `c5_residual_width_summary_20261111.json`: `5C1506DE710E57307665A2138E8E795C1D3533D439F87CB7BB1CDD278AB31194`.

The primary receipt pins the accepted parent code, parent receipt and unchanged candidate, and records coefficient hashes, exact panel endpoints, all error components and the32 pass/fail outcomes. The exact postprocessor pins that primary receipt. Both programs accept `--recompute` for read-only comparison; only the numerical one reevaluates panels. No builtin special-function oracle, new spectral premise, Lean build or dependency change is used.
