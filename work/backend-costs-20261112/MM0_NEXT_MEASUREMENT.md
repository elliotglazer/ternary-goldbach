# Next ordinary-PA measurement: bypass textual proof elaboration

Prepared 2026-11-12. Source inspection and experiment design only. No proof, table, arithmetic value, benchmark, build or forecast was generated. The existing estimates and artifacts are unchanged.

The strongest supported next experiment is a direct MMB producer for the existing four-bit arithmetic proof, with the same actual signed operand pairs and an explicit signed result wrapper in both arms. This tests the dominant observed construction cost without changing radix, multiplication algorithm, arithmetic axioms or checker rules. It is not yet evidence that the construction cost can be removed.

## What the current evidence establishes

`mm0-pa/REPORT.md:13–41,60–91` records ordinary PA proofs for 64 **nonnegative magnitudes** from `P343N64.json`, namely the absolute values of `input[2]` and `input[4]` in each original row. It does not already prove the signed product or a rounded dependent network. The final conjunction certificate costs 79.08 CPU seconds of frontend compilation plus 6.86 CPU seconds of conjunction assembly. Python textual generation adds about 0.85 elapsed seconds. Independent checking takes 0.220877 CPU seconds median, and the certificate is 52,088,360 bytes. The measured compiler peak for the 64-product stage is 6,374,992 KiB. Checker samples use warm tmpfs input; their internal timer excludes initial mapping and process launch.

This phase separation matters. The current full-model PA sensitivity in `forecast-audit-20261113/end_to_end_model.py:148–173` uses `(79.08+6.86+.85)/64` for generation, `.220877/64` for checking, and `52088360/64` for bytes, followed by unmeasured width, signed-composition and retry factors. The Python elapsed observation is treated there as busy CPU. The huge forecast is therefore principally a forecast of this frontend-based producer, not a measured lower bound for PA checking. Even perfect removal of frontend overhead would leave arithmetic proof generation, independent checking, proof traffic and all unmeasured completion work.

There is one demonstrated arithmetic improvement already: proved four-bit addition rules reduced the 32-product checker time by 2.29 times, frontend time by 2.89 times and bytes by 2.83 times. Repeating that comparison would not answer the remaining frontend question. The re-exported 64-product conjunction already changes encoding slightly, so its 52.09 MB size must not be conflated with the separate 54.31 MB product-file size.

The earlier `estimates-20261111/MM0_CALIBRATION_AUDIT.md` measured fast native emission of schematic selected-mask proofs. Its numeric table and finish facts were axioms and the target was `ok`. Those rates do not establish an ordinary-PA arithmetic producer. The later real PA pilot supersedes that evidence for these scalar products.

Other previous work is relevant but does not yet supply a measured replacement:

- `GENERAL_RADIX_PA_COST_FRONTIER_2026-11-11.md` generalizes cell/row schedules and prices larger proved tables. Its complete-table format and cache limits are conditional layout constraints, not evidence that larger radix wins on these values.
- `PADDED_NAMED_DIGIT_SOURCE_BINDING_2026-11-11.md` gives conservative definitions and explicit source bridges. Its zero/one exceptions, exact term matching, local resets and table proofs remain costs. There is no compiled matched wide-table implementation to substitute here.
- The product-cell, row/base, signed-dyadic and streaming papers establish proposed interfaces. They do not turn a byte event into one verifier command or supply a measured complete signed network. The present experiment deliberately retains the already implemented binary multiplication with four-bit addition.

## One exact matched experiment

Use the same pinned 64 original rows, in the same order. Do not choose favorable values or strip their signs. Let x_i and y_i be the original signed `input[2]` and `input[4]`, and let z_i be the proposed signed product. Represent each integer by its canonical natural pair `(x_i+,x_i-)`, with at most one nonzero component. For zero both components are literally zero. Prove, for every row, the two ordinary natural equalities

```
x_i+ * y_i+ + x_i- * y_i- = z_i+
x_i+ * y_i- + x_i- * y_i+ = z_i-
```

For canonical inputs these are the exact multiplication rule for the signed value represented by the difference of the components. The final public theorem is the same ordered balanced conjunction of these 128 equalities in both arms. All six component literals per row are fixed in one common textual specification and independently decoded against the original signed JSON fields and proposed result. An equality of hashes alone is insufficient. This is an explicit PA natural-pair signed-product interface; it does not claim an imported Lean/HOL integer type, rounded product, FFT or analytic denotation theorem.

The existing magnitude proof `abs(x_i)*abs(y_i)=abs(z_i)` supplies the nonzero product in each case. Four generic sign-case wrappers, proved once using `mul0`, `mul01`, `add0`, `add01`, equality congruence/transitivity and `iani`, supply the two displayed equalities. The actual zero cases use the same literal zero convention. The source contains these PA ingredients in `examples/peano.mm1:496,2057–2059,2105–2107`; the existing `arithmetic.mm1` already proves all computational lifting rules. These wrappers are proposed proof obligations, not new axioms. They must be compiled and checked before any timing is accepted.

