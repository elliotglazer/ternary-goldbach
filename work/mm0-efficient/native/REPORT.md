# Native whole-chunk coverage checker

This directory contains a native performance prototype for the finite Goldbach coverage step. It is not a PA proof, an MM0 proof, or a verified executable. Prime certification remains a separate input obligation. The prototype never treats an uncovered position as proved.

## Exact checked operation

Each record contains an even target origin `n0`, an odd source origin `p0`, a width `W`, a packed source bitmap, and 512 pairs `(q_i,s_i)`. Before using any pair, the checker verifies that `q_i` is odd and at least 3, that `p0 + 2*s_i + q_i = n0`, and that `s_i + W` lies inside the source bitmap. It uses subtraction after bounds checks for the equality test.

Source bit `j` means that `p0 + 2*j` is prime. Target bit `t` is covered precisely when at least one source bit `s_i+t` is set. Thus a separately certified source bitmap and separately certified prime anchors would turn accepted coverage into Goldbach witnesses for every `n0 + 2*t`, `0 <= t < W`. The current binary checks indices and coverage, not those primality assertions.

Each unaligned 64-bit slice uses two adjacent source words, shifts, and OR. The last source allocation contains a zero guard word. Logical bounds are checked independently of this allocation guard. Tail masks are implemented for widths not divisible by 64, although the actual-prime benchmarks use divisible widths. Source bits outside the logical range are never accepted as witnesses.

## Strategies

Mode 0 uses dense passes, reading every source slice and ORing into every destination word. The same pass accumulates a final all-covered test. Mode 1 maintains a sorted list of incomplete destination words from the start. Modes 2 through 7 begin with 32, 64, 96, 128, 192, or 256 dense anchor passes and then compact the incomplete-word list after every further anchor. No greedy mask selection is performed.

Modes 8 and 9 split the target into 64K-bit and 256K-bit tiles. Each tile uses the 96-pass hybrid strategy and independently stops at its first successful anchor prefix. This bounds the destination working set even when the input record contains a 32 MB source bitmap. The maximum tile prefix equals the first prefix that would cover the whole record. The implementation also rechecks all anchor bounds and identities for each tile, so these timings include that extra work.

`bulk_check.c` is compiled twice from identical source. `bulk_check.exe` uses `-O3 -march=native`; `bulk_scalar.exe` uses `-O3 -march=x86-64 -fno-vectorize -fno-slp-vectorize`. Generated assembly is saved. The native build contains AVX-512 vectorized loops. The scalar build disables compiler loop vectorization; C library allocation, copying and zeroing are still the platform implementations. This is a scalar coverage-loop comparison, not a claim that every instruction in the process avoids SIMD.

## Actual fixtures and controls

`bulk_actual.bin` contains 96 actual-prime cases, 32 each at widths 65,536, 262,144 and 1,048,576. Four distinct target bases near 2e18 and 4e18 supply nearest and spread anchor pools. Source offsets are one quarter, one half, three quarters, and the high end of a 2^32-even block. Offset zero is excluded. Local exact Eratosthenes sieves produce the source bits. The previously generated anchors passed FLINT primality tests. These are numerical data, not exported primality certificates.

`bulk_large.bin` contains 18 actual-prime cases at the same widths. Small-prime values lie near 2^40, 2^48 and 2^52, with a nearest and a spread pool at each scale. All 18 cases cover with their first 512 anchors. At width 1,048,576 the successful prefixes are respectively 278/316, 312/310 and 353/406. The source windows have odd-prime densities 0.0720965, 0.0601063 and 0.0554403. The local sieve uses all primes through the square root of the largest source integer. Its largest base-prime list contains 3,957,809 primes. Generation takes about 5.6 seconds in the recorded Python run; that includes local sieving and anchor tests, not full-range source certification.

`bulk_wide.bin` contains four cases, using two actual anchor pools at widths 2^26 and 2^28. The source bitmaps occupy about 8 MB and 32 MB per record. Successful full-record prefixes are 287/275 and 289/360. The Python reference constructs the exact integer OR independently of the native word loops. Python generated the two local source sieves in about 0.25 and 1.00 seconds. These small-prime values are near 2^33.

Every benchmark starts by checking every positive record with every strategy and comparing its successful prefix with the Python reference. Negative controls clear the entire source, remove all possible witnesses for one chosen target, introduce an out-of-range shift, and break an anchor identity. For wide records the negative control uses a 1M-bit subrange to keep repeated rejection tests bounded. These controls are not a comprehensive software verification campaign.

The fixtures overlap. Repeated timing sweeps and related anchor pools must not be counted as independently verified target ranges. In particular, successful fixed pools in these samples do not guarantee that 512 anchors cover an entire much larger outer block. Production must reject an uncovered chunk and supply a checked fallback or additional anchors.

## Timing scope and reproduction

