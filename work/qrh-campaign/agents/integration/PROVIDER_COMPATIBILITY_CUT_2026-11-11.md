# Global seven-eighths provider: remaining compatibility cut

Source-only research, 2026-11-11. Existing `BLUEPRINT_QRH_PROVIDER.md` and `RESUME_PROVIDER_2026-11-11.md` were read first. No Lean/Lake command, declaration, canonical edit, dependency update or frozen-package change was made. This note adds a direct old/new Mathlib comparison and resolves the precise reflection/carrier adapter on paper; it does not validate the provider proof.

## Pins and the smallest established provider cut

The checkout identities were re-read: QRH `work/openai-math` is `4eaee87548250b2682affda7d05d947c05554bae`; Goldbach `work/ternary-goldbach` is `23b2d68ca344203d4384e0aff7affa4ec034bef9`. QRH declares Lean4.34.1, Mathlib `d13f23b723b8a846827a245b89c10fc7d3f11612`, `fixedToolchain=true`, and `autoImplicit=false`. Goldbach uses Lean4.35.0 and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`.

The selected public module remains `OAI.NumberTheory.DirichletL.Nonvanishing`. Its established source closure is2924 OAI modules plus19 prepared external modules,2943 total. External roots are the pinned/patched `PrimeNumberTheoremAnd.Wiener` and Rellich package recorded in the earlier report and `work/qrh-dependencies/patched-module-closure.json`. This existing inventory was not rebuilt. There is no newly established smaller genuine7/8 proof closure. Removing the wrapper's explicit Foundation import does not remove the assembly's transitive Foundation dependency. The301-module23/24 route is mathematically insufficient.

Use a separate source port of this closure against the target4.35/Mathlib pin. Retain original sources and patch provenance; preserve package options, exact mathematical definitions and theorem statements. Do not mix4.34 oleans with4.35, load two Mathlib revisions under the same module names, or change the Goldbach dependency pin to make the provider import. Reuse the reviewed success-receipt/staging protocol before persistent compilation. The24 target prerequisite receipts contain no successful provider validation.

## Exact exported meaning

At provider `Nonvanishing.lean:19`, the Dirichlet theorem is

`{q : Nat} [NeZero q] (chi : DirichletCharacter Complex q) {s : Complex}`
`(hs : (7/8 : Real)<s.re) (hpole : not (chi=1 and s=1))`
`-> _root_.DirichletCharacter.LFunction chi s != 0`.

It has no primitivity, conductor or height restriction. The namespace prefix `OAI.DirichletCharacter` does not redefine the conclusion's L-function: the explicit `_root_` name is the actual Mathlib continuation. The proof delegates to `SevenEighths.ProbeFinalAssemblyUnconditional.dirichlet_nonzero` with `q`, `NeZero.ne q`, and the same arguments. Its supplied detector-band proof still needs full transitive validation.

At line29, `OAI.riemannZeta_ne_zero_of_seven_eighths_lt_re` takes only `7/8<s.re`. It refers to Mathlib's pointwise zeta value, including its convention at1; no separate pole premise appears. This does not make the meromorphic pole an analytic zero or remove the need for the source's entire `zetaF` continuation.

For an actual zero with `0<rho.re<1`, `rho!=1` follows from the real-part bound. The Dirichlet pole exclusion is therefore immediate, for any character. Contradiction with the exported theorem gives `rho.re<=7/8`. The upper-strip adapter needs no primitivity and no multiplicity argument. Principal conductor1 should use the target's zetaF/xi APIs; arbitrary imprimitive principal L-functions must not be treated as entire nonprincipal data.

## New direct Mathlib comparison

The target cache contains both pinned Git objects. A read-only `git diff d13f23b... 56a00585... -- <paths>` was run using only a command-local safe.directory override. No Git configuration or cache contents changed.

| Inspected file | Observed differences relevant to integration |
|---|---|
| `NumberTheory/LSeries/DirichletContinuation.lean` | Public import rearrangement and one proof-syntax change. The LFunction definition, completed/gamma relation and primitive functional-equation statement/body are unchanged in this file. |
| `NumberTheory/LSeries/ZMod.lean` | Three proof-syntax changes; the finite Hurwitz-sum continuation and completed-function definitions are unchanged. |
| `NumberTheory/LSeries/RiemannZeta.lean` | PSeriesComplex changes from public import to private import, and CrossRefAttribute import disappears. The zeta definition is unchanged. |
| `NumberTheory/DirichletCharacter/Basic.lean` | Removed CrossRefAttribute import and proof-syntax changes. Character, conductor, primitivity and inverse-conductor statements are unchanged. |
| `Analysis/Analytic/Order.lean` | Public/private import changes and two additional lemmas. Existing analytic-order multiplication and nonzero-derivative composition interfaces are unchanged. |

This resolves a narrow semantic concern: the inspected source interfaces do not require a new L-function identification theorem merely because the two Mathlib revisions differ. It is not a proof of whole-closure compilation compatibility or of unchanged transitive implementation. Public-import visibility did change, so downstream proofs relying on re-exported PSeries/derivative APIs may need explicit imports in the isolated port. Add such imports only when an actual failed dependency requires them; no failing provider module is claimed here.

## Concrete unresolved adapter resolved on paper: reflection changes character

The earlier plans named functional-equation reflection but did not give the precise local factor and divisor transport. One cannot assume `L(chi,1-rho)=0` from `L(chi,rho)=0` for a general complex character. The actual Mathlib equation at `DirichletContinuation.lean:283` is

`Lambda_chi(1-s)=q^(s-1/2)*rootNumber(chi)*Lambda_(chi^-1)(s)`.

For primitive nonprincipal chi and `0<Re z<1`, the exact local identity is

`L_chi(z)=C_chi(z)*L_(chi^-1)(1-z)`,
`C_chi(z)=q^(1/2-z)*rootNumber(chi)*gammaFactor(chi^-1,1-z)/gammaFactor(chi,z)`.

This follows by substituting `s=1-z` and using `LFunction_eq_completed_div_gammaFactor` at line258. Its premise is `s!=0 OR q!=1`; in this strip the first alternative suffices at both arguments. The target already gives the same factorization pattern in `Explicit/ZeroSums.lean:106–156` and `LGrowthLeft.lean:251–269`.

C is analytic and nonzero in a neighborhood of every such z. The positive integer q has a nonzero constant cpow base. `LGrowthLeft.norm_rootNumber:221` gives norm1 for primitive chi. The two gamma factors are Gammaℝ at z or z+1 and at1-z or2-z, all with positive real part; use even/odd gamma-factor identities and `Gammaℝ_ne_zero_of_re_pos`. `WeilBridge.analyticAt_Gammaℝ:19` supplies the target's local analyticity argument. No gamma pole, zero0 exception or root-number zero enters this open strip.

Thus a zero of chi at rho gives a zero of chi^-1 at1-rho. Apply the provider to chi^-1: if Re rho<1/8, then Re(1-rho)>7/8, contradicting that zero. Together with the upper adapter this gives the full closed strip `[1/8,7/8]`. No conjugation identity and no same-character symmetry is needed for this step.

The same observation resolves lower finite-strip transport: certify the upper .555 bound for every character in the full primitive family, then apply it to chi^-1. `DirichletCharacter.conductor_inv:404` preserves the conductor, hence primitivity and Hcert. Parity is also preserved because chi(-1) is+1 or-1. The family must really include every inverse character; a real-character-only result is insufficient.

## Multiplicity and conjugation are separate obligations

For multiplicity, use the local identity above, `analyticOrderAt_congr`, and `analyticOrderAt_mul`: the analytic nonzero C contributes order0. Then `analyticOrderAt_comp_of_deriv_ne_zero` (`Analysis/Analytic/Order.lean:588`) for `z -> 1-z`, whose derivative is-1, gives

`ord_rho L_chi = ord_(1-rho) L_(chi^-1)`.

Translate each side separately through `MeromorphicOn.AnalyticOnNhd.divisor_apply` on its own containing ball, and then `.toNat`. The existing `WeilBridge.divB_eq_of_analyticOrderAt_eq:55` compares functions at the same point; it must not be applied directly to different reflected points. This paper argument supplies the missing two-point order step without adding an analytic assumption.

Conjugation, when a consumer actually needs it, has the different map `(chi,rho)->(chi^-1,conj rho)`. Mathlib `MulChar.star_eq_inv:73` and `star_apply':79` identify the coefficient conjugation for the finite unit group. Establish `conj(L_chi(conj z))=L_(chi^-1)(z)` first on Re z>1 using the absolutely convergent Dirichlet series and conjugation of positive-real powers, then extend by analytic continuation for nonprincipal chi. Analyticity of the doubly conjugated function follows by conjugating its local power-series coefficients. The same coefficient argument preserves vanishing order. A scoped search did not locate a ready-made LFunction conjugation/order theorem; implementation remains necessary.

