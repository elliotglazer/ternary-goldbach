# QRH two-pass analytic audit

Date: 2026-11-11. Status: conditional local-source PASS, awaiting independent review. No Lean invocation, numerical evaluation, source edit, or new premise was performed. The source root for the references below is `work/openai-math/lean/OAI/NumberTheory/DirichletL/`; the table at the end pins the inspected files.

## 1. Scope and conclusion

The inspected path starts at `Descent/CanonicalLongUniformTestBin.actual_marked_bin_uniform_test:16` and `CanonicalReopeningHeight.reopening_twisted_moment_squared:35`. It descends through the actual first-pass physical split, common Fourier measure and weighted Cauchy inequality, the second-pass retained/deleted source identity, and the scalar losses used to reassemble the estimate. No local change of function, uncharged branch, lost height quantifier, or use of an unsupported default infinite sum was found in these layers.

This is not a proof of the four child moment hypotheses. They remain the two sides of `FirstLabelCellStep.ChildBounds:17`, for each of the two first-pass signs. Nor does this audit establish all lower Poisson, divisor-mass, radial Fourier and rapid-decay estimates. Section 7 identifies that cut. The result is evidence about the mathematical assembly in the inspected source, not a fresh checked Lean build or validation of the entire QRH provider.

Write $F=r+3\ell+V$, let $Z\ge2$, and use the source's finite pool of actual primes and its finite label sets. The resulting estimate has the form

\[
 Z^{-V}\,\mathcal E(\text{actual marked reopened rows};Z^M)
 \le C\Gamma^2(1+A)Z^{F+\mathrm{lossFinal}}
 \left(\int_{\mathbb R}|a(\xi)|(1+|\xi|)^d\,d\xi\right)^2,
 \qquad \Gamma=C_{\rm coef}(eZ^\ell)^{\varepsilon_1}.
\]

Here $a$ is the actual reopening coefficient and $d=\operatorname{momentOrder}(\operatorname{firstDegree}(\mathrm{degree}))$. The estimate is conditional on the source's full support, capacity and child-moment assumptions, not merely on this displayed abbreviated formula.

## 2. Actual functions and order of choices

`CanonicalLongKeys.actualLongSourceKeys:14` builds the keys from the actual retained source and actual live summands. It is not a free key set that could be chosen empty. `CanonicalLongParent.actual_long_parent_energy:24` uses `actualLongCoefficient`, its uniform bound, and the actual prime mark on the union of cube support and column subset. `CanonicalLongUniformTestBin` transports between the norm-twisted source and frequency-twisted logarithmic profile using exact source identities.

The prime pool is `outsideSquarefreeIdeals S D` with the actual primary generator map. The hypotheses include the fixed bad primes in $S$, primality of $S$, the cube norm window $[Z^\ell,eZ^\ell]$, squarefree nonzero labels with norm at most $Z^{V+\eta}$, disjoint mark lists, coefficient norms at most one, and mark-slot cardinality at most the fixed natural parameter. The physical support constraint $b_0Z^{r+3\ell}\le D$ is retained.

The compact child windows and their support bounds are chosen before the small exponent parameters, child degree and actual data. The constants may depend on the fixed windows, capacities and exponent parameters, but not on the later pool, labels, coefficients, height or reopened frequency. The four child hypotheses quantify over every applicable ray/core/assignment, actual second-ray index, actual second-cell label, real twist, remaining mark subset and actual triple. In particular a moment bound at one selected twist does not suffice.

The principal scalar domain includes $\eta\in[0,1]$, $0<\tau\le1$, $Z^\eta\ge2,e$, $r\ge-\eta$, $\ell,V\ge0$, $F\le L_{\rm cap}$, and the separate capacity bounds in the entry theorem. The source explicitly requires

\[
48\eta+\tau+\pi+\varepsilon_{\rm child}+\varepsilon_2\le\mathrm{loss},
\quad -\mathrm{saving}\le F+48\eta+\tau+\pi+\varepsilon_{\rm child}+\varepsilon_2,
\]
\[
M-\ell\le F,\quad
3\eta+\varepsilon_1(5\ell+2r+7\eta)\le\mathrm{lossFinal},
\]
\[
\mathrm{loss}+(2L_{\rm cap}+15\eta+\tau)\varepsilon_1+\varepsilon_1
\le\mathrm{lossFinal},\qquad -\mathrm{saving}\le F+\mathrm{lossFinal}.
\]

