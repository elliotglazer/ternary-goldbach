# Actual ray-normalizer production audit

Date: 2026-11-11. This is a bounded source/mathematics audit. No Lean builds, edits to Lean declarations, numerical evaluations, or changes to earlier frozen reports were made. Source paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/` and are pinned at the end.

## Result and scope

No defect was found in the inspected production of the actual ray normalizer. The prime mass is proved for the actual finite ray-prime pools, not assumed for an arbitrary pool. Fixed-prime deletion is eventually exactly invisible to the weight. Positive mass gives a nonzero signed product; the powers of the scale cancel exactly, leaving logarithmic losses that can be absorbed into any positive power. The additional complex source constant is proved to be a positive real number.

The prime number theorem used here is qualitative and is obtained from nonvanishing on the line Re(s)=1, together with the Euler-series region Re(s)>1. It does not use the desired seven-eighths zero-free theorem. The inspected boundary proof, Tauberian interface and analytic specialization make this separation explicit. The lower foundations of those results remain the audit boundary; this is not a complete revalidation of every analytic theorem in the provider.

## 1. Exact object and parameter order

The requested top theorem is `ProbeHighRowFamily.actual_ray_normalizer_inverse`, `PrimeRows/CubeNormalizer.lean:13`. Fix a nonzero ideal M of the Eisenstein ring of integers, a subgroup H of `(O/M)ˣ` containing the images of global units, and a finite excluded set S satisfying `SourceExclusions`. Fix finitely many positive scale exponents ell_j with sum 1/6. The real slot weights W_j are smooth, compactly supported in the same positive open interval (c,b), nonnegative, and nonzero. Separately, W0 and W1 are complex Schwartz functions supported in positive closed intervals, real-valued, nonnegative in real part, and nonzero.

For Z>0, set x_j=Z^(ell_j). The actual slot mass is

\[
 m_j(Z)=\sum_{P\in\operatorname{pool}(C,S,c,b,x_j)}
 W_j(NP/x_j)(NP)^{-5/6},\qquad
 C=\operatorname{identityClass}(M,H).
\]

The definitions are `Detector/PrincipalResidueActual.lean:14`, `PrincipalSignalComparison.lean:35`, and `Detector/RaySlots.lean:16`. A pool member is an actual prime ideal in C, not in S, with

\[
 \lfloor cx_j\rfloor<NP\le\lfloor bx_j\rfloor.
\]

The exact finite subtype reindexing `pool_sum` proves that passing from prime-ideal objects to ideals loses no multiplicity. Integer norm bounds imply cx_j<NP≤bx_j. Support strictly inside (c,b) makes the annular restriction exact even at the endpoints.

The real scalar is defined in `Detector/Basic.lean:13` by

\[
 A(Z)=(-1)^K Z^{-(\sum_j\ell_j)/6}\prod_jm_j(Z)
      =(-1)^K Z^{-1/36}\prod_jm_j(Z).
\]

The full normalizer is N(Z)=c_s A(Z), where c_s is `sourceResidueConstant W0 W1 (∏P∈S,P)`. The product ideal is nonzero by the exclusion hypotheses. For every fixed nu>0 the theorem obtains a constant C>0 and eventually

\[
 N(Z)\ne0,\qquad |N(Z)^{-1}|\le C Z^{\mathrm{nu}}.
\]

All moduli, subgroups, weights, scale exponents, exclusions and nu are fixed before the eventual Z threshold. There is no claimed effective threshold or uniform PNT in growing M, H, S or weights. The chosen C is |c_s⁻¹|+1; the threshold still depends on the other fixed data. This quantifier distinction is important for downstream use.

## 2. Ray-class density and the exact PNT input

`RayQuotient.lean:47` defines C as nonzero ideals having a generator whose residue lies in H. The assumption that H contains global units makes this independent of generator choice. The proof at line 52 explicitly compensates for the unit relating two generators. The quotient character set is the annihilator of H, with cardinality h=`classNumber M H`>0. Its injection into full ray characters preserves the principal character exactly. Character orthogonality, including the zero-ideal case, gives the indicator of C after division by h (lines 83–100).

`Hecke/RayPrimes.lean:15` supplies `RayAsymptotic.AnalyticFamily` using the actual `HeckeFamily.LFunction` attached to each ray character. The structure in `PrimeCounting/RayAsymptotic.lean:104` asks for the series identity on Re(s)>1, analyticity and nonvanishing on Re(s)≥1 away from the principal pole, and an analytic nonzero principal regularization at 1. It does not ask for any zero-free strip to the left of 1.

The boundary input is `Hecke/RayFamily.lean:31`, which invokes `HeckeFamily.LFunction_ne_zero_of_one_le_re` from `Hecke/BoundaryIntegration.lean:69`. Its body separates the Euler half-plane from the line. On the line, the source uses the classical 3-4-1 Euler positivity argument, and separately treats the nonprincipal quadratic character at s=1. In `Hecke/Boundary.lean:16–219`, the local nonnegative expression reduces to

\[
 2a^n(1+\Re(z^n))^2/n\ge0
\]

for |z|=1 and 0≤a<1. Absolute summability of the Euler logarithms permits summing it. A hypothetical boundary zero makes the product with exponents 3,4,1 tend to zero: the principal factor is O(t⁻¹), the vanishing factor O(t), and the remaining factor bounded as the horizontal displacement t tends to zero. This contradicts its norm lower bound 1. At the quadratic exception, lines 375–489 use the nonnegative zeta-convolution coefficients and the entire divided difference, together with a trivial zero of the regularized ideal zeta at −2. The latter is constructed from the ordinary zeta regularization and the nonprincipal quadratic twist; no seven-eighths theorem is inserted.

I checked these boundary reductions and their hypotheses. The general positivity theorem for entire L-series with nonnegative coefficients, the Euler convergence/ideal arithmetic beneath them, and the ordinary continuation/trivial-zero facts are retained foundations. Reading the explicit terms rather than merely a broad import list is what establishes the absence of the desired QRH theorem from this route.

The quotient average of pole-subtracted logarithmic derivatives is continuous on Re(s)≥1 and agrees on Re(s)>1 with the Dirichlet series of the nonnegative ideal-Mangoldt class coefficients minus h⁻¹/(s−1). Exactly one principal character contributes that pole. `RayAsymptotic.quotientClassCoeff_ratio_tendsto:286` applies `WienerIkeharaTheorem'` with this continuous remainder, coefficient nonnegativity, summability and a Chebyshev bound. It yields

