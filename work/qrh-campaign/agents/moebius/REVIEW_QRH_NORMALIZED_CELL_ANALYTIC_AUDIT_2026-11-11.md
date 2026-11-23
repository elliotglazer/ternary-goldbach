# Independent review: normalized nonfloor cell

2026-11-11. Verdict: **PASS for the bounded mathematical/source implication reviewed here**, not for the full seven-eighths theorem. Research/source review only: no Lean build, new declaration, analytic evaluator, or spectral computation.

Reviewed author: `../integration/QRH_NORMALIZED_CELL_ANALYTIC_AUDIT_2026-11-11.md`, final SHA256 `AD0255D4D979265BF9D61B6D18C6CF2EB18AECBCA17467EC580C49287F26F0FE`. All 31 source hashes in its table were independently recomputed and matched. I requested one correction to its initial version `A25C6FDF...`: the high branch cutoff is 3/2, not 1. The final author text fixes this; the source already used 3/2. No remaining correction is requested at this scope.

Source root: `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, commit `4eaee87548250b2682affda7d05d947c05554bae`. The current checkpoint and previous bounded proof frontier were read. This review concentrates on both count regimes, their quantitative margin, the actual batch/moment interface and the normalization. It does not repeat the final zero contradiction.

## 1. Exact theorem and separate roles of its inputs

`Detector/FinalAssemblyNormalized.lean:18` is the selected, count-record-parameterized normalized theorem. `PrimeRows/NonfloorNormalized.lean:18` is the companion that obtains its count parameters internally. Their normalization steps agree: first bound the actual finite central cube, then multiply by an eventual inverse-normalizer bound. The result is

`norm(cube/normer) <= C*C0*Norm(eta.modulus)^(2*eps)*Z^(3/16+Delta-saving+nu)`,

with `normer != 0` explicitly included. It is conditional on actual `SourceMomentsAt` at every height in the stated cube and all source/window/geometric premises. This is not an unconditional analytic bound just because the outer data exist.

The generic binder `saving` need not be positive and does not require `saving>nu`. Positive saving is established at the selected consumer: `saving=t>0` and `nu=t/8` leave `7t/8` before the later `t/8` dyadic summation cost. After that cost the available saving is `3t/4`, which dominates the chosen sigma by its explicit budget. This distinction prevents assigning a stronger conclusion to the generic lemma than its type supports.

## 2. Actual batch construction and uniform thresholds

`PrimeRows/NonfloorMoments.lean:16` defines `SourceMomentsAt` by quantifying over actual batches with exact data, reverse orientation, slot set, widths, profile, upper endpoints, external parameter, mesh, bin width and character-family equalities. It requires `Moments` on every nonempty fiber. These equalities are not disposable labels.

`Detector/FinalAssemblyClass.lean:18` constructs the needed batch using the actual source-amplitude-batch theorem. Nonemptiness of the amplitude class supplies nonemptiness of the original rows. The row-band and support conditions are checked before construction, and all returned equalities are passed into `SourceMomentsAt`. The class mean satisfies `0<=q<=(2a-1)/2`; hence division by `delta=2a-1` is legitimate because `a>51/100`. The construction's deeper phase/bin and prime-sum estimates remain analytic inputs.

The actual count wrappers in `Detector/FinalAssemblySourceCount.lean` keep both regimes' constants, take their maximum, and intersect their eventual events before allowing arbitrary d, a, q, rows and height index. `PrimeRows/NonfloorBudget.lean:13` transfers an eventual threshold in U to all `U=Z^d` with d>=dmin>0; it does not require an unproved uniform-convergence theorem.

At `:22`, the frequency condition is paid explicitly: with d<=dmax and i<=n,

`2*pi*(Z^d)^(tau/(2*dmax))+3*i*Z^tau <= (2*pi+3*n)*Z^tau <= Z^heightCost`

eventually, since tau<heightCost. The prefactor at `:71` includes all labels, two dyadic indices, all amplitude bins and `fiberConstant`. It pays `logCost+heightCost+momentCost`. In particular `fiberConstant=(192*(1+height)*C)*max(1,K0)` is linear in C. No positive additive term has been lost when C0=0. The bin cardinality is bounded using fixed N and fixed positive bin width, so its potentially large size changes the constant, not the exponent or quantifier order.

## 3. Both count regimes, including exhausted capacities

Write delta=2a-1 and x=q/delta. The split is closed on the balanced side: delta<=5/6, otherwise delta>5/6. It covers a=1 and the exact split point.

For the balanced side, `Hecke/DetectorCountFromMoments.lean:12` obtains four bounds. The two unmarked bounds have exponents

`max(1,(1+5r)/6)-delta*r+2epsilon+epsilon_m`

and `max(1,2m)-2delta*m+4epsilon+epsilon_m`.

The marked inverse bound uses capacity `z=(1-r)/2-nu`; when invoked, r>=23/37, r<1 and nu<(1-r)/2 guarantee z>=0, z<=7/37 and the strict conditions `r+2z<1`, `2r+8z<3`. The marked plain bound uses `z=(1-2m)/(9/2+12Delta)-nu`. The crossing and length inequalities ensure the supply bound; its budget is exactly `2m+6*(3/4+2Delta)*z<=1`. These are checked in `DetectorBranchBudget`, not presumed for every row.

`DetectorRowCountOptimization.count_bound_of_source_branches` covers r>=1, either side of the crossing, m>=1/2, and both cases where the requested positive capacity is exhausted. Exhausted capacity falls back to an unmarked bound. There is no gap requiring a strictly positive marked selection for all fibers.

`commonLoss=154epsilon+epsilon_m+mesh+nu`; the optimization adds `5epsilon+6nu+Delta/4`. Thus the displayed balanced loss is exactly `159epsilon+epsilon_m+mesh+7nu+Delta/4`. At the optimized cutoff, `DetectorRowCountEndpoint.balanced_count_identity` makes the short and long exponents equal to the stated balanced row count.

For delta>=5/6, `Hecke/DetectorHighCount.lean:12` uses only the unmarked inverse bound and the cutoff 3/2. The length inequality gives r>=1-76epsilon. If r>=1, the slope 5/6-delta is nonpositive. If r<1, delta<=1 bounds the cost by 76epsilon. Including the original 2epsilon yields the high exponent `1-delta+78epsilon+epsilon_m`. Its independence of q and Delta is justified; no marked bound is silently imported there.

The finite-fiber wrapper pays all labels, bins and dyadic indices. `DetectorFixedAmplitudeCount.fiber_mean_eq` identifies the fiber mean with the same fixed q; without this equality the optimized common exponent would not follow. The selected source wrapper's high branch is strict, but its producer is valid at equality too.

## 4. What the moment-to-count step actually proves

The immediate count derivation is more than a renamed desired conclusion. `Hecke/DetectorRowCount.card_of_energy` sums the per-row spike lower bound `U^p<=norm(F_u)^2` and divides by the strictly positive U^p. Marked inverse and plain counts combine that spike with a selected physical-product spike; the plain polynomial occurs twice and correctly doubles its spike exponent and epsilon cost.

`DetectorInverseFiberCount` and `DetectorPlainFiberCount` select a physical product within the supplied capacity, transfer the raw moment bounds to row-dependent zero/frequency evaluations, and apply this elementary count inequality. `DetectorFiberEnergy` keeps the actual witness locations inside `[0,1]` by `[-height,height]`. The inverse factor 12 comes from `3*(1+4height)<=12*(1+height)`. For the plain square, the first and second derivative combinations cost an additional factor 16, giving 192. The raw derivative moments through order 2 are actually required; pointwise energy at a single common location would not suffice.

This does not re-prove the supplied raw moments, physical selection spike, detector witness spike or the underlying rowwise Sobolev theorem. Those remain named lower inputs. The no-slot inverse route also consumes the actual rowwise inverse-amplification endpoint, including its coefficient orientation and both scaled-profile raw moments.

## 5. Quantitative margin and physical scale

The balanced margin is not based on sampling. In `Endpoint.lean`, let D(y)=(37+34y)/18, P(y)=(7+18y+8y^2)/9, J=(5/6-delta)D+delta P and V=51+41y. For 0<=delta<=5/6 and 0<=y<=1/2, J is between 35/54 and 5/2. The source's exact identity is

`10368*V*J*(-E) = (3+5y)*((4V*delta-79)^2+49)`

`                   +4y*(4V*delta*((1+3y)*(15+32y)*delta+9-13y)+265+3485y)`.

All terms on the right are nonnegative; V<=17(3+5y) then gives `-E>=49/440640`. My independent rational-polynomial calculation expanded both sides after clearing J and obtained the zero polynomial. It also checked `10368*17*(5/2)=440640`. This is a full algebraic identity check, not evaluation on a finite grid.

`CentralMixedMargins` pays the conductor/dyadic mismatch `(d-v)R` using R<=3/2 in the balanced case and R<=1 in the high case. It pays the shift v<=13/16+zeta with slope at most 2. The balanced margin becomes

`-49/440640-(51/64)Delta+(13/16)*countLoss+2zeta+(3/2)mu`.

The high baseline `-1/48-delta/16-Delta` is stronger than needed. `NonfloorExponent.lean:8` combines both with `realLoss <=26e+(N+8)eps+loss+mesh/6` and the explicit count/final budgets. The proof uses v<=1, supplied by zeta<=3/16. No negative loss is discarded without its nonnegativity premise.

`FinalAssemblyArithmetic` sums every amplitude class and pays its fixed cardinality. Its exponent subtracts `P(a,e)=(25/48)a-181/300+(105/8)e`. `FinalAssemblyIntegral.lean:18` restores exactly this physical exponent from `X=Z^(17/48)`, `Y=Z^(23/48)`. I independently checked all three coefficients. The global L1 profile in `CentralCubeNorm` uses J=0 and retains `(1/(2*pi))^3`; it does not pay a volume factor for the height cube. Actual finite-kernel integrability and the common-profile identity are separate source prerequisites, not consequences of cancellation of exponents.

## 6. Normalization

`CubeNormalizer.lean:13` uses the same pools and residue weights as the numerator. `RayPoolThresholds.lean:42` intersects the finitely many positive-mass events. `RayNormalization` derives each lower bound `mass_j>=Z^(ell_j/6-delta0)` from the actual positive ray-prime mass asymptotic and log absorption. Choosing `delta0=nu/(N+1)` makes the finite product lose at most nu. The factor `Z^(-sum ell/6)` in the principal scalar cancels the mass powers; its sign has modulus one.

The fixed source-residue constant is separately positive by `PrincipalNormalizer.lean:13`: it uses positive Mellin factors and the positive principal residue. Consequently the full normer is nonzero, and its inverse norm is at most a fixed positive constant times Z^nu. Only then does `FinalAssemblyNormalized` divide and add nu to the exponent.

The ray-prime asymptotic reaches `Hecke/RayPrimes.analytic_family`, using analytic continuation and nonvanishing on Re(s)=1, rather than the target seven-eighths conclusion. That consuming interface is consistent. The complete ray PNT, principal residue and radial Mellin positivity proofs are not validated by this review.

## 7. Exact-check artifacts and remaining scope

`check_normalized_cell_algebra_20261111.py`, SHA256 `5C17BC3C46613C6197A8C71A88A7557554EE2EDF7053C3141B77F2EF388E5BDB`, performs only rational polynomial/scalar arithmetic and source hashing. Its receipt `check_normalized_cell_algebra_20261111.json`, SHA256 `1CD2622385D8628A2E33DA02BCE0BAAF339A1577B09810FC39C94E85425009E1`, records 12 passing checks and 40 exact source hashes. No analytic function was evaluated. These hashes bind the source references above and are not evidence of Lean elaboration.

I read the final author report in full and checked its source-sensitive assertions against the source. In addition to the detailed count/normalizer cut above, I checked the finite-kernel integrability-before-interchange in `CubeFiniteIntegral`, exact common-profile factorization in `CubeCommonProfile`, the weighted slot-product identity in `CubeSlotExponent`, and the consuming bounds in `CubePrimeBound` and `MellinBoundary.profile_uniform_moments`. Their source hashes are in the verified author table. This checks how those analytic inputs are consumed, not their entire underlying proof trees.

The checked implication is from actual moments, detector spikes/selection, central prime sums, buffered kernels, profile integrability and prime-ray mass to the normalized nonempty-cell estimate, including both count regimes and its quantitative positive saving at the selected parameters. The deeper analytic producers must still be audited and the source must still elaborate under an allowed axiom closure. This review supplies no new final premise for Goldbach.
