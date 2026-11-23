# From arithmetic certificates to a computed block

The matched butterfly checker is useful for cross-system comparison, but is
not an optimized lower bound for a verified FFT. It reads both inputs and
claimed outputs, recomputes three products, and checks nineteen conditions.
A verified evaluator can instead compute rounded outputs itself, justified by
a generic rounding theorem. This removes the claimed-output input and avoids
checking the rounding inequalities individually at runtime.

For positive integer scale S, define

    roundS(r) = floor((2*r + S)/(2*S)).

Its required theorem is

    -S <= 2*(r - roundS(r)*S) < S.

With the exact three-product real/imaginary results rr and ii, set

    pr = ur + roundS(rr),  mr = ur - roundS(rr),
    pi = ui + roundS(ii),  mi = ui - roundS(ii).

The existing residual-pair argument then establishes the four output error
bounds. The implementation must use mathematical floor division, including
negative numerators. A difference-of-naturals backend must normalize results;
repeated unnormalized pair multiplication can increase operand sizes needlessly.

## Required next experiment

The HOL4 BlockRound theory proves the rounding and four local residual
bounds, and its evaluator precondition follows from positive scale. The first
dependent integer network is now complete; see the checkpoint below. A generic
global range/error invariant for the intended spectral algorithm is still absent.
The earlier phase profile supplies direct
evidence for the boundary issue: raw kernel conversion costs about 35 ms for
P343N64, while rebuilding the original integer proposition takes about 1.43 s
after preparing the representation. Named inputs and short conclusions are
therefore another concrete optimization to test alongside internal execution.

The actual Rocq 9.0 native pilot also confirms the need for amortization.
Its Qed parent CPU is about half the same-build VM cost, but the complete small
proof file costs more when compiler subprocesses are included. The next test
should improve block architecture, not merely repeat the same tiny fixture.

1. Define this output-producing operation and prove its rounding/residual
   contract, including positive scale and the chosen range invariant.
2. Build a genuinely dependent multistage block. Later inputs must use earlier
   computed outputs. Repeating an identical stage is not this experiment.
3. Retain intermediate values inside one evaluator invocation. Initial inputs
   and coefficient generation must be included or separately measured.
4. Compare the same operation and data against a native implementation. Record
   translation, evaluation, memory, and final mathematical output separately.
5. Extend to certified coefficients, source enclosures, error propagation and
   the analytic conclusion before applying the rate to the complete TG plan.

The first completed level uses rational coefficient fixtures with an explicit
limited contract. It must not be described as a certified transform or a
zero-count proof until coefficient, source and propagation obligations are present.

## Dependent-block checkpoint, 13 November 2026 UTC

DependentBlockScript.sml and the matching GMP program now satisfy the dependent
arithmetic portion of items 2–4. Every layer consumes the preceding output, with
a rotation connecting different pairs. HOL4 proves length preservation, every
local residual relation, a final coordinate bound and an exact output statistic.
Three fresh processes pass all sizes and controls, with identical exports.
No global spectral error invariant or analytic interpretation is present.

The largest 8192-butterfly block has pooled medians of 73.960 ms for full HOL
acceptance and 3.747830 ms for native execution. Named literal translation costs
a separate median 4.269485 CPU seconds, shared across calls. The detailed report
is hol4-setup/DEPENDENT_BLOCK_REPORT.md; all evidence is in DEPENDENT_RESULTS.json.

The stock-Lean comparison is now complete, including the same generic integer
contract, five controls and three fresh kernel replays per size. Its largest
block takes 13.464615 elapsed seconds. A further packed-product probe finds
modest gains at small sizes and loses at 64 products. Balanced literal loading
fixes a separate frontend cost; it does not remove numerical checking. See
lean-dependent/REPORT.md and PACKED_REPORT.md. All those jobs are terminal.

Candle's dependent comparison is now also complete, including the generic
integer contract, three fresh processes, exact coordinate comparisons, all
controls and identical kernel-channel exports. Its largest-block median is
158.679 ms CPU, with separate input setup of 4.186 seconds. See
candle-setup/DEPENDENT_REPORT.md and DEPENDENT_RESULTS.json. All jobs are closed.

