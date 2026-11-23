# Review of the MM0 analytic-foundation implementation plan

2026-11-11. PASS at conditional architecture and source-research scope. No author correction required. This verdict does not validate an MM0 encoding of Lean, a translator, an exported closure, or a cost estimate. No export, build, analytic evaluation or implementation was run.

Reviewed `moebius/MM0_ANALYTIC_FOUNDATION_IMPLEMENTATION_PLAN_2026-11-11.md`, SHA256 `5B84A49945FCF62C52F1B52574E9F1D783CBF7A9DE7D259435AC7252F006415C`. The author artifact is unchanged.

## 1. Proof replacement preserves the theory under the stated restrictions

The proposed substitution is valid when its target is an opaque propositional theorem, not an arbitrary declaration. More explicitly, fix the accepted target theory and translated context, including its data definitions, universes and parameter order. Suppose a source theorem constant has translated type P in that context. An independently checked target proof of that exact P may supply the theorem constant instead of translating its original proof body. Consumers still refer to the same typed constant. No assumption P has been added to the trusted theory: its new proof must precede its use.

For polymorphic or parameterized theorems, the replacement must derive the complete quantified type, not only one convenient instance. Any required type conversion must itself be justified by the target's accepted rules. Equality of printed theorem names or mathematical equivalence of propositions is insufficient.

Dependent uses of the proof are not a reason to waive this requirement. The plan explicitly requires compatible proof irrelevance and conversion. Under those rules two inhabitants of the same Prop can be exchanged in dependent uses; any required transport remains an ordinary target derivation. This does not permit changing a Type-valued opaque constant, a data definition used by reduction, or the consumer's interpretation of naturals, factorials, finite sums or primality. Initial restriction to genuinely opaque Prop boundaries is therefore appropriate.

The replacement proof must have an allowed axiom closure and well-founded dependency order. A proposed replacement cannot use the theorem being replaced, directly or through a cycle. Proof-only dependencies of the original body may be omitted only when no remaining declaration uses them through its type or value and the replacement has already been proved. These are explicit consequences of the author's same-type, checked-premises and retained-dependency requirements, not additional permission to prune by name.

Thus the replacement can reduce proof-generation work while preserving the exact theory and statement. The report does not establish that the particular SmallMuPhi theorem already has such an alternative proof, nor does it give a measured size reduction. Its PA option likewise requires an interpretation of each used axiom/rule and the concrete arithmetic representations. Translating a particular finite PA derivation by induction does not require importing an unproved global PA-soundness assertion.

## 2. The exponential test is genuine and its scalar conclusion is correct

I read the actual Mathlib `Analysis/Complex/Exponential.lean:407–441`. `Complex.exp_bound'` has hypothesis `norm(x)/n.succ <= 1/2` and conclusion

    norm(exp(x) - sum_(m<n) x^m/m!) <= norm(x)^n/n! * 2.

The body rewrites the actual complex exponential and finite sum through Cauchy-sequence limits, transports negation/addition/norm through those limits, and applies a finite tail comparison. It uses `Nat.factorial_mul_pow_le_factorial` and a geometric sum. The author's characterization of the source mechanism is accurate.

At n=16 and norm(z)<=4, the condition follows from 4/17<1/2. The right side is at most 2*4^16/16!. The proposed independent finite proof of 16!>2^44 therefore gives a strict bound below2^-11, with exactly sixteen terms indexed0 through15. Factorial casts, positivity of denominators and natural-to-real/complex interpretations must be proved in the target. The author includes these in the intended arithmetic join; the test does not get them merely from a PA receipt.

This is a useful initial test because accepting only the theorem statement, an uninterpreted exponential, or a finite polynomial masquerading as exp would fail its stated criteria. Its full closure should exercise actual real/complex constructions and limit reasoning. The closure has not been exported, however, so this review does not claim an exact feature inventory, axiom set or small proof size.

## 3. The Mellin test preserves its actual function and domains

