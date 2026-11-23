# Two linked time-FFT stages at conductor 10000

HOL4 exported four closed theorems, one per tile at 2, 512, 1026 and 1318. Together they check 449 requested grid-220 raw enclosures at 174 distinct time indices for labels 3, 6667, 11 and 9091. The tile counts are 118, 48, 50 and 233. The exported object is `.hol/objs/QuarterBridgePilotTheory.dat`. The build log is `q01_pilot.log`.

The input consists of rounded quarter-transform components for the live lanes and a high-precision twiddle at each live index. The checker squares the twiddle internally, bounds its rounding error, and checks the recombined real even component and the real and imaginary odd components against the exact operand term extracted from the archived final-butterfly theorem. It also checks both components of that theorem’s twiddle. Each exported theorem conjoins these checks with the reloaded final-butterfly result. This moves the external numerical boundary back one radix stage. The quarter transforms originate in the external Arb calculation in `quarter_prepare.py`. A full HOL proof still needs the upstream transform and a general real-enclosure interpretation of the integer predicates.

| Timed operation | CPU seconds |
|---|---:|
| Read four predecessor archives | 0.448 |
| Quote new quarter-transform inputs | 0.964 |
| Assemble checker arguments | 0.006 |
| Evaluate new integer checks | 0.545 |
| Finish and store linked results | 0.418 |

The full pilot build used 49.62 s wall, 21.15 s process CPU and 909,544 KiB peak RSS. The external quarter-transform preparation took 24.50 s wall and 24.08 s CPU. The four-label sparse run in `FULL_REVIEW.md` already charged the final butterfly. Reusing its archives in this pilot measures the additional predecessor check. Quoting numerical intermediates is an expense of this benchmark boundary.

The original schedule row is `scenarios[0].small_sign_only_conditional_candidate.totals.time_butterflies` in `work/qrh-campaign/agents/prime-estimates/sign_only_minimal_theta_nonprincipal_schedule_20261111.json`. It counts 89,858,217,607,168 butterflies. The conductor-10000 raw metadata row has transform length 524,288 and p243. A dense four-label circuit has 1,048,576 butterflies per stage. All selected indices lie in the first quarter, so the 71,325 requested final outputs consume 71,325 distinct final butterflies and 142,650 distinct preceding butterflies. The four-tile pilot covers 449 and 898 respectively. Twiddles can be shared across labels at coincident indices. The lane values still require separate arithmetic.

The 16.894 s CV cost in the 71,325-output run covers the selected final butterflies and their raw enclosure checks. Its 41.590 s read/quotation cost measures standalone admission. A pipeline that already supplies those operands internally should charge its own handoff once. The 104,318-hour tiled convolution alternative in `small-time-nonproduct-price/README.md` uses a different circuit. Its extraction/postchirp/rounding row includes operations absent from this pilot. Neither that row nor the entire dense time-transform bill has a justified scalar hourly deduction from these four tiles.
