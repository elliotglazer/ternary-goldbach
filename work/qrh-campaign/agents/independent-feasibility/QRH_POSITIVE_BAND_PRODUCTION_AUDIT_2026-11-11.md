# Positive-band production: bounded source and mathematical audit

## Result and scope

The inspected branch has a substantive conditional construction of positive-band **upper energy bounds**. It is not merely an inverse-energy wrapper. Its main steps are amplified common-column bounds, a left/right square-root pairing, a finite absolute-block mass estimate, and conversion of that mass into the original energy. I found no contradiction in the inspected assembly or loss normalization. This does not validate all analytic producers, prove the global QRH provider, or establish compilation or an axiom closure.

The three requested entry points have different obligations. `CanonicalLowColumn.actual_admitted_subsets_low_column` consumes child `ZeroAt` and `PositiveAt` estimates and admitted packets. `FirstReferenceEnergy.actual_physical_mass` consumes both left and right `ColumnBounds`. `PositiveLowBandSource.actual_low_stages_from_physical` consumes the resulting mass estimate **and a previous positive band**. None is a closed proof of all bands on its own.

This is a source/body audit, with the consulted and boundary files pinned below. No Lean commands, declarations, analytic evaluators, or source modifications were used. File hashes identify bytes; they are not declarations that every theorem in each file was audited.

## Minimal construction and quantifier order

The selected route is:

1. `CanonicalLowColumn.actual_admitted_subsets_low_column` receives actual main/error child estimates through `CanonicalAnnularPower.actual_original_subsets_annular_power` and the amplified-uniform producer. It combines them using `FirstCommonReferencePower.common_energy_reference_powers` and `FirstLowHomogeneousPowers.actual_low_homogeneous_four_powers`.
2. `CanonicalLowSource.actual_original_left_low_column` and `CanonicalRightSourceColumn.actual_original_right_low_column` construct the left/right source admissions for a live original block.
3. `CanonicalLowPhysical.actual_low_physical` assembles these into `FirstReferenceEnergy.ColumnBounds`, and applies `FirstPhysicalNormalization.actual_physical_mass_of_columnBounds`.
4. `NaturalLowPhysical.actual_natural_low_physical` selects the natural-state parameters and the four-loss fit. `NaturalLowStage.actual_low_from_bands` calls the mass-to-energy conversion and merges the old band.
5. The conversion itself is `PositiveLowSourceControlled` to `PositiveLowBandSource`, then `NaturalLowSourceBound`, `LowFixedRadialEntry`, and `FixedRadialReduction`. The last uses both the actual original-source comparison and the first retained-source remainder estimate.

The column theorem fixes the ambient finite slot family, modulus data, support endpoints, loss parameters, and width caps before choosing a finite profile set and height degree. For each allowed character and modulus divisor it then chooses a constant and a sufficiently large scale threshold. These precede the dynamic scale, frequency/height data, matched source, and live block. The auxiliary character family is allowed to depend on the selected ray character. Finite intersections over subsets and finite sums of constants in `CanonicalLowPhysical` preserve the stated order.

This is uniformity over the dynamic data in the theorem, not a constant independent of arbitrary new ambient slot families, support intervals, or fixed loss parameters. The assumptions include positive support lower endpoints, positive scales, supported ideals, the prescribed modulus equality, source/volume caps, and the child estimates. In the low-column theorem, the regime includes `κ ≥ 1/6`, `beta ≥ 51/100`, and `2*beta-1 ≤ κ`. The natural-state specialization has its own stronger `κ ≥ 3/4` hypothesis. These must not disappear from a provider-level summary.

`FirstSecondInputGates.Ready` consists of geometric/admission inequalities: nonzero puncture, positive scale and nominal/frequency scales, volume/source/conductor/puncture caps. It does not contain the desired energy inequality under another name. The actual child energy assumptions remain separate. The left/right source wrappers obtain eventual source admission, main-packet admission, error-packet admission, and prime separation before applying the conditional column theorem. Their lower admission proofs were not fully audited here.

## Four powers and the common reference

Write `V` for source volume, `NC` for the left ideal norm, and `q` for the relevant character conductor norm. The common reference is

