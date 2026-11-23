# Independent review of the genuine seven-eighths provider cut

Date: 2026-11-11. Reviewer: prime-estimates agent, independent of the integration note's author.

**Verdict: PASS for the stated source-level compatibility comparison and mathematical adapter plan.** No blocking mathematical or source/API defect was found. This is not a sealed theorem audit, a provider proof audit, or a compilation result. No Lean command, dependency update, canonical edit, or frozen-file change was made.

Reviewed target: `../integration/PROVIDER_COMPATIBILITY_CUT_2026-11-11.md`, SHA256 `4F2209C5D0D7F861426E5469A37B878CC4920756276F177C69D3C21D99E6F78C`. The hash was recomputed before reading the note. The reviewed source checkouts have HEADs `4eaee87548250b2682affda7d05d947c05554bae` for `work/openai-math` and `23b2d68ca344203d4384e0aff7affa4ec034bef9` for `work/ternary-goldbach`.

## Exact provider and expanded logical inputs

Directly inspected `work/openai-math/lean/OAI/NumberTheory/DirichletL/Nonvanishing.lean:19–24` and its delegate in `Detector/FinalAssemblyUnconditional.lean:37–43`. The public Dirichlet export is genuinely

`OAI.DirichletCharacter.LFunction_ne_zero_of_seven_eighths_lt_re`.

Its conclusion explicitly names `_root_.DirichletCharacter.LFunction chi s != 0`. The root definition in Mathlib's `NumberTheory/LSeries/DirichletContinuation.lean` is `ZMod.LFunction chi s`, the analytic continuation, not the potentially zero-by-definition divergent `LSeries` sum. No primitivity, height cutoff, spectral certificate, margin package, or detector hypothesis appears in the public theorem's source type. The delegate constructs its detector-band input inside the proof. This source inspection does not validate that transitive construction.

The following binder inventory compares the source syntax with the note's stated theorem. It is not a substitute for later elaborated type and axiom inspection.

| Binder | Classification | Reason |
| --- | --- | --- |
| implicit `q : Nat` | TYPING | Modulus parameter |
| instance `[NeZero q]` | SOURCE | Nonzero modulus, as in the source export |
| explicit `chi : DirichletCharacter Complex q` | TYPING | Character parameter on that modulus |
| implicit `s : Complex` | TYPING | Evaluation point |
| `hs : (7/8:Real) < s.re` | SOURCE | Exact open half-plane premise |
| `hpole : not (chi=1 and s=1)` | SOURCE | Exact principal-pole exclusion |

Counts: SOURCE 3, TYPING 3, STANDING 0, RULED 0, EXCESS 0. The note reproduces all six source binders and the conclusion correctly. The delegate's explicit `q!=0` and local `letI : NeZero q` are supplied by the wrapper; they are not an extra public assumption.

The separate zeta export at `Nonvanishing.lean:29–31` is `OAI.riemannZeta_ne_zero_of_seven_eighths_lt_re`. Its binders are implicit `s : Complex` classified TYPING and `hs : 7/8<s.re` classified SOURCE. Counts: SOURCE 1, TYPING 1, all other bins 0. It has no separate `s!=1` premise. The note correctly treats this as a statement about Mathlib's pointwise zeta function and does not infer analyticity at its pole.

I also read `RowCompletion/ZeroFreeRegion.lean:210` and the preceding Dirichlet export. Those use `23/24`, and the zeta theorem additionally takes `s!=1`. Since `7/8 < 23/24`, that theorem excludes a strictly smaller half-plane and cannot supply the selected global seven-eighths result. The note does not substitute it.

## Independent old/new Mathlib comparison

The provider's `lean-toolchain`, `lakefile.lean`, and `lake-manifest.json` confirm Lean 4.34.1, Mathlib `d13f23b723b8a846827a245b89c10fc7d3f11612`, `fixedToolchain=true`, and `autoImplicit=false`. The target files confirm Lean 4.35.0 and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`.

I independently ran a read-only Git diff between those exact Mathlib commits in the existing cache at `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`, using a command-local `safe.directory` setting. I inspected the complete diffs of the same five files:

| File | Independent finding |
| --- | --- |
| `NumberTheory/LSeries/DirichletContinuation.lean` | Imports change and one proof is rewritten with `congrm`; the inspected L-function, gamma, completed-function, and functional-equation definitions/statements do not change |
| `NumberTheory/LSeries/ZMod.lean` | Three proof-syntax changes; no changed continuation definition in the diff |
| `NumberTheory/LSeries/RiemannZeta.lean` | PSeriesComplex becomes a private import and CrossRefAttribute is removed; no zeta definition change in this file |
| `NumberTheory/DirichletCharacter/Basic.lean` | CrossRefAttribute removal and proof-syntax changes; no changed conductor, inverse-conductor, character, or primitivity statement |
| `Analysis/Analytic/Order.lean` | Import changes and two added lemmas; the multiplication, eventual-equality, and nonzero-derivative composition APIs used by the note are unchanged |

