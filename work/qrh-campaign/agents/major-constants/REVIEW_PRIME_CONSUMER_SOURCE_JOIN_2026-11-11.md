# Independent review of the P4 source join

2026-11-11. **PASS as a conditional paper/source reduction.** No blocking mathematical or source-fidelity defect found. This is not a Lean proof, a completed finite certificate, or an adoption of a changed strategy.

Reviewed author: `../prime-estimates/PRIME_CONSUMER_SOURCE_JOIN_2026-11-11.md`, SHA256 `B5F377CEED926B70B22E2539086D5C423D474A065D3E10F56D93C93108377B61`. Source: `work/ternary-goldbach/TernaryGoldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`; cached Mathlib commit `56a005855ea17e0b0958f73ec801ae140b0a1679`.

## Count and moment

The unconditional height-floor derivation is valid. At a zero with 1/2<=sigma<=1, the source `Explicit/ZetaLowZeroFree.lean` norm bound and `zetaF_eq_J` imply 4(sigma+1)<=|s||s-1|. The arithmetic-geometric mean gives the upper bound sigma^2-sigma+1/2+t^2. Consequently t^2>=23/4>2.39^2. The other half is reached by the stated xi reflection, not by assuming critical-line zeros. This also excludes real nontrivial zeros. The scratch proof and its existing audit were inspected; its status remains paper/source, not a new compilation claim.

For the translated positive mass estimate, the author correctly exposes the missing analytic producer and the true multiplicity bridge. `XiPartial.xi_partial_approx:776` alone supplies T>0 and a lower multiplicity bound in one output clause; those are not enough to replace actual analytic orders. Its proof chooses k>=23 and T>k. Strengthening that output or using divisor equality with the actual memberships gives the stated route. `WeilBridge.lean:38,56,87` was checked; the destination-height hypothesis in the last lemma must be retained. Positivity permits comparison of any selected finite zero set before the approximation error tends to zero. There is no finite count calibration hidden in this argument.

On every length-three bin, a=2-beta lies in [9/8,15/8]. The concave quadratic a-(8/25)(a^2+9/4) is nonnegative at both endpoints, so every zero, with its multiplicity, contributes at least 8/25 to the translated mass. The logarithm bound at |c|<=60343058+3 gives mass<12. Thus total multiplicity<37.5, and the weaker bound 38 is safe.

The two half-open sign-bin partitions include all nonzero ordinates and the closed top height 10^6; the last index is 333333. The first bin uses 2.39, and every subsequent bin uses 3k. Therefore the exact harmonic comparison is

`sum m/|rho| <= 7600/239+(76/3)H_333333 < 277096/717 < 387`.

Here the middle displayed strict inequality uses H_333333<14. The relevant Mathlib harmonic bound was checked. The weighted quantity inherited from the reviewed smoothing packet is specifically

`W35 = sum m*exp(35*max(beta-1/2,0))/|rho|`.

This definition, including the maximum, should be retained in implementation. Under the closed .4968--.5032 certificate its weight is at most exp(.112)<9/8. The geometric bound starting at the quadratic exponential term is valid, giving W35<435.375<436. This bound is uniform over the finite explicit-formula carriers, not an assumed enumeration or an assertion about an undefined infinite zero sum.

## Smoothing and its domain

I compared the allocation with the previously reviewed `mellin/RESUME_PSI_LOW_ZERO_REFINEMENT_2026-11-11.md` (SHA `33C01406E927F8F49F329AB52B967AA14B85B64DF7928A034C3028EFEEB91F61`) and the existing review `RESUME_PSI_LOW_REVIEW_2026-11-11.md`. The new narrower strip satisfies the older endpoint-factor domain. Only the low-zero moment is enlarged. On 5e9<=x<=exp(35),

`1.002*436/sqrt(x) < 436.872/70700 < .00618`.

The other accepted entries sum to .002188002001 after multiplication by log x. Since log x>22, their unscaled sum is below .0001. Applying the upper-denominator factor conservatively to the entire sum gives .00628000628<.006281<.0064. The earlier shared-strip/global tail gives .0081/log x<.0064 from exp(35) onward. These are continuum implications of the inherited estimates, not checks at sampled x.

This establishes the proposed P4 upper envelope conditionally. It does **not** establish .01/log x from the new coarse moment and does not discharge the accurate moment needed by other consumers. The new reduction retains the global 7/8 provider, shared finite .555 strip, and narrow principal certificate. The paper Gaussian finite-carrier/limit and refined vertical-integral arguments still require formalization; the existing RHBelow producer cannot simply lose its hypothesis.

## Finite and floor joins

The exact existing target is `Prelim/LambdaMu.lean:1375`, the von Mangoldt Icc sum at floor(y), bounded by 1.0064*y for y>=25000000. `ThetaExplicit.psiR_nat:42`, `psi_eq_Icc:126`, `PsiTwoSided.psi_Icc_eq`, and the definitions supply the required carrier equalities. The final `Nat.le_floor`/`Nat.floor_le` step in the source has no additive unit loss.

`PsiSieveMain.sieve_table3:28160` has the strict upper cutoff 10^9. Its theta upper estimate and the finite prime-power repair give 1.00030524*N for 25000000<=N<10^9. The subsequent closed checkpoint chain gives 1.000397565*N for 10^9<=N<=5e9; the arithmetic and right-endpoint interpolation were checked against `RESUME_PSI_LOG_RECURRENCE_LEDGER_2026-11-11.md`, SHA `27B2C225C2A5646DCD01948E35FA12FB3D3627E2A538D4127CC2900622624B1A`. The 6439 prime-count and log/recurrence certificates are still required. Neither the data nor an external verification flag is promoted to a Lean theorem here.

The finite nonprime repair is legitimate on this range. In `LambdaMu.nonprime_mid:678`, the sqrt, cube-root and fourth-root calls all have arguments strictly below 10^6 when N<10^12. `PsiTwoSided.lean:79` shows the below-10^6 branch directly uses unconditional `SmallTab.small_table` and `thS_add_ppS`; the later conditional branch is unnecessary. `SmallPsi700.psi_lt_small_700:12` and this table give the finite 1.03883 bound. The source polynomial at v=3.162 and its positive derivative were independently checked. Calling the existing conditional wrappers unchanged would not be this repair.

The sieve/chain join at 10^9, chain/analytic join at 5e9, and analytic join at exp(35) have overlap or explicit closed endpoint coverage. No missing interval or threshold change was found.

## Independent checks and remaining scope

`review_prime_consumer_source_join_20261111.py`, SHA `A7EA3B2FEB74105FD2BA4F5B2CC894812BCE996A4D5E3E5EAC8EACE1E0866897`, ran 22 independent Fraction-only assertions. Receipt `review_prime_consumer_source_join_20261111.json`, SHA `431801E6EB1DCC8429CB3C8D902C0A46250DFB0A8ED80675A3162F1005F97861`. They check the height floor, mass endpoints, elementary exponential comparisons, harmonic constants, weighted moment, both smoothing branches, finite bounds and the finite nonprime polynomial. These are scalar checks, not zero or prime evaluations.

The author-frozen report was not changed. No Lean build, evaluator import, native numerical evaluation, zero scan or new prime computation was performed. Missing spectral evidence, translated-mass/digamma proof, multiplicity/limit adapters, finite prime certificates and final exported type/axiom validation remain open. The accepted conclusion is precisely that these identified inputs suffice for this unchanged P4 consumer with the weaker coarse moment.
