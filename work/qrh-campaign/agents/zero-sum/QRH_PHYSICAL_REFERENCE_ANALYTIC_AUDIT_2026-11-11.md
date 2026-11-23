# Physical reference estimate: analytic source audit

Date: 2026-11-11. Source root: `work/openai-math/lean/OAI/NumberTheory/DirichletL`. This continues the bounded inverse-total-energy audit, without changing that frozen report. The entry point is `Inversion/InitialEnergyCallerReference.lean:23`, `actual_physical_reference_bound`.

**Verdict: conditional local-source PASS.** The estimate is a real comparison of the finite physical block with supplied normalized child energies. Its body does not establish those child energies. Below the comparison, the source gives a finite fiber-count/Cauchy–Schwarz inequality, explicit quotient-mass and allocation costs, exact Fourier separation of the physical kernel, and integrable weighted densities. This audit reconstructs those steps and the local rapid-decay envelope. It does not validate the whole canonical rank-energy producer or the separate infinite high-frequency-tail theorem. No Lean build, declaration edit, function evaluation, or numerical test was performed.

## 1. Statement and dependence of constants

The fixed data are actual smooth source functions W1,W2 supported in a common positive compact interval, a complex Schwartz radial function Phi, six smooth compactly supported coordinate windows V_i with fixed bounds M_i on their live logarithmic arguments, and two smooth child windows omega_i supported in [lo,b], where lo>0 and b>=1. Two positive-support Schwartz reference windows are constructed from the child windows before choosing the energy order J, slot bound N, quotient-exponent cap U>=0 or loss pi>0.

For each J,N,U,pi the theorem chooses C>0 before all prime pools, finite source sets, characters, real scale parameters, row/label sets and modulations. In particular C is independent of the pool size, source cardinality, source frequencies and Z. The data still must satisfy:

- Actual nonzero primary prime generators, distinct prime ideals, the required coprimality and odd residue-characteristic conditions.
- A finite source S, divisor contained in common support, and nonzero source frequencies; coefficient weights have norm at most one.
- At most N marked slots, with assigned coefficient norms at most one; the exact source-to-child image lies in the supplied nonzero labels and rows, and rows are closed under negation.
- `Z>1`, quotient exponent R<=U, every quotient ideal t in the actual quotient image has `Norm(t)<=Z^R`, and eta*log Z>=0.
- The actual `BlockSupport` restoration conditions, positive source clipping factors c1,c2, and the clipping deficit
  `delta=max(0,D-B-v)-(D-B-v)<=3eta`.
- `F=D-B+theta+delta` and `R=B-theta+2eta`.
- For every real modulation s, every ray, every pair of assigned slot subsets and every actual quotient ideal, both normalized child energies at scale `Z^max(0,D-B-v)` are bounded by `A Z^(F+epsilon)(1+|s|)^(2J)`, with A>=0.

No assumption `R>=0` is silently added. A nonempty quotient image forces enough positivity for the divisor-count argument; the empty case is handled separately. The broader cap/gap inequalities of the preceding inverse-energy theorem are used upstream to construct these inputs, not introduced afresh by this comparison.

## 2. Genuine finite inequality: fibers, Cauchy–Schwarz, normalization

Let d(I) denote the number of ideal divisors. For j assigned prime labels, `Inversion/InitialFibers.lean:80,101` encodes each valid tuple with fixed child (t,f,k) by

\[
 (\text{divisor of }f,\quad j\text{ assigned divisors of }tf).
\]

This map is injective: the divisor reconstructs the common ideal from t, the residual ideal from f by nonzero cancellation, and the source frequency from k using the nonzero primary divisor generator. The assigned tuple is retained in the code. Therefore the fiber size is at most

\[
d(f)d(tf)^j\le d(f)^{j+1}d(t)^j.
\]

No squarefreeness or unique factorization of the *list* of children is assumed here. The product-divisor inequality is proved by the surjection from pairs of divisors onto divisors of a product. `Descent/InitializationEnergy.lean:71` uses this fiber bound to push a nonnegative squared norm onto the finite child range. The source-to-ideal-tuple map is injective on the relevant sector; this is checked explicitly when `InitialEnergyCallerSupport.lean:18` uses the projection.

For arbitrary complex child functions L,R and coefficients with norm <=a, the actual estimate at `InitialEnergyCallerSupport.lean:57` is

