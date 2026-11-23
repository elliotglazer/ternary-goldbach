# Combined precision first-run stop

2026-11-11. The first authorized execution of `combined_conductor_precision_assignment_20261111.py`, SHA256 `D0764C6DFEB13453D4F47356EAC62A7138CEBF8F9963B6F2AC1E30C3F1D1F785`, stopped at its encoded artifact-size check. This is a failed run, not a published assignment result.

The frozen preflight is `B563B8CC28DC1F2BCF08390BCF9385AD504432940A0C22D263BC9002037158B2`; independent preflight review is `E1DA5A7A4101326B2419EB9367D842405AB9965DC44B8807B33CE8F345C9B2B8`. Integration cleared the exact revised writer before execution. The earlier unexecuted version, SHA256 `48886836AC2B6B28EE10F879C7627F6673F7BD99640858D780B249317669ECDE`, remains preserved as `combined_conductor_precision_assignment_20261111_v1_unexecuted.py`.

The program reported these completed phase transitions:

1. Source and destination gate.
2. Saved manifest and coefficients.
3. Exact legacy rows and complete cache gate.
4. Exact sharp rows and complete cache gate.
5. Combined selector after both exact predecessor gates.
6. New representation contracts and bounded serialization.

It then reported:

```text
status: FAIL_STOP
phase: new representation contracts and bounded serialization
error: AssertionError(('new representation contracts and bounded serialization', 'encoded artifact cap', 30371291))
checks: 30371291
partial_artifacts: []
```

The failing source line is423, the check `len(raw)<=cap*MIB` before publication. The generic diagnostic did not print the current filename or encoded byte count. Neither is claimed here. The program reached this phase only after its exact predecessor gates and combined selector, but their in-memory results are not a frozen, independently reviewed assignment artifact.

All four intended output paths were independently checked after the stop and are absent:

- `combined_conductor_precision_rows_20261111.json`
- `combined_conductor_precision_nodes_20261111.json`
- `combined_conductor_precision_caches_20261111.json`
- `combined_conductor_precision_summary_20261111.json`

No output file was opened. No cap was increased, no schema changed and no rerun attempted before this failure report. The frozen writer and preflight remain unchanged. The coordinator and independent reviewer received the failure immediately. Any diagnostic rerun or revised serialization requires explicit scoped authorization and new source clearance. No distribution, cache total, price or runtime conclusion is published from this stopped run.