\[
 N^{-1}\sum_{n<N}\Lambda_C(n)\longrightarrow h^{-1}.
\]

The Chebyshev/summability interfaces in `IdealMangoldt.lean:257–277` bound the actual norm-fiber coefficients by twice ordinary von Mangoldt. This Tauberian theorem and the lower norm-fiber estimates are explicit remaining foundations, not additional assumptions of the top normalizer theorem.

## 3. From Mangoldt coefficients to actual weighted prime pools

`PrimeCounting/IdealPrimeMass.lean` splits the class coefficients into prime ideals and higher prime powers. The higher part is nonnegative and bounded by twice the ordinary nonprime von Mangoldt term; its quotient by n is summable. Consequently its cumulative sum divided by N tends to zero (lines 80–124). This is a genuine removal of higher powers, not identification of a prime-power count with a prime count.

`PrimeCounting/AnnularPrimeMass.lean:77–159` proves Abel summation on the exact floor interval. For a smooth weight phi vanishing at the two endpoints,

\[
 x^{-1}\sum_{\lfloor ax\rfloor<n\le\lfloor bx\rfloor}
 f(n)\phi(n/x)
 =-\int_a^b\phi'(y)\,x^{-1}\sum_{n\le xy}f(n)\,dy.
\]

The scaled cumulative sums have a common bound on [a,b] from Chebyshev. Dominated convergence is therefore applicable; integration by parts produces the expected integral of phi. Lines 284–343 remove the log(NP) weight: on the annulus, |log(NP)−log x| is bounded by |log a|+|log b|, and the normalized count is O(1/log(ax)), so the error tends to zero.

For phi(y)=W(y)y⁻⁵ᐟ⁶, lines 364–409 explicitly check the scale identity x⁻⁵ᐟ⁶·x=x¹ᐟ⁶. Thus `RayPrimeNormalizer.asymptotic:21` obtains

