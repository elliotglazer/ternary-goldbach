# Matched computed recurrence experiment

13 November 2026 UTC. Paper plan only. No build, Lean edit, producer evaluation or new inventory was run for this plan.

Recommendation: compare one internally computed recurrence block with explicit operation certificates for the same eight actual bases and128 height steps. Keep the arithmetic, source centers, complete output trace and analytic conclusion identical. This tests whether moving repeated arithmetic inside a proved program reduces proof construction, checking or representation costs. It assumes no saving.

## Why this experiment

The current source work establishes real logarithm and inverse-root enclosures and prepares actual rounded step/product programs. It addresses initialization, not the repeated work across heights. The conservative raw-source schedule initializes at most265800 bases once and then advances each through as many as89600 steps. Its repeated-update count is `I*J`, while initializer count is `I`. That distinction motivates testing the update path. It does not establish that all those states are needed or that a measured low-height block prices the whole prefix.

Two existing results prevent a batching shortcut. The8192 dependent-butterfly Lean experiment costs13.464615 elapsed seconds in its median renamed kernel replay, but is a343-bit rotate-and-pair network with no actual source or global analytic error. Its count is not interchangeable with raw-source multiplications. The finite Lean batch reduces the concrete closure from8650 to265 declarations yet increases median replay from9.451671 to18.516011 elapsed seconds. Its incremental construction is cheaper under a different shared-support boundary. Therefore neither declaration count nor an unrelated backend ratio predicts this experiment.

## One minimal matched workload

Use the existing bases `1,2,3,41,61,10004,262144,265800`. Start at height zero and retain every state through step128, so the last height is exactly10. Use:

- state grid `S=2^120`;
- initial inverse-root scale `2^98`, embedded exactly by multiplying its numerator by `2^22`, with imaginary coordinate zero;
- step grid `T=2^122`, produced by the actual log/phase/Taylor/regrid program for `exp(-i*(5/64)*log x)`;
- the same four-real-product `mulStep T` definition in both variants, with two nearest divisions and the same tie convention.

The update count is1024 complex products:4096 signed real products,2048 product-combining additions/subtractions and2048 coordinate roundings. The complete trace contains1032 complex pairs, including the eight initial pairs. Counts exclude setup, integer loads, widths, equality checks, trace/index structure and analytic assembly. This is deliberately smaller than the old8192-butterfly fixture. Do not add a size sweep before this matched comparison succeeds.

Construct the eight actual initial centers and steps once. Check their literal equalities to the actual producer programs, source bounds and ranges before either variant consumes them. If shared log2 is used, both variants use the same checked cache and charge its construction once. The generated inverse-root and supplied-adjacent-square alternatives must not be mixed silently across the two variants; select one common producer, preferably the existing internal candidate program, and record its complete cost.

## Exact common conclusion

Define one ordered trace interface with dimensions8 by129. For every base index i and `0<=j<=128`, the final closed certificate must bind the actual retained integer pair `Z[i,j]` and prove

    norm(denote_grid120(Z[i,j])
         - integerPower(base[i], (j:Real)*5/64)) < 2^-96.

It must also establish exact initial entries, the exact fixed step associated with each base, and the exact recurrence `Z[i,j+1]=mulStep T Z[i,j] V[i]`. There must be no initial-value, step-enclosure, arithmetic, grid, trace-length or recurrence premise left in the concrete export. Retain literal output equality for the full trace, not only a final checksum or coordinate bound. The existing generic recurrence can supply the analytic transport after the actual arithmetic and source facts are discharged.

The two treatments differ only in how they establish the trace:

1. Operation certificates prove each update equality against supplied consecutive pairs, using ordinary integer proofs. Compose those1024 facts into the common trace and analytic theorem. Do not use a deliberately inferior rounding representation or rebuild shared sources per operation.
2. The computed block evaluates a proved loop from the same accepted seeds and steps and proves equality of its whole output with the same literal trace. Apply the generic loop/source theorem. Do not hide operation proofs in imported concrete helpers outside the measured closure.

A generic theorem about the accuracy of an unevaluated fold can be cheap without computing any usable output. That theorem alone is not this benchmark. Whole-trace literal equality forces actual arithmetic acceptance and preserves the producer-to-consumer output boundary. Conversely, the literal trace is an untrusted proposal, not a substitute for computing or proving it.

`RawDyadicProduct.lean` currently supplies the intended integer operation and a local norm-error theorem. It is a prepared source ingredient, not evidence here of a successfully built recurrence block. The full source/step/loop composition and its exact exports must compile before timing. A raw-source component still does not supply a Hurwitz polynomial, character transform, completed L-sign or zero count.

## Hard gates before comparison

Require identical source and step numerators, grids, base order, trace order and all output coordinates across variants. Inspect the final types and axioms independently. Only ordinary accepted axioms are allowed; no unchecked native computation, `sorry`, custom arithmetic axiom or hash-only output binding. Check signed rounding and exact source semantics, including x=1. If any library proof is still conditional, supply its premises in the concrete certificate.

Controls must reject a changed initial pair, step, base label, interior trace entry and final entry. A dropped or repeated time row must fail the shape/index check. Include negative-round/tie controls even if the selected trace happens not to hit a tie. A resource failure is not evidence that a false proposition was rejected mathematically. Preserve failed attempts separately.

