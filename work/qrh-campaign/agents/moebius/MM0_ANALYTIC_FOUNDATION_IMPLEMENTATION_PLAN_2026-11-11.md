# A bounded implementation route for the full MM0 foundation

2026-11-11. Source and architecture research only. No exporter, evaluator, Lean/MM0 build or generated proof was run. No existing artifact was changed. The proposed tests below are mathematical specifications for future work, not new approved Lean declarations or verified translations.

The lowest-rewriting candidate remains a compatible dependent type theory encoded in MM0, with proof-producing translation of the actual Lean proof closure. The existing LeanExport front end makes this a more concrete investigation than building an extractor. It does not settle the missing semantic translator, its compatibility or its cost. There is no demonstrated lowest-development-cost complete route yet. Ordinary PA certificates solve part of the finite work and must be joined to the chosen analytic foundation by proofs.

## 1. What is already reusable

The reviewed route decision and its LeanExport supplement establish distinct facts. The pinned MM0 repository contains examples for arithmetic, set theory, HOL and dependent type theory. Its demonstrated library path is filtered Metamath to MM0, with an outward Lean3 example. That is real import evidence, but not a Lean4 analytic-library translator. In particular the importer can retain source axioms and incomplete proofs; its output needs a foundational audit. The small dependent-type example does not establish support for the whole Lean4 language used here.

The installed LeanExport implementation already traverses dependencies in declaration types and proof bodies. Explicit roots restrict the traversal after importing their environments. It shares expressions and preserves numeral literals. The reader reconstructs an untrusted constant map, not a validated environment. Default-safe export is not a proof that all required declarations appeared. Root presence, referenced declarations, builtin packages, format version and safe status need independent checks.

These points remove two unnecessary projects: source-level tactic replay and a fresh Lean syntax extractor. They do not remove import loading, compatible compiled dependencies, proof-term conversion, inductive validation or final statement interpretation. A previously built compatible `.olean` avoids repeated elaboration for an export session; its original production remains in an end-to-end-from-source cost account.

The old `FORECAST.md` arithmetic benchmark is explicitly schematic: table/lifting facts are axioms and its accepted target is `ok`. Neither that benchmark nor a paper-reviewed finite checker supplies the analytic library. The current compute blueprint also has unfinished mathematical adapters and actual finite certificate tasks. Translation cannot complete those missing proofs.

## 2. Fix the target logic before generating a large proof

The target specification must be independent of Goldbach, RH, QRH and the numerical results. A compatible type-theoretic route needs the actual used rules for universes, dependent products, lambda/application, local contexts, let expressions, equality, conversion, proof irrelevance, inductives and quotient operations. Universe `max`/`imax`, impredicative `Prop`, mutual/nested inductives, permitted eliminations and recursor computation are compatibility obligations, not details to delegate to untrusted exported metadata. Every other conversion feature encountered in the closure must receive a rule or a derived proof before acceptance.

An explicit standard axiom policy could allow the ordinary Lean principles actually required, such as propositional extensionality, classical choice and quotient soundness. This is a proposed policy to review, not a finding that these are the complete axioms of the selected roots. The actual closure must reject `sorryAx`, unsupported/custom result axioms and any native-result shortcut. Generated recursors cannot be admitted merely because the exporter labels them recursors. Their types and computation rules must follow from the accepted inductive package rules. Preserve the source meaning of all data definitions.

The external translator may be complicated and untrusted. It must emit ordinary target proofs whose premises the MM0 checker has already accepted. No rule may say that Lean accepted a term, a hash matched a theorem, or a native computation returned true. Conventional implementation assurance for the chosen checker is a separate issue; this plan does not demand a formal verification of the MM0 executable while granting Lean's executable an unequal exemption.

An alternative ZFC/HOL library import remains worth comparing if it has substantially more ready analysis. It must still supply this project's exact functions, measures, normalization, multiplicity and explicit estimates, or prove representation bridges. PA alone requires a proof-specific reduction of the analytic argument that has not been provided. An arithmetical final conclusion is not a proof of such a reduction.

## 3. Two small, complete translation tests

