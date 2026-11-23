# Deterministic error for principal block wave reuse

2026-11-11. Coordinator research note, pending independent review. This proves a finite arithmetic error rule for the shared-wave suggestion in `PRINCIPAL_HIGH_STRIP_PRODUCTION_PLAN_2026-11-11.md`. It supplies no new sign, zero count, numerical block, Lean declaration, or performance measurement.

The current principal target is the closed strip `[.4968,.5032]` above height2000 through one million. A successful critical-line sign chain is a stronger sufficient certificate. Nothing below asserts that such a chain has been found, that a fixed mesh finds it, or that the fixed analytic K0 error can certify every nonzero Hardy value.

## Accepted mathematical input

Use the actual Khat expression in the independently reviewed principal K0 assembly, SHA256 `E14AC6ADC47771795B75142340962F9FEA95BC499049D7BBD0D4103B7019B6D6`, with review `A39ED6F31EE45499080BD95357B453F065F0FFEEE78AFDC9B794775460A73633`:

`Khat(t) = 2 Re(exp(i thetaHat(t)) * sum_(1<=n<=N(t)) w_n(t)) + J(t)`,

where `w_n(t)=n^(-1/2) exp(-i t log n)`, `N(t)=floor(sqrt(t/(2*pi)))`, and `thetaHat(t)=t/2*log(t/(2*pi))-t/2-pi/8+1/(48*t)`. Explicitly, put `a=sqrt(t/(2*pi))`, `z=1-2*(a-N(t))`, and `J(t)=-(-1)^N(t)*a^(-1/2)*F(z)`. Here F is the analytic removable extension of `cos(pi*(z^2+3/4)/2)/cos(pi*z)`, with `F(1/2)=F(-1/2)=1/2`; totalized division at those points is not used. The assembly proves `|HardyZ(t)-Khat(t)| < .451*t^(-3/4)` for real `t>=1500`.

The accepted stable interval plan, SHA256 `E3B6843DA11022ACBC0A7BBAFA5B8C125CF38B88127B69DCB3B8FF6EB90B157A`, with review `D483173A41EACEAB527579BB92A9F2795FB93161BAFAB47C2E249D264FD01197`, supplies arbitrarily accurate elementary enclosures of thetaHat and J at exact rational t, including strict saddle-floor selection. This note changes only how the finite main waves are evaluated. It does not replace the exact floor or the correction routine.

## Exact block identity

Fix exact rational `t0>=1500`, `h>0`, and integer `B>=1`. For `0<=j<=B`, write `t_j=t0+j*h`. Choose an integer `M>=1` with `N(t_j)<=M` throughout the block. One may bound M from the top endpoint before computing any waves; the actual active N at each point still needs its exact floor certificate.

For every `1<=n<=M`, define the exact unit rotation `r_n=exp(-i*h*log n)`. Then

`w_n(t_(j+1)) = r_n*w_n(t_j)`.

All M waves are initialized at t0 and propagated even when a wave is not yet in the active sum. A wave enters the sum only when the separately certified N reaches its index. This avoids an unproved interpolation or continuity claim at a saddle crossing. The main-wave identity remains exact across that crossing; J uses the appropriate branch at each sample.

The phase `exp(i*thetaHat(t_j))` is evaluated anew at every retained sample. It does not obey the constant-ratio recurrence for individual n waves.

## Center-radius recurrence

Let dyadic complex centers `v_(n,j)` approximate the exact waves, and dyadic `q_n` approximate r_n. Suppose

* `|w_n(t0)-v_(n,0)| <= E0`;
* `|r_n-q_n| <= delta`;
* each center update satisfies `|v_(n,j+1)-q_n*v_(n,j)| <= eta`.

The update uses rounded centers, not repeated rectangular interval multiplication. Certified Euclidean norm radii track the resulting error. Rectangular arithmetic may implement each operation if its component rounding bounds imply the stated complex norm bound.

Writing `a_n=n^(-1/2)<=1` and `E_j=|w_n(t_j)-v_(n,j)|`, split with the exact unit r_n:

`E_(j+1) <= E_j + delta*|v_(n,j)| + eta`

`             <= (1+delta)*E_j + delta*a_n + eta`.

No statistical independence is used. Shared or correlated log enclosures are allowed if the initialization and rotation errors above are individually valid. Their propagation is deterministic.

