# Import-only EisensteinCoordinates candidate

The candidate in this directory retains the original file byte for byte from `namespace OAI` onward. Only the import header is replaced. It has not been compiled, and no performance result is claimed.

The original source is `work/openai-math/lean/OAI/NumberTheory/DirichletL/Arithmetic/EisensteinCoordinates.lean` at the campaign's pinned openai/math commit `4eaee87548250b2682affda7d05d947c05554bae`. The candidate is prepared against the existing Mathlib v4.35.0 checkout. The lean-elaboration skill was read before this import audit. No proof body, binder, declaration, tactic, or option was edited.

The proposed direct imports are

```lean
import Mathlib.NumberTheory.NumberField.Cyclotomic.PID
import Mathlib.NumberTheory.LSeries.Nonvanishing
import Mathlib.Analysis.Complex.HalfPlane
```

`Cyclotomic.PID` directly supplies `IsCyclotomicExtension.Rat.three_pid`. Its public dependencies provide the cyclotomic field, ring of integers, and principal ideal ring structures used by `eisenstein_ring_pid`.

`LSeries.Nonvanishing` directly supplies `DirichletCharacter.LFunction_ne_zero_of_one_le_re`. Its public dependency graph also reaches the exact providers below.

| Declarations used by this leaf | Provider reached through public imports |
| --- | --- |
| `ArithmeticFunction.moebius_mul_coe_zeta` and divisor convolution | `NumberTheory.ArithmeticFunction.Moebius` |
| `gaussSum`, shift identities, trivial-character sums | `NumberTheory.GaussSum` |
| `AnalyticOnNhd.eqOn_of_preconnected_of_eventuallyEq` | `Analysis.Analytic.Uniqueness` |
| Analytic products, subtraction, identity and constants | `Analysis.Analytic.Constructions` and its public imports |
| `convex_halfSpace_re_gt` | `Analysis.Complex.Convex` |
| `Real.sqrt_pos` | `Analysis.Real.Sqrt` |
| Ordered finite-sum comparisons | `Algebra.Order.BigOperators.Group.Finset` |
| `field_simp`, `linarith`, `nlinarith`, `norm_num`, `positivity`, `ring`, `ring_nf`, `group`, `gcongr` | The respective `Mathlib.Tactic` modules listed in the manifest |

`Complex.HalfPlane` directly supplies `Complex.isOpen_re_gt`, used in `zero_free_of_analytic_identity`. It is absent from the public import closure of the other two retained roots, so it remains explicit.

Basic complex norms, multiplicative/additive characters, units, finite sums, and finite-field instances are already available through the retained providers. No file-specific theorem from the removed Fourier, measure-theory, manifold, Fredholm, distribution, or smoothing imports was identified in the body. This is a static symbol and public-dependency review. Compilation must still detect omitted instances, tactic registrations, or changes in exported APIs.

The original header has 180 direct imports. The candidate has 3. The scanner finds 4023 reachable module names for the original header and 3827 for the candidate when following all import edges. Thus the proposed change removes 196 reachable names. These counts include imported non-Mathlib module names when the scanner reaches them, but only Mathlib source files are recursively read. Direct-import counts alone substantially overstate the potential load reduction.

`prepare_eisenstein_imports.py` reproduces the candidate and `import-manifest.json`. It strips nested block comments and line comments before scanning imports, distinguishes public imports in files using the module system, and preserves all imported declarations for legacy files. The original first scanner pass included commented examples; the delivered manifest comes from the corrected scanner. The corrected pass changed dependency counts and preserved the same three-import candidate.

SHA256 values are

- Original source `a97237026d0add0b1e1f6a3a025a253a9e6dd17c0e06929f779772727f02260b`.
- Candidate `7a9e677b2abd33b80be2278b202895e94a11c71a49b81da72314fd8e1d05091b`.
- Shared body starting with `namespace OAI`, `6a659f2c2a18dbb4197b99f8811ebecc2aa4bbe204bc21433213398d960a1ab6`.

The Python assertion confirms exact body byte equality. Source and candidate paths are distinct, and the original remains unmodified. Required next checks are an original-file v4.35 baseline, candidate compilation, identical public statements and axiom audits, and matched A/B profiling. If relying on wall time, use at least three runs each under the same single-compiler conditions. The integration worker owns scheduling. This candidate is not accepted as a performance change until those checks pass.
