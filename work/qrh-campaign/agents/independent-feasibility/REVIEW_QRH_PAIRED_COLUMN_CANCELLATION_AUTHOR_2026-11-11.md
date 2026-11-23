# Independent review: paired-column cancellation

2026-11-11. **PASS at the bounded source/paper level, with the lower inputs retained below. No correction requested.** This is not a build, axiom audit, validation of the global QRH provider, or proof of the selected Goldbach theorem.

The reviewed author artifact is `work/qrh-blueprint/QRH_PAIRED_COLUMN_CANCELLATION_AUTHOR_2026-11-11.md`, SHA256 **A390EBEBDEB7F8689350211306CE9AB90E3C5CA24219427BE3513947F4792BFE**. Its bytes were preserved. The target is `CenteredMomentFiniteProfileExceptionalCommon.actual_common_better_side`, `Moments/FiniteProfileExceptionalCommonSymmetry.lean:22`. Below, M means `work/openai-math/lean/OAI/NumberTheory/DirichletL/Moments/`.

I independently read the target and the cancellation, finite-profile, allocation, shell, and common-source bodies identified below. All 32 source hashes in the author's evidence table match the current raw file bytes. All four context-artifact hashes also match; that check does not independently review the arguments in those context artifacts. In addition, I inspected `M/ExceptionalAsymmetricSource.lean:64–93`, SHA256 **795AD100BB5B4048DD8CD4350A337FF0480CB020B90EBD05E5A0B9EED0662EE9**, for the raw-reduction cap identity consumed by the finite-profile path.

## 1. Exact claim and quantifiers

The author accurately describes the actual target. For a fixed finite slot carrier, fixed positive lower radial support endpoint, fixed upper endpoint and slot windows, positive epsilon/delta/theta, and nonnegative conductor/divisor exponents, the theorem first chooses a degree J and finite seminorm set S containing (0,0). For each nonzero Q it then chooses K>0 and an eventual Z threshold. Source data, radial profiles, supported C and D, nonzero R, common seed, real lower-scale exponents, rows, and divisor sets follow these choices.

In particular:

* The profiles are genuinely variable after S is chosen. The finite-profile argument is not replaced by the older fixed-`Tests` estimate.
* All four scale lower bounds on each source remain premises. Both sources need the fixed slot windows in the symmetric conclusion.
* The two actual inducing-row premises and both expanded conductor bounds remain premises. There is no free declaration that an arbitrary row has the required inducing character.
* Only divisors with nonzero Mobius coefficient require the stated norm bound. The source handles the others by exact vanishing.
* The real lower-scale exponents may be negative. The proof caps the saving where required; it does not add their nonnegativity.
* The result is eventual in Z. Neither this review nor the author supplies an effective numerical threshold or a statement uniform in an unbounded slot dimension.

Writing c=Norm(C), d=Norm(D), u=max(rLeft-log_Z(c),0), and v=max(rRight-log_Z(d),0), the final exponent is `2*epsilon+delta-max(u,v)`. The actual nonnegative profile mass, the two frozen-profile factors, `(c*d)^theta`, and `1/(c*d)` are retained. Empty row sets do not create a positivity assumption on their cardinality.

## 2. Uniform coefficient and equal-product cancellation

The potentially delicate coefficient bound is valid for the reason stated in the report. `M/Counting.lean:82–96` uses an approximation `|S(X)-X*a|<=E` and absolute bound `|S(X)|<=C*X` **for every X>0**. If |a|>C, choosing X=(E+1)/(|a|-C) contradicts the triangle inequality. E is fixed while X varies. Thus no E is added to the resulting bound on |a|. The scalar negative control correctly demonstrates that four selected scales, or a single scale, would not suffice.

`M/HeckeVolume.lean` supplies the relevant uniform-in-X approximation rather than merely a limiting heuristic. I inspected the primary/ideal conversion, finite masking expansion, fixed period, and bounded-character transfer, including `fixedInducingRow_controlled` and `actual_induced_volume`. The fixed complex density may depend on the inducing data but not on X; positivity of that density is not used. Every mask divisor is nonzero and its rescaled X remains positive. The row-character and primary-representative foundations themselves remain lower inputs.

