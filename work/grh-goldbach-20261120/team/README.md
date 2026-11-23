# Ternary Goldbach through the existing large theorem

The November 20 collaboration targets the calr3 large theorem at commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. It proves the odd cases from 10^27 given `PlattGRH`. The team is testing full Dirichlet GRH as the provider and preparing the finite proof below that cutoff.

The [Saturday plan](saturday.md) records the November 21 deadline, the separate large-case milestone and the conditions for spending the AWS budget.

| Assignment | Work product |
| --- | --- |
| Verify the GRH release and identify a common Lean version | [Upstream evidence](grh-build.md) |
| Specialize the actual Dirichlet zero statement to the existing hypothesis | [Adapter audit](adapter/) |
| Prove the finite reduction under an explicit theta bound | [Checked Lean theorem and axiom output](gap27/check.log) |
| Find a shorter analytic proof of the prime interval | [Gaussian bounds and remaining inequalities](rh-gap.md) and [full-RH Weil window implementation](weil/WeilWindowRH.lean) |
| Produce a binary certificate near the target upper bound | [Certificate, generator and acceptance instructions](certificate/README.md) |
| Estimate production costs and benchmark requirements | [Binary cost model](finite-cost/estimate.md) and [combined ladder model](finite-cost/ladder.md) |
| Independently compare the ladder and Dudek alternatives | [Sources, measurements and hypotheses](alternatives.md) |
| Coordinate proofs and collaborate with Claude | [First exchange](claude/first-response.json) and [review of the Weil proposal](claude/second-response.json) |

Claude Code used the requested signed-in account. Both exchanges belong to session `97cda507-c748-437f-90d1-7c28eaf9e4f1`, started from the `claude` subdirectory. Its replies are research suggestions. The local theorem `WH_re_nonneg_of_line` proves the sign for the unphased window. The downstream prime sum has a localization phase and needs an absolute bound. Claude's endpoint calculation gives about 2.0e14 of room at the proposed B=1.1e16, conditional on the displayed uniform psi inequalities. Bertrand's theorem covers the transition where the lower endpoint would be too small to invoke those inequalities.

The closed implication in `gap27` uses a different input, the explicit Schoenfeld theta estimate, and yields B=1e16. The Gaussian implementation has to supply its own bounds. The benchmark needed for fleet sizing is a complete representative large block, including proof of primality, coverage, disk traffic and final Lean acceptance. The upstream GRH build and checking the closure of the Goldbach theorem in a compatible version are separate dependencies.

## Localized interval candidate

The prime-gap and finite-reduction agents independently screened a direct smoothed sum over a buffered short interval. For x=n−4, the proposed parameters give interval width plus four below 3.991e15 and a positive weighted prime contribution above 1.48√x. This would permit B=4e15. The planning model gives 51,541 core-hours for the binary computation at that cutoff, compared with 101,966 at B=1e16 and 110,370 at B=1.1e16. These values price certificate production and first checking after implementing the full-scale checker.

The open proofs include the localized weighted zero estimate, Gaussian leakage outside the buffered interval, prime-power removal, and the sum/integral interchange. In Lean, use `2 / max |γ| (2/w)` for the reciprocal weight so that the bound gives w at γ=0. The source-level numerical cross-check and the Lean-checked conditional theta reduction are distinct results. [Derivation](rh-gap.md)

Claude reviewed the 4e15 parameters in the same session. It found the endpoint, main mass, leakage and prime-power budget consistent, conditional on the uniform zero bound and the remaining explicit-formula error estimates. The first analytic deliverable is a multiplicity-aware upper bound of 98.977√x for the low-zero contribution, uniformly in x. [Third exchange](claude/localized-response.json)

Lean 4.35 also accepted the endpoint pilot covering every even integer in [9,999,999,999,997,954, 10,000,000,000,000,000]. The closed theorem uses `propext`, `Classical.choice` and `Quot.sound`. The run, including imports and axiom inspection, used 33.25 CPU seconds. [Kernel output](certificate/checks/endpoint02/lean.log)