This matches the note. In particular, changed import visibility is a real source-port concern even when the mathematical declarations are unchanged. These five diffs do not establish that every imported mathematical definition, every elaboration behavior, or the 2,943-module provider closure is compatible. I did not regenerate that closure. Its 2,924 OAI plus 19 external count remains the previously recorded source inventory, not a new result of this review. The external patch manifest was inspected for provenance only; the patched dependencies were not reaudited or built.

The note's claim that this narrow comparison does not itself require a new L-function identification theorem is acceptable in that scope. A port must still be compiled and its intended definitions checked at the target pin. No old/new olean mixing or loading two Mathlib revisions under the same module names is justified.

## Functional equation and the nonzero local factor

The target Mathlib theorem `DirichletCharacter.IsPrimitive.completedLFunction_one_sub` states

`completedLFunction chi (1-s) = q^(s-1/2)*rootNumber chi*completedLFunction chi^-1 s`.

Substituting `s=1-z` gives the exponent `1/2-z`. Applying `LFunction_eq_completed_div_gammaFactor` at both arguments and multiplying by the nonzero inverse-character gamma factor therefore gives exactly the note's identity

`L_chi(z) = C_chi(z)*L_(chi^-1)(1-z)`,

`C_chi(z) = q^(1/2-z)*rootNumber(chi)*gammaFactor(chi^-1,1-z)/gammaFactor(chi,z)`.

The character on the reflected L-function is its inverse. Replacing it with the original character without a conjugation argument would be invalid for a general complex character. The note avoids that error.

For primitive nonprincipal `chi`, `q` is positive from `[NeZero q]`; in fact `q!=1` also follows from nonprincipality. At `0<Re z<1`, both `z` and `1-z` are nonzero. Thus the disjunction `s!=0 or q!=1` required by `LFunction_eq_completed_div_gammaFactor` is discharged at both points. The completed-function and gamma formulas have no exceptional-point ambiguity in this domain.

The local factor is analytic and nonzero throughout the open strip:

* A positive, constant base `q` makes the function `z -> q^(1/2-z)` analytic and nonzero. It can be expressed through `exp((1/2-z)*log q)` or handled by the existing constant-base complex-power API.
* `Explicit/LGrowthLeft.lean:221`, `norm_rootNumber`, proves the primitive root number has norm 1, without a Platt premise.
* Mathlib's even/odd gamma-factor identities reduce the arguments to `z`, `z+1`, `1-z`, or `2-z`. Every relevant real part is positive. `Gammaℝ_ne_zero_of_re_pos` and `Explicit/WeilBridge.lean:19`, `analyticAt_Gammaℝ`, give nonvanishing and analyticity. Division by the denominator gamma factor is therefore analytic locally.

The target already uses this factorization in `Explicit/ZeroSums.lean:106–156` and `LGrowthLeft.lean:251–269`. Those source bodies confirm the factor orientation and the root-number/gamma APIs.

Consequently, if `L_chi(rho)=0` in the open strip, then `L_(chi^-1)(1-rho)=0`. The genuine provider excludes `Re rho>7/8` directly and excludes `Re rho<1/8` after reflection. Both endpoints remain allowed, yielding `[1/8,7/8]`. The reflected point cannot be 1 because its real part remains strictly below 1. No same-character symmetry or conjugation lemma is needed to obtain this strip.

For the finite `.555` upper bound, the analogous reflection is valid only when the certificate covers the inverse character too. `DirichletCharacter.conductor_inv` preserves the conductor; rewriting the definition of primitivity gives primitivity of the inverse. Since `chi(-1)` is 1 or -1, inverse parity is unchanged. Modulus, absolute ordinate, and the conductor/parity-based height cutoff therefore agree. A certificate for only real characters would not cover the required family.

## Reflected multiplicities and actual zero sets

The proposed two-point order argument is mathematically sound and uses actual available interfaces. On a neighborhood of `rho` inside the strip, use the local equality above with `analyticOrderAt_congr`. The multiplication formula gives

`ord_rho L_chi = ord_rho C_chi + ord_rho (L_(chi^-1) composed with (z -> 1-z))`.

The first order is zero because the factor is analytic and nonzero. `analyticOrderAt_comp_of_deriv_ne_zero`, target `Analysis/Analytic/Order.lean:588`, then identifies the second order with `ord_(1-rho) L_(chi^-1)` because the affine map has derivative -1. This compares the functions at the correct two distinct points.

For the conversion to multiplicities, target `Analysis/Meromorphic/Divisor.lean:79` states the exact analytic divisor formula

`divisor f U z = ((analyticOrderAt f z).map (cast to Int)).untop₀`