`ref = q * (V/NC)^2 * Z^allowance`.

The normalized power in `FirstCommonReferencePower` satisfies the exact identity

`ref * normalizedPower = NC^(eps-1) * V * E * (b^N * V/NC)^alpha`.

The positive-scale hypotheses permit the real-power identities used here. This accounts for the reference factor; it is not a comparison that silently discards a conductor.

The four losses in `FirstAmplifiedFourCoefficients.lossVector` are

`[paid, 3*sigma/2 + 5*(delta+reserve)/6,`
` 2*sigma+delta+reserve+eps*Mcap,`
` 2*sigma+delta+reserve-saving]`.

Here `paid = 2*Bcap*epsMask + epsChild + epsRemove + (delta+reserve+thetaSource)/6 + thetaClip/3 + kappaMesh`. The Gaussian profile losses are

`[2*deltaSrc+epsSrc, 2*epsSrc+2*deltaSrc+2*(5*Bcap+1)*thetaSrc, 0, 0]`.

The finite amplification average includes the three actual error orders 1, 6, and 7. The associated squared weights total 1872. The common factor in the four-power estimate is `56*((Mamp+2*sigma)/(sigma/6) + 1872*card RayCharacter)`. This is absorbed in a fixed constant, not in an unreported scale exponent.

`CanonicalLowPhysical` requires, for each of the four indices, the sum of its Gaussian loss, its loss-vector entry, `epsSrc*(A+1)`, and `primeLoss` to be at most the chosen `ell`. The natural-state caller supplies this through its parameter-fit theorem. The present audit checks how that fit is consumed; it does not independently reprove every parameter-choice theorem or the amplified-uniform analytic producer.

## What physical mass means, and why pairing does not double the loss

`FirstSourceReduction.physicalMass` is a finite sum of sector masses. `FirstReferenceSource.physicalMass_eq_sum` rewrites it as a sum over actual common labels, inactive subsets, and local dyadic blocks of the **norms of original blocks**. It is nonnegative by construction. It is not a lower bound asserting positive energy, and no cancellation between block norms is used.

`FirstReferenceEnergy.ColumnBounds` demands common-energy bounds for both columns, every retained squarefree divisor, every ray character, and every real frequency. For a nonzero block, `FirstReferenceBlock.actual_reference_block` turns these into a block bound through `FirstDivisorCommonBound.actual_supported_annular_harmonic` and the actual reference-window normalization.

The divisor restriction is substantive. If the Möbius coefficient is zero, the term vanishes. Outside the source-radius support the relevant right energy vanishes. Live divisors with nonzero Möbius coefficient are squarefree and receive the supplied estimates. The factors from the two sides are square roots, giving `sqrt(1/NL)*sqrt(1/NL)=1/NL`; they do not produce `1/NL^2`.

The actual `windowBudget J t E` is `sqrt(E)*heightEnvelope(t)^J*profileMoment(J)`. Consequently, if both nonnegative column coefficients are at most `F*Z^(Mdecl-M0+ell)`, each of the sixteen paired terms is at most that same quantity times the fixed height/profile factors. The sum costs 16, not a square of `F` and not twice the exponent. Nonnegativity and `sqrt(E)^2=E` are explicitly used.

The reference source factor contains `K*q`. With `M0=log_Z K+log_Z q`, `FirstPhysicalNormalization.physical_power_identity` proves

`K*q*Z^(Mdecl-M0+ell) = Z^(Mdecl+ell)`.

Thus the final mass estimate has the form

`physicalMass/V ≤ C*F*Z^(Mdecl+ell+epsPhysical)/Nseed`

times the displayed polynomial height and profile factors. There is no additional uncharged conductor factor in this normalization.

The finite block summation requires two further estimates. `original_input_local_blocks_subpower` bounds the number of local dyadic blocks. `actual_inactive_radical_mass` reduces the inactive-subset weights to `SecondBlockRadicalHarmonicMass.actual_active_radical_mass`, using `0 ≤ inactiveWeight ≤ 1`. `FirstReferenceEnergy` gives half of its total small exponent to the single-block estimate and half to block summation; `original_block_sum` splits that latter half between dyadic counting and radical mass. These uses sum to the advertised exponent. The harmonic-mass and dyadic-count producers remain lower inputs, not consequences of finite summation alone.

