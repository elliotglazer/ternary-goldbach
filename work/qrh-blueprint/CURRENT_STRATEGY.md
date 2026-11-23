# Current strategy: minimum finite heights and the short prime gap

Selected research plan, 2026-11-11, against `work/ternary-goldbach` commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The earlier 104-chapter package is preserved separately at `outputs/qrh-blueprint-104`. This plan adopts independently reviewed conditional reductions; it is not an author-frozen Lean declaration or a completed proof. No new Lean build or canonical theorem edit occurred. Agent report paths below are relative to `work/qrh-campaign/agents`.

## Unchanged final target

Prove `TernaryGoldbachFrom (10^27)` with no mathematical premise, then the existing full `Statement` with only `BinaryGoldbachInput`. Preserve every odd natural at the inclusive large threshold, the original finite bridge, and the meaning of “sum of three primes.” No finite spectral assertion, psi estimate, QRH conclusion, or computational result is an allowed extra final premise.

Use the revised major/minor/nonprime budget `1.0404 / 1.0376 / .00271`, leaving `.00009>0`. Rebuild the lower representation-sum and final numerical adapters; the old major coefficient1.049 cannot be retained by calling its unchanged wrapper. Source roots are `Helfgott/Main.lean:68`, `Helfgott/Inputs.lean`, and `MainTheorems.lean:16,23`.

## Selected mathematical evidence to prove

1. Validate and integrate the actual global7/8 nonvanishing provider, including the principal-pole exclusion and reflection/multiplicity adapters. Its known source is not a locally checked target artifact. The smaller23/24 provider does not supply this plan.
2. For every active primitive character, prove `beta<=111/200` at all nontrivial zeros with inclusive height `|gamma|<=Hcert(c)`. Active conductors are odd `c<=150000` and multiples of4 `c<=300000`; include principal conductor1 and all conjugate characters.
3. Prove the additional principal low-zero package through one million, sufficient for the weighted moment24 described below. It is not implied by the .555 family assertion.
4. Prove the short finite prime-envelope interval using the generated candidate counts, their complete sieve semantics, certified log boxes, and exact interpolation. External counts and hashes are evidence to replay, not theorems.

For `D_c=1200000/qt(c)`, with `qt(c)=2c` for odd c and c otherwise, select

`Hp_old(c)=ceil(200+max(1000,(704/7)*D_c))`,
`Hcert(c)=min(Hp_old(c),100000000/c)`.

The heights are exact real/rational values; do not round the minimum upward. The star low cutoff is `min(Hs_old(c),100000000/c)<=Hcert(c)`. At c=1, `Hcert(1)=60343058`. Both inequalities `Hbase<=Hp_old` and `Hbase<=100000000/c` must be established for the pointwise base-gap proof; the major moment audit alone does not establish them.

The common-height major argument and minimum-profile corollary have a completed independent conditional review in `independent-feasibility/REVIEW_COMMON_HEIGHT_NEW_2026-11-11.md`, hash `3536A5E362A7E72DB10A4DC909A972CECE2DD8E11BAA2F5B3DB1A1BDD90CAA87`, bound to `major-constants/RESUME_COMMON_HEIGHT_MAJOR_2026-11-11.md` hash `79833F8D5D5856E000A96D3F5CCA9FC9E26CB3BAF637CDE089FEFDD703436BA7`. No finite spectral certificate exists.

Base-gap containment has separate reviewed evidence: `zero-sum/RESUME_BASE_GAP_FINITE_FAMILY_2026-11-11.md` proves the old-Hp comparison, while `zero-sum/RESUME_SPECTRAL_CERTIFICATE_STRATEGY_2026-11-11.md` section6 proves the common-height comparison. The latter is bound by `moebius/SPECTRAL_CERTIFICATE_STRATEGY_REVIEW_2026-11-11.md`, hash `2E39BDF6741A252F6A9F6DE8F9812AFFB5611D431AE424543536B4A48D0922CE`. Both inequalities therefore give the minimum-profile comparison without changing the base cutoffs. These remain paper proofs requiring formalization.

## Proof order

**Elementary and finite foundations.** Formalize the reviewed P2 harmonic upper bound, P3 harmonic lower bound, and full P6 prime-power bound. Reuse the existing finite tables with their proven specifications. Independently implement the finite totient theorem through `q<=2^1000`, the elementary fourth-root first-choice repair, and the remote second-choice envelope. Prove the separate `regionS` replacement; it is not supplied by the Type II totient repair.

