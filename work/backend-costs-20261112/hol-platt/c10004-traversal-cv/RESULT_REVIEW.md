# Accepted matched outer-traversal diagnostic

Reviewed 13 November 2026. This is a review of recorded construction, stock HOL evaluation and separate code inspection. It is not a complete analytic transform certificate or an independent replay of all imported theories.

## Outcome

The sequential public call is 5.685 to 6.233 times faster than the indexed reference in the four matched warm-median comparisons. It preserves the proved all-input public equality and the original guards. All seven controls passed, including two complete output equalities, the full impulse output, three rejected-input cases and rejection of an altered output. Each timing call separately executes the stock proof-producing evaluator, checks the exact proposition and expected Boolean, checks empty hypotheses and allowed tags, and saves its result.

| Process order | Fixture | Reference median CPU seconds | Sequential median CPU seconds | Reference / sequential |
|---|---:|---:|---:|---:|
| reference_first | 1 | 2.313755 | 0.371214 | 6.233 |
| reference_first | 2 | 2.106625 | 0.370527 | 5.685 |
| sequential_first | 1 | 2.169206 | 0.369218 | 5.875 |
| sequential_first | 2 | 2.245676 | 0.393946 | 5.700 |

| Process order | Fixture | Entry | Three individual warm total CPU observations |
|---|---:|---|---|
| reference_first | 1 | reference | 2.067603 / 2.326794 / 2.313755 |
| reference_first | 1 | sequential | 0.371214 / 0.360669 / 0.378855 |
| reference_first | 2 | reference | 2.106625 / 2.164425 / 2.086254 |
| reference_first | 2 | sequential | 0.410079 / 0.364304 / 0.370527 |
| sequential_first | 1 | reference | 2.165291 / 2.169206 / 2.176495 |
| sequential_first | 1 | sequential | 0.367775 / 0.369218 / 0.385812 |
| sequential_first | 2 | reference | 2.177948 / 2.245676 / 2.259468 |
| sequential_first | 2 | sequential | 0.423412 / 0.384957 / 0.393946 |

The eight first calls are retained separately in cv01_parsed_timings.json and the raw logs. They are first calls within already loaded processes, not fresh whole-library construction. Warm repetitions retain stock translation and characteristic-equation caches. The code creates and applies a computation conversion every time; it does not retrieve a previously proved closed result. Compute.sml calls its interpreter on each supplied term. Its cached setup checks do not replace that execution.

The synthetic inputs and root cache are produced inside each evaluated expression. Named expression preparation takes about 0.0012 to 0.0014 seconds at the pooled warm medians; almost all observed time is in the execution phase. These fixtures do not measure admission of externally supplied literal arrays or actual analytic input generation. The full split includes preparation, execution, Boolean decoding, discharge, audit/storage and total CPU in the JSON and raw logs.

## Proof and code review

CV01 constructed all ten traversal translations and three diagnostic translations through unchanged stock HOL rules. The separate inspect01 run loaded and audited all thirteen translations. Each is an unconditional equality with empty theorem hypotheses. It audited every reachable code equation and required the sequential public call to contain the sequential pair/take/chunk/head-tail/transpose/concat/tensor/checked functions and exclude the reference tensor/checked functions. The reference call has the reverse dependency condition. The output comparison contains both programs. This rules out using the public equivalence theorem to silently translate the sequential benchmark back into the reference or to replace the comparison by a constant theorem.

Every evaluated result and generic root has only DISK_THM import tags, no explicit axiom tags and empty hypotheses. Ancestry checks permit only the four standard HOL axioms. The two generic public equalities are checked against exact expected conclusions in every process. This retains the standard serialized-import trust boundary.

The coordinator rehashed eleven expected-source entries, five run-source entries, eighteen dependency/tool entries and six output entries. All matched. The code inspection's ten pinned inputs also matched. All five benchmark phases, both inspection phases and both containers exited zero. The expected record counts and completion markers match. These are recorded-result checks, not a newly constructed proof replay.

## Construction and process costs

| Phase | CPU seconds | Wall seconds | Peak RSS KiB |
|---|---:|---:|---:|
| Translation theory | 10.43 | 62.11 | 389568 |
| Audit module construction | 3.13 | 30.04 | 24912 |
| Seven controls, including load and export | 14.96 | 27.27 | 436808 |
| Reference-first process, including load and export | 29.46 | 40.23 | 442804 |
| Sequential-first process, including load and export | 30.19 | 42.40 | 399120 |
| Phase sum | 88.17 | 202.05 | |

The benchmark container took 210.109 wall seconds. Prerequisite theories were already built and are excluded from these costs; their separate construction records remain. The environment is the pinned local Linux container on an AMD Ryzen 9 8945HS host, limited to one CPU and four GiB, with one HOL GC thread in the audit processes. The CPU model was read from the Windows hardware registry after an unprivileged CIM query was denied. This does not establish a conversion from Platt's historical hardware.

Exported .dat sizes are 33233 bytes for the generic translation theory, 6121 for the controls and 10269/10271 for the two benchmark theories. Their sizes describe these short Boolean conclusions and stored theory format, not an independently replayable primitive proof stream or a campaign export bound.

The inspection launcher initially resolved its workspace one directory too shallow and stopped before launching a container. The preserved initial source records this error. Correcting the launcher path produced the successful inspect01 run; the numerical benchmark was not repeated or changed.

## Cost-model consequence and next work

No campaign factor changes. The model already assumes efficient production adapters, and its nominal arithmetic-only price for this transform is about 0.062634 seconds. The observed 0.37 to 0.40 seconds includes synthetic input generation, root/cache work, guards and data handling as well as arithmetic. Neither the approximately sixfold reference speedup nor the ratio to that arithmetic-only price can be applied to the full model.

This establishes a faster verified outer traversal. Inner arithmetic and indexed root access remain unchanged. Actual sources, certified roots, analytic error, strict signs and count closure still have to be connected and measured. Further research must complete that path and the other representative strata specified in CONFIDENCE_REQUIREMENTS.md before claiming a historical-scale campaign.

## Pins

| Artifact | SHA256 |
|---|---|
| C10004TraversalCVScript.sml | 3ec490060b5a42092de7756c609566b77db45270da0db6d1aedbd6a716607b83 |
| traversal_cv_audit.sml | b6ccc8a081782f0d1cfe9f735b5962667a264fb6906271421d054243ab557ee2 |
| source_expected.sha256 | 6be092c0ce6cc269da303a95e96ed80f670411aae2f9eb2500c92e8fcf2d5840 |
| inspect_code.sml | bbc0d70332223e36052d0f6d09a6c6cc622b621ff45e92a27a84f9da46621fca |
| cv01_parsed_timings.json | 7645283cb905433a64595725184ec535986b40281664787f7f861b9225f133d2 |
