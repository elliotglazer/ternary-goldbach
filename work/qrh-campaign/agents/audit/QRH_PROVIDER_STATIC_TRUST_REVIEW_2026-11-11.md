# Independent review of the QRH provider static trust inventory

2026-11-11. **PASS for the stated prepared-source inventory, with lexer limitations below. No actual export axiom closure, successful elaboration, or mathematical proof validity is established.** No Lean/Lake command, build, dependency change, canonical edit, or frozen-file edit was performed.

## Pins and independently reproduced evidence

Reviewed author report `moebius/QRH_PROVIDER_STATIC_TRUST_AUDIT_2026-11-11.md`, SHA256 `237280059D4E714E89432C4BC574EE42BC136BEAD7797FE5C09F3E48855AF270`; scanner `41BB8A23C440BF95921BA9C971DC83A8CE08CE865E4329E5122C17FA8EBFB303`; receipt `E859AF42B6F5B345DFB52D6E0773580128583FD04FFDFC65685A8D71BCB4F58C`.

I copied the scanner byte-for-byte into this audit directory and ran it there, so its only JSON write was owned by this review. The rerun exited zero and reproduced the entire receipt byte-for-byte, including the same SHA256. Independently of that replay, I reread and SHA256-checked every recorded source file: all 8,742 match. The byte total is 104,674,081. I checked reachability/acyclicity of the recorded graph; there are no cycles. The 2,924 OAI module set equals `integration/qrh-modules.json`; the 19 prepared external module names equal `patched-module-closure.json`. No unresolved import or scanner warning was reported.

The auxiliary lexer/hash-check receipt is `qrh_provider_lexer_review_20261111.json`, SHA256 `16098AAFA911A79A9EA6B4FE9504EEB423C56A01E319788FEDDCCD00543472EE`. It records the observed string-interpolation limitation and the absence of matching constructs in the selected custom source set. The scanner replay is a reproducibility check, not a second independently implemented Lean parser.

The root is the actual `OAI.NumberTheory.DirichletL.Nonvanishing` source, not a challenge or an alternative 23/24 wrapper. The OAI checkout remains the original pinned `4eaee87548250b2682affda7d05d947c05554bae` source. Its declared environment is Lean4.34.1/Mathlib `d13f23b...`; this inventory deliberately resolves its imports against prepared external patches and the Lean4.35/target-Mathlib `56a00585...` source baseline. It is not an inventory of the complete original4.34 dependency environment. Per-file hashes identify the actual prepared bytes even where repository HEAD alone would be insufficient.

## Public statements and internal premise discharge

I read `Nonvanishing.lean` in full. The Dirichlet export has precisely the visible parameters q, `[NeZero q]`, chi, s, `7/8<s.re`, and the principal-pole exception. Its conclusion explicitly uses `_root_.DirichletCharacter.LFunction`. The zeta export has only s and `7/8<s.re`. Neither visible signature has a primitive-character, bounded-height, detector-certificate, finite-zero-list, moment-bound, or QRH premise. There are no section variables in that wrapper. Fully expanded types and inferred instances must still be inspected after elaboration; source spelling is not a substitute.

I also read `Detector/FinalAssemblyUnconditional.lean`, `Detector/FinalAssemblyCertifiedBands.lean`, and `Energy/CertifiedExistence.lean`. The conditional internal `DetectorCertifiedBands` proposition is not silently accepted as a final hypothesis: the unconditional assembly defines `detector_certified_bands : DetectorCertifiedBands` by a proof beginning with its quantified data and applying `terminal_certificate` to explicit parameters. It supplies support, smoothness, fixed-parameter and arithmetic proofs. The public Dirichlet and zeta paths pass this term to the conditional assembly.

The beta hypothesis inside `DetectorCertifiedBands` is an antecedent of the proposition being proved, not a final theorem binder. `CertifiedExistence.certified_bands` is an induction with explicit analytic-successor and floor dependencies; `terminal_certificate` invokes radial transport. This confirms the source-level architecture of discharge. It does not validate the induction's imported analytic lemmas or thousands of other proof bodies.

There is an internal `OAI.SevenEighths.HeckeFamily.LFunction` in `Hecke/IdealBridge.lean`; its existence is legitimate and does not replace the explicitly rooted final Dirichlet conclusion. Actual name resolution and the unqualified zeta name still require elaborated type checks. The result at s=1 uses Mathlib's pointwise zeta convention; no meromorphic-pole removal theorem should be inferred from that spelling.