**Finite prime interval.** Keep the grid from `a0=10^9` to `5*10^9`, with next endpoint `min(5*10^9,a+floor(a/4000))`, and require `|theta(a)-a|<=a/10000`. P6 and monotonicity give both psi errors below `v/2300`; `log v<23` then yields `|psi(v)-v|<.01*v/log v` throughout every interval. This relaxed condition replaces the rejected tighter checkpoint condition; the old rejection remains recorded.

All6439 windows now have external candidate counts. The complete chain comprises the earlier538 windows and5901 new windows, with125271 small sieve subwindows in total. The read-only metadata/receipt/rational replay passed. A separate independent sieve subsequently recounted the entire four-billion-integer interval with different segmentation and reproduced every window count, subcount and hash. Neither check is a Lean proof. Current data status is pinned by `prime-estimates/RESUME_PSI_FULL_CANDIDATE_2026-11-11.md`, hash `466ABA0CBBBE9ED52C9FFB805336CBF7208AEF25DAD57C45FCA03CD9E8EACDDE`; the dataset `psi_full_candidate_20261111/COMPLETE.json` has hash `92770E969395E4817210366B3ECBDFF218768D800C923CA6E7944CF71DD73763`. The independent report is `audit/RESUME_PSI_FULL_RECOUNT_REVIEW_2026-11-11.md`, SHA256 `F18029529E22892D2225C96DC36058BFC1DDB2D22E19082A0292A320DAE97FF1`. There are zero uncounted windows and zero new Lean count proofs. Prove base-prime completeness through70710, each interval count, the source-seeded theta recurrence, all log boxes, and endpoint coverage before consuming this data.

**Principal spectral refinement and all-range psi.** The reviewed smoothing/desmoothing refinement gives the required psi envelope for `x>=5*10^9` from the shared principal .555 height, global7/8, and the extra low-zero strip/moment. Therefore the finite and analytic branches meet at exactly5e9. The integer envelope E is `|psiN(v)-v|<=.01*v/log v` for all `v>=10^9`; downstream real-cutoff adapters retain their separately reviewed floor allowance.

The extra principal contract is the actual multiplicity sum

`W35=sum_{|Im rho|<=10^6} mult(rho)*exp(35*max(Re rho-.5,0))/|rho|<=24`,

together with the required low strip, not a zero-list heuristic. The selected sufficient construction is: no nontrivial zeros through height14; `.499<beta<.501` through one million; positive-ordinate `Q1500=sum mult*(1/gamma-1/1500)<=2`; and `N(t)<=F(t)+5*log(t)+20` for all real t>=1500, where `F(t)=t/(2*pi)*(log(t/(2*pi))-1)+7/8`. The independently reviewed Jensen/Binet and argument-principle construction proves this count estimate on paper without finite-count calibration or historical zero data. It gives W35<23.990<24. Its exact counting identity, argument branches, closed-height limits and analytic interfaces still require formalization.

The count proof and independent review are `mellin/RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md` and `major-constants/RESUME_PSI_ANALYTIC_COUNT_REVIEW_2026-11-11.md`, with review SHA256 `82B2A416EAE9E4F16F8147C92776AB7D5063355E3EABE828615281AA64D8C418`. The actual closed height14 exclusion now has an external zetaF rectangle certificate, independently checked with different Euler--Maclaurin parameters, and needs formal replay. Its review is `moebius/ZETA14_RECTANGLE_REVIEW_2026-11-11.md`, SHA256 `787C5C4FB9885A8C02098C8D99E68207075539D73E72266CFEAA5A360FCF7B1E`. The narrow strip through one million and complete Q1500 certificate remain absent. The .555 family certificate supplies neither. Closed-height sums require larger auxiliary divisor radii before applying strict source multiplicity bridges.

**Prime and Möbius producers.** Derive original P1/P4/P5/P7 from E and the reviewed finite sources/P6. Use E and P2 for the214-cell Möbius induction and revised infinite tail, obtaining `.03` on `[11815,100000001)` and `.10` thereafter. Transport this to the original M1 coefficient2.8 and M2 coefficient.37273 through the changed internal G2 allowance.0089. Do not claim the old .0082 or .09 intermediate bounds. Rebuild first/second-choice Type I/II consumers with the finite/remote totient repairs, retaining the raised off-arc envelope and its integrated correction below1e-24.

