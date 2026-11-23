# Canonical marked-energy rank induction: bounded mathematical audit

Date: 2026-11-11. This is a static proof-body and mathematical audit of `Descent/CanonicalRankExistence.canonical_marked_energy_exists`, continuing beyond the earlier inverse-energy wrapper review. No local defect was found in the induction, actual child rank inequalities, or constant/normalization joins reconstructed below. The underlying short-energy and two-pass analytic estimates remain explicit boundaries. This report does **not** validate the global QRH provider, certify elaboration, or report a transitive axiom check.

No Lean declarations, builds, numerical evaluations, or source edits were made. Source paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`; the recorded repository baseline is `4eaee87548250b2682affda7d05d947c05554bae`. The byte manifest at the end binds the actual files read. Prior reports remain unchanged.

## 1. Actual conclusion and quantifiers

`Descent/CanonicalRankExistence.lean:32` returns `CanonicalEnergyExists Mcap Fcap c eps (Fcap+1) K W` for nonnegative caps, positive `c,eps`, and a Schwartz profile supported in a compact positive interval. It does not quantify over an abstract energy function.

`CanonicalEnergyExistenceData.lean:13` expands the conclusion in this order:

1. There are an integer degree and `B>=1`.
2. For every nonzero natural `q`, there are `C>0` and `Z0>1`.
3. For every `Z>=Z0`, integer pool bound `D>=B Z^(Fcap+1)`, admissible disjoint marked-prime lists of at most `K` slots, coefficient norms at most one, product-of-slot-caps at most `Z^z`, and a bounded base character factoring through the fixed modulus attached to `q`, the stated canonical rank moments hold.

Thus the degree and pool multiplier precede `q`; the coefficient constant and scale threshold may depend on `q`. There is no single uniform threshold for all `q`, and no assertion that arbitrary choices of cap/margin admit a state.

`CanonicalRankMoments.lean:19` then quantifies over actual base ray twists, nonzero punctures, real exponents `N,V,M,Q>=0`, subslots and admissible ideal labels. Its margins are the two concrete inequalities (`Basic.lean:13`)

\[
 c\le F-M-Q-z,\qquad c\le4F-3M-6z,\qquad F=N+V.
\]

It also requires `||embedding(m)||^2=Z^Q`. Its conclusion is

\[
 \mathcal E(W;Z^N,Z^M)\le C Z^{F+\epsilon}(1+|s|)^{2d}.       \tag{1}
\]

Here `normalizedColumnEnergy` (`Inversion/InitialClippedColumns.lean:199`) is the finite sum of squared actual `finiteCanonicalMarkedRow` values, with each value multiplied by `Z^(-F/2)`. The nonnegative ideal weight is
`secondLabelWeight K I = card(idealDivisors I)^(9+4K)` (`SecondNormalizedEnergy.lean:35`). The row is `fixedChildRow` with the actual `primeMark` and the scaled smoothing (`Canonical.lean:16`). Therefore (1) bounds the **normalized** energy; before normalization the power is `Z^(2F+epsilon)`, not `Z^(F+epsilon)`.

The energy need not be strictly positive: empty labels, zero coefficients or a zero profile are allowed. This is an upper-bound theorem for every admissible state, not a positive lower bound or a universal existence theorem for states.

## 2. The finite rank schedule is not circular

Write `d0` for the source's positive `cutoff`, and `eta>0` for its scale loss. `CanonicalRankExistenceData.lean:27–33` defines

\[
 R_n=\tfrac34(n-1)d_0,\quad F_n=L-15n\eta,\quad
 c_n=c_*/2+7n\eta,\quad e_n=62n\eta.                         \tag{2}
\]

Rank zero permits `M<=-3d0/4` but also requires `M>=0`. Its proof is correctly vacuous (`:51`, `CanonicalRankMonotone.lean:17`); it does not silently prove a nonzero-energy bound from zero. The successor must do the substantive work of reducing every retained child into this smaller class.

`CanonicalRankExistenceInduction.lean:23` inducts on `n` with a hypothesis for **every** compact positive-support Schwartz profile. At the successor, `actual_complete_normalized_rank_step` supplies four new profiles before it quantifies over the child degree, `q`, or the state. The four induction hypotheses are therefore legitimate. Their degrees are combined first, and only then supplied to the complete-step theorem. This ordering avoids a profile/degree fixed-point assumption.

`CanonicalRankExistenceSuccessor.lean:15` takes the sum of four child degrees, enlarges the finite pool multiplier to `1+hi+B11+B12+B21+B22`, combines nonnegative constants by their sum, and combines scale thresholds by a sum. All thresholds are already greater than one, so that sum dominates each. It applies child estimates at the same `q,Z,D`, then restricts to subslots. No child hypothesis has rank `n+1`.

For the final prescribed caps, `RecursionParameters.lean` first chooses `csmall=min(c,1)` and `d0=csmall/1000` through `CanonicalRankDepthParameters.lean:19`. It chooses

\[
 n=\left\lceil\frac{4M_{cap}}{3d_0}\right\rceil_+ +1,
\]

and only then chooses `eta` as a positive minimum involving `d0/32`, `csmall/200000`, `csmall/(28(n+1))`, `1/(30(n+1))`, and `eps/(800(n+1))`, as well as `1`. Hence depth does not depend on an `eta` that itself depends on depth. The explicit inequalities ensure

\[
 M_{cap}\le R_n,\quad F_{cap}\le F_n\ (L=F_{cap}+1),\quad
 c_*/2\le c_n\le c,\quad 0\le e_n\le\epsilon/4<\epsilon.
\]

The final restriction and loss enlargement are in `CanonicalEnergyExistenceData.lean:28`; their inequality directions match the definitions.

## 3. Actual long-bin progress

The child reduction is not an assumed abstract well-founded relation. `CanonicalLongGeometry.lean:19` starts with a nonempty actual progressing cube bin. Set

\[
 \ell=\log_Z(\mathrm{normLogScale}(j)),\qquad r=N-3\ell.
\]

The bin's actual cube ideal satisfies `Z^ell<=Norm(cube)<=exp(1)Z^ell`. Its active condition gives `Norm(cube)^3<=b Z^N`, and `b<=Z^eta` implies `3ell<=N+eta`. Thus `r>=-eta`, with the needed upper caps inherited from `N+V<=L`.

Progress means the cube norm exceeds the short threshold `Z^(d0-V)`. Combining this with the upper bin norm gives
`d0-ell-V<=1/log Z<=eta` (`CanonicalLongSource.lean:81`). Consequently

\[
 \ell+V\ge d_0-\eta\ge d_0/2,\qquad
 \eta\le(d_0/2)/16.                                         \tag{3}
\]

`CanonicalLiveBinRank.lean:16` therefore applies the child theorem with its smaller short cutoff `d0/2`. Empty bins need no child bounds; their contributions are handled by the finite aggregation. The short branch is separately estimated, not declared absent. In particular, `CanonicalCompleteState.lean` treats `d0<=V` by the actual identity that the short sum vanishes when its norm threshold is at most one; otherwise it invokes the short-energy theorem.

## 4. The substantive child inequality, from actual norms

Let `g,theta` be the second dyadic exponents of the common source and its divisor, and let `j` be the cube-label exponent. Use `A,t>=0` for the other source exponents. Define

\[
 d=\ell+A+t+g-\theta+V,
\quad M'=M-2d-2\ell+j+\eta,
\quad F'=F-d-2\ell+j+\delta.                                \tag{4}
\]

These are exactly `decrease`, `childM`, `childF` in `Basic.lean:44–50`. Their connection to the actual cell is checked below; (4) is not merely a favorable invented recurrence.

First, divisor inclusion and the actual dyadic norm bounds imply

\[
 Z^{\theta-\eta}\le\mathrm{Norm}(E)\le\mathrm{Norm}(G)
 \le Z^{g+\eta},\qquad g-\theta\ge-2\eta.
\]

This is `SecondTripleBounds.actual_second_common_center:16`. Second, the actual cube-label bound gives `Norm(jLabel)<=Z^(2ell+2eta)`, while the label cell has lower bound `Z^(j-eta)`; hence `j<=2ell+3eta` (`:30`). The combinatorial cube-label norm theorem is explicitly retained as a deeper input below.

Substitution into (4), using `A,t>=0`, yields

\[
 M-M'\ge2(\ell+V)-8\eta.
\]

For any positive short cutoff `s` with `ell+V>=s` and `eta<=s/16`, the right side is at least `3s/2`. By (3), `s=d0/2` is available. Therefore

\[
 M'\le M-3d_0/4.                                           \tag{5}
\]

This is the actual strict progress required by (2), as proved through `Basic.child_row_decrease:85`, `SecondAdmissible.actual_second_row_decrease:94`, `ActualChildStateSupport.actual_cell_row_decrease`, and `FirstLabelCellStepChildren.source_row_decrease:61`.

### Why this is the actual child radius

`SecondCorrelatedCutoff.lean` defines the retained correlated radius as

\[
 \|d_{first}\|^2\left(\frac{\mathrm{Norm}(E)}{\mathrm{Norm}(G)}\right)^2
 L_{col}^2\frac{H}{Y}.
\]

In `SecondCutoffScale.lean`, the bounds for those five factors have exponents
`deltaFirst+eta`, `2(theta-g+2eta)`, `2(r-A-B-t+4eta)`, `tau`, and
`-(firstPhysicalHeight+12eta+tau)`. Their sum is

\[
 2(r-A-B-t-g)-H_{phys}+\delta_{first}+2\theta+\eta=M',
\]

because `Hphys=2r-2B-M+4ell+2V+deltaFirst-j` (`PhysicalExponents.lean`). The `tau` factors cancel and the remaining loss is exactly one `eta`. `ActualChildStateSupport.actual_cell_correlated_row_support` transports membership from this retained radius to the actual child frequency ball; `ActualChildStateRadius` then identifies its exponent with `childM`. For a live cell, a nonzero Eisenstein frequency has squared norm at least one, so `M'>=0`. Combined with (5), this is a genuine finite-depth restriction on live retained cells.

