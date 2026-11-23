# What Lean must accept after the rational panel

2026-11-11. Research-only handoff. No evaluator, benchmark, Lean build, or new declaration anchor was run or generated. This note refines the next acceptance milestone; it does not predict its speed.

## Evidence and present boundary

The frozen integration candidate `rational_xi_panel_candidate_20261111_01.json` has 77,741,605 bytes and SHA256 `1B55E8A2665EF872056DE9747670E6F47017863A49D9E2C9A2D6604B6F74D09F`. Its producer `rational_xi_panel_backend_20261111.py` has SHA256 `DEE8AC9AA39F25023C77003BC2AAA5970388A016207AD5A8EE0DF8F6D912F84A`. I read the packet header, producer routines, saved-data inspection, and completed independent review; I did not reevaluate the packet.

The completed independent review is `independent-feasibility/REVIEW_SMALL_RATIONAL_XI_PANEL_2026-11-11.md`, SHA256 `11504C44549147C179EBB816E8EBED1F7FC44FA35B77F86C9BED51A5F0F4138C`. It accepts the 929 node balls, 12,999 weight balls, seven sums, and whole-disk comparison at paper-analysis plus external exact-arithmetic scope. The older producer result note correctly retains its historical pending-review status.

The packet exercises terminal theta2/4/3 at 120/387/422 nodes and zero/one/two S steps at 687/236/6 nodes. These are workload descriptors, not kernel-operation counts. In particular, 929 nodes, 12,999 weights, 77 MB of JSON, and recorded rounding counts are different quantities and cannot supply a shared seconds-per-operation estimate.

The packet is not a complete operation-proof trace. `Backend.__init__` computes pi, then `node` clears the elementary-event list; the initial Machin proof event is therefore absent from each node record. `weights` retains only centers and radii, not its elementary events or original boxes. Ordinary arithmetic edges, terminal mode contributions, and reverse-transport intermediates are also not all retained. Exact source-pinned recomputation supplies them externally. Hashes establish provenance, not containment or equivalence between a future Lean implementation and Python.

## The acceptance contract

Lean need not import JSON or check Python. It needs a closed typed data value, a proved checker soundness theorem, and a kernel-checked proof that the concrete data passes. An untrusted exporter may produce that data. The resulting theorem must expose the exact target and bounds so a faulty exporter cannot silently change the task. File hashes remain an audit aid unless a separate byte-binding requirement is deliberately formalized.

The mathematical inputs are fixed, including `T_input=32`, `T_work=14`, `b=pi/4-1/33`, center `3/5+14i`, radius `1/64`, grid `k/256`, `K=928`, and degree six. A string naming a function or an arbitrary expression graph is insufficient. A proved recipe must connect each accepted arithmetic expression to the intended seed, modular jet, P expression, or signed weight.

For a complete panel the consumed data and obligations are:

1. **Node certificates.** For each unique index 0 through 928, a typed expression recipe, admissible T/S choices and guards, elementary-function certificates, terminal type and 16-mode sum, tail padding, reverse jet transport, final P box, and its center/radius bound. The checker must connect every input reference, enforce the initial theta3 type, subtract T's integer, retain its phase, select the positive-real square-root branch, reject origin-containing reciprocals, and verify the terminal-height guard. A root identity without its branch test is insufficient.
2. **Weight certificates.** For each signed index and order, establish the actual weight `h*v^j/j!*exp((1/10+14i)*v)` within the proposed ball. Existing center/radius rows alone cannot do this. Preserve signed odd powers, the real exponential, and the exact zero-node special case. A single certified exponential per signed index may feed all seven orders through a proved recurrence.
3. **Assembly certificates.** Check completeness and uniqueness, negative-node conjugation under its analytic identity, zero once, node centers on the `2^-32` grid, weight centers on `2^-64`, and the exact seven integer sums on `2^-96`. Check all radius and norm allocations, the rational error budget, closed-disk/rectangle geometry, and the strict whole-polynomial inequality. Diagnostics, authorization fields and success labels supply no mathematical premises.

Elementary soundness, modular identities, ordinary-derivative transport, the source P identity, reflection, Fourier quadrature, spatial and Cauchy tails, and the final xi adapter remain separate proofs. A checked arithmetic slice may first prove enclosure of its explicit elementary expression. It must not call that expression the actual P value until the source identity is proved. No missing analytic premise should be concealed as a completed unconditional result.

## Witnesses versus recomputation

Two routes have the same possible trust boundary but different workloads.

| Route | Data supplied | Work that must be checked |
|---|---|---|
| Deterministic recomputation | Exact target, finite algorithm choices, proposed final centers/radii; optional word witnesses | Recompute all missing finite elementary series, arithmetic, guards and final bounds using proved definitions, then compare the result with the claims. Reproducing Python's exact intermediate rounding is unnecessary if a sound enclosure implies the same claimed balls. |
| Typed witness replay | Ordered operation tags/references, proposed interval endpoints, branch/domain witnesses, series parameters and sufficient finite-sum evidence | Check every local containment and its relation to the fixed recipe. Verify series tails and range reduction; reject unknown operations, missing references and unchecked constants. A trace cannot promote external transcendental values to axioms. |

