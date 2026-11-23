# Independent review: seeded Gaussian source energy

Date: 2026-11-11. Reviewer: major-constants.

Verdict: PASS within the bounded source/mathematical scope below. No correction requested. I read the frozen author report in full, compared its substantive claims with the source bodies, and independently verified all 39 source hashes.

Author report: `independent-feasibility/QRH_SEEDED_GAUSSIAN_SOURCE_ENERGY_AUDIT_2026-11-11.md`, SHA256 `9CD95D94917B765A1B0A3F9901A81BDD8617901C50B3A6B99063B3E23553A4BB`. The author report is unchanged.

Source baseline: `work/openai-math` commit `4eaee87548250b2682affda7d05d947c05554bae`. Source paths below are relative to `lean/OAI/NumberTheory/DirichletL/`. This is a bounded mathematical/source review, not compilation, axiom validation, or validation of the global QRH provider. No Lean source was changed and no numerical analytic evaluation was performed.

## 1. What this round checks

The two selected consumers are `Moments/SecondFrozenLiveSource.original_nonexceptional_energy` and `Moments/SecondSourceRemainder.original_source_remainder`. I independently emphasized the actual retained/remainder split, source normalization, seed factors, and the discarded-tail argument. I also read the supported-child bridge, canonical radial specialization, ratio cancellation, and harmonic aggregation.

The earlier retained-window audit concerns `Inversion/InitialRetainedWindow`; its conclusion does not directly discharge these Moments producers. The earlier global-tail audit concerns `InitialHighFrequencyTailRapid`. The exact shared lower tail input is instead `Poisson/RadialFourier.paperRadialFourier_lattice_tail` (544–582), reached through `Moments/Tail.uniform_sector_lattice_tail` (156–173). Reuse of that lower result must not be described as reuse of the whole earlier retained or tail consumer.

## 2. Supported children and ratio cancellation

`SecondSupportedChildren.lean:71–175` retains the actual squarefree divisor pool, exact coprimality masks, actual character-height identity, and supplied source-restricted energy estimates. Those estimates are hypotheses. The theorem does not derive them from the earlier geometric `Ready` predicate.

There is an important zero case. If `Norm(L)>Hsource/Norm(D)`, the right source coefficient is identically zero: a nonzero coefficient would give `L | I` and `Norm(D*I)<=Hsource`, contradicting that inequality (`54–69`). The proof therefore uses a finite coarse left energy outside the live divisor range and zero on the right (`115–147`). It does not delete a possibly nonzero left term on its own. The product of the two window budgets is then zero. On the live range each energy is bounded by `E_i/Norm(L)`; the paired square roots produce exactly one factor `1/Norm(L)`, not its square. The remaining Möbius harmonic mass costs `Z^delta` (`148–175`).

I also checked the corresponding nonsquarefree completion in `SecondSquarefreeBlock.lean:63–104`: both energies receive finite coarse bounds on nonsquarefree divisors before the generic estimate is applied, and only then do their Möbius weights vanish. `CommonLiveFrozen.lean:37–119` combines an actual weighted allocation decomposition with `actual_uniform_divisor`, pays the allocation count squared and the two losses `delta/2`, and retains `1/(Norm(C)*Norm(L))`. `CommonLiveHeight.lean:20–46` unnormalizes by the positive actual raw volume. This is a separately read use of the allocation mechanism, not an assertion that the earlier first-allocation theorem has the same statement.

For the analytic finite-sum join, I independently read `Cauchy.lean:11–129`, `RestrictedEnergy.lean:82–130`, and `RestrictedWindow.lean:39–127`. Finite row Cauchy is applied pointwise against the same Fourier density; the weighted Schwartz integral is finite. The window proof puts the square root of the nonnegative lattice weight inside each finite-row integral, uses the true height shift `t+2*pi*(w-theta)`, and bounds all finite row sets before passing to the nonnegative series. The conjugated right column and negative row argument stay explicit. The common-density and actual-column representation inputs are not replaced by hypothetical independent densities or pointwise consequences of an L2 estimate.

`SecondFrozenChosen.lean:49–143` uses the actual canonical radial function: the ball profile and the predicate excluding the fixed inducing row, together with nonzero frequency. The family identity transports this predicate to the source predicate in each child; it is not replaced by an arbitrary majorizing row set. The source coefficient norm bound supplies the actual divisor cutoff. The ball profile majorizes the actual dyadic rows. The constant and eventual threshold are chosen before the varying source, seed, row, character, and dyadic indices appearing afterward.

I checked `SecondRetainedRatioScalar.lean:21–110` directly. For `r>0` and `0<=a<=1`,

`r/(1+r) * max(1,1/r)^a <= 1`.

For `r<=1`, use `(1/r)^a<=1/r`; for `r>=1`, the maximum is one. In the actual source expression the effective kernel scale is at most the first dyadic scale when the physical block is nonzero. The exact scalar cancellation, including partition normalizer and child envelope, leaves this ratio times the stated fixed conductor factor. The residual source norm bound then supplies `4*fixedFactor*Norm(eta)*Hsource/sqrt(Norm(C)*Norm(D))`. No lower bound for a zero physical block is used: `SecondFrozenRatioCost.lean:105–107` handles that case separately.

