# Independent review of the principal simple-phase K0 assembly

2026-11-11. Verdict: PASS as a complete assembled paper proof of the stated approximation to the actual Mathlib Hardy Z function, for every real t>=1500. No unresolved mathematical join was found after including the pinned coefficient-contour supplement. This is not acceptance of a Lean theorem, an arithmetic checker, sign data, a finite RH certificate, or the Goldbach theorem.

## Frozen target and review scope

The target is `independent-feasibility/PRINCIPAL_SIMPLE_PHASE_K0_PAPER_ASSEMBLY_2026-11-11.md`, SHA256 `E14AC6ADC47771795B75142340962F9FEA95BC499049D7BBD0D4103B7019B6D6`. All relative paths in this report begin at `work/qrh-campaign/agents/`.

I read the full assembly and the underlying normalized-Gamma, exact Riemann-Siegel, coefficient-contour join, and K1 remainder arguments. I checked the independent Mordell, Gaussian-moment, normalized-Gamma, exact-RS, and K1 reviews. I also inspected the actual pinned Mathlib HardyZ source. A read-only hash replay verified the target and all 13 producer/review pins in its ledger. There were no mismatches.

I authored the earlier coarse-phase component. That component has its own independent review by the assembly author, pinned `DE019E48942C1999785FA8F14BC4CD65CAD7C4423038965FA0DEF96DD8BC75D0`. This report independently reviews the new assembly and its joins; it does not substitute self-review for that component's existing independent review.