\[
\left|\sum_{x\in S}c_x\overline{L(c(x))}R(c(x))\right|
\le a\sqrt{E_L}\sqrt{E_R},
\quad
E_L=\sum_t d(t)^j\sum_f d(f)^{j+1}\sum_k|L(t,f,k)|^2.
\]

It follows by the finite triangle inequality, ordinary finite Cauchy–Schwarz and the fiber projection. It is not an assertion that an arbitrary unweighted child sum controls the source.

`InitialEnergyCallerCanonical.lean:25,47` checks the actual normalization:

\[
E_L=Z^F\sum_t d(t)^j\operatorname{normalizedColumnEnergy}_L(t).
\]

The child is `finiteCanonicalMarkedRow` with puncture `j*primaryGenerator(t)`, label `primaryGenerator(f)`, the actual row k and the retained marked lists. If each normalized energy is <=B_i, the pair estimate becomes

\[
a\,Z^F\Bigl(\sum_t d(t)^j\Bigr)\sqrt{B_1}\sqrt{B_2}.
\]

This is the bound consumed by `InitialEnergyCallerBranch.lean:21`. The right child actually has row -k. `InitialEnergyCallerOpposite.lean:17` removes that sign only by the explicit finite bijection k->-k using the assumed negation closure. It does not identify the two row values pointwise.

The marked allocation step retains all ordered pairs of assigned subsets. The assigned-source construction stores assignments and proves its reindexing injective; it is not a projection that drops multiplicity. The branch coefficient includes the ray coefficient and unit phases. `modeCoefficient_norm_le` controls all other factors by one using the actual character and masks. There are at most `4^N` subset pairs, six unit sectors, and a finite sum of ray-coefficient norms. All are paid in the constant.

## 3. Quotient mass and scale accounting

`InitialQuotientGeometry.lean:180` bounds

\[
H^{-1}\sum_{t\in T}d(t)^j\le C H^e
\]

for arbitrary finite nonzero ideal sets of norm <=H, H>0, e>0. Its proof uses the ideal-divisor subpower estimate and the finite ideal count `#T<=128H`; nonempty T implies H>=1. This argument retains an explicit factor H; it is not a logarithmic loss estimate.

`InitialEnergyCallerMass.lean:28` puts H=Z^R and e=pi/(U+1). Since R<=U, Z>=1 and U>=0,

\[
(Z^R)^e\le Z^\pi,\qquad
\sum_{t\in T}d(t)^j\le C Z^{R+\pi}.
\]

The assigned quotient image is a subset of the original quotient image. Increasing j to 2N is legal because d(t)>=1 for nonzero t. Thus `all_slots_bound`, `all_units_bound` and `all_rays_bound` yield, at each fixed Fourier frequency z,

\[
\left|\sum_{x\in S,\rho} w_x\operatorname{rowMode}(x,\rho,z)\right|
\le C_{N,U,\pi}Z^{F+R+\pi} E(z),
\]

where E(z) is a common upper bound on the two normalized child energies. One may take the bookkeeping constant from the successive proofs as a quotient-mass constant times `4^N`, times 6, times `1+sum_rho |secondRayCoefficient(rho)|`. This is a dependence statement, not a numerical evaluation of that constant.

## 4. Actual kernel separation and integrability

`InitialProfile.lean:26` defines the source density exactly as

\[
d_{g,c,\theta}(t)=\operatorname{logPhase}_{t-\theta}(\log c)\,
\widehat g(t-\theta).
\]

Hence its absolute value is independent of c. Positive c is nevertheless required when identifying it with the original function `W(c*x)`. Translation in logarithmic coordinates carries a phase, not a missing c-power. The two source-density moment bounds are uniform in clipping c, with the stated polynomial dependence on theta.

The radial factor is separated only after a compact logarithmic cutoff is inserted. If active coordinate windows imply `|y_i|<=M_i`, set

\[
T_0=\sum_i|a_i|M_i,\quad L_0=T_0+1,\quad m_0=e^{-L_0}>0.
\]

`QuadraticSieve/IdealQuotients.lean:305` constructs a smooth cutoff chi equal to one on the active range. For radial scale R0>0 it chooses the actual Schwartz function

\[
b_3=\mathcal F[\chi(s)F(R_0e^s)],
\quad F=\operatorname{paperRadialFourier}(\Phi).
\]

