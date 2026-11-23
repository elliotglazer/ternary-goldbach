# Actual local characters and Gauss transforms

Date: 2026-11-11. This is a bounded source/mathematics audit. No Lean build, source edit, or numerical evaluation was performed. Paths in the text are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`; the final table pins the inspected files.

## Verdict and scope

No defect was found in the three requested mechanisms: the canonical sextic character's nontrivial powers, the finite product Gauss transform, and its scalar CRT form. The actual cubic-sieve consumption also preserves the needed distinctions. A transform identity requires nontrivial multiplicative characters but not primitive additive characters. Its Gauss norm conclusion does require additive primitivity. The full order-six claim needs residue characteristic different from 2, whereas the initial cubic sieve uses only powers 2 and 4 and proves their nontriviality without that extra condition.

This verdict concerns the inspected constructions and reductions. Generic finite-field character theory, the ring-of-integers/finite-quotient infrastructure, and the analytic lattice Poisson theorem remain explicit foundations. It is not an audit of the complete energy argument or of the provider's build and axioms.

## 1. The canonical character is an actual residue character

In `GaussSum/FiniteFourier.lean:485–503`, the ring is the integers of `CyclotomicField 3 ℚ`, with a specified primitive cube root `omega` and `lambda = omega - 1`. For a maximal ideal P, the quotient is a finite field. The hypothesis `lambda ∉ P` proves that the reduction of omega is still a primitive cube root (line 528): its cube is 1 and it is not 1. Consequently 3 divides q−1, where q is the quotient cardinality.

The construction at lines 377–477 does not choose an arbitrary nontrivial character. Reduction restricts to an equivalence between the two groups of cube roots of unity. Surjectivity follows by expressing a quotient cube root as a power of the specified reduced omega; equal cardinalities then give bijectivity. With m=(q−1)/3, the homomorphism on quotient units sends u to u^m, regarded as a quotient cube root, and lifts it through the inverse root equivalence. `MulChar.ofUnitHom` extends this map by zero on nonunits. This gives `cubicChar` at line 565.

The source proves both the reduction identity and nontriviality. If the character were principal, every quotient unit would satisfy u^m=1. `FiniteField.forall_pow_eq_one_iff` would imply q−1 divides m; since q−1=3m and m>0, this is impossible. Its cube is the principal MulChar, so its order is exactly 3 (`cubicChar_order`, line 648).

At lines 788–829, the sextic character is

\[
 \chi_6=\chi_3^2\chi_2,
 \qquad \chi_6^2=\chi_3,\quad
 \chi_6^3=\chi_2,\quad \chi_6^6=1.
\]

Here the quadratic character is the actual finite-field quadratic character, with values transported from integers into the ring of integers. When the residue characteristic is not 2, it is nonprincipal. `sexticChar_order` at line 1287 excludes orders 1, 2 and 3 using the displayed powers, and excludes the other possibilities by divisibility into 6. Thus the order is exactly 6.

`Arithmetic/EisensteinEmbedding.lean:461` defines `canonicalSextic` by composing this ring-valued character with the concrete Eisenstein embedding into ℂ. The embedding is injective. Transport of powers and nonprincipality therefore gives `canonicalSextic_pow_ne_one` at line 471 for exactly 0<j<6, under both `lambda ∉ P` and residue characteristic ≠2. The neighboring `pow_six` theorem does not require characteristic ≠2. There is no identification of this concrete embedding with an arbitrary complex embedding in this proof.

All these identities use MulChar multiplication. Its identity is the principal unit indicator, not a function equal to 1 at zero. This is essential for the zero cases below.

## 2. Local transform, including zero frequency

`ShortDraftFiniteGaussFourier.gauss_transform` at `GaussSum/FiniteFourier.lean:23` states, for a finite field F, a nonprincipal complex MulChar χ, and any AddChar ψ,

\[
 \sum_{x\in F}\chi(x)\psi(hx)
 =\begin{cases}0&h=0,\\\chi(h)^{-1}G(\chi,\psi)&h\ne0.\end{cases}
\]

At h=0, ψ(0)=1 and the proof uses the nonprincipal-character sum equal to zero. At h≠0, h is a unit, and the Gauss sum change of variables supplies the inverse-character multiplier. No division by an unproved nonzero Gauss sum occurs. In particular ψ is allowed to be trivial: the identity remains valid even when the Gauss sum vanishes.

`product_gauss_transform` at line 35 first expands the finite sum over a product of fields as the product of the coordinate sums, using `Fintype.prod_sum`. It then applies the local formula coordinate by coordinate. Each input tuple is counted once, with no cardinality factor and no infinite-sum operation.

The zero exponent is deliberately outside the nonprincipal theorem. `Arithmetic/EisensteinEmbedding.lean:438–458` handles j=0 separately: for primitive ψ, the transform at nonzero h is −1; at zero h it is q−1. These are the principal unit-indicator formulas, not the transform of the constant-one function.

## 3. CRT phases and scalar collapse

Let e:T≃∏F_i be the actual ring equivalence. At `Poisson/EisensteinLattice.lean:507`, the coordinate additive character is defined by

\[
 \psi_i(z)=\psi(e^{-1}(\operatorname{single}_i z)).
\]

The CRT idempotents are therefore present in the definition. The decomposition of x as the sum of these lifted coordinate vectors proves ψ(x)=∏ψ_i(e(x)_i). Applied to hx, the coordinate argument is exactly e(h)_i e(x)_i. Neither a sign change nor a character conjugation is inserted by CRT.

`gauss_transform_finite_crt` transports the finite sum along e and applies the preceding product theorem. At line 563, `gauss_transform_finite_crt_scalar` evaluates the same formula at h=1 to identify the base Gauss sum, and obtains

\[
 \sum_{x\in T}R(x)\psi(hx)
 =R(h)^{-1}\sum_{x\in T}R(x)\psi(x),
 \qquad R(x)=\prod_i\chi_i(e(x)_i).
\]

This is valid for nonunit h as well. If a coordinate of h is zero, its nonprincipal transform is zero; the corresponding character value is zero and complex `0⁻¹=0` makes the scalar expression zero. The proof does not cancel R(h). If the index type is empty, T is the singleton ring supplied by the equivalence, and both sides are 1. A blanket claim that the transform vanishes at h=0 would be false in that empty case; the source formula does not make that claim.

For ideal quotients, `quotientProdEquivPi` at line 595 uses pairwise coprimality to identify the product of ideals with their intersection, then invokes the quotient CRT. Its `mk` lemma proves that a residue of a is sent to the residues of the same a. Maximal ideals supply the field factors. Repeated or noncoprime ideals cannot silently enter this theorem.

`GaussSum/SexticRadialPoisson.lean:80–175` uses this exact equivalence for the actual sextic product row. It proves that the row vanishes precisely when the represented element belongs to at least one selected prime ideal. Its inverse equals its complex conjugate, by the finite complex MulChar identity, including at zero. The conjugation in the resulting transform is a conjugation of the row multiplier; it does not reverse the additive character. A convention using ψ(−hx) is obtained explicitly by shifting ψ by −1, as the earlier local Fourier lemmas do.

## 4. Actual trace character and Gauss norm

`ChineseRemainder/AdditiveCharacters.lean:512` defines

\[
 \breve e(z)=\exp(2\pi i(z+\bar z)).
\]

`GaussSum/ChineseRemainder.lean:439–476` constructs the quotient character from the raw function x↦breve e(ι(x)/(ι(c)λ_tr)), proving its period on the principal ideal before descending to the quotient. Here λ_tr=1+2ω in the concrete complex embedding; it must not be confused with the good-prime element ω−1. The source proves they are unit associates at `GaussSum/FiniteFourier.lean:507–526`, and `Arithmetic/EisensteinEmbedding.lean:287` supplies the actual coordinate period.

For every nonzero c, `GeneralPrimitiveTrace.eisTraceModChar_breveE_primitive` at `PrimeRows/IdealGenerators.lean:383` proves primitivity directly. If a nonzero residue x annihilated all additive shifts, applying the shift to 1 and omega would show that both trace phases of z=ι(x)/ι(c) are integers. The explicit reconstruction at line 354 writes z as an integral combination of 1 and omega. Surjectivity onto this coordinate lattice gives z=ι(q); injectivity then gives x=cq, contradicting the residue's nonzeroness. The argument handles every nonzero principal modulus, not only prime ones. For a unit modulus, primitivity is vacuous on the singleton quotient, consistently with the transform formulas.

`coordinateAddChar_isPrimitive` at `PrimeRows/IdealGenerators.lean:423` passes primitivity to each CRT coordinate: a hypothetical annihilating coordinate a lifts to the nonzero vector e⁻¹(single_i a), which would annihilate the global character. This checks the needed premise rather than treating an arbitrary coordinate AddChar as primitive.

The norm calculation at line 453 uses

\[
 |G(\chi_i,\psi_i)|^2=|F_i|,
 \qquad |G(R,\psi)|^2=\prod_i|F_i|=|T|.
\]

`Cusp/MatrixPhases.lean:120` obtains the first equality from the standard Gauss product identity and its conjugation formula, with both nonprincipal χ and primitive ψ explicit. The CRT product calculation then restores the quotient cardinality exactly.

In `CubicSieve/Poisson.lean:168–215`, this gives the actual unnormalized Gauss norm |ι(c)| because |O/(c)|=|ι(c)|². The normalized Gauss sum divides by |ι(c)|, which is nonzero because the finite product modulus is nonzero, and has norm 1. It would be invalid to infer this norm merely from the transform identity with arbitrary ψ; the source supplies the stronger hypotheses at this step.

## 5. Consumption by the original and cubic rows

The sextic Poisson interface retains the explicit characteristic≠2 and 0<j<6 hypotheses. The cubic-sieve version accepts the more direct premise that each actual local power is nonprincipal. `CompletedGauss.actualSextic` is an abbreviation of `canonicalSextic` (`CubicSieve/RowCaps.lean:204`), and `goodLambda` is the same ω−1 (`PrimeRows/NormFiberExtraction.lean:110`). There is no alternate unconnected character at this interface.

For the initial cubic sieve, `CubicSieve/Poisson.lean:305` proves nonprincipality of powers 2 and 4 from `canonicalSextic_pow_two = cubicChar` and the cubic character's exact order 3. Thus this use genuinely does not require characteristic≠2. `CubicSieve/Initial.lean:13–85` squares the finite squarefree row, gives the active exponents 4 and 2, and retains the coprime mask on the intersection of the two supports. Only unequal supports yield a nonempty active set; this explicit condition is supplied for the off-diagonal estimate. It avoids incorrectly applying zero-frequency vanishing to an empty active product.

The radial Poisson substitution at `CubicSieve/Poisson.lean:81–165` uses the actual trace character, row and positive scale. Its unnormalized prefactor is scale/|ι(c)|²; inserting the normalized Gauss sum changes it to scale·G_norm/|ι(c)|. No quotient cardinality, unit count or square root is omitted in this finite algebraic conversion. The analytic Poisson identity and convergence supporting the surrounding infinite sum are consumed here, not re-proved in this local audit.

## Remaining foundations

The checked mechanisms terminate at named, ordinary foundations: `MulChar.ofUnitHom`, character orthogonality and change of variables, finite-field unit-power/quadratic-character facts, Gauss product/conjugation identities, finite ring CRT, the concrete cyclotomic embedding and its coordinate basis, and the actual analytic lattice Poisson theorem. Their required assumptions are exposed in the inspected callers. This report does not recursively certify those library results, all later sieve estimates, or the full QRH provider.

## Source pins

The following SHA-256 values bind this source audit, not a tested build.

| File | SHA-256 |
|---|---|
| Arithmetic/EisensteinEmbedding.lean | `37D3AFD1026BDB466677BCC0FAC8173B93B59865AACEF456D9CE5CABD362242C` |
| GaussSum/FiniteFourier.lean | `BB2039A8A9125DE0519AA08E3B277F1E4513F7C6AC952B5B5E5373C14D725E12` |
| Poisson/EisensteinLattice.lean | `CC52C9B695ECEC6ECD54AD79C8870CD36A53E99D94BF6B3D5F3A04093DC99D69` |
| GaussSum/SexticRadialPoisson.lean | `8DB6F0F3B850868F18706630A4F8F1DA42A345D2F0D32949B8D4CC6CB0F5D21C` |
| GaussSum/ChineseRemainder.lean | `82669D0AD1108ECA0C5E0DFB6E073A67D0B64AC7C5D2B39B155FB79B4B2CECA0` |
| ChineseRemainder/AdditiveCharacters.lean | `A4BFF8663A80E4B542438F5FEA067CA22B69C4F3333FACCFAA320187C3BF2D96` |
| PrimeRows/IdealGenerators.lean | `FFD100322A61D78A44F28CE7EDEA6E7CC756D7055C5710B42809B1B2AA016949` |
| Cusp/MatrixPhases.lean | `EF13178B21FAC195559255DEEB756E6704C027E685465D2EF720AE62D6AB50B7` |
| CubicSieve/Poisson.lean | `2A10C842C07951230927A3D046BD65C2A71F9F739A1401BC74B20CACA16669CF` |
| CubicSieve/Initial.lean | `D76A296A7D19D528C0EBBC93BD6D8ABA750F17201A538ECA808923172509DCD0` |
| CubicSieve/RowCaps.lean | `0EC9465BA4A0C1980EE772BD6E56CBF490129DC240A3F029AB2292D65E7FDD21` |
| PrimeRows/NormFiberExtraction.lean | `60D8BA6CAE8F7A5797C6DAE1B72049279673BF18527ED9CC37FCCB5AA741F35B` |
| GaussSum/CubicNormalization.lean | `DE04E573BD90BA00B0C545F030C01F7ED0D8CCD4BCD5D0107B53D95DD5EB6915` |
