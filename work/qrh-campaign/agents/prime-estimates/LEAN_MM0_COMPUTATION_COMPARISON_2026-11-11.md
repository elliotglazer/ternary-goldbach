# Lean, MM0 and the cost of checked computation

2026-11-11. **Verdict: there is no defensible Lean-to-MM0 speed ratio for this Goldbach project yet.** MM0 can make explicit proof replay cheap; Lean can perform substantial computation inside definitional equality. Neither observation tells us the cost of certifying this project's bitset counts and interval arithmetic. A small matched benchmark of those two workloads is the minimum useful basis for a Fermi estimate. No benchmark or build was run for this note.

## What actually runs

| Route | Work at acceptance | Trust distinction |
| --- | --- | --- |
| Lean kernel reduction / reflection | A soundness theorem connects a Boolean checker to the mathematical claim; the kernel checks its application and the concrete computation needed to prove acceptance. Other proofs may instead supply explicit arithmetic steps. | The proof producer need not be trusted. The kernel and its arithmetic implementation are trusted, along with the declared logical axioms. |
| Lean proof-producing evaluation | A tactic constructs equalities or other proof terms, which the kernel checks. | Compiled tactic execution is not itself an oracle if its complete output is checked. |
| Lean `native_decide` / `decide +native` | Compiled evaluation is admitted through a generated axiom. | This additionally trusts the native evaluation path, compiler and replacement implementations. It is outside this campaign's standard-axiom policy. |
| MM0 ordinary proof checking | The verifier checks a supplied proof stream against the supplied specification, including explicit conversion steps and shared references. | An untrusted producer may generate the stream. The verifier implementation and specified axioms remain trusted. |
| Plain Metamath | The verifier checks substitutions, hypotheses, distinct-variable conditions and earlier assertions in a proof database. | It does not automatically execute a numerical procedure because it appears in a theorem statement. |

Lean's pinned 4.35.0 source documents that ordinary `decide` may reduce in both elaborator and kernel, while `decide +kernel` avoids that duplicate evaluation. It also documents `decide_cbv` as proof-producing evaluation requiring only the standard axioms. Thus “Lean evaluation” is not one timing category. The local `Init/Tactics.lean` SHA256 is `0F98C09E7E56ED3431292D6996A20237EC8E5EB4D322E5701B33D6396638E056`; `Lean/Meta/Native.lean`, which constructs the native-result axiom, is `E1D0C6B5BE42F492810A12281FC0D8FF4C981E421397C3EC00E165A255ED09C1`. [Pinned tactic source](https://github.com/leanprover/lean4/blob/v4.35.0/src/Init/Tactics.lean), [pinned native mechanism](https://github.com/leanprover/lean4/blob/v4.35.0/src/Lean/Meta/Native.lean).

Lean's kernel is not restricted to unary arithmetic. Its `reduce_nat` handles natural-number literal arithmetic, division, remainder, bitwise operations and shifts using implementation primitives. However, surrounding recursion, expression allocation, reductions of data structures and definitional equality still cost work. Data representation, sharing, reduction strategy and chunk boundaries can dominate. [Lean 4.35.0 kernel source, `reduce_nat` and `whnf`](https://github.com/leanprover/lean4/blob/v4.35.0/src/kernel/type_checker.cpp).

MM0's binary format makes conversions explicit and provides saved term/proof references. Its reflexivity test uses pointer identity, with the producer responsible for arranging sharing. This can avoid searches and repeated reconstruction, but adds a proof-production and proof-storage workload. “Essentially linear checking” concerns the supplied proof representation, not the number of mathematical operations in an arbitrary source algorithm. [MMB format and proof instructions](https://github.com/digama0/mm0/blob/master/mm0-c/mmb.md).

MM0's thesis describes arithmetic tactics that return both a value and its proof, with computation-linear proof overhead under suitable sharing. It explicitly notes this is not unique to MM0. Its historical fast `set.mm` verification used a translated, rearranged representation, so that result is not a measurement of these Goldbach computations. [Carneiro thesis, sections 1.6 and 4.2](https://digama0.github.io/mm0/thesis.pdf).

Plain Metamath and MM0 should not be merged into one benchmark label. Metamath's documented rule applies supplied substitutions rather than discovering them, but its conventional proof representation and verifier differ from MM0's typed tree and binary stream. [Metamath proof explanation](https://us.metamath.org/mpeuni/mmset.html#proofs).

## Equal trust means equal treatment of execution

A theorem proving that a numerical checker is sound does not, by itself, prove that one particular executable run returned true. To certify that run, one must check an execution/proof certificate, compute in the trusted checker, or trust a correctly implemented execution path. The same alternatives apply to both systems. A verified native checker could justify a fast path if the chain covers the actual executable, inputs, arithmetic semantics and result interpretation; the word “verified” is not a substitute for that chain.

For the comparison here, allow untrusted native **generation** on both sides, but require ordinary checker acceptance of every numerical fact. Do not compare Lean kernel computation against an MM0-associated native program whose result is merely assumed. Conversely, do not compare `native_decide` against ordinary MM0 proof checking while claiming identical trust. The MM0 project describes its verified-executable bootstrap as a project goal; that does not establish that an arbitrary candidate binary already has that proof. [MM0 project overview](https://github.com/digama0/mm0), [Lean validation guidance](https://lean-lang.org/doc/reference/latest/ValidatingProofs/).

In both systems, include the final statement and axiom manifest in acceptance. In particular MM0's documented `NO_PARSER` configuration omits the external specification comparison; timing it alone does not validate the requested theorem. [mm0-c options and contract](https://github.com/digama0/mm0/blob/master/mm0-c/README.md).

## Smallest useful matched experiment, not executed

Use two finite workloads already present in this project:

1. **Counting workload:** one actual 32768-position sieve subcell, then batches of 8 and 64 distinct existing subcells. Preserve the same complete 7004-prime base, 131072-bit pattern semantics, count convention and boundary checks. Separate one-time base/pattern certification from per-cell work. This measures the work behind the 125271 recorded subcounts; it does not establish that each costs the same.
2. **Arithmetic workload:** the existing 24 reciprocal rectangles and their exact four-inequality decisions, plus the fixed 63-term rational seed certificate. Require matching accept/reject outcomes, including the two genuine rectangle failures. Include the existing huge-exponent rescalings to catch denominator expansion. Use the same signed-exponent meaning and exact analytic checker contract, not a floating-point approximation on either side.

For each, compare Lean kernel/reflection and a reasonable proof-producing Lean route against ordinary MM0 proof replay. Supply the same mathematical inputs and equally strong conclusions; audit the encoding bridges. Plain Metamath is a separate optional third implementation, not a proxy for MM0. Use distinct cells/receipts in batches so theorem reuse does not turn repeated identical inputs into an artificial speedup.

Pin tool versions, executable options, logical axioms, hardware and worker count. Report separately: proof generation, serialization, cold dependency checking, warm input parsing plus proof checking, peak memory, proof bytes and temporary storage. Run false-input controls. Measure at least three batch sizes to expose setup, scaling and memory thresholds. Existing Python or Arb timings do not fill any of these checker timing columns.

A later estimate may use `setup + sum_j(number_of_jobs_j * measured_cost_j)` by workload class, with measured size-dependent ranges and separate proof-generation/I/O totals. Extrapolate only across supported sizes and bit widths. Unknown spectral certificate volume and unimplemented analytic bridges remain separate unknowns; they cannot be hidden inside a purported universal MM0 speed multiplier.

This note supplies a comparison design and a trust-model verdict only. It neither chooses a new prover for the project nor predicts a completion date.