The identity on the active coordinate product follows from Fourier inversion of this compact smooth function. Off that support the coordinate product is zero. No inversion of an uncut radial logarithm is assumed. The support and derivative bounds for chi are fixed before R0.

For a requested radial decay power A0 and frequency moment J, the positive-log proof takes derivatives through `K=J+volume.integrablePower` and assumes the actual Euler derivative bounds

\[
(1+x)^{A_0}|(x\partial_x)^iF(x)|\le C_F,
\qquad 0\le i\le K,quad x>0.
\]

On the derivative support, `e^s>=m0` and `m0<=1`, so

\[
1+R_0e^s\ge m_0(1+R_0).
\]

Leibniz and the exponential chain rule transfer the Euler bounds to ordinary derivatives of the cut function, with a factor `m0^(-A0)(1+R0)^(-A0)`. `Fourier/PositiveLogProfiles.lean:654` expresses the resulting weighted Fourier integral bound using its finite `momentConstant` and `coefficientMomentBound`. The envelope also bounds `sup_t (1+R0)^A0(1+|t|)^J|b3(t)|`. `Poisson/RadialFourier.lean:418` supplies CF from finitely many seminorms of the original Schwartz Phi; the underlying Euler continuous-linear-map estimates remain a cut below this audit.

The nine-dimensional common density is the product of the two source densities, b3 and six coordinate Fourier transforms, multiplied by `exp(-3L)`, where L=eta*log Z>=0. `familyDensity_weighted_integrable:126` proves absolute weighted integrability. `familyDensity_weighted_integral:140` factors its weighted norm integral into the nine one-dimensional moments. `family_common_measure:175` then bounds the product uniformly, using `exp(-3L)<=1`. The local rapid-decay factor `(1+R0)^(-A0)` is genuine; the physical-reference theorem uses A0=0, so it does not need a high-radial cutoff or a limiting tail argument.

`InitialPhysicalMeasure.lean:243` and `InitialEnergyCallerSource.lean:131` identify the original finite physical block with

\[
Z^{P+3\eta}\int d\mu(z)\sum_{x,\rho}w_x\operatorname{rowMode}(x,\rho,z),
\quad P=m-2D+B-\theta.
\]

This restoration uses the actual `BlockSupport` hypotheses: fresh windows equal one wherever the corresponding source is live, and the coordinate windows equal one on their joint live support. Positive coordinates are obtained from valid nonzero-frequency source data. Finite sum/integral interchange is provided by `family_density_finite_sum:215`, using integrability of the density times unit-modulus Fourier modes. It is not a manipulation of default integrals. `actual_common_integral_bound:23` then applies the pointwise finite estimate and the integrable weighted-density majorant.

## 5. Clipped reference energies and the final exponent

`InitialEnergyCallerUniform.lean:26` reduces the original child scale `Z^n`, n=D-B-v, to `Z^max(0,n)`. The ratio `c=Z^(max(0,n)-n)` belongs to [1,b] if there is a live child column: its norm is at least one and the original child window is supported below b. If there is no live column, the actual row and its energy vanish. This case split proves the clipping range; the theorem does not assume all real n have a bounded ratio.

`Descent/ClippedEnergy.lean:35` proves the needed energy transfer, not only a scalar Fourier identity. Represent each component as a Fourier integral of a reference row at modulation theta+t, include `sqrt(labelWeight)*Z^(-F/2)` in the vector, and apply finite weighted integral Cauchy–Schwarz. The inequality

\[
1+|\theta+t|\le(1+|\theta|)(1+|t|)
\]

gives the transfer constant

\[
\left(\int(1+|t|)^J|\widehat{\log W}(t)|\,dt\right)^2+1.
\]

Every component integral is justified by `canonical_clipped_mode_integrable`; nonnegative label weights are explicit. The extra clipping phase has norm one and cancels only after taking row norms. The two child modulation heights are bounded by the product frequency weight of order 4J (`initial_height_bound:14`), preserving their opposite signs.

Substitute `E(z)=(C1+C2) A Z^(F+epsilon)` times that weight into the physical estimate. Its exponent is

\[
P+3\eta+F+R+\pi+(F+\epsilon)
=m+5\eta+2\delta+\pi+\epsilon
\le m+11\eta+\pi+\epsilon.
\]

