# Principal Riemann–Siegel integer replay

The first ordinate is the weakest of the 10,813 retained signs in the high slab. The other two are adjacent grid points one and two ticks higher, with a tick of 1/1024. Each of the three evaluated 3,989-term sums uses a 45-step log Horner recurrence on the 137-bit grid, regrids to 129 bits, rounds its phase to a multiple of pi and evaluates the reduced cosine with a 72-step complex Horner recurrence on a 64-bit grid. The integer evaluator constructs 3,989 amplitudes by Newton iteration, checks both bounding squares, checks all log input ranges, and tests both the reduced angle and period-quotient bound for every summand. The final signed integer is on a 128-bit grid, including an externally supplied correction on that grid.

The independent generator uses Python integers and Arb at 320 bits. For the three site-dependent theta and correction values, as well as pi, it requires the outward interval rounded to the selected grid to contain a unique integer. No per-summand inputs come from Python. The altered-integer control changes the expected result by one unit. The grouped control evaluates three points against one source cache in a single HOL term.

## Analytic accounting

For theta and pi rounded to the 139-bit grid, quotient magnitude at most ten billion, t at most one hundred million and log error at most 2^-128, the reduced angle incurs at most (1+10^10)/2^140 + 10^8/2^128. For cosine add 9/2^64 from integer Horner and 2^74/73! from truncation. With amplitudes at most one and amplitude error below 2^-64, the absolute error in the double weighted sum including the correction is bounded by twice 3,989 times (the cosine error plus 2^-64), plus 2^-129. This gives less than 4.4e-15. The analytic Riemann–Siegel tail at the first point is 4.51013e-7. The magnitude of the first computed center is 0.000358828762265.

The earlier stock-HOL theorems source_raw_log129_error, source_exp_horner_zero_error and source_raw_taylor72_error establish these local error estimates for their original operators. Connecting those operators to this signed executable, transporting the pi parity and phase Lipschitz error, aggregating the sum, and proving the three external scalar enclosures remain open. The explicit Riemann–Siegel tail inequality and critical-strip upper count also remain external. The elementary rs_negative_sign theorem expresses the last sign implication for a negative sample once analytic errors are supplied.
## Batched angle recurrence

The 64-site mesh starts at tick 102396199792 with spacing 128 ticks (1/8 height). For each of the 3,989 summands the evaluator computes the complex normalized starting phase and the exact-step approximation exp(-i log(n)/8) once. It advances the complex state by a multiply and two nearest-integer rounds per mesh step, accumulates two amplitude-weighted coordinates, and applies the common theta difference only after summing over n. At each point the correction and theta are supplied as Arb-rounded scalar integers. The test changes one least-significant unit in the last expected result for its negative control.

For m at most 64, suppose the complex starting point and unit increment have Euclidean errors at most d=10/G where G=2^64. The fixed-point rotation adds Euclidean error at most 1/G per update. From e(0)<=d and e(k+1)<=(1+d)e(k)+d+1/G, all 64 states have error below 705/G. A final theta rotation at error at most d, the amplitude error below 1/G, and the two final scalar roundings give a conservative absolute 7e-13 bound on the full main sum. This propagation is a paper error bound. The recurrence, guards and exact integer outputs are the objects of the timed HOL replay. Independent 320-bit Arb evaluated every full 3989-term cosine sum and every true Hardy sign. The largest observed discrepancy was 1.087e-17. All 64 signs lay outside the analytic truncation budget; the weakest margin was 795.6 times that budget. There were 20 sign changes and the native endpoint zero counts were 247998230 and 247998250.

Over the full pilot slab, 399 of 512 eight-height windows saturated by 1/8 spacing. The other 113 lacked 242 zeros in the sign-change lower count. Nested repair used 7,232 new sites at 1/16, 2,944 at 1/32, 768 at 1/64 and 512 at 1/128. This gives 44,225 actual sites including the 32,769 uniform sites. These counts follow from the stored native pilot stages, with monotonicity for the 108 windows already saturated at 1/4. Each repair set within a window forms a regular shifted mesh. At most 692 batches of 64 cover the slab and repairs if the initial grid is partitioned continuously and the extra meshes are kept within their windows.
## Scalar replay timing

