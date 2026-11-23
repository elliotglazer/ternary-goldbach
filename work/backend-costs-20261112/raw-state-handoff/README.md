# Raw-state integer handoff: prepared, not run

This directory owns one matched materialized/fused HOL4 experiment. No HOL
or Lean evaluation, generator execution, build or benchmark has been performed
by its author. Python files received static AST parsing only. HOL proof/API
compatibility remains to be tested by the root's serialized build.

## Fixed scope

Input: ../../lean-pilots/raw-head/state_fixture.json, SHA256
01C3E9F1AF2FD8DF40C9EF770840078E02EC356737727637C58397836C5C6BF9.
Eight ordered bases, 129 states each, grid120 states and grid122 steps.
The fixture's source centers are untrusted integers here; their actual log,
inverse-root and step semantics have NOT been proved in HOL by this experiment.

Both paths prove the same closed integer theorem, after expanding their local
source names: raw_pipeline [1;2;3;41;61;10004;262144;265800] 61 128 sources
= SOME heads. Heads are four ordered rows of129 pairs, hence516 exact outputs.
No checksum replaces output equality. The generic pipeline checks the exact
base labels, denominator, depth, full8-by129 shape, and every state's strict
coordinate bound abs<2^121. It uses four products per recurrence update and the
same nearest tie-to-positive-infinity rule as the Lean fixture. The raw-head
real/imaginary numerators implement c*conj(Bc)*Ba and divide by2^140 to grid100.

Materialized: check/decode full producer, bind all1032 proposed state pairs,
define/translate that literal trace, check consumer, compose pipeline theorem.
Fused: one translated pipeline computation, with no intermediate HOL literal
construction/translation before primary acceptance. All eight traces are visited
by the common shape/bound check. Final output construction and equality remain
in both paths. Separate fresh processes prevent warm representation reuse.

This is EXACT INTEGER HANDOFF ONLY. It is not a closed analytic raw-head theorem,
a completed HOL analytic port, a sign, a transform, or a whole-cost measurement.
The separate full-trace recurrence experiment has a different final contract.

## Files and prerequisites

- RawStateHandoffScript.sml: ordinary definitions, length/join/guard proofs,
  and cv translations/precondition proofs.
- HandoffRuntime.sml: emitted into each wrapper; decomposes cv_eval's ordinary
  proof-producing phases and checks exact input/conclusion, hypotheses/oracles.
- prepare_handoff.py: checks the pinned one-fixture schema, regenerates the
  exact recurrence and516 expected heads as UNTRUSTED proposals, emits two
  wrappers and a cross-result comparison. No HOL subprocess is launched.
- run_handoff.sh: root-only serialized build/run,600 seconds per phase,
  4GiB virtual-memory cap, exclusive log labels and explicit saved outputs.
- summarize_handoff.py: read-only result validation and exclusive receipt.

Required existing artifacts: the pinned HOL4 commit
1de64f8521b4758508bd875fbaf11d1768261b92 and its configured hol.state/Holmake,
../hol4-setup/run.sh runtime environment, compiled BlockRound/StageCheck and
cv automation. No HOL checkout file is edited. Holmake uses --no_prereqs;
missing compiled support is a stop, not permission to rebuild dependencies.
AGENTS.md's CLAUDE.md indirection was read. These new files are outside the
upstream repository; no upstream configure/build/selftest run is proposed.

## Root launch sequence

From repository root in PowerShell, AFTER source clearance:

    & C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe work/backend-costs-20261112/raw-state-handoff/prepare_handoff.py

Then in the existing configured Linux runtime, from this directory:

    sh run_handoff.sh handoff01

The runner performs theory build, materialized wrapper build/run, fused wrapper
build/run, and cross-import comparison in order. No concurrency or automatic
retry. A fresh label is required after any failed attempt; retain every old log.
Inspect the first failure before modifying source. Generated wrappers and
fixture_binding.json are exclusive, so regeneration requires an explicit
version/archive decision; never silently overwrite them.
The runner hashes all eleven local/fixture inputs before building and checks
those hashes again after comparison. The result collector independently checks
the same launch manifest. Root must also retain the external HOL/compiler and
compiled dependency identity; these local pins do not authenticate an installation.
The runner also records selected installed heap, Holmake and BlockRound object
hashes; local executable/theory snapshots before and after every build; and
actual command arguments, exit statuses, logs and resource records. Holmake may
perform a no-op or incremental build. Only the logs and snapshots establish
what was constructed; the generic build label is not evidence of a cold build.

Finally, from repository root in PowerShell:

    & C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe work/backend-costs-20261112/raw-state-handoff/summarize_handoff.py handoff01

No launch above was performed during preparation.

## Measurement boundaries

The generic theory build is separate common library work. Wrapper compilation,
source fixture proposal generation, and whole process CPU/RSS are retained.
Inside each primary run, time literal source construction, source definition
and cv translation; final literal construction; representation proof, from/to
lookup, equations/conversion setup, cv computation, decoding and precondition
closure; final exact binding, public-source unfolding and theorem save.
Materialized additionally times its intermediate literal construction,
definition/translation and equality/composition. The fused path still pays
producer computation and representation of the pipeline term.

Controls run only AFTER HANDOFF_PRIMARY_COMPLETE: bad seed, step, interior
state, swapped source row, dropped/repeated state, final pair, base label and
denominator must reject; positive and negative half ties must match. Their
numeric data may be present in wrapper code before primary timing, but their
HOL literal construction/translation/evaluation is after it. Compiler/data
loading and whole-process costs remain recorded, not subtracted as free.

Exports contain the final theorem AND controls; their bytes/export time are
explicitly full-context costs, not a pure primary-output rate. The summary
reports primary instrumented phase CPU and full process CPU separately and
never adds them. The phase sum omits uninstrumented setup and audit gaps and is
not a complete first-acceptance time. The output comparison imports both theories and requires
aconv of their exact empty-hypothesis final conclusions. No hash is a proof
premise. Any incomplete proof, unexpected oracle, failed guard, mismatch,
timeout or resource failure is a failed experiment, not a timing success.

The older227.54-core-year proxy is not altered. This sample can measure one
integer boundary; it cannot supply spectral payload lifetimes, HOL source
analysis, general cache reuse or a whole-family representation refund.