The mass/deletion exponent parameters are positive and constrained by the displayed smallness conditions in the entry theorem; they are not arbitrary constants silently absorbed into $C$.

## 3. First pass: full split, physical identity, and Cauchy

`ReopenedPhysicalSplit.original_reopened_physical_split:41` expands the finite cube pair sum and uses the canonical split separately for each pair. Its cutoff is an actual finite child-frequency ball. Zero belongs to it under the stated nonnegative-radius and nonzero-multiplier hypotheses. `GaussSum/BranchScaling.actualFirstKernel_truncate:616` applies `sum_add_tsum_subtype_compl` to an explicit `actualFirstKernel_summable` proof with positive radial scale and nonzero divisor. Thus the infinite complement is an actual convergent tail, not the default value of an unproved summability statement.

`FirstGlobalSourceEnergy.original_global_physical_energy:40` yields

\[
\mathcal E\le |\mathrm{physicalZero}|+K|\mathrm{retained}|+|\mathrm{tail}|.
\]

Here $K$ is the radial row scale. The nonzero-row energy is obtained from the full row sum by subtracting the nonnegative original row-zero square. That subtraction is distinct from the physical dual zero-frequency term, which remains explicitly on the right. Complex terms are bounded by their norms; no sign assertion about them is required.

`FirstCanonicalPhysical.canonical_first_kernel_physical:44` and `FirstRetainedPhysical.canonical_retained_physical:32` identify the retained canonical kernel with the actual common physical rows. Their conjugation of the first window and phase factors is retained. The first Fourier separation is therefore applied to this actual physical expression.

For a finite source, `FirstFamilyEnergy.first_family_cauchy:34` is weighted Cauchy on the source/ray/subset indices. The common weight becomes its absolute value and the phase has norm one. If the two separated energies are bounded by $B_1W_J$ and $B_2W_J$, then

\[
|\mathrm{separatedRow}|\le\sqrt{B_1}\sqrt{B_2}\,W_J.
\]

This introduces no cardinality factor for the source. `FirstUnequalEnergy.first_family_integral_of_two_energies:15` then integrates against the absolute value of the Fourier density. The generic norm-of-integral estimate alone is not a Fubini or Bochner-integrability proof. For the actual application these are supplied separately: `FirstFamilySource.integrable_first_block_density:16` expands finite rows into integrable density times unit phases, and `first_family_density_sum:41` interchanges those finite sums and the integral. `FirstProfileUniform` supplies joint measurability, weighted integrability and the actual common-measure identity at lines 79, 112, 197 and 305. Its radial-envelope construction is a lower input, not supplied by Cauchy.

The normalization is substantive. Put $L=\eta\log Z$, let $P_i=Z^{\kappa_i}e^{9L/2}$ be the two first child normalizations, and let `rootScale` have its source meaning. `FirstHeightBudget.first_unequal_prefactor:25` proves

\[
\frac{Z^{-r-2\ell-V}Z^M}{\mathrm{rootScale}}e^{9L/2}
\sqrt{P_1^{-1}}\sqrt{P_2^{-1}}=1.
\]

All scales are positive. This is the cancellation used in `FirstOriginalProfilePhysical.actual_first_original_subset_physical_budget:13`; one cannot omit the square roots or apply an unnormalized child estimate.

The retained push extends only nonnegative weighted energies to larger finite sets. The small-power count concerns actual live joint keys. `FirstDyadicRetainedEnergy:18` retains the radius power and key cardinality; `FirstDyadicRetainedBudget:21` applies the live-key small-power bound, giving the resulting $Z^{(2L_{\rm cap}+15\eta+\tau)\varepsilon_1+\varepsilon_1}$ loss rather than treating the number of keys as constant.

## 4. Second pass: deleted marks and four child inputs

`Inversion/WholePriorityRetainedSource` uses the actual attached second source with nonzero-frequency cutoff. Its deleted lists and whole-row identity are exact. A deleted prime must belong to cube support or the first common subset, or divide the actual quotient ideal. These alternatives are hypotheses of `SecondDeletedOriginalBound.actual_second_deleted_mode_original_bound:18`. Arbitrary deletion of inconvenient marks would not satisfy this theorem.

