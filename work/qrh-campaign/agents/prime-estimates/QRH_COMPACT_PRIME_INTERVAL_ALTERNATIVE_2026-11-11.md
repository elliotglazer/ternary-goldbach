# A compact positive prime bump with an RH head and QRH tail

Bounded paper alternative, 2026-11-11. This is not the selected strategy, a finite RH certificate, a Lean theorem, or a uniform prime-ladder theorem. The exact scalar checks below concern the interval starting at X=10^27. No prime, zero, zeta, or other analytic-function values were evaluated.

## Verdict and comparison

A compact logarithmic bump gives a sufficient criterion with no uncontrolled physical tails. Under RH through H and global beta<=7/8, the criterion passes at (B,H)=(10^16,6.2*10^12) and (2*10^16,2.95*10^12). The respective normalized upper errors are below .775 and .765. These are not claims of optimal H.

The second candidate is already worse in height than the coordinator's new finite-RH-only H approximately 1.92*10^12 route for B=2*10^16, presently under independent review. That result is not assumed here. The first improves the H=9*10^12 Johnston route reported in the parallel ladder comparison, but no overall cost advantage follows. In particular this bump needs a new polynomial-decay explicit-formula adapter and a kernel-transform proof. Historical principal-RH computation near 3*10^12, reported at roughly 7.5 million core-hours, is a screening warning, not a matched runtime prediction. A few percent reduction in H cannot justify another optimization round without a total-cost comparison against explicit ladders.

## Kernel and exact support

Define I0(z)=sum_(k>=0) (z^2/4)^k/(k!)^2 by its entire series, and

    f_c(t)=c I0(c sqrt(1-t^2))/(2 sinh c),  |t|<=1,
    f_c(t)=0 otherwise.

For c>=4 this is a positive even probability density. Its transform is

    integral exp(zt) f_c(t) dt
      = (c/sinh c) sinh(sqrt(c^2+z^2))/sqrt(c^2+z^2).

The quotient is interpreted by its entire series, so no square-root branch is part of the definition. A direct proof expands both series absolutely on a compact set and uses

    integral_-1^1 t^(2j)(1-t^2)^k dt
      = 2*4^k*k!*(2j)!*(j+k)! / (j!*(2j+2k+1)!).

This polynomial integral follows by integration by parts; the resulting coefficient is 2*binomial(j+k,k)/(2j+2k+1)!, exactly that of the displayed entire transform. Nonnegative series also give I0(c)<=cosh c<=exp c, hence ||f_c||_infinity<2c.

Scale f_c to [-a/2,a/2] and convolve two copies. The result w is continuous, nonnegative, even, supported on [-a,a], has integral 1 and supremum <=4c/a. Put phi(t)=w(log t) for t>0. Its Mellin transform is

    F(s)=[(c/sinh c) sinh(sqrt(c^2+(as/2)^2))
                       /sqrt(c^2+(as/2)^2)]^2.

In particular F(1)>=1. For x=X+B/2 and a=B/(2(X+B)), the support of phi(n/x) lies strictly inside (X,X+B). Use log(1+v)>=v/(1+v) on the right endpoint; the left has still more room. Thus positivity after subtracting prime powers really produces a prime in this interval.

## Closed RH head and unconditional count

All zero sums count true analytic orders. Let N(t) count positive ordinates <=t. Use the previously reviewed analytic bound

    N(t)<=C(t)=t/(2pi)*(log(t/(2pi))-1)+5 log t+167/8, t>=1500.

It is not a computed spectrum or an RH consequence. It gives N(1500)<2000. The underlying nontrivial-zero carrier has 0<beta<1, no real zero, and conjugation preserves orders. Assume finite RH on the closed set |gamma|<=H, and global beta<=7/8 beyond it. No head reciprocal-moment input is required.

Set R=sqrt(8c)/a and

    G(R)=2000+R/(4sqrt(pi))*(log(R/(2pi))-2+2/sqrt(pi))
              +5 log R+167/8.

