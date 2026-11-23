# Review of the next global-provider proof obligations

2026-11-11. **PASS for the corrected source/paper claims and proposed validation boundary.** No unresolved mathematical or source-interface defect was found in the two new reductions. This does not validate the provider proof, its compilation, its expanded elaborated type, or its transitive axioms.

Reviewed author: `integration/GLOBAL_PROVIDER_NEXT_PROOF_OBLIGATIONS_2026-11-11.md`, final SHA256 **`50F5DDF5EC71575D8DDF4F90DDBEB3AB995FEE1E1BE02F015A397BCF139D6732`**. Paths to research notes are relative to `work/qrh-campaign/agents/`. Only source reads and hashes were used; no evaluator, Lean/Lake command, build, dependency change, or frozen-file edit was performed by this review.

## Corrections incorporated before acceptance

The initial `73B09A0F...` version said that the ordinate is unchanged by induction and reflection. Under the actual reflection rho->1-rho its sign changes. The final text correctly says induction leaves rho unchanged, while reflection negates the ordinate and preserves its absolute value. Conductor-dependent height certificates therefore still transfer.

The initial text cited `LGrowth.norm_cpow_neg` as the power-norm identity without noting its shifted exponent. Its actual conclusion is the norm formula for `t^(-(s+1))`. The final text explicitly instantiates it at s-1 and names the direct underlying `Complex.norm_cpow_eq_rpow_re_of_pos`. This is a source precision correction; the intended inequality was already mathematically correct.

## Public theorem and principal reduction

I read the actual `OAI/NumberTheory/DirichletL/Nonvanishing.lean` and `Detector/FinalAssemblyUnconditional.lean`. The visible public Dirichlet theorem quantifies over every natural q with `[NeZero q]`, every complex Dirichlet character modulo q, and every s with 7/8<Re(s), excluding exactly chi=1 and s=1. It concludes nonvanishing of the explicitly rooted Mathlib continued `DirichletCharacter.LFunction`. No primitive, conductor, finite-height, moment, detector or spectral certificate appears as an additional public binder.

The internal detector proposition is supplied by an explicit candidate proof term in `detector_certified_bands` and then passed to the conditional assembly. This verifies the visible architecture of discharge only. It does not establish the correctness of its imported analytic arguments or thousands of proof bodies, and it cannot replace elaboration and a final proof-dependency audit.

The target Mathlib `LFunction_modOne_eq` is an equality of functions for **any** complex character modulo1, not merely equality in a half-plane of absolute convergence. Specializing the public export to q=1 and chi=1 therefore supplies zeta nonvanishing for Re(s)>7/8 and s!=1. The pole exception is exactly discharged by s!=1. No naive `LSeries` is used outside its convergence range.

For a xiF zero, the existing source exclusions put its real part strictly between0 and1. `xiF_eq_zero_iff` gives a zeta zero and hence Re(rho)<=7/8. The functional equation `xiF_one_sub` gives another xiF zero at1-rho, so the same argument gives Re(rho)>=1/8. Both boundary equalities are allowed; strict nonvanishing must not be advertised as exclusion of the boundary lines. This location proof needs no conjugation, order equality, or zero simplicity. The actual xiF values at0 and1 equal1, so no pole convention has been used as an analytic identity there.

The source Gaussian carrier is covered because `zerosRectD_zetaF_strip` already supplies strict-strip location and the actual xiF/zeta zero. For the nonprincipal carrier, its separate zero0 branch still must be split as described in the prior compatibility note; the new open-strip argument does not absorb trivial zeros.

Thus the **consumed public theorem boundary** can shrink to the one Dirichlet export. The module still imports and elaborates its established closure; this review finds no smaller module set, proof-size reduction, build-time reduction, or permission to ignore a declaration that prevents its module from compiling. Nor does it infer that the separate zeta export, if later claimed checked, has passed its own expanded-type/axiom gate.

## Induction from the primitive character

I read the actual conductor, primitive-character, change-level, norm and analytic-order APIs. For q>0, the conductor c is nonzero and divides q; the selected primitiveCharacter is primitive and changing its level back to q equals chi. These are actual source identities, so the proposed conductor is not a user-supplied label.

`LFunction_changeLevel` requires `chi0!=1 or s!=1`; using the second disjunct is legitimate on the open strip. Its product runs over **all** `q.primeFactors`, exactly as recorded. Factors for primes dividing c are1 because the character value is0. The author has not silently replaced this product by a smaller uncertified index set.

For each prime p in that finite product and Re(s)>0,

`norm(chi0(p)*p^(-s)) <= p^(-Re(s)) < 1`.

Here p>=2, the character norm is at most1, and the positive-base complex power has the stated norm. Consequently every Euler factor is nonzero. Positive constant base also makes that power an entire function of s. On a neighborhood of rho with0<Re(rho)<1 that avoids1, both L-functions are analytic by the pointwise differentiability theorem applied throughout that open neighborhood. Their local change-level identity therefore yields equality of zero status and of analytic orders, by `analyticOrderAt_congr` and `analyticOrderAt_mul`, with the nonzero Euler factor contributing order0.