The zero source-radius case is handled separately by `physicalMass_zero`, using the plain profiles' vanishing at zero. Positive support lower endpoints establish that vanishing. The physical estimate is therefore not obtained by dividing by a radius that may be zero.

## Analytic mechanism beneath the block bound

I read the bodies of `FirstPhysicalSourceBound.physical_block_child_bound`, `FirstChildBound.whole_kernel_first_child_bound`, and `ReflectedChild.whole_kernel_reflected_gauss_child_bound`, as well as the final `Cauchy.whole_kernel_row_estimate` assembly.

The actual original block is rewritten as its scalar times the whole kernel. Möbius separation of coprimality and finite ray expansion give a sum over divisors and two ray characters. `finite_first_ray_divisor_bound` pays the `firstPhaseTable_mass ≤ 256` factor once. The reflected right polynomial is evaluated at `-z`; the reflection step uses the injective map `z ↦ -z` and equality of its radial norm. It does not assume the original finite row set is itself reflection-invariant.

The nonnegative radial majorant is at least one on the retained rows. It bounds each finite sum of squared Gauss polynomials by the corresponding full Gauss energy. The two supplied energy bounds then imply a product of square roots at most `E1*E2*(1+|t|)^(J1+J2)`.

The whole-kernel estimate invokes `whole_product_pair_separation`. That producer supplies an exact integral representation with a common density `b` and an estimate

`(1+R)^A * integral (1+|t|)^J * |b(t)| dt ≤ C`.

Finite Cauchy–Schwarz and the integrability conditions yield the row bound. This identifies the critical analytic cut more precisely than saying merely that a common-energy bound is available. **The common-density separation identity and its weighted integral decay are not proved by the finite Cauchy–Schwarz argument.** Their underlying Fourier/Mellin construction was not audited in this task. The finite ray identities and full Gauss-energy summability also retain their source foundations.

## Return to original energy and merge with the previous band

`OriginalSource.input_polynomial_difference` and its normalized version identify the actual difference of the two source products with the finite Hecke polynomial, with normalization `1/sqrt(V)`. The inspected comparison sums

`|x|^2 ≤ 2*|x-y|^2 + 2*|y|^2`

against nonnegative radial samples. It uses actual summability/HasSum statements, not a formal rearrangement of an unevaluated divergent sum.

`ZeroComparison` makes the comparison row exactly zero. It chooses `smallScale(b)=1/(2*max(1,b))`, so the upper support endpoint times that scale is strictly below one, and adjusts the other scale to keep the product and volume unchanged. The imported strict-subunit row theorem, together with vanishing at zero, supplies the zero row. This is not a limiting comparison whose error must still be paid.

`FixedRadialSource` chooses a fixed smooth nonnegative majorant equal to one on the required compact radial interval. The sampled radii are nonnegative. The original complex radial function is bounded by its diagonal control times this majorant; the finite energy bound follows using nonnegative squared-polynomial samples. `FixedRadialReduction` then combines this comparison with `FirstSourceReduction.original_first_physical_reduction`.

That latter reduction contributes **separate** diagonal and tail errors through `SourceInputFirstRemainder.original_first_remainder`, and a retained-norm estimate through `FirstRetainedNorm.original_retained_norm`. These are important unvalidated analytic inputs in this audit. `NaturalLowSourceBound` absorbs them only after checking `epsDiag ≤ e` and `-saving ≤ e`, the volume and inverse-scale caps, and the polynomial-height/profile bounds.

`PositiveLowBandSource.PhysicalLowAt` asserts a mass bound on widths `rho ≤ width ≤ Mcap` satisfying the low-volume constraint. The production theorem uses the previous `PositiveAt` for `width ≤ rho` and the new physical argument for `width > rho`. The closed endpoint is covered by the old band; there is no missing width at equality. The controlled variant permits an independent constant for the old band and adds it algebraically to the new one. `LowBandEmpty.positive_low_zero` gives the zero-slot result by specializing the slot subset to empty.

