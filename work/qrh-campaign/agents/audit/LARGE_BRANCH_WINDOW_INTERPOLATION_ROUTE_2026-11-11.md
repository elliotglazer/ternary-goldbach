# A windowed interpolation route for the large branch

2026-11-11. Source and paper research with exact rational scalar checks. No function values, transforms, zeros, prime evaluations, builds, declarations or inventories. This is a conditional mathematical route, pending independent review and formal implementation. It proves no signs and selects no production precision.

The normalization gap has a narrow resolution. Platt section 6 interpolates a Gaussian-windowed version of exactly the endpoint-normalized function used by the historical large-character code. Its proof does not extend the strict-tilt theta-transform theorem of section 5 to eta=1. The remaining printed sample-tail restriction can be replaced by the explicit all-height bound below. A conservative instance has analytic error less than `2^-46+2^-243`, plus the full sample and finite-arithmetic errors.

## 1. Exact source and normalization

Primary source: David Platt, [Numerical computations concerning the GRH](https://arxiv.org/pdf/1305.3087), arXiv:1305.3087v1, section 6, printed pages 11–14. The local PDF `audit/platt_turing_1305_3087.pdf` has SHA256 `8FD109AA21345BC3FEAC4FDE2FAA7DFB51B4EF1FC9A430F643323612A39EF417`; its text has SHA256 `2A2EABBCA321E6B29BC3E0BAE4339245C819B5234C0C4CC222C65E981E84E3E9`. Relevant text lines are 601–617 for the critical-line growth bound, 715–760 for sampling/Weiss, 762–875 for the window and Fourier bound, and 878–915 for the printed sample tail.

Fix a primitive nonprincipal character chi of conductor c and parity a in {0,1}, with the same fixed root phase at every height. Set alpha=(2a+1)/4. The actual real function is

    Y(t)=epsilon_chi (c/pi)^(it/2) Gamma(alpha+it/2)
         exp(pi*t/4) L(1/2+it,chi).

This is Platt's Lambda_chi and the Y_src identified in `LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md`, SHA `96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D`. Its independent review is `zero-sum/REVIEW_LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md`, SHA `F6F38CBFC4237AB0C4AAC978EF1D0157754DFAA461D01FC3D54D921B1FE45D54`.

For target t0>=0 and h>0 define

    W(t)=Y(t) exp(-(t-t0)^2/(2h^2)).

Then W(t0)=Y(t0). Unlike unwindowed Y, this W has rapid real-axis decay. The Gaussian also controls its derivatives, using analytic continuation and polynomial growth on bounded vertical strips. Thus the Fourier transform of W is integrable and of bounded variation; no jump-average issue arises. These analytic facts and the ordinary sampling theorem still need formal proofs. They are the hypotheses of section 6, not conclusions supplied by a numerical receipt. The primitive nonprincipal restriction avoids an L-function pole in the rightward contour shift.

Use Fourier normalization `W_hat(x)=(1/(2pi))*integral W(t) exp(-ixt) dt`, Delta=1/(2B), and sinc(z)=sin(z)/z with sinc(0)=1. The Weiss bound gives

    |Y(t0)-sum_(n in Z) Y(n Delta)
          exp(-(n Delta-t0)^2/(2h^2)) sinc(pi*(n-t0/Delta))|
       <= 4 integral_(2pi B)^infinity |W_hat(x)| dx.       (1)

Reality supplies the symmetric Fourier-tail relation. This is approximate-bandwidth interpolation, not exact finite-band interpolation. Absolute summability of the sample sum follows from the Gaussian and the growth bound below.

## 2. Fourier tail at the endpoint normalization

Let M=5/2-a, so M is 5/2 for even characters and 3/2 for odd characters. Platt lemma 6.4, with lemma 6.5 for t0>=0, proves that the right side of (1) is at most

    T_F = [2 (c/pi)^(M/2) zeta(M+1/2)/(pi M)]
          exp(M^2/(2h^2)-2pi B M) Pbar(t0,h),

    Pbar(t0,h)=h*pi*(t0+h/sqrt(2pi)+1+1/(2sqrt(2))).     (2)

The source proof shifts Re(s)=1/2 to Re(s)=3-a. There the L-series is absolutely convergent and bounded by zeta(3-a); the Gaussian shift contributes exp(M^2/(2h^2)). The Gamma integral becomes the one at real part 3/2 bounded in lemma 6.5. Its estimate includes negative t. The integration of exp(-Mx) supplies 1/M. This reconstructs the factor and normalization of (2).

There is no tilt parameter in (2). In particular this proof does not invoke lemma 5.4, whose delta=(pi/2)(1-|eta|) degenerates at eta=1. The new route uses a target-dependent Gaussian window to restore Fourier decay.

## 3. Explicit omitted-sample bound for all target heights

The printed lemma 6.7 specifies only sufficiently large t0, and lemma 6.6 uses a lattice-center hypothesis. Neither statement alone admits all low-height, off-grid targets. The following elementary replacement avoids both restrictions.

Lemma 5.3 gives

    |L(1/2+it,chi)| <= zeta(9/8)*(c/(2pi))^(5/16)
                            *(3/2+|t|)^(5/16).

Lemma 6.3 bounds the scaled Gamma factor by the maximum of

    2^(1/4)*sqrt(pi)*exp(1/6)*(3/2+max(t,0))^(1/4),
    sqrt(2pi)*exp(pi/8+1/4).

Using pi<4, e<3 and zeta(9/8)<=9, a deliberately coarse consequence for all real t and c>=1 is

    |Y(t)| <= 144*c*(2+|t|).                            (3)

Indeed each Gamma expression is below `16*(3/2+|t|)^(1/4)`, the conductor factor is at most c, and `(3/2+|t|)^(9/16)<=2+|t|`. No RH or zero information is used.

Write t0=(k+theta)Delta, k=floor(t0/Delta), 0<=theta<1. Retain n=k-m,...,k+m, where m is a positive integer. Put z0=m Delta and A=2+t0. Assume

    z0*(A+z0)>=h^2,
    r=(1+Delta/(A+z0))*exp(-(2z0 Delta+Delta^2)/(2h^2))<1.

The function f(z)=(A+z)exp(-z^2/(2h^2)) decreases for z>=z0. Each omitted side has distances at least z0+j Delta, j>=0. This remains true for theta=0 and for every off-grid theta. Moreover `f(z+Delta)/f(z)<=r` there. The triangle inequality, (3), and `|sinc|<=1` therefore give

    T_S <= 288*c*(A+z0)*exp(-z0^2/(2h^2))/(1-r).         (4)

This proof deliberately drops sinc decay. It does not use the grid-center hypothesis of lemma 6.6 or an unspecified height threshold. It is valid at t0=0, provided the required negative samples are supplied correctly.

## 4. A fully specified conservative instance

Choose Delta=5/64, B=32/5, h=1, m=256. For every c<=265800 and 0<=t0<=7000, (2) and (4) imply

    T_F < 2^-46,        T_S < 2^-243.                   (5)

Here is a rational certificate for the coarse constants. The positive Taylor polynomial for exp(7/10) is greater than 2. Also 3<pi<4 and `zeta(2),zeta(3)<=2`. Then Pbar<2^15. For odd parity the prefactor in (2) is below 2^34 and the negative exponent has magnitude greater than `80*(7/10)`, so the bound is below 2^-46. For even parity use `(c/pi)^(5/4)<c^2<2^38`; the prefactor is below 2^53 and the negative exponent exceeds `132*(7/10)`, giving 2^-79.

For (4), z0=20. The polynomial ratio is below 2, and the exponential ratio is below 1/4, hence r<1/2. Also A+z0<2^13, c<2^19 and `exp(-200)<2^-285`. The remaining prefactor is below 2^42, proving the stated sample tail. The companion checks these exact rational inequalities. There is no transcendental numerical evaluation.

These are sufficient enclosures, not optimal error estimates or lower bounds on actual errors. In particular 2^-46 is not automatically small enough for a requested sign. Increasing m alone reduces (4) but leaves (2) unchanged. Improving the Fourier allowance requires a separately checked parameter/contour bound or a different admitted evaluator. The present instance makes no claim to achieve a complete 2^-82 tolerance.

## 5. Samples, guards and finite arithmetic remain charged

For these parameters the kernel is

    K_n=exp(-(n Delta-t0)^2/2)*sinc(pi*(n-t0/Delta)).

With sample centers Yhat_n and radii rY_n, kernel centers Khat_n and radii rK_n, and finite arithmetic error e_acc, the complete interpolation radius is

    r_I=T_F+T_S+e_acc
        +sum_(n=k-m)^(k+m) [(|Khat_n|+rK_n)rY_n
                              +|Yhat_n|rK_n].         (6)

The full L/source/transform/head/scaling and actual amplitude/canonical-phase errors from the complete-error contract enter rY_n once. The sign proxy alone is not a Y sample. A strict sign requires `|Ihat|>r_I`. Direct summation or a proved padded convolution may compute the same finite sum, with their own arithmetic radius. The kernel can be shared for identical Delta,h and fractional offset theta. There are 513 retained samples per direct target; this is a local formula, not a new global cost inventory.

Both guard sides must exist. At t0=0 this includes negative heights through -20. At the largest current extra-node coordinate `424195/64`, even a conservative right guard of `257 Delta` stays below 7000. This proves compatibility with the analytic seed height cap, not that the existing output inventory contains those guards. A missing upper guard must be produced and charged, the target region restricted, or a direct point evaluator used. Targets near 7000 itself likewise need an extended source domain or another admitted treatment.

For inverse-character negative samples, the exact normalization matters. If H_chi(-u)=kappa H_(chi inverse)(u), then

    Y_chi(-u)=kappa*exp(-pi*u/2)*Y_(chi inverse)(u),

with kappa in {+1,-1} fixed by the actual root phases. The positive factor needs a certified enclosure and multiplication error. Copying a positive ordinate of the same character, or copying its radius without rescaling, is invalid. Both channels and zero-height conventions remain those of the complete count contract.

## 6. Relation to strict tilt and direct signs

The reviewed function F_eta satisfies, for alpha=(2a+1)/4,

    F_eta(t)=pi^-alpha*exp(-lambda*t)*Y(t),
    lambda=pi*(1-eta)/4,    -1<eta<1.

This positive diagonal conversion is exact. It permits sign transfer and sample conversion with a new multiplication radius. It does not transfer unchanged sample errors or Fourier tails. For a Gaussian window, completing the square gives the exact identity

    F_eta(t)*exp(-(t-t0)^2/(2h^2))
      =pi^-alpha*exp(-lambda*t0+lambda^2*h^2/2)
          *Y(t)*exp(-(t-(t0-lambda*h^2))^2/(2h^2)).

Thus even this alternative must rebind the window center and all constants. Lemma 6.5 in its printed form requires the shifted center to be nonnegative. A negative shifted center requires another proved bound or direct treatment. This note selects no strict-tilt conversion and credits no savings from it. The endpoint-window route already matches actual Y. Direct sign-proxy evaluations remain an admitted alternative when sample construction or interpolation margins fail, with their own error/cost contract.

## 7. Remaining proof and data obligations

The mathematical handoff is (1)–(6), under the exact primitive-character, source-normalization and parameter hypotheses above. The paper-level lower inputs remain the actual continuation/functional equation, Rademacher critical-line bound, scaled Gamma estimate, the right-contour integral argument and Weiss theorem with its regularity hypotheses. Their formal availability is not established by the scalar receipt.

Production must still construct and check actual Y samples, fixed root phases, positive/negative guards, kernel and arithmetic enclosures, strict signs, and the unchanged canonical Turing integral/count evidence. No interpolation bound proves a sign at a zero, guarantees sufficient brackets or supplies count saturation. No current p112/134/152 case becomes selected merely from this analytic instance.

The companion `large_branch_window_interpolation_20261111.py` checks 23 exact scalar and source-pin assertions and exclusively writes its receipt. It imports no analytic evaluator. Frozen predecessor papers are unchanged. This route resolves the endpoint-normalization admission on paper without claiming full numerical certification.