This is an equality of local analytic orders. It does not assume that a meromorphic principal L-function is entire on the larger ball used by a particular divisor carrier. The author's explicit instruction to use the pole-cancelled principal carrier or a separate meromorphic restriction is necessary and correct. Order-to-multiplicity conversion still requires the actual containing-ball hypotheses and a finite order; it is not obtained from a formal equality of source names. On Re(s)=0 the Euler factors can vanish, so the open-strip restriction is substantive.

For the lower global bound, the primitive nonprincipal functional equation changes chi0 to its inverse at1-rho. I checked the actual Mathlib equation and its Gamma-factor conversion: the local factor is

`c^(1/2-z)*rootNumber(chi0)*gammaFactor(chi0^-1,1-z)/gammaFactor(chi0,z)`.

In0<Re(z)<1 the Gamma arguments have positive real parts, the primitive root number has norm1, and c>0. The factor is analytic and nonzero. Thus the prior reflection/order proof applies without a same-character assumption. A primitive principal character has c=1 by the conductor identities and uses the modulus-one reduction instead. `conductor_inv` preserves c, and reflection preserves |Im(rho)|, so a finite certificate must use Hcert(c), not an ambient-modulus guess. None of this supplies the finite certificate itself.

## Trust and evidence scope

I reread the earlier compatibility cut, selected external semantic audit, and static-trust review. Their restrictions are preserved. The 19 external prepared modules are not collectively API-equivalent or proof-only edits: declarations, visibility, instances and names changed. Their retained mathematical objects were previously source-reviewed. Exact patch provenance does not prove the patched proofs elaborate. The earlier five-file two-Mathlib comparison does not validate every imported implementation or visibility dependency.

The 2924+19 module and8742-source figures are explicitly attributed to earlier import inventories; this review did not repeat that broad scan. Such an import graph is not a theorem dependency graph. Neither absence of a literal `axiom`/`sorry` token nor an imported native example determines a final theorem's trust. The next actual validation must inspect the elaborated export and its transitive proof dependencies, allowing only the specified `{propext, Classical.choice, Quot.sound}` and rejecting all other axioms, including generated native and synthetic admissions. The challenge specification and solution must remain separate. The comparator's `enable_nanoda=false` supplies no independent kernel check.

No new mathematical hypothesis is justified by an eventual compatibility failure. The next build/check sequence is a proposal, not work performed or authorized by this source review. The common psi reduction retains its finite RH1500/Q/count data, shared finite strip, global provider and formalization obligations; it does not make global QRH imply the tighter finite strip or complete Goldbach.

## Source pins checked

The source roots are OAI revision `4eaee87548250b2682affda7d05d947c05554bae`, Goldbach revision `23b2d68ca344203d4384e0aff7affa4ec034bef9`, and target Mathlib revision `56a005855ea17e0b0958f73ec801ae140b0a1679`. The OAI source requests the different Lean4.34.1/Mathlib d13f23b environment; the target is Lean4.35.0. This distinction is not erased by matching theorem text.

| Actual source read and SHA256-checked | SHA256 |
|---|---|
| OAI/NumberTheory/DirichletL/Nonvanishing.lean | `16A7F55147E177E972264A2AC61D1639188A2090844A89D1C080CBA8500791CC` |
| OAI/NumberTheory/DirichletL/Detector/FinalAssemblyUnconditional.lean | `70D01B604FD5CC3522A4503543D9A5E422F9105C19E88985C5CD7C28C5958BA2` |
| Mathlib/NumberTheory/LSeries/DirichletContinuation.lean | `ECF79F2A64EF2E7215729EBB2E7D5ADAA03468B18BBDA0040680AA925D4673F1` |
| Mathlib/NumberTheory/DirichletCharacter/Basic.lean | `6CF338CFCDEE91A271CBDB8DF0011C47D02780469BCD2279D36907370F7C5FD4` |
| Mathlib/NumberTheory/DirichletCharacter/Bounds.lean | `411E5AEF9D6F072AB228FE5F23A88B3577042EA280379BDBD37E4D239EFFAA06` |
| Mathlib/Analysis/Analytic/Order.lean | `2426AEF2574C3DF5758D40D81DD33A6A62E07235F2B7B3F980512D4E80FDF46C` |
| TernaryGoldbach/Explicit/LGrowth.lean | `5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341` |

The xiF and carrier source files were also read and hashed during this same research turn for the damped-psi join; their hashes match the author's table. Relevant prior review pins independently matched here are `REVIEW_PROVIDER_COMPATIBILITY_CUT` = `85AFD92D37CA273EF553399903F3133BFA030175CFF608A25E3DA1E146970167`, static author = `237280059D4E714E89432C4BC574EE42BC136BEAD7797FE5C09F3E48855AF270`, and static review = `90E6426099124B1E446E48AF7DB0A099256CAD39FD4F87517ABA16DFE76B9560`.

Final acceptance is limited to the corrected paper/source reductions and accurate statement of what remains unvalidated. Successful provider proof checking and the finite certificates are still mandatory.
