# Independent review of the finite spectral moment reduction

Research review, 2026-11-11. No Lean execution, canonical source changes, zero evaluations, or finite spectral certificates were produced. The frozen base-gap interface ledger is unchanged.

## Verdict and reviewed inputs

The proposed conditional implication passes this review: the four stated inputs imply `W35 < 23.913 < 24`. The partial summation signs, cutoff terms, multiplicity weights, and reflection factor are correct. This accepts the reduction, not the truth or formal proof of its four inputs. In particular, the analytic count theorem above 1500 remains a proof task, and all proposed finite zero data remain absent.

Reviewed exact files in `agents/mellin/`:

* `RESUME_PSI_SPECTRAL_LEAF_2026-11-11.md`, SHA256 `66691465A472EC324B15F987854E8BCA2DB0F28951E8304002E4790136963F6B`.
* `resume_psi_spectral_leaf_20261111.py`, SHA256 `EE27337A4AFCC800AF92C678F7E1762A47909ACC9F6084B6CEF6361C1A023C4A`.

Independent replay of the unchanged Python script exited 0. Its upward rational outputs were `23.178844107557`, `9.746110064949`, and `23.91242471927`. These are scalar inequalities, not evaluations of zeta or certified zero counts. The script's geometric exponential remainder, alternating arctangent bounds, interval directions for logarithms, and sign-dependent denominator in the linear term were inspected. Machin's identity and the analytic series estimates still need mathematical or kernel proofs in an implementation.

## Partial summation, including both endpoints

Take the finite positive-ordinate zero measure with actual multiplicities, and `N(t)=sum_{0<gamma<=t} m`. A single atom of mass m contributes to

`N(T)/T - N(a)/a + integral_a^T N(t)/t^2 dt`

as follows: zero if `gamma<=a`, `m/gamma` if `a<gamma<=T`, and zero if `gamma>T`. This proves the claimed identity directly and handles `gamma=a` and `gamma=T` without a convention change. Adding the low sum yields

`sum_{0<gamma<=T} m/gamma = Q_a + N(T)/T + integral_a^T N(t)/t^2 dt`,

where `Q_a=sum_{0<gamma<=a} m*(1/gamma-1/a)`. The negative `N(a)/a` has been absorbed into Q, not discarded.

For the proposed continuous count majorant `F+R`, integration by parts gives

`F(T)/T + integral_a^T F(t)/t^2 dt = F(a)/a + (log^2(T/(2*pi))-log^2(a/(2*pi)))/(4*pi)`.

Similarly, the R contribution is `R(a)/a + integral_a^T R'(t)/t dt`. Since `R'=.137/t+.448/(t*log t)` and a>1, replacing T by infinity and then `1/log t` by `1/log a` gives exactly the displayed upper error term. Both replacements increase the expression. No differentiability of N is required.

With a=1500, Q<=2 and B<9.747 give positive-ordinate reciprocal mass <11.747. Conjugation preserves both multiplicity and the positive/negative height correspondence. The separate closed height-14 exclusion removes real zeros, so the both-sign mass is <23.494. Without that exclusion, doubling positive ordinates would omit possible gamma=0 terms.

## Reflection and the exponential weight

First use `1/|rho|<=1/|gamma|`; this is valid because gamma is nonzero. Reflection of nontrivial zeros preserves multiplicity and the closed condition `|gamma|<=T`. It may reverse the sign of gamma, which does not matter after replacing the denominator by `|gamma|`. Conjugating as well gives a height-preserving version if desired.

Writing b=beta-1/2, the average of the two exponential weights is

`(exp(35*max(b,0))+exp(35*max(-b,0)))/2 = (1+exp(35*|b|))/2`.

Thus `|b|<=.001` gives the claimed multiplier `(1+exp(.035))/2`. Fixed points on the critical line have exact multiplier 1 and retain their full multiplicity. This is an averaging bijection on the finite weighted carrier, not a division of zero multiplicities by two. The final scalar bound is <23.913. The diagnostic wider-strip expression >28 only shows failure of that upper-bound method; it gives no lower bound on actual W35.

