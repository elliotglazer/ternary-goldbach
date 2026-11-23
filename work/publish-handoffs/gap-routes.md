# Prime gaps and the HOL4 Turing phase

Status at 22 November 2026. Paths are relative to the workspace root.

## Prime gap below 10²⁷

The Lean reduction in `work/grh-goldbach-20261120/team/gap27/Gap27.lean` gives ternary coverage through 10²⁷ assuming an explicit bound on Chebyshev's theta function and binary Goldbach through 10¹⁶. Bertrand's postulate handles the lower branch. Both theta evaluations on the upper branch occur above 5×10¹⁵. The reduction can therefore use a non-strict theta bound valid from 10¹¹, followed by its already strict numerical majorant. That interface adjustment has been identified in the source and still needs a compiled join.

The candidate `theta_schoenfeld_large` in `work/goldbach-lean/entries/goldbachintervalsrh445/LeanLab/PNTPort/ExplicitPsi1/ThetaSchoenfeldLarge.lean` proves the required log-squared bound from RH and three extra inputs about the actual zeta zeros, `HSWN70 gZ`, `HSWHead14 gZ` and `Ordinates14 gZ`. The source signature was inspected. Discharging those inputs and importing the result on the common toolchain remain open.

The narrower 4×10¹⁵ binary cutoff uses a separate explicit-formula argument. Its main term, vertical and middle/high-zero coefficients, prime extraction and finite transfer have local Lean checks. The analytic assembly, continuous binary coverage through the cutoff, and final join to the large-range ternary theorem remain outstanding in the reviewed records. The 60,285 useful core-hour estimate extrapolates two workstation blocks. It is a planning figure for finite work. See `work/grh-goldbach-20261120/team/local-assembly/README.md`, `work/grh-goldbach-20261120/team/finite-cost/reforecast.json` and `work/grh-goldbach-20261120/team/large-corollary.md`.

## Turing phase and the Gamma remainder

The following directories are under `work/backend-costs-20261112/hol-platt/`. The stated HOL4 results were kernel-exported.

| Source | Verified result |
| --- | --- |
| `full-height-count/Rumely167Script.sml` | Both fixed conductor-10,000 inverse-pair rows pass the strict integer upper-count arithmetic at 167 extra steps, using the supplied phase, weights and per-channel allowance 3.85174. |
| `source-log-real/TuringScheduleScript.sml` | For positive log arguments through 37,748,736, the logarithm is below 17.5. The conductor-height adapter covers the stated schedule through conductor 400,000 with a guard extension up to 200, given the lower bound 3.14 on the supplied value of π. |
| `source-log-real/BernoulliPhaseScript.sml` | The sharp absolute bound for the fourth Bernoulli polynomial on [0,1] is 1/30. |
| `phase-integral/PhaseMassScript.sml` | For y>0, the improper integral of (u²+y²)⁻² over the positive half-line exists and is at most 1/y³. |
| `phase-bernoulli-kernel/PeriodicKernelScript.sml` and `PeriodicMassScript.sml` in the same directory | For z=h+iy, h≥0 and y>0, the actual modulus of B₄({u})/(u+z)⁴ is integrable on finite intervals. Its integral over the positive half-line exists and is at most 1/(30y³). The continuity proof includes integer endpoints. |
| `phase-bernoulli-kernel/ComplexRemainderScript.sml` | Both components of the kernel have finite gauge integrals. The norm of the finite complex integral is at most the integral of the modulus. The export includes `cr_component_integrals` and `cr_finite_kernel_norm`. |

Build receipts are `phase-integral/mass-check.log` and `phase-bernoulli-kernel/{kernel-check,periodic-mass-check,complex-remainder-check}.log`. Separately, `full-height-count/gamma167_integral.py` checked both stored phase upper bounds by native FLINT quadrature. That numerical check used the analytic log-Gamma integrand.

The signed complex improper limit and its norm bound still need a completed HOL4 export. The draft is `phase-bernoulli-kernel/ComplexTailScript.sml`. The subsequent analytic obligation is the order-four Euler–Maclaurin identity for log Γ on the right half-plane, with its branch real on the positive real axis. After the 1/(12z) term the remainder is −1/(360z³) minus one quarter of the signed periodic integral above. Connecting this identity to the paired phase, certifying the stored endpoint expressions, proving the integrated Sχ allowance, and linking the counted brackets to actual zeros remain separate obligations. These results establish neither a complete Turing count nor an end-to-end verification time.
