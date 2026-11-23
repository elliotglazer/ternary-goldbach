# Independent review of local Gauss transforms and the canonical sextic character

Verdict: PASS within the bounded mathematical/source scope, with no correction requested. I read the frozen author report `zero-sum/QRH_LOCAL_GAUSS_CHARACTER_AUDIT_2026-11-11.md`, SHA256 `4E66D3846AADA090DEE312D3CB9AFDA6D603251BBFFE64D33EC5FDC42577027C`, and verified all 13 of its source hashes. This review does not validate the full QRH provider or assert successful Lean elaboration.

The source baseline is `work/openai-math`, HEAD `4eaee87548250b2682affda7d05d947c05554bae`. Source paths below are relative to `lean/OAI/NumberTheory/DirichletL/`.

## 1. The actual sextic character has order six under the stated exclusions

The target `Arithmetic/EisensteinEmbedding.lean:471–480` proves that `canonicalSextic P hgood ^ j ≠ 1` for a maximal ideal `P`, `lambda ∉ P`, residue characteristic different from 2, and `0 < j < 6`. The construction at lines 461–463 is the source's algebraic sextic character followed by the concrete injective embedding of the Eisenstein integers into the complex numbers. It is not an arbitrarily chosen finite-field character.

I traced the algebraic character in `GaussSum/FiniteFourier.lean`. At lines 529–564, `lambda = omega - 1` not lying in `P` makes the reduction of `omega` a primitive cube root. Hence 3 divides the order of the finite residue field's unit group. At lines 372–477 and 566–606, reduction gives a bijection between the two groups of cube roots of unity. Its inverse lifts the finite-field homomorphism `u ↦ u^m`, where `3m = #F - 1`. `MulChar.ofUnitHom` extends this homomorphism by zero on nonunits. The reduction formula is checked separately at zero, where `m>0` is used.

Nontriviality at lines 623–647 is substantive. If the cubic character were principal, all units would satisfy `u^m=1`. The finite-field exponent theorem would force `#F-1` to divide `m`, contrary to `#F-1=3m` and `m>0`. This uses a standard finite-field group theorem, not an assumption of a nonzero Gauss sum.

The actual sextic character is `cubicChar^2 * quadraticCharO` at lines 801–803. Its square is the cubic character, its cube is the quadratic character, and its sixth power is the principal character, as checked algebraically at lines 805–827. The characteristic-two exclusion ensures the quadratic character is nonprincipal. Therefore its order divides six but is neither one, two, nor three; `sexticChar_order` at lines 1287–1321 concludes that it is six. Composing with an injective ring homomorphism preserves the nonprincipal powers. The concrete embedding injectivity is given at `Arithmetic/EisensteinEmbedding.lean:155–156` by coordinate uniqueness and nonzero imaginary part of the chosen cube root.

The distinction between the hypotheses matters. The sixth-power identity alone does not require characteristic different from two. Exact order six and nontriviality of every power 1 through 5 do. No statement for `j=0` or `j=6` follows from the target nontriviality theorem.

## 2. Local and product transforms, including zero frequency

For a finite field `F`, a nonprincipal multiplicative character `χ : MulChar F ℂ`, and any additive character `ψ`, the source proves

\[
 \sum_{x\in F}\chi(x)\psi(hx)
 =\begin{cases}0&h=0,\\\chi(h)^{-1}G(\chi,\psi)&h\ne0.\end{cases}
\]

This is `GaussSum/FiniteFourier.lean:22–33`. At zero frequency the additive character equals one and the sum of the nonprincipal multiplicative character is zero. At nonzero frequency multiplication by `h` is a bijection; the standard shifted Gauss-sum identity applies to its associated unit. Thus no additive primitivity or nonvanishing of the Gauss sum is required for this equality. In particular the equality remains valid for the trivial additive character, when the Gauss sums vanish.

`product_gauss_transform` at lines 35–52 is an exact finite Fubini identity followed by this local identity for each field. It keeps every factor, including a zero factor when any frequency coordinate is zero. It is an unnormalized sum: no cardinality factor is missing. An empty index type is allowed. Its product ring is a singleton, and both sides are one. A claim that all zero frequencies force vanishing would therefore need a nonempty index hypothesis; the source's displayed product formula needs none.