In `SecondFrozenRatioCost.lean:110–144`, both child estimates contain the *same* nonnegative envelope `E`. Thus `sqrt((E1*E)*(E2*E))=E*sqrt(E1*E2)`. Taking decay one and exponent `a=1/6` cancels the retained-ratio penalty exactly. This is not an inference from an upper bound for an unrelated row energy.

`SecondNonexceptionalAggregate.lean:31–87` sums norms of actual physical blocks. `SecondBlockHarmonicMass.lean:106–141` separately pays `epsilon/2` for the active labels and `epsilon/2` for their dyadic blocks. The result is `Z^epsilon/Norm(seed)`. Combining this with the local `Z^(2delta)` bound gives `Z^(2delta+epsilon)/Norm(seed)` in the selected nonexceptional theorem. Squarefreeness and nonzero seed remain explicit requirements of this harmonic step.

## 3. Exact remainder, not a signed-energy comparison

`SecondLocalization.lean:26–80` identifies the actual Poisson argument as

`Kphys * Norm(h)/(Norm(I)*Norm(J))`.

The denominator comes from the squared complex norm of the product of primary generators; it is not a second extra square of the ideal norms. The outer kernel factor is `Kphys/(sqrt(Norm(I))*sqrt(Norm(J)))`.

`FirstLocalization.lean:17–65` proves summability of the complete, retained, and discarded weighted Fourier series from the lattice norm-summability theorem. It then removes the zero term and uses retained plus discarded weight equal to one at each nonzero lattice point. Both weights vanish at zero. Thus the decomposition is an identity between genuinely summable series, not a use of a default value of `tsum`.

The finite retained-row partition in `SecondEnergySplit.lean:21–85` is also exact. The source rows are nonzero, which makes the complement of the exceptional predicate equal to the defined nonexceptional part. It follows that

`sourceGaussEnergy - partEnergy(false)`

equals the sum of (i) `Kphys*paperRadialFourier W 0*sourceSecondZero`, (ii) `partEnergy(true)`, and (iii) `secondDiscardedEnergy`. `SecondSourceRemainder.lean:114–155` takes the norm triangle and divides once by positive `V=volume s`. It neither asserts positivity of the three complex terms nor assumes cancellation between them.

## 4. Zero mode and the seed divisor

I inspected the finite zero-mode argument below the wrapper. In `SecondDiagonal.lean:14–47`, a nonzero residue-character summand at frequency zero forces each residue to be a unit. The scaled congruence then implies both `u|v` and `v|u`, hence equality of their principal ideals. Distinct ideals therefore have zero correlation. For actual primary generators, equality of ideals forces equality of generators (`75–88`). This supplies the exact off-diagonal cancellation used in the finite energy.

At equal generators the zero correlation is `sum_x chi(x)*conj(chi(x))` (`49–73`). Its norm is at most the residue cardinality, equal to the ideal norm. Dividing by the product of the two square roots cancels this norm; the resulting energy norm is at most `sum |c_i|^2` (`119–155`). This argument needs no principal-character exception or claim that the equal-row correlation is exactly the full cardinality.

The seed factor is a separate count (`97–117`, `157–190`). Division of each nonzero ideal by the nonzero seed is injective on seed multiples and puts its norm below `Y/Norm(seed)`. In the nonempty case that ratio is at least one, so the finite ideal-count bound applies. The empty case is handled separately. Consequently the zero-mode energy is at most `128*Bcoef^2*Y/Norm(seed)`.

`SourceSecondZeroEnergy.lean:97–182` does not overlook repeated product columns. A divisor-small-power bound controls the coefficient fiber; squaring its `Y^(epsilon/2)` cost yields `Y^epsilon`. If the support bound is below one, every coefficient vanishes. Otherwise the normalized estimate is obtained with `Y=L*V`, then division by `V`. `profile_second_zero_energy` (`192–239`) retains the actual seed mask and profile bounds. `SecondSourceDiagonal.lean:20–60` specializes this to the actual source and the scalar `Kphys*paperRadialFourier W 0`.

Thus the remainder's diagonal term has one factor `1/Norm(seed)`, `V^epsilon`, the squared coefficient supremum, and the support factor `(1+product(hi)*whi^2)^(1+epsilon)`. It is not the square of a count bound for all pairs.

## 5. Discarded tail and its uniform power budget

`Tail.lean:116–173` restricts a genuinely summable lattice majorant to the actual discarded set. Coefficients are bounded in norm; cutoff weights have norm at most one. For `0<K0<=K`, the support condition `T<=K0*Norm(h)` implies `T<=K*Norm(h)`, while replacing the denominator by `(min(1,K0))^2` enlarges the upper bound. This is the exact uniform-sector adapter.

`SectorLocalization.lean:405–488` obtains `T=Z^(xi/4)` on every nonzero discarded-weight term from the frequency cutoff and the eventual logarithmic threshold. It specializes the coefficient bound to the actual correlation, with cost `Norm(u)*Norm(v)`. `SecondTail.lean:15–86` uses

