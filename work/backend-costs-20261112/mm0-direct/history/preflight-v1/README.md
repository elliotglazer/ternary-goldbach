# Direct ordinary-MMB producer: prepared source, not accepted proof

This is the implementation candidate for `../MM0_NEXT_MEASUREMENT.md`.
No compiler, MM0 verifier, Lean process or benchmark was launched by the author.
The only executed tests are Python syntax parsing, static decoding of the saved
library's declaration headers, and 82 tiny format tests. These establish no PA
theorem and are not timing evidence. Root must review the sources before running.

## Exact contract

The fixed source is `work/lean-pilots/batched-transform/P343N64.json`, SHA256
`F024EAF87BD02898530A72CAB2C567B00C98BCC83DF48E0BE4E8D9CFCA6D00AE`.
For its 64 rows use the original signed `input[2]` and `input[4]`, not selected
favorable values. Every integer is represented by the canonical pair of
nonnegative components, with literal zero on the unused side. Each row exports
the exact two natural equalities for signed multiplication. The final theorem
is their ordered balanced conjunction. The zero-case control exports `0=0`.

Both arms use the existing proved four-bit addition rules and binary
schoolbook multiplication. Each row has six public component definitions, one
public magnitude product and one public signed product. The final conjunction
is produced in the same file. The sign wrapper instantiates the existing PA
zero-product, zero-addition, congruence, transitivity and conjunction rules.
It does not add four new sign axioms or require a new integer sort. The
natural-pair interpretation is explicit; there is no claim of a rounded
product, dependent FFT, Lean integer import or analytic source theorem.

## Implementation boundary

`mmb.py` parses the saved `fourbit0.mmb` library and retains all of its proof
statements verbatim. It reconstructs the declaration tables and relocates
their signature offsets. All original term/theorem IDs stay unchanged, and
new declarations follow them. No original arithmetic proof is replaced by a
hash or cached theorem assumption. The optional debugging name index is
omitted in direct output. The independent checker still parses the full
textual specification and checks every proof, including the copied library.

The library pin is
`813A982693548162973DCBAAB7BA4B2558EDD3CEFC7179040113E92ECBD9CBF4`.
Its ordinary-PA axiom inventory has 26 entries. `Sorry` is rejected during
input parsing and by the independent output audit. The source libraries and
joined specification have additional fixed pins in `prepare.py`.

The direct emitter builds terms with explicit local sharing, fills theorem
arguments by matching the actual saved signature, emits ordinary premise and
argument applications, and performs explicit definition conversions. Curried
implications use the existing `ax_mp`. The untrusted matcher is not part of
the acceptance boundary: wrong substitutions must fail in mm0-c.

The frontend arm prints the same derived proof structure as MM1 and leaves
argument inference/definition conversion to the existing frontend. Both arms
put the conjunction in the initial output, so the old separate 6.86-second
import/aggregate pass is not a matched timing baseline. No wider radix,
Karatsuba, named-digit change or new theorem chunking is included. Differences
in expression sharing and serialized commands are measured, not assumed zero.

`prepare.py` modes are `spec`, `frontend`, and `direct`, each with count 0 or64.
All generated artifacts are exclusive. It never invokes the checker. The
specification is a full joined ordinary-PA specification. `audit.py` separately
decodes binary headers and compares the exact component literals, magnitude
claims and all 128 signed equalities against the pinned JSON. It does not
import the producer module. It checks absence of new axioms and `Sorry`, and
compares every copied direct-library statement byte-for-byte. Actual logical
acceptance remains the independent checker, not this audit.

## Root launch, only after review

The first small preparation command from the repository root is:

```
& C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe work/backend-costs-20261112/mm0-direct/prepare.py spec 0
```

That would create an exclusive artifact and therefore must not precede the
full fresh-directory runner without an explicit archival/version decision.
It is useful only if root chooses staged diagnostics. No such artifact exists
at handoff. The complete runner's first command, in the existing configured
Linux environment and this directory, is:

```
sh run.sh direct01
```

It requires an existing Python3, the pinned `../mm0-pa/mm0-rs`, the existing
`../hol4-setup/run.sh` runtime and the existing timed/profile/highwater C
checkers under `../../formal-goldbach-bench/mm0`. It installs and builds no
toolchain. If Python3 is unavailable there, root can use the listed Windows
Python for preparation modes and execute the checker phases manually with
the same logging/pinning; that is a different run record, not a hidden retry.

The runner caps virtual memory at 10 GiB and each regular phase at 600 seconds.
It processes zero and full cases sequentially, each with five fresh timed
checks and separate command/high-water checks. Proposed direct files are
capped at256MiB and the internal term catalogue at2,000,000 nodes. These are
fail-closed preparation limits, not established workload resource needs.
Fresh labels and an empty generated-artifact set are mandatory. Root must
stop on the first failure, retain diagnostics and review before any change.

Four malformed controls per arm change an input magnitude, a nonzero input
sign, an output magnitude, and a theorem reference inside signedProduct63.
The runner requires a nonzero non-timeout exit; the collector additionally
requires the actual `MM0_REJECT` diagnostic. Source corruptions deliberately
test exact public binding. They are not claims that a different true product
can never have its own valid proof.

## Measurement and unclosed obligations

The runner pins input code, fixture, libraries, compiler and checker binaries
before execution and checks that they remain unchanged afterward. It keeps
exact commands, exit status, whole-process CPU/elapsed/RSS and all artifact
sizes. The saved internal checker timer is separate from whole-process time.
No warm-tmpfs or cold-disk equivalence with the prior pilot is assumed; this
runner leaves files on the chosen filesystem and reports that choice.

Record the specification/proposal phase, frontend source generation, direct
construction/serialization, frontend compilation, independent checking and
controls separately. The direct setup includes saved-library parsing and
re-emission, but not historical development of that library. Both complete
files replay the library in the independent checker. Compiler/tooling
construction is inherited common setup, not free work for a new deployment.
The zero fixture is a gross-setup control, not permission to erase actual
library costs from a first acceptance.

Remaining gates are substantial: compile the frontend source; independently
accept both full MMB files; establish that all definition conversions and
argument orders match the stock format; verify source/specification equality;
pass malformed controls; and review the recorded command/memory counts. The
static tests do not discharge those gates. No speedup, proof-byte saving,
stock-memory fit or end-to-end forecast change is claimed.
