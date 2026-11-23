# Independent saved-data controls for the high slab

2026-11-11. **PASS for exact finite consistency and 13 targeted rejection controls.** No analytic model was evaluated or recomputed. These checks supplement, and do not replace, the separate independent 13-model numerical review or the source-adapter proof.

The immutable author receipt is `zero-sum/high_slab_em_candidate_20261111_01.json`, SHA256 `CF90E96C7531F57E455ABCE70D8D71FB06596E9E1490FADDBAFA6DE64FCB0B09`. Its producer is `AA4496B7EE84D4BCA497B5BDFFC237A6DC0949F45C5F9E134B29498C5B58D084`, reviewed in `REVIEW_HIGH_PRINCIPAL_SLAB_PREFLIGHT_2026-11-11.md`, SHA `1111EF1A55452E17059F51B662EA72B48A40354A3F7F59E2A1AC6A49AB2F1BD8`.

The independent standard-library checker is [check_high_slab_saved_controls_20261111.py](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/check_high_slab_saved_controls_20261111.py), SHA `59C6120523CC7F33150B76F214A3CB55F3C121C8D76657245171026319AE2920`. Its same-basename JSON records the successful run and each rejected mutation. The checker imports no author code or numerical library. It reads the author's literal pin table using AST parsing, verifies those files, and independently reconstructs the target, model manifest, panel geometry and exact crossing calculation with rational arithmetic.

The controls JSON SHA256 is `C8B97CE7F8521BC3BB98E6EAD0C2E338A362B98CFDA03B4C8D3141F763B8289D`.

The baseline passes the following checks:

- The entire target dictionary is fixed, including rectangle `[629/1250,2]+i[7999999/8,1000000]`, seven new/six old models, degree23, all allowances and operational caps.
- All 13 model centers and radii match their exact roles. All 312 complex coefficient boxes are ordered. Each of the 144 imported top coefficient boxes encloses its original full rational box; the replacement allowances dominate the original error upper bounds. New coefficient true-value containment is not established by these shape checks.
- The 14 accepted panels equal the 14 initial attempts, with no pending panels, failures or refinements. Exact model assignments, endpoint disk membership, closed adjacency and side orientations match the intended traversal. Horizontal side lengths are 1871/1250, vertical side lengths 1/8, and the positive shoelace twice-area is 1871/5000.
- Every recorded numerical image box is ordered and its selected signed coordinate has the stated strictly positive lower bound. The right edge is explicitly the separate analytic Re(zeta)>1/4 leaf, not fabricated numerical data. These are bounds on the saved boxes; proving the boxes contain the true whole images remains the analytic/numerical verification task.
- All shared surrogate vertices satisfy both incident half-plane requirements. Exact ray intersections give crossing list `[0,-1,0,0,0,0,0,0,0,0,0,1,0,0]` and sum zero. Constant image edges and ray vertices are included; the vertices are not incorrectly treated as actual endpoint values.

All 13 corruptions were rejected through the finite validation logic: changed target, geometric gap, reversed/inconsistent orientation, wrong model assignment, changed model center, changed model radius, loss of positive image bound, false margin, wrong rotation, zero shared vertex, changed crossing, changed winding, and narrowing an old coefficient box. Mutations to panel fields were made in both the accepted and attempt lists, so rejection was not merely a duplicate-list mismatch. The mutated copies were not rejected by a whole-receipt hash check; the baseline hash was checked separately before these semantic tests.

This checker is deliberately scoped to this receipt's 14 unrefined panels. It is not a general acceptance theorem for arbitrary refined receipts. Nor does it reject every possible scientifically false box: replacing a newly computed coefficient or image with a different plausible interval can require analytic recomputation to detect. The selected controls establish the stated consistency checks only.

The physical author file is 204498 bytes. Its saved output_bytes is 200234, confirming the preflight distinction between LF-serialized payload size and Windows on-disk size. Scientific replay does not consume this telemetry field.

The original receipt remains unchanged. No additional spectral region, full principal strip, family certificate, Lean result or axiom closure follows from this saved-data audit alone.
