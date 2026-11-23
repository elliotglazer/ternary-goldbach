# Independent review: actual retained-window bound

Date: 2026-11-11. **PASS at the author's bounded source/mathematical scope.** No mathematical correction is required. One terminology clarification is recorded below. This is not a build result, axiom-closure result, or proof of the entire QRH provider.

Author: `integration/QRH_RETAINED_WINDOW_ANALYTIC_AUDIT_2026-11-11.md`, SHA256 `994D7AE2F9A63CD1151268E8735D93C7A6E70F505C96714AB442FB77C4FFC58B`. I read the complete report and independently reconstructed the actual-window state, full puncture, clipping and normalization calculations. The source/receipt checker `check_retained_window_source_20261111.py` verified all 32 source pins and 12 supporting-report pins, and recorded two additional inspected source files. Its JSON receipt preserves the full hashes. That check performs byte operations only.

Source paths are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, expected commit `4eaee87548250b2682affda7d05d947c05554bae`. Report paths are relative to `work/qrh-campaign/agents/`. No source edits, builds or analytic numerical evaluations were made.

## 1. Target and quantifiers

`Inversion/InitialRetainedWindow.retained_window_bound:21` concerns the actual finite physical block on the window-filtered source and all its point-source terms. It is not an assumed bound on prospective children. Its exponent is m+15eta+piLoss+eps, where piLoss is an arbitrary positive loss parameter, not the circular constant. The theorem alone provides an upper bound with losses above m; a later parameter choice is needed to absorb them into a larger budget.

The source chooses degree, Btree and Tclip before q. It chooses C and Z0 after a nonzero q but before Z, the actual prime-pool size, finite slots and source, assignment data, all window exponents, both modulation parameters and all bounded source weights. Hence q-dependence of C/Z0 is permitted; dependence on a subsequently chosen source or twist is not. `InitialRetainedPhysical.lean` respects this order when selecting the two reference profiles, obtaining their canonical moments and adding the degrees, pool multipliers and constants.

The window theorem requires eta>=0, eta<=gap/50 and tau<=gap/50, without separately requiring tau>0. It permits zero profiles or zero physical blocks. `InitialRetainedSum:18` later fixes positive eta,tau and supplies the additional eventual power/log conditions. Empty or zero cases do not establish the substantive estimate for nonzero inputs, but are correctly separated from it.

## 2. Actual support, filtering and full puncture

I checked `InitialEnergyCallerSourceMask.lean:18–74`, `InitialEnergyCallerEmpty.lean:19–82`, `InitialCanonicalStateSource.lean:21–88` and the consuming body of `InitialRetainedWindow.lean`.

The coprime-source filter deletes only terms whose actual outer coefficient vanishes. Divisor inclusion and coprimality then imply squarefreeness of the retained child labels. This is a justified source reduction, not an extra assumption that all original labels are admissible.

The nonzero-block branch implies that the fresh column set is nonempty: otherwise exact support replacement makes every physical term zero. Together with the fixed positive-support cutoff and log(bfresh)<=3eta log Z, this proves

`delta=max(0,D-B-v)-(D-B-v)` satisfies `0<=delta<=3eta`.

The proof does not impose this bound on every arbitrary real choice of D,B,v. It derives it where needed from an actual nonzero contribution. The zero branch is bounded immediately.

A retained quotient t is nonzero, with Norm(t)<=Z^(B-theta+2eta). Consequently P=B-theta>=-2eta whenever the quotient support is inhabited. The assigned product j is nonzero and has Norm((j))<=Z^(G+eta), where G is the sum of assigned exponents. The exact ideal equality `(j*primaryGenerator(t))=t*(j)` gives the full norm bound. For

`Q=log_Z Norm((j*primaryGenerator(t)))`,

the source proves Q>=0, Q<=P+G+3eta and `|embedding(j*primaryGenerator(t))|²=Z^Q`. This is the full principal-ideal norm, not a radical norm substituted into an equality. Nonzero ideals and Z>1 justify the logarithm and inverse power identity (`InitialCanonicalState.lean:19–54`).

The nonzero source frequency and divisor imply nonzero child frequency. Actual child norm bounds therefore give nonnegative V=theta+v+2eta and M=theta+H+2eta. Together with N=max(0,D-B-v), these provide the precise finite domains used by canonical moments. The row domain is closed under negation, a requirement used later for the opposite child.

## 3. Independent margin calculation

Write z for the all-slot exponent sum, G for the assigned sum, P=B-theta, and D=r+z-2G. The register identity gives remaining sum z-G>=0. From `Descent/Basic.lean:117–147`, define

`F0=r+z-2G-P+delta`,

`M0=2(r+z-2G)-m-2P+6eta+tau`.

Direct expansion, using Q<=P+G+3eta, yields

`F0-M0-Q-(z-G) >= c1+delta-9eta-tau`,

`4F0-3M0-6(z-G) >= c2+4delta-22eta-3tau`.

