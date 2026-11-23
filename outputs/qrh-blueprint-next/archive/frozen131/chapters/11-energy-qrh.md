# Weighted minor-arc energy from QRH: actual squared smoothing

Research status: the derivation below gives a new all-height bound for the actual etaPlus smoothing and a relaxed weighted-energy coefficient below .65. Its analytic interfaces are not implemented or compiled. A small exact-rational script checks the displayed arithmetic, not the analytic statements. The original .640208 coefficient is **not** recovered by this argument. The independent major-constants worker reports that replacing it by .65 is compatible with recomputed minor-arc scalar bounds; that downstream result is a separate obligation.

All source references below are relative to the pinned `work/ternary-goldbach/TernaryGoldbach` tree, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No source file was modified.

## Exact consumer and target

Write L=log x, x>=X0=4.9e26, and

    S(x)=sum_(n>=0) Lambda(n) log(n) etaPlus(n/x)^2.

`MinorArcs.MinorTotal.T_le` (MinorArcs/MinorTotal.lean:216, namespace `TernaryGoldbach.MinorArcs`) currently obtains an existential signed error from `MajorArcs.prop_7_1_5`. Its actual needs are summability of the summand and the upper bound S(x)<=sig(x)*x; the lower error bound is unused. Here `sig` at line70 is

    (.640208+366.91/sqrt x)*log x-.021095.

The prime-restricted sum of squared coefficients is bounded termwise by S(x). A replacement can therefore use a direct upper-energy theorem, together with summability; an upper bound on a bare `tsum` without summability is insufficient.

The present paper argument establishes, conditional only on the global QRH zero strip and the separate positive weighted-mass bound described below,

    S(x) <= (.64621*log x-.021095)*x
         <  (.65*log x-.021095)*x.                    (E)

These are mathematical targets for later statement review, not approved or frozen Lean declarations. No finite-height RH assertion, zero spacing, simplicity, or low-height zero-free gap is used.

## Existing squared-smoothing interfaces

In namespace `TernaryGoldbach.Explicit`, Explicit/EtaPlusSq.lean defines

    phi1(t)=(etaPlus(t)^2 : complex),                  line183
    phi2(t)=(log(t) : complex)*phi1(t),                line185.

`hasDerivAt_mellin_phi1` at line329 identifies the second transform as the derivative of the first. `goodSmoothing_phi1` and `goodSmoothing_phi2` at lines382 and396 are unconditional. `summable_SsumG` at line415 proves absolute summability. Thus the log split already used in MajorArcs/Prop715.lean:299ff gives, with the principal character modulo1,

    S(x)=L*SsumG(1,phi1,x)+SsumG(1,phi2,x),

after casting the real sum to complex. This also proves summability of the real summand; no non-summability contradiction is needed.

The unconditional main-integral theorem `TernaryGoldbach.MajorArcs.integral_etaPlus_sq_log` in MajorArcs/EtaPlusSqLog.lean gives

    I(x)=integral_(t>0) etaPlus(t)^2 log(xt) dt,
    I(x) <= (.640206+1.95e-6)*L-.021095+5.3e-7.         (I)

This public bound already suffices for (E). Its comments advertise a sharper internal error, but the explicit inequalities used in its current proof give the one-sided upper errors .871625e-6*L+.50085e-6 around .640206*L-.021095. Indeed the two cross terms use M0=1000, lambda0=1.6 and M1=60, lambda1=.4, so their bounds must be counted twice. The exact script checks these totals. Do not rely on the comment's .26e-6 coefficient without an additional sharpening.

## Logarithmic Fourier projection: three L2 norms

Let g(u)=hBase(exp u), and h(u)=hH(200,exp u). These are the existing `MajorArcs.gL` and the actual bandlimited smoothing; h is not replaced by g. The Fourier convention is

    Fourier(g)(xi)=integral g(u)*exp(-2*pi*i*xi*u) du.

`hH_eq_fourier` (MajorArcs/HHFourier.lean:272) identifies

    h(u)=integral_(|2*pi*xi|<=200) Fourier(g)(xi)*exp(2*pi*i*xi*u) dxi.

The orthogonal Fourier cutoff therefore contracts each derivative L2 norm. The existing derivative-energy bounds are

    integral |g'|^2 <=19.5,             HHFourier.lean:194,
    integral |g''|^2 <=368,             HHFourier2.lean:195.

Also ||g||_2<2: the explicit derivative `hP'` in Helfgott/HHBound.lean:194 is nonnegative on[0,1] and nonpositive on[1,2]. Hence 0<=hBase<=exp(1/2)<1.65. `Explicit.Cg_le` bounds integral |g| by2.03. Consequently integral |g|^2<1.65*2.03<4. We obtain

    ||h||_2<2,  ||h'||_2<=sqrt19.5<4.5,
    ||h''||_2<=sqrt368<19.2.                           (P)

In products below retain ||h'||_2^2<=19.5 rather than replace it by20.25. Fourier inversion and Plancherel, including the multiplier (2*pi*i*xi)^j, must be proved for this h. They introduce no additional 2*pi factors into (P).

