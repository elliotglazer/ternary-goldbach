# Independent review: low-zeta refinement of the psi threshold

Bounded source/mathematical review,2026-11-11. No Lean compilation, canonical edit or finite-zero computation. This is not a manifest-bound Lean theorem audit. The subject is a conditional paper implication with separately identified, unproved spectral certificates and analytic implementation obligations.

## Frozen evidence and verdict

Author artifacts read and independently hashed:

* mellin/RESUME_PSI_LOW_ZERO_REFINEMENT_2026-11-11.md:33C01406E927F8F49F329AB52B967AA14B85B64DF7928A034C3028EFEEB91F61.
* mellin/resume_psi_low_zero_refinement_20261111.py:702632F337600C7BC9E1B68DFE6AA2A89967A526F884861093A4BDF2F933D261.
* mellin/resume_psi_low_zero_refinement_20261111.json:AF92F5DDCD6696153DEBCFF945EF0405DF587F53A250AD8A4EE24A178A24D689.

The exact scalar script was independently replayed with Path.write_text disabled, so author-owned JSON was not changed. It exited0. Its reported main allocation is exactly bounded by.009798011781002001<.00981. The alternative one-billion allocation is approximately.009955108733454211, but its extra spectral moment has no certified feasibility.

No mathematical defect was found in the main conditional deduction. Under the stated complete low-zero certificate, shared finite.555 zeta strip through60343058, genuine global7/8 provider and the specified analytic bridges, it yields

    |psiR(x)-x|<.00981*x/log(x) for all real x>=5e9.

This reduces the remaining prime-error gap to[1e9,5e9). It does not close that gap, prove the spectral inputs, or complete the Möbius/Goldbach proof. The lower endpoint1e9 must remain included because the earlier finite sieve is strict below1e9.

## Low-zero contract and multiplicities

The flexible contract is the entire nontrivial-zero set through |gamma|<=1e6, with true multiplicities, beta in[.49,.51], and

    sum m*exp(35*max(beta-.5,0))/|rho|<=24.

The35 is the upper logarithmic x endpoint, not the moment cap. The stricter finite-RH-plus-unweighted-moment24 contract implies this flexible one. Neither contract follows from shared.555 or global7/8.

On22.33<=L=log(x)<=35,

    x^(beta-1)<=x^(-1/2)*exp(35*max(beta-.5,0)).

For beta<.5 the extra factor is1 and x^(beta-.5)<=1. For beta>=.5 use L<=35. This is correct for every phase; no oscillatory cancellation is assumed.

With a=+/- .002/L, b=log(1000/x), and delta=.002/(L*sqrt(L+10)), the exact source numerator exp(a*beta)+exp(b*beta) is bounded by exp(.51|a|)+exp(-.49*(L-7)). The latter uses b<7-L<0 and beta>=.49 with the correct inequality direction. Multiplying by exp(delta^2/2) gives the checked factor<1.002.

Source GaussSmooth.norm_intExp_le' at355 supplies the denominator|rho| and both endpoints; ZetaZeroSums.norm_Mg_strip_le at106 retains the Gaussian factor. Dropping ordinate damping only enlarges the finite low sum. Thus the scaled low error is bounded by24*1.002*L*exp(-L/2), decreasing for L>2. At L=22.33 its checked upper value is.007604484794927989<.00761. Real zeros are not omitted: |rho|>0 follows from beta>=.49 and their reciprocal contributes to the moment normally.

The finite certificate must cover the full low rectangle with multiplicities. Approximate ordinate lists without completeness, simplicity assumptions, or unproved first-zero gaps do not meet the contract. Conjugate-box doubling requires a proved multiplicity correspondence; counting both signs directly avoids that extra shortcut.

## Intermediate and high zeros

The intermediate range is1e6<|gamma|<=60343058. Shared.555 and reflection give beta in[.445,.555]. The previously reviewed translated xi mass gives at most38 zeros per length3 interval, counting multiplicities. It is an unconditional analytic bridge once formalized, not an assumed numerical zero count. Its source entry remains XiPartial.xi_partial_approx at776, with the true-multiplicity and digamma adapters still open.

For bins starting at T=1e6, |rho|>=|gamma|>=T+3k and

    gamma^2>=(T+3k)^2>=T^2+6Tk.

The both-sign sum is therefore bounded by

    (76/T)*exp(-delta^2*T^2/2)/(1-exp(-3delta^2*T)).

There is no omitted or duplicated factor2. Replacing delta by its minimum at L=35 is safe for both decreasing factors. Bounding the endpoints by2.001, L by35, and discarding x^(-.445) gives the checked scaled bound4.282276592646879e-15<1e-12. The endpoint T belongs to the low certificate; bins can be half-open or counted with harmless boundary overlap.