Finally, `NaturalLowStage.actual_low_from_bands` merges profile sets and height degrees and dominates the resulting constant by a multiple of `C0+C1+1`. It consumes child `ZeroAt` and `PositiveAt`. Its condition `Mparent-sigma/2 ≤ Mchild` alone does not assert `Mchild < Mparent`, establish a well-founded induction, or supply the initial band. Those remain obligations of the calling induction. This branch cannot be used as a circular justification of its own child bounds.

## Remaining proof cut and next bounded audit

The most useful next audit is `whole_product_pair_separation`: check its exact whole-kernel identity, density integrability, weighted decay, support assumptions, and constant uniformity. This is a specific analytic source for the physical-mass estimate rather than another band wrapper.

Other retained cuts are the actual amplified-uniform child estimate and its admitted main/error packets; the normalized Gaussian four-power bounds; the reference-window normalization; the dyadic block and radical harmonic bounds; the first retained-source/remainder estimates; and the exact arithmetic/ray/source identities used below the inspected adapters. The global induction must also supply child bands and a genuine progress schedule. None is discharged by this report's successful finite algebra checks.

The bounded conclusion is therefore that the inspected production and normalization chain is mathematically coherent conditional on these explicit lower inputs. There is no new unconditional QRH, Goldbach, full-provider, or Lean certification claim.

## Source pins

All paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL`. The manifest records inspected assembly files and explicitly retained boundary files. It does not claim full-file validation.

| Source | SHA-256 | Scope |
|---|---|---|
| `Energy/CanonicalLowColumn.lean` | `BB81827AE7A2A730685CB3B977E07E3913AAA98349EB8BCCAB6EAAB70B7BB074` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/CanonicalAnnularPower.lean` | `49F426FECB2FBB789FEACC7B557CA753BE6C31545C134DC4B7FC9093097AD3BB` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/CanonicalLowSource.lean` | `2A9B310C35B674BF831B57B0FFB57CADD0A027B8AB0B2C4DDE58D0BD30618B55` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/CanonicalRightSourceColumn.lean` | `602D3E2DE1B03A5FB6FE77D8238DBC70DD1EFB79C79BE0A438A4B7CEE3F806A6` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/FirstLowHomogeneousPowers.lean` | `C6B694744E7FD988144E67C8AD38E62A031A46E5391B6318EABC2A407300665D` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/FirstGaussianProfileWeights.lean` | `E6F0FF771F7B29F85F1A570DE31B441D87D78920B46EF74508CD54429DC70192` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/CanonicalLowPhysical.lean` | `572B4C44F799B555D2D3C89A896FAA253F89EEE54337A0DFE32C3864EE96D79D` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/FirstPhysicalNormalization.lean` | `B91950CF1E30F4680D0E83A06D33BB9D4DD0FB3BF0F33D28F06A835D6E06E270` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/NaturalLowPhysical.lean` | `46395476353507AA86001CE63A8E4599CB72BDDDB382408B502A0B371F82359A` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/NaturalLowStage.lean` | `E831B3EFB8C8EBE45767CFFF4188BFB0DD9C01C3E033A1D943AC2D5F9C2A37D4` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/PositiveLowBandSource.lean` | `9E14E3172C8AA25E8DF5FB89A90F2A50A8F86A954EC3495963B34122A60995E6` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/PositiveLowSourceControlled.lean` | `ECAB2AB967B86E3BA5B7DD60F17E6423F8B98A735D1C35C21086CEF6032C05CC` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/NaturalLowSourceBound.lean` | `1FF8B0C52A291FF5FB18128B48FDD1076F1DD405B2F5DC62DC665FF2E5A5DF5C` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/ReferenceLowBands.lean` | `1740F40A10E3D43C3A59E84B91C167EE01E9437DF16293E23311B1024D4EB92E` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/LowFixedRadialEntry.lean` | `EA7EE428814770B9BC2C8C7372927D696DC6171E59501CC2BA49EC88F6CFA3ED` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/FixedRadialReduction.lean` | `4CBAB080A8F4677EDB9CFDB90C1584A09760AF93924BC1F35E50EAE4EEC323B9` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/FixedRadialEntry.lean` | `CB65F1E0A69F5EBCF90826F397E64735684C2D62DBA5C84F8B5B7BEDA5C43170` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/FixedRadialSource.lean` | `97E8D9BF4E9D3D91107A636A6AC4C0C188A45328FA0499B75771D6056EB6258E` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/OriginalSource.lean` | `D6689EF9DC4C3A7B88CB03EE9DD02B68DD3288C542A379D3937016EB5BD8F19A` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/ZeroComparison.lean` | `7FB3882909CA57E72511AD094505DB103001566860B945020BC061807FF117D0` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/FirstSecondInputGates.lean` | `FFAF9D81081BD5F5C1AA04CEF450CB7C2D645A6C5CFD5F444C0559D2418B9A5C` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/FirstAmplifiedFourCoefficients.lean` | `8BAF4B3C85B109797581667070238E0107AE1068423749F4AD930AB470035FB4` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/FirstCommonReferencePower.lean` | `B7871A4D9B4AC91A6DF9965DD4AAF62B8F265B9E2585A52321D03EE00369C45A` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/FirstSourceReduction.lean` | `13569CB6EFD2062FAF1B733BA5EE517A1E20839A9DEFEC07A7CC79F5B4A715AB` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/FirstReferenceSource.lean` | `5D6B22796049104C58917948AAF43189A2F97B50059F3AD476FE20E151340F14` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/FirstInactiveRadicalMass.lean` | `1FBD9E9B0AF90B28C7C67E9D3147966F9B2F28F04B51B2808D8E3662F7859174` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/FirstReferenceEnergy.lean` | `8CE5CC555EC7335258793C972EBBD2AF52441391F5B4918E45272F95BDF73E02` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/FirstReferenceBlock.lean` | `8AB20561C496BA081998909ACC9FAFA45D8B979804DCEF0979433BF61C55C779` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/FirstDivisorCommonBound.lean` | `00DFE41E7FF2280DE4BA2DA29E042738AC847BCAB4B9263E76A2DF7E078AC020` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/FirstPhysicalAnnularCommonBound.lean` | `8D8948B45BD353EC62EC53B14A690F6647295C4EEAB13E59FEF92A4595009AD5` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/FirstPhysicalSourceCommonBound.lean` | `5C5D99388D6FE3A8CAA487AE6D9F1EABE11B1A7C8C2E3160A91F1835A67388FE` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/FirstPhysicalSourceBound.lean` | `375B2EF3F351BB4C8AC0CB9829A3523DCC6273EEC555A50D25AACAD5E65B4D9A` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/FirstChildBound.lean` | `815D6CE48159812298A528CF7A05726032E2F35DAF6F5226F7DE8BB5CED84B90` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/ReflectedChild.lean` | `0748FE859C32CDC826A61FF9EB5065E17D21A79821A496007801BBDCAE6BDE8A` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/ChildEnergy.lean` | `F8613F73303C6401F5A5464848C8275B5F038BF2DB6F7907CD5FA333A0847744` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/Cauchy.lean` | `9CE4439AE957530D140D50A5CA9D99CD7BE3F54CADA3D71F1AF74D874F5113A3` | Assembly/definitions inspected; selected bodies as described above |
| `Moments/SecondWindowBudget.lean` | `FCC974624B2F58ECA571DC46E7B45159D897936C5A52EEED64083E46206A3815` | Assembly/definitions inspected; selected bodies as described above |
| `Energy/CanonicalAmplifiedUniform.lean` | `8E06F918FA7619BB7BD6F92D9B61568A9328BF9C861C8099BE3C6106C4413F84` | Boundary pin; underlying analytic proof not validated |
| `Energy/FirstNormalizedGaussianPowers.lean` | `B610FE00BB9DF078CC0A6CD1AA3758A54CEF6DDA8EBF3EC8F8B12856CE667FD7` | Boundary pin; underlying analytic proof not validated |
| `Moments/Smooth.lean` | `2C1337F3B8F06D4221F45A81973D9793A59CE876CDDD36A9A443D08C115ED556` | Boundary pin; underlying analytic proof not validated |
| `Moments/FirstCommonSourcePowerBudget.lean` | `F369306E785677A776C3BAF09EAE64B6D834141E294F504F690FE1054DC346D1` | Boundary pin; underlying analytic proof not validated |
| `Moments/FirstMixedWindow.lean` | `981130C958876220F9CF964E54DD52527DBFA4289B7E31B34CC8F84E3128C31D` | Boundary pin; underlying analytic proof not validated |
| `Moments/FirstPhysicalDyadicCountSource.lean` | `F601B7ADA9E14DDCE0B4AC11D75C064D5F0A6E7DB1B8A37620ADC343DBEF24B4` | Boundary pin; underlying analytic proof not validated |
| `Moments/SecondBlockRadicalHarmonicMass.lean` | `13DCB7793D6D787171DABE68E1DB2201315ACF5F8D95EB66E77D397D6CA8E822` | Boundary pin; underlying analytic proof not validated |
| `Moments/SourceInputFirstRemainder.lean` | `EFE6F5F308208D9A15D8D548A12C51762A1637849D5B88CA1237CA6FE0ADD71D` | Boundary pin; underlying analytic proof not validated |
| `Moments/FirstRetainedNorm.lean` | `0C0E7816277D08AFCC8544BBEEB54A1777D66AEC877806945EBFB7F71A7B44D9` | Boundary pin; underlying analytic proof not validated |

