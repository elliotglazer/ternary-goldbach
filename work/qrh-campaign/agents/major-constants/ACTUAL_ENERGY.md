# Actual etaPlus coefficient energy from unconditional source facts

Status: a paper proof assembled from existing source theorems, with explicit new bridge lemmas identified. No Lean compiler was run. The resulting analytic bounds and finite totient statement are not yet kernel-checked as a new theorem. This note introduces no prime-distribution hypothesis and retains the complete Gaussian tail. actual_energy_model.py records the arithmetic and finite factor list; its floating-point output is exploratory.

## Source inputs and thresholds

The pinned Mathlib NumberTheory/Chebyshev.lean supplies, for real z>=1,

    psi(z) <= log(4)*z + 2*sqrt(z)*log(z)                (psi_le, line441),

and for real z>=0,

    psi(z) >= (z-1)*log(2) - log(z+2)                  (psi_ge', line484).

These are unconditional. The definitions agree with the repository's natural/real psi sums after the elementary range/floor conversion. In addition Explicit/PsiSandwich.lean:33,88 proves psi(N)<=4N and psiR(z)<=4z globally for z>=0. No use is made of the Platt-dependent1.03883 bound. Helfgott/Chebyshev.lean:207 only gives1.387N atN>=1e27 and is not sufficient by itself at the startingx=4.9e26.

For the smoothing:

* HHFourier2.lean:195 integral_gL''_sq_le gives integral|g''|^2<=368.
* HHFourier2.lean:217 contains the two exact Fourier derivative identities needed for the weighted identity integral(2*pi*xi)^4|ghat(xi)|^2<=368.
* HHFourier.lean:300 hH_eq_fourier_K identifies hH with the inverse Fourier transform truncated at|2*pi*xi|<=H.
* Mathlib Analysis/Fourier/Inversion provides Continuous.fourierInv_fourier_eq once integrability of ghat is established.
* EtaCirc.lean:18,21,39 gives P0, its derivative P1, and hasDerivAt_P0. Thus etaO is increasing on[0,1], decreasing on[1,2], equals1 at1 and0 at0,2.
* CMain.lean:20 P0_symm proves symmetry about1.
* EtaONum.lean:140 gives m=integral_0^2 etaO^2<=.640205998.
* The explicit multiplicative large sieve is the comparison theorem cited in STRONGEST_AVERAGE.md.

The signs and integral identities below are direct consequences of these source facts, not new analytic assumptions.

## Pointwise Gaussian remainder, with the Fourier normalization checked

Cauchy-Schwarz and the weighted Fourier energy give

    integral_|2*pi*xi|>H |ghat(xi)| dxi
      <= sqrt(368/(3*pi*H^3)),

because integral_|2*pi*xi|>H (2*pi*xi)^(-4) dxi=1/(3*pi*H^3).

The bounded central Fourier interval plus this tail proves ghat integrable. Full Fourier inversion, followed by subtraction of the truncated inversion, then yields

    |hH(200,t)-hBase(t)| <= sqrt(368/(3*pi*200^3)) < .0023  (t>0),

    |etaPlus(t)-etaO(t)| <= .0023*t*exp(-t^2/2)             (t>=0).

The coefficient is about.00220924231; only the safe rational.0023 is used. The rational check .0023^2*3*3.14*200^3>368, with pi>3.14, suffices. The Mellin worker independently confirmed the normalization and the exact source inversion interfaces. This pointwise bridge is new and still needs formalization; the existing L2 approximation of etaPlus by etaO alone would not justify it.

## Compact etaO prime energy

Let x>=4.9e26, ell=log2, L=log(2x), f(t)=etaO(t)^2, and m=integral_0^2 f(t)dt. Its derivative is nonnegative on[0,1] and nonpositive on[1,2]. Symmetry and integration by parts give

    A=integral_0^1 t*f'(t)dt = 1-m/2,
    B=-integral_1^2 t*f'(t)dt = 1+m/2.

Finite summation by parts (equivalently, integrating the step function psi(xt)) gives exactly

    sum_n Lambda(n)*f(n/x) = -integral_0^2 psi(xt)*f'(t)dt.

Use the lower Chebyshev bound on the increasing half and the upper bound on the decreasing half. On the increasing half, the lower-bound error is at most ell+log(x+2); on the decreasing half, the upper-bound error is at most2*sqrt(2x)*L. Since each half has total derivative variation1,

    sum_n Lambda(n)*f(n/x)
      <= x*ell*(1+3m/2) + ell+log(x+2) +2*sqrt(2x)*L.

This is valid for the actual von Mangoldt coefficients, including prime powers. No separate prime-power approximation is needed.

Every nonzero term has n<=2x and Lambda(n)<=log(n)<=L. Therefore

    sum_n Lambda(n)^2*f(n/x)
      <= L*[x*ell*(1+3m/2)+ell+log(x+2)+2*sqrt(2x)*L].

The compact sequence has interval length floor(2x). Put Q=150000 and let ||.||_LS denote the square root of the sum over primitive characters with weightc/phi(c), normalized by1/x. Multiplicative_large_sieve gives, uniformly in the additive twistdelta,

    ||Lambda*etaO||_LS^2
      <= (2+2Q^2/x)*L*[ell*(1+3m/2)
                       +(ell+log(x+2))/x+2*sqrt(2/x)*L]
      <=2.719*L.

For the last numerical inequality, 2*ell*(1+1.5*.640205998)=2.71756530859..., while the remaining terms atx0 are below1e-10 and decrease thereafter. The expressions log(x+2)/x and log(2x)/sqrt(x) are decreasing in this range by elementary differentiation. The safe2.719 leaves ample rounding margin. A formal proof should certify those elementary comparisons rather than import the floating value.

## Complete Gaussian tail using integer blocks

Let d_n=Lambda(n)*(etaPlus(n/x)-etaO(n/x)). Partition ALL n>=1 into blocks

    floor(jx)<n<=floor((j+1)x), j=0,1,2,... .

Their lengths are at mostx+1. Put G0=exp(-1/2), and Gj=j*exp(-j^2/2) forj>=1. On blockj, t*exp(-t^2/2)<=Gj. Global psi<=4z therefore gives

    sum_block |d_n|^2
      <= .0023^2*Gj^2*log((j+1)x)*4*(j+1)*x.

The large sieve and Minkowski inequality imply

    ||d||_LS <=2*.0023*sqrt(1+(1+2Q^2)/x)
                 *sum_(j>=0) Gj*sqrt(j+1)*sqrt(logx+log(j+1)).

This is an infinite convergent sum. Nothing beyond a fixed truncation is discarded.

Using sqrt(a+b)<=sqrt(a)+sqrt(b), it suffices to bound

    S0=sum Gj*sqrt(j+1)<=2.1,
    S1=sum Gj*sqrt(j+1)*sqrt(log(j+1))<=1.4.

Elementary certificates can be used: exp(-.5)<.607, exp(-2)<.136, exp(-4.5)<.0112, exp(-8)<.000336; sqrt2<1.415,sqrt3<1.733; sqrt(log2)<.833,sqrt(log3)<1.049,sqrt(log4)<1.178. Forj>=4 bound both summands by j*(j+1)*exp(-j^2/2), whose successive ratio is<=1.5*exp(-4.5)<1/40. Thus its entire tail is<=20*.000336/(1-1/40). These rational estimates give S0<2.1 andS1<1.4. The elementary exponential/logarithmic inequalities still need ordinary Lean numerical proofs; no numerical integration is needed.

Since logx>61 and (1+2Q^2)/x<1e-15,

    ||d||_LS <= .0105*sqrt(L).

The block partial sums converge to every actual character sum by the source's absolute summability of the Gaussian-smoothed von Mangoldt sequence. There are finitely many characters, so passing to the limit in the squared Hilbert norm is routine. This justifies the complete-tail Minkowski step without assuming an unproved tail estimate.

Combining the compact and Gaussian sequences,

    ||Lambda*etaPlus||_LS
      <= (sqrt(2.719)+.0105)*sqrt(L)
      <1.6595*sqrt(L),

and hence the following concrete theorem is the target of this proof draft:

    sum_(c<=150000) c/phi(c) *sum_(chi primitive mod c)
      |sum_n Lambda(n)*etaPlus(n/x)*chi(n)*exp(2*pi*i*delta*n/x)/x|^2
       <=2.8*log(2x),

for every realdelta and everyx>=4.9e26. It has no prime-distribution premise. Only standard analytic and finite-sum bridges above remain to formalize. This is an actual coefficient-energy estimate, not a conclusion-shaped hypothesis.

## Conductor contribution and the quantitative limit

Insert L_energy=2.8*log(2x) into STRONGEST_AVERAGE.md. ForD>75000, an odd squarefree conductorc>=D has no larger odd multiple<=150000. Thus

    K_D=2/(min_(D<=c<=150000, c odd squarefree) phi(c))^2.

The reproducible integer factor computation gives:

| D | Minimum phi(c) | Attained atc | Resulting Aplus atx0, before coprime correction |
| --- | ---: | ---: | ---: |
| 100000 | 42240 | 102795 | 3.67739e-6 |
| 140000 | 58752 | 140595 | 1.35774e-6 |
| 149000 | 68256 | 149415 | 9.45190e-7 |
| 149900 | 73728 | 149955 | 8.05231e-7 |
| 149990 | 99996 | 149997 | 4.37482e-7 |

The table uses the entire Fourier integration range bound, not quadrature. The finite totient claims are exact integer computations but not yet kernel certificates. actual_energy_results.json includes every factorization in the last100-integer interval, ready to turn into a small finite certificate.

ForD=149900 the exact pre-correction bound is

    Aplus_(c>=149900)
      <= (30547447/2357723136000000)*log(2x).

For induced characters, the primitive/coprime difference is bounded by the same non-coprime prime-power removal used in ArcChars, since character values have modulus<=1. A1% square-splitting loss contributes at most101*1e-30*381.22*13.59756<1e-24. Thus a safe rounded target, including this correction, is

    Aplus_coprime_(c>=149900) <=1.31e-8*log(2x)+1e-24.

This final statement also awaits the finite totient certificate and Lean bridges above. Atx0 it is below8.142e-7. The J<=10 total coprime Aplus budget is9e-7, leaving less than9e-8 for every remaining conductor. This is useful only as a partial range estimate. It does not close the main proof.

The log growth is retained: this bound lies below9e-7 only while log(2x) is below about68.7 (log(2x)<=68 is a safe window). It is not a uniform small constant for allx>=x0. AtD=100000 or140000 it already exceeds the whole budget atx0, so the present large-sieve maximum-weight method cannot cover a broad high-conductor range with these unconditional coefficient estimates. A sharper average over weights, genuine prime cancellation, or a complementary eventual QRH estimate is still required. Cross remains entirely separate.
