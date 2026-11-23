# Complete binary pilot accepted

2026-11-11. Recommendation (4)'s finite binary certificate is complete at the representative internal-pilot scope. The positive-height spectral certificate remains incomplete, so recommendation (4) and the active goal remain open.

`BinaryPilot.binary_interval` proves every even natural number in the inclusive interval [3999999997356523524, 3999999997356523650] is the sum of two natural-number primes. The 64 targets span two contiguous 32-target tiles. All 12 anchor primes, 152 distinct positive-bit source primes, exact source shifts, coverage equalities and interval assembly are proved. The 644-node Lucas/Pratt dependency closure is included in the standalone source.

The coordinator inspected the generic support, concrete source/coverage assembly, independent semantic review, and full-build, axiom and malformed-mask logs. Fourteen artifact hashes and all nine run receipts were reconciled against the author's results. The exact-type and transitive-axiom probe independently passed with only `propext`, `Classical.choice` and `Quot.sound`. A deliberately false full-mask equality was rejected. The owned proof sources contain no `sorry`, `admit`, custom `axiom`, `native_decide` or setting override. This is internal pilot acceptance, not approval of a public frozen declaration.

The full standalone build took 87.796652 seconds wall and 126.031250 process CPU seconds, including strict trust-level-zero imports, elaboration, checking and object output. The separate import-only run took 12.872155 wall and 12.718750 CPU seconds. These are individual observations with concurrent campaign activity; their difference is not a measured kernel-only time. The standalone source is 322829 bytes and its object 8214968 bytes. No peak-memory measurement was collected.

This complete certificate replaces the earlier semantic gap in a raw arithmetic-only benchmark. Its per-target cost must not be extrapolated directly to the full range: it constructs a cold source-prime proof closure for one small interval, while the proposed production design amortizes shared source and anchor proofs across many targets. Conversely, the older warm bitwise-equality timing still does not price the full semantic proof. Both measurements must remain separate in the provisional estimates.

Evidence:

- `work/lean-pilots/binary/REPORT.md`, SHA256 20FBB99BECB49FF16E19ABE17EE7CE91542B53D8D0F92929A61B3979FFA6946D.
- `work/lean-pilots/binary/results.json`, SHA256 C0C0B289849E2FDC7CAB8BBD5859A40A4FAEC2FB7EC263FD44F062A32C2EF0AA.
- `work/qrh-campaign/agents/audit/REVIEW_BINARY_LEAN_PILOT_SEMANTICS_2026-11-11.md`, SHA256 189FCB113A859B16919E6BF3E1AA394B890649833E6F9B619475021C437E3162.
- `work/lean-pilots/audit/root_binary_acceptance.json`, coordinator's reconciliation receipt.

DRAFT_ANCHORS: none created; repository-wide state not audited.
UNREGISTERED_SORRIES: none in the accepted pilot closure; repository-wide state not audited.
DRAFT_IMPORT_VIOLATIONS: none in the accepted pilot closure; repository-wide state not audited.
SEALED_THIS_TURN: 0; no public frozen anchor was adopted or sealed.
