# gap routes — 2026-11-21

## 22:15:11 UTC · Final

At 300 comparable vCPUs and 70% utilization, the fleet delivers 5,040 useful vCPU-hours per day. The 4×10¹⁵ route’s 60,285-hour estimate takes **12.0 days**. The 10¹⁶ route’s 101,966-hour estimate takes **20.2 days**, with supplied scenarios spanning **10.3–140.1 days**. These are compute durations. The scenarios lack probabilities, so they do not establish a 90% interval for compute or proof completion.

If all 300 vCPUs are billed throughout, the $10,000 cap allows at most **$0.1161 per billed vCPU-hour** for the first point estimate, **$0.06865** for the second, and **$0.00992** for the 706,000-hour scenario, before other charges. The 2.51×10¹⁵ Dudek parameter alone does not determine a runtime estimate.

## 22:17:59 UTC · Final

The local HOL benchmark already measures full-height count arithmetic for four characters at conductor 10,000. It projects 9,100–70,600 core-hours for selected small-family stages depending on whether process overhead is amortized. Those scenarios exclude large-family repairs, analytic theorem joins, and some sign production. At conductor 10,004, a native midpoint scan found 13 hidden pairs in 15 full-character grid intervals. A full-height closure for an inverse pair above the algorithm switch, including its auxiliary strip and a proof connecting computed signs to the final count, would directly test the missing stage. [Full-height benchmark](../../../work/backend-costs-20261112/hol-platt/full-height-count/README.md) · [Midpoint scan](../../../work/backend-costs-20261112/hol-platt/c10004-grid-repair/README.md)

## 22:20:15 UTC · Final

The closest source declaration is `theta_schoenfeld_large`. It proves the required log-squared bound for \(x\ge10^{11}\), conditional on RH and three additional zeta-zero estimates, `HSWN70 gZ`, `HSWHead14 gZ`, and `Ordinates14 gZ`. I found no discharge of those three premises for the actual zeta zeros in the inspected entry. I verified the source signatures, without building the upstream module on the public toolchain. [Schoenfeld declaration](../../../work/goldbach-lean/entries/goldbachintervalsrh445/LeanLab/PNTPort/ExplicitPsi1/ThetaSchoenfeldLarge.lean:91)

The source bound’s higher threshold and non-strict inequality both suffice for the \(10^{27}\) reduction. Bertrand handles \(n\le1.5\times10^{16}\). Above that cutoff the lower endpoint exceeds \(5\times10^{15}\), and the checked numerical majorant is strict, so a non-strict Schoenfeld estimate composes with it using `lt_of_le_of_lt`. This removes the need for a separate medium-range theta estimate on this route. [Reduction](../../../work/grh-goldbach-20261120/team/gap27/Gap27.lean:44)

## 22:24:54 UTC · Final

The replay ran locally in Python 3.14. HOL4 proofs of the analytic Turing theorem and of the connection between the stored phase bounds and the actual completed \(L\)-functions remain open.

## 22:27:08 UTC · Final

Stock HOL4 exported `Rumely167Theory.fixed_even_167` and `Rumely167Theory.fixed_odd_167`. They prove that the two stored 167-step rows yield upper bounds strictly below 31,761 and 31,763, respectively, using a per-channel allowance of 3.85174. Holmake exited successfully and reported 0.166 seconds for the theory build. [Theory source](../../../work/backend-costs-20261112/hol-platt/full-height-count/Rumely167Script.sml) · [Kernel export](../../../work/backend-costs-20261112/hol-platt/full-height-count/.hol/objs/Rumely167Theory.dat)

The theorems check arithmetic on the supplied phase, weight and count numerals. Identifying the phase with the integrated Gamma expression, proving the integrated \(S_\chi\) bound, and connecting the stored weights to the analytic zeros remain separate obligations.

## 22:29:30 UTC · Final

Direct 160-bit interval integration verified the actual log-Gamma phase for both conductor-10,000 rows over the 167-step guard. Each integral lies below its stored HOL upper bound by \(1.543074572784381\times10^{-10}\), with enclosure radius below \(6\times10^{-41}\). Both checks took 0.0625 local CPU seconds in total. [Executable check](../../../work/backend-costs-20261112/hol-platt/full-height-count/gamma167_integral.py)