Combining conjugation with functional-equation reflection gives the same-character map `rho -> 1-conj rho`, preserving imaginary part, and its multiplicity statement. It should be proved only where used, rather than hidden inside the basic strip adapter. Family sums may instead pair inverse characters if every coefficient/weight is proved invariant. The principal zeta case uses `Xi.xiF_one_sub:24`, `xiF_eq_zero_iff:55` and `WeilBridge.analyticOrderAt_xiF_eq:38`; conjugation still must be justified wherever positive/negative ordinates are doubled.

## Actual finite carriers and exceptional terms

`Explicit/ExplicitFormula.lean:298,302` defines `zerosRect chi T` and `multRect chi T`; `Datum.lean:82,86` defines their generic counterparts for f. Both use actual analytic divisors on the ball centered at2 with radius `RT(T)=2(T+3)` and a strict interior rectangle filter. These are not supplied zero lists.

For primitive nonprincipal chi, `ZeroSums.zerosRect_cases:159` yields `L_chi(u)=0`, `|Im u|<T`, and either `u=0` or `0<Re u<1`. Exclude or split the zero0 branch before applying the strip/multiplicity reflection. An even-character trivial zero at0 need not satisfy the global strip and is already a separate explicit-formula term. For zeta, `ZetaZeroSums.zerosRectD_zetaF_strip:39` supplies the nontrivial-strip and xi carrier directly; zetaF has no zero at0 or1.

