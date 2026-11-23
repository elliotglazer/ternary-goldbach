# Actual principal residue at one

2026-11-11. Bounded source/mathematical audit. No Lean invocation, analytic evaluation, source edit, or change to an earlier report was made.

Verdict: the principal pole-removed nonvanishing at one follows from an explicit positive finite residue formula. There is no arbitrary nonzero-residue hypothesis, no primitivity requirement, and no use of a zero-free region in this local proof. The actual theta/Mellin normalization and its connection to the continued L-function are retained. The library theta and Mellin foundations and target-version kernel validation remain separate from this source verdict.

The OAI source base below is `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, revision `4eaee87548250b2682affda7d05d947c05554bae`. Mathlib references are to the inspected target source at revision `56a005855ea17e0b0958f73ec801ae140b0a1679`, under `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/`. OAI's manifest instead names `d13f23b723b8a846827a245b89c10fc7d3f11612`; this audit does not establish elaboration compatibility between those versions.

## 1. Exact formula and quantifiers

Let \(\chi\) be `HeckeFamily.Character`, with ideal modulus \(\mathfrak m\ne0\), positive integer period \(N\), and principal residue character `chi.residue = 1`. Put

\[
 R_\mathfrak m=\mathcal O/\mathfrak m,\qquad
 q=|R_\mathfrak m|,\qquad u=|R_\mathfrak m^\times|,
\]
and let
\[
 \pi_N:(\mathbb Z/N\mathbb Z)^2\longrightarrow R_\mathfrak m
\]
be the source additive coordinate map. Write \(k=|\ker\pi_N|\). The inspected definitions give

\[
 \mathrm{poleRemoved}(\chi,1)
 =\frac{\pi}{6}\left(2d_Nku\right)>0,
 \qquad
 d_N=(N^2)^{-1/2}(3N^2)^{-1/2}.
\tag{1}
\]

The equality is an equality in \(\mathbb C\) with the positive real quantity on the right embedded in \(\mathbb C\). It proves more than mere nonvanishing. `Hecke/PrincipalResidue.lean:35`, `principal_residue_positive`, already states this positivity in existential-real form. The local theorem consumed by the logarithmic-control route is `Hecke/Origin.lean:40`, `poleRemoved_one_ne_zero`, via `Hecke/Reciprocal.lean:61`, `regularizedL_ne_zero_at_one`.

No theorem in this chain assumes `IsPrimitiveOnIdeals`. It applies to a principal character for every nonzero ideal modulus, including an imprimitive principal character. It asserts no common positive lower bound for (1) over all moduli.

## 2. The finite sum cannot vanish

`Hecke/Family.lean:22` includes the actual period hypotheses \(N>0\) and \(N\in\mathfrak m\). `Hecke/Coordinates.lean:48` uses the latter to descend the integer quotient map to `ZMod N`. At line 61 the coordinate map is

\[
 (a,b)\longmapsto a+b\omega\pmod{\mathfrak m}.
\]

Surjectivity at line 74 comes from `coordinateElement_surjective:20` and surjectivity of the ideal quotient. The former expands each integer of the Eisenstein field in its integral power basis \(1,\omega\); its basis dimension is two. This is an actual arithmetic map, not an assumed equidistribution statement.

The coefficients in `Hecke/Family.lean:50` are the residue character evaluated at these coordinates. `coefficients_eq_quotient_character:82` identifies their finite `Fin N × Fin N` indexing with the additive quotient map. The equivalence `finCastEquiv` in `CharacterAnalytic.lean:42` preserves every term.

For a surjective homomorphism of finite additive groups, `CharacterAnalytic.additiveFiberEquiv:9` explicitly chooses a lift \(r(b)\) of each image element and constructs

\[
 a\longmapsto\bigl(\pi_N(a),a-r(\pi_N(a))\bigr),
 \qquad (b,h)\longmapsto h+r(b).
\]

Thus every fiber has cardinality \(k\). Its finite-sum consequence at line 26 is

\[
 \sum_a f(\pi_N(a))=k\sum_b f(b).
\]

The principal multiplicative character is one on units and zero on nonunits. It is not generally the constant-one function on the entire quotient ring. Mathlib `NumberTheory/MulChar/Basic.lean:616`, `MulChar.sum_one_eq_card_units`, proves that its full residue sum is \(u\). Therefore the actual coefficient sum is

\[
 \sum_{a\in(\mathrm{Fin}\,N)^2}w(a)=ku.
\tag{2}
\]

Both factors are positive integers. The kernel contains zero; the unit group contains one. Their finiteness follows from the finite source group and finite ideal quotient. The source uses `Nat.card_pos` and `Fintype.card_pos`, not a character-sum cancellation heuristic. `Reciprocal.coefficients_sum_ne_zero_of_principal:10` proves nonzero directly from (2). `PrincipalResidue.coefficients_sum_positive:10` repeats the same identification to retain positivity.

The top ideal is not silently excluded. Its quotient is the one-element ring, whose unit group is also one-element; the unique element is a unit. Accordingly its principal character sum is one, and (2) remains valid. No inappropriate `Nontrivial` assumption or claim that a principal character always vanishes at zero is used.

## 3. Why the dual theta constant is exactly \(2d_N\sum w\)

`Hecke/Theta.lean:68` builds the actual theta pair as a finite weighted sum of two parity pairs for each residue coordinate. Its `finitePair:19` sets \(k_{\rm FE}=1\) and \(\varepsilon=1\), and incorporates each component's original epsilon into the dual function and dual constant. In particular, the combined pair has no remaining complex root-number ambiguity in its residue.

`EisensteinTheta.lean:27` gives the exact quadratic-form identity

\[
 x^2-xy+y^2
 =N^2(i+x_0)^2+3N^2(j+y_0)^2
\]
under its explicit parity coordinate substitution. `parityEquiv:21` is a bijection, so there are exactly two parity classes, not an approximate density factor. `cosetTheta_hasSum:43` proves the reindexed Gaussian series identity with summability before exchanging its sums.

The one-dimensional input is Mathlib `HurwitzZeta.hurwitzEvenFEPair`, `NumberTheory/LSeries/HurwitzZetaEven.lean:256`. Its weight is \(1/2\), epsilon is one, and dual constant is one. `ThetaProduct.rescale:67` changes epsilon by \(v^{-1/2}\) when scaling the positive theta argument by \(v\), while preserving its dual constant. `ThetaProduct.product:33` multiplies the two epsilons and dual constants, and adds their weights. Hence each parity pair contributes

\[
 (N^2)^{-1/2}(3N^2)^{-1/2}=d_N.
\]

Both parity classes have this same dual constant, independently of the coordinate shifts. The finite-pair definition therefore gives

\[
 (\mathrm{pair}\,w).g_0=2d_N\sum_a w(a).
\tag{3}
\]

This is exactly `Hecke/Theta.pair_g₀:138`. Its source proof unfolds the product/rescaling definitions and sums the two parity terms. `Reciprocal.dualScalar_ne_zero:35` uses \(N>0\); `principal_dual_constant_ne_zero:42` then combines it with (2). Positivity in (1) uses the positive real powers, not only their complex nonvanishing.

This audit checked the finite/product/rescaling and parity assembly. The underlying one-dimensional theta functional equation, kernel regularity, and decay assertions in `hurwitzEvenFEPair` remain library inputs. The inspected library constructor supplies them through `evenKernel_functional_equation` and the even/cosine kernel decay theorems; they are not additional residue assumptions.

## 4. Mellin pole sign and L-function normalization

For a `WeakFEPair` of weight one and epsilon one, the actual library definition, `AbstractFuncEq.lean:381`, is

\[
 \Lambda(s)=\Lambda_0(s)-f_0/s-g_0/(1-s)
 =\Lambda_0(s)-f_0/s+g_0/(s-1).
\tag{4}
\]

The sign of the residue at one is therefore positive \(g_0\). The library proves \(\Lambda_0\) entire at line 391, proves agreement with the Mellin transform on the convergent half-plane at line 407, and gives the corresponding punctured residue limit in `Λ_residue_k`. These depend on the pair's actual integrability, decay, and functional-equation fields.

`Hecke/Theta.regularizedCompleted:183` defines
\[
 (s-1)(\Lambda_0(s)-s^{-1}f_0)+g_0.
\]
At \(s=1\) this is literally \(g_0\), with no division by zero. For \(s\ne0,1\), it equals \((s-1)\Lambda(s)\). `regularizedLatticeL:203` multiplies it by \(\pi^s/\Gamma(s)\). Finally `HeckeReciprocal.regularizedL:48` divides by six. Since \(\Gamma(1)=1\), the exact value at one is \(\pi g_0/6\), as stated in `regularizedL_at_one:57`.

The six is the same six-unit normalization in `HeckeFamily.LFunction`, whose definition is the continued lattice L-function divided by six. The prior primitive-log audit traces its equality with the actual ideal Dirichlet series. There is no switch to a new L-function in this residue proof.

For an entire pole-removed function, `Hecke/MellinIdentity.lean:11` instead defines
\[
 s(s-1)\Lambda_0(s)-(s-1)f_0+s\varepsilon g_0.
\]
`Hecke/Origin.poleRemoved:11` multiplies this by \(\pi^s/\Gamma(s+1)\) and divides by six. The entire reciprocal Gamma function makes this expression entire, including zero. At one, \(\Gamma(2)=1\) and \(\varepsilon=1\), so the result is again \(\pi g_0/6\). This is `Origin.poleRemoved_one:33`. Away from zero and one, `poleRemoved_eq:23` uses the Gamma recurrence to recover \((s-1)L(s)\).

Consequently (1) is an actual residue statement, not an arbitrary assigned regularized value. In a punctured neighborhood of one avoiding zero, \((s-1)L(s)=\mathrm{poleRemoved}(s)\). Continuity of the entire right side gives the limit (1). Its nonzero value means the meromorphic L-function has a simple pole at one. No assertion about the source's totalized raw value `LFunction chi 1` is needed.

## 5. Period independence and exact consumer consequences

There is a useful paper consequence beyond nonvanishing. Taking cardinalities in the explicit additive fiber equivalence gives
\[
 N^2=qk.
\]
Since \(N>0\), \(d_N=1/(\sqrt3N^2)\), so (1) simplifies to
\[
 \operatorname*{Res}_{s=1}L(s)
 =\frac{\pi}{3\sqrt3}\frac{u}{q}.
\tag{5}
\]
Here \(q\) is the finite quotient cardinality, equivalently the absolute ideal norm. This calculation needs only the already constructed finite equivalence, `card (ZMod N)=N`, and positive real-power identities. It explains why the auxiliary period cancels. Formula (5) is a derived paper consequence, not a claim that an identically named Lean theorem was found or compiled. No Euler-product evaluation of \(u/q\) is needed.

The consumers only require positivity or nonzero, not a quantitative lower bound. `Origin.poleRemoved_one_ne_zero` proves this for the principal branch of `LogarithmicInput.regular_ne_zero`. Since its regular function is `poleRemoved/(s+1)`, its value at one is half the positive residue. `HeckeReciprocal.reciprocal` has principal value zero at one and is locally holomorphic there, using the nonzero denominator just established. These are distinct functions and distinct assertions.

Although `Hecke/Reciprocal.lean` imports `ZeroSupremum`, the inspected proofs through `regularizedL_ne_zero_at_one` do not use beta, QRH, boundary nonvanishing, or an Euler-product lower bound. The later `regularizedL_ne_zero` and `reciprocal_differentiableAt` use beta for other points; that later use does not enter the residue argument. Import reachability alone must not be mistaken for a circular mathematical premise, and it also does not establish a transitive kernel-axiom verdict.

## 6. Remaining boundaries and source pins

The bounded assembly has no unresolved positivity or pole-normalization step. The underlying integral power basis and ideal quotient finiteness, one-dimensional theta equation and kernel estimates, general weak-FE-pair Mellin theorems, Gamma identities, and the lattice-to-ideal six-unit identification remain mathematical/library inputs at the stated read depth. Full provider validation still requires the other analytic/arithmetic parts of the QRH proof, compatible elaboration, and exact transitive axiom inspection.

All hashes below pin whole-file bytes; they do not assert full audit of every declaration or import in those files.

| Source under OAI base | SHA256 |
|---|---|
| `Hecke/Origin.lean` | `D42011FD72DAEACF02EAD1440212E55E3E722031B82983782D1E5948CF78F33D` |
| `Hecke/Reciprocal.lean` | `4161F072933BAAC5769ADAD68ACF0B8B3C45BD75FFFACF6152587AE001355D68` |
| `Hecke/PrincipalResidue.lean` | `A1EB8F4D91501D0A83A71154F6FFB65C3C76D7F2102581988D95C200757C2ABA` |
| `Hecke/Coordinates.lean` | `A639985CCD722DD74757987BD6DE0BB635B8E12C12ECFD6306570018A48E4F01` |
| `Hecke/CharacterAnalytic.lean` | `A439B16326E73782045166626B22BE9D84A95D23774E5326B390BC1874EFCC6A` |
| `Hecke/Theta.lean` | `69668551F9379A136381A5DCF45D773DCCDC9AE70DD423CB91698E298D43E514` |
| `Hecke/MellinIdentity.lean` | `D2BE4ED6CFDF938AB40172FC0F13EFE45E5AF8583BD38FE392494C27F563F3CD` |
| `Hecke/Family.lean` | `B18557C5C055910287507F1ED2B1F7BB31EDE318CB62A2A10A3140F1995A9408` |
| `EisensteinTheta.lean` | `65BEA1D1A235635EF6043CB3BEE163E19964869FDF03F2EF278B74C91ADE8B59` |
| `ThetaProduct.lean` | `13B1D4BD11C9814CBD92619365AE4F364888D760F9C6B3B63902232BA693E227` |

| Source under inspected Mathlib base | SHA256 |
|---|---|
| `NumberTheory/MulChar/Basic.lean` | `1C31A9810F59DB8CDCDEEF50D20EFEAA0C70CF24B5C2448356AD1FF5EC240915` |
| `NumberTheory/LSeries/AbstractFuncEq.lean` | `9FD5A09427DA6EEE9DF1C1E8A45D4803BE7ED488D4B5924C58F9C3E61249EB07` |
| `NumberTheory/LSeries/HurwitzZetaEven.lean` | `A55187C4FC35149EB5ACF82C7625849525E60F520D71A3E428FB2272DEFAC814` |
