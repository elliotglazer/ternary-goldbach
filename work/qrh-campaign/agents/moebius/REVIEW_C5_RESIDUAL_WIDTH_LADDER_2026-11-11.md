# Independent review of the fixed conductor-5 width ladder

2026-11-11. **PASS as a bounded32-panel experiment. No correction required.** The frozen candidate, centers and width ladder are preserved. Every evaluated panel is on the original rectangle, and all analytic control and pole-distance conditions hold. The author obtains28 l1 passes and28 moment passes after exact propagation from l1. These local results do not complete the boundary.

## Pinned evidence and replay

The reviewed note is `../zero-sum/C5_RESIDUAL_WIDTH_LADDER_2026-11-11.md`, SHA256 `E853FB47AEF9BD98D101590E30594299868BCBAAE5F11DCA59FB1111397B0DA2`.

The numerical script has SHA256 `BF30372824E93C45FD61BF952E8ACB6B30DB9ABF380AE9C4692DEE3E8425A3F3`; its receipt has SHA256 `7B0138E4C9455A844ADD83D8EF8ED078A933682AF58A26D24F819ABA85E1142C`. The exact postprocessor has SHA256 `45FF286131CCEBC6C1BBDA4076B08B2661B4BB59357712BFE690BB3C1E68C1B1`; its receipt has SHA256 `5C1506DE710E57307665A2138E8E795C1D3533D439F87CB7BB1CDD278AB31194`.

I ran both read-only `--recompute` modes. All numerical non-timing fields and all exact postprocessor fields reproduced. These review replays do not introduce new panels or amend the author's one32-panel run.

The independent script `review_c5_width_ladder_20261111.py` has SHA256 `49BE9A832A0CAB7CE73BEC25E6A22CD519D6C6B864644DC5DCD3AF7BF1177612`; its receipt has SHA256 `72CA843998D76FEDEC39F7F1A64A29DDFED5CA8D7EFA2249CB4A1CA5D98F239D`. It pins the five author files, checks exact geometry and cached coefficient hashes, independently checks the saved rational moment propagation, and evaluates the same32 panels using the alternate rigorous model from the preceding independent review. No extra width, center, fit, subdivision, or contour sweep is introduced.

## Exact domains and cached data

The centers are exactly those in the accepted four-panel receipt. Their x-coordinates are111/200 or2. The eight half-widths are exactly

`1/2048,1/1024,1/512,1/256,1/128,1/64,1/32,3/64`.

The independent check verifies all32 oriented endpoint pairs, their order on the relevant vertical side, and their containment in the original height range[-12,12]. On the left edge they are oriented downward; on the right edge they are oriented upward. At center457, the largest half-width3/64 is exactly the distance to the lower endpoint-12. A larger symmetric width there would leave the original boundary. Smaller entries at that center are contractions relative to the original panel, as the note explains.

For every entry, `rho <= 3/64 < 11/200 < 1/4`. The middle value11/200 is the horizontal clearance from the left edge to every fixed pole on Re(s)=1/2. It follows immediately that every panel disk is pole-free; the per-pole numerical lower-bound checks give the same conclusion. All width entries satisfy the finite-g Cauchy-radius condition as well. No test failed for a geometric or pole-domain reason.

The finite-g Cauchy disk remains radius1/4, with the actual outer sigma floors61/200 at the left centers and7/4 at the right center. The candidate's rational Taylor disk has its own pole-distance check; the code does not confuse these two domains. The actual L-minus-g error is recomputed on each panel disk using Re(center)-rho. Thus a bound valid only at111/200 is not reused on a disk extending leftward.

The independent script verifies all12 cached coefficient hashes: finite-g, rational-candidate and residual coefficient arrays at each of the four centers exactly match the accepted four-panel receipt. These coefficients do not depend on width. The width-dependent Cauchy tail, actual L error, rational tail, polynomial norms and residual image are recomputed. The four initially computed rational tails at the smallest width are discarded, and that extra work is explicitly recorded.

The analytic justification is the one already reviewed at `REVIEW_C5_RESIDUAL_TAYLOR_PANELS_2026-11-11.md`, SHA256 `EAB2CD5C2F08E7400C8565DB2B4C4361F50E7A2F7C58D39F67F1C7333CA23CFA`: actual entire L-functions, a finite entire EM approximation with explicit remainder, Cauchy control for its omitted Taylor coefficients, exact rational-pole Taylor tails, and the cross-term-inclusive product-error inequality. No new spectral premise enters this width calculation.