`M/Lattice.lean:15–98` separates the zero mode only after establishing the required summability and bounds the nonzero modes through the actual radial transform and `pvControl`. The substitution by the squared period norm is positive. This is an application of the retained Poisson/lattice estimates, not a new proof of those estimates.

In `M/HeckeTwist.lean` the positive-support twist gives a main term X^(1+it)*a. The equal products X1*X2=Y1*Y2 make the two leading products equal with the same complex phase. Both profiles use the same t within that rectangle. The expansion in `M/Basic.lean:180–199` bounds one actual factor directly and the other leading factor by its coefficient bound. It therefore gives

    error <= E*C*(X1+X2+Y1+Y2) <= 4*E*C*T/L,

without a spurious E1*E2 contribution. All four scales are at least L>0, so T>0 and normalization by sqrt(T) is legitimate (`Basic.lean:243–255`). Different twists between the two later columns cause no problem: the cancellation is proved separately inside each column.

## 3. Finite profile control and small extracted scales

I read `FiniteProfileExceptionalControl`, `Volume`, `Unit`, `Normalize`, `Rectangle`, `Row`, and `Capped`. The fixed positive-support log maps and the frequency-twist derivative formula produce a finite set of source seminorms and a polynomial height factor before the profile is supplied. The finite-set enlargement includes (0,0), which both bounds pointwise norm and ensures that zero control forces a zero profile. The normalization argument explicitly includes this zero case. Homogeneity restores exactly the product of the two controls.

The divisor-count application uses epsilon/(B+1), retaining B>=0. Its exponent is at most epsilon, including B=0. Character replacement in `FiniteProfileExceptionalRow.lean:35–41` preserves both the actual row equality and induction while importing the controlled conductor; the original unbounded witness is not used as though it already met that bound.

`FiniteProfileExceptionalCapped` treats L>=1 by cancellation and 0<L<1 by the absolute estimate. This produces max(1,L) in the denominator. There is no attempt to use the former theorem outside its domain. The proof still consumes the underlying absolute ideal-sum and fixed-log-map control results.

## 4. Allocation denominator and one-sided shell bound

I inspected `FiniteProfileExceptionalSlots`, `Allocated`, `Amplitude`, `Pair`, and `CommonAsymmetric`, together with the shell sources. If d0 is the actual reduction factor, residual volume is V/d0 and its lower-scale cap is max(1,Z^r/d0). Combining the residual bound with the allocated-energy identity gives

    (F^2/d0) * (H*Lslot)^2 * (V/d0) / cap^2
      = (H*F*Lslot)^2 * V/(d0^2*cap^2).

Taking a nonnegative square root yields **d0**, not sqrt(d0), in the denominator. The slot product comparison then restores the original slot control. This check is conditional on the exact source-to-residual energy and volume identities used there; those identities are not inferred from a choice of majorant.

For two columns the right cap alone may be dropped because it is at least one. With x and y the two log reductions, the remaining weight is `Z^(-x-y-max(r-x,0))`. The source assumption P_i>=1 and the nonzero selected divisors imply the left reduction is at least one. Therefore x>=0 and replacing r by max(r,0) preserves that weight. This replacement would be false without the reduction hypothesis.

`ActiveDivisorShell.lean:45` supplies, on the **right active allocation**, `n<=y+A`, where n is the log divisor norm and A is its window allowance. For every real r and x,

    -x-max(r-x,0) = -max(r,x) <= -r.

Consequently the full exponent is at most A-r-n. Only the right active boundary is needed for this inequality. It yields a factor 1/Norm(L) while preserving the left saving. No Mobius sign cancellation is being claimed.

In a half-open shell U<=Norm(L)<2U, U>=1, the two allocation counts cost at most a constant times (2U)^(2e). The at-most-256U ideal count cancels the inverse U. The finite-union argument makes this uniform over subsets of the fixed slot carrier, not over arbitrary slot dimension. Choosing e=deltaShell/[2*(Lbound+1)] pays at most Z^deltaShell. `UniformDivisorShell.lean:40–71` bounds the right allowance by the fixed sum of log windows and evaluates its Z-power as a fixed exponential constant.