I read `TernaryGoldbach/Explicit/GMellin.lean:1–89`. Lines19–23 define

    f_delta(t)=t^2 exp(-t^2/2) exp(2*pi*i*delta*t)

and identify its Mellin integral with `Gr s delta 0`. The norm identity removes only the unit-modulus oscillatory factor. The subsequent source establishes continuity, exponential decay at infinity, and the order-two bound at the positive-side zero endpoint.

At lines67–73, `differentiableAt_G` takes every real delta and complex s with -2<Re(s), applies `mellin_differentiableAt_of_isBigO_rpow_exp` with a=1 and b=-2, supplies local integrability from continuity, then rewrites the actual Mellin integral. There is no extra bounded-delta premise and no quantitative contour estimate in this result. The author correctly separates the later `norm_G_le_strip` at line85.

This second test adds measure/integration, filters, asymptotic predicates and complex differentiability to the first test. It is representative of an important additional part of this project's analysis, not a proof that every later Fourier, contour, zero-divisor or Turing dependency is supported. A translation must also preserve the actual `Gr` definition and the identity used to identify the integral; a newly axiomatized function with the same notation would not pass.

## 4. Front end, target logic and unfinished work

I read the prior route decision/review and LeanExport supplement. I also inspected installed `LeanExport/Basic.lean:252–305` and `Parse.lean:18–23`. The exporter separately traverses type and value for definitions, opaque declarations and theorems; axioms receive their own records. The reader explicitly constructs an untrusted map, not a validated Lean environment. These source facts support using the existing extractor while retaining the missing semantic translation and closure checks.

The author does not promote the old set.mm-to-MM0-to-Lean3 example to a Lean4 analytic exporter. Its proposed target rules include the difficult compatibility points: universes and max/imax, Prop, proof irrelevance, inductive packages and elimination, recursors, quotient operations and every encountered conversion feature. The allowed standard axioms are a proposed policy, not a computed closure. `sorryAx`, custom result axioms and native-result shortcuts remain excluded. Those distinctions are necessary and are stated honestly.

The plan's two tests are a staged development experiment. Passing them would validate only the translated statements, their complete checked closures, and the exercised target rules. It would not prove target consistency, full Lean4 compatibility, correct translation of unsupported constructs, or successful generation of the missing mathematical and finite certificates. The report retains these boundaries.

The cost discussion also separates development from execution. Existing compatible compiled dependencies avoid repeating elaboration during an export session but do not erase their original production cost. Export traversal, proof conversion, numeral reductions, serialization, ordinary target checking, arithmetic interpretation and final statement linkage remain charged. Shared-context reuse is conditional on retaining checked context; hashes alone do not authorize skipping proof prefixes. No Lean/MM0 ratio or completion forecast follows.

## 5. Pins and validation limits

All seven entries in the author's source ledger match the inspected files, including both mutable blueprint snapshots at their quoted hashes. The two newly inspected analytic source files match:

| Source | SHA256 |
|---|---|
| Mathlib Analysis/Complex/Exponential.lean | 564992EF54C295F97D4E00CA0D07A396C068F331D09EFD29B85E4863511986F0 |
| work/ternary-goldbach/TernaryGoldbach/Explicit/GMellin.lean | B35DEB66E13608081839069DDCF4368E6FF6CF680D2B04B8F7871662399EAABB |
| Installed LeanExport/Basic.lean | 2E839D4AC1EF1992CFE09C489A97928AD8F8EAEA3925BC76B511C6BF85E1B8AA |
| Installed LeanExport/Parse.lean | FF46B43893AD39BC8D8B71E2B028B1D7C7065AC11EFBEEA368D1641419F9460E |

Mathlib here is the inspected cache under `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/`; the exporter is installed Lean4 v4.35.0 source. Reading both does not establish that those versions and the project's compiled dependencies form a compatible export environment. The author's future version/closure gate remains required.

This is a source/paper review. No `#print axioms`, compilation, export, target proof check or full transitive dependency audit was performed. Those omissions prevent implementation acceptance but do not undermine the conditional architecture or the two source-faithful test specifications reviewed here.
