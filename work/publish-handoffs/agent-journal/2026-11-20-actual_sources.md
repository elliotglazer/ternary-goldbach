# actual sources — 2026-11-20

## 19:28:44 UTC · Final

Generated 4,800 reference inputs at each of heights 0, 5/64 and 5/32. All 28,800 real and imaginary coordinates rounded uniquely to the p81 grid. Single-threaded evaluation and rounding took 0.887 and 0.864 seconds at the two positive heights. Nine character sums agreed within Arb enclosures with FLINT’s Dirichlet L values.

These timings measure direct Hurwitz evaluation. The P20 source pipeline and its HOL proof remain separate work. [Run receipt and hashes](../../../work/backend-costs-20261112/hol-platt/c10004-reference/receipt.json)

## 19:31:58 UTC · Final

Pairing the 18,477,108 character lanes gives 9,236,019 pairs and 5,070 singletons. All 7,499 conductor rows meet the original sign tolerance with one additional integer magnitude bit and the existing fractional precision.

The paired schedule uses 36.105 trillion pruned general rotations and 2.402 trillion scalar packing additions. The existing half-length alternative uses 34.929 trillion general rotations including setup, with 4.811 trillion scalar packing additions. These are alternative circuits. Their wall-time ranking remains unmeasured.

[Derivation and comparison](../../../work/backend-costs-20261112/hol-platt/time-pairing/README.md) · [Counts and native numerical control](../../../work/backend-costs-20261112/hol-platt/time-pairing/counts.json)

## 19:33:54 UTC · Final

The 16-cell, degree-20 Taylor evaluator matched the direct Hurwitz reference for all 9,600 complex inputs. All 19,200 coordinates rounded uniquely to p81 after including the Taylor remainder.

Production took **0.660 seconds wall time** and **0.484 seconds CPU time**, including shared head initialization and both sets of coefficients. The direct run took 1.752 seconds wall time and 1.609 seconds CPU time, including TSV formatting. Both used one FLINT thread. These measurements cover native arithmetic; HOL verification and the original P20 source pipeline remain separate.

[Derivation and timings](../../../work/backend-costs-20261112/hol-platt/c10004-batched-source/README.md) · [Machine-readable receipt](../../../work/backend-costs-20261112/hol-platt/c10004-batched-source/receipt.json)

## 19:40:09 UTC · Final

All 9,600 high-height Hurwitz values matched the direct reference after rigorous p81 rounding. The four-cell Taylor implementation took **8.11 CPU seconds** for both heights, compared with **46.47 CPU seconds** for direct evaluation, a **5.73× speedup** on this pair.

Cold initialization and the first height cost 5.05 CPU seconds. The adjacent height cost 3.06 CPU seconds with its own coefficient table and all head updates charged. The degree-86 Taylor remainder was below \(5.157\times10^{-36}\). These timings cover native source generation. HOL4 verification, longer phase recurrences and other heights remain unmeasured.

[Derivation and timings](../../../work/backend-costs-20261112/hol-platt/c10004-batched-high/README.md) · [Run receipt](../../../work/backend-costs-20261112/hol-platt/c10004-batched-high/adaptive.json)

## 19:44:48 UTC · Final

Generated the full \(t=5/64\) P27→P20 input for the mixed-grid HOL replay and sent it to the HOL worker. All 13,844 coarse coefficient pairs met the \(2^{-102}\) error bound. After 168,960 midpoint updates, the mixed-grid evaluator produced all 4,800 residue outputs. Each satisfied \(633\,|\mathrm{error}|<2^{-82}\) against an independent Arb enclosure.

Native generation and verification took 10.16 CPU seconds. HOL replay and the formal source proof remain separate.

[Mixed-grid inputs](../../../work/backend-costs-20261112/hol-platt/c10004-p20-source/h1-mixed.json) · [Expected outputs](../../../work/backend-costs-20261112/hol-platt/c10004-p20-source/h1-horner.json) · [Method and validation](../../../work/backend-costs-20261112/hol-platt/c10004-p20-source/README.md)

## 19:49:53 UTC · Final

Generated the 64-height P20 slab and sent it to both replay workers. It covers seven residues at two fine anchors. All 1,728 coarse coefficients met the \(2^{-102}\) error bound, and all 448 scalar Horner outputs met the \(633|\mathrm{error}|<2^{-82}\) bound against direct Hurwitz enclosures.

The run used the original Euler–Maclaurin construction at every height and took 1.00 CPU second, including verification.

[Replay data](../../../work/backend-costs-20261112/hol-platt/c10004-p20-slab/slab.json) · [Verification receipt](../../../work/backend-costs-20261112/hol-platt/c10004-p20-slab/receipt.json)

## 19:53:06 UTC · Final

