# An honest route for the analytic library in MM0

2026-11-11. Source research only. No build, translation, declaration, proof export, numerical evaluation or acceptance test was performed. This note does not choose a new foundational axiom list for the project.

**Decision:** retain ordinary-PA arithmetic as a reusable component, but do not make PA the assumed foundation of the entire analytic proof. For preserving the existing Lean development, the first candidate to investigate is proof-producing export of its actual dependency closure into an explicitly specified compatible type theory in MM0. This minimizes intended mathematical rewriting, not necessarily CPU cost. It is not implemented or validated by the sources inspected here. The strongest existing library-import evidence instead concerns `set.mm` into MM0; that supports a distinct set-theoretic port, not a free import of this Lean library. There is presently no evidenced lowest-time complete route.

## What can actually be reused

MM0 is not intrinsically PA. Its specification separates supplied axioms and theorem statements from proof input; the pinned project overview explicitly permits PA, ZFC or HOL. Thus changing from a PA arithmetic experiment to an established stronger foundation is a foundational design decision, not a native-arithmetic shortcut. It still requires an exact reviewed specification and ordinary proofs, with no Goldbach/provider/certificate-result axiom. [Pinned overview](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/README.md#L28-L46).

| Source evidence inspected | What it establishes | What it does not establish |
|---|---|---|
| `examples/peano.mm1`, existing digit/arithmetic reviews | Ordinary arithmetic proof bodies and candidate finite-certificate machinery | A PA interpretation of this real/complex analytic proof |
| `examples/set.mm0:59–85`; `set.mm1:71–105` | Concrete set-theoretic axiom/class interface and some core proof bodies | An entire analytic library in this small example |
| `mm0-hs` importer and recorded `set.mm` example | Proof-producing import path with dependency filtering | Clean foundational closure or every theorem needed here |
| `examples/hol.mm0`, `hol.mm1` | HOL-style core with equality, abstraction, choice, infinity and proved core lemmas | The project's analytic results or a Lean4-to-HOL translation |
| `examples/lean.mm1` | Explicit universe, typing, substitution, conversion and recursor machinery, with Nat/List examples | A compatible exporter for all features used by current Lean4/Mathlib |

The importer is substantive source: `FromMM.hs:69–91` chooses named dependency closures and emits specifications/proofs; `Closure.hs:10–46` recursively includes hypotheses, expressions and proof references. But `FromMM.hs:216–225` emits an axiom when the source assertion lacks a proof, `:393` preserves `PSorry`, and `:421–422` leaves definition conversion as a TODO. An import therefore requires an exact axiom/definition audit and rejection of incomplete proofs; the tool name is not such an audit. [Importer](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/mm0-hs/src/MM0/FromMM.hs#L69-L91), [closure traversal](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/mm0-hs/src/MM0/FromMM/Closure.hs#L10-L46).

The recorded demonstration is specifically `set.mm → MM0 → Lean3`, filtered to `dirith,elnnne0`. Its postprocessor connects the translated Dirichlet theorem to a native Lean prime statement at `post.lean:473–498`. This is useful evidence of both library reuse and the nontrivial semantic bridge. It is not the reverse direction or a current Lean4 compatibility result. [Demonstration and commands](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/mm0-lean/README.md#L9-L20), [actual postprocessing](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/mm0-lean/mm0/set/post.lean#L473-L498).

The HOL core has actual proof bodies, for example choice/excluded-middle consequences in `hol.mm1:394–410`; it is not only a list of desired theorems. A separately discovered HOL Zero/Common HOL importer advertises work in progress targeting Flyspeck. I did not pin or validate that separate tool or import an analytic corpus, so it receives no completed-library credit here. [Pinned HOL interface](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/examples/hol.mm0), [core proofs](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/examples/hol.mm1#L394-L410), [separate project status](https://github.com/digama0/hz-to-mm0).

`examples/lean.mm1:514–624` contains real recursor/conversion examples, but neither that fact nor the filename establishes full Lean support. The separate `mm0-lean4/MM0/Basic.lean` starts with axiomatized compiler/machine infrastructure; it is not the missing analytic-library exporter. [Type-theory example](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/examples/lean.mm1#L514-L624), [Lean4 file](https://github.com/digama0/mm0/blob/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/mm0-lean4/MM0/Basic.lean#L1-L68).

## Three complete-proof choices

**PA throughout.** Keep the finite arithmetic proofs, but supply a proof-specific reduction/reformalization of every required analytic implication into PA, including the unbounded conclusion. Coding rational approximations is not by itself such a reduction. Quantification over functions, limits, completeness, integration, choice and analytic continuation must be eliminated or justified at the exact strength actually used. No such translation was found in the inspected campaign/toolchain sources. The conclusion being arithmetical does not imply that an arbitrary proof of it has a PA translation. This is an open mathematical/formal-development project, not a missing compiler flag; no universal conservativity claim is warranted.

**Matching type theory with proof-producing Lean export.** Preserve the existing analytic proofs rather than translating their mathematics by hand. Export elaborated declarations and their real transitive proof dependencies, including implicit arguments and conversion evidence. Establish support for the exact universe rules, inductive/recursor forms, quotients, proof irrelevance and used axioms such as propositional extensionality/choice; do not infer compatibility from Nat/List examples. Freeze the foundational rules independently of the target theorem. Reject every unmatched primitive, opaque theorem without its proof, unsupported axiom or unresolved source hole. Generic conversion lemmas and expression sharing can reduce expansion, but the resulting ordinary-MM0 proof must justify each step. This is the preferred *development-risk investigation* for reusing the current library, contingent on demonstrating that exporter. It is not a claim that its proof volume or checking time beats a port.

**ZFC or HOL library plus a port.** Import a filtered, axiom-audited library using the demonstrated or separately validated translation path. Match actual statements and definitions for reals, complexes, integration/Fourier transforms, Dirichlet L-functions, zero multiplicity and the selected explicit inequalities. Existing basic analysis or Dirichlet's theorem is not a substitute for those exact results. Prove missing mathematics and all representation bridges. This avoids first proving an unnecessary PA reduction, but incurs potentially large port development. Neither the small ZFC/HOL examples nor the old Dirichlet demonstration establishes that this project's remaining library is complete. One must compare that missing-proof list against the matching-type-theory exporter work before choosing.

## Joining the arithmetic without a new axiom

In the chosen analytic foundation, define the intended naturals and arithmetic, prove the interpretation of the used PA axioms/rules, and translate each finite arithmetic derivation by those proved templates. Alternatively implement the same digit/certificate lemmas directly over that foundation's naturals. This is a concrete derivation translation, not an assumption that a string naming a PA theorem is true, and not an internal global reflection principle for PA.

Then prove the precise bridge for prime, divisibility, finite lists, bounds and certificate outputs. The arithmetic batch conclusions must become the actual hypotheses of the analytic consumer, with identical integer constants and inclusive endpoints. Two separately checked files using unrelated meanings of “Nat” and “prime” do not compose automatically. Retaining arithmetic proofs in PA remains useful even when the final result is stated in ZFC/HOL/type theory; it does not make that final result a PA theorem.

Use one audited foundation and complete proof dependency context for final acceptance. An untrusted linker may share libraries and remap identifiers. It may not import analytic conclusions, finite-RH data, prime batches or shard success labels as fresh axioms. A hybrid Lean analytic proof plus separate MM0 arithmetic checks is a different artifact until its bridge is checked; it must not be reported as a complete MM0 proof.

## Cost ledger and the smallest decision gate

Separate **development work** (foundation/rule audit, exporter or port, semantic bridges, missing mathematics) from **compilation/generation work** (source elaboration if needed, dependency extraction, conversion expansion, proof construction, serialization/linking). Separately charge **acceptance** (foundation/library proof checking, concrete arithmetic proofs, import I/O and root assembly), plus proof bytes, resident expression/statement storage and repeated shard checking. A preexisting library can lower development while still producing large proof-generation and checking costs. A source-to-source port can have the reverse profile. No universal Lean/MM0 multiplier follows.

The next useful source/implementation gate is one representative analytic consumer with its entire dependency closure, not an isolated arithmetic lemma: it should exercise the chosen real/complex representation, an infinite limit or integral, and a finite arithmetic bound consumed through the natural-number bridge. Record unsupported rules and missing library statements before implementing a broad translator. Later, when authorized, produce and ordinarily check that complete slice, including exact root statement/axiom manifest and false-input controls. Only then extrapolate proof-generation or checking costs by measured dependency/term classes. Do not translate unused Mathlib or all of `set.mm` by default; prune by proved dependencies while retaining definitions and conversion dependencies.

Faithful widened/streaming ordinary-MM0 implementations remain eligible, with the same implementation-assurance standard used for Lean. A new reflection/native acceptance rule is a separate proposal with its own soundness obligation. Neither removes the need to translate or prove the analytic statements.

## Pinned source inventory

The MM0 source commit inspected is `0d414c0bfdaaeb7fea571895127abc1fa5a3d956`. Source URLs above use that immutable commit. Git blob identifiers below come from the stored recursive tree; they are **Git blob IDs, not SHA256 file digests**. Web line displays are zero-based; linked source line references in this note are one-based.

| Path in that repository | Git blob |
|---|---|
| `examples/set.mm0` | `13d0f5f1b1f237032a6fd215ed7d583f742b222d` |
| `examples/set.mm1` | `e72c734feab40ef474a13a9d5118482b91880b73` |
| `examples/hol.mm0` | `e8ce518e20af56864a10de274232786f3dce2108` |
| `examples/hol.mm1` | `511223ba723d5a7990fb1129bc8e49d8cf1de749` |
| `examples/lean.mm1` | `df6e45a3579579bd0cb7e8d12dd15b06534190e4` |
| `mm0-hs/README.md` | `636c69428ac68e00cc686762a42af7cc81f5779f` |
| `mm0-hs/src/MM0/FromMM.hs` | `4309ba69fe3348db62a812d5c8dee235417440f6` |
| `mm0-hs/src/MM0/FromMM/Closure.hs` | `f76be795ccd005fb1b10d357467fb7f8ed0c38a4` |
| `mm0-lean/README.md` | `a283a52cb093d2fa76d6cb606edae0f69dfc8727` |
| `mm0-lean/mm0/set/post.lean` | `93446d7bc18d5afa08d6394808e52575eb51b857` |
| `mm0-lean4/MM0/Basic.lean` | `1ed1a653826abbd6b2876ca3d840cbc68d8eecfc` |

Local evidence: `work/mm0-efficient/toolchain-sources/tree.json` SHA256 `696C3A071FF79189294EF99EC1C5CA80FA864C4667DBDD2783BC2CF199122DC5`; its `README.md` SHA256 `A62A362B425E74CDFA0881C74A5CA08ADC7951876D770757B6A2F9F6D5994E46`; `work/qrh-blueprint/COMPUTE_FIRST_RESEARCH_AGENDA_2026-11-11.md` SHA256 `06F28067634B559C125B9348502EC0CD897F0AB1380E797619F52315EBC2BB8A`.

Prior campaign boundaries retained: `integration/EFFICIENCY_PROOF_COMPOSITION_2026-11-11.md` SHA256 `FE62515193754C19CDB4A34728765CFA09DD5BEDD1694E5D575DCC79EE7D4E9B`; `integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md` SHA256 `3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227`. Those are arithmetic/composition evidence, not an analytic-library translation.
