# One-character closed-count benchmarks

## The shared gamma integral from two endpoints

For the two-channel Turing count, write \(z=(1+2a)/4+it/2\), let \(q\) be the conductor, and let \(\theta_a(t)=t\log(q/\pi)/2+\Im\log\Gamma(z)\). For \(0<T<H\), define

\[
F(z)=\left((z^2-z)/2+1/12\right)\log z-3z^2/4+z/2.
\]

Then the integral of \(2\theta_a/\pi\) over the window differs from

\[
\frac{2}{\pi}\left(\frac{H^2-T^2}{4}\log(q/\pi)-2\Re(F(z_H)-F(z_T))\right)
\]

by at most \(4(T^{-2}-H^{-2})/(45\pi)\). The principal log is analytic in this right half-plane. Differentiation of \(F\) gives \((z-1/2)\log z-z+1/(12z)\). The omitted constant in the log-Gamma formula is real. The first neglected term has modulus \(1/(360|z|^3)\). The sector factor is at most 4 because \(|\arg z|<\pi/2\). Hence the pointwise remainder is bounded by \(4/(45t^3)\). Integrating it gives the stated error. [NIST DLMF 5.11.1 and remainder bound](https://dlmf.nist.gov/5.11#ii)

At conductor 3, with \(T=61\) and \(H=261\), the saved sign brackets and this endpoint formula give an upper count of 46.784 after rounding upwards to three decimal places. With 46 roots already bracketed, the integer upper and lower counts agree. A second calculation integrated log-Gamma directly with Arb at this window and at two further windows, using both parities across the three cases. All three independent integrals lay strictly inside the endpoint enclosures. [Numerical receipts](phase-ends.json)

For the 7,499 small conductors, the native sweep computed both needed parities at each of the three published positive guard lengths. The lower and upper limits are the exact saved grid ticks multiplied by \(5/64\). The 44,985 enclosures took 0.797 CPU seconds for the arithmetic loop. The largest interval width divided by window length was below \(3.57\cdot 10^{-11}\). The TSV stores integer endpoints scaled by \(2^{32}\). The same formula also supplies 42 parity-specific enclosures for the separate 24 auxiliary-margin examples. This is a native cost for the shared gamma integral. Validating a full channel still requires the Hardy sign brackets, the auxiliary weights and Turing's inequality. The endpoint formula and numerical enclosures still need a HOL4 proof. [All grid enclosures](phase-windows.tsv) · [Reproduction](phase_ends.py)

All three runs used one worker and 96-bit Arb. The first two use the primitive odd real character modulo 3, with values +1 at residue 1 and -1 at residue 2. Both rectangles lie inside its selected height. The complete selected conductor-3 height is much larger. The principal run fulfills the numerical extent of the separately listed RH-through-500 restriction.

## Direct contour through 20

count.py covers the counterclockwise boundary of [-1/2,2] x [-20,20] with 12,368 segments. Arb encloses L(s,chi) over every **whole** segment in a rectangle excluding zero. Each image lies in an open half-plane through the origin, so its continuous argument increment equals the principal argument of the endpoint-value ratio. The sum divided by 2 pi enclosed 8 with radius below 5.84e-24. The primitive nonprincipal L-function is entire. The argument principle thus gives eight interior zeros with multiplicity and no boundary zeros. A quarter-step Hardy grid found positive brackets (8,8.25), (11,11.25), (15.5,15.75), (18.25,18.5). For a real character conjugation gives four negative partners. The Hardy multiplier is nonzero on the line, and the function there is real and continuous. Eight disjoint witnesses exhaust the rectangle count. This includes both closed ordinate boundaries and excludes extra central or multiple zeros. The contour cost 6.30 CPU seconds and the sign grid 0.016 CPU seconds.

## Integrated count through 61

turing.py uses the campaign's ELEMENTARY_TURING_PAPER_ASSEMBLY and the separate closed-count endpoint argument. Set T=61, H=261, h=200. The signed grid (step 1/32) gives 23 positive main brackets and 136 positive auxiliary brackets strictly inside their respective intervals. The real character contributes both ordinates, so K=46 and W=2 sum(H-v)=412619/16 for actual upper bracket endpoints v. The algorithm sums interval enclosures of 2 theta(t)/pi times 1/32 over 6,400 auxiliary cells. It uses theta(t)=t log(3/pi)/2+Im logGamma(3/4+it/2), with the analytic log-Gamma real on the positive axis. The integral A is less than 35000. The older elementary allowance b=42+6.93 log(3H/(2 pi)) is less than 76 per channel. Thus

    C(61) <= (A-W+2b)/200 < (35000-412619/16+152)/200 = 46.8165625 < 47.

Since C(61) is an integer and K=46, this closes the entire two-sided rectangle at 46, counting true multiplicities, conditional on the stated analytic upper-count theorem. The final run spent 3.33 CPU seconds generating signs and 0.078 CPU seconds integrating the phase and checking the comparison. The earlier T=60, H=260, 1/16 grid gave K=44 and U near 46.8. A sign change in the first auxiliary cell had left endpoint exactly T and was excluded by the strict-interior test. That first attempt did not close.

## Principal restriction through 500

principal.py obtains the upper count 269 from FLINT's native arb.zeta_nzeros at the exact positive height 500. Its independent lower count uses 2,001 Hardy evaluations from 0 through 500 with step 1/4. All signs were strict and 269 adjacent pairs changed sign. Conjugation yields 538 zeros across both signs. The standard nonvanishing of zeta on the real segment (0,1) follows from its alternating eta series there. The zero-count call took 0.003 wall seconds, below the CPU timer resolution, and the line samples took 0.344 CPU seconds. The principal campaign target extends to 10^8.

## Evidence and formal obligations

The signs, contour rectangles, winding increments and integrated operands are stored alongside their generators. The native code relies on FLINT's enclosure semantics, Hardy normalization and correct character identification. Importing these results into HOL would require certified analytic evaluation, a real continuous Hardy/function bridge, the contour or integrated count identity with its hypotheses, the two S allowances and the closed-boundary multiplicity argument, as appropriate to the route. The principal shortcut uses FLINT's native count algorithm as a trusted producer. The small-character timings do not calibrate full target heights or conductor-wide failure and repair rates.

## Principal reciprocal head through 1500

principal1500.py independently computes the additional damped-route head. The selected-principal data obligation audit gives the positive-ordinate target N(1500)=1069 and Q1500=sum(1/gamma-1/1500)<1.668 for the alternate damped/shared-strip use. The audit traces the original ordinary-RH comparator to its closed principal height 10^8 without a separate reciprocal-head input.

The exact positive native count was 1069. An independent 1/8-step sign scan found 1069 distinct brackets. Bisection isolated each positive ordinate between strict opposite-sign endpoints with width 1/8192. Equality with the all-zero count proves simplicity and excludes missed or off-line zeros. Every endpoint through 1500 had strict Hardy sign. Conjugation doubles the count to 2138 for 0<|gamma|<=1500. The real strip (0,1) is zero-free by the alternating eta formula. Integer outward rounding of each reciprocal, using the smaller endpoint for its upper bound, gave

    positive raw sum <= 2368335934373/10^12 = 2.368335934373
    Q1500 <= 4967007803119/(3*10^12) < 1.655669267707 < 1.668
    both-sign sum of 1/|gamma| <= 4.736671868746

For the damped both-sign convention, the bound is exactly twice the stated positive Q bound. The run took 5.129 wall and 4.828 CPU seconds. principal1500-brackets.tsv stores dyadic endpoints and signs. The native count and the Hardy evaluation require formal counterparts for kernel credit.

## Function specifications

The Python calls are dirichlet_char(3,2).l(s) for the nonprincipal contour, dirichlet_char(q,label).hardy_z(t) for real-line signs, acb.lgamma() for the continuous log-Gamma on the right half-plane, and arb(T).zeta_nzeros() for the principal count. FLINT documents the Hardy realness and equivalence of its real zeros to critical-line L zeros. Its principal count is a separate analytic primitive, whose own implementation can also use Hardy evaluations and Turing arguments. The lower grids were generated independently of that count. [FLINT L-function evaluation](https://flintlib.org/doc/acb_dirichlet/l-functions.html), [FLINT Hardy functions](https://flintlib.org/doc/acb_dirichlet/index.html), [FLINT zeta counting function](https://flintlib.org/doc/acb_dirichlet/acb_dirichlet_zeta_nzeros.html).

DLMF 25.10.1-2 defines the real Hardy Z for zeta, and section 25.10(i) gives the critical strip and reflection symmetries. DLMF 25.15(i) records entireness for nonprincipal characters and their functional equation. These analytic statements and the explicit campaign integrated-count lemma supply different premises from the enclosures computed here. [DLMF 25.10](https://dlmf.nist.gov/25.10), [DLMF 25.15](https://dlmf.nist.gov/25.15).