Regularity and boundary terms: the cutoff Fourier density is integrable on a compact interval, and every polynomial multiple of it is integrable. Differentiating under the integral gives bounded continuous h and all its derivatives. The weights below decay exponentially as u tends to minus infinity and faster than exponentially as u tends to plus infinity. Thus F,F',F'',uF,(uF)',(uF)'' are integrable, and the two integration-by-parts boundary terms vanish. This is a concrete route to the needed analytic lemmas; it is not an extra hypothesis to retain in (E).

## Scalar weight bounds, with elementary certificates

Fix 0<=beta<=7/8, set a=2-beta, b=beta+2, z=exp(2u), and

    E(u)=exp(b*u-exp(2u))=z^(b/2)*exp(-z).

Then a>=9/8 and 1<=b/2<=23/16<3/2. For k=0,1,2,3,

    z^k E <= C_k,       (C_0,C_1,C_2,C_3)=(1/2,1,3,10).    (M)

For z<=1 use z^(k+b/2)<=z and z*exp(-z)<=1/e<1/2. For z>=1 use z^(k+b/2)<=z^(k+3/2); the maximum of z^p*exp(-z) is p^p*exp(-p). Squaring reduces (M) to

    exp(2k+3) > (k+3/2)^(2k+3)/C_k^2.

The four right sides are 27/2,3125/32,823543/1152,387420489/51200. The degree30 Taylor lower sums for exp(3),exp(5),exp(7),exp(9) prove all four inequalities by exact rational arithmetic.

The derivative formulas are

    E'=(b-2z)E,
    E''=((b-2z)^2-4z)E,
    a^2 E-E''=[-8beta+(4beta+12)z-4z^2]E=:P E.

They imply

    E<=1/2,  |E'|<=2,  |P E|<=15.5.                    (B)

For E', if z<=b/2 its nonnegative value is <=b E<=23/16<2; otherwise its magnitude is <=2zE<=2. The positive part of P E is <=(4beta+12)zE<=15.5. Its negative part is <=8beta E+4z^2 E<=7/2+12=15.5.

The logarithmic versions needed for phi2 are

    |u|E<=1,  |u||E'|<=7,  |u||P E|<=58.               (LB)

For z>=1 use |u|=(log z)/2<=z/2 and (M); for z<=1 use (-log z)z<=1/e. This gives |u|E<=1 (in fact1/2), |u|zE<=3/2, |u|z^2E<=5. Therefore

    |u||E'| <=3*1+2*(3/2)=6<7,
    |u||P E| <=7*1+15.5*(3/2)+4*5=50.25<58.

These slack constants avoid numerical maximization of the scalar weights.

## All-height Mellin kernels for the actual etaPlus squared

With F(u)=h(u)^2 E(u), logarithmic substitution gives exactly

    mellin(phi1)(beta+i*gamma)=integral F(u) exp(i*gamma*u) du,
    mellin(phi2)(beta+i*gamma)=integral uF(u) exp(i*gamma*u) du.

Twice integrating by parts gives

    (a^2+gamma^2)*M1 = integral (a^2 F-F'') exp(i*gamma*u) du,
    (a^2+gamma^2)*M2 = integral (a^2 uF-(uF)'') exp(i*gamma*u) du.