Arm A uses the current recursive proof construction and the mm0-rs textual frontend. Arm B emits ordinary MMB proof commands directly from the same deterministic arithmetic derivation and the same sign wrappers. Both produce the conjunction in the initial file, avoiding a separate importer pass in **both** arms. This is a matched change to the old measurement, so the old 79.08+6.86 seconds is context, not the new Arm A denominator. Retain a magnitude-only compatibility result against the old 64 equalities as a correctness gate, not an extra timed workload secretly charged to only one arm.

Freeze the common library, specification and arithmetic derivation before timing. Keep the same per-product theorem boundaries, public definitions and final conjunction in both arms. Do not add larger digit rules, Karatsuba, named-digit substitution, new chunk boundaries or proof-byte compression to Arm B. Such changes would prevent isolation of the frontend effect.

## Implementable direct construction

`mm0-pa/generate_arithmetic.py:17–57` already computes the successor, addition and multiplication proof tree from exact integers. `generate_fourbit.py:9–44` supplies the proved four-bit rules and their recurrence. Replace the nested textual proof strings with a typed internal record for each theorem application containing its theorem ID, explicit natural argument terms, premise proofs and exact conclusion. The untrusted producer can calculate those records from the same recurrences. It must not ask the checker to trust the calculation.

The pinned `mm0-rs/src/mmb/export.rs:400–457` gives the concrete lowering order. A theorem application emits premise proofs, argument expressions, the conclusion expression, and then `ProofCmd::Thm`. Terms use `Term` and retained objects use `Ref`; explicit definition conversions use `Conv` and the corresponding conversion proof. The exact command definitions are in `components/mm0b_parser/src/lib.rs:315–451`. The public `Exporter` consumes a `FrozenEnv`, so calling it after the existing elaborator is **not** evidence of bypassing elaboration. The direct arm needs either an explicit-record adapter before elaboration or a standalone encoder following these same command and layout rules. The latter is the proposed arm.

Import the fixed proved library as data for the encoder, preserving or correctly relocating every actual term/theorem ID, signature, definition body and proof. The complete output must contain its proofs and be accepted by the ordinary checker from the ordinary textual specification. A library hash or already accepted result in another process is not an admissible proof import. The direct writer must construct declaration tables, signature offsets, statement lengths and final source bindings as specified by `export.rs:510–680`; it cannot simply append bytes to a complete MMB file and ignore relocation. This is a bounded encoder implementation, not a new arithmetic method.

Use deterministic structural term interning within each theorem and explicit saved proof references. Record its construction and lookup costs. The current exporter already shares `Ref` nodes, so merely adding a hash table does not establish a new sharing benefit. Local references must be rebuilt after reset. `mm0-c/verifier.c:179,383–396,482–506,731–790` checks references and theorem applications and resets the local state at declaration boundaries. Any larger sharing difference must be reported in command counts and memory, rather than credited as a pure frontend saving.

Start with the same enlarged-capacity, unchanged-rule C checker used for the real pilot. State those capacities explicitly. If the new stream also fits unchanged stock limits, a separate stock run can establish that later; the design does not assume it. Reject `Sorry`, reject every additional axiom and retain parser-enabled public statement checking. Native integer multiplication is permitted only to propose literals and proofs. No native arithmetic result is accepted without the ordinary proof.

## Required measurements and rejection gates

Measure one library-only control and the full signed 64-row case in each arm. Both full cases include their own library import/emission and final conjunction. Report gross first production plus one independent acceptance, alongside a clearly labeled library-subtracted diagnostic. A later warm same-process producer run may be reported separately; it cannot replace the cold total.

Record separately:

1. Original JSON parsing, signed canonicalization and proposed magnitude/result generation.
2. Common PA/four-bit/sign-library proof construction and compilation, plus encoder build/setup. Existing cached library emission/import is still timed per output.
3. Arithmetic proof construction, term interning, explicit bindings, declaration/layout construction, serialization and final conjunction. Arm A records parsing/elaboration/export separately if instrumented. Otherwise retain their combined measured cost.
4. Independent checker CPU, whole-process CPU/elapsed, mapping/setup, peak heap/store/RSS, proof and unifier commands, and all actual file sizes. Keep compilation, checking and copying distinct. Report warm tmpfs and disk-transfer costs separately.
5. Signed wrapper and final public binding counts. They are measured additions to the old magnitude-only experiment, not covered by an arbitrary multiplier.

Before publishing timing, independently check the unchanged axiom inventory, absence of `Sorry`, exact source literals, 64 ordered signed leaves and complete conjunction. Require actual checker rejection after corrupting a nonzero input sign, an input magnitude bit, an output component, a theorem reference and one purported sign-case conversion. Use a nonzero case for the sign control. Test zero and each sign-case helper as ordinary generic proofs even if a particular branch is absent from the fixture; do not invent extra timed fixture rows to improve the average.