`GlobalPriorityFilteredEnergyUniform:20` restricts to the geometric source by an identity: the excluded rows vanish pointwise. It is not an inequality discarding complex summands. It retains the actual signed weight, quotient puncture and remaining lists. Its coefficient normalization uses the explicit positive bound $512(32\cdot512)$; scaling the weights back is an exact identity.

At the next layer `SecondDeletedOriginalBound` applies the deleted branch-energy estimate and then the geometric two-energy inequality. The varying-assigned triple set is contained in the assigned triple set and then in the actual original triple set. The last extension uses nonnegative `tripleDivisorWeight`. Consequently a uniform child bound $A$ gives $A\sum_\gamma\mathrm{tripleDivisorWeight}(\gamma)$, not $A^2$ and not an unrestricted complex-sum comparison.

`SecondDeletedAllModes.actual_second_deleted_all_modes_bound:60` sums the two six-element unit sectors and remaining subset choices, producing $36\,2^{|S_1|+|S_2|}$. `SecondDeletedPhysicalRecursive:19` restores the child normalization: for $N$ the formal column exponent and $V_{\rm lab}$ the actual label exponent, the bound is $A Z^{2(\max(0,N)+V_{\rm lab})+\varepsilon_{\rm child}}$. This is where both child sides enter; the exponent and $A$ are not squared a second time.

`SecondDeletedMovingEnergyUniform:16` supplies an actual Fourier density and its weighted integrability, restores the physical factor

\[
e^{6L}\left|\frac{Y\,\mathrm{ray}}{E V X}\right|,
\]

and retains the divisor-mass sum and radial decay factor. The assigned-mark and ray/core aggregation in `GlobalPriorityFilteredAggregateUniform:19` pays $4^K$, finite ray/core cardinalities and coefficient bounds. These depend on fixed structural parameters, not on the later source cardinality.

For clarity, the exact exponent identity in `PhysicalExponents:50` is reconstructed here. Define

\[
\begin{aligned}
\kappa&=M-2r-2\ell-V-\delta+A+B-R/2,\\
H&=2r-2B-M+4\ell+2V+\delta-j,\\
\lambda&=H-\theta-(r-A-B-t-g),\\
q&=\ell+R/2-j+t+g-\theta,\\
N&=r-A-B-t-g-v,\qquad V_0=B+\theta+v+j.
\end{aligned}
\]

Then $\kappa+\lambda+q+2(N+V_0)=F$. The first $e^{9L/2}$, second $e^{6L}$, shifted $Y=Z^{H+12\eta+\tau}$, and mass padding $11\eta/2$ contribute $28\eta+\tau$. `SecondCellParameters.second_cell_clipping_width:110` proves $0\le\max(0,N)-N\le6\eta$ from the live geometry, contributing at most $12\eta$. The actual label padding $V_{\rm lab}=V_0+4\eta$ contributes $8\eta$. Thus the retained exponent is exactly bounded by

\[
F+48\eta+\tau+\pi+\varepsilon_{\rm child}.
\]

The mass smallness condition pays $\pi$. The four-coordinate key count remains $(1+C_{\rm bin}\log Z)^4$; `FirstSecondHeightCost:61,84,137` pays an additional $Z^{\varepsilon_2}$. This derivation does not assume $N\ge0$.

## 5. Discarded branches are charged

Before final absorption, `FirstTwoPassEnergy.original_two_pass_energy:23` bounds the normalized energy by exactly three terms:

\[
\begin{aligned}
&C_0\Gamma^2Z^{M-\ell+3\eta+\varepsilon_1(5\ell+2r+7\eta)}\\
{}+{}&C_1\Gamma^2(1+A)Z^{F+\mathrm{loss}}(1+|\theta|)^{2d}
Z^{(2L_{\rm cap}+15\eta+\tau)\varepsilon_1+\varepsilon_1}\\
{}+{}&C_t\Gamma^2Z^{-\mathrm{saving}}.
\end{aligned}
\]