`K0=exp(-2HN)/Tsec <= Kphys/(Norm(I)*Norm(J))`

from the source support `Norm(I),Norm(J)<=exp(HN)*V` and `V^2/Kphys<=Tsec`. Supported nonzero ideal norms are at least one, so discarding the inverse square-root prefactor costs at most `Kphys`, with no division-by-zero case.

`SupportedTailAggregate.lean:16–72` uses the actual finite coefficient mass squared, including zero coefficients explicitly. In `SourceInputTailUniform.lean:159–227`, the source coefficient mass is at most `Cmass*plainControl*V`, and each supported column norm is at most `exp(HN)*V`. Dividing the aggregate tail by `V` therefore leaves **`V^3`**, since `V^2` comes from coefficient mass and `V^2` from the correlation norm cost.

The inverse kernel denominator is bounded by

`(1+exp(2HN))^2 * Z^(2B)`

when `Tsec<=Z^B`. With `V<=Z^B`, the total growth before decay is `Z^(5B)`. Choosing an integer `Adec` with

`5B - xi*Adec/4 <= -saving`

gives the declared arbitrary power saving. This choice is possible for every real `saving` because `xi>0`; the finite seminorm set and constant are then chosen before the varying input and Fourier test function. The source itself proves `Tsec>0` from the positive-volume nominal-scale inequality. No separate unmentioned positivity premise is needed.

The final discarded tail has no `1/Norm(seed)` factor. Its theorem is deliberately uniform in arbitrary seed and row ideal and pays a coarser coefficient-mass bound. It must not be combined with the first two terms by factoring a seed divisor out of all three.

## 6. Exceptional normalization and the remaining boundary

`SecondExceptionalFixedQSource.lean:61–153` applies the actual chosen exceptional-block estimate and radical harmonic aggregation. Its local exponent is `2epsilon+delta+2B*theta-2*max(r,0)/3`; aggregation adds another `delta` and keeps the seed divisor. The final volume/radius factor is `V^(1/3)*Kphys^(5/6)*a^(-2/3)`, where `a=product(lo)*wlo^2>0`.

`SecondExceptionalSourceCaps.lean:14–38` pays the five polynomial-size factors: character modulus, row ideal, two source-radius factors, and frequency radius. The fixed multiplicative factor is absorbed by one additional power of `Z`. Thus the specialized cap is `Z^(5B+1)`, and `SecondExceptionalUniformSource.lean:63–97` correctly changes the loss to `2*(5B+1)*theta`. The profile set, order, and leading constant are chosen before `Q`; `K` and the eventual threshold are permitted to depend on the fixed `Q`. This is not a single threshold uniform over all moduli.

The source reading above verifies the normalization and consumption of the exceptional-block estimate. It does not independently validate every analytic input of `chosen_exceptional_block`. Likewise, the nonexceptional route still requires the stated actual child-energy bounds. The lower squarefree block/Fourier window bridge, exact supported correlation/Poisson identity, character-family transport, finite ideal-count and divisor estimates, and Schwartz Fourier foundations retain whatever independent coverage they have; this review does not silently turn them into new proved global premises.

More precisely, I checked `FiniteProfileExceptionalFixedQUniform.lean:45–110`: it calls `FiniteProfileExceptionalFixedQSaved.actual_saved_exceptional_block:43` and then applies the common-weight inequality. For nonnegative `u,v`, the latter uses `max(r-min(u,v),0)+(u+v)/3 >= 2*max(r,0)/3`; splitting at `r<=0` and `min(u,v)>=r` proves it directly. This absorption is valid but does not prove the saved exceptional input. That input is the next substantive exceptional-energy boundary.

In particular, no QRH zero-free assertion was used as an extra assumption in the finite algebra or tail steps inspected here. That local observation is not a global dependency or axiom audit of the provider.

## 7. Frozen version and source manifest

All 39 whole-file source pins in the author manifest were independently recomputed and matched. Those pins are incorporated by the exact author hash above; this does not claim that every declaration in every manifested file was independently re-proved. Additional directly inspected files and their exact byte hashes follow.

| Source under `DirichletL/` | SHA256 |
|---|---|
| `Moments/FirstLocalization.lean` | `1E89CD3A8C5FA142A4E909818263C4187F265DCC7F004B0CA08F0F18F7FAD3BB` |
| `Moments/SecondEnergySplit.lean` | `EC79B9020C33EAB6879FE4825638B571E75BDC274C40B28BA75D1F538BB444AC` |
| `Moments/SourceProfileMassUniform.lean` | `0F0B752B1257831AFDD872C9AA63EA4A3652D18E96B4ECED8616B4D2DAE8576F` |

The additional mass adapter reduces to the actual finite profile coefficient after a finite-index equivalence; its factor `2*128^(card(iota)+2)` is explicit (`SourceProfileMassUniform.lean:13–56`). Its lower ideal-count estimate remains a named arithmetic input. No numerical evaluator, Lean import, build, or source mutation was used for this review.