This support argument does not make discarded frequencies disappear: the separate second-pass tail estimates must bound them. That analytic obligation is retained in §8.

## 5. Total cap and the two margins

The actual label exponent is `B+theta+v+j+4eta`. The actual column exponent is clipped at zero, so in (4)

\[
 \delta=\max(0,N_{formal})-N_{formal}+4\eta.
\]

`SecondCellParameters.second_cell_clipping_width` proves the clipping part is at most `6eta` from the actual joint support bound and `b<=Z^(6eta)`. Thus `0<=delta<=10eta`. The same norm inequalities used for (5) give `F'-F<=5eta+delta<=15eta`, as in `ActualChildState.lean:92`. The extra `4eta` label padding is included; using the unrelated `11eta` bound from `Basic.childF_upper` would be insufficient here.

The puncture is the actual inherited **radical** puncture, not the old puncture with its size assumed unchanged. `SecondSharpPuncture.lean` proves

\[
 Q'\le Q+\ell+t+g-\theta+4\eta\le Q+d+4\eta.
\]

Its proof retains the old radical norm, the nonzero quotient norm, the cube `q0` norm and the residual source/divisor norm. Each comes from the corresponding actual product of ideals. Nonzero conditions justify the logarithm defining `Q'`.

The exact identities in `Basic.lean:51` now imply