Generated all 32 consecutive heights, with **153,600 p81 Hurwitz inputs** and **73,632 scalar character-transform outputs**. The first two source files matched their archived hashes, and their recomputed spectra matched the archived integer outputs. Every coordinate at heights 3–32 rounded uniquely at p81.

Source generation and reuse took 27.47 CPU seconds. The scalar transforms took 2.19 CPU seconds, excluding spectrum writes. These are direct Arb source values for comparing transform circuits.

[Per-height timings and file hashes](../../../work/backend-costs-20261112/hol-platt/c10004-time-slab/receipt.json) · [Generator](../../../work/backend-costs-20261112/hol-platt/c10004-time-slab/generate.py)

## 19:58:28 UTC · Final

The original band-1 coefficient and rounding bounds guarantee **126,782,212,733,568 skippable Horner stages**, or **14.9%** of the guarded baseline. The shortened recurrence gives exactly the same integer outputs and retains the original K20 error budget.

At \(t=5/64\), all 1,025 fine cells had highest nonzero degree 8. The shortened evaluator reproduced all 4,800 archived outputs and all 448 outputs in the separate 64-height slab. The campaign savings are operation counts; checker wall-time savings remain unmeasured.

[Derivation and scope](../../../work/backend-costs-20261112/hol-platt/c10004-effective-degree/README.md) · [Per-degree cutoffs and weighted counts](../../../work/backend-costs-20261112/hol-platt/c10004-effective-degree/counts.json)

## 20:00:50 UTC · Final

All 500 outputs of the conductor-10000 Gauss slice passed independent 448-bit direct Fourier checks. The largest error ceiling was **56 p307 grid units** before terminal rounding and **57 units** afterward, both at frequency 186. The generic nearest-coordinate bounds are 1,768 and 1,769 units, respectively.

The independent calculation used exact schoolbook circular convolution. Its integer outputs are ready for comparison with the packed Kronecker backend. [Expected outputs](../../../work/backend-costs-20261112/hol-platt/c10000-kronecker-error/expected.tsv) · [Derivation](../../../work/backend-costs-20261112/hol-platt/c10000-kronecker-error/README.md)

## 20:05:48 UTC · Final

The **65,536-slot tile plan** covers all 7,499 conductors while limiting each scalar multiplication to **6.10 MB per operand**, before scratch. Counting only tile pairs that reach a requested sample gives **1,051,852,215 scalar products** and **1,836,492,654 accumulation pieces**.

Measured single-threaded product timings imply **86,426 CPU hours for multiplication alone**, assuming full-sized operands for ragged tiles. Packing, accumulation, chirp generation, output processing, proof checking and I/O remain unpriced. The schedule still produces 1.775 trillion real samples.

[Tile derivation and comparison](../../../work/backend-costs-20261112/hol-platt/c10000-kronecker-time-price/TILES.md) · [Counts and timing receipts](../../../work/backend-costs-20261112/hol-platt/c10000-kronecker-time-price/tiles.json) · [Precision and sign-error bound](../../../work/backend-costs-20261112/hol-platt/c10000-kronecker-time-price/README.md)

## 20:14:00 UTC · Final

The generating-function prototype reproduced every scalar numerator and rounded output in the tested cells. At height 1, batching took **0.327 s versus 0.321 s** for scalar Horner across all 131,070 units of conductor 131071. For conductor 265800, it took **0.251 s versus 0.183 s**. Scalar evaluation also won in the two degree-19 tests at conductor 131072, including its final band-1 height.

The certificate direction avoids building the inverse kernel. Checking all 1,025 prime-conductor cells by short integer multiplication took **46.4 ms** for the congruences alone. Setup, seed verification, packing, extraction and final division remain separate costs. No HOL timing was measured.

[Derivation and benchmark comparison](../../../work/backend-costs-20261112/hol-platt/c10004-forward-series/README.md) · [Certificate timings and scalar operation counts](../../../work/backend-costs-20261112/hol-platt/c10004-forward-series/cert.json)

## 20:20:57 UTC · Final

Generated the full h2 source, assembly and spectrum, and sent the fixtures to the HOL worker. All 4,801 retained h1 head states were advanced by one stored step. The separate Euler–Maclaurin coefficient calculation used direct Arb elementary powers at h2.

All 4,800 assembled inputs and 2,301 output channels passed the independent checks. Four p81 input pairs differed from direct Hurwitz rounding. All completed signs remained strict: **1,679 positive and 622 negative**, with 153 channels changing sign between h1 and h2. This completes the native reference; the linked HOL replay is separate.

[Method and validation](../../../work/backend-costs-20261112/hol-platt/c10004-p20-h2/README.md) · [Output hashes and sign receipt](../../../work/backend-costs-20261112/hol-platt/c10004-p20-h2/assembly-receipt.json)
