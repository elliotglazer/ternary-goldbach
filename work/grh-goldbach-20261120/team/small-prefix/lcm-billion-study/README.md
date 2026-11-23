# Factorial and LCM certificates at one billion

Both runs proved `SmallGoldbach.Power9.binaryGoldbachUpTo` using the same 1,908 rows and 129,075 anchors. The width was 262,144, the halo was 2,592, and the residual tail limit was 192. The axiom audit for both methods printed `[propext, Classical.choice, Quot.sound]`. The source-level statement, decoded row widths, counts and offsets are compared in `coverage.json`.

| Method | Producer CPU s | Standalone build and audit, LCM first | Standalone build and audit, factorial first | Reverse-order peak KiB |
|---|---:|---:|---:|---:|
| Released factorial | 9.984375 | 126.859375 | 125.375 | 2,844,976 |
| LCM | 10.734375 | 132.171875 | 130.359375 | 2,852,416 |

Using the LCM reduced the coprimality modulus from 427,094 to 45,552 bits at cutoff 31,622. Certifying its divisibility support cost enough to make the two complete LCM runs 6.0625 and 5.734375 CPU seconds slower. The earlier 100-million row-module experiment found a faster LCM leaf when the generic bridge was precompiled; that comparison excludes the separate bridge build. These data establish no crossover for complete standalones. The contiguous extension therefore uses the released factorial method. The timing receipts and comparison inputs are preserved in this directory.
