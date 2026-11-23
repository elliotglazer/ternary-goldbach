# Principal Hardy signs in a 4,096-unit slab ending at 100,000,000

The native positive counts at 99,995,904 and 100,000,000 were 247,997,213 and 248,008,025. All 10,812 intervening zeros were witnessed by strict disjoint sign-change intervals. The run used Python-FLINT 0.9.0 and one local thread. plan.json fixes the 512 eight-unit windows and refinement policy in advance. The slab includes the previously piloted final eight units.

| Grid spacing | Windows attempted | Windows closed at this spacing | Still missing after this stage |
| --- | ---: | ---: | ---: |
| 1/4 | 512 | 108 | 1,374 zeros |
| 1/8 | 404 | 291 | 242 |
| 1/16 | 113 | 90 | 48 |
| 1/32 | 23 | 20 | 6 |
| 1/64 | 3 | 2 | 2 |
| 1/128 | 1 | 1 | 0 |

Across refinement stages, the proposal tested 65,152 cells and 40,769 distinct Hardy sites. Final grids contain 40,768 cells. Shared boundaries and previous dyadic sites were evaluated once. Every sign was strict. The difficult window [99,997,128, 99,997,136] contains 21 zeros and needed spacing 1/128. Two further windows needed 1/64, beginning at 99,996,288 and 99,996,960. No window remained open. stages.csv gives the complete per-window failures. Streaming evaluation retains the current window and one seam in memory.

## Cost by stage

| Native operation | CPU seconds | Wall seconds |
| --- | ---: | ---: |
| Two outer counts together | 0.046875 | 0.0591 |
| Additional 511 interior counts, used to localize repairs | 10.546875 | 10.8453 |
| Propose signs and adapt, 80 bits | 76.046875 | 78.0215 |
| Replay 19,530 distinct endpoints of accepted adjacent-cell brackets, 112 bits | 34.65625 | 35.2900 |
| Replay compressed chain of 10,813 alternating signs, 112 bits | 18.96875 | 19.9081 |

A sequence of N+1 alternating signs gives N disjoint open sign-change intervals. Selecting the largest available absolute value in each same-sign run reduces the endpoint count and improves the weakest margin. The smallest absolute Hardy enclosure lower endpoint in the compressed chain was about 0.00035879846748, compared with 0.00009105411485 among the adjacent-cell bracket endpoints. alternate.py verifies the retained signs anew. The global difference of two counts suffices to close this replay; the proposal used 511 further counts to identify failures locally. Assembling the whole finite-RH certificate also requires disjointness across slabs and enough lower witnesses globally.

The measured native proposal used 3.771 sites and 7.034 CPU milliseconds per zero. In sixteen contiguous 256-unit substrata the proposal wall time per zero ranged from 4.87 to 11.76 milliseconds, with median 7.13 milliseconds. The compressed native replay used 1.754 CPU milliseconds per zero. Multiplication by the full positive count of 248,008,025 gives sensitivity values of 484.55 native core-hours for proposal and 120.86 native core-hours for compressed replay at these ceiling rates. Interior diagnostic count costs, spectral coverage elsewhere, formal certification and cross-height variation are separate. One contiguous ceiling slab does not determine the rate at smaller heights.

The Python binding used here exposes the scalar Hardy evaluation. FLINT documents a separate C-level rigorous FFT/interpolation evaluator with different setup and crossover costs. These measurements use scalar evaluations. [FLINT algorithm documentation](https://flintlib.org/doc/algorithms/special-functions/zeta-zeros.html)

## Explicit Riemann–Siegel replay and formal gap

The reference calculation uses a certified native Hardy function. The separate Khat replay computes the actual finite main sum with directed Arb enclosures, the logarithmic phase including 1/(48t), the saddle floor, and the explicit correction F(z). Every tested denominator cos(πz) excluded zero. The analytic remainder is the paper bound 0.451 t^(-3/4), applicable for t≥1500. Each retained site is checked for a strict sign after allowing the full error budget and against the independent at-site native Hardy enclosure. Source logs and inverse square-root weights are shared at 112 bits. [Principal Khat definition and remainder](../../../qrh-blueprint/turing-scalars/PRINCIPAL_BLOCK_WAVE_ERROR_2026-11-11.md)

Stock HOL4 still needs a proved Riemann–Siegel remainder or a different rigorous ζ/Hardy evaluator, certified elementary function bounds on the actual operands, and a link between that evaluator and the normalized Hardy signs. Replaying 3,989 direct phase reductions and cosine enclosures per retained site can dominate runtime in a proof backend. A wave recurrence replaces most transcendental evaluations with bounded multiply/update operations, at the cost of its required error and provenance proofs. Native timings do not calibrate these HOL costs. For purposes of cost accounting, a direct replay of this slab already evaluates more than 43 million RS summands. The alternative explicit and native-Hardy replays are separate sensitivity measurements, not mandatory consecutive passes.

All 10813 compressed sites passed the explicit sum and correction check. The replay evaluated 43133057 summands. The sum of per-site wall times was 44.569 seconds and the sum of per-site CPU times was 44.203125 seconds; cached elementary source construction took a further 0.00445 wall seconds. The smallest lower-sign margin relative to the analytic radius was 795.607 in the evaluated midpoints and enclosures. all-riemann-siegel.json stores every site, saddle, correction, Khat, tail radius, sign and timing. The native run does not establish the analytic error theorem in HOL.

