# Coordinator source review before execution decisions

2026-11-11. Source review only. No execution decision or runtime manifest is supplied by this note.

## V4 diagnostic

The coordinator read the complete V4 outer runner and child, the inner lifecycle and guards, all inner/outer changes from V3, and the complete specification. The previous V3 baseline source review remains applicable to unchanged code. The two final specification corrections distinguish V2's missing counters from V3's retained observations and distinguish original-handle memory/termination evidence from later PID-candidate observation.

| File under this directory | SHA256 |
| --- | --- |
| `c8_supervisor_capability_preflight_20261111_v4.py` | `08A6AB509952DC830002433B53892ED1E4B717B139611C45E5BF16E6FF6777AB` |
| `coordinator_c8_capability_run_20261111_v4.py` | `07426FC9A9D1A0E51A2E4BD69930027FCCC8C7DE6F0047739273BBD9A32A68E1` |
| `c8_supervisor_benign_child_20261111_v4.py` | `B0E008A7344824D1651D5F86B8232171508CCCF6016CB4A74DEB32F4F97A455D` |
| `C8_SUPERVISOR_CAPABILITY_PREFLIGHT_V4_2026-11-11.md` | `0EAFC886790B7AF8B6C7DB0C7098343269EC5B4979AE07C92644494553446209` |
| `c8_supervisor_capability_preparation_20261111_v4.json` | `5B5CA7666FF24F9736332CAACB9F703703573BBB9C50A6DC4FE897208FB3AEBD` |

The new observations compare child/supervisor self-identities with the identities captured through original creation handles. Raw PID-list evidence is persisted before per-entry inspection, and the baseline self-comparison is recorded before rejecting the list predicate. Reopened unknown PIDs remain later candidates, not retrospectively identified snapshot instances. Two valid snapshots cannot establish a complete lifetime inventory. Existing count, deadline, output and memory predicates remain mandatory.

The coordinator found no additional source issue requiring a code change. Independent review was still pending when this note was written. Any later single-attempt decision must bind its completed review and these exact source/specification bytes. Earlier attempts remain failed; no count reinterpretation or numerical follow-on is authorized here.

## Rational j7 programs

The coordinator also read both complete source files, without importing or executing them:

| File relative to the agents directory | SHA256 |
| --- | --- |
| `integration/rational_direct_g_j7_producer_20261111.py` | `B633D322F0B696CDF59FEDB668CE62F4EE13E5BFAC28BC0959E9AF13E37315D7` |
| `moebius/rational_direct_g_j7_independent_20261111.py` | `4762265952B7DD4E5382BC0426205A84BB766EFA43A872DDD6E148EF15674FDC` |

The reads covered exact rational helpers and guards, signed rounding and normalization, the producer Horner and independent forward schedules, all finite-g correction terms, old-square/image reconstruction, fixed negative controls, manifest parsing, publication and failure paths. No additional mathematical source issue was identified beyond the scope already covered by the accepted arithmetic, structural and operand-bound reviews. This is not an executed acceptance result or a Lean proof.

The concrete numerical-supervisor design must account for the producer's five-file output family and deletion of its own incomplete outputs on caught failure. It must also cover the independent checker's final serialization and write after its last internal telemetry observation. Worker assertions of membership in some job and a positive `supervisor_pid` field do not establish membership in the intended job or the actual creation relationship. External original-handle evidence must supply that binding. Both inputs and output paths must be bound independently by the supervisor, and candidate status must remain distinct from externally accepted completion.

No rational runtime manifest exists as a result of this review. The 600/900-second, 512 MiB and 16 MiB constraints are unchanged; successful containment, completion, numerical comparisons and post-exit evidence remain outstanding. The target repository still has only its two previously recorded untracked QrhMellin/QrhNumeric files and no new Lean changes from this work.