\[
 {\log x\over x^{1/6}}m_W(x)
 \longrightarrow L_W:=h^{-1}\int_{\mathbb R}W(y)y^{-5/6}\,dy.
\]

The apparently unrestricted `finsum` is not relying on its default value: `primeWeightTerm_support_subset` and `weightedPrimeSum_eq_annular` prove finite support in the actual annular prime set for x>0. For each fixed P∈S, NP/x tends to zero, while W vanishes in a neighborhood of zero. Finite conjunction then shows that deleting S is eventually exactly equal to the undeleted weighted sum (`fixed_prime_deletion_eventually_eq:517`). This argument would not justify a growing excluded set, which is not the theorem's contract.

Nonnegativity and nonzeroness of W imply L_W>0. The source proves integral positivity from continuity, positive support, and a nonzero value, not just from W≥0. Eventually m_W(x)≥(L_W/2)x¹ᐟ⁶/log x>0. `Detector/RaySlots.lean:45–83` transfers these statements to the exact finite prime subtype and residue weights.

## 4. Exponent cancellation and signed denominator

The elementary step is `Detector/RayNormalization.lean:13–65`. For fixed ell,d,c>0, log Z=o(Z^d) gives eventually

\[
 Z^{\ell/6-d}\le c\,(Z^\ell)^{1/6}/\log(Z^\ell).
\]

Apply this with the lower-mass constants. For a fixed finite slot set J choose d=nu/(|J|+1). Finite conjunction gives m_j(Z)≥Z^(ell_j/6−d) for all selected j simultaneously. Therefore

\[
 |A(Z)|\ge
 Z^{-\sum_j\ell_j/6}Z^{\sum_j(\ell_j/6-d)}
 =Z^{-d|J|}\ge Z^{-\mathrm{nu}},
 \qquad |A(Z)^{-1}|\le Z^{\mathrm{nu}}.
\]

The factor (−1)^|J| has absolute value 1. There is no sum of signed masses to cancel: every m_j is strictly positive and the only sign is this explicit global parity. `power_ray_mass_and_normalizer` combines positivity and the inverse bound without changing the order of quantifiers. Its generic finite-set result handles the empty product; the top theorem's sum ell_j=1/6 rules out an empty slot family in any actual instantiation.

## 5. The source constant is genuinely nonzero

`PrincipalMellinResidues.lean:379` defines

\[
 c_s=M[W_1](1)\,M[\widehat W_0^{\rm radial}](1/6)\,
 R_M^2/6.
\]

`Hecke/PrincipalResidue.lean` proves R_M>0 from the actual lattice residue: the principal coefficient sum is the positive cardinality of the coordinate-map kernel times the positive cardinality of quotient units. The residue is pi times a positive scaling factor and that coefficient sum, divided by 6. This includes unit modulus; it does not infer positivity merely from nonvanishing.

The radial transform need not be pointwise positive. Instead `Detector/RadialMellin.lean` proves, for 0<s<1 and positive-support W,

\[
 M[\widehat W^{\rm radial}](s)
 =(2\pi/\sqrt3)^{1-2s}
 {\Gamma(s)\over\Gamma(1-s)}M[W](1-s).
\]

The inspected proof uses the actual paper Fourier normalization, Gaussian Fourier pairing and Laplace-Mellin duality. Its Fubini exchange has an explicit product-integrability lemma from the Mellin convergence hypothesis. At s=1/6 all scalar factors are positive. A real, nonnegative, nonzero W supported away from zero has a strictly positive real Mellin transform, so both Mellin factors in c_s are positive real. No assertion that an arbitrary oscillatory transform is nonnegative is used.

`Detector/PrincipalNormalizer.lean:13–58` assembles c_s>0 and the signed product's nonzeroness. Finally `CubeNormalizer.lean` multiplies the inverse estimates:

\[
 |(c_sA(Z))^{-1}|=|c_s^{-1}|\,|A(Z)^{-1}|
 \le (|c_s^{-1}|+1)Z^{\mathrm{nu}}.
\]

The original nonzero proof is retained alongside this inequality, so totalized inverse at zero is never being mistaken for a useful denominator bound.

## Remaining cut

