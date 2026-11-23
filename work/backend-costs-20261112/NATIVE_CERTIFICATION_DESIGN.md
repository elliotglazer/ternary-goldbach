# A feasible native-certification architecture

The measurements support pursuing a verified evaluator before concluding that
a standard-foundation ternary Goldbach proof is impractical. They do not yet
establish a feasible end-to-end compute budget. In particular, an axiom count
does not specify the proof format, evaluator implementation, library coverage
or amount of numerical work.

## The mathematical and execution obligations

For each finite task, define an executable acceptance predicate and prove a
generic theorem connecting acceptance to the exact mathematical obligation.
The spectral task must cover source enclosures, certified coefficients,
rounding and error propagation, strict signs, and a complete zero count. The
prime-coverage task must cover source primality, anchor certificates, shifts,
exceptions and exact interval coverage. A theorem about a few arithmetic
operations is useful for choosing an evaluator but does not discharge either
complete obligation.

An untrusted program may search for witnesses and prepare the inputs. Actual
acceptance must then be justified. Merely proving that the checker is correct
does not prove that a particular external run accepted its input. That last
step needs kernel evaluation, a checked execution proof, or a verified
execution mechanism incorporated into the proof system's acceptance rules.

The useful design keeps intermediate arithmetic values inside that execution
and derives a short semantic result, such as a zero count or coverage of a
specific interval. Shared source and coefficient producers should be proved
once. The production design must account for input construction, cache reuse
and checked partition assembly, rather than charge only the inner arithmetic.

## Existing systems and an extension

Candle already has a soundness-proved fast evaluator, integrated with its
machine-code soundness development. It runs suitable first-order computations
using native arbitrary-precision arithmetic and returns a theorem. HOL4 has a
closely related evaluator and proof-producing translation tools. These are
existing mechanisms, not hypothetical future proof assistants. The local
arithmetic experiments and their exact limitations are in REPORT.md.
See [the verified-computation paper](https://doi.org/10.1007/s10817-025-09719-8)
and [Candle's project documentation](https://cakeml.org/candle/).

A focused Lean extension could follow the same design. It would accept a
restricted numerical language with precise integer, array, interval and
bitset semantics. Its source translation would produce ordinary correctness
proofs, and its evaluator would have a checked soundness argument relative
to Lean's inference rules. This is a smaller target than verifying an entire
optimizing Lean compiler. Efficient checked interval arithmetic and packed
prime coverage may need different specialized operations.

Such an extension need not add a mathematical axiom. It changes the kernel
implementation or accepted computational rule, so it is a different deliverable
from a proof accepted by an unchanged stock Lean kernel. Its correctness,
actual executable, input interpretation and output binding all need evidence.
It has not been implemented in this project.

## Three deliverables that must remain distinct

| Deliverable | What would establish completion |
|---|---|
| Stock Lean with the usual three axioms | The exact TG theorem rechecks in the unchanged kernel, with the full numerical obligations in its checked dependency closure |
| A verified faster Lean evaluator with the same logical axioms | The exact theorem is accepted through a proved sound extension, with the deployed implementation and execution contract identified |
| A standard-foundation HOL proof using Candle | The numerical and analytic TG statements are both proved in that foundation, and the result is exported through the verified output channel |

Candle uses the HOL axioms of infinity, choice and extensionality. These are
not Lean's propext, Classical.choice and Quot.sound. A Candle theorem therefore
does not become a stock-Lean theorem by importing a success record. Likewise,
an ordinary MM0 certificate and a specialized verified checker for PA are
different deployment targets. A cross-system interpretation would itself be
a separate formalization project.

## What to build next

The next meaningful cost experiment is one complete spectral block, with
proved source values, coefficients and error propagation, ending in the
analytic claim needed by the zero-count argument. Measure construction,
execution, mathematical assembly, memory and output separately. Independently
measure a complete finite prime-coverage block, including source-prime evidence.
Then price the existing typed workload ledger and re-optimize the binary-cutoff
versus prime-ladder tradeoff for the chosen evaluator.

The current network already demonstrates that execution architecture can
change the measured arithmetic cost substantially. Small-batch Nat packing in
stock Lean gives only a modest additional improvement on the tested products.
Neither result is a justification for multiplying every entry of the old TG
forecast by one speed ratio. Ordinary PA MM0 now has an exact scalar-product
theorem with independent verification and a measured four-bit-rule optimization
(mm0-pa/REPORT.md). It does not yet have the matching signed dependent network.
Complete numerical blocks and backend-specific end-to-end costs remain unfinished.

The finite experiment has since reached one complete closed interval theorem
in Lean and HOL4, including all source/anchor primality and exact endpoints.
See finite-lean/REPORT.md and finite-hol/COVER_REPORT.md. Balanced witness
definitions remove a measured input-translation bottleneck in HOL. The next
finite experiment batches the prime-certificate graph, while full spectral
certification and end-to-end costs remain unfinished. No cross-system transfer
or universal backend speed ratio follows from the new result.
