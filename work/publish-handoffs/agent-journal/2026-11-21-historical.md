# historical — 2026-11-21

## 22:15:02 UTC · Final

The 0.78 million core-hour figure covers modeled work on the optimized route. The historical 400,000 core-hours describe the original computation. Neither establishes the cost of finishing the formal verification or calibrates a 90% interval.

The older full-strategy estimates are central scenarios in core-hours. HOL4 was 4.58 million, Candle 6.87 million, stock Lean 682 million, and scalar PA-MM0 4.77 trillion. QRH needs a separate estimate for its outstanding analytic proofs. A numerical 90% completion interval would require assumptions about the unmeasured work and a statement of whether the estimate is conditional on successful completion.

## 22:19:08 UTC · Final

The transpose-and-scan pilot raises the fused HOL4 estimate to **783,638–795,534 core-hours**. Charging a separate sign check across all outputs gives **811,955–844,307 core-hours**. The calculation replaces the original scan allowance with 13,188–13,270 core-hours for the combined operation. I reproduced the original allowance from the timing logs before making that replacement. [Verification script](../../../work/backend-costs-20261112/hol-platt/guard-repricing/transpose_scan_crosscheck.py)

Both ranges extrapolate two panels at conductor 10,004 to the full grid. They are partial planning scenarios. Archive generation, repairs, analytic interpretation and final completeness remain unpriced.

## 22:23:25 UTC · Final

The long-axis transform is the largest individual modeled charge at **235,251 core-hours**. I tested whether computing the packed kernel sum once per axis would reduce its cost across 16 distinct synthetic height inputs. Both methods gave identical integer outputs. Median elapsed-time ratios ranged from **0.984 to 1.019**, and the trials at every axis length included both speedups and slowdowns. The native benchmark provides no basis for reducing the HOL4 estimate. [Benchmark](../../../work/backend-costs-20261112/hol-platt/large-axis-fused-tree/kernel_sum_probe.py)

## 22:25:17 UTC · Final

The selected nonprincipal HOL4 subtotal is **763,138–773,334 core-hours** after subtracting the principal pilot from the corresponding fused-scenario endpoints. That is **4.77–4.83 times** Helfgott’s retrospective 160,000-hour allocation for the required subset. Applying that allocation to the exact selected conductor and height schedule remains an assumption.

The same subtotal is **1.91–1.93 times** Platt’s 400,000-hour full run. The selected domain contains 4,351,723,951 nonprincipal characters, or 14.72% of Platt’s 29,565,923,837. All selected main heights fit inside Platt’s domain. The HOL4 subtotal averages 0.631–0.640 core-seconds per selected character, compared with 0.132 under the subset allocation and 0.0487 across Platt’s full domain. Character averages include shared conductor work and depend on the height schedule. [Conductor census](../../../work/backend-costs-20261112/hol-platt/historical-scope-independent/audit.json)

The local conductor-10,004 comparison verifies agreement on 2,301 signs at one height. Its native timers cover production of inputs consumed by the HOL timer. The receipts establish numerical agreement but supply no end-to-end hardware correction. Repairs and final analytic acceptance remain outside the subtotals. [Timing boundaries](../../../work/backend-costs-20261112/hol-platt/c10004-full-integer/RESULT_REVIEW.md)

## 22:26:43 UTC · Final

No additional conductor family can be dropped by conjugation or parity. Conjugating a character reverses the sign of the ordinate. For a nonreal inverse pair, the two positive-height channels cover the two halves of one symmetric rectangle. One completeness certificate can serve both labels once both channels have been checked. The conductor-10,000 pilot already uses this sharing for one even and one odd inverse pair. [Full-height count](../../../work/backend-costs-20261112/hol-platt/full-height-count/README.md)

The transform schedule already prunes imprimitive labels between axes. A possible local improvement is to skip final postchirp operations on discarded labels wherever the implementation still executes them. Those labels account for **0.293% of regular final-axis modes**. Their removal would leave the underlying convolution in place. No measured core-hour saving follows from that fraction. [Transform census](../../../work/backend-costs-20261112/hol-platt/large-axis-fused-tree/REPORT.md)

## 22:30:04 UTC · Final

The +640 grid has **41,029,096,839,823 outputs** across both families. Small conductors contribute 1,787,257,220,237 outputs, or 4.36%. A small-family character averages 96,728 samples, compared with 9,056 for a large-family character.

The fused scenario leaves **4,466–16,362 core-hours** under the 800,000-hour cap. That allows **0.392–1.436 microseconds per scheduled output**, or **3.694–13.535 milliseconds per character**, for all remaining work. The alternative that reconstructs the archived small-family raw projection reaches **800,308–812,643 core-hours** before filesystem I/O, repairs and final analytic acceptance. [Calculation and source receipts](../../../work/backend-costs-20261112/hol-platt/guard-repricing/family_headroom.md)

## 22:32:59 UTC · Final

The strongest replicated stock-HOL4 speedup saves about **1.04 core-hours** when restricted to the measured geometry. The fused 1,152-point transform took 39.89 ms versus 47.00 ms for the baseline. The +640 schedule uses that exact dimension and capacity 529,188 times, all at the final axis. A joint timing with sign extraction is needed before subtracting the saving from the fused-sign estimate. [Census script](../../../work/backend-costs-20261112/hol-platt/large-axis-fused-tree/shape_reuse.py)