The first rapid-tail exponent can be checked independently. `FirstDyadicTail.full_first_dyadic_marked_rapid_tail:13` requests local saving $\mathrm{saving}+4F_{\max}+14\eta$. Global aggregation at exponent one costs $B^5L_0^2$ times label mass; two local marks cost $B^4L_0^2$. With $B=Z^{\ell+\eta}$, $L_0=Z^{r+\eta}$, and label mass $Z^{V+\eta}$, this is $Z^{9\ell+4r+V+14\eta}$. Since $\ell,V\ge0$, $9\ell+4r+V\le4F\le4F_{\max}$, so the requested saving pays it. The full-energy caller asks for a further $\eta$ before applying its normalization, which is bounded by $Z^\eta$ when $r\ge-\eta$.

The second pass also retains its zero and tail branches in `GlobalPriorityFilteredStepUniform:19`. `GlobalPriorityTail` charges the source/mark capacity losses before `GlobalPriorityTailPhysical` charges the physical prefactor; the latter asks the former for an additional $L_{\rm cap}$. These rapid estimates are used with their complete capacities and fixed-window seminorms. Their lower analytic rapid-decay proofs remain in the cut below.

## 6. Reopening and actual height dependence

`ReopenedIntegralEnergy.varying_separated_canonical_integrable:16` proves integrability by the explicit finite cube/subset expansion. Its family-energy theorem at line 38 uses an integrable Schwartz weighted majorant and the finite-row integral-energy inequality. For $B=Z^\ell$ and length $Z^r$, the reopened row has prefactor $1/(B\sqrt{\mathrm{length}})$, whose squared norm is $(B^2\mathrm{length})^{-1}$. Thus the raw separated-energy factor $Z^{r+2\ell+V}$, this prefactor, and outer $Z^{-V}$ cancel exactly. The final square of the reopening moment is therefore properly normalized.

`CanonicalReopeningHeight:12,23,35` identifies the reopening coefficient with the Fourier transform of the frequency-twisted logarithmic source. `DescentHeight.frequencyTwist_fourier_moment:10` bounds the requisite finite collection of Schwartz seminorms by a fixed constant times $(1+|\theta|)^{J+\mathrm{integrablePower}}$, and applies the uniform Fourier moment bound. Squaring is justified by nonnegativity. The constant is chosen before the arbitrary real height. The actual consumer `CanonicalLongHeightBin:94` supplies the required smoothness of the norm-twisted source explicitly. The common-measure densities elsewhere may depend on the parameters; their uniform weighted bounds, not equality of densities across heights, are what the proof uses.

## 7. Exact remaining cut

The following are substantive lower inputs, not conclusions of this audit:

* The four actual normalized child moment bounds in `FirstLabelCellStep.ChildBounds`, and their eventual production by descent/induction.
* The foundational actual first-kernel Poisson/CRT formula and its absolute summability. The application of `actualFirstKernel_summable` and exact complement split was checked; the complete proof behind that summability and Poisson transformation was not re-proved here.
* The retained push and live-key arithmetic estimates, including `first_retained_actual_second_energy`, `first_global_retained_push_uniform` and `original_live_joint_small_power` used by the retained caller.
* The lower deleted-branch estimate `actual_second_deleted_mode_branch_energy` and the underlying normalized divisor-mass bound `actual_second_normalized_mass`. Their finite-set transport and energy/mass assembly were checked; their complete arithmetic fiber proofs were not.
* The radial Fourier envelope and Schwartz moment foundations used by `FirstProfileUniform` and `InverseSecondProfileUniform`, and the local rapid-decay producers `first_whole_cube_rapid_physical_tail` and the lower second-tail estimates. This audit follows how their actual functions, constants and losses are consumed, not a new derivation of all those foundations.

These cuts are noncircular in the inspected caller graph: child moments and arithmetic/analytic estimates are supplied below the two-pass assembly; the outer two-pass conclusion is not used to construct them here. This does not certify an uninspected global dependency graph. Empty individual sources may give zero legitimately; no step replaces an arbitrary required source by an unsupported empty batch.

## 8. Pinned inspected source

Line references above identify declarations rather than claiming every declaration in each file was audited. SHA-256 values below identify the exact read-only source version. Independent review should retain the conditional scope and the cut in section 7.