Two independent stock-HOL processes checked all three exact 3,989-term integer centers, using the normal CV conversion and requiring a closed theorem with the original left side and True on the right. Both rejected the one-unit corruption. The second process additionally audited the interval sign implication. CPU times in seconds:

| Work | First process | Second process |
|---|---:|---:|
| Weakest retained sample | 1.610 | 1.788 |
| One tick later | 1.394 | 1.704 |
| Two ticks later | 1.429 | 1.662 |
| Corrupted expected integer | 1.470 | 1.602 |
| All three, one log and amplitude cache | 3.550 | 3.638 |
| Source cache plus length | 0.398 | 0.396 |

Peak resident sizes for the complete benchmark processes were 631384 and 624104 KiB. Startup is excluded from conversion timings. All six conversions and standard theory loading were part of the enclosing 21.28 and 22.11 seconds wall measurements.

## Mesh replay timing

| Sites checked | First CPU seconds | Fresh CPU seconds |
|---:|---:|---:|
| 8 | 3.549 | 3.534 |
| 32 | 3.732 | 3.372 |
| 64 | 4.642 | 5.036 |
| 64, last expected integer shifted by one | 4.777 | 4.600 |

The fresh mesh05 process also proved the 64 integer sign margins each exceed 10^-6 in its recorded direction, in 0.376 seconds. The complete process used 687368 KiB peak RSS and 31.28 seconds wall. The first process recorded all four successful conversions and its end marker, then failed when its source file was edited for the margin check before the interpreter closed it. Timing variation uses its completed conversions. Successful final process status, the independent corruption control and the margin check are all in mesh05.

Pricing 692 batches at the observed 64-site range gives 0.2971–0.3223 CPU seconds per zero on the high pilot mix, or 20.5–22.2 thousand CPU-hours if the ceiling rate and pilot repair distribution are used for all 248,008,025 zeros. The site-count mapping includes all observed mesh refinements. These times cover documented integer arithmetic and final expected-value checks. Analytic continuation, correction and theta certification, Riemann–Siegel remainder, and strip completeness have additional unmeasured cost. Repair density and term count change with height. The weakest retained site was chosen deliberately; these process ranges are descriptive.
## Extended mesh

The same recurrence was run on the next 512 sites beginning at the weakest retained tick. The longer interval detected 166 sign changes; the independent endpoint zero counts differed by 168. Each of the 512 signs agreed with the independent Hardy evaluator and the largest discrepancy from a direct 3,989-term Arb sum was 1.252e-16. The longer mesh contains a real missed pair even though every point sign was decisive.

For up to 512 sites the same elementary recurrence gives e(k)<=(12k+10)/G. Indeed, while e(k)<6144/G, the product (10/G)e(k) is below 1/G. The sum and final rotation then have error below 4e-12. This is a conditional propagation argument; its HOL complex-error transportation and the site-dependent analytic scalar enclosures remain separate premises.
The single 512-site conversion did not yield a theorem within either bounded attempt. The literal-quotation process produced the 128- and 256-site theorems in 9.473 and 18.786 CPU seconds before it was stopped at 480.55 seconds total wall and 2,097,196 KiB peak RSS. A separate compact loader constructed the same 512-site input term directly from decimal records in 0.229 CPU seconds. It was stopped after 414.34 seconds total wall (408.76 CPU seconds) and 2,097,016 KiB peak RSS without finishing the conversion. Both used a 4-GiB virtual-memory cap. The similar observed peaks identify a practical resource threshold in these configurations; they do not isolate the internal cause. The pilot forecast therefore uses the checked 64-site times. Longer single-packet arithmetic has no demonstrated speed advantage.
The final 512-site audit used four contiguous 128-site packets with independently restarted phases. All four theorem checks passed. They took 7.116, 8.104, 7.942 and 8.395 CPU seconds, or 61.6 milliseconds per site. Including startup, reading and receipt checks, the single process used 38.77 CPU seconds, 45.82 wall seconds and 1,756,904 KiB peak RSS. The largest discrepancy between any packet center and a direct Arb sum was 2.693e-17. All 512 signed sites and their real grid locations agree with the original single-group proposal. See 512-audit.json for the validated checksums.