The local production chain is checked through actual finite pools, quantitative exponents, positivity and eventual division. Remaining foundations are the Wiener–Ikehara theorem and its coefficient estimates; the lower Euler/ideal and entire-L-series positivity results used for line-one nonvanishing; and the underlying Fourier/Gaussian/Mellin convergence theorems. No seven-eighths zero-free input, quantitative zero-density assertion, effective PNT rate, or uniform varying-modulus estimate has been added. This audit does not certify the separate downstream source-integral estimates which divide by the resulting normalizer.

## Source pins

SHA-256 values bind the inspected version, not a build result.

| File | SHA-256 |
|---|---|
| PrimeRows/CubeNormalizer.lean | `B6808E221D9A1963FC56ABEF23B9DA5F357F25DFC066612B57ED757BCAA5CA55` |
| Detector/RayPoolThresholds.lean | `469D39943061C81000433FD5D1FFEC79DEE89DB47953809A173562542AF3101A` |
| Detector/PrincipalNormalizer.lean | `465F5CA2A1E64324254E7771A1C595B0A54A69CB9A1DC890538FB789B277DE27` |
| Detector/RayNormalization.lean | `F40F5EA33726752F2672315ACFD5315267E28797896E2C468E1E8BAF0219E09D` |
| Detector/RaySlots.lean | `3EF16C5521252DBB348B0EC0B5ECEEEC03889C71A66980AEC020010C4B868EFC` |
| Detector/Basic.lean | `00FC7D4219CC55F43A0C800648F4070EC6C5430F2D707631A6A4E66D06C79F81` |
| Detector/PrincipalResidueActual.lean | `1D8F97533254B0F6E4C704826634125B10C6562ED6C2E24B1D6800AAA3E2A25C` |
| PrincipalSignalComparison.lean | `FB59CCAED042EA0D445CA08B5333D0FD248B8DB8EE12E691F79A32A351E1B08D` |
| PrincipalMellinResidues.lean | `B0C7700B00073C0FDBADE385EF2C66F8A524EF90C044C26840664A6E8A8396D9` |
| RayPrimeNormalizer.lean | `5FA8667E99895FFE0D7B33C115CFEAB30D614DF8BFF946C8EFEC8288218E17D4` |
| RayQuotient.lean | `099C84E98F64B7035A831FA109EC63A91C1E8B3963152D6B30CEA59F65F8020B` |
| Hecke/RayPrimes.lean | `355B50F5FFEF3B46B39D28CA265D055BAF343C0960EA7D6E9F12CDA2EA0AE0A7` |
| Hecke/RayFamily.lean | `1A3C7B86DC7253DC0DB202BE32A8359893179EAC9F3F89AC9008100D7ECD78D5` |
| Hecke/LogDerivative.lean | `6F976319CAF6739E01ED21F71F4BF511DABAF643ADDB58242C8C3AB895D05895` |
| Hecke/BoundaryIntegration.lean | `F012B21C77D5D42A02FF83595781519C854F9216A7DC3B2D799F95EC41F0F2C0` |
| Hecke/Boundary.lean | `B0248FC7BEDCAB9F88A5F5D7BBF4908B75BDEA3E4AF9A2CEF47106A85A472599` |
| Hecke/PrincipalResidue.lean | `A1EB8F4D91501D0A83A71154F6FFB65C3C76D7F2102581988D95C200757C2ABA` |
| Detector/RadialMellin.lean | `7E48D9AF92641466920088D4C034675AF5C621F6F227974E232B5EBE148B1202` |
| PrimeCounting/RayAsymptotic.lean | `EB7C9650A1DD1EC5CA3F7BB38E0823BCB41646126158D6D58343FBE25CBB700F` |
| PrimeCounting/IdealPrimeMass.lean | `7722F12A5D7ED80F770B8552787C29A02FEAA6FA8A5C1D355A50A08174732683` |
| PrimeCounting/AnnularPrimeMass.lean | `F48BB4AB40177C033070AA129FE90946EA166A30BAAF8BD9BC3CA20FD2761E8A` |
| IdealMangoldt.lean | `3A2AEE46664BD41DA36B8CC8A9DE44B272FEFFCE0D3EDB676892AA7F050E9FB1` |