The source pins are Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679` and Goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No source, dependency, producer, or frozen artifact was edited. No build, scan, special-function evaluation, or new sign computation was run.

## Exact function and phase normalization

The target is the global real function `hardyZ`, not a new function in a `Mathlib` namespace. The producer explicitly explains its prose prefix. The source at `Mathlib/NumberTheory/LSeries/HardyZ.lean:76,79` defines it using the real part of completed zeta divided by the positive norm of Gamma_R, and provides `ofReal_hardyZ`. Its own `abs_hardyZ` proof uses the same completed-zeta product identity required by this assembly.

The normalized-Gamma construction supplies an analytic L on Re(w)>0 with exp(L)=Gamma, L(1)=0, and real values on positive reals. Its proof obtains the kernel bounds from exponential coefficients, differentiates under uniform exponential majorants, proves the Gamma recurrence and log-convexity, applies Bohr-Mollerup, and then uses analytic uniqueness. The assembly carries the source-name correction `Real.eq_Gamma_of_log_convex`. It does not assume a chosen branch of principal log Gamma or an unknown imaginary constant.

For s=1/2+it and w=s/2, define ell=L(w)-(s/2)log(pi). Since pi is positive, the actual Gamma_R definition gives Gamma_R(s)=exp(ell). Thus its norm is exp(Re ell)>0, and division by that norm gives exactly exp(i theta), where theta=Im L(w)-(t/2)log(pi). The critical point s is nonzero and Gamma_R is nonzero. The source zeta definition consequently yields

`(hardyZ(t) : Complex) = exp(i theta(t))*riemannZeta(1/2+it)`.

This fixes the sign of the target function. Equality of moduli or zero sets would be insufficient. No principal pole or totalized Gamma value occurs on this line.

## Dependency closure at paper level

The assembly consumes concrete proofs of the former analytic leaves, with the following interfaces checked.

| Component | Checked conclusion and join |
| --- | --- |
| Normalized Gamma and coarse phase | The periodic-Bernoulli argument uses the same Laplace remainder R as the constructed L. It proves `abs(theta-thetahat)<13/(50*t^2)` and `abs(theta-theta0)<1/(40*t)` on all t>=1500. |
| Mordell special cases | The reconstructed cases are 1, 1/2, and 2. Their positive square roots, line orientations, finite residue shifts, Gaussian domination, and removable interpretations supply the exact integral identities. |
| Exact RS identity | The initial real interval 1<s<2 avoids the exceptional intermediate denominator. Absolute Fubini, the Gamma-ray branch, the origin detour, reflection/duplication, and continuation to the critical line are supplied. The residue shift and saddle substitution give the same S, q, tau, and sign used in the assembly. |
| Fixed Gaussian moments | The same prefactor c(q) gives `abs(B0)<=1`, `abs(B1)<8/5`, `Re B0=F(q/sqrt(pi))`, and `Re B1=F'''/(3*pi^(3/2))`, with `abs(F''')<=4*pi`. These bounds cover the closed parameter interval. |
| Coefficient-contour join | The fixed coefficients equal their source-contour integrals before subtraction, including the indented upper endpoint. This is a separate proved step, not an inference from the moment bounds. |
| K1 remainder | The explicit defect equation and segment FTC give the residual. The four-range bounds and frozen tails prove `abs(S-B0-tau*B1)<4.2*tau^2` for all t>=1500 on the actual saddle domain. |

The exact-RS identity uses the actual theta just identified with HardyZ. Its finite shift gives the main sum with coefficient 2, and the residual I_N already includes that coefficient. The saddle formula therefore has one correction `sigmaN*a^(-1/2)*Re(U*S)`, with no second factor 2.

The K1 proof does not take a full Gabcke error theorem as a premise. Its radial segment stays off the specified logarithm cut. The elementary f/W estimates cover their entire real ranges. The middle integrals have bounds 1.82 and 2.31, while each tail is below .001. The tail integration-by-parts estimate is used only with shape a>=1 and cutoff X>a. Freezing these tails at t=1500 is an upper bound for every larger t. No hidden finite-height cutoff is introduced.

Ordinary analytic prerequisites remain, including finite Cauchy and residue theorems, dominated integration, Gaussian integrals, and analytic uniqueness. Their applications, branch conditions, and limiting majorants are present in the component proofs. No missing source-specific contour identity or quantitative K0 estimate remains as an unexplained assumption in this paper composition.

## The floor endpoint is covered

For a=sqrt(t/(2*pi)) and N=floor(a), the parameter is -sqrt(pi)<q<=sqrt(pi). At an integral a, q=sqrt(pi). The exact saddle proof gives the southeast detour with the pole on the left of the increasing diagonal path.

The join supplement `major-constants/K0_COEFFICIENT_CONTOUR_JOIN_2026-11-11.md`, pin `B484CC05689773705AC91AE6D3938FE6D605AF850404106845A4E7CC0B8816D1`, is essential. It proves equality of fixed and indented coefficient integrals for each sufficiently small positive radius using a pole-free notched region and vanishing connectors. At the endpoint the normalized B0 residue is exp(-3*pi*i/8)/pi. Its positively oriented half-circle contributes exp(i*pi/8); its symmetric straight principal value is zero. Hence the fixed value is B0(sqrt(pi))=exp(i*pi/8), not zero. Its real part also matches F(1)=cos(pi/8).

The assembly retains this arc. It subtracts S, B0, and tau*B1 on the same contour. Only then does the double zero of g-1-tau*P1 make the residual quotient removable with value zero, so that its arc tends to zero. The small radius also avoids the shifted logarithm cut. There is no unsupported removal of B0's pole and no circular use of the final remainder estimate to justify the coefficient deformation.

The excluded lower endpoint q=-sqrt(pi) is never produced by the floor convention. The residual has a continuous extension there, but the argument does not require an unindented S definition there. The approximation may be discontinuous at a floor transition; the proof is pointwise on both sides and at the endpoint. It does not apply the intermediate value theorem to the approximant.

The removable F values at z=+/-1/2 are both 1/2 and come from the analytic integral representation. Totalized division or division by an interval containing zero would not evaluate that function correctly. The sign `sigmaN=-(-1)^N` removes a natural-predecessor ambiguity. In this range N>=15, and every log(n) and real power in the finite sum has positive argument.

## Scalar assembly and global phase sensitivity

The two uses of the phase bound are separate and both valid. First, U=exp(i*(theta0-theta)) is a unit and `abs(U-1)<tau^2/5`. Combining it with the moments and K1 gives

`abs(E2)<[21/5+(1/5)*(1+(8/5)/40)]*tau^2=(551/125)*tau^2<4.41*tau^2`.

Taking real parts uses the sharper real-part bound for B1, rather than its modulus bound. Multiplication by the one saddle factor a^(-1/2) gives the bracket in the producer's equation (9). The rational pi/root estimates bound that bracket by `3317717799/7457500000<.45`.

Second, monotonicity gives `sum_(1<=n<=N) n^(-1/2)<=2*sqrt(N)-1`. The main-sum amplitude is therefore strictly below 4*t^(1/4), for every positive height in the stated range. Multiplying by the phase error gives less than `(26/25)*t^(-7/4)`. This is an all-height bound; it does not use the earlier finite-range amplitude 80. The correction F has no theta dependence and contributes no phase-substitution error.

Consequently the total coefficient is at most

`45/100+26/(25*1500)=16901/37500<451/1000`.

I ran a fresh inline Python Fraction replay, without importing author code or writing receipts. All 11 exact checks passed: N>=15 at the threshold, the fourth-root upper bound, the sqrt and tau thresholds, the coarse phase-to-U inequality, the E2 exact value and rounding, the bracket fraction and rounding, and the final exact value and rounding. The process exited zero. A separate read-only replay verified all 13 dependency pins and the assembly pin. These checks corroborate the arithmetic; they do not prove the analytic estimates.

## Final acceptance boundary

The frozen note establishes on paper, by composition of the reviewed proofs,

`abs(hardyZ(t)-Khat(t)) < (451/1000)*t^(-3/4)`

for every real t>=1500. The normalization, unbounded domain, strict threshold, removable values, and all integral-saddle endpoints are covered. No finite RH assumption or high-order sharp Gamma-phase theorem enters this chain. No correction is requested.

Actual Lean proofs of the component arguments and their interfaces are still absent. A usable interval checker also needs proved finite-arithmetic enclosures, floor certification, and outward-rounding bounds. Strict signs, their ordering, and a complete zero count are separate data and proof obligations. None follows merely from this analytic error theorem. This report makes no kernel-feasibility, runtime, finite-spectrum, or final Goldbach claim.