For R sufficiently large that log(R/(2pi))>=2, Abel summation gives
sum_(gamma>0) m exp(-gamma^2/R^2)<=G(R). To verify the bound, integrate C(t) against 2t exp(-t^2/R^2)/R^2 above 1500, add 2000 for the low part, and discard the negative lower endpoint. After t=Ru, bound log u<=u-1. The replacement polynomial majorants are nonnegative down to u=0 in this range. Use integral u^2 exp(-u^2)=sqrt(pi)/4, integral u^3 exp(-u^2)=1/2, and integral 2u exp(-u^2)=1. The logarithmic term improves by sqrt(pi)/2-1<0 and can be discarded. These are ordinary Gaussian integral identities, not numerical quadrature.

For 0<=u<=c, h(u)=log(sinh(u)/u) satisfies h'(u)>=u/(2c). One elementary proof splits at 1 and 2: sinh u<=4u/3 and u cosh u-sinh u>=u^3/3 on [0,1]; h''>=0 on [1,2]; coth u>=1 above 2. Integration then bounds F(i gamma) by exp(-gamma^2/R^2) while a gamma/2<=c. Above that threshold the sine quotient gives F(i gamma)<=(c/sinh c)^2. The positive probability representation also gives

    |F(1/2+i gamma)-F(i gamma)| <= (a/2) exp(a/2).

Therefore the entire closed head, divided by x, costs at most

    Ehead=2 x^(-1/2) [G(R)+((c/sinh c)^2+(a/2)exp(a/2))*C(H)].

The factor 2 is conjugation, not a second RH hypothesis.

## QRH tail, with an explicit transition guard

Choose d>=1/16 with

    1-(2c/(aH))^2-1/H^2 >= d.

For gamma>=H, |beta|<=1 and z=c^2+(a(beta+i gamma)/2)^2, Re z<=-a^2 gamma^2 d/4. For a square root r of z with nonnegative real part, |r|^2>=a^2 gamma^2 d/4 and Re r<=a/(2sqrt d)<=2a. Consequently

    |F(beta+i gamma)| <= Ktail/gamma^2,
    Ktail=4c^2 exp(4a)/(d a^2 sinh(c)^2).

Indeed |sinh r|^2<=cosh(Re r)^2<=exp(4a). Abel summation, dropping its nonpositive lower boundary term, gives

    sum_(gamma>H) m/gamma^2 <= T2(H),
    T2(H)=log(H/(2pi))/(pi H)+(5 log H+187/8)/H^2.

Thus Etail=2 x^(-1/8) Ktail T2(H). The finite RH region is never extended past H. The same kernel without global QRH replaces x^(-1/8) by 1; the resulting displayed bounds fail badly. This only compares this specific kernel bound, not all finite-RH-only methods.

## Contour remainder: actual source adapter required

Do not feed this kernel to GoodSmoothing: Explicit/ExplicitFormula.lean:51 requires exponential vertical decay, which a nonzero compact logarithmic kernel does not supply. The needed new theorem is a polynomial-decay version of the same finite-left-line explicit formula, not an invented GoodSmoothing instance.