The principal multiplicative character is a unit indicator, not the constant-one function on the entire field. The source correctly handles `j=0` separately in `Arithmetic/EisensteinEmbedding.lean:432–457`. At zero frequency its sum is `#F-1`. At nonzero frequency the value `-1` uses additive primitivity, via nontriviality of the shifted additive character. These cases cannot be silently included in the nonprincipal theorem.

## 3. CRT retains the actual phase and permits nonunit frequencies

In `Poisson/EisensteinLattice.lean:507–536`, for a ring equivalence `e : T ≃+* ∏i R_i`, the coordinate additive character is defined by

\[
 \psi_i(z)=\psi(e^{-1}(\operatorname{single}_i z)).
\]

This retains the CRT idempotent in each phase. Since `x` is the sum of these coordinate lifts, the global additive character factors into their product. Applied to `hx`, the coordinate argument is exactly `e(h)_i e(x)_i`. No additional inverse, minus sign, or conjugation is inserted. If a consumer wants a negative Fourier phase, it must put that sign into `ψ` or `h`; the general identity does not change conventions for it.

The finite CRT transform at lines 538–561 first factors the summand, then reindexes using the full ring equivalence, then invokes the product theorem. The scalar form at lines 563–585 specializes the transform at `h=1` to identify the constant Gauss factor. It replaces each piecewise local expression by `χ_i(e(h)_i)^{-1}G_i`, which is valid also at zero since `χ_i(0)=0` and complex inverse is totalized with `0^{-1}=0`. It then distributes finite products. There is no division cancellation by the global character value and no assumed nonvanishing of the scalar Gauss factor.

At lines 587–623 the ideal CRT equivalence uses pairwise coprime ideals to identify their finite product with their infimum, followed by the quotient CRT. Maximality supplies fields in the intended application. Repeated identical maximal ideals cannot be passed as pairwise coprime. The source does not claim this product-of-fields formula for arbitrary prime powers.

`GaussSum/SexticRadialPoisson.lean:60–82,113–150` supplies the canonical powers' nontriviality and defines the actual product row. Its inverse-to-conjugate conversion uses the finite-character identity also at zero. The zero criterion at lines 100–111 says exactly that at least one local ideal divides the input, and the vanishing corollary retains this witness. `CubicSieve/Poisson.lean:13–42` also offers a version with the local nontriviality proofs supplied directly; that is a valid more general interface and does not manufacture them.

The cubic-only consumer is less restrictive than the full order-six theorem. `CubicSieve/Poisson.lean:303–329` proves nontriviality of powers 2 and 4 using only the nontrivial order-three cubic character and `lambda ∉ P`. It does not need the characteristic-two exclusion. `CubicSieve/Initial.lean:26–75` selects exactly those exponents on the active support and retains the coprimality mask on the intersection. Its off-diagonal application separately obtains nonempty active support from `S ≠ T`. I checked this distinction; the downstream analytic Poisson and Polya–Vinogradov estimates remain outside the present finite-character audit.

## 4. Norm estimates have stronger, explicitly consumed hypotheses

The transform identities above alone do not prove a nonzero Gauss sum or square-root magnitude. For that separate conclusion, `Cusp/MatrixPhases.lean:120–147` uses both `χ ≠ 1` and `ψ.IsPrimitive`. The Gauss-product identity and conjugation identity give

