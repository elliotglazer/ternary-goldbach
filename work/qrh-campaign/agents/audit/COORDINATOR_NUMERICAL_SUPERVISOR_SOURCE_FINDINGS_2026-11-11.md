# Coordinator findings on the numerical supervisor source

Status: interim source review, not final acceptance or execution authorization. This note records the coordinator's read of the complete current common, managed and run modules and preparation note. The native module had been read previously. No module was imported or executed for this review.

The source snapshot has these SHA256 values:

| Module in `../integration/` | SHA256 |
|---|---|
| `rational_j7_supervision_20261111_common.py` | `FA073C190EEEDCF03288A926F8AA6139C76D72C87379DF35AE533429A9A722CC` |
| `rational_j7_supervision_20261111_managed.py` | `0025419CCC8C899870BED4EFB5A038C6E286F4383D8E4376019915868EE75880` |
| `rational_j7_supervision_20261111_native.py` | `CFC956B179C45AFAEAB5EA1DB42B05C06C643D0A10EC1682CBE0433248248E13` |
| `rational_j7_supervision_20261111_run.py` | `125CCDED23216FD0967402E5F2AC031EC57551613697315229AFD3BA35064C70` |

These are draft snapshots. Subsequent repairs require fresh hashes and final independent review. They are not frozen providers or Lean declarations.

## Confirmed source behavior

The source now distinguishes producer control dictionaries from the independent worker's string controls, and projects the old analytical budget to the two fields actually emitted by the producer. It checks a real host source reference against the authorized host digest. The independent phase requires its predecessor to be a producer phase. Failed assignment after process creation triggers termination through the retained original process handle as well as the job.

The managed source checks deadlines after signaled waits and queries memory through the original handle after exit. Worker serialization therefore lies inside the supervised interval. S and R publish provisional records only. The pure host-chain validator cannot itself establish that a host observed R's exit; the actual reviewed host implementation and its execution remain necessary.

## Findings requiring disposition

1. In `run.main`, `observed_self_peak_bytes` is saved before inventory hashing, publication, cleanup and later guards. Its `through_final_check_not_postexit` label overstates the scope of that saved observation. Later guards still enforce the cap. The source should distinguish the saved pre-seal observation from later, unsaved enforcement rather than claim that the stored value is the last query. The independent lifecycle reviewer agreed with this finding.

2. The managed job snapshot and pure validator decode complete raw PID arrays but do not require positive, unique entries, or bind the assigned-before-resume singleton to the original created PID. Add those consistency checks at the unambiguous suspended checkpoint. Do not infer that every post-exit PID list must be empty: retained references affect that observation. The independent lifecycle reviewer agreed that these checks are appropriate.

3. The external H implementation, final host schema and its independent review are still pending. Any additional H containment job changes the tested nesting arrangement. V5 is evidence for its fixed benign arrangement only. Before a numerical attempt, specify and verify the new containment arrangement, including R termination between S creation and S job assignment. Do not weaken existing total-process predicates or add a helper exemption.

## Remaining acceptance boundary

Final source review must cover the repaired four modules and actual H implementation together, including noncircular authorization construction, complete output accounting and final host bytes. The accepted V5 test does not authorize a numerical run. No runtime manifest was created here, and neither rational evaluator nor Lean/Lake was run.

The Goldbach checkout still reports only the existing untracked `Explicit/QrhMellin.lean` and `Explicit/QrhNumeric.lean` files. This review does not change them, the selected mathematical strategy, or any theorem's proof status. PlattGRH remains present.

```text
DRAFT_ANCHORS: 0 created
UNREGISTERED_SORRIES: 0 introduced
DRAFT_IMPORT_VIOLATIONS: 0 introduced
SEALED_THIS_TURN: 0
```