The check ran in FLINT. The HOL4 export proves the downstream rational inequalities. In the pinned HOL4 sources I found real-log series bounds that could support an endpoint calculation, but no complex log-Gamma remainder theorem for the right half-plane. Connecting the paired phase to the analytic zero-count identity and proving the integrated \(S_\chi\) allowance remain open. [Real-log bounds](../../../work/backend-costs-20261112/hol-platt/source-log-real/SourceLogTailScript.sml:181) · [HOL4 inequalities](../../../work/backend-costs-20261112/hol-platt/full-height-count/Rumely167Script.sml)

## 22:35:29 UTC · Final

HOL4 exported the four theorems in `TuringScheduleTheory` in **0.677 seconds**. `conductor_height_domain` covers conductors through 400,000 and guard extensions through 200 height units, given \(p\ge3.14\) and the stated schedule bounds on \(qH\). Taking \(p=\pi\), `schedule_log` gives \(\log(qH/(2\pi))<17.5\). `schedule_allowances` then bounds the Rumely expression by **4.0132** and the moderate expression by **18**, with no per-row logarithm evaluation. [HOL4 source](../../../work/backend-costs-20261112/hol-platt/source-log-real/TuringScheduleScript.sml) · [Kernel export](../../../work/backend-costs-20261112/hol-platt/source-log-real/.hol/objs/TuringScheduleTheory.dat)

The separate analytic theorem relating \(\int S_\chi\) to either allowance remains open.

## 22:45:17 UTC · Final

HOL4 proved that \(B_4(x)\) ranges from \(-1/30\) to \(7/240\) on \([0,1]\), with equality at \(0\) and \(1/2\), respectively. This gives the sharp uniform bound \(\lvert B_4(x)\rvert\le1/30\).

The kernel also exported `scaled_stirling_remainder`. Given the periodic integral domination estimate and the fourth-order remainder decomposition, it proves the scaled error is at most \(1/90\). The analytic connection to \(\log\Gamma\) remains open. The theory built in 0.648 seconds. [HOL4 source](../../../work/backend-costs-20261112/hol-platt/source-log-real/BernoulliPhaseScript.sml) · [Kernel export](../../../work/backend-costs-20261112/hol-platt/source-log-real/.hol/objs/BernoulliPhaseTheory.dat)

## 23:03:03 UTC · Final

HOL4 exported `PhaseMassTheory.improper_mass_bound`. It proves that for every \(y>0\), the finite integrals converge as their real upper endpoint tends to infinity, with
\[
\int_0^\infty \frac{du}{(u^2+y^2)^2}\le \frac1{y^3}.
\]
The proof uses a rational antiderivative whose derivative dominates the integrand. The theory built in 1.4 seconds. [HOL4 source](../../../work/backend-costs-20261112/hol-platt/phase-integral/PhaseMassScript.sml) · [Build log](../../../work/backend-costs-20261112/hol-platt/phase-integral/mass-check.log)

This bound and the checked Bernoulli maximum give the required scaled constant \(1/360+1/120=1/90\), once the periodic-integral identity for normalized \(\log\Gamma\) and its complex norm comparison are supplied.

## 23:06:18 UTC · Finding