### Declaration locators

Line numbers below locate the actual declarations in the pinned files; they do not enlarge the audited scope.

- `Energy/CanonicalLowColumn.lean:122`: `actual_admitted_subsets_low_column`.
- `Energy/CanonicalAnnularPower.lean:96`: `actual_original_subsets_annular_power`.
- `Energy/CanonicalLowSource.lean:105`: `actual_original_left_low_column`.
- `Energy/CanonicalRightSourceColumn.lean:109`: `actual_original_right_low_column`.
- `Energy/CanonicalLowPhysical.lean:109`: `actual_low_physical`.
- `Energy/FirstPhysicalNormalization.lean:60`: `physical_power_identity`.
- `Energy/FirstPhysicalNormalization.lean:208`: `actual_physical_mass_of_columnBounds`.
- `Energy/NaturalLowPhysical.lean:31`: `actual_natural_low_physical`.
- `Energy/NaturalLowStage.lean:37`: `actual_low_from_bands`.
- `Energy/PositiveLowBandSource.lean:44`: `actual_low_stages_from_physical`.
- `Energy/PositiveLowSourceControlled.lean:28`: `actual_low_stages_from_physical`.
- `Energy/NaturalLowSourceBound.lean:55`: `natural_low_source_bound`.
- `Energy/OriginalSource.lean:143`: `positive_energy_comparison`.
- `Moments/FirstSecondInputGates.lean:23`: `Ready`.
- `Moments/FirstReferenceSource.lean:62`: `original_block_sum`.
- `Moments/FirstReferenceEnergy.lean:33`: `ColumnBounds`.
- `Moments/FirstReferenceEnergy.lean:69`: `actual_physical_mass`.
- `Moments/FirstReferenceBlock.lean:25`: `actual_reference_block`.
- `Moments/FirstDivisorCommonBound.lean:159`: `actual_supported_annular_harmonic`.
- `Moments/FirstPhysicalSourceBound.lean:18`: `physical_block_child_bound`.
- `Moments/FirstChildBound.lean:94`: `whole_kernel_first_child_bound`.
- `Moments/ReflectedChild.lean:27`: `whole_kernel_reflected_gauss_child_bound`.
- `Moments/Cauchy.lean:99`: `whole_kernel_row_estimate`.
- `Moments/Smooth.lean:117`: `whole_product_pair_separation`.
- `Moments/FirstPhysicalDyadicCountSource.lean:79`: `original_input_local_blocks_subpower`.
- `Moments/SecondBlockRadicalHarmonicMass.lean:54`: `actual_active_radical_mass`.
- `Moments/SourceInputFirstRemainder.lean:21`: `original_first_remainder`.