If `B*delta<=1/2`, then `(1+delta)^B<=exp(1/2)<2`, hence for every `j<=B`,

`E_j <= 2*(E0+B*(delta+eta))`.

This also covers delta=0 without dividing by delta. At a new block, recompute each initial wave to its fresh E0 allowance rather than carrying a previous block's accumulated radius into the new bound.

## One explicit error allocation

Let `0<e<=1` be a rational requested absolute error for Khat. The following conservative allocations work for every B,M above:

`E0 <= e/(64*M)`,

`delta <= min(1/(2*B), e/(128*M*B))`,

`eta <= e/(128*M*B)`.

They give `E_j<=e/(16*M)` for every wave. Therefore the error in any active exact sum due to its wave centers is at most e/16.

Sum the active centers with total complex rounding error at most e/16. Call the resulting center S. The exact active wave sum differs from S by at most e/8. The elementary bound `sum_(n=1)^N n^(-1/2) <= 2*sqrt(N)-1 < 2*sqrt(M)` implies

`|S| <= 2*sqrt(M)+e/8`.

Choose a rational `A>=2*sqrt(M)+1`, for example `A=2*M+1`, or a much tighter certified square-root bound. Certify a phase center u with

`|u-exp(i*thetaHat(t_j))| <= e/(16*A)`.

Because the exact phase has norm one, the main-value perturbation before final arithmetic is at most

`2*(e/8 + e/(16*A)*|S|) <= 3*e/8`.

Charge at most e/8 to forming `2 Re(u*S)` and adding the correction center, including all rounding in those operations. Certify J(t_j) with absolute error at most e/4. The total resulting approximation k_j then satisfies

`|k_j-Khat(t_j)| <= 3*e/8 + e/8 + e/4 = 3*e/4 < e`.

No later use may omit the initial-wave, step-rotation, accumulated-update, active-sum, phase, correction, or final-arithmetic allowances.

For the selected range through one million one may use M=398 with its existing certified saddle bound and A=41, since `2*sqrt(398)+1<41`. If `t_top=t0+B*h`, choose `e<=min(1,19/(1000*t_top))`. Then every sample in the block has arithmetic error strictly below `.019*t_j^(-3/4)`: `t_j>=1` and `1/t_top<=1/t_j<=t_j^(-3/4)`. Combined with the accepted analytic K0 error, the final interval has radius strictly below `.47*t_j^(-3/4)` about the actual Hardy value. A positive or negative interval certifies only that sample's sign.

## Finite construction and costs

All positive tolerances above admit a finite dyadic precision. The accepted elementary interval primitives can refine log n, initial exponentials, rotations, phase and correction to these tolerances. Error in h*log n must be charged when certifying q_n; storing a narrow log interval without propagating h is insufficient. Likewise t0 multiplies the log error in initialization. Exact rational or dyadic rounding with prescribed norm error is a finite integer computation. Floor selection at rational t terminates by the accepted irrationality-of-pi argument.

For a block of B steps this construction uses M initial-wave evaluations, M step-rotation evaluations that can be reused between blocks sharing h, and M*B rounded complex updates. Every evaluated sample still needs an active sum, one separately enclosed phase and one correction. Memory for the wave centers/radii is O(M). These are operation counts, not seconds or kernel costs. If only a sparse subsequence is needed for replay, direct evaluation or per-gap rotations may be preferable; the recurrence does not automatically compress the proof or shorten checking.

The fixed mesh and block length are data, not completeness assumptions. Nonzero wave approximations do not prove a sign for their sum. Inconclusive K0 signs require another sample or the existing arbitrarily refinable actual-function evaluator. A completed sign chain still needs disjointness, endpoint signs and the independent all-zero count. Multiple or permitted off-line zeros can defeat sign saturation while leaving the target strip true. Direct strip exclusion remains available.

## Required implementation and review

An eventual certificate must bind exact block endpoints, h, B, active-floor witnesses, initial centers, rotations, per-operation rounding rule, and phase/correction parameters. Either replay the specified center recurrence or supply checked arithmetic evidence for its updates. A claimed precision in bits is not a substitute for the norm-error bounds.

Independent review should rederive the recurrence and allocations, inspect the actual Khat signs and normalization, check saddle crossings and reanchoring, and distinguish arithmetic convergence from sign-search or spectral completeness. No Lean implementation, numerical block, or independent review is supplied by this note itself.