For the second inequality, the discarded nonnegative terms are 10G and 2P+4eta; for the first they include 2G. Thus these bounds use the actual G>=0 and P>=-2eta conditions. They do not assume P>=0.

With c1=c2=2gap, eta,tau<=gap/50 and delta>=0, these inequalities supply at least 3gap/2. The radial threshold bounds the actual M by M0, and the actual total label exponent is F0+2eta. Increasing F and decreasing M preserve both margins. Replacing z-G by z-G+eta spends eta in the first margin and 6eta in the second, still leaving at least gap. This is the calculation implemented by `enlarged_initial_margins:63` and `InitialCanonicalStateWindow.actual_window_state:19`.

The cap is also derived: the clipping bound gives N+V<=r+z+7eta, while the first positive canonical margin and Q,z-G+eta>=0 imply M<=N+V. The supplied parent cap therefore controls both. No independent canonical-state hypothesis survives at the final window interface.

## 4. Two normalization costs

`InitialCanonicalEnergy.normalization_change:18` follows by equating the common unnormalized energy. Enlarging the label exponent from V0=theta+v to V0+2eta has two effects. Transporting its normalized energy back to F=N+V0 multiplies by Z^(2eta); the available upper bound already contains the larger exponent F+2eta+eps. The result is therefore `A Z^(F+eps+4eta)`. The row/weight restriction is valid because the sums have nonnegative weights and squared norms. There is no lost factor of Z^(2eta).

Terminology clarification to author section 4: `CanonicalRankMoments:19` defines a uniformly quantified **bound predicate** on the actual `normalizedColumnEnergy`; it is not that energy's defining declaration. Its body explicitly quantifies all allowed twists, punctures, real widths, subslots, finite label sets and real log twists. This wording does not change the report's formulas or intended scope, and the author confirmed it.

The physical prefactor is m-2D+B-theta. With R=B-theta+2eta and F=D-B+theta+delta, expansion gives

`prefactor+3eta+F+R+piLoss+(F+e) = m+5eta+2delta+piLoss+e`.

The two F terms come respectively from undoing the column normalization and from its energy bound. Delta<=3eta gives the 11eta cost; putting e=eps+4eta gives exactly 15eta. I checked both the algebra in `InitialEnergyCallerClipping:30–41` and its actual substitution in `InitialRetainedPhysical.lean`. The common energy bound enters linearly, not squared.

## 5. Source multiplicities and integral interface

I checked the immediate bodies in `InitialEnergyCallerSupport.lean`, `InitialEnergyCallerAssignedCanonical.lean`, `InitialEnergyCallerMass.lean`, `InitialEnergyCallerIntegral.lean` and `InitialEnergyCallerPhysical.lean`.

The sector source maps injectively to its arithmetic tuple, but the child projection need not be injective. The proof pays its divisor-count fiber weights explicitly. Finite Cauchy bounds the signed pair by square roots of the two weighted energies. Opposite-child transport uses the sign-closed row set; it is not a silent deletion of the negative frequency. When both energies have upper bound E>=0, their square roots multiply to E, explaining the linear moment constant.

Quotient mass is paid with epsilon=piLoss/(U+1). Since R<=U and U>=0, R epsilon<=piLoss; this also works for negative R. The normalized mass estimate is multiplied back by positive Z^R, so there is no missing quotient-volume factor. Subset and unit/ray expansions are finite and their constants are fixed before the source. The deeper arithmetic fiber and divisor-mass estimates remain inputs, as the author states.

The actual integral comparison has a weighted-integrable family-density majorant before applying the norm-of-integral bound. The physical identity uses the common-measure formula with its supplied profile identity and integrability, followed by the uniform weighted L1 estimate. This is a coherent consuming interface, not a new proof here of all common-measure construction or Fourier-decay theorems.

## 6. Rank and finite-window boundaries

The immediate rank successor at `Descent/CanonicalRankExistenceSuccessor.lean:15` selects four reference profiles before applying the rank-n induction hypothesis to each. Their estimates apply to all real twists and retained children; the rank-(n+1) output does not assume its own retained-window conclusion. The displayed source caps, normalization and successor losses agree with the author report. I did not independently redo the deeper short-energy and two-pass analyses; their pinned prior reports remain bounded inputs.

Finally `InitialRetainedSum.lean:18` fixes [1/4,1] windows, obtains eventual Z^eta>=4 and the Tclip condition, and pays the finite retained-window count with Z^loss. The physical cutoff T is chosen after these constants. The weight includes the actual cutoff product, bounded by one. Equality in the radial threshold is included. This proves a finite-window sum estimate; the previously reviewed Poisson/summability and zero-mode steps remain separate.

No source or mathematical defect was found in this join. Remaining foundations include the actual child-fiber bound, divisor-mass theorem, exact row identities, canonical clipping, common-measure construction, and deeper rank/short/two-pass estimates. Successful elaboration and permissible transitive axioms remain independent requirements. No new premise or final-target relaxation is proposed.
