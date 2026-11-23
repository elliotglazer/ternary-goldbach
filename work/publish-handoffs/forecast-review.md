# Historical cost forecasts and HOL4 repair receipts

## Cost and calendar

Platt reported roughly 400,000 core-hours for his completed numerical verification. The 800,000-hour comparison target doubles that historical figure. The proposed verification covers a different conductor and height schedule, on different hardware, and adds formal checking. Its nonprincipal census contains 4,351,723,951 primitive characters. A projected subtotal of 780,000 core-hours would leave 20,000 hours for all omitted work, or 0.0165 CPU seconds per character on average. Neither the census nor successful repair trials determine the frequency of expensive failures. [Historical scope audit](../backend-costs-20261112/hol-platt/historical-scope-independent/REPORT.md) · [Cost ledger and overlap rules](../backend-costs-20261112/hol-platt/campaign-cost-ledger/README.md)

The November 13 HOL4 model gave favorable, planning and stress scenarios of 81, 523 and 66,578 core-years. All assumed a completed analytic library. They are scenario costs and supply no calibrated calendar percentiles. A separate binary Goldbach fallback through \(4\times10^{15}\) projected 60,285 useful core-hours from two warmed calibrations. At 300 comparable cores and 70% utilization, that is about 12 compute-days after production starts. The $10,000 ceiling at $0.0733 per useful core-hour buys roughly 136,426 core-hours. Proof development, end-to-end shard throughput and the chance of finishing within the cap require separate estimates. [Historical scenario model](../backend-costs-20261112/forecast-audit-20261113/END_TO_END_MODEL.md) · [Finite reforecast](../grh-goldbach-20261120/team/finite-cost/reforecast.json)

## Conductor 10,004

The preselected even Conrey pair was 6559/7707 and the odd pair 5499/7659. At the exact main height 6,578 the native Gaussian run found 31,752 and 31,751 brackets respectively. Against the supplied phase bounds and allowance 18, the width-50 guard passed the strict integer count test for both pairs. Width 25 failed that same test. Stock HOL4 replayed the ordered sign packets and the four inequalities. The independently evaluated Hurwitz slab agreed on all 124 compared signs after a constant phase reversal for the even pair. [Frozen target](../grh-goldbach-20261120/team/q10004-freeze.json) · [Native counts](../grh-goldbach-20261120/team/q10004-gaussian/counts.json) · [Phase check](../grh-goldbach-20261120/team/q10004-gaussian/crosscheck.json) · [Count replay](../grh-goldbach-20261120/team/q10004-gaussian/hol/replay.log)

HOL4 linked all 93 interior repairs to the prior count packets. The raw replay used 20 shared weight vectors and 17,563 distinct stored samples. A second implementation stored approximately 14.5–14.9 bits per sample and checked the enlarged sign margins. A fused replay checked the raw-to-compressed correspondence and sign predicates together. Whole-build CPU times below are single local observations. [Raw inputs](../grh-goldbach-20261120/team/q10004-gaussian/hol/all-input.json) · [Compression choices](../grh-goldbach-20261120/team/q10004-gaussian/hol/compression.json)

| Implementation | CPU seconds | Receipt |
|---|---:|---|
| Raw signs and packet links | 46.16 | [Raw timing](../grh-goldbach-20261120/team/q10004-gaussian/hol/all.time) |
| Compressed signs and packet links | 28.73 | [Compressed timing](../grh-goldbach-20261120/team/q10004-gaussian/hol/compressed.time) |
| Separate raw-to-compressed proof | 32.98 | [Projection timing](../grh-goldbach-20261120/team/q10004-gaussian/hol/project.time) |
| Fused correspondence and signs | 44.40 | [Fused timing](../grh-goldbach-20261120/team/q10004-gaussian/hol/fused.time) |

The fused first pass saved 17.31 CPU seconds relative to the two separate compressed builds. The raw and fused builds differed by 1.76 CPU seconds. This comparison covers repair windows. The 20 edge probes, regular signs outside the windows, upstream analytic sample and interpolation bounds, and the Turing allowance were outside this repair replay. [Fused export hash](../grh-goldbach-20261120/team/q10004-gaussian/hol/fused-export.sha256)

## Short-stencil checks

Two datasets exercise different source interfaces. For 13 hidden midpoints in the conductor-10,004 Hurwitz slab, HOL4 verified the rounding of 208 archived decimal sample intervals and 160 exact Lagrange weights across ten distinct boundary offsets. With supplied strip remainder bounds, the batched check took 0.733 CPU seconds inside the worker. The individual checks totaled 0.924 seconds. [Source manifest](../grh-goldbach-20261120/team/q10004-short/inputs.json) · [Batch log](../grh-goldbach-20261120/team/q10004-short/ShortBatch.log)

For 270 indexed 12-node repair rows across eight conductors, HOL4 checked all integer dot products and supplied thresholds. The 270 individual judgments took 1.798 CPU seconds inside one worker. A balanced combination took another 0.782 seconds and proved the identical ordered batch statement, about 9.55 milliseconds per row combined. Evaluating one literal list directly took 63.118 seconds. These inner timings exclude startup and export. One concrete specialization proves a negative target at conductor 10,000, label 3, tick 8,010,240, conditional on sample and weight admission and the stated interpolation remainder. Generalizing that analytic admission across the campaign remains open. [Individual checks](../grh-goldbach-20261120/team/q10004-short/PanelUnary.log) · [Balanced join](../grh-goldbach-20261120/team/q10004-short/PanelJoin.log) · [Batch check](../grh-goldbach-20261120/team/q10004-short/PanelBatch.log) · [Conditional real-sign theorem](../grh-goldbach-20261120/team/q10004-short/ActualSignScript.sml)

Outside `work/`, the [blueprint chapters](../../outputs/qrh-blueprint-next/chapters/) retain project-level reports and reviews. The forecast and repair receipts used in this handoff are under `work/`.