A hybrid is the useful first experiment: provide word choices and difficult quotient/root endpoints as witnesses, verify them with multiplication/order checks, and deterministically recompute short finite elementary series and structured sums. Prove the generic rules once. There is no reason to repeat a pi certificate per node; a shared certified interval is enough. Conversely, sharing a definition syntactically does not establish that kernel reduction caches all its uses.

Use signed-exponent dyadics for rounded endpoints and exact rational pairs where small fixed constants require them. Cross-multiply rational inequalities under checked positive denominators. Finite Taylor coefficients need a specified exact or outward-rounded implementation; not every intermediate Fraction is dyadic. Do not route huge exponent gaps through `toRat`, full-gap alignment, or an unbounded exact sum. The reviewed compact plan supplies guarded comparisons, three-term signs, outward rounding, multiplication, quotient and square-root checks. The separately reviewed reciprocal-rectangle criterion supplies exact full-box checks without Fraction extrema enumeration.

The compact plan is `integration/COMPACT_DYADIC_REPLAY_PLAN_2026-11-11.md`, SHA256 `85651AA198E92AEBDB541C48A2C42AC666B0F5A72A7DDB728545A83F01AD19A8`; its review is `major-constants/REVIEW_COMPACT_DYADIC_REPLAY_PLAN_2026-11-11.md`, SHA256 `2BD81A05B6C84A27149C1BEE5827B4918DD4F7F454AB799B1DEA8E954398F9DC`. The reciprocal plan is `prime-estimates/COMPACT_RECIPROCAL_RECTANGLE_2026-11-11.md`, SHA256 `53E2BCD126E06BCB280F579352BEB05BCB1C939AE4ACC97661F0525B3486434F`, reviewed at `9E7C5548435232AA0660A568F0C6DEF5C0CB9F2DFD9184EDCCFAABDF8FE27675`.

These are paper allocation bounds, not implemented Lean performance guarantees. For this 320-bit fixed-grid packet, huge exponent handling may be less important than repeated series reduction, Fraction normalization, expression allocation and graph access. No profile currently ranks those costs. Compact signed exponents protect the general interface; a compact typed recipe avoids carrying irrelevant JSON. Both matter, but neither proves fast replay.

## One bounded milestone and its future measurements

Select a deterministic small set of existing nodes covering all three terminal types and the maximum observed two-S path, plus one negative-index weight, its positive counterpart and the exact zero weight. Freeze their indices and claimed output balls before implementation. This is a coverage slice, not a new panel. Require generic soundness for every exercised operation and a closed accepted theorem for each selected expression. Audit the theorem's transitive axioms and exact conclusion. Include rejecting controls for a wrong T phase/type, narrowed output, wrong branch, omitted tail and altered signed weight. Malformed-data rejection alone is not a substitute for false numerical-claim rejection.

For a later authorized experiment, record the following separately:

| Phase | Record |
|---|---|
| Untrusted generation | Producer wall/CPU time, peak resident/private committed memory, output bytes; include witness generation separately from already-frozen input loading. |
| Export and representation | Conversion/parsing time and memory, typed data bytes, proof bytes, operation-tag counts, mantissa/exponent bit-width distributions, maximum live references. |
| Elaboration / proof generation | Fresh-process wall/CPU and peak memory after pinned dependencies are available; distinguish parsing, elaboration, tactic proof construction and kernel calls where instrumentation permits. |
| Kernel acceptance | Time and memory of actual checking of the generated closed proof against the pinned environment, using a documented supported checking path. If tooling cannot isolate this from elaboration, report a combined measurement and mark isolated kernel cost unknown. |
| Dependency and storage costs | Cold setup separately from warm proof work, imported artifact sizes, temporary files, final artifacts, and process-tree peak memory. |

Importing an already built artifact is not automatically a measurement of rechecking every proof in that artifact. Subtracting two end-to-end runs does not by itself isolate kernel checking. Peak RSS and private committed memory answer different questions; record both where available, especially on Windows. Parallel workers need a combined process-tree memory measurement, not just the largest worker's peak.

The pinned Lean 4.35 `Init/Tactics.lean` documents that ordinary `decide` can evaluate in both elaborator and kernel, while `decide +kernel` uses the kernel once. `decide_cbv` produces proofs using standard axioms. Native execution may generate witnesses or proofs, but `native_decide` is outside the current acceptance policy. Any comparison must retain the same claim and axiom policy and state which of these paths it measures.

Start with the coverage slice, then distinct larger batches only after correctness and resource behavior are established. Do not multiply the first slice's time by 929 or by 12,999. Classify zero/one/two-S paths, terminal types, bit widths, series lengths and sharing before any extrapolation. The earlier `LEAN_MM0_COMPUTATION_COMPARISON_2026-11-11.md` already gives the broader equal-trust comparison; this note adds no prover speed ratio.

**Verdict:** the next useful result is a small, source-bound typed replay with generic soundness and concrete standard-axiom kernel acceptance. The 77 MB packet provides candidates and provenance; it supplies neither that acceptance nor a defensible Lean cost estimate.