Next examine a proved source producer that avoids per-literal translation.
Add actual spectral coefficients, source enclosures and propagation before
transferring a rate to a complete TG forecast. Ordinary PA MM0 and finite
coverage remain separate cost tasks. NATIVE_CERTIFICATION_DESIGN.md records
the proposed acceptance mechanisms and their distinct trust contracts.

## Why the distinction affects the estimate

High-precision input literals cost a traversal of their logical representation
in the current Candle interface. Computing values internally from small
parameters can amortize or avoid those boundaries. A final theorem about zero
counts or interval coverage can be short even when its computation is large.
This is an algorithm-design opportunity, not a demonstrated whole-proof rate.
Keep finite prime-coverage benchmarks separate: their efficient packed-bitset
representation and memory behavior differ from high-precision spectral work.

The current HOL4 cv_compute kernel lacks direct bitwise primitives: its word
OR/AND/XOR translations use recursive per-bit arithmetic. Lean 4.35.0 has direct
native kernel reductions for Nat bitwise operations. The earlier wide-bitset
Lean experiment therefore remains relevant; reusing the spectral winner for
prime coverage without a separate test would be an unjustified assumption.

## Complete finite interval, 13 November 2026 UTC

The separate finite test now includes a closed 1,024-target interval theorem
in both stock Lean and HOL4, with all source and anchor primes discharged.
Lean's complete certificate replay has a three-process median of 9.452
elapsed seconds. HOL's balanced implementation takes 11.075 CPU seconds across
its measured reconstruction, translation, coverage, assembly and export phases.
The acceptance boundaries differ. See finite-lean/REPORT.md and
finite-hol/COVER_REPORT.md for the exact protocols and limitations.

The numerical coverage checks take only 3.516 ms in Lean and 21.964 ms in HOL.
Prime certification dominated that small certificate. Balancing HOL witness
definitions reduced data translation to 1.448 CPU seconds, from 58–131 seconds
in flat-layout attempts. The subsequent batched checker is now complete.
HOL's primality median is 64.05 ms, but its whole-process median is 13.09 CPU
seconds rather than 18.27. The same design compiles in stock Lean with bounded
subtree composition and the standard three axioms. Its full replay median is
18.516 elapsed seconds, slower than the earlier 9.452. Further finite tuning
is deferred behind the missing spectral and production-scale measurements.

The next spectral entry block is the actual conductor c=10004, with 4,800
unit inputs and 2,301 primitive output channels, at indices 1 and 2 of the
5/64 height grid. Initialize and certify its height-zero state inside the
block. Use the saved p81 combined8828 contract and ordered 2/40/60 tensor
plan. The p75 mean186 successor has different hypotheses and receives no
unmeasured saving. This conductor has no Bluestein leaf, so a separate actual
row must later calibrate normalized Bluestein cache construction.

Before implementation, bind concrete unit generators, CRT flattening,
character maps and retained output indices to the analytic definitions.
Certify actual source and root values, execute the selected dependent circuit,
propagate its error and derive actual signs or explicit inconclusive outputs.
Do not import an unproved initial state or an assumed sign margin. The exact
saved parameters are in forecast-audit-20261113/C10004_PARAMETER_PACKET.md;
INDEPENDENT_FEASIBILITY.md specifies the acceptance and measurement gates.

The first reusable source module should implement the reviewed shared
integer-power producer and its indexed rounded recurrence. Its theorem must
bind states to actual powers. SPECTRAL_STRATEGY.md supplies its source contract
and the separately useful Hermitian half-time reduction. A complete small-family
time block and a source-to-sign-to-count block remain distinct follow-ups.

Production-scale finite coverage and an adapted prime ladder also remain
unfinished. FINITE_FRONTIER.md records why the existing 2048-offset ladder
cannot be reused unchanged at the smaller binary cutoffs. No component timing
may be applied as a universal backend multiplier. Conditional full-cost models
must retain source production, counting, failed searches, libraries and I/O.
