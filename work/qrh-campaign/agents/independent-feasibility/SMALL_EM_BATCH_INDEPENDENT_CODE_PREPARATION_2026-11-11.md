# Prepared independent verifier for the eight-center EM batch

2026-11-11. **Code preparation only. No numerical execution is authorized or claimed.** The new source is ready for independent static review. Only parsing, compilation to an unexecuted code object, AST inspection, and source-file hashing were performed. The module was not imported or executed; no FLINT import, logarithm, exponential, moment, transform, model, or function image was evaluated.

## Frozen artifacts and inputs

Paths are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
|---|---|
| `independent-feasibility/review_small_em_batch_prepared_20261111.py` | `A6F6A8C78B4DC70F657564D19398ADF2E9F8922B005969B7ABAAA62BFBBC5A9A` |
| `independent-feasibility/review_small_em_batch_prepared_syntax_20261111.json` | `044F499982B25A36D40AE8F8CA3B34F2D4C97C5158240D7804420A204AA08D33` |
| Bound producer source `integration/small_em_batch_candidate_20261111.py` | `23D358590279AA810EAE764D3FEEA0756C51DF8CF0EA6F05B457A192BB82822C` |
| Producer preparation/schema `integration/SMALL_EM_BATCH_CODE_PREPARATION_2026-11-11.md` | `65379869F849BB27BE9DF4974F73984269FECF1C408C442D2C772BFF37E53500` |
| Main pilot specification | `3977881D20CFE9F948E850AC9A83CF50084AA1EF7D0B7023E5D1A95DE845B929` |
| Corrected small scalar support | `47256C6265C63BF1851B0FD7347F57BC18849AA7B629FFA72442EF9D05A22D23` |
| Receipt contract | `DA2740C39148A2F1AB2291E6581B5C55A75BF33456E8006CB148B34B516178AF` |
| Independent paper preflight | `E8D928EB25CA0AAB583609D33DF982CFC2A1D01E65890AE8BCBBB58C4BF9C7F0` |

The source's literal PINS table additionally binds the scalar script/receipt, generic batching proof/review, EM source proof/review, finite coefficient semantics/review, and DFT contract/review. The AST-only receipt records every one of those pins and their verified current bytes. Reading producer code and schema was limited to read-only interface alignment and source inspection. This verifier never imports or executes producer code.

## Independent numerical paths prepared

All future numerical operations use fixed 224-bit external FLINT elementary interval arithmetic. The producer uses 192 bits. The exact target remains N1024, B1025, M16, K16, p24, J8, L32, sigma629/1250, t0=31999/16, Delta=-1/8, outer radius1 and actual radius1/16. No command-line parameter can change these values.

1. Recompute all 1024 real bin coordinates and residuals. The independently computed interval must lie in each original witness interval; the signed q and its residue are never reselected. Exact rational checks validate the midpoint rule, width, complete assignment and residual domain. The independent receipt retains all these computed enclosures.
2. Rebuild all 12,288 moments by an n-major loop. Each n's normalized h factors and residual m factors are constructed independently at224 bits, then added to the fixed bins. This differs from the producer's h-streamed implementation. Every resulting rectangle must fit wholly in its fixed claimed Euclidean disk. Zero-radius claims require exact containment too.
3. Directly sum each 32-term positive normalized DFT at every consumed index (-j) mod32. The inputs are the exact rational stored moment centers. There are 3,072 checks and 98,304 summands. No FFT routine or butterfly algorithm is used by the verifier. This certifies arithmetic-output claims separately from the actual-moment claims.
4. Compute all128 finite-g jets directly at all8 centers, without bins or transforms. Exponential coefficients use the manual `v_(h+1)=v_h*(-log n)/(h+1)` recurrence. Correction assembly separately forms `D=main+EB/2+EB*A` and `H=exp((1-s)log B)`, then `G_h=(s-1)D_h+D_(h-1)+H_h`. H is evaluated separately rather than inferred by the producer's B-phase recurrence. Every independent coefficient box must be wholly contained in the producer's fixed coordinate-halfwidth2^-52 square.
5. Reconstruct all8 whole-panel and9 endpoint images using exact rational rectangle operations and the independently verified fixed coefficient boxes. The operation order matches the frozen schema: descending Horner, predivision EM+Taylor coordinate padding once, conjugate-coordinate reciprocal with correct unary squares, then Cartesian multiplication. The denominator lower bound must be positive. Exact rational endpoint equality is required, with deterministic endpoint owner min(l,7).

The receipt preserves every independent moment/DFT box and its sufficient L1 disk-containment bound, all128 independent direct-g boxes, and all17 exact reconstructed images. Lexicographic array position has the frozen h/m/k or h/m/j meaning. A partial run retains only completed checks and never reports complete PASS. No nonvanishing, coordinate-sign, polygon or zero-count success is required.

## Exact checks and diagnostic scope

Consumed row shapes, counts and index orders are exact. A disk radius must be exactly2^-110 or a separately checked exact zero; zero radius also requires zero center. A wider disk cannot evade the budget. Every final g coordinate radius must be exactly2^-52. Optional producer `computed` boxes must themselves fit the claimed moment/DFT disks, using a sufficient L1 test. The full independent true-value containment checks remain separate.