## Results and moment normalization

The largest passing l1 half-widths on this *tested ladder* are:

| Center identifier | Largest l1 half-width | Full segment length |
| --- | --- | --- |
|29999|1/32|1/16|
|3871|1/64|1/32|
|457|3/64|3/32|
|24860|1/32|1/16|

Every smaller ladder entry passes the l1 test. These are not proven optimal widths. The four l1 failures are29999 at3/64,3871 at1/32 and3/64, and24860 at3/64. A failed sufficient upper bound is not a lower bound for the actual residual and does not exhibit a zero.

The direct interval-convolution moment calculation passes27 entries. At29999,rho=1/32 it fails even though the l1 upper bound is below.776. The exact normalization is

`T16=sum_(k=1..3) |rhat_k|^32`.

Since each positive character transform has norm at most||r||1, the independent exact check verifies the valid alternate bound `T16<=3*(l1_upper)^32` on every row. Taking the smaller of the two proven upper bounds is sound. It restores the28th moment pass. The raw failure is kept in the primary receipt and is not relabeled as a successful direct convolution calculation. The postprocessor performs no additional numerical panel evaluations.

## Independent alternate model

The independent implementation reuses its already reviewed explicit polynomial arithmetic, with N80/M24, degree14, radius1/8 and224-bit freshly computed constants. It uses coefficient-sum bounds on disks and direct scalar residual moments; it does not use acb_series, a builtin special function, or the author's group-convolution computation. It checks only the same32 width entries.

It obtains28 l1 passes, matching the author's l1 classifications, and29 direct scalar-moment passes. The additional alternate-model moment pass is at24860,rho=3/64: its rigorous upper bound is less than`1.142e-5`, although its l1 sufficient bound is greater than1.627. This is possible because a moment bound can pass when an l1 bound does not. The alternate model's scalar residual caps prove this one local result without interpreting the author's failed upper bound as false. The author's frozen degree12 classifications are unchanged.

This extra observation covers an already tested local panel only. It supplies no new center, interpolation between centers, or full-boundary certificate. It also does not establish that increasing degree alone caused the improvement: the independent model changes several enclosure choices.

## Error-source discussion

The author correctly distinguishes finite-g truncation, actual-L approximation, rational-candidate truncation and polynomial range enclosure. Its saved components support the quantitative statements in the note.

At3871,rho=1/32, the explicit analytic error disks add at most `sqrt(2)*sum_k E_res,k` to the group l1 upper enclosure. The factor arises because an error disk is inserted as a square, and the inverse transform has four output components each carrying a1/4 factor. Independently, using the rational upper boundsqrt(2)<283/200 gives an exact contribution below.005717, hence below the stated.012. This is small relative to the recorded l1 upper bound above2.33.

It is therefore valid to say that most of that failed upper bound comes from the polynomial-range enclosure, rather than the separately inserted analytic tails. It is not valid to infer from these data alone how much of that polynomial range is true variation and how much is interval overestimation. The author makes that distinction explicitly. Likewise the large rational Taylor tails near the maximum width show deterioration of this particular geometric remainder bound; they do not prove large actual residuals or a lower bound on the best possible enclosure.

## Counts, limits and conclusion

The source loops support the listed counts: four finite-g jet builds and four rational jet builds,1048 truncated-series exponential calls,60060 rational coefficient products,20020 power updates,2028 residual-polynomial coefficient products,32 width-dependent analytic controls,36960 rational-tail summands, and128 four-component convolutions with2048 complex products. Additional scalar bound arithmetic, imports and initialization are excluded and disclosed. The postprocessing consists only of exact rational operations on saved bounds. There are no extra actual-L point evaluations or old-bound comparisons in this width run.

The short timings measure this cached, four-center experiment. They are not a global throughput bound. In particular, a common tested full width1/32 at these four locations does not imply such a width works at every boundary point. No number of globally sufficient panels, complete contour, Hcert result, family result, or Lean theorem follows. The predecessor global receipt remains incomplete.