`WholeDivisorShell.lean:34–182` partitions precisely the live divisor set using floor(log_2 Norm(L)). Nonzero Mobius coefficient implies squarefree and nonzero, hence norm at least one. The shell count is logarithmic and is paid by a second positive subpower budget. `ExceptionalWholeSource.whole_weight_bound` uses delta/2 for each payment. Its threshold is independent of the varying divisor set and r. Unit divisors, Lbound=0, empty live sets, and negative r do not require an omitted case.

The finite-profile consumer uses this profile-free weight lemma. It does not substitute the older `Tests`-dependent whole-source estimate. `ExceptionalMaskedSource.lean:27–82` passes from the actual finite masked expansion to the allocation estimate by triangle inequalities, with the nonsquarefree/zero-Mobius cases removed only when their weights vanish.

## 5. Common normalization and the maximum saving

`CommonExceptionalGates.lean:18–57` derives coordinate divisibility, norm bounds, extracted scale lower bounds, the mask-induction equivalence, and the exact expanded conductor. `FiniteProfileExceptionalCommonGates.lean:22–41` supplies all fourteen admissibility fields. No extra coprimality of Q with C or D is introduced.

`CommonExceptionalCost` retains the exact common scalar/volume identity. For a nonzero frozen coefficient, actual support bounds the reduction sufficiently to give

    |commonScalar|*sqrt(commonVolume)
      <= frozenProfile*sqrt(originalVolume)/Norm(C).

The zero-coefficient case is separate. `CommonExceptionalMass` and its finite-profile counterpart multiply this by the slot and profile factors without losing the inverse norm. Each side's common-allocation count uses exponent theta; their product is a constant times `(c*d)^theta`, not `(c*d)^(2*theta)`.

`CommonPairedSource.lean:16–89` defines normalizedColumn using the original volume and applies the actual source normalization identity before its finite-sum triangle inequalities. `FiniteProfileExceptionalCommonSource` combines these bounds with the asymmetric estimate. Finally, `FiniteProfileExceptionalCommonSymmetry.lean:48–77` applies that same uniform theorem twice, once with the data swapped. Its J, S, K, and threshold are unchanged. Selecting the better bound gives max(u,v) with no factor two. It cannot give u+v.

## 6. Verification and remaining cut

The scalar script `work/qrh-blueprint/paired_column_scalar_20261111.py`, SHA256 **0A6A0DB51CCF7C7CEA171558DF2EE57C79E2D7A55EBD0BD551E98540BD47ED15**, was read and replayed without modification. It exited 0: 696 max/shell examples, 96 normalization examples, 54 shell-budget examples, and five negative controls. These finite tests corroborate the displayed algebra; the general implications above were checked separately. They are not analytic evaluations or a substitute for the source hypotheses.

The author correctly retains the following boundaries:

* The actual paper-normalized radial Poisson formula, transformed-lattice summability, uniform `pv_lattice_bound`, and finite Schwartz control of the fixed log maps.
* Ideal-ball, ideal-divisor, and allocation counting estimates; primary representatives; row-character construction and induction transfer; fixed-mask induction equivalence; and the active support boundary.
* The genuine finite source/residual/normalized-column identities, support implications for nonzero frozen coefficients, and slot-product identities.
* The separate fixed-Q row-count and physical-saving arguments. Their hashes were checked here, but their complete mathematical arguments are outside this review.
* Compatible elaboration, full declaration/definition fidelity, and transitive axiom validation. None was run or established here.

No RH or finite-RH assumption was inserted in the inspected implication. This is not a conclusion about the entire import closure, nor does it supply spectral certificates or the missing global-provider validation. The selected Goldbach strategy and its outstanding finite and analytic obligations are unchanged.

Only this new review file was written. No Lean source, old report, author script, spectral data, or frozen strategy was changed. No build, new Lean declaration, analytic evaluator, or production scan was used.