## Count theorem provenance and the remaining analytic task

I independently retrieved the original issue OCR using its [Archive download endpoint](https://archive.org/download/sim_american-journal-of-mathematics_1941-01_63_1/sim_american-journal-of-mathematics_1941-01_63_1_djvu.txt). Rosser's pp.223–224 distinguish the low-height proof, which invokes Theorems 17–18 and historical computations, from the branch above A approximately 1467.47747. The latter invokes Backlund's analytic estimates and a limiting-power argument. The OCR confirms this dependency split but corrupts several formulas. I have not reconstructed the analytic estimates or certified their rounded constants. The proposed threshold 1500 is consistent with that split; it is not a completed independent proof of the desired majorant.

The [Hasanalizade–Shen–Wong paper](https://arxiv.org/pdf/2107.06506), Table 1, lists Rosser's upper error constant 2.463 when the main term excludes 7/8; `2.463=1.588+7/8`, consistent with the note's upper majorant. Its proof of Corollary 1.2, p.15, explicitly uses finite-height data via (1.7) below 30,610,046,000. That corollary therefore cannot silently replace the missing analytic proof in this campaign. Increasing .443 to .448 is safe here because log log t is positive.

A precise future analytic contract must bound the full multiplicity count, with no RH assumption, at every real t>=1500. If its proof first treats heights off the zero ordinates or uses half-weight endpoints, obtain the closed count by approaching from above through nonzero heights. Local finiteness and continuity of F+R justify the limit. Applying a half-weight bound directly at a zero ordinate would not justify the current terminal term.

## Finite certificates and source carrier details

Under the separately proved global 7/8 strip and reflection, every nontrivial zero lies between real parts 1/8 and 7/8. Consequently the proposed closed rectangle `[.1,.9] x [-14,14]` covers all low zeros. The right rectangle `[.501,.9] x [-1000000,1000000]`, together with reflection, gives the strict narrow strip `.499<beta<.501`, including candidate zeros at the top and bottom heights. A zero-free boundary plus winding number zero is required; neither is present yet.

The pinned source at commit `23b2d68ca344203d4384e0aff7affa4ec034bef9` defines the correct pole-removed function in `Explicit/ZetaGrowth.lean:17`; `zetaF_one:22` and `differentiable_zetaF:30` support the advertised entire-function carrier. Its value at 1 is 1, so the argument principle does not acquire a spurious zero at the zeta pole.

One implementation detail must be explicit: `Explicit/WeilBridge.lean:87`, `multRectD_eq_mult`, requires `0<Re u<1`, `|Im u|<T`, `|Im u|<T'`, and `1<=T'`. Its cutoffs are strict. For a closed-height moment through one million, use larger auxiliary divisor parameters, such as 1000001, and then filter `|Im u|<=1000000`; do not instantiate the strict hypothesis at the closed cutoff. Multiplicity transport must use these actual analytic orders.

Given the height-14 exclusion, `Q_1500=integral_14^1500 N(t)/t^2 dt`. On each checkpoint interval, monotonicity gives `N(t)<=N(t_j)<=n_j`, hence the proposed upper Riemann sum. Counts at an outward-moved safe height are valid upper bounds for the intended checkpoint. This avoids needing simplicity or a complete list of individual ordinates, but it still requires complete argument-principle counts, including all off-line zeros and multiplicities.

The floating-point 470-cell diagnostic is correctly excluded from the accepted evidence. In particular, evaluating or rounding `F+R` below 1500 is not a substitute for proving those counts, and a narrow interval for an unverified quantity does not prove its center is correct. The note leaves these finite tasks and its argument-principle replay unresolved.

## Handoff

No numerical correction to the conditional W35 bound is needed. Preserve the four-input status, reconstruct the analytic count proof rather than importing historical tables, and make the closed-count and larger-divisor-radius adapters explicit. The finite height gap, head count certificate, and narrow rectangle remain genuine mathematical/computational obligations. This review makes no claim that the provider, spectral certificates, or final psi estimate have been checked by Lean.
