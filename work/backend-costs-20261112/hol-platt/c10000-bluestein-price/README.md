# Price of the length-500 small-family slice

The 7,499-conductor schedule contains ten conductors with a complete length-500 character axis. In factor-list order, projecting out imprimitive local labels immediately after each finished axis leaves 6,007,596 C500 character transforms. Of these, 546,144 have exactly 307 fractional bits. All four auxiliary extension choices produce the same totals and exact-width counts for this shape. The ten-conductor fold also produces 42 Gauss-phase transforms, each at higher precision (426 to 478 bits in the base schedule). fold.json preserves individual counts and widths per extension.

| Character fractional bits (base) | C500 slices |
|---:|---:|
|304|1,092,270|
|305|546,136|
|306|1,911,500|
|307|546,144|
|317|819,240|
|322|273,070|
|334|136,536|
|356|682,700|

At q=10000, both parity inputs have 68,268 nonnegative frequencies. The C2 x C4 x C500 layout retains both C2 labels and two of four C4 labels. This gives four C500 lines per parity and frequency. One p307 normalized kernel serves all 546,144 character uses if kept resident. The Gauss table has a single input tensor and four C500 lines at p429, so its different rounding grid needs a separate kernel. The measured data were an actual Gauss-axis input slice on the p307 grid; the measured geometry and precision match the character stage. Its source values and intermediate magnitudes may differ from Gaussian bucket inputs. Formal equivalence for the projected axis traversal and the normalized cache also remains a prerequisite.

The normalized runtime circuit performs 10,240 radix-two butterflies and 2,024 point/chirp products. The historical central butterfly and point-product assumptions price the same operation counts at 0.117056 CPU seconds. The old ledger also lists separate inverse scales. The measured circuit puts the normalization in the cached kernel. An adjusted forecast must avoid double charging scales and setup. The earlier stock HOL conversions took 0.303648 to 0.403917 seconds for arithmetic, about 2.59 to 3.45 times the corresponding two-row historical estimate.

The resident experiment ran five stock HOL conversions on the same admitted literal fixture, decoding and verifying all 500 output pairs each time. Arithmetic took 0.255758, 0.267520, 1.016590, 0.240347 and 0.259965 CPU seconds. The median was 0.259965 and the mean was 0.408036. The total mean including output decoding, premise discharge and comparison was 0.905257 seconds. The one slow run is retained. Template construction cost 0.000547 seconds, admission of the shared three arrays 4.678816, admission of the example input 1.936338 and CV conversion construction 0.054669. Saving one closed equality took 1.000402 seconds and exporting the theory 3.034253. The single replay process took 33.16 wall seconds and peaked at 1,470,380 KiB RSS. These measurements exclude generating analytic certificates.

| Alternative treatment of 546,144 p307 occurrences | Conditional core-hours |
|---|---:|
| Historical two arithmetic rows | 17.76 |
| Earlier freshly prepared HOL arithmetic | 46.07 to 61.28 |
| Resident HOL arithmetic, median / mean | 39.44 / 61.90 |
| Resident arithmetic plus full literal output decoding and verification, mean | 137.33 |
| Fresh literal input admission each time plus previous line | 431.09 |

Each row prices the same exact-width occurrences under a different interface. In a forecast use one row for these occurrences and retain the charges for the rest. The conservative default assigns a measured arithmetic price only to the 546,144 exact-width, exact-shape calls, conditional on comparable operand magnitudes. This gives a partial subtotal and supplies no mathematical lower bound on other implementations. The 3,549,906 lower-width occurrences can be added in a sensitivity scenario if they use p307 arithmetic, with an appropriate accuracy proof and comparable operand sizes. The resulting 4,096,050 calls take 345.49 to 459.57 hours at the earlier arithmetic rates. The 1,911,546 higher-width character calls and all 42 phase calls require their own evidence. Kernel generation, upstream arithmetic and formal analytic binding remain separate charges.

fold.py derives widths directly from the producer's epsilon/sigma and axis safety formulas, using the selected theta and N for each saved row. It counts surviving prior labels times all following dimensions. price.py derives the previous unit price from the historical model and processes the five measured repetitions. p01_replay.log and .hol/objs/BlueResidentTheory.dat record the executed conversions and the saved equality.
