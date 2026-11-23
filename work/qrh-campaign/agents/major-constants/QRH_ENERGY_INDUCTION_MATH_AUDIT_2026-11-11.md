# Bounded mathematical audit of the QRH energy induction

Date: 2026-11-11. Status: **no defect found in the inspected induction and exponent accounting; global QRH provider not validated**. This is a source-reading audit, not a compilation, axiom audit, or verification of every analytic dependency. No Lean build, evaluator, or numerical experiment was run. The current research checkpoint was read before the audit.

The four requested files contain a meaningful induction on a combined row/conductor width. They do not simply assume the next band. The substantive analytic issue is whether their imported physical-column and prime-polynomial estimates hold with the displayed normalizations and uniformity. The present audit checks the local mathematical mechanism and identifies those remaining boundaries explicitly below. It does not establish an unconditional improvement over known estimates.

All source paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`. Line numbers are one-based and refer to the SHA256 pins at the end.

## 1. What is actually being bounded

`Energy/State.lean:15–45` gives a `NaturalState` a character, a fixed inducing modulus, a nonzero puncture, and an actual radial profile. Its width is `rowWidth + characterWidth`. The radial scale is exactly `Z^rowWidth`; the character modulus norm is bounded by `Z^characterWidth`; the puncture norm is bounded by `Z^Bmask`. Kept rows are nonzero and exclude the specified fixed-inducing rows. Thus the estimate is not, by definition, an estimate for all rows including the exceptional fiber.

`Energy/Bands.lean:20–53` defines `ZeroAt` and `PositiveAt` using the actual energy function. ZeroAt bounds plain energy by

`C * diagonalControl(radial.profile) * profileControl^2 * (1+|t|)^degree * Z^(width+loss)`.

PositiveAt uses the prime pools, relative-character ideal coefficients and annular weights, and imposes the explicit capacity condition

`length(Z,X1)+length(Z,X2)+6*kappa*sum(w_i) <= state.width`.

Both quantify over all admitted states, profiles and positive scales up to the specified `Z^L`. The logarithmic length uses `max 1 X`, not `X` without a lower cutoff. `State.lean:50` identifies plainEnergy with **zeroEnergy**, not with the number zero.

`CappedWidthInduction.lean:49–61` orders its quantifiers as follows: first choose the degree and finite set of profile seminorms; then for each character `eta0` and ideal `Q` satisfying `Q <= M`, `internalQ != 0`, `internalQ != top`, and `internalQ <= span{72}`, choose two positive constants and an eventual-Z threshold. The threshold need not be uniform over the infinite family of eta0. No such stronger uniformity is justified here.

The global hypotheses retained by `CertifiedExistence.lean:19` are positive compact support for the slot smoothing, `0<a<=1/4`, `b>=1`, nonnegative mask capacity, positive width cap and error, `kappa>=3/4`, `beta>=51/100`, and `2*beta-1<=kappa`. These are not a finite-GRH hypothesis. Conversely, this conditional theorem alone does not eliminate beta or prove the desired global zero bound.

## 2. The successor is triangular

The proof body of `CappedAnalyticSuccessor.lean:30` does the following, with parent width the capped width at k+1 and child width the capped width at k.

1. `CappedLowStage.actual_capped_low` obtains new low positive/zero energy from the old zero and positive band.
2. `NaturalHighStage.actual_high_stage` obtains new high positive energy from the old bands plus the new low band.
3. `NaturalZeroStage.actual_zero_stage` obtains new zero energy from old bands plus new low zero energy, through a growth estimate and a contour recovery estimate.
4. Packing combines these outputs into the next certificate.

The low stage invokes `NaturalLowStage.actual_low_from_bands`, which in turn combines an actual physical mass bound with `PositiveLowSourceControlled.actual_low_stages_from_physical`. The high and zero stages are implications whose antecedents are supplied by earlier steps of this list. They are not used to manufacture their own antecedents. Restricting old states to radial support 2, zero puncture exponent, and the required child length is explicit in the caller.

The interval bookkeeping is also explicit: the old support lower endpoint is the new endpoint divided by `max 1 b`; the previous length exceeds both the new requested length and the reflected/growth length. Increasing support at the next stage is paid for by starting the induction with a smaller positive endpoint. All these are finite-stage operations; no passage to a zero support endpoint is used.

## 3. Independently reconstructed exponent budget

Here M is the final width cap, B the final source cap, epsilon the target error, and A the declared parent capacity. Put

`s = min(1,epsilon/16000)`, `n=count(M,epsilon)`,
`Lscale=n+M+10B+30`,
`r=min(s/100,epsilon/(1000000*Lscale))`.

The source schedule is

`w_k=r/16+k*s/2`, `ell_k=epsilon/1000+r+64*k*r`,
`mesh=r/(kappa+1)`.

In particular r>0, r<=1/100, kappa*mesh<=r, and ell_n<=epsilon/500. A child width at most `parent-s/2` lies in the previous uncapped band; the additional cap `min(M,w_k)` preserves this implication. The terminal width equals M because `M<w_n`. The final loss is subsequently enlarged to epsilon, not silently identified with epsilon.

The low physical estimate has four terms. `FirstGaussianProfileWeights.lean:15` contributes

`[2*d+es, 2*es+2*d+2*(5B+1)*theta, 0, 0]`,

and `Moments/FirstAmplifiedFourCoefficients.lean:42` contributes

`[paid, 3*s/2+5*(delta+rAmp)/6, 2*s+delta+rAmp+es*A, 2*s+delta+rAmp-saving]`.

These are actual powers in a four-column bound, not four new hypotheses in CertifiedBand. `FirstSourceParameters.lean:18–20,63–95` chooses

`es=r/[8(A+1)]`, `emask=r/(2B+1)`,
`d=theta=rAmp=thetaSource=thetaClip=epsilonRemove=r/4`,
`saving=2s+1`, and eventually `0<=delta<=r/4`.

The paid exponent equals

`2B*emask + ell + epsilonRemove + (delta+rAmp+thetaSource)/6 + thetaClip/3 + kappa*mesh`.

For any old loss ell<=ell_k, it is at most `ell_k+59r/24`. The external column cost is `es*(A+1)+r/4=3r/8`. Consequently the four complete column exponents satisfy the following direct bounds:

| Column | Bound including external cost |
| --- | --- |
| inherited/main | `ell_k+83r/24` |
| exceptional | `3s/2+(5B/2+49/24)r` |
| diagonal | `2s+r` |
| rapidly decaying | `-1+7r/8 < 0` |

The required upper bound is `columnLoss=ell_(k+1)-9r/4`. For the first column, `83/24 < 64-9/4`. For the second, `5B/2+49/24 <= Lscale/4`, so its bound is at most `3epsilon/32000+epsilon/4000000 < epsilon/1000`. The third is at most `epsilon/8000+epsilon/1000000 < epsilon/1000`. The fourth is negative, while columnLoss is positive. This independently checks the central finite exponent accounting.

Importantly A need not be <=M. `FirstDeclaredCapacityLossBudget.lean:13–18` pays the extra `es*A` explicitly, and its chosen es makes both `es*A` and `es*(A+1)` small. Replacing A by M without that payment would be invalid; the inspected code does not do so.

`FirstActualFrequencyBudget.lean:16–26` obtains the eventual frequency bound from `128<=Z^(r/8)`, hence `log_Z(128)<=r/8`. This is eventual in Z, not a numerical claim at a prescribed small Z.

## 4. Where the width gain comes from

The gain is not merely the identity `w_(k+1)-s/2=w_k`. `Energy/AmplifiedChildWidth.lean:145,182` proves that each relevant nonzero main/error physical block has

`log_Z(dyadicScale)+log_Z(norm(child character modulus)) < parent-s/2`.

Its proof obtains a nonzero actual lattice row and a ball-profile witness (`:38`), bounds the child's nominal scale by a fixed geometric constant times `volume^2 / chosenRadius` (`:53,80`), and invokes the physical radial/conductor calculation in `Moments/AmplifiedChildWidth.lean`.

In that file, `:90–100` is an exact identity of real exponents. The unmatched quantity `u-max(u,0)` is nonpositive. Substitution of the exact conductor products gives a `-2s-delta-reserve` term for the main branch (`:112`) and `-s-delta-reserve` for the error branch (`:132`), plus fixed conductor constants. The physical radial estimate (`:156,189`) adds `xi/2` and a fixed logarithmic constant. For `xi<=s/4`, `exists_fixed_width_threshold` (`:265`) makes all these fixed costs <s/2. The final width-drop lemmas are `:422,442`.

This establishes the algebraic origin and the correct direction of the strict gain, conditional on the radial-block and conductor identities invoked there. The error branch explicitly restricts valuations to 0,5,6; those restrictions cannot be discarded. Proving the relevant block decomposition has only those error branches is a separate analytic/algebraic dependency.

## 5. How inherited energy is used, and where beta enters

I followed one main-child route through `CanonicalMainPaid`, `CanonicalUniformReference`, `CanonicalReferencePaid`, `CanonicalPaidSource`, `CanonicalLiveBound`, `CanonicalChildBound`, `AllocatedHomogeneous` and `PaidRemoval`. These are successive adapters, not independent reasons to believe the underlying estimate.

The decisive inherited-energy use is `PaidRemoval.lean:19–77`. A finite set R of prime slots is removed. `PaidBands.remaining_energy_bound` then applies the old ZeroAt if all slots were removed, and the old PositiveAt if the remaining capacity fits. The price is

`Z^(epsilonRemove + excess/6 + kappa*mesh)`.

`Moments/RelativeCapacityRemoval.lean:61–159` proves this price by multiplying individual normalized-slot squared bounds. It assigns each slot loss `epsilonRemove/(card+1)`, so all fixed losses total at most epsilonRemove, and uses the finite removal inequality `kappa*sum_removed w <= excess/6+kappa*mesh`. No average cancellation is assumed in this step.

Those individual bounds come from `NaturalFixedRaySourceNaturalPrime.lean:35,73`. The nonexceptional condition is used to show all relevant ray twists are nonprincipal (`:19`). For a fixed eta0, its modulus is absorbed by taking Z at least that modulus; this explains the permitted eta0-dependent threshold. The source then invokes `PrimeHeight.ray_prime_all_height_squared` (`:152`):

`norm(rayPrimePolynomial)^2 <= C*(1+|frequency|)^degree * Z^loss * P^kappa`,

under the displayed conductor/scale caps, smooth compact support, nonprincipal twists, beta>=.51 and kappa>=2beta-1. The proof at :152 separates bounded P from large P. Its large-P input at :68 invokes **`CenteredMomentPrimeGlobal.ray_prime_global_squared`**. That global prime estimate and its analytic derivation have not been validated by this audit. The source use is parameterized by beta; it does not at this point assume beta<=7/8. The later argument that forces an improved beta requires separate inspection.

The radial summation in `Energy/CapacityRemoval.lean:22` is justified by finite support in a lattice norm ball, not by treating a potentially divergent tsum as zero. The scalar nonnegative multiplication in the inherited-energy step is consistent with the actual radial data. Empty live-block cases in `CanonicalLiveBound` are proved to have zero energy term-by-term; they are not used as a blanket assertion that every state is empty.

## 6. Terminal scope and nonvacuity cautions

`CertifiedExistence.lean:19–38` performs ordinary Nat induction to the finite count; :40–end first builds at `max 2 radial` and restricts to the requested radial cap. `CappedRadialTransport.lean:18` is restriction of admissible states, not enlargement of their support. The terminal result permits arbitrary positive radial cap, despite the internal low/high machinery requiring at least 2.

I found no local quantifier reversal or use of the next certificate to prove itself. The zero smoothing, empty finite slot set, or an empty particular state family can make a specialization trivial; that does not show the universal certificate is vacuous. This report has not proved that the final QRH detector produces the required nontrivial states. The separate independent audit is checking that consumer. It must also check the exceptional-row contribution; the nonexceptional energy estimate alone does not cover it.

## 7. Exact unresolved analytic boundary

The following are **not certified by this bounded audit**, even though their source declarations exist. They are the appropriate next tasks, rather than another inspection of the Nat induction wrapper.

| Boundary | Exact source location | What still needs substantive validation |
| --- | --- | --- |
| Prime slot input | `Moments/PrimeHeight.lean:68,152`; call at :89 to `Moments/PrimeGlobal.lean:28`, `CenteredMomentPrimeGlobal.ray_prime_global_squared` | Actual smoothed prime-polynomial bound, uniform in growing conductor/scale and frequency, with beta-dependent exponent and no circular use of the desired beta conclusion. The top adapter and its hypothesis propagation were read. |
| Main/error column synthesis | `Energy/CanonicalLowColumn.lean:122` (`actual_admitted_subsets_low_column`) | Its complete decomposition, four coefficients, amplification average, valuation branches and all scaling factors. Only the consuming contract and the exponent definitions were inspected; a proof of the whole large body is not claimed. |
| Physical mass normalization | `Energy/FirstPhysicalNormalization.lean:208` (`actual_physical_mass_of_columnBounds`), invoking `Moments/FirstReferenceEnergy.lean:69` (`actual_physical_mass`) | The theorem body reduces to actual_physical_mass plus the paired-budget polynomial bound. The underlying block mass/Cauchy–Schwarz/summation theorem and all uniform seminorm estimates remain to be audited. |
| Physical-to-low conversion | `Energy/PositiveLowBandSource.lean:44` | Actual energy decomposition, removed/exceptional terms, and their conversion to low zero and positive energies. The controlled wrapper's constant bookkeeping was read, not the entire underlying analysis. |
| Initial floor | `Energy/WidthFloor.lean:29`; calls at :46–51 to `Energy/Floor.lean:11` (`exists_zero_floor`) and `Energy/Bands.lean:55` (`exists_positive_bottom`) | Genuine initial energy bounds. The assembly and initial widths were checked; the analytic floor producers were not. |
| High/zero analytic recovery | `NaturalHighStage.lean:30`, `NaturalZeroStage.lean:24`, `ZeroGrowthOriginal.lean:52` | Reflection/growth-contour estimates and their actual functions. The stage dependency and loss transfer were checked, not their complete analytic derivations. |

The chosen radius creates a favorable child width but also produces the four new physical costs. Thus checking the child-width identity alone would not prove a stronger energy bound: both the synthesis/normalization theorem and the costs in section 3 are essential. Likewise the smallness of the arbitrary error epsilon is paid for by potentially enormous thresholds, degrees and profile constants. No effective numerical QRH certificate follows from this source reading.

## 8. Source pins

These hashes freeze the principal audited contracts and the explicitly identified boundaries. A hash does not imply the full file was verified; the scope of each read is stated above.

| File | SHA256 |
| --- | --- |
| Energy/CertifiedExistence.lean | 498BEA492166111FC95D17B7F2C379D26BF6D03013299B8D410793EA0B438066 |
| Energy/CappedAnalyticSuccessor.lean | 4EC231F505ED8D60B0CC096951EA1F259E96E1B4C4709DEDA62FE0E69351E772 |
| Energy/CappedWidthInduction.lean | 4D9ED300268C73C78C65E7102D538EEF72613A450099C35131E12BA2B50C4325 |
| Energy/CappedRadialTransport.lean | 75DE077BD37F5309AB213DF1126DD42A40DA14D1040B8C90A233ED0A007535B7 |
| Energy/Bands.lean | 42FD3FE963D8DEEF1CC5772979B41A8273E80940641E9F24475FF33397A09C2E |
| Energy/State.lean | B5118D2F6F04ED495A6317317B74A7D60BA1B32F2050AEB7EE7E9E4783D67222 |
| Energy/WidthSchedule.lean | B1DA2BF9CA130FF9C6B0F8A37E2CD86B449D0DEAECF0F7A4576EB92A38440B5D |
| Energy/StageReserveSchedule.lean | 47938137986F9B4B6A7518E35C6E5278C6AFC57792247CCA4B009A1CBF25FB5F |
| Energy/CappedLowStage.lean | 65DDBCCF257ECEC57A727C4DBB010D7B7875597A24600CCF4637812B424AA906 |
| Energy/NaturalLowStage.lean | E831B3EFB8C8EBE45767CFFF4188BFB0DD9C01C3E033A1D943AC2D5F9C2A37D4 |
| Energy/NaturalHighStage.lean | 9A8E0F9C45BBEA861336F632D48A526A47694C0A71A860FE88B65E420ED492AB |
| Energy/NaturalZeroStage.lean | 7745F22169E40515D27022D4A88DA9E4BB94A47A50F876FBD2740F9014CD865E |
| Energy/NaturalLowPhysical.lean | 46395476353507AA86001CE63A8E4599CB72BDDDB382408B502A0B371F82359A |
| Energy/CanonicalLowPhysical.lean | 572B4C44F799B555D2D3C89A896FAA253F89EEE54337A0DFE32C3864EE96D79D |
| Energy/FirstSourceParameters.lean | 4837B7D97B1D51C1F4319EBE5DEFC30A141FD63F11CE2B26CCFD048A86EE8C75 |
| Energy/FirstActualFrequencyBudget.lean | 340DC8F4B7AA923AA2294BC69AEFF2F668566DD848FB2482087C92562E877A14 |
| Energy/FirstDeclaredCapacityLossBudget.lean | 7435FF2AB1FCD2EFBEEAC92655939CE02C4535D0E8BFABE63EB77D4D5A302141 |
| Energy/FirstStageLossBudget.lean | E9C1E509832F8C2456983CEF242F19231EF572571A27955BBFF96F61D1FE2220 |
| Energy/FirstGaussianProfileWeights.lean | E6F0FF771F7B29F85F1A570DE31B441D87D78920B46EF74508CD54429DC70192 |
| Moments/FirstAmplifiedFourCoefficients.lean | 8BAF4B3C85B109797581667070238E0107AE1068423749F4AD930AB470035FB4 |
| Energy/AmplifiedChildWidth.lean | 631AA47C7E6AB7CA1F55202D3417AEE126518F983390F0ED9BFA2F3A74013EE8 |
| Moments/AmplifiedChildWidth.lean | 6F304FF331BA073E0138C3D42DF5A37374B936721ED9C2AC63F6420B3E6E388A |
| Energy/PaidRemoval.lean | E82461C13865D99700722DB9E2D2863B0C203E5BF05DFAB89EFC59BE275CDAAE |
| Energy/CapacityRemoval.lean | 01429C7A3230A11416C654B56616410595BC2C76FCB5FBDE274B0DF8E514A157 |
| Moments/RelativeCapacityRemoval.lean | 0FFD039FAC65AB444062267B32F9C3C625523B499D810012BAA4A48395F8A7D3 |
| Moments/NaturalFixedRaySourceNaturalPrime.lean | CA6A36E22778FA91B262985F24010BF55697A59FD9A654413D7DA8FB7CAE312A |
| Moments/PrimeHeight.lean | A1EC164AF7FF7B0D757E3B6DBBD43DCF9CD394DBE50783C35FE970DD84F64B12 |
| Moments/PrimeGlobal.lean | 8FFC0F6629F775AA1BD9DA2CC1FB61F4D37DD710B214035299C800EC8DFFFE9E |
| Moments/FirstReferenceEnergy.lean | 8CE5CC555EC7335258793C972EBBD2AF52441391F5B4918E45272F95BDF73E02 |
| Energy/Floor.lean | C21817E4B2C47A5B2DEA174CC15897358A01B05F873880AF9727C2925093B54D |
| Energy/WidthFloor.lean | CAF4B5BEE946E7E441A8E26046696BC1D75976CDD76F87E1ED10A173E6C3E6CA |
| Energy/FirstPhysicalNormalization.lean | B91950CF1E30F4680D0E83A06D33BB9D4DD0FB3BF0F33D28F06A835D6E06E270 |
| Energy/PositiveLowBandSource.lean | 9E14E3172C8AA25E8DF5FB89A90F2A50A8F86A954EC3495963B34122A60995E6 |
| Energy/ZeroGrowthOriginal.lean | 6282A4B2C61775A1C92E9F62344366560379EEFF92CA529389C8B57A411BCA7D |
| Energy/CanonicalLowColumn.lean | BB81827AE7A2A730685CB3B977E07E3913AAA98349EB8BCCAB6EAAB70B7BB074 |

No source files were changed. The next bounded audit should take one of section 7's analytic statements and its actual proof body, rather than treating this report as closure of those statements.