Each loaded sweep includes validation of all 512 anchor pairs, destination zeroing, source slicing, all coverage work, active-list compaction when selected, and the final coverage decision. Initial file reading and workspace allocation are outside this timed sweep. Each strategy has three timed trials; raw wall and process CPU times are retained. `summary.json` uses median wall time per target bit, where one target bit represents one even integer.

The `stream_parse` measurement additionally opens the file, parses and reads every record, allocates and frees its source and anchor arrays, and checks coverage. It reads an OS-cached file after prior passes. It does not measure cold disk throughput. The fixture format duplicates source windows across target cases; a production source-segment-major schedule can reuse one source segment across multiple target blocks instead. No throughput gain from that different schedule is included here.

Run the three `make_*_fixtures.py` scripts with the existing interval-environment Python. Compile the C file with the flags above and run each executable with one `.bin` argument. Save standard output as JSON, then run `summarize.py`. Binary file headers and record layouts are implemented directly in these scripts and in `read_case`. The two compiler warnings concern explicit declarations of `fopen` and `fread`, used because this packaged compiler lacks the standard I/O headers.

This prototype has not been hardened as an adversarial file parser. Malformed-file cleanup, exhaustive overflow validation for arbitrary origins, root interval scheduling, primality-certificate checking, compiler correctness and machine-code refinement all remain outside this measurement. Those obligations must be completed before accepted records can be used as a proof-producing verifier.

## Results

Final result tables are generated in `summary.json`. The completed native wide run gives the following median wall times, in nanoseconds per even integer.

| Target bitmap size | Dense full-width | Best untiled hybrid | 64K-bit tiles, hybrid96 | 256K-bit tiles, hybrid96 |
| --- | ---: | ---: | ---: | ---: |
| 8 MB | 1.7527 | 0.7255 | 0.2914 | 0.3158 |
| 32 MB | 2.8771 | 1.1259 | 0.3097 | 0.3236 |

The wide fixture file contains 84,181,264 bytes. Parsing, reading, allocating and checking it from the OS cache takes 0.33963 ns per even with 64K-bit tiling. Thus the small destination tiles preserve performance even when the source record is larger than cache. The native wide run passed 40 positive checks and 44 negative controls. Its three tiled loaded trials have process-CPU/wall ratios between 0.93 and 1.07, consistent with the coarse process-time clock and no major scheduling interruption.

The completed scalar build gives the following median wall times on the same fixtures, also in nanoseconds per even integer.

| Target bitmap size | Dense full-width | Best untiled hybrid | 64K-bit tiles, hybrid96 | 256K-bit tiles, hybrid96 |
| --- | ---: | ---: | ---: | ---: |
| 8 MB | 3.3682 | 1.2296 | 1.0383 | 1.1747 |
| 32 MB | 3.9108 | 1.4541 | 1.2029 | 1.1501 |

The best scalar untiled strategy switches after 64 anchors. Scalar parsing and checking of the OS-cached file takes 1.47593 ns per even with 256K-bit tiles. The scalar build also passed 40 positive checks and 44 negative controls, with identical reference-prefix results. Comparing the best strategy for each build, native checking is 3.71 times faster on the 32 MB loaded cases and 4.35 times faster in the cached-file measurement. The scalar implementation remains viable as a simpler first target for machine-code verification, but the SIMD gain is large enough to price explicitly.

Raw final measurements are `bulk_wide_native.json` and `bulk_wide_scalar.json`. `SHA256_MANIFEST.json` records hashes for both binaries, their C source, generated assembly, fixtures, measurements and this report. Optional small-case reruns queued after the scalar test were stopped; they are not part of these results.

At 2e18 even integers, 0.3097 ns each would be about 19.6 core-years of this coverage computation alone. This multiplication is a throughput extrapolation, not an estimate of a completed verified Goldbach proof. It excludes global source sieving, primality certificates, proof-producing or machine-code-verification overhead, fallback frequency, recursive initial ranges and production input transport. The high-p samples are separately needed when choosing much larger outer blocks.

For comparison, the best loaded scalar rate projects to about 72.9 coverage-only core-years, while its cached-file rate projects to 93.5. These are measured C execution rates. They are not achieved rates for an MM0 proof checker or a verified native accelerator.

The completed earlier high-p run, `bulk_large_run_1.json`, has eight strategies. Its modes 0 through 7 have the same meanings as in the final source. Across all six high-p pools, the 1M-bit hybrid128 median is 0.543 ns per even; dense full-width checking is 1.022 ns. These data support a modest density penalty when increasing the small-prime range. They do not establish uniform coverage or a full-range cost. That run's exact executable was overwritten when the two tiled modes were added; the final hash manifest explicitly records this provenance limitation. The final wide native and scalar raw files do match the retained ten-strategy binaries.

`bulk_run_1.json` and `bulk_run_2.json` are historical preliminary runs. In particular, mode 2 in the first run meant hybrid64, before the switch-point grid was added. They are not used for the final wide comparison.
