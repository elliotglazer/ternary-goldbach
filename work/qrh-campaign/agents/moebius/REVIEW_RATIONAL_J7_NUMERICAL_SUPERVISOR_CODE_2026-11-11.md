# Rational j7 supervisor source review

Verdict: **PASS for the frozen S/R source components and their final-chain validation contract, with execution gates still open.** This is not acceptance of a complete runnable H/R/S/W system. The separately authored H implementation and its review, evidence for the additional three-job containment arrangement, and a genuine numerical runtime authorization are still required. No numerical worker, inspected supervisor module, native API, process probe, or Lean build was executed in this review.

The review read the sources against the accepted adaptation E3FF0DD6DB600A42496767254CFE44322F1E92F5CE564EB97DC95150B6E60150 and its review DC0A0E113DE9FF002C4710EB15865F7067DBAD2D5C7C902BBE81AA60DF769CA0. Source preparation and syntax success do not establish either host capability or successful rational computation.

## Frozen scope

Paths in this table are under `../integration/`.

| File | SHA256 |
|---|---|
| `rational_j7_supervision_20261111_common.py` | `0BB49255BCF82307BACFB3BA353A3D83217C2023D37DCCDAFE6DDE98623CF154` |
| `rational_j7_supervision_20261111_managed.py` | `F90F2DCC39A2659C2AF372EFEC19CCA73A3E679CE2AFDDAC12DABC0E209423C9` |
| `rational_j7_supervision_20261111_native.py` | `CFC956B179C45AFAEAB5EA1DB42B05C06C643D0A10EC1682CBE0433248248E13` |
| `rational_j7_supervision_20261111_run.py` | `755300B91BA4780D5713DEC6C192E6F60AF50ABE6330F1C258F95C59DD28486C` |
| `rational_j7_supervision_20261111_PREPARATION.md` | `38F3D3B6DE246D65B11F451363BD28750FBBF9E56D050A6FFAE2DDCCA077AB29` |

The scientific sources remain producer B633D322F0B696CDF59FEDB668CE62F4EE13E5BFAC28BC0959E9AF13E37315D7 and independent checker 4762265952B7DD4E5382BC0426205A84BB766EFA43A872DDD6E148EF15674FDC. The result-schema review `../major-constants/REVIEW_RATIONAL_J7_SUPERVISOR_RESULT_SCHEMA_2026-11-11.md`, SHA256 1924FE111A11261E919C847906C6CB9A955464AEED56948CFBDE7BF423FE280F, binds the preceding common FA073C snapshot. The sole subsequent common change is the positive-integer assertion on the original PID; the reviewed numerical schema is unchanged. I also read the current schema against both workers.

## Original handles, clocks, and failure paths

`Managed.start` at managed:55 uses the pinned executable, explicit argument quoting, `-I -S -B`, fixed working directory, suspended detached creation and an explicit inherited-handle list. It reads back the job limit, verifies membership and the actual creation identity before the single resume. The recorded flags are `0x8000C`; job flags are `0x2008`. These constants preserve the intended detached launch and kill-on-close/active-limit contract. They are not a claim that every host supports the additional nesting.

`Managed.wait` at managed:116 retains the original creation handle through signaled exit, fresh postexit memory and identity queries, exit-code retrieval and final job accounting. It checks the deadline after every wait, including a signaled result. Memory acceptance requires a successful fresh query, positive peak, peak at least current working set and all recorded earlier peaks, and the applicable cap. Reopening a PID never substitutes for this handle. The copied native `Win` and `identity_match` source segments exactly match the V5 source 882762361FC9E3AE2AF876CB604E6EA8CCDA2E6C2251872DD79B2593F0953A85.

The numerical limits remain W 600/900 seconds and 512 MiB; S 690/990 seconds and 256 MiB; H must observe R within 750/1050 seconds. The run code also enforces the preparation/finalization windows and R's 128 MiB observed cap. Worker clocks start before CreateProcess, so imports, scientific work and final serialization are included. In particular, the independent worker's JSON encoding after its local telemetry does not escape S's lifetime measurement.

The original draft could leak a successfully created suspended child when identity or job assignment failed. This was corrected: created/assigned/resumed are tracked, and failure cleanup terminates the original process handle as well as the job before its bounded exit wait. No PID-selected termination is introduced. The last review found unchecked early CloseHandle calls; managed:97-101 now checks each pipe-writer and NUL close before clearing the stored handle. A failure retains the handle for cleanup and cannot produce success. Final handle-close failures also force a nonzero observer exit. Failure or unsuccessful cleanup cannot restore an earlier provisional result.