gAAAAABrAiPq92JujMkDM9dhdP_N4Zm6maalIQa2d95JJLGUefpIosp4Be4-r00-JFcfVtV8lSuzHon1mAxfk7bIiuJyzMaWDCOtoRY348Ahm8y4Ip192an1dmZnn-rkCDIncznWugnEqxreNmj449dnbX0Yy20mcznxNfnrALcJgMryCiV0sF1dM-VR2jryR1y_xK6ziDRXQKaGHODwdPmKQaf4WvnFWmI8RiVYYJgNhVKy0S95Vfh4SwbylZDob7JPvoo4M709zwuB1v4BzHeOCa1EGor2k2xnfIi9OicoIYhF8yEdacXramTZqoMXrB4gGuIRqmIgtioO338wVFlorVWSj4IQEE-CU_Rug1iyUsKwaApKk-rhWlToINrVr_M3YHOu5r1q5iV2mTCwN-UxNFk49EsZzNqIPl5pLRt0jZKKaU2roXt4YVlpMDDcgsO-VchGOCRFBKqNEMbUXqyArBF_xlNlz1zfKMD2JMKia-dytHJ1Uyi_QsMdvC__MDuR20woMhTvrUOVM36ckHTaiDbkzF0pZ2fJeEQUi2qB8zuY3RNYiOcSvomZALArGc4mPS0tZIcU_mX87CEzhOPqeXCWvEQuAVQFCix_3--Xt3KI_bBU_eTl8YWYQfuXoOhHc_FYan_DXOWQ3nCacwbfi3fqH4AfovJSVex2KQ0GRt6vFVVamuDD6jRDStCEAZzwhEnHXvehBOW0Gzzo9PL7IqFl7fxYtVCD3LKYWjClTCfmldF7lAHurboh3UFkdUxjO5Pw4OGZXrZosGpAnvdM-IPUfWruSaZLRI8xG7o8cSOYLAZdz7sExD4vMfXUpZmAc9elpCCHvEiApqtVYgOg4IFdNGpjpDLWctYLlBB9Rdq9usNYzModdaYa_Wq-6tbFG9AgfrKVHYHjHT7RDHZ5er3qwE0bJjmPt0v1FMmZ73nOB1OYhF39dvlrB3rWKn0de1P8QBTtzCwqI5k13Lb51OxUMpPAQNuOUdXQ5oXquVfgJCcZ8ZK1SS6A4-Q1qJsIk1loLlLrYuU-yehXplf1mhjo4nNFjgCzDqrWtutSgFmLRg_fBMARx-NniGadlDcZtjNvp9ikaZ5d0IAitprmacIW7PROZM34WPbvKbqHmEWfBatop9lsyVjwZ5tzUgmhspIaW7G-scvXuGaDsnOx0PIVKQc0mD9k8_RAisAnusfiLGQyLiofFzEmxPgqmwUnaShBWUKyu2OuRbuT5SJbV5dPrKcaMVaIyZs6b4jey7vLhg9G-e---NKRTru3MiQGrvppe0FNoWkGW7-lDD8yob-Ld2ltVyLpSkdTJQrnSMXH85XViB-YGoZ3mKh6BvTKfFWzutOUiCvtKKYlIg41mbZgTmZOLA==

## 23:08:10 UTC · Final

At 300 comparable vCPUs and 70% utilization, the \(4\times10^{15}\) binary certificate’s **60,285 useful core-hours translate to 12 days of compute**. The estimate extrapolates two workstation blocks. Sustained production, packaging, and the final join have no measured campaign-wide cost. The $10,000 cap requires an average price below **$0.116 per allocated vCPU-hour** before storage and other charges. [Finite reforecast](../../../work/grh-goldbach-20261120/team/finite-cost/reforecast.json)

## 23:16:14 UTC · Final

Stock HOL4 proved that for \(a,u\ge0\) and \(y>0\),
\[
\left|\frac{B_4(\{u\})}{(u+a+iy)^4}\right|
\le \frac{1}{30(u^2+y^2)^2}.
\]
It also proved that whenever the modulus has a gauge integral on \([0,b]\), its value is at most \(1/(30y^3)\). The five theorems exported in **1.5 seconds**. [HOL4 source](../../../work/backend-costs-20261112/hol-platt/phase-bernoulli-kernel/PeriodicKernelScript.sml) · [Build log](../../../work/backend-costs-20261112/hol-platt/phase-bernoulli-kernel/kernel-check.log)

Existence of the periodic-kernel integral and its identification with the normalized log-Gamma remainder remain open.

## 23:26:37 UTC · Final

HOL4 proved continuity of \(B_4(\{u\})\) at every integer and discharged the finite-integrability hypothesis for the actual complex kernel modulus. The exported theorem `periodic_modulus_improper` proves that for every \(h\ge0\) and \(y>0\),
\[
\int_0^\infty \left|\frac{B_4(\{u\})}{(u+h+iy)^4}\right|\,du
\le \frac{1}{30y^3}.
\]
The theory built in **1.8 seconds**. [HOL4 source](../../../work/backend-costs-20261112/hol-platt/phase-bernoulli-kernel/PeriodicMassScript.sml) · [Build log](../../../work/backend-costs-20261112/hol-platt/phase-bernoulli-kernel/periodic-mass-check.log)

The remaining link is the exact Euler–Maclaurin identity for normalized complex \(\log\Gamma\), together with the norm inequality connecting its complex remainder to this modulus integral.
