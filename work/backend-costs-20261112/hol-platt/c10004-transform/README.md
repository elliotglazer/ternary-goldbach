# Actual retained c10004 integer transform

Prepared source only. No HOL process, build, evaluation, native numerical
reference or benchmark was run by the author. Independent source review must
precede the root's first diagnostic attempt. Successful source review is not
successful compilation or numerical acceptance.

This is a complete integer list program for the specified full and retained
CT transforms. It consumes supplied integer inputs and a supplied root-center
packet. It is not yet an actual L-value producer, a root-enclosure certificate,
or a complete proof of the tensor projection theorem. The precise remaining
theorems are in `MISSING_THEOREMS.md`; no declarations claiming them are added.

## Program contract

The input packet is nine lists of integer pairs in this exact length order:
2,3,5,10,15,20,30,40,60. `tx_roots_ok` checks every list length and every
coordinate bound `abs(coordinate)<=2^81+1`. It also checks exact entries for
identity, negation and positive/negative quarter turns whenever present.
These checks do not establish the accuracy or unit modulus of general roots.
The intended missing analytic contract is approximation to
`exp(2*pi*i*k/n)` with the accepted error. The public program does not pretend
that a coordinate bound proves this.

`tx_cache` constructs exact sums `(wr+wi,wi-wr)` once from those same pairs.
The public caller cannot supply unrelated cached sums. A general root action
uses three exact real products and rounds only the two final coordinates with
`BlockRound.round_scaled` and divisor2^81. The source theorem
`tx_mul_cached_identity` reduces this operation to the four-product real and
imaginary numerators. Exact roots use identity, negation or coordinate swap
without a rounding. All other additions and subtractions are exact integers.

The CT splits are 10=2*5,15=3*5,20=2*10,30=2*15,40=2*20,60=2*30.
Length2 is a sum/difference; lengths3 and5 have direct rows. A direct row
starts at x0 and adds each j=1..n-1 root product in ascending j order. For a
split n=r*m, gather `x[a+r*b]`, transform its m entries, apply cross roots
indexed a*v, and finish with the r-point row at u. Output k is v+m*u.
Children and cross-root rows are evaluated once per node. The outer GENLIST
of output points does not recompute the first children or cross products.
There is no normalization division or Bluestein leaf.

Fuel6 exceeds every admitted tree depth. Its zero case is a direct transform,
not an arbitrary default result. The public tensor uses only the fixed
admitted lengths; the general helper is total on other natural lengths but
no transform semantics or selected-workload claim is made for them.

`tx_omit` constructs the same first children and bridge as `tx_full` but only
evaluates output points1..n-1. This implements the selected q=n pruning:
the v0 final child omits u0, while every other final child keeps all outputs.
The candidate universal theorem `tx_omit_projection` states exact equality
to TL of the rounded full node for arbitrary cache and input integers. It
needs no analytic root premise. Its proof is included, but unbuilt.

## Full and selected tensor orders

Input slot is `2*(40*j61+j41)+j4`. This differs from the existing finite map
order `2400*j4+60*j41+j61`. The separate c10004-layout package owns that
permutation and source association. This directory neither edits it nor
claims its unrun checks succeeded.

The full tensor keeps all outputs at every axis. It uses 2400 length2 lines,
120 length40 lines, then80 length60 lines. Its final index is
`(2*k41+k4)*60+k61`. The selected tensor uses 2400 pruned length2 lines,
60 pruned length40 lines, then39 pruned length60 lines. Its final index is
`59*(k41-1)+(k61-1)`, with k4=1 and nonzero k41,k61. Thus its stored stage
lengths are2400,2340,2301, and `tx_project` selects the corresponding2301
entries from the full4800 outputs.

Both programs are ordinary functional list references. They allocate row
lists and flattening lists explicitly. They do not implement or prove the
in-place/early-release packed-memory schedule. A later optimization must
prove equivalence to these functions and measure its actual object lifetimes.
No live-memory saving is claimed from the list reference.

The public `tx_checked` demands the root packet, exactly4800 inputs with
coordinate magnitude<=2^95-1, and checks exactly2301 output coordinates
within2^112-1 before returning SOME. These are representation guards, not a
substitute for the complex input-norm or whole-transform error theorem.
`tx_checked_contract` exports the exact guard/conclusion relation.

## Prepared proofs versus unproved joins

The generic source includes proofs for the cached three-product identity,
node lengths, the full-versus-omitted node equality, tensor output lengths,
and public guard preservation. All require a successful ordinary HOL build.
The universal outer tensor equality is not yet proved. It is recorded
explicitly in `MISSING_THEOREMS.md`; the test equality below covers only two
fixed synthetic integer arrays. Character semantics, analytical root
enclosures and source/output error propagation are also absent.

`tx_emit` is a proof-side higher-order helper. Before translation its
definition is unfolded in the full/omit equations, so the executable equations
have only specialized GENLIST lambdas. No function-valued packet or untrusted
closure is introduced. CV translation and precondition discharge may still
require ordinary source repairs; no such repair may change the contract or
insert an axiom.

## Diagnostics and root commands

`C10004TransformTestsScript.sml` defines synthetic integer roots and arrays.
They are deliberately not labeled approximations to roots or source values.
The arrays contain signed large coordinates. They test the entire4800/2301
shape without a huge external literal file. They do not measure realistic
source construction or certify a Hardy sign.

The small mode checks10 exact logical results: a well-shaped synthetic root
packet, three bad packets, all nine local node projections, both signed
half-tie cases, a short input, a malformed packet at the public entry, and an
out-of-range input. Full mode adds both full-tensor projection fixtures,
both public-success fixtures, a nonzero impulse through every retained
channel, and a deliberately changed first output that must compare false.
These are functional diagnostics; the two fixture names h1/h2 do not assert
actual analytic height values.

The runner separates theory build, audit build and audit execution, records
each command/status and time, and checks source/dependency hashes afterwards.
It records pre-existing artifacts so a warm/no-op build cannot be called
first construction. It permits4GiB and900seconds per phase, fails closed on
any nonzero status, and requires exactly10 or16 logged controls plus the
final marker. A resource failure is not a logical rejection. Each negative
control must return the expected Boolean via an ordinary closed theorem.
Diagnostic result theories are not overwritten; root must archive a prior
attempt explicitly before reusing a mode.

After independent source review, from the Linux host-mounted repository root:

```sh
sh work/backend-costs-20261112/hol-platt/c10004-transform/run_transform.sh tx01 small
```

Only after that succeeds and is inspected:

```sh
sh work/backend-costs-20261112/hol-platt/c10004-transform/run_transform.sh tx02 full
```

The Linux runner needs no Python. It uses the existing pinned HOL checkout
and `--no_prereqs`, with existing BlockRound/StageCheck dependencies. It does
not authorize rebuilding dependencies or changing any predecessor artifacts.
Its manifest covers direct numerical dependencies and executable inputs;
transitive library provenance remains the established checkout/build record,
not a newly reconstructed closure. The audit checks closed hypotheses,
permitted DISK_THM tags and the four standard HOL bool axioms in ancestry;
it also prints each theorem's axiom-tag component for inspection.

No code in this directory supplies an analytic accuracy theorem, a trusted
root table, a completed L-function, a final sign or a zero-count result.