The four diagnostic sections are required and their documented structures are checked. The verifier also replays the main-jet error accounting by exact rational arithmetic. It reconstructs the contraction from stored transform centers, checks that point's inclusion in the recorded arithmetic ball, verifies the full ball-to-center error bound, and checks the exact source-input, transform and residual error sums. Bernoulli constants, phase-error recurrence, correction/assembly caps and all diagnostic array dimensions are checked.

These additional checks do not independently prove that every recorded elementary or internal R/Q/C ball contains its analytic target. Those internal diagnostic claims still rely on the producer's reviewed source and external interval arithmetic. The mandatory independent moment, center-DFT and direct-g paths establish the consumed output claims without treating the diagnostic log/phase/correction records as analytic oracles. This preparation does not claim a standalone proof trace or a verified numerical library.

## Serialization and bounded parser

The code implements the agreed disjoint scalar formats. Internal balls use canonical signed-exponent dyadics with odd mantissa, or zero represented by(0,0). Final images and analytic pads use reduced signed-numerator/positive-denominator rationals. No float is used as a mathematical endpoint.

Duplicate JSON keys, booleans where integers are required, nonfinite numbers, malformed rationals, negative radii, unordered intervals, missing/duplicate indices and changed targets are rejected. Input reads and hashes are bounded to64MiB before allocation of larger file contents. Recursive shape checks cap depth32, total visited values2,000,000, list length20,000, object width128 and string length4096. JSON integer tokens have their own digit cap. Mathematical integer strings are checked before conversion. Dyadic mantissas are capped at4096 bits and exponents at absolute8192 before shifts. Exact rational integers are capped at16,384 bits. These are additional conservative rejection limits, not a proof that arbitrary packets of those maximum sizes are efficient.

The complete candidate's status, producer-code hash, exact ten-entry producer pin dictionary, exact parameter manifest, full analytical pads and recorded producer time/memory caps are checked before FLINT is imported. Missing, additional or changed producer pins are rejected. The verifier checks all locally pinned source bytes separately. A source hash or candidate PASS label never substitutes for the numerical containment tests.

## Runtime authorization and output discipline

No run manifest was created. A future coordinator manifest must have schema `small-em-batch-independent-run-v1` and action `RUN_ONE_SMALL_EM_BATCH_REVIEW`. Its exact keys are:

* `schema`, `authorize`, `independent_code_sha256`;
* `producer_code`, `candidate`, `static_review`, each with an agents-relative path and SHA256;
* `pins`, exactly the source's literal PINS mapping;
* `output`, a new agents-relative JSON path owned by independent-feasibility.

The producer path/hash must equal the frozen version bound in this source. The candidate and future static-review hashes are supplied only after their actual artifacts exist and the coordinator approves them. The static-review file hash is a gate controlled by the coordinator, not a programmatic proof that arbitrary text constitutes approval. Manifest paths stay within the agents workspace. The future invocation is the prepared script with `--manifest` and that approved manifest path; the script offers no evaluation mode without this gate.

One attempt has a360-second wall cap,512MiB evaluator-process peak-working-set cap and64MiB receipt cap. Windows GetProcessMemoryInfo supplies peak working set; missing telemetry fails closed. There are no child-process, delegation, retry, precision-increase or retuning paths. Guards occur during parsing, source hashing, each numerical phase and inner loops, exact image construction, serialization and publication. The candidate hash is checked again after the complete review.

The output is reserved with exclusive binary creation and starts as an INCOMPLETE record. Existing artifacts are never overwritten. Subsequent writes use only that exclusively owned attempt handle. The large result is serialized inside the cap; a telemetry footer is sampled after that serialization and before publication. Further guards run after writing/flushing and checking physical byte count. If serialization or a post-write guard fails, only this attempt's owned handle is truncated to a bounded failure record. BaseException handling includes a KeyboardInterrupt during publication, rather than leaving its observed interruption as a completed result. The stdout completion record includes telemetry after publication and binds the receipt SHA256, candidate SHA256 and independent source SHA256.

A complete accepted run requires process exit0 and its final completion record as well as the receipt. The coordinator must verify that the final console hashes match the actual receipt, authorized candidate and frozen verifier. An external kill can leave an incomplete or not-finally-confirmed file; even a PASS-looking file alone must not be accepted as a completed attempt. The footer explicitly identifies its before-publication snapshot phase rather than presenting it as the exact final process runtime. These are observed stop/acceptance rules, not a hard real-time OS guarantee.

## Status

Syntax/AST and static pin checks pass. They do not test FLINT API execution, evaluator correctness in operation, actual containment, runtime, memory, or receipt size. All those remain unmeasured. Independent static review must bind this code and the producer before the coordinator considers a separate bounded run authorization. Even a successful later experiment would establish only this fixed external-interval/paper-analysis evaluator result, with no Lean proof, rational-only transcendental certificate, new spectral coverage or production speed claim.