For any strict-cutoff nontrivial zero, reflected real part remains in(0,1), absolute imaginary part is unchanged, and the standard rectangle geometry puts it in the destination carrier. The centered balls themselves need not be invariant under reflection; prove the two memberships separately before comparing divisors. For inclusive finite heights H, take an auxiliary T>H, filter `|Im u|<=H`, and use the strict source lemmas. `WeilBridge.multRectD_eq_mult:87` explicitly requires both strict height inequalities. Do not drop zeros at H.

## Minimal future validation order

1. Verify original sources, dependency patches and both environment pins. Prepare the isolated target-version port and audited persistent build receipts. Preserve exact options and source diffs.
2. Compile a bounded original leaf only to diagnose compatibility, then the genuine2943-module source closure. A leaf success is not provider success. Do not update global target pins or infer correctness from unrelated target receipts.
3. Check the two final public exports at expanded types and audit transitive axioms against `propext`, `Classical.choice`, `Quot.sound`. Run the supplied comparator in its separate challenge/solution role; its `enable_nanoda=false` means it does not itself promise an independent checker run.
4. Validate thin actual-zero upper adapters, the primitive inverse-character lower adapter, and zeta specialization. Then prove the local analytic-factor/order transport and only the conjugation identities required by actual consumers.
5. Validate concrete carrier applications, including zero0 separation, principal-pole removal, both strict/inclusive height conventions and weight invariance for any reindexing. These adapters consume the genuine provider; they never add it as an axiom or premise of the final Goldbach root.

No version conflict has been proved absent across the whole provider. The new result is a source-supported compatibility cut: unchanged inspected mathematical APIs, known import-visibility risk, and an explicit inverse-character/local-factor route resolving the previously underspecified reflection and two-point multiplicity bridge. All compilation and final type/axiom gates remain open.