The first test should use the actual `Complex.exp_bound'` at Mathlib `Analysis/Complex/Exponential.lean:407`. For complex `z` and natural `n`, under `norm(z)/(n+1) <= 1/2`, it bounds the error after the first `n` exponential-series terms by `2*norm(z)^n/n!`. Its body rewrites the exponential as a Cauchy-sequence limit, transports norm/addition through limits, bounds the finite tail, uses factorial growth, and sums a geometric bound. Thus exporting its complete dependency closure tests actual real/complex construction and limits rather than a theorem about a new uninterpreted `exp`.

Join it to an independently ordinary-checked finite proof of `16! > 2^44`. The resulting proposed test conclusion is, for every complex `z` with `norm(z) <= 4`,

`norm(exp(z) - sum_{m=0}^{15} z^m/m!) < 2^(-11)`.

Indeed `4/17 < 1/2`, and the source bound is at most `2*4^16/16! < 2^33/2^44`. This tests the arithmetic-to-analysis interface: natural factorial, casts into reals/complexes, ordered-field division and the exact finite sum. No complex numerical evaluation is needed. Importing this conclusion as an axiom, or replacing the source exponential by a finite polynomial, fails the test. A source constant named `exp_bound'` with no translated proof also fails it.

The second test is the actual `TernaryGoldbach.Explicit.differentiableAt_G` at `Explicit/GMellin.lean:67`. Its conclusion is complex differentiability of `s ↦ Gr s δ 0` for every real `δ` and complex `s` with `-2 < Re(s)`. Lines 19–23 define the true oscillatory Gaussian integrand and identify its Mellin integral with `Gr`. Lines 26–64 establish its norm, continuity and the two endpoint bounds. Lines 69–73 invoke `mellin_differentiableAt_of_isBigO_rpow_exp` with `a=1,b=-2`, local integrability, and those bounds. This adds measures/integration, filters, asymptotic predicates and differentiability to the tested language/library fragment. The theorem at line 85, `norm_G_le_strip`, is a later test of the quantitative contour estimate; it is not silently included in the second test's result.

Neither test's transitive proof closure or actual axiom closure was exported in this task. Neither has a predicted small byte count merely because its final statement is short. Failure to support a required quotient/recursor/conversion feature is useful evidence before committing to the entire analytic library.

## 4. Avoid exporting expensive numerical proof bodies when an exact replacement is available

A theorem can have two ordinary proof providers in the same target theory. Keep its exact translated type, implicit parameters, universes and context; either translate the source proof or independently derive that type using the finite arithmetic backend. The latter can avoid enormous literal-reduction proofs generated by source `rfl`/`decide`. This is a proof replacement, never an assumption replacement.

For example the source `SmallMuPhi` prefix bounds could eventually be supplied by a checked finite squarefree/phi computation that proves the identical translated prefix theorem. This does not license treating a source hash or an old Lean result as the proof. It also does not authorize changing `phiTD`, the sum, the endpoint, or a data definition used by reduction. Only genuinely opaque propositional theorem boundaries should be used initially. Any dependent use and proof-irrelevance conversion must be supported by the chosen target rules. Retain every proof-only dependency still used elsewhere; prune a source proof branch only after its replacement type has been proved.

If finite certificates are produced in a separate PA signature, establish a proof translation into the analytic theory's naturals. Prove each PA axiom/rule interpretation and the representations of integers, rationals, bit arrays, finite sums and primality. Then translate each finite derivation. A blanket new axiom asserting soundness of the PA checker is not the required interface. Alternatively implement the arithmetic proof library directly on the analytic target's naturals and avoid the two-signature bridge.

This option lets arithmetic generation/checking compete fairly with kernel conversion without rewriting the surrounding analytic mathematics. Its benefit is an empirical future question: compare ordinary proof events and bytes for a real shared numerical theorem, including the bridge and repeated uses. No benefit is credited in the present cost inventory.

## 5. Full-proof dependency and cost boundary

