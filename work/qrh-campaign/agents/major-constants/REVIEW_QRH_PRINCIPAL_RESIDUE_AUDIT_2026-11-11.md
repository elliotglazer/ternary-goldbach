# Independent review of the actual principal residue

2026-11-11. **PASS within the bounded source/mathematical scope below; no correction requested.** This is not provider validation, a successful Lean elaboration, or a transitive axiom verdict.

Reviewed author: `prime-estimates/QRH_PRINCIPAL_RESIDUE_AUDIT_2026-11-11.md`, SHA256 `E47B752259600C8147D13470403545ED3DE84D3593DC153A944ED7B37F013525`. I read the complete report, independently read the indicated proof bodies, and verified all thirteen source hashes in its tables. No Lean, numerical function evaluation, source edit, or mutation of an earlier report was performed.

OAI HEAD is `4eaee87548250b2682affda7d05d947c05554bae`. The inspected Mathlib checkout is `56a005855ea17e0b0958f73ec801ae140b0a1679`, while the OAI manifest requests `d13f23b723b8a846827a245b89c10fc7d3f11612`. The author correctly discloses this. The review checks these source statements mathematically and does not establish version compatibility.

## 1. Exact finite cardinality argument

The actual `HeckeFamily.Character` includes a nonzero ideal modulus, a multiplicative residue character, triviality on global units, and a positive integral period lying in the modulus (`Hecke/Family.lean:22–29`). The residue computation additionally assumes the residue character equals the principal multiplicative character. It does not assume primitivity.

`Hecke/Coordinates.lean:20–42` constructs surjectivity of the two integer coordinates using the actual integral power basis of the third cyclotomic field. Period membership makes the coordinate map descend to `(ZMod N)^2` (`:48–59`). Surjectivity onto the ideal quotient is then proved at `:74–80`. Thus the kernel and fibers are those of a specified finite additive homomorphism, not a freely chosen distribution of coefficients.

For a surjective additive homomorphism pi, `CharacterAnalytic.lean:9–24` constructs the equivalence

    a -> (pi(a), a-r(pi(a))),       (b,h) -> h+r(b),

where r chooses a preimage. Both inverse identities use pi(r(b))=b and pi(h)=0. At `:26–35` the finite sum is reindexed through this equivalence. Combining it with the explicit `Fin N`/`ZMod N` equivalence and the coefficient identity gives

    sum coefficients = card(kernel(pi))*card((O/modulus)^units).

The second factor comes from `MulChar.sum_one_eq_card_units` (inspected Mathlib `NumberTheory/MulChar/Basic.lean:616–628`), whose proof identifies the principal character with the unit indicator. It does not identify that character with the constant-one function on a general ring. The kernel contains zero and the group of units contains one, so both finite cardinalities are strictly positive. `PrincipalResidue.lean:10–33` preserves their real positivity as well as complex nonvanishing.

The top ideal is valid: its quotient is the singleton ring, with one unit. The singleton's zero equals one and is a unit. The unit-indicator formula therefore yields one, not zero. No `Nontrivial` hypothesis was inserted. The report's treatment of this edge case is correct.

## 2. Theta and Mellin normalization, including the sign

I checked `ThetaProduct.product` (`:33–52`), `rescale` (`:67–89`), and `rectangularPair` with its summation identity (`:128–159`). Rescaling f(t) to f(vt) changes epsilon by v^(-k), changes the dual argument to v^(-1)t, and leaves g0 unchanged. Each one-dimensional pair has k=1/2, epsilon=1, g0=1, as explicitly supplied by Mathlib `hurwitzEvenFEPair` (`HurwitzZetaEven.lean:256–278`).

The parity coordinate equivalence and quadratic-form identity are exact (`EisensteinTheta.lean:15–32`). For each residue class there are two parity pairs, with scales N^2 and 3N^2. The Gaussian series reindexing in `cosetTheta_hasSum` establishes summability before regrouping. `Hecke/Theta.finitePair` (`:19–46`) absorbs each original epsilon into the dual function and constant, then sets its own epsilon to one. Therefore its dual constant is exactly

    g0 = 2*d_N*sum coefficients,
    d_N=(N^2)^(-1/2)*(3N^2)^(-1/2)>0.

This agrees term-for-term with `pair_g₀` (`Hecke/Theta.lean:138–149`). No phase or root-number sign was dropped.

The inspected `WeakFEPair.Λ` definition is

    Λ(s)=Λ0(s)-f0/s-epsilon*g0/(k-s).

At k=epsilon=1 this is Λ0(s)-f0/s+g0/(s-1). Hence the residue at one is **+g0**. The library's `Λ_residue_k` has the same sign, and `differentiable_Λ₀` supplies the analytic regular part (`AbstractFuncEq.lean:381–440`). The author does not infer the sign from informal terminology.

