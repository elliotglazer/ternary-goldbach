# Shared phase table and packed sign admissions

HOL4 proved both conductor-10004 integer sign checks. All 2,301 channels per height passed using a single 2,301-entry kernel-defined phase table. Each height supplied the 4,800 source pairs, two completion factors, one radius and one packed expected-sign vector. The independent sign comparison found 1,732 positive and 569 negative values at height 5/64, and 1,679 positive and 622 negative values at height 10/64. There were 153 opposite endpoint signs.

| Height | Build HOL terms, CPU s | Encode and prepare, CPU s | Execute tensor and sign guards, CPU s | Decode Boolean, CPU s | Discharge, CPU s | Through theorem storage, CPU s |
|---|---:|---:|---:|---:|---:|---:|
| 5/64 | 0.105827 | 3.443965 | 0.488653 | 0.000100 | 0.000073 | 4.243739 |
| 10/64 | 0.096981 | 3.572293 | 0.715813 | 0.000094 | 0.000075 | 4.653073 |

The fresh single-worker admission process took 27.55 s wall and 21.59 s CPU, including loading the phase theory, checking both heights and exporting the closed statements. Peak RSS was 1,344,076 KiB. The earlier fused per-channel coefficient representation took 47.60 s wall, 39.91 s CPU, and 1,635,304 KiB. Per-height CPU through theorem storage fell from 9.399 and 9.915 s to 4.244 and 4.653 s. These are single paired observations from different runs with other local jobs active. Load and wall-time variation limits comparisons. Kernel encoding of the changing source still accounts for most of each admission.

## Setup costs

| Step | Wall s | User + system CPU s | Peak RSS KiB |
|---|---:|---:|---:|
| Generic predicate theory | 90.52 | 22.76 | 377,364 |
| Reusable phase definition and encoding theory | 63.00 | 21.45 | 947,692 |
| Audit module build | 19.23 | 2.91 | 26,808 |
| Two admissions with saved phase theory | 27.55 | 21.59 | 1,344,076 |

Together the successful build and admission steps took 200.30 s wall. Holmake scans and cold process initialization are included. Within the phase theory, defining the literal table and proving and checking the CV encoding consumed 2.294 CPU s. Its exported data occupied 1,568,932 bytes. The two admission theorems occupied another 3,435,010 bytes. The native Gauss and phase generation took 0.374 s for this run. Preparing the parity factors, maximum radii and sign vectors from the existing native spectra/sign tables took 0.018 and 0.021 s. The earlier native generation of those source, root, spectrum and sign files is outside these timings.

The reusable phase TSV occupies 119,758 bytes. The two height records occupy 806 and 805 bytes including a newline, compared with 138,652 and 139,327 bytes of per-height guards in the previous representation. The input source arrays remain independent at each height.

## Checked predicate

Rounded phase and factor coordinates use scale 2^81. For phase (p,q), parity-specific factor (f,g) and spectrum center (r,i), the program forms A = pf − qg and B = pg + qf. Assuming at most one grid unit of error in each phase and factor coordinate, expansion bounds each multiplier-product coordinate error by D = |p| + |q| + |f| + |g| + 2. Given spectrum coordinate radius e and supplied sign s, the program checks

    s (A r − B i) > (|A| + |B|) e + D (|r| + |i| + 2 e).

HOL also checks the nonnegative radius and the complete lengths of the phase and output lists. At the end it requires the remaining sign mask to be zero. A set low bit requests a positive sign, a clear bit a negative sign. Each step shifts the mask right and swaps odd/even completion factors. The native label check verifies that this alternation matches (1 + k41 + k61) modulo 2 in the specified order. The maximum radii were 13,299 and 13,391 p81 grid units. Native recomputation of these guards using previous HOL outputs gave minimum certified arithmetic margins divided by 2^243 of approximately 0.05471460 and 0.02048119.

The kernel proved the phase-encoding equality and both concrete integer predicates with empty hypotheses, only DISK_THM oracle tags, and the standard four HOL axioms in the ancestor audit. Source, root, phase, completion and radius enclosure theorems connecting these literal records to the analytic L-values remain separate obligations.

The first cache build left unreduced integer syntax in the encoding, recorded in s01_replay.log and s02_replay.log. The final phase theory explicitly loads the integer reductions and verifies that its encoding contains only CV syntax before export. The successful records are s01_theory.time, s03_phase_cache.log, s03_phase_cache.time, s03_build.time, s03_replay.log, s03_replay.time and checks.json. run.sh performs the full sequence and admit.sh reuses the compiled generic and phase theories. artifacts.sha256 binds sources, input data and outputs.