| Layer | Required accepted object | Cost and unfinished work that remain |
|---|---|---|
| Foundation | Reviewed MM0 specification and ordinary typing/conversion library | Used Lean features, inductive/quotient validation, exact axiom policy |
| General analysis | Translated true real/complex, topology, measure/integration and analytic-function proofs | Complete proof closures, shared declaration context, conversion evidence |
| Goldbach analysis | Actual selected smoothing, zero-count, major/minor-arc and finite-to-global theorems | Paper-level adapters still require proofs; source imports alone do not discharge them |
| Finite spectral evidence | Certificates for exact functions, contours, closed heights and multiplicities, with analytic checker soundness | Actual generation, successful margins, all panels, arithmetic and interval proofs |
| Finite additive evidence | Source primes, anchor/order proofs, binary coverage and chain or uniform-gap alternative | Every exception, endpoint, cache proof and complete coverage composition |
| Final theorem | An ordinary proof of the original ternary conclusion with its exact range and finite join | No final BinaryGoldbachInput, RH, QRH or checker-result premise may remain |

The original finite-RH route in the current blueprint avoids exporting an optional global QRH provider. Its own explicit analytic argument and finite-RH certificates remain substantial. The uniform-gap competitor additionally requires its higher principal-height and gap-analysis proofs. A selected route must be costed with its actual dependency union, not all alternatives added together or a discarded alternative's cheap component substituted into it.

For each test or route, separate source elaboration and missing adapters, environment import, export traversal/bytes, target proof generation, target checking, certificate production, and final linkage. Record unique shared declarations, term DAG nodes, conversion proof events, arithmetic widths, proof bytes and peak live context. A source line count or `.olean` size does not determine these quantities. Count imported theorem proof verification once only when a previously checked ordinary context is genuinely retained. A fresh standalone checker must replay the needed prefix or use a separately justified checked-context mechanism. Hash references and proposed streaming alone provide no import theorem.

The first development decision is therefore conditional. Implement the fixed logic and the first exact analytic test before scaling the translator; then use the second test to expose measure-theory costs. Compare that measured implementation burden and proof expansion with a bounded inventory of missing theorems in an available set/HOL library. Do not declare an overall winner from an arithmetic microbenchmark, and do not extrapolate a completion date from these two tests.

## Source ledger and limits

Whole-file SHA256 pins, rechecked for the current report:

| File | SHA256 |
|---|---|
| `integration/MM0_ANALYTIC_LIBRARY_ROUTE_DECISION_2026-11-11.md` | `DC2110AC1ED3F81D6379D8B19750F147E52D4CBFDDBACA6B2A8E64760D49D5E4` |
| `zero-sum/REVIEW_MM0_ANALYTIC_LIBRARY_ROUTE_DECISION_2026-11-11.md` | `C512BC128DB2096F57E08678CBD26C54F71ECDAD3D44C569B0B81715B94F4813` |
| `integration/LEANEXPORT_MM0_FRONTEND_SUPPLEMENT_2026-11-11.md` | `A04AFAEE338B6AF96E0E98422266B67E199A2CD78AE66FF160E89C77C8D96885` |
| `work/qrh-blueprint/CURRENT_COMPUTE_BLUEPRINT_2026-11-11.md` | `8FEAC3536CCD7F521CD7BBD3B4986E1E7B9DAF289CA25273F466D5124A21DBDB` |
| `work/qrh-blueprint/CURRENT_COMPUTE_BLUEPRINT_SCOPE_ADDENDUM_2026-11-11.md` | `3A9EDE78304E2196ED71437683B74C061637EABDF4047810DB4F5D29D024AA1A` |
| Mathlib `Analysis/Complex/Exponential.lean` | `564992EF54C295F97D4E00CA0D07A396C068F331D09EFD29B85E4863511986F0` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/GMellin.lean` | `B35DEB66E13608081839069DDCF4368E6FF6CF680D2B04B8F7871662399EAABB` |

The first three paths are relative to `work/qrh-campaign/agents/`. Mathlib is the inspected local tree under `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/`, pinned in the campaign to commit `56a005855ea17e0b0958f73ec801ae140b0a1679`. The source bodies newly read were `Exponential.lean:407–441` and `GMellin.lean:1–89`. The full prior source/export reports were read; their MM0 repository claims retain their own primary-source pins and review scope. No new claim about every available external translator follows from this bounded inventory.

Concrete unresolved questions are the exact target logic's completeness for these closures, whether ordinary conversion proofs remain manageable, the cost of shared-context reuse, the PA-to-analysis interface, and completion of the actual mathematical and finite-certificate inputs. None is answered by better seed arithmetic alone.
