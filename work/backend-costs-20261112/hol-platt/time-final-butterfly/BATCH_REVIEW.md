# Four-label batched time-FFT handoff and sparse masks

HOL4 exported a single Boolean theorem covering 1,024 actual sample projections and strict signs across Conrey labels 3, 6667, 11 and 9091 at conductor 10000. Each of the 256 sample indices shares a twiddle among the four channels; each label has its own exponent in each 64-tick tile. This aligned pilot took 0.598188 CPU s for literal term construction, 0.000314 s for encoding, 0.250776 s for CV evaluation, 0.000236 s for final checking and 0.255520 s for naming and storing the aggregate theorem. The generic schema setup took 0.11881 s. The input hex payload occupies 256,804 bytes. On 16, 64 and 256 decisions, CV evaluation took 0.003279, 0.013209 and 0.046347 CPU s. Calculating the four pairs of complete penultimate transforms and checking the native comparison data took 18.73 CPU s. These native FFTs remain outside the HOL kernel.

## Actual sparse certificate

The full masks in sparse-count/raw-*.txt require 17,883, 18,234, 17,207 and 18,001 samples for the four labels. They contain 71,325 decisions at 51,996 distinct sample ticks. Exactly one, two, three and four labels require a tick at 35,518, 13,928, 2,249 and 301 ticks, respectively. There are 33,125 unused ticks. Reusing each root once per selected tick therefore gives a factor of 1.372 relative to separate roots per decision. Exponents remain label-specific; 5,312 of the 5,324 label/tile pairs have at least one selected position.

| Full grid tile | Selected ticks | Required channel decisions | Fraction bits for five input coordinates | Signed input-field width |
|---:|---:|---:|---:|---:|
| 2 | 40 | 118 | 32 | 49 |
| 512 | 37 | 48 | 48 | 31 |
| 1026 | 37 | 50 | 80 | 29 |
| 1318 | 60 | 233 | 104 | 31 |

The masked pilot covers 449 genuine decisions at 174 selected ticks. The per-tile width is shared across active channels and the exponent remains distinct per channel. The native preparer tested candidate precisions in increments of 8 bits and selected the first at which every requested projection interval fits inside its target short-head bin. Shortening an initial p256 center with strict error below one p256 grid unit by nearest rounding leaves error below one new grid unit for these reduced precisions. The input file stores each used twiddle once, packs coefficient fields only for requested lanes and occupies 22,376 hex bytes. The program computes the full unrounded butterfly numerator at its chosen scale, verifies the entire operator-error interval lands in the target bin, and invokes the original strict_code with the original coarse radius.

| Masked pass | Literal construction, CPU s | Kernel argument encoding, CPU s | CV arithmetic, CPU s | Final check, CPU s | Named-theorem storage, CPU s |
|---|---:|---:|---:|---:|---:|
| First | 0.020181 | 0.000303 | 0.013498 | 0.000162 | — |
| Second | 0.023050 | 0.000489 | 0.012552 | 0.000210 | — |
| Third | 0.023597 | 0.000391 | 0.112457 | 0.000162 | 0.018323 |

The schema took 0.080634 CPU s and the per-pass shape template took 0.0012–0.0025 s. Median construction and execution cost 51.3 and 30.1 microseconds per selected output, respectively. The slower third execution is included in the table. Applying only these pilot medians to all 71,325 outputs would give 5.8 CPU s for construction and arithmetic; using the slower execution instead gives about 21.5 s. Both estimates exclude upstream transforms, selecting and proving precision, local proof setup and storage. The pilot tiles emphasize the beginning, middle, N/8 and main-range endpoint, and their masks are denser than the whole certificate. Neither estimate is a full-workload measurement.

The aggregate theorem selected_actual_samples has empty hypotheses. It accepts supplied, reduced-precision penultimate E/O coordinates, twiddle coordinates and input masks and checks all indicated head bins and signs. The masks, coordinate/phase enclosures and mapping from packet order to actual ticks are validated in the native adapter. They are not yet theorems linking the earlier stages to a fully verified time transform. No full-width final sample occurs in either aggregate HOL input. The native adapter used the original grid and sign files for independent comparison.

batch_prepare.py, batch_native.json, BatchButterflyScript.sml and b02_pilot.log cover the aligned benchmark. masked.py, masked.json, MaskedButterflyScript.sml and b03_pilot.log cover the masked benchmark. All outputs and input hashes are in batch_artifacts.sha256.
