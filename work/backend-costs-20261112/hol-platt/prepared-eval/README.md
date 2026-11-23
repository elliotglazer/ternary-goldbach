# Prepared evaluation: runnable source, not yet tested

Root-only launch from the Linux host-mounted workspace, after source review:

    sh work/backend-costs-20261112/hol-platt/prepared-eval/run_prepared.sh prepared01 smoke

A later distinct label with `full` runs three fresh processes per mode rather than one. Each process always tests depths 1,8,32,128 with three calls per case. All processes run sequentially. Smoke is three processes total; full is nine. The runner compiles only owned sources using `Holmake --no_prereqs`, a 4 GiB virtual-memory cap and 600-second per-phase timeout. It uses the already-built StageCheck, BlockRound, DependentBlock and stock CV support. No kernel or dependency rebuild is allowed. Existing labels refuse overwrite.

`prepared_dependent.sml` is copied from the pinned baseline with its literal inputs, coefficients, four acceptance expressions and five corruptions preserved textually. Only driver/control instrumentation and result theory name changed. `PreparedEval.sml` supplies the stock transport sequence with either a freshly created or retained conversion. The draft polymorphic-timer error was repaired by giving the adapter its own top-level polymorphic timing function; no run was needed to identify it.

The stock-reference equality is checked AFTER the three selected-mode calls so it does not silently warm the first selected evaluation. In retained mode, prebuild discovery and conversion are timed before the first call. Input naming/translation, positivity, representation discovery on every call, normalization, proof transport, soundness derivation and export all remain charged in phase or process logs. Phase times nest in outer call/process times; do not add nested times twice. This is not a cold-process baseline for each individual depth: previous depths already ran. Compare modes within the same schedule, keep first-call data and whole-process CPU.

## Critical cache scope limitation

A retained closure owns an ordered list of closed equation theorems. Every application rediscovers the current representation and equations and checks exact conclusion equality with `aconv`; the old theorem objects remain valid dependencies. It does not use a hash to authorize evaluation and it never returns a cached result theorem. Each call invokes the stock conversion on the actual current term.

The positive performance cases repeat the same named fixtures. This experiment therefore isolates code-conversion reuse, NOT realistic throughput for arbitrary new spectral payloads. Named input definitions can occur in the CV equation set. Changed-input/coefficient controls explicitly print cache HIT or MISS. On MISS a new correctly bound conversion is built and paid for before proving the false claim. No exception counts as mathematical rejection. The equation-identity predicate also has an explicit nonempty-versus-empty control; that is a structural guard check, not a false mathematical theorem.

A HIT for a changed named input would demonstrate that particular equal-equation case only. A MISS establishes that cross-payload reuse is not obtained here. Before crediting reuse across fresh spectral blocks, a separate proved input interface must supply fresh CV data under genuinely identical program equations and pay data representation. This driver does not pretend to solve that boundary.

## Acceptance and interpretation

Every positive mode result must have the exact requested LHS, true RHS and empty hypotheses, and its full equation must equal the stock reference. The generic block_accept_sound theorem derives the same existential local-residual/length/bound/checksum output, then audits allowed tags and exports it. Every negative control is proved false both by stock and the selected route and compared. Kernel equality handles the actual term; timer and native data generation have no logical authority.

The runner only provides an execution envelope and preliminary marker checks. Root must still audit all completed logs, expected modes/counts, per-result proof/tag checks, hashes, `.dat` objects, phase timing validity and resource failures before calling any measurement accepted. No summarizer or speed inference is supplied. The existing native baseline is unchanged.

Prepared conversion execution still includes parsing, interpreter, reification and proof transport. No new tracing inside the kernel was added. Signed quotient specialization, altered butterfly arithmetic, different list representation and changed source construction remain parked.

## Review repairs before first build

The incompatibility control now invokes an actual retained fixture-8 closure on
true, after independently confirming its equation set differs. Only the specific
PreparedEval.CacheMismatch exception satisfies this control. Successful return,
any other exception, or resource failure aborts. The true proposition is not
claimed false; this checks refusal to use the wrong code cache.

Every discovered equation set used by the experimental paths is recorded as an
ordered list of exact closed HOL theorems named prepared_equations_ID_INDEX in
the exported results theory. Set counts, member names and per-use IDs are logged.
The registry shares metadata only after exact conclusion comparison. IDs are not
an oracle or a replacement for the actual equation objects held by the closure.
Stock/fresh modes also record their case equation sets outside the timed calls.
This instrumentation is explicitly timed/charged; it can perturb the small-case
comparison and its cost must not be silently deleted. Current final tags and
ordinary saved-theorem trust remain unchanged.

The runner additionally verifies the executable hash after the entire run.
The previously documented synthetic list predicate remains as an additional
small structural check, not as the only incompatible-cache test.