This is the exact identity at `InitialEnergyCallerClipping.lean:30`; delta<=3eta is essential. The resulting constant is the physical/profile constant times `(C1+C2)`, and the height factors use `momentOrder(4J)`. No numerical value for C or the degree is claimed.

## 6. Noncircular scope and remaining cut

The child energy inequalities are explicit inputs to the reference theorem. The inspected proof goes down through finite combinatorics, a finite vector integral inequality, and Fourier estimates for the supplied source functions. It does not call the original-input energy conclusion to prove those input inequalities. The separate caller later supplies canonical rank energies. This establishes the local direction of dependence; it is not a whole-repository acyclicity or axiom check.

The following remain outside this bounded acceptance:

- The actual canonical rank-energy producer supplying the reference moments, especially `Descent/CanonicalRankExistence.canonical_marked_energy_exists`.
- Foundational radial Euler continuous-linear-map/Schwartz seminorm bounds below `Poisson/RadialFourier.paperRadialFourier_euler_source_weighted_bound:394`, and the general Fourier coefficient-moment estimates used by `PositiveLogProfiles.positive_log_fourier_bound`. Their hypotheses and use were checked; their complete proofs were not rederived here.
- The general divisor subpower estimate and finite ideal count used by `InitialQuotientGeometry.normalized_mass_bound`. The fiber multiplicity coding itself was checked, including its nonzero cancellation conditions.
- The underlying logarithmic Fourier inversion and finite-vector integral theorem used by the clipped-row transfer, and the general product-measure/Fubini results used by the profile. The relevant actual-function identities and integrability applications were checked.
- `Inversion/InitialHighFrequencyTailRapid.original_physical_tail_rapid`: the distinct global high-frequency summation branch remains open at the prior audit's cut. The local radial envelope above supplies useful decay but does not, by itself, prove that whole tail theorem.

All sums in the main finite comparison are finite. The only analytic integrals used here come with Schwartz or explicit weighted integrability; no nonsummable `tsum` convention is involved. This report leaves the total-energy infinite-frequency limit to the preceding accepted bounded audit. It proves no terminal band, global QRH theorem or finite spectral claim.

## Source pins

SHA-256 values below refer to paths relative to the source root above. A pin is not a record of compilation. Wrapper and foundational-cut files are included to make the stated scope reproducible.