The actual source ingredients are Datum.rect_identityD:89, norm_logDeriv_leftD:198 and good_heightD:258; XiPartial.ldatum_zeta2:99 and HkD_BPz2_le:114; and the formula shape in ZetaExplicit.explicit_formula_zeta_seq:122. The polynomial datum gives good-height horizontal logarithmic derivatives O(log^2 T), while F is O(T^-2) uniformly for -1/2<=Re s<=3/2. Thus the horizontal integrals vanish. Mellin inversion follows for this continuous compactly supported phi with integrable transform; on the right line the absolutely convergent von Mangoldt Dirichlet series permits interchange. The left integrand is absolutely integrable, and the zero series is absolutely convergent by the preceding count bound. These facts justify passage from the finite contour identity to

    sum Lambda(n)phi(n/x) = x F(1)-sum m F(rho)x^rho
       -(1/(2pi))*integral (zeta'/zeta)(-1/2+it) F(-1/2+it)x^(-1/2+it) dt.

No contour is moved to minus infinity and no unproved trivial-zero remainder is used. The source has the finite contour and inversion infrastructure, but its hypotheses must be split and the polynomial adapter proved.

XiPartial.log_BPz2_le':49 and Datum.norm_logDeriv_leftD give

    |(zeta'/zeta)(-1/2+it)| <=401(1+log(1+|t|)).

For details, log(BPz2(t)/.355)<=40+10log(1+|t|), using log22<3.1 and log13.75<2.7; (2/log2+4.8)<8; subtracting the logarithmic derivative of s-1 costs <=2/3. Evenness of w gives |F(-1/2+it)|=|F(1/2+it)|. Hence the normalized left-line error is bounded by

    Eleft <= 802/(2pi x^(3/2)) *
       [exp(a/2) H(1+log(1+H))+Ktail*(3+log H)/H].

The tail integral uses log(1+t)<=1+log t for t>=H>1. The transition guard applies equally to beta=-1/2.

## Prime powers and sufficient inequality

For the two tested intervals, log(X+B)<63 and X+B<2^100. For every k>=2 the number of integer bases in [X^(1/k),(X+B)^(1/k)] is at most B/(k X^(1-1/k))+1. Since Lambda(p^k)=log p<=63/k, summing over all integer bases is a safe overcount. The bounds sum_(k=2)^100 1/k^2<=1 and sum 1/k<=50 give

    Epp <= (4c/a)*63*(B/sqrt X+50)/X.

The sufficient criterion is Ehead+Etail+Eleft+Epp<1. It proves the weighted prime sum positive, not merely a von Mangoldt sum positive.

## Exact scalar receipt and limits

The adjacent Fraction script uses lower Taylor sums for exp and sinh, pi>3.1415, sqrt(pi)>1.772, sqrt(X)>3162*10^10, X^(1/8)>2370, and exp(y)<=1/(1-y) for the tiny positive exponents. The pi inequality can be certified by the already-reviewed Machin interval primitive. All log upper bounds are checked by rational exponential lower sums. Display decimals are not acceptance tests.

| B | H | c | d | Ehead | Etail | total upper |
|---:|---:|---:|---:|---:|---:|---:|
| 10^16 | 6.2*10^12 | 15 | 1/16 | .512962 | .261553 | .774514 |
| 2*10^16 | 2.95*10^12 | 14.2 | .07 | .239041 | .525197 | .764237 |

Prime-power error is below 2.8*10^-10 in both rows; the left-line error is smaller still. The receipt stores both exact fractions. The rows alone do not establish the same criterion on every lower interval: that requires a separate uniformity/patch argument. Nor do they provide RH certificates to either H, validate the global provider, implement the compact transform/contour lemmas, or price proof checking. All of those costs remain, so this is a bounded alternative only.

## Pins

Repository commit 23b2d68ca344203d4384e0aff7affa4ec034bef9. SHA256:

- Explicit/ExplicitFormula.lean: 8CDDDBE6934871CA37260E435BE639A49AC33F4A8D92CBB2E33AB9D330869C35
- Explicit/ZetaExplicit.lean: A2252356B4A2FCE4BC0B2B0EFF9A26B43DFAEBA9B05DB94BFEAA444A423B94E2
- Explicit/XiPartial.lean: 8F47E96329BF7F1CC69F82C3AB5A422087F692BECB74EF70A7908BC323623770
- Explicit/Datum.lean: 42F14B373106D5508F73080BEC1E57992FDCBCB7A0460182AD396534463ACDDE
- mellin/RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md: 4648E4C454F4344D4F110E878F6CF619F5AC2128CAC91C2658E443FA3D1DF303; its review: 82B2A416EAE9E4F16F8147C92776AB7D5063355E3EABE828615281AA64D8C418.
- qrh_compact_prime_bump_scalar_20261111.py: 6CAD36A3FE60B5AE5A14A36331A6836DD12924A5FBB82A6C8B9D5BF6AAEF5C90
- qrh_compact_prime_bump_scalar_20261111.json: D8BF4A9216E2646B363809C44B3020C93E64CE7A74E0CD20B9A36A3540F02B04

Primary comparison sources: Johnston, arXiv:2109.02249; Kadiri--Lumley, arXiv:1407.7902. Their numerical route comparison is owned by the independent-feasibility ladder report, not re-proved here.
