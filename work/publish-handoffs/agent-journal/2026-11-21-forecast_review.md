# forecast review — 2026-11-21

## 22:15:03 UTC · Final

The $10,000 cap funds 136,426 useful CPU-hours, or 27.1 days at the assumed sustained throughput. A Saturday noon start gives the team 45 hours before Monday at 9 a.m. Pacific, enough for 9,450 useful CPU-hours and at most 360 agent-hours.

The large-\(n\) integration is the only route with a plausible Monday delivery, conditional on the existing proofs composing. The new 25-page argument has no measured proof-authoring rate. The finite fallback’s 60,000-CPU-hour median costs $4,398 and reaches Thursday, December 3 in the morning if production starts Saturday noon. The HOL4 subtotal alone costs $57,174.

Report a probability of finishing under budget alongside any **conditional** 90% completion interval. If failure under the cap has probability greater than 5%, the unconditional 95th percentile is infinite. The available estimates do not support calibrated probabilities for proof completion.

## 22:17:17 UTC · Final

At a 780,000-core-hour subtotal, the remaining 20,000 hours allow **16.55 milliseconds per primitive character** across 4,351,723,951 characters for all unfinished work. If 1% needed two additional CPU seconds each beyond the repairs already priced, those repairs alone would cost **24,176 core-hours**. This shows how the cap could be exceeded. The measured data do not establish how likely that outcome is. [Character census and audit](work/backend-costs-20261112/hol-platt/historical-scope-independent/REPORT.md)

The full-height trial covered four preselected characters at conductor 10,000. Ninety interior probes recovered 178 missed crossings, and 24 additional probes checked edges. Both inverse pairs closed conditionally at width 50. The compressed-grid timing already includes the 114 repair checks. The cost of characters that require additional work after this procedure remains unmeasured. [Full-height trial](work/backend-costs-20261112/hol-platt/full-height-count/README.md) · [Cost ledger](work/backend-costs-20261112/hol-platt/campaign-cost-ledger/README.md)

## 22:18:45 UTC · Final

At conductor 10,004, a native benchmark tested all 2,301 primitive characters over 15 high intervals. Midpoint checks found 26 additional crossings across 13 of the 27,620 intervals with equal endpoint signs. Computing and checking those midpoints took 40.641 CPU seconds. The receipt measures recovery on that grid. It leaves open how many crossings remained undetected and how much additional work a full-height HOL4 count would require. [Second-modulus receipt](/work/backend-costs-20261112/hol-platt/c10004-grid-repair/README.md)

For a second full-height trial, use conductor 10,004 and preselect one primitive inverse pair of each parity, four channels total. Freeze the selection and main height before examining signs. Run to the scheduled main height with 320 extra nodes, extending to 640 for unresolved counts. Set a local spending limit of four CPU-hours for the first pass and four more for retries. Record shared setup, discovery, formal checking and retry costs separately, alongside the final Turing margins and every unresolved channel. This would measure whether the method transfers to a second conductor. Four channels would still leave campaign-wide tail risk unquantified.

## 22:23:05 UTC · Final

The conductor 10,004 benchmark is frozen. The even inverse pair is **6559 and 7707**. The odd inverse pair is **5499 and 7659**. Each pair had the lowest preregistered SHA-256 digest among 575 eligible pairs of its parity.

The main height is **6,578**, with final grid index 84,199. The two auxiliary windows end at heights 6,603 and 6,628. The local preflight verified the character inventory, modular inverses, frequency convention and grid endpoints. Full-height evaluation remains pending. [Frozen receipt](../../../work/grh-goldbach-20261120/team/q10004-freeze.json) · [Reproducible selection](../../../work/grh-goldbach-20261120/team/freeze-q10004.cjs)

## 22:30:09 UTC · Final

The conductor 10,004 block passed. All four frozen characters had strict signs at 16 endpoints and 15 midpoints, for **124 certified native interval signs**. The endpoints gave 12 sign-change brackets. The midpoint checks found no additional brackets. All 12 independent 288-bit direct L-function sign checks agreed.

The shared transform and sign calculation took **9.05 CPU seconds** using saved source values. Phase setup took 0.19 seconds and the independent checks took 301.44 seconds. Full-height counting and HOL4 replay remain unverified. [Measured receipt](../../../work/grh-goldbach-20261120/team/q10004-block.json) · [Benchmark code](../../../work/grh-goldbach-20261120/team/q10004-block.py)

## 22:37:39 UTC · Final

The full-height Gaussian pilot closed both frozen inverse-character pairs at conductor 10,004 and height 6,578, conditional on the analytic sign and Turing bounds. The width-50 window gave counts of **31,752** for the even pair and **31,751** for the odd pair. Their upper bounds exceeded the observed counts by 0.91922 and 0.91234 respectively, both below one. The width-25 window missed that threshold with the same allowance. [Count receipt](../../../work/grh-goldbach-20261120/team/q10004-gaussian/counts.json)

The run took **289.91 local CPU seconds**, including 16 independent L-value normalization checks. It evaluated 339,360 coarse signs. Ninety-three interior probes recovered 186 main crossings beyond the endpoint-corrected counts. All 124 signs from the independently computed high-grid block agreed after accounting for the constant phase sign of each pair. This is a native interval-arithmetic result. HOL4 replay and the repair-cost distribution across other conductors remain open. [Grid receipt](../../../work/grh-goldbach-20261120/team/q10004-gaussian/grid.json) · [Independent comparison](../../../work/grh-goldbach-20261120/team/q10004-gaussian/crosscheck.json)

## 22:44:55 UTC · Final

