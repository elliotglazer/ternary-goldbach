# Typed evaluator smoke result review

2026-11-13. Independent source and receipt audit of `typed01`. No builds, workload evaluations, or reruns were performed for this review.

Verdict: PASS for the bounded differential experiment. Both process orders completed with exit status 0, all expected checks, and unchanged pinned inputs. The result supports a faster raw typed evaluator on these fixed requests. It does not establish a faster theorem-producing evaluator, an independently replayed export, or a whole-campaign speedup.

## Source and runtime binding

This review consumes `REVIEW.md` SHA256 `7097F9A1F0733F785517DD7B2AC238CD78B47FF2FBBF822E0F06F0CD94819B12` and `REVIEW_NAMESPACE_AMENDMENT.md` SHA256 `C0C8DDD0C62BFED1AD2CF13CB798077C5A39CADBFD7464E78A29F039328998E7`. The final workload is `TypedWorkload.sml` SHA256 `63B33C7C5A94976A0451176F7FF84969C6CC688C3A95CE6B4406B29511F89231`; its manifest is `source_binding.json` SHA256 `52015325D1386F6BFA3656B24E3927ABDAF25A1E9E413B147DBFF7CF08D25029`.

I independently matched all 29 entries in the launch manifests to current file bytes: 19 source entries, six imported theory artifacts, three toolchain entries, and the executable. The runner's postchecks also report every entry OK. Manifest hashes are:

| File | SHA256 |
| --- | --- |
| typed01_sources.sha256 | 80B5CD84B3F5501EBB772276751AE092C37A3F697AB3613B4759C6B2DC3ACFD6 |
| typed01_dependencies.sha256 | F301270460F2554404779C7FBA2B0C5EDAADC94278C02CF738FF77010850B5C6 |
| typed01_toolchain.sha256 | F3E37EF6CB76AD38D2000B2A2DF578134E0CE5FE1D02092A8B27371DE24128F5 |
| typed01_executable.sha256 | 3BF9C64B1CA1B0382D9DF1CACDA0D855E89A3F407BDC34A81996CA12B5861096 |

`run_typed.sh` applies a 4 GiB virtual-memory limit and a 600-second timeout per phase. The successful build uses `Holmake --no_prereqs`; it is not a clean dependency/library rebuild. The small executable wrapper is not the entire runtime identity: the source and imported artifact manifests remain necessary.

## What actually passed

Each process has exactly 213 distinct timing labels matching the expected set, one 22-edge success marker, nine workload success markers, five false-control rejection markers, and the final completion marker. Each of the nine requests compares the entire output array and Boolean on all three samples. This is stronger than a checksum-only comparison. Array and acceptance calls execute separately; the acceptance call recomputes the block.

The requests use 128 complex input pairs at depths 1, 8, 32, and 128, plus altered checksum, bound, depth, input, and coefficient controls. The altered-depth control uses depth 7; the other controls use depth 8. The 22 edge checks comprise eight signed floor/tie cases, six whole-array cases, five invalid-input rejections, and three malformed CV decoding rejections. Both order logs contain the same equation-count structure: 32 prepared requests and 448 recorded equation occurrences. These are occurrences, not 448 distinct library theorems. Each main array request uses 15 equations and each acceptance request uses 21.

The typed worker uses `IntInf` arithmetic and two buffers with the reviewed rotation convention. It constructs no HOL theorems. For the first sample of each request, stock `cv_compute` independently produces a theorem about the exact CV input and full raw result, and the driver checks its conclusion and empty hypotheses. The original four positive and five negative source-level checks also pass. Their nine printed tags have only `DISK_THM`, with empty direct-axiom lists; the declared HOL context retains SELECT, INFINITY, ETA, and BOOL_CASES. Imported theory trust is not removed by an empty direct-axiom list.

The two exported `.dat` files are byte-identical, each 11,616,455 bytes, SHA256 `7E542FA304030C5D56216D50D725984FD5E9EEAC59B8E5CF913FA27DB73DEE0A`. This audit checks source, log, and artifact binding. It does not perform a separate kernel readback of those files, prove the typed worker correct for arbitrary requests, or introduce native result acceptance.

## Matched raw CPU measurements

Seconds below are medians of three calls within one process per order, not three independent process measurements. Each row compares the same timing field. The order switch tests one source of bias but does not establish a stable distribution.

| Order | Depth | Stock array | Typed array | Stock acceptance | Typed acceptance |
| --- | ---: | ---: | ---: | ---: | ---: |
| stock-first | 1 | 0.000346 | 0.000081 | 0.000597 | 0.000119 |
| stock-first | 8 | 0.001926 | 0.000557 | 0.002062 | 0.000571 |
| stock-first | 32 | 0.008025 | 0.002483 | 0.008190 | 0.002334 |
| stock-first | 128 | 0.033812 | 0.010714 | 0.031197 | 0.011216 |
| typed-first | 1 | 0.000303 | 0.000121 | 0.000531 | 0.000123 |
| typed-first | 8 | 0.001759 | 0.000613 | 0.002430 | 0.000632 |
| typed-first | 32 | 0.007514 | 0.002544 | 0.011714 | 0.002494 |
| typed-first | 128 | 0.031107 | 0.009843 | 0.032518 | 0.010119 |

