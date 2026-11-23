# Actual prime-mask cover experiments

2026-11-10. These are measured numerical experiments, not PA/MM0 or Lean proofs. They replace the earlier independent-random-mask model for the sampled cases only.

With 512 actual prime anchors, greedy covers of the sampled interior/high 64-target words used **11.175 masks on average, maximum 14**. Sequential coverage used 64.445 attempted masks on average. All sampled chunks through 1,048,576 target bits were covered by the first 512 anchors. The largest observed sequential prefix was 284 anchors for a 65,536-bit chunk. Native C construction plus greedy search took about **3.7 microseconds per 64-target word** in the scalar baseline and **1.3 microseconds** after the checked SIMD refinement, on the sampled interior/high data.

## Data and numerical validation

The block length is 2^32 even targets and the anchor interval is [B-2^20,B). Four exact block origins were used:

    3999999988766605316
    3999999980176670724
    3999999928637063172
    1999999985793368068

All sampled targets remain below 4e18. Each base has two ordered pools of 1,024 distinct prime anchors. The `nearest` pool searches downward from B; the `spread` pool tests deterministically seeded random odd positions throughout the interval. The 512 pool is the first half of the corresponding 1,024 pool. This preserves actual residue-class correlations between anchor q and small prime p=n-q. It also means the pool-size comparisons are paired, not independent samples.