| Source | SHA-256 |
|---|---|
| `Inversion/InitialEnergyCallerReference.lean` | `F9A70CBD23132AB32AD726C4CBF4C9E5C5C3545DFAAE06B7EFF343C06D01FBB9` |
| `Inversion/InitialEnergyCallerUniform.lean` | `6B6DA0C18C076DDE09860D3A641BF8EC4100EC1202E1AD8F8C29CFB9676E88CE` |
| `Inversion/InitialEnergyCallerPhysical.lean` | `464705C0A397A23479F97570B8C3398AD4EA85461761CF2B76CE2A4A2FF6EE80` |
| `Inversion/InitialEnergyCallerIntegral.lean` | `AE5F78C274C6051DBFEE961F6F7067D34E39E6458F2464E61C13C9F2F8FE26C9` |
| `Inversion/InitialEnergyCallerRays.lean` | `7697106A1F316EB5730860511D67900D1E9571E482A4C48D8AEAECE000A5DC6A` |
| `Inversion/InitialEnergyCallerUnits.lean` | `77ACDB3FBAAE99640C7D4E39E5990D1E3A01F276ED602B2D0C4F920819C5FC12` |
| `Inversion/InitialEnergyCallerAllSlots.lean` | `1B11F097734B03A34CF52C7FB21B2F40969BCA3C3D1BCC9CF8BBDEBA914F130D` |
| `Inversion/InitialEnergyCallerMass.lean` | `DDA4126813E9E9033299C94B782D29DB7EC09224F497A576B2707514ACC9F045` |
| `Inversion/InitialEnergyCallerBranch.lean` | `9E7F5CB692792BD364BA502DF5700DE4E250B01DD03594BFD6E924A6C196F815` |
| `Inversion/InitialEnergyCallerCanonical.lean` | `95B274B8B37C906981F852B7516DBB98C97D844F4054270AB377205BE5B3BE52` |
| `Inversion/InitialEnergyCallerOpposite.lean` | `D99A82AF687F56170CB8C7240636DC2DE72637F479F256418B3F91D1DB838F2E` |
| `Inversion/InitialEnergyCallerSupport.lean` | `FA0D03E9C370B9E7B8418715532E65C23C8B03FA7C4653F2B12EE77FE2738F14` |
| `Inversion/InitialEnergyCallerAssigned.lean` | `270A3FC1695A72880A6AD6707723640EE9B900C21329DC95A21396C7DC716A9C` |
| `Inversion/InitialEnergyCallerAssignedPair.lean` | `E7B451D0A09079FBE5758BE1B3D600DD6FC4D8A7AB52510EFA409E6FCADAB46E` |
| `Inversion/InitialEnergyCallerAssignedCanonical.lean` | `A11ACD1ACDD9CBE01DAF8C52E154D32719B65CA2D5D167A62CC9976EDDD3F111` |
| `Inversion/InitialEnergyCallerAllocation.lean` | `F6D19460B268DE8DCB53FFD42F16A41C4AEEC778D098751496AA9B33E7E0721D` |
| `Inversion/InitialEnergyCallerSource.lean` | `2DDF8A8D9CBD5CBBF54C96D888EB5770AF7244D073CC3DC6B383AC08CBA53365` |
| `Inversion/InitialEnergyCallerClipping.lean` | `407EF2BF3BFF836593EB22260CD4E92A326E5F25932750AB15C361E7B32552F3` |
| `Inversion/InitialFibers.lean` | `BD6F4D9D556064F27324CAA77410B09C717BC2AB06D4D463D0F12A3B2696024D` |
| `Inversion/InitialQuotientGeometry.lean` | `2CA798537E445759793A264B9B7DFACCE6DDECBEA79CCDFABE71ABAC468452B5` |
| `Inversion/InitialProfile.lean` | `83B1C5FEC03CCE64C50DE747EA3F3F518A1569633B35592A67D89E79D57ECA19` |
| `Inversion/InitialPhysicalMeasure.lean` | `4E34DE8B8777EBB75998F7B484643D4DA6D63F222C352C531655836D0D8B0751` |
| `Descent/InitializationEnergy.lean` | `497D4F0E7EEFACDB1775E67C24925ED8E9CC622DACDD58593ED2366A3208C3B5` |
| `Descent/ClippedUniform.lean` | `83D99B54A7DE3F5513BEBCD4247A3DD58A87384B5BFCE7A3347D81D6DC1DA77D` |
| `Descent/ClippedEnergy.lean` | `13DB0274BCDA0E58D1A07D76112A47282E76AA9B9DDD17160418A791A63FEB65` |
| `Descent/ClippedFourier.lean` | `BE404C6B6223557A16E3ED4CBCEB441C514F3BA81DAD294C19A598B4C0FFDA35` |
| `Descent/WindowFourier.lean` | `C840FFB6602B2404BF32247AA14ADF8923E5FBCA624D6E4499E6D98FC9E6BFD2` |
| `Descent/ProfileIntegral.lean` | `DD788B98A7F5A6CC8B5214DB20A3752AB33E6C3D7DA48E1F3E33D13619A9B190` |
| `QuadraticSieve/IdealQuotients.lean` | `3961EF95BA392A9352CADD3A9EC9C3336081BDC468B89A14FB099D00FD64D499` |
| `Fourier/PositiveLogProfiles.lean` | `F35DE7EF62C99B19FA5D50501E84AB0CFD751C5318459A78C0A43EE597901E4D` |
| `Poisson/RadialFourier.lean` | `86D5DEB861723EBF182C8A8489EFD29320F97049F4CCB471684C827F931C8E58` |
| `Descent/CanonicalRankExistence.lean` | `7B299DCB2DE3C671BC9C84E5E5D2F3D0CF2D3192D30CADF1A2041867EFD21427` |
| `Inversion/InitialHighFrequencyTailRapid.lean` | `53FDA6A2E82B6C38E4595C3148BDEAB49235F36F685D8A0960F59BCF01473AED` |

Preceding bounded audit: `work/qrh-campaign/agents/zero-sum/QRH_INVERSE_TOTAL_ENERGY_ANALYTIC_AUDIT_2026-11-11.md`, SHA-256 `8782F2CBAEF66F9C029DB2AE8EAEDD3BC785273A1CBC02390295765F3A53D05E`.