At depth 128, stock/typed median ratios are 3.155871 and 3.160317 for raw arrays, and 2.781473 and 3.213559 for raw acceptance. The stock-first raw acceptance samples range from 0.030733 to 0.060424 seconds; typed acceptance ranges from 0.009960 to 0.044185. This variability argues against overinterpreting one warm median. No ratio here uses the earlier roughly 0.074-second full-call measurement as a raw-execution denominator.

The depth-128 boundary costs are material:

| CPU seconds | stock-first | typed-first |
| --- | ---: | ---: |
| Decode and validate typed inputs | 0.086076 | 0.077494 |
| Array equation discovery / parse | 0.007917 / 0.013474 | 0.020757 / 0.014620 |
| Acceptance equation discovery / parse | 0.014124 / 0.013643 | 0.014504 / 0.014083 |
| Stock kernel array reference | 0.088771 | 0.108070 |
| Stock kernel acceptance reference | 0.049752 | 0.048406 |

The raw timers omit these phases, result comparison, equation recording, and export. The two reference calls still execute through stock proof acceptance. Reusing decoded inputs or prepared programs needs the same exact input/program binding and an explicit lifetime; it cannot be inferred as a free campaign-wide cache.

## Whole-process and export costs

| Phase | User CPU | System CPU | Total CPU | Wall seconds | Max RSS KiB |
| --- | ---: | ---: | ---: | ---: | ---: |
| Existing-library build | 1.18 | 2.98 | 4.16 | 38.63 | 31,616 |
| stock-first process | 23.91 | 4.47 | 28.38 | 39.31 | 1,556,872 |
| typed-first process | 26.36 | 4.78 | 31.14 | 44.49 | 1,576,328 |

All three exit statuses are 0. Each run includes both implementations, setup, edges, controls, stock references, logging, and export. The two process totals are therefore order diagnostics, not competing backend totals. Recorded theory-export CPU/wall is 5.984781/7.633930 seconds and 7.317721/9.238725 seconds respectively. These costs cannot be hidden inside the raw median or counted again if a future complete-process model already includes them.

## Consequence and next decision

The measured opportunity is the representation and dispatch overhead of stock raw CV execution for this repeated integer block. The typed worker preserves the observed fixed-fixture results and reduces that timed phase. It does not yet reduce proof-acceptance cost: removing the stock reference would remove the existing justification for trusting the computed result.

The next useful step is to specify and review the typed worker's proof-producing acceptance path, with a complete one-shot comparison that charges input decoding, preparation, evaluation, result binding, and acceptance. Retaining a prepared/decoded cache can be a second declared comparison. More warm raw samples alone cannot close this missing trust and cost boundary.

Only matching integer execution/representation rows could eventually change. The experiment supplies no new estimate for analytic source production, root/coefficient certificates, Gamma or logarithm enclosures, sign repair, zero counts, principal work, finite Goldbach coverage, library engineering, or the full selected transform workload. No end-to-end model or forecast is revised.

## Receipt pins

| File | SHA256 |
| --- | --- |
| typed01_build.log | CD046BDB2C2A805F6A277703A00DFC016BC3E6BF51A585387B26D4AA180A1583 |
| typed01_build.time | EF9BB09B6DACCE554A2B25EE618E3E9DE072DFC6E5F28C09B9099A6331FE5DE7 |
| typed01_stock-first_1.log | FD0EF1B76A978700545ED8DE2522B8248A6E672D2ADAD0E505444A85299C4067 |
| typed01_stock-first_1.time | 6FB97ECCD6AFD5A7115232575DC9A52C37425B6A731C43B8CAE4BA4C21A19B98 |
| typed01_typed-first_1.log | 11B23E6C54D948A6BF14BC76EA0E46068336034DB2BF47F9839997FDD3957744 |
| typed01_typed-first_1.time | 19DEF91C0D32430C5A9DBF961C74E8EBBA4FD3B49B7180BF9020C509BE0F5F9E |
| Either validated log | F3E1C2EC62225DED5F5B2639D9EC1DF3C36F27FC17FA2590EA0FF8DF60E2B107 |
| typed01_source_check.log | 8DF6DD55CB951696EE12186D40F5E64D7D807B0F4FF3F0DE6D19A7479337C435 |
| typed01_dependency_check.log | 1E704EABF47A3A201EE80B74916B661BD654C50B9E44B5A9C44BFE7485A280CF |
| typed01_toolchain_check.log | 4E247F5CD71B69702EF85420B5EE7CDB53D6CC92787E7692F1FA618F479A26C3 |
| typed01_executable_check.log | F378BA8AB4BD067CF62BA2050F812BD7EBF920889721FB71A24CA47A95F0E2E4 |
