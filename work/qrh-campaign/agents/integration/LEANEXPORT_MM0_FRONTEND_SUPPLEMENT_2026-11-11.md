# LeanExport is an available front end; MM0 proof translation remains open

2026-11-11. Source inspection only: no exporter invocation, build, generated proof, analytic evaluation or acceptance test. This supplements, without changing, `MM0_ANALYTIC_LIBRARY_ROUTE_DECISION_2026-11-11.md` (SHA256 `DC2110AC1ED3F81D6379D8B19750F147E52D4CBFDDBACA6B2A8E64760D49D5E4`) and its review `zero-sum/REVIEW_MM0_ANALYTIC_LIBRARY_ROUTE_DECISION_2026-11-11.md` (`C512BC128DB2096F57E08678CBD26C54F71ECDAD3D44C569B0B81715B94F4813`).

**Correction of the implementation inventory:** a current Lean4 declaration/proof exporter already exists, including in the installed v4.35.0 source. The missing component is not an initial Lean syntax exporter. It is a compatible, proof-producing translation from those elaborated terms and their typing/conversion obligations into an independently specified MM0 theory, followed by ordinary proof checking and exact root interpretation. Nothing inspected establishes that complete bridge or its cost. The previous note's phrase “contingent on demonstrating that exporter” should therefore mean this semantic MM0 bridge, not the existing NDJSON front end.

## 1. Reusable installed implementation