| Source relative to root | SHA-256 |
|---|---|
| `Descent/CanonicalLongUniformTestBin.lean` | `2FA3CEFB0FFFF170E3133F258B398629F24758ECA90B21697D82138A03C7BBCE` |
| `Descent/CanonicalReopeningHeight.lean` | `DF4C4E6307A018D01077885372032FFE4CFE0621420ECD56583B46DD536EACFA` |
| `Descent/CanonicalLongKeys.lean` | `042F7520CFC73A3D625E74B9852E7143CDBB4AB57E0B0D0FEE278368CECA687F` |
| `Descent/CanonicalLongParent.lean` | `B6FC179C1695A5A209A6591DE449162C0395419CAF8089341A6DD36EB0F096B9` |
| `Descent/CanonicalLongIntegral.lean` | `8EFC07460A8B4F45263F6F04AC8F156D65F679766F46641259C6531E4EE40E43` |
| `Descent/CanonicalLongHeightBin.lean` | `A9B75C9A183BABFBF48D41EA84F2A72925FF1F3287D87D30CD9C6A4E1AA561C7` |
| `Descent/ReopenedBinEnergy.lean` | `F448EF0EF5E41A1FE617559BD80919612D0B1DE285BAD00F71ED5A543812BC5E` |
| `Descent/ReopenedIntegralEnergy.lean` | `36F88E0DD1E3E9425A4CF8E87715B1DD237EF460F162B0DC40ACC524EF6E99D6` |
| `Descent/FirstTwoPassParentEnergy.lean` | `F69ADA6D725C88AF35F8449A94A72FC5E7B8B584C0A1AB9B1E21AC0646FD0D72` |
| `Descent/FirstTwoPassEnergy.lean` | `F6541375A50B6C944CC19F5760AED2ADE98BCB6291864377D1FFE757FE2C4C42` |
| `Descent/FirstDyadicFullEnergy.lean` | `A81CE2AEF5DCB5804EF556376C0801C504F01899C3C104AEE15ACFAB2C1DFFF4` |
| `Descent/FirstGlobalSourceEnergy.lean` | `0A153B81D3EB4C19B01A93CDB3A4F798EB88459E4DA02F961BB8419E79052388` |
| `Descent/ReopenedPhysicalEnergy.lean` | `7B8E624077DD8C290EBB09217D4389347B275C1E691BEB2818C4223501D2DC16` |
| `Descent/ReopenedPhysicalSplit.lean` | `AE569652D48275BA2A3DFDA1E8D532C97091C5969D6D07D19FB637E3C0098A1A` |
| `Descent/FirstRetainedPhysical.lean` | `0D62057EED683D99DDA589ACB96133660582E9A8D8421F8A0D4048A7680E42B5` |
| `Descent/FirstCanonicalPhysical.lean` | `B18623123CF03BDCB96FCD33F31100002D81ABF02E060EA1B07EE64E922CECF4` |
| `Descent/FirstDyadicRetainedEnergy.lean` | `AB7F6F719D08D3D9ECF3EFA3B1D45F5E59997BE40F8C4F427D2E940222659012` |
| `Descent/FirstDyadicRetainedBudget.lean` | `F4F49C73A24F45DFC28270B5AFE44048D3482E7B9706D3B4D70C24B95F258670` |
| `Descent/FirstOriginalProfilePhysical.lean` | `EEEA6D2395318E83903ACBE5CFA5B875E558E84F3318D52B6347E5A149E709DB` |
| `Descent/FirstHeightBudget.lean` | `CC4BF52C05F36699EF10696E322F16EE6E20A885C2F6CD0FED0E20BB2D011BC6` |
| `Descent/FirstFamilySource.lean` | `F02FF19C0126E0EDF15B875272EF2E715E3A0A47703ABDDBD27D37D0210A9DDF` |
| `Descent/FirstFamilyEnergy.lean` | `AEDCBD90A1DBFB5B61078E2A14619CE409E7B17EAE79986498CBCA856E8E2E13` |
| `Descent/FirstUnequalEnergy.lean` | `6581DD04246446A9D65A183C46A8DB158EF1A43D722C7725107EA9C45BF3AFA5` |
| `Descent/FirstProfileUniform.lean` | `77351AE45B77FF7A31D27C7A70BA8A217970488C359FFBDA4BE54ED497D29761` |
| `Descent/FirstLiveActualStep.lean` | `BECD305A5C49B903F29C427D1CF31FA0ED50EB01CF8342C98085A380DE618A37` |
| `Descent/FirstLabelCellStep.lean` | `E0D563F40C4E48CC87E08DBDE617A9CB223D23C508B72F1F3C573885AD53505B` |
| `Descent/GlobalPriorityFilteredStepUniform.lean` | `F8D762FE1B85CA0F95B7BFD747A987C4B0B610591F8AF289569A9BE2ADC881B9` |
| `Descent/GlobalPriorityFilteredAggregateUniform.lean` | `2E790676C47776B7508C0C0894AF060CEF2C221FD59316B2507C3558976767CC` |
| `Descent/GlobalPriorityFilteredEnergyUniform.lean` | `C58689BF417BBB95DAEDF161A5F8ECBFBF523EF54B68D2B097A62D2F0B95FFCD` |
| `Descent/SecondDeletedMovingEnergyUniform.lean` | `7D1A62361CFE16FCB9C0E917E4E224C7D5293C7D188F4C916085496188D664A0` |
| `Descent/SecondDeletedPhysicalRecursive.lean` | `40764E61BFE27F13192C2D9F6CCFD9C05978A1E0BD73D57B78219629512F20F8` |
| `Descent/SecondDeletedAllModes.lean` | `62F6CE6730C852B497E75981B0BE28261F5E3563F5F5D7724241CE15D7814B8C` |
| `Descent/SecondDeletedOriginalBound.lean` | `FF6C6842DE3758AF25ED55CBA71D055DA30724F3BFF29D1ED6F270D00332E46C` |
| `Descent/PhysicalExponents.lean` | `A872431FB5FA7D144735553D9988AA797E780F4679A73A53FB3491E341ABF509` |
| `Descent/PhysicalBlockBudget.lean` | `78320F89F1E7CC626CF7D63025CA089BB4E3358D3509C30780860A256261D8FB` |
| `Descent/PriorityCellBudget.lean` | `578BB0AFBEE84EEA94128B061D3B740673358D343058304880B590EDFE6C8FC4` |
| `Descent/PrioritySourceBudget.lean` | `1EBFBA3E92F6E8F3D3D4C26996CAFC25CA1B00332920A5DBBBBE9498B5D1C0B2` |
| `Descent/SecondCellParameters.lean` | `F9F442C2DFBF9411AD01F038FC56CD93EF1EBB3FAACC71C9A31D32063CC25AEC` |
| `Descent/SecondOriginalMass.lean` | `F2D61082640D94B533DED131C52990D32B04F9CFF01F9229A1908758FEC25567` |
| `Descent/FirstSecondHeightCost.lean` | `538372410B122ED95FB5E4F3CF7F3A3234D2F2E64A2778BA24EF27B1959E1F15` |
| `Descent/FirstDyadicTail.lean` | `94117225A4DCA653D1B42197A4381E4732AF73DBBD7311B05BE214DDB7F875EE` |
| `Descent/GlobalPriorityTail.lean` | `D8A494EA9F504D5871593EE816DE0782909452BD9E15BC63CBE5FC5F863FC2E4` |
| `Descent/GlobalPriorityTailPhysical.lean` | `EC1AE37A3E78C8024DC43BA6AF05707B7C53D32D2DA4A2B6544F3C8C95ACFD32` |
| `Descent/DescentHeight.lean` | `7DB84DA1103F958D1B005F5F61E6DA5A1EBCEADA8EC9586FD4BBB82569B56C37` |
| `GaussSum/BranchScaling.lean` | `F10218E1A4BBAF2F67144511D697AF496CE8273636E3B9AF03E3334FDE7616ED` |
| `MeanSquare/CanonicalDensity.lean` | `95083D8287953D3BD25A67E71A96CA6869C33E849F039D03E66247BE45CB78CB` |
| `Inversion/WholePriorityRetainedSource.lean` | `550B3D3ADCBD174074CA7E5CA06C34712B8A0F936090B17AB3E3519241EBDD59` |