The first integrand expands as

    a^2 F-F'' = -2((h')^2+h h'')E -4h h'E' +h^2 P E.

By Cauchy–Schwarz, (P), and (B), its L1 norm is at most

    2*(19.5+2*19.2)*(1/2)+4*2*4.5*2+4*15.5
      =191.9 <172*(9/8).

Also ||F'||_1<=2*2*4.5*(1/2)+4*2=17. Since

    a^2 uF-(uF)''=u*(a^2 F-F'')-2F',

(LB) gives its L1 norm at most

    2*(19.5+2*19.2)*1+4*2*4.5*7+4*58+2*17
      =633.8 <566*(9/8).

Define the positive xi weight

    w2(beta+i*gamma)=(2-beta)/((2-beta)^2+gamma^2).

The resulting proposed closed Mellin estimates are

    |mellin(phi1)(beta+i*gamma)| <=172*w2(beta+i*gamma),
    |mellin(phi2)(beta+i*gamma)| <=566*w2(beta+i*gamma)    (K)

for every real gamma and 0<=beta<=7/8. There is no division by gamma, so zero height and clustered zeros cause no special case. These kernels apply to the actual hH200 and retain its Gaussian tails. Neither the local principal 2750-cell computation nor a compact etaO approximation is used.

## Positive zero mass and the explicit formula

Use the exact global provider `OAI.riemannZeta_ne_zero_of_seven_eighths_lt_re` after its independent validation. Only the upper endpoint is needed here: source theorem `zerosRectD_zetaF_strip` gives 0<beta<1, and the provider gives beta<=7/8.

The separate weighted-mass obligation is, for every T>0,

    sum_(rho in zerosRectD zetaF T) multRectD(zetaF,T,rho)*w2(rho)<=.07.

Its proof route is `xi_partial_approx` at2, positivity of omitted weights, `multRectD_eq_mult`, and the numerical derivative bound Re(xiF'/xiF)(2)<=.07. See BLUEPRINT_PRINCIPAL.md P1 and the prime-estimates XiMass work. The .07 is the single-pole mass, not the doubled Phi mass .14. This report does not certify that separate Lean theorem.

Applying (K) termwise, with actual multiplicities, bounds each finite zero sum by172*.07*x^(7/8) or566*.07*x^(7/8). No quartet argument is needed. `explicit_formula_zeta_seq` (Explicit/ZetaExplicit.lean:122) with `goodSmoothing_phi1` or `goodSmoothing_phi2` passes these bounds to the limit. Its zero sum uses the fixed sequence `goodSeqD ldatum_zeta`. The pole term is x*mellin(phi_j)(1). Trivial zeros and zero do not occur in these rectangles, by `zerosRectD_zetaF_strip` and `zetaF_zero_ne_zero`. No extra zero-at-zero residue should be added.

## Vertical remainder and final numbers

Existing unconditional `phi1_vert` and `phi2_vert` (Explicit/EtaPlusSqBound.lean:250,257) give exponential rate1/400 and prefactors

    K1=(Cg*2aH)^2*8*exp(1)<400000,
    K2=2*K1*exp(1/800)<2200000,

using `cA_sq_le` <=16703 and exp(1)<2.7182818286. The second estimate safely uses exp(1/800)<=exp(1). `norm_integral_hZeta_le_gen` bounds the vertical integral by x^(-1/2)*VgL(3,Kj,1/400). The source proof `VgL400_le` gives VgL<=6.6403e6*Kj. Since 2pi>6, the normalized errors are at most

    R1(x)=5e11*x^(-3/2),   R2(x)=3e12*x^(-3/2).

Thus, after dividing the weighted sum by x*L,

    |S(x)-x I(x)|/(x L)
      <=.07*x^(-1/8)*(172+566/L)+R1(x)+R2(x)/L.

For x>=X0, L>=61 and x^(1/8)>2125. The first term is <=38703/6481250<.006. The vertical contribution is <6e11*x^(-3/2)<1e-27. The strict margin in the first term absorbs it, so the whole normalized error is <.006. Every bound decreases as x increases.

Combining this with (I), and 5.3e-7/L<=5.3e-7/61, proves (E):

    .640206+1.95e-6+5.3e-7/61+.006 < .64621 < .65.

The exact script `minor_energy_constants.py` checks all arithmetic above, including exp Taylor lower sums, 2125^8<X0, exp(61)<X0 via the source upper bound on exp(1), kernel numerators, vertical prefactors, and final margin. It uses Python Fraction only. An exit0 is computational arithmetic evidence, not kernel validation of (K) or (E).

## Original coefficient and low-height diagnostics

If .640208 must be retained, the exported main-integral error leaves only approximately4.14e-8 of normalized zero-error allowance at X0; unpacking the one-sided source proof improves this to approximately1.12e-6. The kernels (K) are far too coarse for either. The earlier file `minor_energy_diagnostic.py` is explicitly exploratory NumPy Gauss quadrature for the compact etaO^2 Mellin transform, not an interval certificate. At beta=7/8 it gives a quartet mass-normalized kernel about.837 at height14 and .03155 at height30, corresponding to normalized errors about2.70e-5 and1.02e-6. This shows why a height14 gap alone does not validate the original coefficient under a worst-phase mass argument; it is not an impossibility theorem about actual zeros.

A possible sharper route combines beta<=3/4 below a bounded height with beta<=7/8 above it and sharp actual-smoothing transform bounds. That requires a new verified nonvanishing rectangle and better kernels. Nothing in this report treats such a rectangle as established. The relaxed .65 route avoids this work for the energy consumer.

## Remaining formal work and status

1. Prove the Fourier cutoff's derivative L2 contractions for h, h', h'', and the elementary ||g||2<2 bound from the existing hP derivative sign and Cg bound.
2. Prove the scalar weight inequalities, log-substitution identities, regularity and vanishing boundary terms, and the two integration-by-parts kernel estimates (K). The constants need only small rational/exponential certificates, not a large numerical table.
3. Finish the independently assigned global QRH provider and positive xi mass validation. No result-shaped replacement assumption should remain in the final specialized energy theorem.
4. Apply the already existing unconditional explicit formulas and vertical bounds, prove summability through the phi1/phi2 log split, and specialize the final arithmetic.
5. Replace the minor-energy consumer with coefficient .65 only after the independent minor scalar replay and statement audit approve that changed bound. The original sig is not silently preserved.

Strongest result here: a complete paper derivation of small explicit all-height Mellin kernels for the actual etaPlus squared, reducing the relaxed energy theorem to existing Fourier/explicit-formula ingredients and the separately tracked global QRH/xi-mass inputs. It is research progress, not a claimed Lean proof or a completion of the full10^27 theorem.