All line references in this section refer to the local pinned files below. Their upstream counterparts are the official [Lean4 source](https://github.com/leanprover/lean4/tree/v4.35.0/src/LeanExport) and [lean4export repository](https://github.com/leanprover/lean4export). This inspection establishes the local source behavior, not reproducibility of an installed executable.

`LeanExport.lean:11–19` initializes the search path, imports named modules, and accepts selected constant names after `--`. It passes those names to `dumpEnv`. Thus the schematic interface is `leanexport Module ... -- Root ...`; it was not run. With no explicit roots, `Basic.lean:463–472` seeds every non-internal constant. With explicit roots, it traverses those roots. The internal-name filter applies to default seeds, not to needed dependencies.

`Basic.lean:252–305,418–420` follows constants used in both **type and value** for definitions, opaque declarations and theorems. The output includes theorem proof terms, not merely theorem statements. It includes proof-only dependencies. Opaque declarations are not automatically converted to axioms. Axioms instead have their own record, which a downstream policy must inspect. Dependencies of literal infrastructure receive explicit treatment at `:234–244`: `Nat`, and for strings `Char.ofNat`/`String.ofList`, are exported when present. Literal dependencies are not obtained just by finding explicit constant expressions.

This is useful root-specific closure support, but it is not an import-cost elimination. `LeanExport.lean:16` imports the module environment first. `Basic.lean:79–93` scans its constants to build the inductive-to-recursor map before the root traversal. Expression, name, level and declaration caches live across the traversal. `:55` requests an initial expression-map capacity of 10,000,000. That is an implementation allocation hint, not a measured resident-memory figure or a lower bound on the selected proof size.

The closure has explicit failure qualifications. Missing names fail by default; `--ignore-missing` suppresses that failure (`:60,91,253–254,311–313`). Unsafe declarations are skipped unless `--export-unsafe` is set (`:255–256`), including when requested explicitly. A complete certificate must require its roots to be present, resolve every referenced declaration and required builtin package, and reject omitted required declarations. Do not use `--ignore-missing` for acceptance. Exporting unsafe records for diagnosis would not make them acceptable mathematical dependencies. The conditional literal lookup also means successful output alone is not a complete closure validator.

## 2. Compact syntax is not a conversion proof

`Basic.lean:101–115,174–230` shares names, universes and expressions by indices. A natural literal is `{"natVal":"decimal digits"}` (`:186`), and `Parse.lean:237–241` reconstructs `Expr.lit (.natVal n)`. This preserves raw numeral representation rather than serializing a unary successor tree. Applications are serialized as applications: there is no exporter rule evaluating an ordinary power or expanding a modular-squaring trace. Consequently the supplied-root checker plan can retain its symbolic large exponent and bounded modular circuit at the source boundary. Export itself neither forces nor proves a huge ordinary-power computation.

A compact numeral or proof term does not supply an ordinary-MM0 proof of its arithmetic conversions. A Lean proof using reflexivity/`decide` may rely on kernel reduction of large literal arithmetic. The target must either prove those reductions using compact ordinary arithmetic lemmas, or translate the underlying conversion derivation. Treating a serialized numeral, a `rfl` term or a Lean primitive operation as a trusted arithmetic result would change the acceptance rules. This is precisely where the ordinary-PA limb/circuit work may help, once a checked bridge to the chosen target naturals exists.

Metadata is stripped by default; `removeMData` also normalizes the optimization flag on let expressions (`Basic.lean:147–169`). This is intentional syntax normalization, not arbitrary proof simplification. Export with metadata is optional. Do not require recovery of tactic scripts: the terms are already elaborated. Do require their types and conversions to check independently.

## 3. Inductives, recursors, quotients and the reader

`Basic.lean:323–411` emits mutually related inductive types, constructors and recursors together. The recursor map is built from actual `recInfo.all`; recursor types and rule right-hand-side dependencies are traversed. Records retain universe parameters, parameter/index/motive/minor counts, nested/recursive/reflexive flags, constructor metadata, recursor rules and the `k` flag. Constructor/recursor seeds redirect to the associated inductive package (`:413–416`). Quotients receive the complete `Quot/Quot.mk/Quot.lift/Quot.ind` package plus `Eq` (`:308–322`).

These are valuable inputs to a checker, not permission to accept user-supplied recursor equations. The target must validate the inductive package and allowed elimination rules, derive/validate recursors and reduction rules, and implement the exact quotient and proof-irrelevance behavior its chosen foundational specification permits. Nested/mutual inductives, universe constraints, K-like reduction, projections, definitional equality, and the actual axiom closure remain compatibility tests. A Nat/List example in MM0 does not settle these features for the analytic dependency closure.

The installed reader explicitly returns an untrusted constant map rather than extending a Lean environment (`Parse.lean:18–23,520–526`). It rejects missing expression/name/level indices and duplicate index/declaration bindings (`:55–107`); `Json.lean:40–55` rejects duplicate object keys. It reconstructs syntax, including recursor rule bodies (`Parse.lean:416–464`), without checking their logical validity. Moreover `parseMdata` simply consumes the first line (`:511–516`): it does not validate the format/exporter/Lean version. Some record parsers read required fields without enforcing exact key sets. A strict external acceptance reader therefore needs version/schema checks, resource bounds, required-root/closure validation and the subsequent logical checker. Reusing this parser unchanged as an acceptance theorem would be incorrect.

## 4. What the current primary-source search did and did not find

The official exporter provides NDJSON version 3.1.0; installed `Basic.lean:433–451` emits both format/exporter versions and Lean version/git metadata. The prior pinned MM0 source investigation still applies: `examples/lean.mm1` is useful type-theory machinery, while the recorded large-library direction is Metamath to MM0 and outward to Lean3. The current [MM0 overview](https://github.com/digama0/mm0) likewise describes `from-mm` and outward `to-lean`, not a completed Lean4 analytic-library translator.

A bounded primary-source search for `Lean4 MM0 translator` and `lean4export mm0`, followed by repository inspection, found no completed Lean4-to-MM0 bridge. This is a search result, not a proof that none exists. External Lean checkers are not such bridges merely because they read the export. [Lean4Less](https://github.com/Deducteam/Lean4Less) is relevant research: it inserts explicit casts to remove certain definitional equalities. Its README reports proof-irrelevance/K-like work, restricted scalability, aborted large-gcd cases, and an `.olean` output limitation. It does not establish ordinary-MM0 output or compatibility with this installed version. The related [lean2dk](https://github.com/Deducteam/lean2dk) targets Dedukti and describes a restricted example with patches/stubbing; it supplies no MM0 acceptance result. These are candidates to study for conversion techniques, not completed-library credit. The mutable pages were consulted on this date and are not adopted as pinned dependencies.

## 5. Revised implementable boundary and cost ledger

The economical investigation now starts with an **existing front end**, followed by these still-unimplemented or unvalidated gates:

1. Select the exact unchanged root declarations and pin their compiled-source/version inputs. Export their proof closure with the installed matching tool. Validate metadata, closure, root statements and the permitted axiom list; retain every proof dependency. No source theorem is accepted merely because it appeared in a module.
2. Translate the shared expression/declaration DAG into a fixed compatible MM0 foundational specification. Generate ordinary proofs of typing, substitution and each required conversion. Reuse generic lemmas and proven caches, but never substitute a native conversion answer for its proof. Alternatively choose a distinct set/HOL translation with its own demonstrated semantic bridge; do not call it a PA translation without proving that stronger claim.
3. Check the generated proofs and the final interpretation of the root statement. If finite arithmetic uses an ordinary-PA backend, prove its interpretation in the analytic foundation and its prime/bound/endpoint interface. No root, finite-RH or Goldbach hypothesis may be added as a shortcut axiom.

The front end avoids inventing source parsing, tactic replay and declaration extraction. Existing compatible `.olean` files also avoid repeating source elaboration merely to export. Their original generation cost remains in an end-to-end-from-source bill, and missing/incompatible files must be rebuilt in a future authorized task. Import loading, the recursor scan, export traversal, NDJSON bytes/parsing, target typing/conversion proof generation, proof checking and root linkage all remain separate costs. A streaming output format does not imply bounded-memory generation or checking: both reader and exporter retain maps. Root pruning helps output and later proof work but does not remove the initial import closure. Sharding must preserve shared theorem identities and charge library rechecking or an explicitly validated persistent checked context.

The smallest useful future test remains a complete analytic consumer closure exercising its actual universes, reals/complexes, limits or integration, plus a finite arithmetic conclusion. The newly precise unknown is the conversion/typing proof-event and byte expansion of that closure, especially literal arithmetic and recursors—not availability of a Lean4 syntax exporter. Ordinary-rule MM0 implementations with wider indices or checked-context streaming remain eligible on the same conventional implementation-assurance basis as Lean. Adding a native arithmetic/conversion acceptance rule is a separate extension. No speed ratio or complete-proof cost winner follows from this source inspection.

## Local source pins

Base directory: `C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/src/lean/`. SHA256 of files read in full:

| Relative path | SHA256 |
|---|---|
| `LeanExport.lean` | `EC95C53D108C5B014E7A53D6B88A4DBE41DC75C2E55102B2F8211268FCB94CF5` |
| `LeanExport/Basic.lean` | `2E839D4AC1EF1992CFE09C489A97928AD8F8EAEA3925BC76B511C6BF85E1B8AA` |
| `LeanExport/Parse.lean` | `FF46B43893AD39BC8D8B71E2B028B1D7C7065AC11EFBEEA368D1641419F9460E` |
| `LeanExport/Json.lean` | `469B5766E9DDC44E24D4FC72F7C30363F9536551D08A11947698D4AEF2D92AD0` |

The prior decision note retains its immutable MM0 commit/blob inventory. This supplement neither changes that source snapshot nor promotes an unrun export or translator to a checked proof.
