# Compact integer-sign result review

13 November 2026. PASS for the fixed integer-sign result and the reported phase accounting. No required correction found. This independent review read the saved source, manifests, artifacts and logs, checked hashes and source literals, and recomputed timing sums. It did not rerun HOL, the evaluator, source generation, or any numerical state calculation.

## Source and attempt history

The source reviews remain valid at their stated scope. The only subsequent launcher-input change was converting the predecessor manifest's thirteen CRLF endings to LF. Exact text comparison after that conversion matches the archived original. The original manifest is preserved in history/predecessor_inputs_before_lf_D795B1D3.sha256. Its SHA256 is D795B1D3CBE84D2DCA4742E262A0F4FF04DD55BE69B5637A4262432E3AF592B7; the LF manifest is 7FB0813B14D23CAB1740D2F30DCE297B757C6E6C9D5FF823DBF03955B3447E97. File names and expected hashes did not change.

compact01 stopped at the manifest check before its build phases. compact02 is the first completed build/evaluation attempt, following that documented launcher correction. It is not evidence of two successful timing repetitions.

All forty entries across the prepared, predecessor, run-source, generated-source, built-artifact and export records match their current files. The run records also show successful before/after input checks. An independent exact token comparison matched all thirty-two ordered initial/step integer coordinates against the pinned fixture. The complete included HandoffRuntime source matches its predecessor. This check used the JSON number spellings directly, without floating conversion or state evaluation.

The generated wrapper contains the eight original initial/step pairs, the original base order, denominator 61 and depth 128. It does not contain the expected full result or expected masks. The public theorem is rebound to these literal inputs. The old full theorem is loaded only after the primary-completion marker and is required to have that same public pipeline input.

## Completed proofs and result meaning

Saved generic/build/run exits are all zero. The generic theory log records the sign-code, digit-bound, mask relation and compact correctness proofs, followed by successful CV translations. The completed run audits the primary equality and sign relation as closed results without oracle tags under the allowed ordinary HOL axioms. The context snapshot warning is visible in the run log; it did not bypass these explicit theorem/context checks. This is an audit of that recorded execution, not a second independent kernel replay.

The accepted compact result has four natural masks. A pair contributes code(real)+3*code(imag), where negative, zero and positive have codes 0, 1 and 2. Time zero is the least significant base-nine digit. With the external row length 129, the four masks describe all 1032 integer coordinate signs of the four final head rows. They omit magnitudes. Mask values alone do not encode row lengths, and high zero digits represent negative/negative pairs.

The wrapper specializes raw_compact_correct and checks the exact resulting raw_sign_summary_rel statement. After primary completion it maps the same packer over the old full theorem's RHS, composes that equality with AP_TERM and TRANS, and checks exact agreement with the expanded primary compact equality. The log records COMPACT_MATCHED_OLD_FULL_SIGNS,1032. This verifies the sign-only information against the original full output; it does not make the two output contracts identical.

All four rejection controls passed: changed base label, denominator, depth and first mask. The negative-tie and sign-code controls also passed. Magnitude corruptions that preserve signs are not promised to be rejected by this compact contract. The original pipeline still computes its eight traces and four head rows and performs the inherited shape/bound checks. There is no new analytic source bridge, Hardy-function sign certificate, or zero count.

## Timing interpretation

The following are saved instrumented CPU seconds, independently summed only before the respective primary marker.

| Phase | Old full result | Compact result |
|---|---:|---:|
| Primary instrumented total | 0.657195 | 0.053642 |
| Evaluator compute | 0.015590 | 0.003682 |
| Result decode | 0.543517 | 0.001258 |

The primary total falls by 0.603553 seconds; the measured decode difference alone is 0.542259 seconds. These observations support a result-representation improvement for this fixed sign-only task. They do not measure an arithmetic speedup. In particular, the compute phase includes evaluator result construction and can change with output shape; noise and one-run conditions are not separated here. The new calculation still includes the original state/head work plus sign packing. No full-model cost refund or throughput extrapolation follows.

The primary sums omit uninstrumented parsing, some term construction/audits, process startup, generic-library construction and export. They also exclude the intentionally subsequent old-result validation and controls. The saved complete process costs are separate:

| Process | User+system CPU seconds | Wall seconds | Maximum RSS KiB |
|---|---:|---:|---:|
| Generic theory build | 14.66 | 91.24 | 415296 |
| Executable build | 3.04 | 34.08 | 21784 |
| Complete run, including old-result validation and controls | 13.32 | 23.01 | 842444 |

These process totals must not be added to their included instrumented phases. The post-primary old-full load alone is 0.670780 CPU seconds and its full-result representation phase is 3.260686 seconds. They remain real validation costs for this experiment. The generator receipt's zero CPU reading is timer-resolution evidence, not a claim of free generation; its internal elapsed reading is about 0.0032213 seconds and excludes startup and output writes.

## Result bindings

| File | SHA256 |
|---|---|
| compact_fused.sml | 7CBC653BFB8C3EB826738311D504EA5442F05F99261B60BF4440290DA63CBE0B |
| RawCompactSignsScript.sml | 1B26201077B2FEDB21712482F73531D02C40DAACEE2983820D97393D2577140D |
| compact02_run.log | CB1C515407409183ED241798F59930E5812AB2CF1DC489B971CB05D489A4A6F4 |
| compact02_source.sha256 | BAA50F135FF7FFBF4C0B778C39532A7B770AB013C6DE9805501EB0C34E0D70A2 |
| compact02_built.artifacts | F632D13C1CCA35D95FB1B41F23482FF1C9090D701EEC288E7BE6CDA38212BB6F |
| compact02_export.sha256 | 3B8785FE97078B5F8C85374F193678DFC43C7F9BB1164788A8AD752F5BFD7580 |
| .hol/objs/CompactFusedResultsTheory.dat | 57C4D802F35CDCE7D2115FE3FC5DDB83533CA5DA2988E5CD465C37E26442797A |

The export contains primary results and validation/control theorems together. Its serialized size is not a measurement of a minimal sign-only export. Any later warm-readback or consumer benchmark must keep that distinction and the external row-length requirement explicit.