\[
 F'-M'-Q'-z\ge c+\delta-5\eta,\qquad
 4F'-3M'-6z\ge c+4\delta-7\eta.
\]

Since `delta>=0`, both imply the child's `CanonicalMargins` with `c-7eta`. This reconstructs the margin transport, including the coefficient of `Q'`. Actual labels are transported as supported ideals, then filtered by `Squarefree` before using the rank hypothesis (`CanonicalChildSupport.lean`, `CanonicalRankMoments.lean:34`). Base ray twists are closed under the two child twists. None of these steps asks the rank hypothesis to cover a larger row cap than it supplies.

Equations (5), `F'<=F+15eta`, and `c'>=c-7eta` fit (2) exactly:

\[
 R_{n+1}-3d_0/4=R_n,\quad F_{n+1}+15\eta=F_n,
 \quad c_{n+1}-7\eta=c_n.
\]

## 6. The energy step and its budget

`CanonicalCompleteRankNormalized.lean:16` is the four-child implication actually used. Its output is

\[
 \mathcal E\le C_s(1+|t|)^{d_s}Z^{F-c_*/256}
 +C_b(1+A)(1+|t|)^{d_l}
 Z^{F+lossFinal+2L\epsilon_1+\epsilon}.                       \tag{6}
\]

Its proof connects to the actual completed-row sum using `outside_complete_normalized_energy` (`CanonicalCompleteNormalized.lean`). This identity preserves the `Z^-F` normalization and reindexes the primary/ideal generator by units over the full nonzero frequency ball. It does not assert pointwise equality of rows at two different generators without that reindexing.

The complete-state proof splits short and long contributions and aggregates actual nonempty cube bins (`CanonicalCompleteState.lean:16`, `CanonicalLongTotal.lean:14`). The latter consumes the logarithmic bin count with two allocated half-losses. `CanonicalCompleteChildren.lean:16` applies the two-pass estimate on each long bin and converts the four child bounds. Thus (6) is not proved by rank decrease alone: it also uses the analytic short/two-pass estimates listed in §8.

At rank `n+1`, the exact choices are

\[
 \epsilon_1=\frac{\eta}{10L+32},\quad
 e_m=e_d=\frac{2\eta}{20(3L+16)+30},\quad
 \tau=\epsilon_2=\epsilon=\eta,\quad\pi=8\eta.
\]

In particular `em*(20(3L+16)+30)=pi/4=2eta`; no independent smallness of the unscaled source-mass cost is assumed. The retained contribution is
`48eta+tau+pi+e_n+epsilon2=e_n+58eta`. The source sets `loss=e_n+58eta`, `lossFinal=e_n+60eta`. Because `eta<=1`,

\[
 (2L+16\eta+1)\epsilon_1\le\eta,
 \quad 2L\epsilon_1\le\eta,
 \quad lossFinal+2L\epsilon_1+\epsilon\le e_n+62\eta=e_{n+1}.
\]

The principal/first-pass constraint `3eta+epsilon1*(2L+7eta)<=lossFinal` follows from the same denominator and `e_n>=0`. These are the concrete proofs in `RecursionParameters.lean` and `CanonicalCompleteBudget.lean:10`.

The short term's exponent `F-c*/256` is at most `F+e_(n+1)`. Positivity and `Z>=1` therefore merge both terms with constant `(Cs+Cb)(1+A)` and the maximum of their degrees (`CanonicalCompleteBudget.lean:25`); the final degree is doubled to match the rank predicate. This harmless enlargement does not manufacture an energy saving. The theorem supplies an arbitrarily small positive loss after choosing sufficiently small `eta` for the finite number of ranks.

The scalar physical-prefactor identity was also checked in `PhysicalExponents.lean`: `firstKappa+secondLambda+secondCount+2*(formalColumn+formalLabel)=r+3ell+V`. With clipping at most `6eta`, the displayed `9/2+18+11/2` losses sum to `28eta`, giving `40eta` after clipping. This verifies the algebra of that lower-level budget, but does not by itself prove that the underlying analytic estimates have those prefactors.

## 7. Circularity and scope findings

The inspected successor is triangular: choose four profiles; use rank `n` for them; establish actual child admissibility and strict row decrease; apply the complete-step estimate; enlarge to rank `n+1`. The positive cutoff is chosen before the depth, and depth before `eta`. Constants and degrees are combined in the correct direction. Empty bins and the vacuous negative-row base case are used only where their definitions justify them.

No desired global beta bound or global QRH theorem is passed as a hypothesis in this inspected chain. This is a local dependency observation, not a transitive circularity or axiom certificate for all imported analytic estimates. The finite cutoff/reference construction is supplied by `actual_rank_reference_cutoffs` and the eventual power gates by `actual_rank_reference_thresholds` (`CanonicalRankExistence.lean:11,17`); their existence is not obtained from the rank conclusion.

The main advance beyond the earlier wrapper review is the derivation of actual child radius decrease, total-cap inflation, and inherited-puncture margins from concrete norm bounds, together with the complete rank/energy loss arithmetic. It does not close the analytic energy theorem below the complete-step interface.

## 8. Exact remaining cut

| Remaining input | Source boundary | Unvalidated part in this round |
|---|---|---|
| Short completed-energy bound | `CanonicalShortFinite.lean:14` calls `InverseShortCanonicalNormalization.canonical_short_normalized_energy_uniform_degree` | Underlying short analytic estimate and its `c*/256` saving. The finite-pool/mark/normalization adapter was read. |
| Long two-pass estimate | `CanonicalLongHeightBin.lean:16` calls `actual_marked_bin_uniform_test` and `reopening_twisted_moment_squared` | Full Fourier/Poisson/Cauchy/two-pass estimate, retained-source mass and derivative bounds, and discarded-tail estimates. The height and rank application was read. |
| Actual cutoff and child support | `SecondCorrelatedCutoff.full_second_correlated_tail`, plus actual second-row transport used in `ActualChildStateSupport` | Algebraic correlated-radius scaling checked; the complete analytic tail and row-transformation identities below this interface remain to audit. |
| Cube label combinatorics | `Eisenstein/SeedDefects.lean:647`, `cube_label_norm_bounds` | The source supplies the actual norm inequality used in §4; its full primewise combinatorial proof is outside this round. |
| Cell/support and puncture foundations | `SecondCellParameters`, `SecondSharpPuncture` and their imported support/ideal identities | The displayed norm products, exponents and margin algebra were read; deeper ideal factorization, source construction and all transport identities are not fully re-proved here. |
| Exact completed short/long split and counting | `CanonicalLongFinite.actual_complete_finite_split`, `actual_cube_bin_count`, and completion identities | The aggregation and allocated losses were read; the full expansion and counting foundation remain a separate audit. |
| References and eventual thresholds | `Inversion/CanonicalReferenceThreshold` and the cutoff existence called at `CanonicalRankExistence:11` | Treated as independent analytic cutoff/eventual-growth inputs, not inferred from the rank result. |

These inputs have source proof bodies; “remaining” means not validated by this bounded mathematical review, not that the files contain postulated theorems. No claim about successful compilation or the entire global-provider proof follows from their presence.

## 9. Source byte manifest

Files in this manifest bind inspected bodies or named boundary interfaces. Inclusion does not claim that every declaration in a file was audited.

| File | SHA256 |
|---|---|
| Descent/CanonicalRankExistence.lean | `7B299DCB2DE3C671BC9C84E5E5D2F3D0CF2D3192D30CADF1A2041867EFD21427` |
| Descent/CanonicalRankExistenceInduction.lean | `EAF8639E1BA4D9E8A89DC4FD6F1FB9471CFF5F7BDE7D646D255D0EFCAE374934` |
| Descent/CanonicalRankExistenceSuccessor.lean | `D2843F8CBBD084E83E1682DD8FB9160F593F807C8C461E37BF54AA6A4D736745` |
| Descent/CanonicalRankExistenceData.lean | `D285834EBA420F8FFB3E696972C2680BEB23A7A97383FFC2EA2108372054F3CC` |
| Descent/CanonicalRankDepthParameters.lean | `BB38E5DEDD665427C01B2225536493DFAA0BD775078BDEAAF76E9E828608E8FA` |
| Descent/CanonicalEnergyExistenceData.lean | `2E53E4682091E687689E7014833AD33F6983A888B92E2CE39CC5B337FFFA26E3` |
| Descent/CanonicalRankMoments.lean | `7311954BBB54718ACEC29DC50699F7D447AA5B27A9C660E1AE88B4EFD415F964` |
| Descent/CanonicalRankMonotone.lean | `54BE93ED5C5E785B87DCC49D33E942E6ACB1A766BF248A2575BC859FB3F41C55` |
| Descent/CanonicalRankFamilyGates.lean | `117BF4AC0B499BD5D61F1F09D5FFBBCF16BF063EE0D2154C4C20E38BDFC3C813` |
| Descent/CanonicalRankPuncture.lean | `88CEB16E246C96376F153120FB4D57B6C460845D1709758334090235F1F03152` |
| Descent/CanonicalCompleteRankNormalized.lean | `72AB6C4781B92B236F40893B69C6D2FEC4B1BF6DD7A2731950FE1BAE1F61CB6E` |
| Descent/CanonicalCompleteRank.lean | `ECFDC826302CAE631A60B05E36EC845BEF79B63B7D0B4F812D131073D99B4389` |
| Descent/CanonicalCompleteNormalized.lean | `38844550D49193E746FA5B13EC5D986B8907EE01ED905EC8FC1A9D0AD7BC39D9` |
| Descent/CanonicalCompleteChildren.lean | `59C337130290EA4DF1BA59DF5FD372D6CB5E0CEBCA3D19891005B5E499B9ACBB` |
| Descent/CanonicalCompleteState.lean | `F40A5D850F6EBF8A7C41AFCE37E543B4632B64964FED7EBFAF91CB9241D929DB` |
| Descent/CanonicalCompleteBudget.lean | `461CDEB2A19F95627E7CCBDD029A404A895F4D8DEC49A9C5FDB45C64275C50BF` |
| Descent/CanonicalLiveBinRank.lean | `85E700FA983999972342803BA459FE29E7B0706C6F0A741582AEF5DBDBB2891F` |
| Descent/CanonicalLongGeometry.lean | `D986FB9CAEB6ECC0ECC54E007D8CD3893922BB0A2522ACEAB91D2294D2A54CFA` |
| Descent/CanonicalLongSource.lean | `3A0E435DCFDB28AF2051CA897227DA83401816B114D149FA70C5CB87BAB1475B` |
| Descent/CanonicalLongTotal.lean | `3195F9E7D9E43E913B9C01927F341CDAB90AB38611CDE3F63A6F5A9EFFE2409F` |
| Descent/CanonicalLongFinite.lean | `BA25029C6E8D9C446E8AC08F0C160D4CC6F097C715C491BDDDD002092B3FC66E` |
| Descent/CanonicalLongHeightBin.lean | `A9B75C9A183BABFBF48D41EA84F2A72925FF1F3287D87D30CD9C6A4E1AA561C7` |
| Descent/CanonicalLongCount.lean | `12FD1000823D6D969BF13CFF0A8C63234F12AA5849DA59F2E9DB2D3EE697192D` |
| Descent/CanonicalShortFinite.lean | `690078847B6F630C3E2C1FCF2B37BD64608C9AA59683516F12647C6BC1BB9FFD` |
| Descent/CanonicalChildSupport.lean | `20F71569AA1FE27C4D691B51765D2B6AF4EBDB5B0B0BECFB1BB28BCA998B08BC` |
| Descent/FirstCanonicalChildren.lean | `BB257583B32E8DF63270DB0CFB1997AD598A7D84B4AA1C6EECFA4BC2570BD00A` |
| Descent/FirstLabelCellStepChildren.lean | `8110CAA288516F6C454477292C87357472AD50A03394CCFFF3F01F05E012CE4D` |
| Descent/GlobalRetainedGatesRank.lean | `A851EC142902DF2B0E327E432BEB772D83F0C8F20CFE6F08425579E5628FF5D3` |
| Descent/ActualChildState.lean | `3103F38BE43A6467F35147F9CC83156370D52928F9B3F0DEA342E1782F6CDC46` |
| Descent/ActualChildStateRadius.lean | `367B354C5803FBE62615635B39DFE1B524FD65812C50F564C863D8AEBF08FE8A` |
| Descent/ActualChildStateSupport.lean | `3C86C5A6A382E51A654A2689A33F21E98EDBA0F958581723AF6834F8C095B51B` |
| Descent/ActualChildStateDepth.lean | `FF687505F78640813D643E10D28DD620035AF1AE2622537F3CA9CEBBA274DD18` |
| Descent/ActualDepthBudget.lean | `FC1877CB17D74AD4308C19E48B3EAEB94FFFD7BA82AEFB93DE475CCAAC089653` |
| Descent/Basic.lean | `DFA8CB13C1C5D34E1AA629D46719B33E93194CF04380DBF65B00E064D33DFFBC` |
| Descent/SecondTripleBounds.lean | `170F93B84EAD643BD56E5B8D78421E4903EAD2160DF446AA1EE7B47C2ABE64B9` |
| Descent/SecondAdmissible.lean | `3B2F6F5032E4E6F270901F22397B352FF0CCDB11E79EBECFE0FA798C88776A98` |
| Descent/SecondSharpPuncture.lean | `F0EE55623705FAFB04DB0E22EA028152C2277CD4A74C4374611013E6FB9422FC` |
| Descent/SecondCutoffScale.lean | `1DCD4B002E78321BDBEE225577610996A6AD3BFB7C3A927FE6C7D1B679F6EE39` |
| Descent/SecondCorrelatedCutoff.lean | `BBA86B2CCF9D2832C3BDE0C36466DFFA5961273D5A8E29D39EC272F68FD2878E` |
| Descent/SecondCellParameters.lean | `F9F442C2DFBF9411AD01F038FC56CD93EF1EBB3FAACC71C9A31D32063CC25AEC` |
| Descent/PhysicalExponents.lean | `A872431FB5FA7D144735553D9988AA797E780F4679A73A53FB3491E341ABF509` |
| Descent/RecursionParameters.lean | `D2046807FF141FD4CEEA99987376A80427690201865E956FE0F7E6E56C546C5E` |
| Descent/Canonical.lean | `E6ECEECC674D0D979E656D94A5AABF549DADBFA5DA00F61FFC871A8BD32FD433` |
| Descent/SecondNormalizedEnergy.lean | `CCC23556F52E7CCBF521A54B022BCE64ED645F92317913CB2F47401144CE5F0C` |
| Inversion/InitialClippedColumns.lean | `19424723657E5E55AC5648A7ED4922A83AF977AD9448C9F599E4B9F5DAFF2B94` |
| Inversion/CanonicalReferenceThreshold.lean | `6EC6B1F8CF53AB89CDB9A5419FF0DEBD57BB9F3D3684A2AC42CCC4AAB62C832E` |
| Inversion/ReflectedShortNormalizedUniformDegree.lean | `C5078507182DBBAFFD26D14AB4414AFA2CA4B06253709BE773221757BF2E7609` |
| Descent/CanonicalLongUniformTestBin.lean | `2FA3CEFB0FFFF170E3133F258B398629F24758ECA90B21697D82138A03C7BBCE` |
| Descent/CanonicalReopeningHeight.lean | `DF4C4E6307A018D01077885372032FFE4CFE0621420ECD56583B46DD536EACFA` |
| Eisenstein/SeedDefects.lean | `A60BCC07E52B038B206FA3C2C16ABDC35F149F71B9276D131A2B6BECA9363F10` |
