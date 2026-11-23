# Corrected integer source producer accepted

Sourceint01 rebuilt SourceArithmetic after the initializer representation correction. The only source changes are the explicit (int # int) option return type and integer first-coordinate cast in source_initial_def. All other definitions and the original three theorem statements are unchanged. INTEGER_INITIALIZER_CORRECTION.md explains the diagnosed rational-coordinate mismatch and preserves the previous version under history/before_integer_initializer.

The new reload audit checks seven exact executable types, including integer-pair initializers and recurrence interfaces. It checks the exact corrected initializer definition plus the three original generic theorem roots, empty hypotheses, permitted DISK_THM imports, empty axiom tags and ancestry restricted to the four standard HOL axioms. All seven type records, four roots and the completion marker are present.

Five expected-source pins, six run-source pins, forty-five dependency/tool pins and three output pins were rehashed and matched. All phase and container exits are zero. Successful phase CPU is 14.27 seconds; container wall time is 77.0678805 seconds. This is a recorded-result and reload review, not an independent whole-kernel replay or source-throughput benchmark.

The corrected initializer now has the integer representation required by source_state. Its analytic accuracy still belongs to the pending SourceInitial module. Existing SourceStateError, SourceInverseRoot and SourceStateBounds consumers must be rebuilt and audited against this dependency before integration. The campaign forecast and full goal remain unchanged.

## Accepted bindings

- `SourceArithmeticScript.sml`: `50b56639ce7ce5abd385d7b0b286dfa6ca3c269a7ba87e3ace7af7d61dba9058`
- `source_audit.sml`: `cc260bbfacb24a30c77e49d1d11f558e300cbbe5442bd2dbf35ab9316ab0fa55`
- `source_expected.sha256`: `ffae5ae04ae108b9d52fcd4f01127afb29e5d9a1f1fb40b4cc1849849426e8ab`
- `.hol/objs/SourceArithmeticTheory.uo`: `fe8c7fcb43880621c0c4b44fc4b53445d549295b12efbd8d099bbe43ae6aa471`
- `.hol/objs/SourceArithmeticTheory.dat`: `6cfb5b38c7e86885e265809a0054849a28f648bed926da712c449a0e959be3a6`
- `sourceint01_audit.log`: `211dbab23096f78dbbcd2435460b942f94c68d5c37b8fb7c148c312de67dd185`