Adjacent-character packing already exploits Hermitian symmetry in the small-family time transform. The large-family character transform receives complex Hurwitz values at each positive height. Adjacent heights can share roots and use bounded integer lanes, but measured speed depends on the backend. Packing 32 heights reduced a native trial from 2.19 to 0.484 CPU seconds. On the measured stock-HOL five-point leaf, the scalar path took 416 μs per leaf versus 647 and 731 μs for widths four and eight. These results support retaining the current estimate. [Packed trials](../../../work/backend-costs-20261112/hol-platt/c10004-packed-transform/README.md)

## 22:42:51 UTC · Final

Stock HOL4 proved `score_sign` for the unchanged fallback detector. Given the four one-unit coefficient enclosures and both sample-coordinate enclosures of radius `e`, return code `2` certifies a strictly positive real projection and code `1` certifies a strictly negative one. The proof applies even when the completed product has a nonzero imaginary component. Establishing the six input enclosures remains an upstream obligation. [Proof](../../../work/backend-costs-20261112/hol-platt/fallback-score/FallbackScoreScript.sml) · [Successful build](../../../work/backend-costs-20261112/hol-platt/fallback-score/score05.log)

## 22:45:30 UTC · Final

Stock HOL4 exported `DispatchedScoreTheory.dispatched_sign` for the exact branch expression in `Sector$sector_packet`. Code `2` certifies a strictly positive completed real coordinate, and code `1` certifies a strictly negative one. Code `0` remains unresolved. The theorem assumes the six input enclosures, a nonnegative sample radius, a nonzero phase multiplier and a zero completed imaginary coordinate. [Proof](../../../work/backend-costs-20261112/hol-platt/dispatched-score/DispatchedScoreScript.sml) · [Successful build](../../../work/backend-costs-20261112/hol-platt/dispatched-score/dispatch01.log)

## 22:50:43 UTC · Final

At conductor 10,004 and height \(5/64\), stock HOL4 checked two production rows. Conrey character 3 took the fast branch, and character 10,003 took the fallback. Both returned code `2`. HOL4 proved that each row’s enclosed real projection is positive under the stated Hardy reality and nondegeneracy assumptions. [Proof](../../../work/backend-costs-20261112/hol-platt/dispatched-score/DispatchedFixtureScript.sml) · [Build log](../../../work/backend-costs-20261112/hol-platt/dispatched-score/fixture01.log)

An independent 256-bit Arb calculation checked all six coordinate enclosures for each row using direct Gauss sums, gamma factors and Dirichlet \(L\)-values. The largest observed spectral coordinate discrepancy was below 81.262 grid units, against a radius of 13,308. The analytic enclosure evidence for these two points remains external to HOL4. [Numerical receipt](../../../work/backend-costs-20261112/hol-platt/dispatched-score/fixture.json)

## 22:57:34 UTC · Final

Certified coarse signs at \(0,T,H\) can be used directly. Stock HOL4 proved that opposite strict signs at two samples force a root strictly between them. The main and auxiliary brackets can therefore share the sample at \(T\) without counting a root twice. An auxiliary bracket ending at \(v\) contributes the conservative weight \(H-v\), which is zero when \(v=H\). [Proof](../../../work/backend-costs-20261112/hol-platt/dispatched-score/InclusiveBracketScript.sml) · [Build log](../../../work/backend-costs-20261112/hol-platt/dispatched-score/inclusive02.log)

For the existing strict scanner, translate each sample tick \(t\) to \(t+1\) and use bounds \(L,H+2\). This preserves the included samples and flips. Subtract the number of auxiliary flips from the translated weight before applying the physical Turing inequality. An exhaustive check passed on all 19,683 nine-sample grids with positive, negative or missing signs. [Check](../../../work/backend-costs-20261112/hol-platt/dispatched-score/check_inclusive.py)

With a **closed-count** upper bound \(U<K+1\), strict interior brackets suffice even if an endpoint sign is unavailable. The parity shortcut \(U<K+2\) needs additional parity evidence, currently strict signs at \(0,T\) on both channels. An off-grid probe near \(T\) cannot certify nonvanishing at \(T\). The historical evidence does not establish how often a campaign-wide fallback would be needed.

## 23:02:29 UTC · Final

Stock HOL4 proved that the fallback detector’s center and radius enclose the completed real amplitude under the same six input enclosures used for sign checking. A repair request can retain that pair for selected rows. A fast-path row requires the full postchirp rotation before projection. [Proof](../../../work/backend-costs-20261112/hol-platt/dispatched-score/RepairAmplitudeScript.sml) · [Build receipt](../../../work/backend-costs-20261112/hol-platt/dispatched-score/amplitude02.log)

Across six conductor-131,071 tiles, 2,686 of 2,688 reconstructed intervals excluded zero and agreed with the archived sign. Two p24 intervals contained zero despite strict fast-path signs. Native rotation and projection took **1.34–2.33 μs per selected row** with inputs resident. This excludes kernel receipt production, tile replay and storage. [Measurements](../../../work/backend-costs-20261112/hol-platt/dispatched-score/window_taps.json)