Stock HOL4 accepted the conductor 10,004 count packets and exported both theories. At the exact height of **6,578**, the width-50 guard passed for the even pair with **31,752** brackets and the odd pair with **31,751**. The width-25 guard failed the strict \(U<K+1\) test for both pairs. The replay took **26.07 CPU seconds**. [Checker log](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/replay.log) · [Export hashes](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/exports.sha256)

The kernel checked the packed sign changes, their ordering and weights, and all four inequalities against the frozen phase operands and allowance of 18. Interpreting the bracket totals as exact L-function zero counts still requires proofs connecting the sign bits to the Hardy functions and justifying the analytic phase bounds and Turing allowance. [Frozen operands](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/manifest.json)

## 22:52:35 UTC · Final

Stock HOL4 linked one repaired interval for each of the four frozen characters to the exact sign bits used in its width-50 count. Each proof checked 192 regular signs and evaluated the interior sign from the same 192 stored samples. In all four cases, the interior sign was opposite to both endpoints, recovering two brackets per interval. The replay took **18.88 CPU seconds**. [Checker log](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/windows.log) · [Source hashes and packet positions](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/windows.json)

This covers **4 of 93 interior repairs**. The remaining 89 repairs, 20 edge checks and most regular signs still need replay. The analytic link from the stored samples to the Hardy functions, the interpolation error bounds and the Turing allowance also remain open. [Exported theory hash](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/window-export.sha256)

## 22:58:07 UTC · Final

Stock HOL4 accepted **all 93 interior repairs** at conductor 10,004. For each repair, it verified the left endpoint, interpolated interior sign and right endpoint against the corresponding three bits in the previously checked count packet. The four channels shared 20 interpolation kernels and used 17,563 distinct stored samples. [Checker log](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/all.log) · [Input manifest](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/all-input.json)

The full build took **46.16 CPU seconds** and 75.11 seconds elapsed. Reading the inputs took 0.025 CPU seconds, constructing HOL terms took 0.860, certified input conversion took 18.230, and the arithmetic and packet checks took 0.756. The exported theory occupied 12.3 MB. [Timing receipt](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/all.time) · [Export hash](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/all-export.sha256)

The 20 edge probes and regular signs outside these windows still need replay. The interpolation error bounds, the connection from stored samples to Hardy-function values, and the analytic Turing allowance remain external inputs.

## 23:02:41 UTC · Final

Stock HOL4 accepted all **93 repairs** using the compressed samples. A separate replay checked all **17,563** compressed values against the original raw samples. The compressed representation averaged 14.52–14.87 bits per sample across the four characters. The kernel verified the per-sample error bound and checked that each interpolation kernel stayed within the five-unit error allowance. [Compression data](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/compression.json) · [Sign replay](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/compressed.log) · [Raw-sample replay](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/project.log)

| Measured CPU seconds | Raw | Compressed |
|---|---:|---:|
| Certified input conversion | 18.23 | 6.20 |
| Arithmetic and packet checks | 0.76 | 0.57 |
| Full sign-check build | 46.16 | 28.73 |

Checking the raw-to-compressed correspondence cost another **32.98 CPU seconds**. That brings the first compressed pass to **61.71 seconds**. If the correspondence proof is reused, two comparable passes would total 90.44 seconds compressed versus 92.32 seconds raw. This break-even estimate uses the measured build times from one run of each path. [Raw timing](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/all.time) · [Compressed timing](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/compressed.time) · [Correspondence timing](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/project.time)

## 23:06:08 UTC · Final

The November 13 forecast gave HOL4 scenarios of **81, 523 and 66,578 core-years**. It assumed a completed analytic library and explicitly described the three figures as scenarios. They do not establish a 90% interval for either cost or calendar time. [Historical model](../../../work/backend-costs-20261112/forecast-audit-20261113/END_TO_END_MODEL.md)

For planning, my judgmental 90% ranges are **1–6 weeks for the large-\(n\) result** and **1–12 months for the all-\(n\) fallback**, conditional on proof completion, sustained staffing and the assumed compute access. The finite fallback alone projects 60,285 useful CPU-hours, about **12 days** at 210 useful cores after production starts. That estimate comes from two warmed calibration blocks, with end-to-end shard throughput still unmeasured. [Large-case evidence](../../../work/grh-goldbach-20261120/team/large-corollary.md) · [Finite-cost reforecast](../../../work/grh-goldbach-20261120/team/finite-cost/reforecast.json)

For the direct HOL4 route under the $10,000 cap, I would report **no finite unconditional 95th-percentile completion date**. Its projected 780,000-core-hour subtotal already exceeds the 136,426 useful CPU-hours available. The new repair measurements improve one local cost estimate while leaving the analytic work and campaign-wide repair frequency unpriced.

## 23:09:18 UTC · Final

Stock HOL4 accepted all **93 interior repairs and 17,563 raw-to-compressed sample comparisons in one pass**. The fused checker used **44.40 CPU seconds**, down from 61.71 seconds for the separate sign and correspondence checks. The raw checker took 46.16 CPU seconds. The 3.8% CPU difference from raw comes from one run each, and the fused run took longer on the clock: 82.57 seconds versus 75.11. [Checker log](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/fused.log) · [Timing receipt](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/fused.time)

Certified input conversion took 14.11 CPU seconds. Checking the correspondence, signs and packet bits took 0.70 seconds. The four exported theorems preserve the raw-sample correspondence. Analytic transfer to Hardy-function values remains open. [Theory source](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/Q10004FusedScript.sml) · [Export hash](../../../work/grh-goldbach-20261120/team/q10004-gaussian/hol/fused-export.sha256)