The saved self-peak is deliberately narrower than later cap enforcement. Run:117-119 saves the peak and its query-completion timestamp before inventory hashing and seal construction, with the label `sample_before_inventory_hash_and_seal; later_unsaved_cap_checks; not_postexit`. Later guards enforce the cap but do not retroactively change that saved sample. This resolves the coordinator's scope objection; neither the saved R value nor the self-query is a full postexit measurement of R.

## Job counts and output ownership

Managed:36 records raw accounting and bounded raw PID-list bytes before semantic predicates. Common:380 independently decodes the accounting and list, checks their linkage, positive distinct PIDs, an empty fresh job and the exact original PID singleton before resume. The original PID itself must be a positive integer. Final lifetime totals remain inner 1 and outer 2, with zero limit terminations. There is no incorrect requirement that a retained-handle postexit PID list be empty. The H contract adds its separate total 3; it does not replace these inner predicates.

Common:166 restricts the exclusive token directory and exact worker file family, rejects unexpected entries and reparse aliases, and counts authorization, worker files, logs, metadata and eventual host files together. Publication reserves space for the entire new record plus the remaining final/failure reserve before creating an exclusive pending file. The aggregate is 16 MiB; streams share 64 KiB, ordinary metadata 128 KiB, with 64 KiB retained for final/failure publication. Worker pending/failure files remain charged to the aggregate even where excluded from the ordinary-metadata sublimit. Final host validation recomputes the inventory including `host.json`; it does not trust a declared byte total alone.

These are bounded writes and rejection on observed/final excess, not a kernel filesystem quota. The fixed source and non-adversarial filesystem model matter. Hashes before and after a run do not defeat hostile transient replacement. These limitations are stated in the preparation note rather than hidden behind a hard-resource claim.

## Worker receipts and final host contract

Common:200-351 implements the two actual worker interfaces. Producer validation covers exact parameters, recipe, immutable old j7 targets and analytic-budget projection, ordered 1025 log/phase rows, all 16 head/correction/g records, canonical rational/dyadic fields, fixed radii and gate counts, scalar/counter fields, and the ten named rejected-control dictionaries. The completion record is strictly typed and must match the bounded stdout JSON. The independent has its different ten-string control list, tighter leaf radii, source/receipt pins, 16 coefficients and coverage counts; no fictitious independent completion stdout is required. Structural validation does not repeat or prove the numerical arithmetic. That remains the purpose of executing the frozen producer and independent checker.

Run publishes only S_PROVISIONAL and R_PROVISIONAL. Common:411 requires a separately produced host record after actual R exit, exact authorized host-source reference, host review/contract references, original and postexit R identities, exact R/S/W commands, W/S lifetime observations, and raw job accounting. It links the S seal to R, the actual worker manifest to S and its attempt marker, and verifies sealed log/metadata hashes. Candidate and seals must occupy the exact owned paths. Pending files and failure records prohibit final acceptance. An independent phase explicitly requires a producer predecessor; an independent predecessor is not accepted as a producer.

This is a validation contract for evidence produced by trusted, reviewed execution. A hand-written JSON with matching fields is not proof that Windows calls occurred. In particular, this review does not approve the not-yet-reviewed H implementation merely because these fields are specified. The host must actually retain R's original handle, enforce its deadline and cleanup, reserve/write its complete final record and reject any late failure. The current S/R set alone cannot close the case where R is killed before cleaning up a newly created child.

The fixed V5 benign packet is now accepted with independent result review 1CEC5660F630F4AE7AAC3B105B683E3705EC89C838416954E7A8032914FB61FE. It is not evidence for the new H containment layer. Common:404 and authorization validation explicitly require a separate evidence/review pair with H/R/S/W topology and active limits `[3,2,1]`. That evidence is absent. Its eventual source/runtime compatibility and actual observations must be independently reviewed; status strings alone cannot supply them. Thus the numerical launch gate remains closed.

## Independent static receipt

`review_rational_j7_supervision_static_20261111.py` reads source bytes, parses and compiles ASTs without executing the code objects, records declaration lines/hashes, and compares the two native source segments. SHA256: 2C577F08F0A26D5D56B23C815985D195653BC81FC9DD738705E844D768DC0116.

Its receipt `review_rational_j7_supervision_static_20261111.json`, SHA256 CC7145903D3476E481D29BD41AD5111DE3480A2D13EDB13326BB3553443D8C75, matches every source/preparation pin above and reports four syntax passes and both native-copy equalities. Only this independent text parser was run. No inspected module was imported, no native API or process probe was called, and no numerical or behavioral rejection test was executed.

No further correction is required in this frozen S/R scope. The next gates are the actual H source review, separately reviewed added-containment capability evidence, genuine runtime authorization, and then actual producer/checker execution and full external acceptance. None follows from this static PASS.