Both variants must fit the same declared process and memory limits. Use default construction heartbeats first; disclose any later resource change separately. Do not compare one successful capped run with an unrecorded timeout in the other. All chunk seams must preserve exact stored state and its accumulated radius. A restart at a later height cannot reuse the height-zero radius or assume a fresh true value. This first experiment starts at zero and needs no late initializer.

## Measurement and decision rule

Record the following separately for each variant:

- generic proof/library construction;
- actual shared log, amplitude and step production, literal encoding and first source acceptance;
- untrusted trace/witness generation;
- successful concrete proof construction, including initial/output binding;
- complete concrete-closure kernel replay;
- output/serialization bytes, process CPU, elapsed time and peak memory.

Report both the full first-admission total and the incremental loop cost with the already accepted source explicitly identified. Never add diagnostic replay phases to a full replay that already contains them. The renamed closure must include arithmetic proof helpers and final binding. A replay of only the last generic theorem application is not a check of the computation. If setup lives in another namespace, list it as a separate charged closure rather than letting a prefix filter make it disappear.

Use the reviewed file-handshake protocol for process CPU if it remains the selected runner, and record its actual options and overhead. Its CPU bracket is wider than the kernel elapsed loop. Repeated replay is measurement replication, not repeated production work. Use fresh validated runs and an agreed repeat count; record every sample and whole-process cost. Preserve common source/library import boundaries. No old elapsed measurement becomes CPU by relabeling it.

For a future sequence of genuinely distinct matched blocks, let `G_v` be extra one-time generic/setup cost of variant v and let `P_v(b), A_v(b), O_v(b)` be its proposal/proof production, acceptance, and output/binding costs for block b. Charge the common source cost S once only if identical lifetime and reuse are proved. The computed variant wins first-admission CPU exactly when

    G_computed - G_explicit
      < sum_b [(P_explicit+A_explicit+O_explicit)
                -(P_computed+A_computed+O_computed)].

For this one-block experiment use only the observed block, not a hypothetical long-run average. Report replay preference separately. A checking improvement that increases full construction is a tradeoff, as the finite batch already demonstrated. If the observed cost difference is smaller than run variation or handshake/import uncertainty, the result is inconclusive. A memory failure or absent semantic closure is a no-go for that implementation, not an invitation to quote its partial timing.

This plan targets repeated raw-state arithmetic. Even complete removal of its initializer cost leaves recurrence, raw conductor caches and residue products, shifted-Hurwitz production, contractions/transforms, error/completion work, sign repairs, counts, principal work and finite Goldbach coverage. Optimizing the265800 initializer pool alone cannot price those roles. No speed factor or end-to-end forecast follows from this proposed experiment.

## Read evidence and pins

Paths below are relative to the repository. Prepared source pins specify the proposed interface, not a new compiled or independently approved implementation claim.

| Evidence | SHA256 |
|---|---|
| work/backend-costs-20261112/lean-dependent/REPORT.md | F22B60290F42C374C77C8E1E4EF1810ABD7D5F8672C7F45050E81C3677F9C579 |
| work/backend-costs-20261112/finite-lean/BATCH_REPORT.md | D36B55EC6450443A26FF3F7234A14B7523F947F70B2169C0A8AF35B26443728B |
| work/lean-pilots/raw-head/RawDyadicProduct.lean | 655FD30D73CB50ADCE330329A3C145FE67829F8D19B89DB6863BD969688AA624 |
| work/lean-pilots/raw-head/RawRecurrence.lean | 21B56EAA24799BCE237C30F318A05276FC5F504A3D6A4E3A3B921BCBBED32C7A |
| work/lean-pilots/raw-head/RawStepProducer.lean | AE8465E9032142061D16FD362658147759FB0C7B2F386E0638C08E472DD7A3AB |
| work/lean-pilots/raw-head/RawInverseRootProducer.lean | AB4B5B6721C03D37E87DC09732865B27A42161C8B7B686EEC50EEF48B676353B |
| work/lean-pilots/raw-head/RawInitialization.lean | C695D2F12F1822C57A8E13EC4376CD2E0378D90B82ABD111805FC7A72FACA1E1 |
| work/lean-pilots/raw-head/RawLogAssembly.lean | BDF4C5DABB9F68EA9E5754452CE0C228EDA801A9F144A4648F415E7C900485D7 |
| work/lean-pilots/raw-head/SOURCE_COMPONENT_AUDIT.md | 779C044560FACD665B9DCDB9CEEB28A0ABA6E44B547876B385237F8F70FBF996 |
| work/lean-pilots/raw-head/REPLAY_PROTOCOL_AUDIT.md | 52F362107CB04989577BDB35FFA3EA22FE8A2D1CE420BE0E161C6C9FE169BE40 |
| work/qrh-campaign/agents/integration/RAW_HEAD_GRID100_PRODUCER_AUDIT_2026-11-11.md | FBBB538E0FC72865A9B4815A048992644AA0563AFC2DEA970FB9C3B4F7596EEE |

Stop after this matched experiment and its audit. Any larger block, alternate arithmetic algorithm, spectral/sign claim or backend comparison needs a separate decision based on the complete result.
