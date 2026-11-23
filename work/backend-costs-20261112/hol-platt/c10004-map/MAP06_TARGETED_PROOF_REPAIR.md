# Targeted sort proof repair

Map05 failed in the generic quicksort equivalence proof before numerical map checking. Its source, logs and saved heap are preserved in history/map05_targeted_diagnostic. Five bounded saved-state diagnostics then located failed Q.SPECL/Q.SPEC applications inside the proof callbacks and a remaining pair-let reduction.

The successor uses direct MATCH_MP for the partition theorem, two context-aware match_mp_tac induction applications, and explicit pair-let simplification. The sorting algorithm, generic theorem statement, finite predicates and final map claims are unchanged.

Diagnostic03 exited0 but left goals open; it is not a proof-success receipt. Diagnostic04 introduced an exact top_thm/hypothesis/conclusion gate and correctly exited1 with the remaining let goal. Diagnostic05 reached that exact closed-theorem gate and printed the full original theorem with no hypotheses. Its display helper also reported a spurious failure when top_goals was called after the final goal closed. That display exception did not establish completion; the separate exact top_thm gate did. No diagnostic exported a theory, and the complete successor build is still required.

The main source uses the proof steps checked in diagnostic05. This is evidence for the generic helper only, not for finite map evaluation, character semantics or the analytic computation.

Successor source SHA256: `7C00870E4BE8D8E565B1A1FBC5FAE48FD0805C99A2BAE691CD33C0D08F5194A1`