`regularizedCompleted` in `Hecke/Theta.lean:183` is literally `(s-1)*(Λ0(s)-f0/s)+g0`. At one it equals g0. Multiplication by pi^s/Gamma(s), followed by division by six, gives pi*g0/6. `Hecke/Reciprocal.lean:48–65` states and proves these exact identities.

## 3. Actual poleRemoved join and period independence

The globally entire alternative is also correctly matched. `Hecke/MellinIdentity.lean:11–25` defines

    R(s)=s(s-1)Λ0(s)-(s-1)f0+s*epsilon*g0

and proves R(s)=s(s-1)Λ(s) for s!=0,1. `Hecke/Origin.lean:11–27` defines poleRemoved=pi^s/Gamma(s+1)*R(s)/6, proves it entire using reciprocal Gamma, and uses Gamma(s+1)=s*Gamma(s) to establish

    poleRemoved(s)=(s-1)*LFunction(s),   s!=0,1.

At one the direct formula gives pi*g0/6 because Gamma(2)=1 (`Origin:33–42`). The actual LFunction is continuedLattice/6 (`Hecke/IdealBridge.lean:95`); its ideal-series agreement is stated immediately afterward. No normalization change occurs in this local join. The deeper six-unit lattice/ideal correspondence is an inherited input, not revalidated here.

On a punctured disk around one of radius less than one, the identity above holds and poleRemoved is continuous. Its positive value at one is therefore the genuine limiting residue. The nonzero numerator gives a simple pole for the meromorphic function. None of this assigns an intended analytic value to the source's totalized raw LFunction at one.

Independently, cardinalities in the finite equivalence give N^2=q*k, where q is the quotient cardinality and k the kernel cardinality. `ZMod.card` and the product-cardinality identity apply since N>0. Positive real power identities give d_N=1/(sqrt(3)*N^2). Thus

    (pi/6)*2*d_N*k*u = pi/(3*sqrt(3)) * u/q.

All canceled factors are nonzero. The ideal norm equals quotient cardinality by the inspected `Ideal.absNorm_apply`; this includes the top ideal, where q=u=1. This is a valid paper consequence and not an assertion that the simplified formula is already a compiled theorem. It supplies positivity for every individual modulus, not a positive lower bound uniform over moduli.

## 4. Consumer and scope checks

`Hecke/LogarithmicInput.lean:11–48` uses, in the principal branch, `PrincipalStrip.sourceNormalized=poleRemoved/(s+1)` (`PrincipalStrip.lean:196–197`). Its value at one is half the positive residue. The source theorem `regular_ne_zero` has a wider beta-dependent domain, but its s=1 branch calls only the local `poleRemoved_one_ne_zero` result. The beta-free local proof was checked separately; the wider zero-free claim was not used to manufacture the residue.

The principal reciprocal `(s-1)/regularizedL(s)` has value zero at one. Its local holomorphy there follows from the differentiability and nonzero denominator just established. This is distinct from nonvanishing of poleRemoved. Importing ZeroSupremum in Reciprocal does not introduce a beta premise into the inspected proofs at lines 10–65. Equally, this source observation is not an axiom audit of the whole import closure.

The retained foundations are the actual integral basis and quotient finiteness, one-dimensional theta functional equation and decay, the general FE-pair Mellin/entireness results, Gamma facts, and the lattice-to-ideal identification. No error was found in finite positivity, parity factors, pole sign, period cancellation, or their local assembly. Those conclusions do not close unrelated QRH estimates or validate the provider.

## Evidence

All ten OAI and three Mathlib hashes in the author report matched their source bytes independently. Additional inspected source files for the consumer and period simplification are pinned below. Paths beginning `Hecke/` are relative to the OAI DirichletL root; other paths are relative to the inspected Mathlib root.

| Source | SHA256 |
|---|---|
| `Hecke/IdealBridge.lean` | `D64B454F8DE573198F360DD4B4647DF87916020D4F89ECB44EB9B18D162A567F` |
| `Hecke/LogarithmicInput.lean` | `9ADCC4FDE13E8A257CDC81F4A1DA752949FCFCF339B856A40411BFE901DC6F0D` |
| `Hecke/PrincipalStrip.lean` | `E0EB332CD6C696C75989C373A549836574C3AE0E31B0C43B39AC82CA314794E4` |
| `Data/ZMod/Defs.lean` | `759B056487B250CE8C2798155065A624C74BFC9764F3D76CE3CB089DC9872ED6` |
| `RingTheory/Ideal/Norm/AbsNorm.lean` | `2507F0CAB94525D81BE5527CCFFF7DC8C02F32811F30A973645B7E262032BF52` |