## Lexer and resolver assessment

The scanner handles nested block comments, line comments, ordinary escaped strings, the inspected raw-string syntax, and character literals while preserving positions. It resolves each discovered import to a unique existing file, fails on ambiguous paths, records unparsed import tokens, and inserts Init except when it detects prelude. These are useful diagnostics. The recorded graph is a recursively resolved source-import graph, not a lemma-level proof graph.

I checked Lean4.35's `Lean/Parser/Module/Syntax.lean`: its header import command takes an optional public/meta prefix, optional all, and one module identifier. The scanner's line-based expression and token splitting are not that parser. It can overaccept invalid syntax and does not prove the validity or exact interpretation of an arbitrary source header. No relevant unresolved or malformed header was observed in the current run. Comments and strings can also contain apparent import text, which is why cleaning matters.

Concrete negative-scan limits:

* Interpolated strings contain Lean expressions. The cleaner removes the whole string, including interpolation bodies; a synthetic `s!"{(by sorry : True)}"` loses the sorry token. This demonstrates a false-negative class, without claiming that this synthetic expression elaborates or occurs in the provider. A raw search found no s!, m!, or f! interpolation candidates in the selected 2,943 custom/prepared-external files. Other registered string syntaxes are not ruled out by that search.
* The finite keyword list is not an exhaustive trust API list. For example, run_cmd is not in WATCH. A supplemental raw search found none in the selected custom modules. Imported elaborators, tactic aliases, quotations, generated declarations, attributes, or future syntax can avoid the listed spellings. Quoted identifiers and token-boundary behavior are not parser-certified.
* The absence of lexer warnings certifies only the lexer's own state. It does not certify all valid Lean lexical forms, source elaboration, or lack of synthetic sorry terms introduced during failed elaboration.
* The package lakefile is not part of the recursive solution-module import closure. It contains run_cmd, unsafe configuration evaluation, and automatic dependency-patch infrastructure. These are outside the claim about 2,943 selected module sources and must not be mistaken for an audited build driver. I read the package options and relevant configuration without executing Lake.

Accordingly, the report's restricted wording—no explicit project-owned escape found among scanned syntax—is defensible. A stronger conclusion such as “the provider is axiom-free” or “all imports contain no untrusted code” is not. The `constant` hits were ordinary mathematical identifiers rather than global axiom declarations; source keyword counts must not be called axiom counts.

## Native/generated axioms and comparator boundary

The report's native trust distinction is correct. I inspected target Lean4.35 `Lean/Meta/Native.lean`: `nativeEqTrue` evaluates a compiled Boolean and then constructs a fresh `Declaration.axiomDecl` for equality to true. Its generated name uses the native tactic/ax suffix. A theorem using that result can therefore depend on a generated axiom even if its source contains no literal axiom declaration. The source explicitly identifies native_decide and bv_decide as consumers. Such a dependency is outside the selected three-axiom allowance.

Conversely, merely importing modules that declare sorryAx, unsafe code or native examples does not make a final theorem depend on them. The decisive check is the actual transitive dependency set of each elaborated export and its proof. It must reject every non-allowlisted axiom, not just recognizable native names. This also catches generated axioms with unexpected naming conventions.

I read the challenge and comparator JSON. The challenge's sorry theorem is a separate specification; its module is absent from the solution inventory. The comparator selects the Dirichlet export and permits only propext, Quot.sound and Classical.choice. It does not select the zeta corollary and has `enable_nanoda=false`. Thus neither zeta trust validation nor an independent proof-object check follows from this configuration. Challenge and solution environments must remain separated.

## Required next evidence

The next gate remains a successful isolated target-version compilation with pinned source, package options and artifacts, followed by exact elaborated-type and transitive-axiom checks for both public exports and the assembly. Preserve `autoImplicit=false`; retain every compatibility edit and reject mixed-version/stale artifacts, errors and synthetic admissions. The original4.34 environment cannot be described as checked by this4.35 source traversal. A comparator run and any required independent kernel check are additional evidence, not consequences of the static receipt.

The current review found no blocking discrepancy in the inventory, final visible binder contract, or supplied internal premise at this limited scope. It leaves all mathematical correctness, compatibility, compilation and actual proof-term trust gates open. No new analytic or detector premise may be added to the final Goldbach theorem to bypass those gates.