An untrusted discovery pass can nominate repair windows before the formal sweep. The producer can then validate and retain just the requested rows while their tiles are resident. Later requests need a checkpoint or tile replay. [Repair-window design](../../../work/backend-costs-20261112/hol-platt/dispatched-score/REPAIR_AMPLITUDES.md)

## 23:03:33 UTC · Final

For a whole interpolation window, evaluate the bound at **both endpoints of the range of \(D=b+2+|t|\)**. When the window crosses zero, its minimum \(D\) occurs at zero. Using only the largest \(D\) requires a monotonicity check. This is a mathematical audit; the analytic bound has not been replayed in HOL4.

## 23:06:45 UTC · Finding

gAAAAABrAiQFs0OBlOFKiPYYbCi_8uemIqyQUIWjx4Rb_2B9nkcfuQfWGoyayZVdWTUTiu8XNw6K7h_e-o8PJVlMC-hea7R-zxv5sz2r7KbcLu5Z2Gp9mkS2EaOKjwmBSSTf9kBSULCeJUDeI2iQEOt-uFlc3R2P28Z5Yw9GCW6QE2wU0kWGfSbmkORirPivQmusYJcmChsSUGmAi7IaAqcEwoL-Mbr6HxDZ6bWZ6pVwKzVO64tPetkIwqOb2rhqggEHfqAqg5F1N15aVXMpOZtzZWl_HGu9k8owLFTszS3XvcFdhpWkRYXgIYOQcIV7Y0_7xINaJq4WUtizMvIB1ddeOiRZTx1vMJe6m5JiviH05F7EobEdqK4DhK4P_lHfPcVphIiUhLmih06HTv8E9st0m1wzhsylzaayv0HP0xOimyDz8zOqD94MY3MBTGHGeCyZNmY4Bh9URCuHHNPE0yTJFvFZ7hPll0zuuIsAj1vPN6rNC_enV9S85zfMgiT7SGW9lAXmpk6E8UfBB8qn2nagNvcZ4zAlAAXq9gi5TL6E4sZHKXsf1sN-jxcYExApRLNsE_sblg2ozJ0mVni6_Nny0gOqsUljDDC_3S9O9HJ5WuGWBCTo6zqV098RTMejzJhzDNXr2piK3BJ_B9ZOGNXvxqpzCULNSJKjMpbK8xjzVN6IsJ-hCOTcaxsS6tPLWFK0hF6anAh5Qh2x4epXOh5GyMu1XPtSHUM7r7YPxcODWzxlUjXgkG-vrJl6Aiw4oXKZzX8410X34u45EhENajzYGIoW4xJo_dBYVNuM57d84Cj8HM8qZQyTQERWgRa-Rh3ZeUPdiNYur537V7L65VGQo4NHWrSHKs0JQi00EapRZysOlXirW_aOT9kjtEzf75i8uKhTaRVSX8Y3Ljry5KpL-gNcDTIONQ==

## 23:19:27 UTC · Final

All **34,515 midpoint signs** in the conductor-10,004 test were certified. The original 16 coarse heights resolved 34,513, including all 13 hidden reversals. One additional coarse height for each of two characters resolved the remaining signs. All 2,070,900 interval comparisons overlapped their independent midpoint references. [Interpolation report](../../../work/backend-costs-20261112/hol-platt/guard-repricing/STRIP_INTERPOLATION.md)

Two primitive real characters also passed the full-height native Turing test. Each required one interior probe and no extra endpoint probes. The repaired closed counts were **3,246** at conductor 65,537 and **2,116** at conductor 132,899. Both central L-values were strictly positive. These are native interval tests conditional on the analytic bounds. [Real-character report](../../../work/backend-costs-20261112/hol-platt/guard-repricing/REAL_CHARACTER_COUNTS.md)

The reports and receipts are saved in the workspace. No Git commit was made because the enclosing repository is the user’s home directory.

## 23:29:15 UTC · Final

The priced dynamic phase cache needs a positive magnitude factor to recover repair amplitudes. After canceling the conductor-only factor and adjusting the interpolation remainder, the whole +640 schedule needs **169,762 parity-and-height entries**. Both 16- and 24-bit tables were generated in **2.20 native CPU seconds**. Independent direct-gamma and reflection-identity checks took **4.30 CPU seconds**. The 24-bit table occupies **679,048 bytes**. These are native timings; formal gamma certification remains open. [Table receipt](../../../work/backend-costs-20261112/hol-platt/guard-repricing/gamma-magnitude-table.json)

On the conductor-10,004 stress panel, variable-radius p24 projections recovered all 13 known hidden midpoint reversals. Raising all 16 nodes to p28 left both clipped-edge cases unresolved; shifting the stencil resolved them. A retry can target individual characters at an affected height. Its cost depends on whether the source residues are still available and how many output modes need refinement. [Normalization, retry rules and costs](../../../work/backend-costs-20261112/hol-platt/guard-repricing/PRECISION_RETRY.md)