**Shared analytic infrastructure.** Prove true-multiplicity xi-mass bounds, reflection with conjugate characters, actual-smoothing Mellin/Gram/product-space estimates, Gauss/induction arithmetic, primitive-to-coprime-to-full transfers, pole/zero0 handling, and good-height limit passages. The new common-height plus tail additionally needs the weighted Fourier-Plancherel L1 split. None of these may be replaced by a new distributional assumption.

**Major arcs and lower energy.** Recompute low estimates on the smaller finite sets using hereditary positive envelopes, not monotonicity of signed sums. Use the common-height Gauss-weighted high tails and the revised full mixed remainder `Rmix<.000160001`, not the former2e-10. Preserve `Aplus<5e-7`, `Astar+Cross<9.5e-7`, `N<1.23`, and `Ep<1e-4`. Principal conductor1 keeps its old cutoff and sharper Ep estimate. Obtain `8.6296<J<=10` without a circular use of J; then the full major contribution is at least1.0404 after all removal corrections.

**Minor arcs.** Prove actual etaPlus prime-restricted square energy at most `.65*x*log x`, retain summability, and update sigma/sD/tau numerics. Combine lower J with the unchanged residual-energy target8e-11*x to obtain the source I0 lower bound. Use the separate elementary `regionS` quotient-sieve repair. The resulting integrated minor estimate stays below1.0376, including the explicit remote-totient correction.

**Complete base gap.** Preserve original character modulus m, reduced approximation denominator `q=m/gcd(m,2)`, `y=x/49`, actual etaU twist delta, and `u=2q*|delta|`. The strengthened parity adapter gives `1200000/49<=u<1200000`. The finite-family pointwise bound covers every reduced q>=4; the q1/q2/q3 finite prefixes join their reviewed high-twist branches. Those high branches depend on the repaired Type I/II producers, so base-gap closure follows those repairs. Implement etaU GoodSmoothing and its actual explicit formula; integrated major moment caps alone do not imply this pointwise estimate. Prove the two height containments before replacing old Hp by Hcert.

**Final assembly.** Feed the new actual consumers into `MinorTotal` and the averaged major comparison, apply the existing circle identity and nonprime estimate, and reconstruct the large and full roots at the unchanged thresholds. Audit expanded theorem types and transitive axioms. An unused `Fact PlattGRH` binder still fails the goal; standard axiom output alone does not remove it.

## Evidence and remaining work

The common-height major and separate base-height containment reviews are complete as conditional paper/scalar reviews. The earlier base-gap, small-q joins, P2/P3/P6, E-to-producers, Möbius, energy, totient and regionS reviews remain the corresponding supporting evidence. The full independent prime recount, analytic Jensen count review and external height14 certificate review passed. None establishes a kernel count equality or a final analytic provider.

No complete family Hcert assertion or narrow strip through one million has been certified. The height14 result and conductor-three pilot are bounded external certificates only; the latter covers requested height32, not its production height. The global7/8 provider still needs compatible local type/axiom validation. No new analytic or finite premise is permitted in the final theorem. The decisive unfinished tasks are the remaining spectral certificate generation and replay, prime certificate replay, the specified analytic proofs, consumer integration, and final kernel/type/axiom checks.

## Alternatives retained separately

* The original-height .555 family plus the long `[10^9,1.6e15]` finite gap and analytic threshold exp35 avoids the extra narrow principal moment certificate. Its85721 endpoint data are not supplied by the short-gap run.
* Original and previously reduced finite-height profiles retain their own reviewed tail budgets. Do not combine their cutoff assumptions with another profile's remainder constants.
* Weighted spectral alternatives remain research options; they do not automatically provide the pointwise base-gap assertion or its parity-sensitive domain. A switch requires a fresh consumer audit.

This plan chooses one coherent route. Its external computations and conditional paper proofs must become actual proofs before it removes PlattGRH.

    DRAFT_ANCHORS: 0 created
    UNREGISTERED_SORRIES: 0 introduced
    DRAFT_IMPORT_VIOLATIONS: 0 introduced
    SEALED_THIS_TURN: 0