\[
 G\overline G=\#F,
 \qquad |G|=\sqrt{\#F},
\]

and positive field cardinality permits normalization. No division by zero occurs.

`PrimeRows/IdealGenerators.lean:423–451` proves that a primitive global additive character induces primitive coordinate characters. If a nonzero coordinate `a` annihilated the coordinate character, the nonzero global element `e^{-1}(single_i a)` would annihilate the global character, a contradiction. Lines 453–471 then multiply the local norm squares and use `#T=∏i #R_i`. This proof also handles an empty product, with cardinality and norm square equal to one.

The canonical application at lines 478 onward obtains global primitivity from `GeneralPrimitiveTrace.eisTraceModChar_breveE_primitive`, lines 383–417. I inspected this adapter: two annihilating phases force the embedded quotient `embedding(x)/embedding(c)` into the Eisenstein coordinate lattice; embedding injectivity then proves `c | x`, contradicting a nonzero residue. The two-phase reconstruction and the standard Fourier-character period criterion remain explicit foundations. `Detector/Calibration.lean:113–146` likewise supplies primitivity before invoking the norm theorem; `CalibrationFourier.lean:27–52` does not need it for its scalar transform equality. These are different uses, with no mismatch of assumptions found.

I also checked the scalar normalization at `CubicSieve/Poisson.lean:128–215`: quotient cardinality is the squared modulus of the embedded generator, and its nonzero proof precedes division. Factoring the raw Gauss sum from the radial identity changes the prefactor from `scale / |embedding(c)|²` times the raw sum to `scale * Gnorm / |embedding(c)|`. The normalized Gauss sum has norm one by the separate primitive-character norm calculation. This algebra does not itself establish the surrounding infinite-sum Poisson theorem.

## 5. Scope and source foundations

This is a bounded audit of the actual character construction, finite field reindexing, finite products, CRT phase decomposition, zero/nonunit cases, and immediate norm adapters. The standard foundations include finite-field exponent and quadratic-character theorems, roots-of-unity cardinality, finite character orthogonality and shifted Gauss sums, ring CRT, and the concrete Eisenstein coordinate/embedding facts. They have not been recursively revalidated here. These finite algebraic steps assume no analytic zero-free region and do not prove any of the remaining global energy estimates.

For signature inspection only, I read cached Mathlib `NumberTheory/GaussSum.lean:72–86,186–218`. Its shifted identity has no additive-primitivity hypothesis; its nonvanishing and product-norm identities do. The cache is at revision `56a005855ea17e0b0958f73ec801ae140b0a1679`, while the target manifest requests `d13f23b723b8a846827a245b89c10fc7d3f11612`. No build or compatibility assertion is made. No analytic function values or finite-field numerical experiments were computed.

## Source pins

The table pins the independently inspected source bodies. All 13 author source pins also matched.

| Source | SHA256 |
| --- | --- |
| `Arithmetic/EisensteinEmbedding.lean` | `37D3AFD1026BDB466677BCC0FAC8173B93B59865AACEF456D9CE5CABD362242C` |
| `GaussSum/FiniteFourier.lean` | `BB2039A8A9125DE0519AA08E3B277F1E4513F7C6AC952B5B5E5373C14D725E12` |
| `Poisson/EisensteinLattice.lean` | `CC52C9B695ECEC6ECD54AD79C8870CD36A53E99D94BF6B3D5F3A04093DC99D69` |
| `GaussSum/SexticRadialPoisson.lean` | `8DB6F0F3B850868F18706630A4F8F1DA42A345D2F0D32949B8D4CC6CB0F5D21C` |
| `PrimeRows/IdealGenerators.lean` | `FFD100322A61D78A44F28CE7EDEA6E7CC756D7055C5710B42809B1B2AA016949` |
| `Cusp/MatrixPhases.lean` | `EF13178B21FAC195559255DEEB756E6704C027E685465D2EF720AE62D6AB50B7` |
| `Detector/Calibration.lean` | `3586D6359B304DABB6370A3644825EF6D8315E5656DAFE6F08E575F682A994C8` |
| `Detector/CalibrationFourier.lean` | `73862CD5FCA03D66EF8FF58A717472AA0976A581CACD2ABFA18D0504FD4FDF85` |
| `CubicSieve/Poisson.lean` | `2A10C842C07951230927A3D046BD65C2A71F9F739A1401BC74B20CACA16669CF` |
| `CubicSieve/Initial.lean` | `D76A296A7D19D528C0EBBC93BD6D8ABA750F17201A538ECA808923172509DCD0` |
| `GaussSum/CubicNormalization.lean` | `DE04E573BD90BA00B0C545F030C01F7ED0D8CCD4BCD5D0107B53D95DD5EB6915` |
| `GaussSum/ChineseRemainder.lean` | `82669D0AD1108ECA0C5E0DFB6E073A67D0B64AC7C5D2B39B155FB79B4B2CECA0` |
| `ChineseRemainder/AdditiveCharacters.lean` | `A4BFF8663A80E4B542438F5FEA067CA22B69C4F3333FACCFAA320187C3BF2D96` |
| `CubicSieve/RowCaps.lean` | `0EC9465BA4A0C1980EE772BD6E56CBF490129DC240A3F029AB2292D65E7FDD21` |
| `PrimeRows/NormFiberExtraction.lean` | `60D8BA6CAE8F7A5797C6DAE1B72049279673BF18527ED9CC37FCCB5AA741F35B` |

Cached Mathlib signature source, at the distinct revision disclosed above:

`NumberTheory/GaussSum.lean`: `52C08C68A0CC5CCE8018EBC526650788C5C0F8C4B33F07AE9377BC6E84E5B404`
