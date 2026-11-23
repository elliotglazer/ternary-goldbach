# Exponential Horner construction notes

The candidate's twelve statements, three definitions, five exact program types,
fixed audit and source manifest were frozen under history/exphorner01 before
the first build. The accepted state-error and raw-log bindings were rehashed.
Operator spacing around casts was normalized before that freeze.

Exphorner01 proved seh_round_pair_error and stopped at seh_affine_distance.
Its failed heap is archived. Expdiag01 identified the missing simplification
of the imaginary unit's modulus. Expdiag02 added a broad square/square-root
simplifier and reached the 120-second limit. Its process receipt records
termination by signal 15, so it receives no acceptance despite GNU time's
separate exit-status field. Its recorded CPU time remains in the research cost.

The proof now uses direct rewrites for the coordinates, their squares and
sqrt(1). Expdiag03 passed the first five lemmas. Expdiag04 printed the exact
source-step residual: rewriting LET_THM left a lambda application. An explicit
BETA_TAC now reduces it before applying the generic pair-rounding theorem.
The temporary diagnostic printing was removed.

Expdiag05 passed the first ten lemmas and exposed an implication tactic applied
to an unconditional base-case fact. Expdiag06 showed that rewriting with the
general initializer equality also left the induction base unresolved. The
final base proof evaluates the two zero-depth definitions directly, avoiding
fresh unconstrained ideal-phase parameters. Expdiag07 passed all twelve exact
closed conclusions. All theorem statements and definitions remain unchanged.

Each diagnostic preserves its exact input, input hashes, output, phase timing
and terminal process receipt. Diagnostic success does not replace a fresh
theory build and execution of the separate frozen expected-term/type/axiom audit.
The recorded-result reviewer checks all source, dependency and output bindings
and requires successful terminal receipts. Only RESULT_REVIEW.md and
review_result.json from that review establish acceptance of the full module.

The error bound is against the defined ideal recurrence. An exponential Taylor
identity and remainder, actual input phase bound, normalization and final regrid
remain required. No production runtime or aggregate campaign saving follows
from this generic rounding proof alone.