Every anchor was tested using `flint.fmpz.is_prime`, not `is_probable_prime`. FLINT documents the former as a primality decision with proof of correctness; the experiment does not export a PA or Lean certificate from that call. See [FLINT's function documentation](https://flintlib.org/doc/fmpz/fmpz_is_prime.html). Python-flint was version 0.9.0, NumPy 2.5.4, Python 3.14.7 on Windows 11.

Small-prime masks came from local Eratosthenes sieves with all base primes through the square root of the window maximum. The entire 8.6-billion-entry range was not allocated or sieved. Five positions were tested, near 0, 1/4, 1/2, 3/4 and the end of the small-prime range. Random entries in each initial window were checked independently with FLINT, and 5,120 selected small-prime witnesses were checked again with FLINT. Every generated selected union and every C search count was checked against the Python results.

`results.json` contains pool values, case distributions, timing fields and script hashes. `words.jsonl` contains the selected anchor indices and outcomes for every 64-bit case. `chunks.json` contains each large-chunk outcome. These files and the deterministic scripts reproduce the experiment; the small-prime table itself can be regenerated.

## 64-target words

Each base/position pair sampled 128 contiguous words. There are 2,560 distinct target words, observed under two anchor-selection schemes and two pool sizes. Reported observations therefore overlap; they are not 10,240 independent trials.

| Pool | Observations | Greedy mean | Median | 99th percentile | Maximum | Failures |
|---|---:|---:|---:|---:|---:|---:|
| 512 | 5,120 | 10.4492 | 11 | 13 | 14 | 0 |
| 1,024 | 5,120 | 9.78965 | 10 | 12 | 12 | 0 |

The first fifth of these cases lies near small prime p=0, where prime density is much greater. It should not receive a 20% weight in a whole-range forecast. Excluding that initial position gives:

| Pool | Interior/high observations | Greedy mean | Sequential attempted mean |
|---|---:|---:|---:|
| 512 | 4,096 | 11.17456 | 64.44531 |
| 1,024 | 4,096 | 10.42603 | 64.44531 |

For the highest-position words alone, the eight 512-pool case means range from 11.266 to 11.508. The nearest-pool interior/high mean is 11.1113; the spread-pool mean is 11.2378. The largest observed greedy cover still has 14 masks. This supports testing a 15-mask planning value, but it does not prove an all-range average or maximum.

Sequential search stops as soon as its union covers the word. Across all positions it attempted 57.5715 masks on average, maximum 187, and retained 24.7025 masks on average if masks adding no new bits are discarded. The attempted counts are identical for the two pool sizes because all these prefixes ended before anchor 512. Greedy searches the entire permitted pool and retains substantially fewer masks; its producer cost is higher.

## Larger chunks for bigint-oriented checkers

At each base and selection scheme, four chunks were sampled near each of the same five positions. The 1,024- and 16,384-bit chunks lie inside the larger 65,536-bit samples. Four additional 1-Mibit cases use the first base, both selection schemes, and low/high positions. The numerical samples cover 6,815,744 distinct even targets, with substantial overlap among representations and pool choices.

| Chunk bits | Cases per pool | Sequential first-full mean | Maximum | Missing bits with all 512 |
|---:|---:|---:|---:|---:|
| 1,024 | 160 | 98.4063 | 224 | 0 |
| 16,384 | 160 | 138.4375 | 235 | 0 |
| 65,536 | 160 | 158.9875 | 284 | 0 |
| 1,048,576 | 4 | 167.25 | 250 | 0 |

Again, the low position lowers the overall means. In the two high 1-Mibit cases, the nearest and spread pools needed 250 and 182 anchors, respectively. The high-end small-prime mask density was approximately .0875. All 1,024-pool prefix results were identical to the 512 results because the first complete union already occurred within the first 512.

This is a concrete reason to benchmark large kernel bit operations separately from 64-bit greedy certificates. A Lean checker might profit from 160-250 large OR operations instead of thousands of separately justified selected-word masks. Whether it does depends on literal decoding, slice construction, kernel reduction and the semantic proof. These numerical results do not establish that performance comparison.

The Python chunk timing performs every OR through anchor 512 or 1,024, including iterations after the first complete prefix. It records the first-full index but does not stop timing there. With 512 masks, the accumulated timings were about 1.46 ms per 65,536-bit case and 21.4 ms per 1-Mibit case. Those include Python loops, integer equality and bookkeeping; they are not bare native OR or Lean kernel timings. Mask construction is recorded separately in the raw file.

## Measured native search

The native programs were compiled with the existing bundled `leanc.exe -O3 -march=native`. They are C microbenchmarks, not Lean proof compilations. Because system stdio headers are absent, they use explicit Windows x64 declarations, matching the parent's baseline setup. The compiler emitted declaration warnings for fopen/fread, and both executables completed with the expected counts and checksums.

Three sequential trials were saved for each program. `native_greedy.c` reads prebuilt 64-bit masks; `native_construct.c` additionally constructs each candidate from two adjacent words of the shared small-prime window and its shift. The latter excludes the initial low-position window. It preserves the narrow source-window reuse of the proposed implementation. The table reports wall-clock time per target word, with process CPU time also retained in JSON.

| Actual C workload | Pool | Median microseconds/word | Three-run range |
|---|---:|---:|---:|
| Greedy on prebuilt masks, all positions | 512 | 3.375 | 3.250-3.400 |
| Greedy on prebuilt masks, all positions | 1,024 | 5.641 | 5.461-5.768 |
| Construct + greedy, interior/high | 512 | 3.684 | 3.622-4.038 |
| Construct + greedy, interior/high | 1,024 | 7.256 | 7.027-8.286 |
| Lazy construct + sequential, interior/high | 512 | .0930 | .0823-.0976 |
| Lazy construct + sequential, interior/high | 1,024 | .0773 | .0718-.0875 |

The last two algorithms examine identical prefixes; their timing difference is ordinary run/cache/code variation, not a benefit established for the larger pool. Process CPU timing has a coarse quantum at these durations, so the high-resolution wall-clock readings are also reported rather than overstating precision.

The native construction benchmark includes source loads, bit slicing and greedy selection. It excludes anchor generation, small-table construction, proof emission, formal checking, disk input and cold streaming of a whole proof. Inputs are revisited in timed repetitions. That is appropriate for a microbenchmark, not a full-system throughput claim. A naive extrapolation of the 512 construction-plus-greedy median over 3.125e16 words is approximately 3,650 core-years for this component alone; hardware, larger-scale memory behavior and proof production can change it. The earlier 5-microsecond-per-word search allowance is plausible for this measured component.

For contrast, the Python/NumPy greedy loop took approximately 44 microseconds per word in this run. The whole initial Python experiment took 2.20 wall seconds, including 0.106 seconds selecting all anchor pools, 0.026 seconds for initial sieves, and 1.059 seconds building the 1,024-mask matrices. These Python and native timings must not be mixed into one conversion factor.

## Fixtures for formal microbenchmarks

`lean_fixtures.json` supplies actual high-end fixtures at widths 1,024, 16,384 and 65,536. Their selected sequential prefixes contain 110, 168 and 168 anchors. Each fixture includes:

- the source bitmap as a hexadecimal integer and its exact bit length;
- the bit/odd-slot shift for every selected anchor;
- the expected all-ones union;
- the first odd integer represented by the source, the target origin and all anchor values.

The exporter checks the identity `source_first_odd + 2*(shift+j) = target_origin + 2*j - anchor` through its construction and checks the complete bigint union. Source lengths are 3,284, 19,925 and 69,077 bits after removing unused leading/trailing data. These are real numerical fixtures; their prime provenance remains an additional formal theorem to prove.

## Reproduction

Run from the repository root using the existing interval environment:

    work/qrh-campaign/interval-env/Scripts/python.exe work/formal-goldbach-bench/prime-cover/actual_cover.py --words 128
    work/qrh-campaign/interval-env/Scripts/python.exe work/formal-goldbach-bench/prime-cover/chunk_cover.py
    work/qrh-campaign/interval-env/Scripts/python.exe work/formal-goldbach-bench/prime-cover/export_fixtures.py

Compile `native_greedy.c` and `native_construct.c` with the bundled leanc command above. Run the first with `native_masks.bin`, the second with `source_masks.bin`. The raw native results are `native_run_1.json` through `_3.json` and `native_construct_run_1.json` through `_3.json`.

## Limits of the conclusion

No sampled 512 pool failed, including the 1-Mibit samples. This is evidence of feasibility at those bases and offsets, not a proof that every block of the target range has a successful fixed-size pool. The samples are deliberately structured and correlated, not uniformly independent trials. They cannot justify a binomial all-range failure bound. A complete certificate generator still needs pool enlargement and explicitly certified exceptional representations, and must prove the primality provenance and every covering operation in its chosen formal system.

## Measured smaller-pool tradeoff

A further C experiment reused the 4,096 interior/high word fixtures. It first runs greedy selection within 64, 128 or 256 anchors. If those masks leave uncovered bits and no further progress is possible, it constructs the rest of the 512 pool and greedily covers only the remaining bits. The selected early masks are retained. Thus the fallback cost and possibly larger final cover are included, rather than replacing a failed small-pool search with a free fresh solution.

`native_pool_grid.c` was compiled with the same flags. Three timing runs are saved in `pool_grid_run_1.json` through `_3.json`; `analyze_pool_grid.py` independently reconstructed the selected-count histogram and fallback count in NumPy for every greedy case and found exact agreement. `pool_grid_summary.json` holds the derived timing and cost scenarios.

| Initial pool | Mean selected after fallback | Words requiring fallback | Median native microseconds/word |
|---|---:|---:|---:|
| 64 | 16.8894 | 1,693 / 4,096 = 41.33% | 1.0336 |
| 128 | 14.1675 | 38 / 4,096 = .928% | 1.2922 |
| 256 | 12.3889 | 0 / 4,096 | 2.0654 |
| 512 | 11.1746 | Not applicable | 3.6394 |
| Sequential, retain productive masks | 26.7454 | Not applicable | .1081 |

All these times include source-word loads and slicing. The sequential case generates masks lazily and stops at full coverage. The native timings are repeated microbenchmarks, with the same cache and system-level limitations described above.

For an independently measured downstream cost lambda microseconds per retained mask, compare `search_time + lambda * mean_selected`. Among the tested choices:

| Assumed additional microseconds per retained mask | Lowest measured-plus-modeled choice |
|---:|---|
| 0 | Sequential productive |
| .1 | Greedy 128 with fallback |
| .5 | Greedy 256 with fallback |
| 1 | Greedy 256 with fallback |
| 2 | Greedy 512 |
| 5 | Greedy 512 |

For example, at lambda=.5, the 256-pool total is 8.260 microseconds/word versus 9.227 for 512. This is a genuine producer/checker tradeoff, not evidence that one fixed pool is optimal for both MM0 and Lean. The cost model assumes additive per-mask downstream cost for a 64-target-word certificate. A bigint-oriented Lean certificate may prefer the large-chunk strategy and must be optimized with its own measured cost function.

## SIMD search refinement

The preceding scalar grid is preserved as a baseline, not presented as globally optimized. Inspection showed scalar population-count instructions in its greedy scan. Two separate variants were added using Clang 64-byte vectors and eight 64-bit population counts at once. Both retain exactly the original first-index tie-breaking rule.

`native_pool_grid_simd.c` maintains per-lane scores and indices. The faster `native_pool_grid_simd_key.c` assigns candidate k the key `1024*popcount(mask[k]&remaining)+1023-k`, takes vector maxima and then reduces the eight lane maxima. Because k<512, maximizing this key first maximizes the score and then minimizes k. This avoids a scalar eight-lane tie loop. The generated assembly contains `vpopcntq` and `vpmaxuq`, confirming that the intended AVX-512 operations are used.

Before each timed run, the executable compares SIMD and scalar choices at every visited greedy transition for all 4,096 interior/high rows and each standalone pool size. The fallback runs' entire selected-count histograms also match the independently checked scalar histograms. Three timing runs for each variant are retained. No mask counts or fallback frequencies changed.

| Initial pool | Scalar microseconds/word | First SIMD variant | SIMD key reduction |
|---|---:|---:|---:|
| 64, then fallback | 1.0336 | 1.1279 | .6084 |
| 128, then fallback | 1.2922 | 1.0432 | .4730 |
| 256, then fallback | 2.0654 | 1.2880 | .7577 |
| 512 | 3.6394 | 1.8537 | 1.3025 |
| Sequential productive | .1081 | .1342 | .0940 |

These are three-run median wall times, including source slicing, under the same microbenchmark conditions. The sequential row is unchanged algorithmically; its variation illustrates timing/code-layout noise. The key variant improves the 512-pool greedy measurement by about 2.8 times. Extrapolating only this measured search component over 3.125e16 words gives roughly 1,290 core-years, rather than the scalar component's roughly 3,600. It does not accelerate proof generation, formal checking, or primality certification by that factor.

The measured-plus-modeled optimum consequently changes. With the key variant's timings and the same retained counts, approximate additional-cost crossovers are .03 microseconds/mask for sequential versus 128, .16 for 128 versus 256, and .45 for 256 versus 512. Thus at an additional .5 microseconds per retained mask, 512 now narrowly beats 256. These comparisons still assume an additive per-mask downstream cost; the actual MM0 and Lean checker measurements must supply that cost.

Raw files are `pool_grid_simd_run_1.json` through `_3.json`, `pool_grid_simd_key_run_1.json` through `_3.json`, and `simd_summary.json`. The `.s` files retain the generated assembly. The scalar programs and their results remain unchanged. This is a demonstrated optimization, not a claim that no further algorithmic or compiler optimization is possible.

## Additional formal-checker fixtures

`actual_trace.json` contains 256 complete high-offset word traces from two distinct near-4e18 bases, totaling 2,892 selected updates. Each word starts with an explicit zero accumulator. Every update records its mask, two adjacent source words, shift, anchor, and accumulator before/after the OR. Every final accumulator is all ones. `export_actual_trace.py` checks every mask against the saved native fixture and the selected index in `words.jsonl`. This supports both OR-only and fused-slice MM0 tests without substituting random masks or omitting word resets.

The packed-convolution experiment is documented separately in `PACKED_REPORT.md`. It exports actual-prime operands for a multiplication/addition/AND coverage test through 1-Mibit target widths. Its numerical identity is validated, but native arithmetic measurements favor unexpanded shift/OR; the kernel-level comparison remains separate.
