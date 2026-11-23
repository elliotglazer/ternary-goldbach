# Statement import candidate

The scratch Statement.lean changes only the original `import Mathlib` header to

```lean
import Mathlib.NumberTheory.LSeries.DirichletContinuation
```

Everything from the original module docstring onward is byte-identical. This includes all declarations, proof bodies, and the exact PlattGRH definition. The candidate is uncompiled; it has not been validated as a replacement or measured for performance. No canonical source was modified.

The retained module defines `DirichletCharacter.LFunction`, which occurs in PlattGRH. Its public dependency closure includes `Mathlib.NumberTheory.DirichletCharacter.Basic` supplying IsPrimitive, `Mathlib.Data.Nat.Prime.Defs` supplying Nat.Prime, and `Mathlib.Algebra.Ring.Parity` supplying Odd and Even. All remaining notation and the short case-split proof use basic natural-number/order infrastructure and tactics already imported by these modules. One direct import is therefore a plausible minimum for the unchanged file; compilation is still required to check the complete elaboration environment.

The candidate's all-import graph contains 3585 module names according to the source scanner. Only Mathlib sources are recursively inspected, so this count also includes terminal names from dependencies. It is not an object-size or timing estimate.

## Exact hashes

- Original source: `3f61837d2c3a0dde3a1997f05af21c20c7fe6ee13e29891125495f6947596bf8`.
- Candidate: `17c9aa69b3bbe552f191c8cc152fbab3500ea2a3f1c94dfe542a961757a2d174`.
- Shared body, including module docstring: `89baccad76a5bf1ce76ccbc6eb32821c22efdb0956e0e6ca73f4a2e30b97db4f`.

`prepare_statement_imports.py` reproduces the source candidate. `statement-import-manifest.json` records provider checks. The scanner uses the comment-aware public-import logic from the preceding Eisenstein audit; core Lean import internals are not traversed.

## Immediate CircleMethod needs

CircleMethod currently imports only Statement. Narrowing Statement can therefore expose imports which CircleMethod previously obtained implicitly. The reviewed substantive providers below are all already publicly reachable through DirichletContinuation:

| CircleMethod use | Provider |
|---|---|
| integral_exp_mul_complex | Mathlib.Analysis.SpecialFunctions.Integrals.Basic |
| continuous_tsum | Mathlib.Analysis.Normed.Group.FunctionSeries |
| integral_tsum_of_summable_integral_norm | Mathlib.MeasureTheory.Integral.DominatedConvergence |
| square root estimates | Mathlib.Analysis.Real.Sqrt |
| fun_prop, ring/ring_nf, positivity, linarith/nlinarith, field_simp, push, split_ifs | Corresponding Mathlib.Tactic modules |

The core cast tactics exact_mod_cast and push_cast live in Lean.Elab.Tactic.NormCast in v4.35, not a Mathlib.Tactic.NormCast module. The core provider's availability is left for compilation; the initial tentative nonexistent Mathlib module entry was removed from the delivered manifest. Core omega and ordinary tactic registrations also need the normal consumer compile check.

No additional CircleMethod import has been demonstrated necessary by this source review. This does not assert that the reviewed provider list covers every instance or tactic extension. Compile Statement, then unchanged CircleMethod against the candidate artifact, and inspect any genuinely missing registration before adding an import. Further consumers such as LogDerivL must be checked independently: a Statement-only success is insufficient for landing.

## Validation gate

The integration worker owns scheduling. Required checks are candidate Statement compilation, unchanged CircleMethod and affected consumer compilation, public-type and axiom audit, then matched original/candidate A/B runs if a performance change is proposed. The reported historical CircleMethod baseline of 386.5 seconds is useful context but is not a paired measurement of this candidate. Cold imports and warm filesystem state must not be confused with a source improvement. The lean-elaboration guidance remains in force.