For |gamma|>H the original Gaussian tail has global x^(-1/8), correct zeta BPz2 and source tail counts including both signs. The new delta is at least .001/L^(3/2), since4L>=L+10. This improves Gaussian damping and the geometric inverse denominator. The old small-L proof used only L<=200, so its lower endpoint can be extended to22.33. The source coefficient2.001 remains sufficient for the new a,delta. The replay checks the conservative2e-9 allowance directly; it does not rely on floating underflow.

For L>35 the argument switches to integration/RESUME_PSI_FROM_FINITE_STRIP_2026-11-11.md, which proves the conditional.0081 coefficient for all L>=35. The refinement does not extrapolate its finite weighted moment beyond the range where the exp35 bound was proved. At exp35 both arguments apply, so there is no joining gap.

## Vertical integral

Source PsiExplicit.norm_logDeriv_zeta_left at21 gives

    |zeta'/zeta(-1/2+it)|<=(2/log2+4.8)*(40+2.6|t|).

The existing proof of norm_integral_hZeta_gsm at51 exposes the exact denominator sqrt(1/4+t^2); replacing it by the scalar82.6 is optional. The new direct integral estimate is valid:

    I_delta<=240+80log(1/delta)+2.6sqrt(2pi)/delta.

For the40 part, [-1,1] costs160. The middle1<=|t|<=1/delta costs80log(1/delta). On the tail, substitution u=delta|t| and1/u<=u for u>=1 give a bound<80. The2.6 part uses |t|/sqrt(1/4+t^2)<=1 and the exact Gaussian integral. The split requires0<delta<=1, which the chosen interval satisfies. Each majorant is integrable; this also supplies the domination needed to replace the source bound before integrating.

At Re(s)=-1/2 the lower Mellin endpoint gives exp(-b/2)=sqrt(x/1000). Therefore normalization by x produces x^-1/sqrt1000, not x^-3/2 for that term. The report and checker retain this essential term. The bounds1/delta<120000, log(1/delta)<12, sqrt1000>31 and sqrt(2pi)<2.51 are correctly directed. Absorbing the tiny exponentials and source coefficient into1.34 yields scaled vertical error<.00016, with checked endpoint.00015188677099104537. Both L exp(-L) and L exp(-3L/2) decrease on the range.

This is a new integrated estimate derived from the existing unconditional pointwise bound. It still needs a Lean integral-splitting proof; no better pointwise logarithmic-derivative theorem is assumed.

## Positive desmoothing and domain checks

The report uses both actual PsiLarge sandwich statements, at296 and326. For the upper sandwich K=sqrt(L+10), Kdelta=.002/L and y0=1000. Then y0 exp(Kdelta)<=x,0<delta<=1,delta<=K, b<=-Kdelta, and1-2exp(-K^2/2)>0. These follow with large slack from L>=22.33 and log1000<7. The scalar assertion exp22.33<5e9 makes the chosen L interval cover every real x>=5e9 through exp35.

After normalizing the source error by x, the upper error is

    4000 exp(a0-L)+[exp(delta^2/2+a0)-1+E+2r]/(1-2r),

and the lower error is

    1-exp(-a0)+2000 exp(-L)+E+4r,

where r=exp(-(L+10)/2). These exactly match the source direction and coarse unconditional psiR<=4y input. In particular, the upper4y0 term is not lost in the denominator manipulation.

The proof uses the larger4r and4000 cutoff allowances for both sides. The exact sum of low, intermediate, high, vertical, shift and leakage allowances, multiplied by1.000001 and then adding the cutoff term, is.009798011781002001. This is strictly below.00981 and hence below.01.

The shift monotonicity is justified by its positive power series: after multiplication by L, every term in exp(.002/L+.002^2/(2L^2(L+10)))-1 is a positive sum of nonincreasing inverse powers of L and L+10. The other terms are elementary decreasing L exp(-cL) expressions or are bounded uniformly by the indicated endpoints. Thus the proof covers a continuum, not sampled values.

## Optional W9 and remaining obligations

The optional W9 target uses finite RH through1e6 plus a Gaussian reciprocal moment<=10.8 with scale50000. It is additional to the main contract; it does not follow from the unweighted moment24. Its fixed-delta scalar calculation on20.72<=L<=22.34 passes and would cover[1e9,5e9] if its stronger data were proved. No actual weighted moment was computed, and no feasibility claim is supported. The conservative reviewed route leaves[1e9,5e9) open.

The author correctly avoids using the old RHBelow-H specialized theorem with changed arguments. Formal work must reprove its finite-zero triangle estimate for these three spectral ranges and pass through the common good-height sequence. It must also formalize the true-multiplicity count bridge, weighted reciprocal application, direct vertical integral, global-QRH Gaussian tail and both sandwich adapters. The integer psiR/psiN correspondence must be supplied at the final arithmetic interface. These obligations remain distinct from the unproved finite spectral facts and the finite prime interval.

Final verdict: the threshold.00981 and the five-billion reduction pass this independent bounded review. No numerical certificate of low zeros, prime errors or the final Goldbach theorem has been produced by either the author script or this review.