under neighborhood analyticity on `U` and membership `z in U`. Apply it separately to each containing ball, rewrite the equality of orders, and finally apply integer `.toNat` as in `multRect`. This order matters; the existing `WeilBridge.divB_eq_of_analyticOrderAt_eq` only handles the same evaluation point and cannot directly compare `rho` with `1-rho`.

No finiteness-of-order premise must be smuggled into this equality: equal extended orders remain equal after `map`, `untop₀`, and `.toNat`. For a source zero actually in the support of the divisor, its nonzero divisor transports to the destination. Combining that with the destination geometry establishes actual reflected carrier membership. Merely knowing a pointwise function value is zero, without addressing divisor support, would not be an adequate shortcut for a completely general analytic function.

`Explicit/ExplicitFormula.lean:298,302` and `Datum.lean:82,86` define the finite zero carriers and multiplicities from the actual divisors in the ball centered at 2 with radius `RT(T)=2(T+3)`. The auxiliary `zerosIn` support filter also imposes the smaller radius `RT(T)/2`; the note's proposed geometry must prove that condition too. `WeilBridge.mem_closedBall_two_RT` already returns both containing-ball membership and the strict smaller-radius inequality for `0<Re u<1` and `abs(Im u)<T`.

Reflection preserves absolute ordinate and sends the open critical strip to itself. It need not preserve the entire ball centered at 2. Proving the two point memberships independently, as the note requires, is the correct method. For an inclusive cutoff `abs(Im u)<=H`, choose an auxiliary `T>H` before using the strict rectangle APIs. The target `multRectD_eq_mult` also requires `1<=T'` for its xi carrier, besides both strict ordinate bounds. This explicit API premise must also be retained at each application; it is automatic for the intended large auxiliary heights.

## Exceptional zeros, the principal pole, and conjugation

`ZeroSums.zerosRect_cases` applies only to primitive nonprincipal characters and yields either `u=0` or `0<Re u<1`. An even nonprincipal character may have the trivial zero at zero. That point must remain in its separate explicit-formula term; the nonzero-gamma-factor and strip argument above is not valid there. The note explicitly separates it.

The principal L-function is not entire. Arbitrary imprimitive principal characters cannot be fed to the nonprincipal entire-function datum. For the primitive principal case at modulus 1, the target uses the zeta continuation instead. `Explicit/ZetaGrowth.lean:17` defines

`zetaF = update (fun s -> (s-1)*riemannZeta s) 1 1`.

Thus `zetaF(1)=1`, not the value obtained by blindly multiplying pointwise `0*riemannZeta(1)`. Its value at zero is `1/2`. `ZetaZeroSums.zerosRectD_zetaF_strip:39` removes the zero0 alternative and gives actual zeta and xi zeros in the open strip. `Xi.xiF_one_sub`, `xiF_eq_zero_iff`, and `WeilBridge.analyticOrderAt_xiF_eq` then supply the principal reflection/order route. These file-prefixed references are declarations in the namespace `TernaryGoldbach.Explicit`; the file names themselves are not additional namespaces.

The note correctly keeps conjugation separate. `MulChar.star_eq_inv` and `star_apply'` require a finite unit group, which is available for `ZMod q`, and identify coefficient conjugation with inverse character. On `Re z>1`, the absolutely convergent series gives

`conj(L_chi(conj z)) = L_(chi^-1)(z)`.

For nonprincipal characters both continuations are entire; conjugating the coefficients of a local power series supplies analyticity of the doubly conjugated function, then analytic continuation extends the identity. The same coefficient argument preserves the order of a zero. This is a valid proof plan, but a completed Lean theorem implementing it was neither located nor supplied by the note. Combining it with functional-equation reflection produces the same-character map `rho -> 1-conj(rho)`. Any family reindexing must additionally prove invariance of its particular weights. None of these obligations follows merely from the upper-strip provider.

## Acceptance scope and open validation gates

The reviewed source note accurately identifies the genuine 7/8 export, the narrow five-file compatibility evidence, the inverse-character local factor, and the required two-point multiplicity conversion. Its principal-pole and trivial-zero handling is mathematically correct. No correction to the frozen note is required for this source-level verdict.

This review does **not** establish that the 2,943-module closure builds at Lean 4.35.0, that its detector-band proof is valid in the target environment, that the patched external modules are semantically unchanged, or that the genuine public exports have only the permitted transitive axioms. The target prerequisite receipts are not provider receipts. The local factor/order and conjugation bridges are still implementation work, and concrete weighted-sum reindexing still needs its own consumer audit.

The acceptance boundary remains the one in the note: an isolated source port preserving exact mathematical types and options, successful whole-provider compilation, expanded public-type checks, transitive axiom inspection, then actual applications to the target carriers including all exceptional points and cutoff premises. Until those gates pass, this is a source-supported research plan and not a replacement theorem available to the final Goldbach proof.
