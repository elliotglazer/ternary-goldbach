# Independent review of the large-branch Gaussian interpolation route

2026-11-11. PASS at the conditional source/paper scope, with no correction to the frozen author. The section 6 normalization, contour constants, all-height sample envelope and off-grid tail are consistent. The result is an analytic interpolation allowance plus explicit numerical sample/kernel/arithmetic errors. It proves neither actual signs nor a full 2^-82 numerical tolerance.

Author: `audit/LARGE_BRANCH_WINDOW_INTERPOLATION_ROUTE_2026-11-11.md`, SHA256 `DA67CB3B463FED71B6545CD13DF374B7713924DFA92C44B37E83862FBA4CCE69`. Author script `117F621DFA28E17605D9FDA022FE616C98A1D0091D603196B3D5607A5BD16C2B`; receipt `0DCB23EFB7A5C9ED3B7D2B748557FC623E33F852FF2E71AAB9BFA113EF71E700`. Paths in this review are relative to `work/qrh-campaign/agents`.

I read the pinned primary [Platt paper](https://arxiv.org/pdf/1305.3087), the actual completion/error contract and the finite-U normalization note. I independently reconstructed the contour, sampling normalization, continuum tail argument and rational constants. No author code was imported or executed. No roots, samples, transforms, L-values, prime/zero data, builds or declarations were produced.

## 1. Exact function and primary-source conventions

The primary PDF is `audit/platt_turing_1305_3087.pdf`, SHA256 `8FD109AA21345BC3FEAC4FDE2FAA7DFB51B4EF1FC9A430F643323612A39EF417`; its text is `2A2EABBCA321E6B29BC3E0BAE4339245C819B5234C0C4CC222C65E981E84E3E9`. Printed page 2 defines exactly

    Y(t)=epsilon_chi (c/pi)^(it/2) Gamma(alpha+it/2)
         exp(pi*t/4) L(1/2+it,chi),  alpha=(2a+1)/4.

Its fixed root phase makes Y real at every real height. Printed page 3 uses the continuous Fourier transform `(1/(2pi))*integral f(t) exp(-ixt) dt`. These conventions match the author's equations. This is the endpoint-normalized function used by the historical large-character branch, not the unit-amplitude sign proxy.

Section 6, printed pages 11–14, applies a Gaussian to this Y. Its Lemmas 6.4–6.5 do not invoke section 5's strict-tilt Fourier bound. The latter has a factor depending on `1-|eta|` and cannot be specialized to eta=1. The author's argument avoids that specialization.

The source joins are the complete-error contract `96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D`, its independent review `F6F38CBFC4237AB0C4AAC978EF1D0157754DFAA461D01FC3D54D921B1FE45D54`, and `FINITE_U_HARDY_NORMALIZATION_2026-11-11.md`, `06C9D3BF785BB183339D8EC64BE0B5AAD05331184C35356F575A8C126ADB724E`. Actual Y sample formation must retain all amplitude, canonical-phase, root-phase and arithmetic errors in those interfaces. A box for a sign-equivalent proxy is not a box for Y.

## 2. Regularity and sampling factor

Let chi be primitive and nonprincipal, t0 real and h>0. For fixed c, the ordinary polynomial bounds for L on a bounded vertical strip, together with the uniform Stirling bound for Gamma there, imply polynomial growth of Y on a small complex neighborhood of the real t-axis. The factor exp(pi*t/4) cancels the Gamma decay in the positive direction and only improves decay in the negative direction. For example a fixed strip narrower than 1/4 in imaginary t keeps the Gamma argument strictly in its right half-plane. Cauchy estimates on a smaller strip then bound each real derivative of Y by a polynomial in |t|. Constants may depend on the character, derivative order and strip; no uniform numerical derivative constant is needed for this regularity claim.

Multiplication by `exp(-(t-t0)^2/(2h^2))` makes W and all its derivatives rapidly decreasing. Thus W is Schwartz, its Fourier transform is Schwartz, integrable and of bounded variation, and Fourier inversion has no jump convention issue. This supplies a standard paper proof of the hypotheses stated by the author. Implementing the underlying continuation, strip-growth, Gamma and Cauchy arguments remains a formal obligation. Merely knowing the real-axis bound on Y without derivative or strip control would not by itself establish this regularity.

The factor four can also be checked directly rather than inferred from an unspecified Fourier convention. Put Omega=pi/Delta and periodize the Fourier transform:

    G(x)=sum_k W_hat(x+2k*Omega),  -Omega<=x<=Omega.

Its Fourier coefficients are `Delta*W(n*Delta)/(2pi)` with the negative exponential convention. Integration of G(x)exp(ixt) over this interval therefore gives the infinite sinc interpolant. Subtracting the ordinary inverse transform leaves, outside the central frequency interval, the same Fourier coefficient multiplied by the difference of two unit phases. Hence the absolute error is at most twice the full outside integral. Reality of W gives equal positive and negative tails, yielding precisely

    4*integral_Omega^infinity |W_hat(x)| dx.

Here Omega=2pi B and Delta=1/(2B). Gaussian sample decay makes the sample sum absolutely convergent. This argument and the primary Weiss theorem give the same normalization; no periodicity of Y is asserted.

## 3. Right-contour and Gamma-integral bounds

Set M=5/2-a. Under s=1/2+it, shifting the contour to Re(s)=3-a changes the real part of the Gamma argument to 3/2. The modulus factors are:

    (c/pi)^(M/2),  zeta(M+1/2),  exp(-M*x),
    exp((M^2-(t-t0)^2)/(2h^2)),
    |Gamma((3+it)/2)| exp(pi*t/4).

The factor 2/pi before the double integral comes from four times the Fourier normalization 1/(2pi). Integration in x from 2pi B to infinity supplies exp(-2pi B M)/M. These reproduce equation (2) exactly, including the sign of M, the Gaussian factor and 1/M.

There are no poles crossed: L is entire for the nonprincipal character, and the Gamma argument has positive real part throughout this rightward strip. Fixed-strip growth times the Gaussian makes the horizontal contour pieces tend to zero. The absolute upper integral is finite, so its later interchange is justified. Principal characters would require a separate residue treatment and are not covered by this route.

I checked Lemma 6.5's treatment of negative t. On t>=0, Gamma recurrence and the exact half-line identity bound the scaled Gamma magnitude by `(1+t)*sqrt(2pi)/2`. The truncated Gaussian integral is at most its full integral, and its first moment is at most t0 times that integral plus h^2. On t<0, the Gamma integral representation gives modulus at most Gamma(3/2), while exp(pi*t/4)<=1. For t0>=0 the negative Gaussian half-line mass is at most h*sqrt(2pi)/2. These give exactly

    h*pi*(t0+h/sqrt(2pi)+1+1/(2sqrt(2))).

Thus the nonnegative-center hypothesis is needed here, not merely in a numerical example. The exact strict-tilt conversion in the author shifts the center to t0-lambda*h^2. Its signs and constants are correct, and the note properly refuses to use this same bound for a negative shifted center without another argument.

## 4. All-height growth and off-grid omitted samples

Primary Lemma 5.3, text lines 601–617, gives the critical-line L bound with zeta(9/8), conductor exponent 5/16 and height exponent 5/16. Lemma 6.3 gives the maximum of the two scaled-Gamma expressions recorded in the author. With 3<pi<4, e<3, and the elementary decreasing-series integral bound zeta(9/8)<=9, the first Gamma expression is below `12*(3/2+|t|)^(1/4)` and the second below 9. Both are below the author's `16*(3/2+|t|)^(1/4)`.

Since c>=1, `(c/(2pi))^(5/16)<=c`. Since `3/2+|t|>1`, its power 9/16 is at most the base and hence below 2+|t|. The resulting all-real bound `|Y(t)|<=144c(2+|t|)` is sound, including t=0 and negative t. It uses no RH premise. Lemma 5.3's Rademacher input and the Gamma/Stirling input remain named analytic foundations, rather than outputs of the rational receipt.

For t0=(k+theta)Delta with 0<=theta<1, the first omitted right sample has distance `(m+1-theta)Delta`, and the first omitted left sample has distance `(m+1+theta)Delta`. Each is at least mDelta; each subsequent distance increases by Delta. This proves the two-sided enumeration at every off-grid theta and at theta=0. It does not rely on Lemma 6.6's lattice-center hypothesis.

For A=2+t0 and z>=z0=mDelta, differentiation gives

    f'(z)=exp(-z^2/(2h^2))*(1-z*(A+z)/h^2).

Thus the stated condition makes f nonincreasing. Its consecutive ratio is `(1+Delta/(A+z))*exp(-(2zDelta+Delta^2)/(2h^2))`; both positive factors are nonincreasing in z. The ratio is therefore at most r. The Gaussian geometric bound, the growth envelope and |sinc|<=1 give `288c*f(z0)/(1-r)`. This proves equation (4) on the continuum, including the low-height cases excluded from printed Lemma 6.7's unspecified threshold.

## 5. Exact scalar instance and its limit

I independently checked the instance Delta=5/64, B=32/5, h=1, m=256, c<=265800 and 0<=t0<=7000. A degree-six positive Taylor polynomial proves exp(7/10)>2. No exponential, Gamma, zeta or trigonometric value was evaluated.

The Gamma integral upper bound is below 2^15. For odd parity, the prefactor is below 2^34 and the decay exponent exceeds 80*(7/10), giving 2^-46. For even parity the prefactor is below 2^53 and the decay exponent exceeds 132*(7/10), giving the stronger 2^-79. The source bound c>=1 is sufficient for both conservative conductor-power replacements.

For the omitted samples, z0=20. The polynomial ratio is below 2 and its exponential factor below 1/4, so r<1/2. Also exp(-200)<2^-285, A+z0<2^13 and the complete prefactor is below 2^42. This yields 2^-243. Both tails are uniform on the stated conductor/target range.

The analytic allowance is therefore below 2^-46+2^-243. This is not a 2^-82 allowance. The larger upper bound does not prove the actual Fourier error is large, but it cannot certify the smaller requested tolerance. Increasing m alone does not improve the Fourier term. A sharper admissible Fourier/parameter argument or a different evaluator would be needed before making that precision claim.

## 6. Negative samples, finite errors and actual guards

For u>=0 the unit-normalized Hardy identity gives `H_chi(-u)=kappa H_(chi inverse)(u)`. With the compatible fixed phases one may write kappa=epsilon_chi*epsilon_(chi inverse), which is a real sign; it must be bound to the actual phase choices. Gamma magnitude is even in u. Therefore

    Y_chi(-u)=kappa*exp(-pi*u/2)*Y_(chi inverse)(u).

The positive damping factor and its multiplication radius are required. The inverse channel cannot be replaced by the same complex-character channel. At u=0 the same phase relation governs the central value, with no assertion of central nonvanishing.

For finite sample/kernel centers, the author's error term follows from splitting at the actual kernel times the sample-center error. It retains the cross contribution through `(|Khat|+rK)*rY`; adding `|Yhat|*rK` and accumulation error completes the finite-product bound. The actual sample contract supplies every source, transform, completion, root and canonical-phase error once. A strict sign still needs the final center to exceed this full radius.

There are 513 retained samples for one direct target. At t0=0 the left guard reaches -20. The current largest target 424195/64 plus the conservative 257*Delta equals 6648.125, below 7000. This establishes compatibility with an analytic/source height cap only. It does not add any output to the saved production inventory, certify its value, or pay for the added positive/negative dependencies. Targets near 7000 need a further positive guard or another treatment. Sample construction, cache sharing, stencil/convolution arithmetic, actual dependency union, signs and Turing closure all remain required and unpriced here.

## 7. Independent evidence and retained obligations

Own script `major-constants/review_large_branch_window_interpolation_20261111.py`, SHA256 `6C4500F31E9D385334411D7A783B20464CA75F47168186AF34A85576579B9FE7`; receipt `review_large_branch_window_interpolation_20261111.json`, SHA256 `0D615D8086A270F7E6CACD5A8322AAEB0E0D7B2F49AD5982CF7E6EA73D546D46`. All 53 independent exact assertions pass, including eight pins, both parity bounds, the tail, guards and the formal Gaussian shift sign. Finite checks supplement the general arguments above; they do not establish their continuum hypotheses by sampling.

The remaining formal leaves include the actual continuation/functional equation and strip growth, Rademacher bound, Gamma identities/estimates, contour and Fourier interchanges, and the sampling theorem or the equivalent Schwartz-periodization proof. Numerical production still needs actual Y samples with certified phase and magnitude, new guards, kernels, arithmetic bounds and strict signs. The review approves a source-faithful conditional route and its stated constants, without adopting a numerical implementation, tolerance, zero certificate or cost saving.