Pin source and generated artifacts before execution, preserve all failures, and bind the executable/compiler/checker versions and memory limits. One failed encoder or dependency import is a failed experiment, not a zero-time data point. Independent output checking must not import or trust the producer's proof-construction implementation.

## How to use the result

Success could replace the current producer timing **for this signed scalar construction at these exact values and widths**. Similar checker commands/bytes with much faster production would identify removable frontend work. Reduced commands/bytes would additionally identify an encoding/sharing difference that must be itemized. Similar construction time would refute the expectation that textual elaboration alone explains the cost. Failure to produce a complete accepted stream leaves the current evidence unchanged.

The experiment cannot replace the model's width factors, general signed rounding/dependent-network multiplier, source producers, analytic translation, principal/nonprincipal closure, finite coverage, actual useful cache lifetimes or success/fallback assumptions. No whole-goal forecast, optimality claim or numerical saving is made here. This is the next measurement because the measured phase imbalance supports it, not because direct emission is already known to be fast.

## Requested numerical sensitivity, not a predicted speed

Root subsequently requested numerical Fermi sensitivities. Using its rounded central model decomposition, retain 4.757e12 core-hours of current generation and 1.065e10 core-hours of current first checking. Let R denote every unchanged reserve and other row. A hypothetical generation improvement factor g, with unchanged checker work, gives

```
T_direct(g) = 4.757e12/g + 1.065e10 + R core-hours.
```

For g=10 and g=100 the subtotal before R is about 4.864e11 and 5.822e10 core-hours. These are arithmetic sensitivities to assumed improvements, not low/central/high estimates of what a direct emitter will achieve. Even zero generation would leave the existing checker row of about 1.065e10 hours plus R. The underlying workload/width/completion assumptions remain those of the unoptimized model.

If a different ordinary-PA arithmetic proof reduces independent checking by a further factor c, the corresponding sensitivity is `4.757e12/g + 1.065e10/c + R`. Proof-byte traffic needs its own measured replacement. No available matched signed experiment determines g or c for a wide-table or faster-multiplication implementation.

A native evaluator with a proved soundness bridge is a distinct implementation and acceptance design. If it still emits ordinary MM0 commands, its proof construction and checker work must be measured. If it adds a native arithmetic acceptance mechanism, the existing stock checker timings no longer price that mechanism, even if its soundness is established separately. The present evidence supports no numeric MM0 estimate for that route. A HOL/Candle total could only be displayed as an explicitly borrowed architectural target, with the new soundness and analytic-port obligations identified and unpriced. It is not an optimized-MM0 result or a universal language ratio.

## Evidence pins

Paths are relative to the repository root. Source inspection used MM0 commit `0d414c0bfdaaeb7fea571895127abc1fa5a3d956`.

| Artifact | SHA256 |
|---|---|
| `work/backend-costs-20261112/mm0-pa/REPORT.md` | `C2846C9815FDDC43EC04DECCDF44AC041BE1246430C6E10F888930B14F817331` |
| `work/backend-costs-20261112/mm0-pa/RESULTS.json` | `C61CEC5C19E489CB88B367E060E822ED163599EC30A2C87970296D87B93FB580` |
| `work/backend-costs-20261112/mm0-pa/generate_arithmetic.py` | `408D3937050403F46604DD7B22034E0DDB19095A4E56CAF7467C38D5612D8B0A` |
| `work/backend-costs-20261112/mm0-pa/generate_fourbit.py` | `64B58A78D0EB206F1013FD6926E6CBDB51CD513F0B3B85AA32D588C94D6D5312` |
| `work/backend-costs-20261112/mm0-pa/generate_aggregate.py` | `82A3324C9F7FB98DF09C79EC7B5511E34FB39D684526CB44ADBBFF306FFCFC30` |
| `work/lean-pilots/batched-transform/P343N64.json` | `F024EAF87BD02898530A72CAB2C567B00C98BCC83DF48E0BE4E8D9CFCA6D00AE` |
| `work/backend-costs-20261112/forecast-audit-20261113/end_to_end_model.py` | `4E35DBD5C8162B1989F54610431B5311AB9CF5AA403CEAF42E9F7C7A77E2D028` |
| `work/qrh-campaign/agents/prime-estimates/GENERAL_RADIX_PA_COST_FRONTIER_2026-11-11.md` | `0C69D1774C2D0AE2A2A0DA849F30962D66304A13C07C66AEA50BA942E2BB5827` |
| `work/qrh-campaign/agents/moebius/PADDED_NAMED_DIGIT_SOURCE_BINDING_2026-11-11.md` | `5A42958919FC13814BBC07F1517E410E5A8BBA2F851888988D4B302A9433B3F7` |
