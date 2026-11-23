# Independent semantic review of the selected external QRH patches

2026-11-11. **PASS for the report's restricted source-level conclusion.** I found no change to the retained mathematical objects or added mathematical premise in the inspected QRH-facing interfaces. The patches are not globally API-equivalent or exclusively proof-only. Their removed exports, renamed constructors, visibility changes and instance-registration changes are real and are correctly acknowledged in the producer report. No correction to that restricted conclusion is required.

This review does not establish that the patched provider elaborates, that every rewritten proof succeeds, or that the final QRH exports have the required kernel axiom closure. No Lean/Lake process, installation, source edit, or repetition of the previous broad 8,742-file scan was performed.

## Exact evidence

The reviewed producer report is `prime-estimates/QRH_EXTERNAL_PATCH_SEMANTIC_AUDIT_2026-11-11.md`, SHA256 `9D305A6D9B5E0E1F5EC5B2BB8DBC1118C7061200C99BEE3BCA3C8BC1036ABD99`. Paths to agent artifacts in this note are relative to `work/qrh-campaign/agents/`.

| Producer artifact | SHA256 |
|---|---|
| `prime-estimates/qrh_external_patch_semantic_audit_20261111.py` | `C49194A08609F28D2C83E0CC06F8BE76728012D3661E44A801EB73E138836175` |
| `prime-estimates/qrh_external_patch_semantic_audit_20261111.json` | `5EB4589A1846CDE7717A0E65F8340143A3034BDD840340AB0FDFB38BE2BC5C49` |
| `prime-estimates/qrh_external_selected_diff_20261111.txt` | `2A9355B5C59B6DC55E7734F2B2B9DAF193125CCE976523D899D60AA33FD90A76` |

I independently read pristine files from Git, compared all 19 pristine/prepared raw hash pairs with the producer inventory, checked the current prepared bytes again, and traversed the two external import roots. The resulting external-project closure is exactly four PNT modules and fifteen Rellich modules. Its remaining direct imports are Mathlib modules.

The selected closure manifest, `work/qrh-dependencies/patched-module-closure.json`, has SHA256 `387D6B1CDA595A0811BB9C8C23CBAEECA44D0EDA82602C54FCCC0B734645945D`. The pristine repository heads are `c39a751132c88b6e8080b74c74023fd95b3d8be0` for PrimeNumberTheoremAnd and `70f85d4c1bf99c6e7d61e8be4daa6f3664d08d23` for Rellich. I also independently compared both stored patch files with their `lean/patches/` blobs at OAI commit `4eaee87548250b2682affda7d05d947c05554bae`. They are byte-identical. Their hashes are respectively `0890432340C0025973BCFE070B634355FA366CC831595F68526E4C73C8903D82` and `0C121D8517DFEADC93EF24FE2DEB56BEEC7CB3998E2552DEE8F61C780B1408C8`.

The producer's reconstruction checks 201 selected hunks. Its complete PNT patch has 55 file sections; this semantic review does not approve the other 51 sections. I inspected the reconstruction routine and its retained output, but the independent semantic work relies on the actual before/after files, not on treating successful patch application as a semantic proof.

Own evidence:

| Artifact | SHA256 |
|---|---|
| `independent-feasibility/review_external_patch_inventory_20261111.py` | `D3CC72D4E6EAD4C8188ABED9CB3F3F2B2816C6904AC48231BA0684F0B58F6921` |
| `independent-feasibility/review_external_patch_inventory_20261111.json` | `BE6CC5B648A202453EC2F3EF9C4AEA0F48525CFAE894FC8B9EF1F60B5A9B3F44` |
| `independent-feasibility/review_external_patch_final_checks_20261111.json` | `A5BAF5BC8ECD9393F86B10D156EFB2BF133FE33F51EE3A3EDF2886EA14A89037` |

Both header inventories are lexical aids, not Lean parsers. Anonymous-instance positions shift after insertions; a declaration body can appear to include a following option or attribute; and an unbracketed let in a result type can truncate a header. I resolved the material cases by reading the actual declarations and context. The inventories do not certify elaborated binders or generated declarations.

## PNT declarations and data

The material retained statement change is the inlining of the old predicates

```
chebyWith C f := forall n, cumsum (fun k => norm (f k)) n <= C*n
cheby f := exists C, chebyWith C f.
```

The prepared explicit quantified formulas have this same meaning. For real coefficient functions, the displayed complex cast gives the same norm as the original coercion into the predicate's complex function argument. No constant, quantifier order, endpoint, or uniformity requirement is changed by this expansion.

In particular, `WienerIkeharaTheorem'` retains nonnegativity, summability at every real abscissa greater than one, the Chebyshev bound, continuity on `Re(s)>=1`, and the exact remainder identity on `Re(s)>1`. Its conclusion is still the limit of the strict partial sum `cumsum f N/N`. The expansion does not manufacture this bound; callers still have to prove it. `vonMangoldt_cheby` supplies its bound using the same explicit witness `log 4+4` and the Chebyshev estimate.

The data comparisons support the following narrower preservation statements:

- `nterm`, `cumsum`, and the finite-difference/shift formulas are unchanged. The strict `Finset.range` convention has not become an inclusive partial sum.
- `CS`, `trunc`, `W1`, and `W21` retain their fields and carriers. Their function coercions, differentiability conditions, compact-support conditions and integrability conditions have not been replaced by trivial predicates.
- The W21 norm still has the same L1 term and `(4*pi^2)^(-1)` second-derivative term. The `ofCS2` change proves the same integrability fields by explicit cases k=0,1,2; it leaves the represented function unchanged.
- `of_Schwartz` becomes `ofSchwartz`, and the coercion is updated. This is a real name change, with the same underlying function and smoothness/integrability data.
- The explicit `CS.ext` theorem replaces the structure's ext attribute machinery. It proves equality from equality of `toFun`; the structure itself is unchanged.
- `toSchwartz` now calls `HasCompactSupport.toSchwartzMap`. I read that declaration in the target Mathlib source at commit `56a005855ea17e0b0958f73ec801ae140b0a1679`: its `toFun` is exactly f. The changed decay proof does not define a different Schwartz function.

The Circle import replacement also has concrete source support. The removed PNT measurable-space and Borel instances use the same subtype measurable structure and Borel proof as `Mathlib.MeasureTheory.Group.Circle:29–32`. This supports preservation of the intended measurable object, but it does not assert that every elaboration path or instance name is unchanged.

The removals are substantive API differences. These include the two pristine `sorry`-bearing preliminary decay lemmas, their alternative-decay branch, the auto-Chebyshev branch, the double-prime Wiener theorem, the character/AP branches, the Fourier bounded exponential object and helpers, and the separate `SmoothExistence` theorem. The surviving W21 route is not a proof of those deleted declarations. Removing them can eliminate unwanted admitted dependencies from this selected module, but it does not by itself certify the retained exports' proof-term axiom closure.

## Rellich declarations, instances and carriers

I compared the affected data bodies as well as their result types. `C1c` retains the differentiable compact-support carrier; `grad` retains the Riesz representation of the derivative; `toL2` and `toL2Grad` still represent the same functions almost everywhere. The graph is still the product of those two maps, and h1 is still the topological closure of its range. The two continuous linear projections still select the function and gradient coordinates.

Most importantly for the QRH consumer, `h1On` remains the comap of the extension-by-zero range under `h1ToL2`. `h1OnToL2` remains the restriction of that same inclusion. The public compact-operator theorem retains its original ambient finite-dimensional/completeness context and compact/measurable support assumptions. No zero map, default space, weakened support condition, or assumed compactness field was substituted.

The following API changes must remain visible in any compatibility assessment:

- `L2ℝ`, `L2E`, `H1Target`, `extendByZeroFun`, and `smoothOn` become public. Their underlying definitions remain the same; visibility is not the same as proof-only editing.
- Local measurable/Borel/measurable-addition instances are named or renamed. Their underlying measurable space remains `borel E`. The completeness instance is renamed.
- The conditional probability-measure instance becomes `isProbabilityMeasure_kernelMeasure`, an explicit lemma with the same continuity, compact-support, nonnegativity and unit-integral premises. This changes instance search. Local proof bindings in callers are compatibility work, not a new global assumption.
- `delta` becomes `deltaLoss`; `Icc` is qualified as `Set.Icc`; ENNReal infinity notation is made explicit. The inspected domains and inequalities retain their meanings.

The larger proof reorganizations extract private squared-integral, range-bound, equicontinuity and norm-transfer lemmas. Their inputs are the same local estimates or support/continuity facts used by the old proofs. Public consumers call these lemmas; they do not acquire those conclusions as new hypotheses. This is a source-level premise check, not independent certification of every line of the rewritten analytic proofs.

## Actual QRH consumption and import boundary

I read the actual uses in `IdealMangoldt`, `PrimeCounting.Progressions`, `PrimeCounting.RayAsymptotic`, and `CubicSieve.RadialWindows`. These consumers supply the Chebyshev estimates to the retained Wiener theorem, rather than relying on a removed automatic-bound theorem. RadialWindows constructs actual C1c graph elements and supported h1 elements, then invokes the unchanged compact inclusion with explicit support, mass and gradient bounds.

The final checks receipt confirms that those four consumer files and `Nonvanishing.lean` equal their pinned OAI source after line-ending normalization. The public Dirichlet conclusion explicitly names `_root_.DirichletCharacter.LFunction`; the zeta conclusion uses the genuine zeta function. These external patches do not edit those endpoints or introduce a replacement L-function, zero predicate, or QRH assumption package. No such substitution was found in the selected external definitions.

The import changes remove Architect and the unused local Asymptotics/Support compatibility modules, remove obsolete Fourier imports, add the ordinary Circle and iterated-derivative imports, and replace the compact-operator umbrella import by `.Basic`. A traversal of the prepared imports reaches exactly the selected nineteen external modules. No selected source introduces an axiom, admission, unsafe override, evaluator macro, or implemented-by replacement in the bounded lexical check. This last observation is only supporting evidence; it is not a transitive axiom audit.

## Verdict and unresolved checks

The producer report accurately distinguishes preserved retained mathematics from changed API and proof implementation. Its references to supplied or proved intermediate inputs are accepted here as statements about source proof declarations and call sites, not as evidence that this target environment has checked those proof terms.

Target elaboration remains untested. The patches target Lean 4.34.1, while the contemplated environment uses Lean 4.35.0 and the recorded Mathlib commit. Changed imports, generated names, local typeclass search, and explicit proof adaptations can still cause compatibility failures. After a successful isolated build, the actual elaborated public types and transitive axioms of both genuine seven-eighths exports still require inspection. The intended axiom whitelist is `{propext, Classical.choice, Quot.sound}`; this review does not establish it.

No claim is made about the other PNT patch sections, arbitrary library users, a general equivalence theorem between modules, or the correctness of the entire original QRH development. Within the requested source-level scope, I found no semantic discrepancy requiring a source repair or a widened final hypothesis.
