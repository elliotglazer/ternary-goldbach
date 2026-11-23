# Explicit etaU prime coefficient energy

2026-11-11. New paper derivation and exact scalar research. No prime, zero, L-function, transform or numerical integral evaluation, Lean build, declaration or source edit was performed. This is not a completed formal theorem or a proof of the aggregate Wstar target.

## Result and scope

Let U be the actual source `MinorArcs.etaU`, put w(t)=U(t)^2, and define

    V = integral_(0,infinity) w(t) dt,
    J = integral_(0,infinity) w(t) log(t) dt,
    P(y) = (1/y) sum_(p prime) (log p)^2 w(p/y).

For every real y>=10^25, L=log y, the following paper implications hold from the principal theta and prime-power bounds specified below:

    |P(y) - V L - J| <= 52*10^-6 V (9L+53) + 2*10^-60.       (1)
    49/64 < V < 1.254,       |J| <= 6V,       J < V/2.        (2)

In the prime-support split required by the source large sieve, x=49y and the retained primes satisfy p>sqrt(x)=7sqrt(y). Write

    tlarge(y) = (1/y) sum_(p prime, p>7sqrt(y)) (log p)^2 w(p/y),
    enp(y) = (1/y) sum_(n not prime) Lambda(n)^2 w(n/y),
    esmall(y) = P(y)-tlarge(y)+enp(y).

The actual coefficient bounds are

    0 <= P(y)-tlarge(y) < 10^-50,
    0 <= enp(y) < 2*10^-9,
    0 <= esmall(y) < 2.1*10^-9,                              (3)
    tlarge(y) < 1.254*(1.000468 log(y)+0.502756)+2*10^-60.    (4)

Keeping V and J in (1) is sharper than substituting (4). The error in (1) grows with log y. This note does not call it an O(1) remainder or claim the sharp coefficient asymptotic with an independently established uniform constant. The result supplies a concrete coefficient input to a future weighted sieve. It does not improve the sieve's modulus weights or prove B<=9.

## Exact source inputs and localization

`MajorArcs/Cor933.etaU_eq:49` identifies this smoothing with the positive Mellin mixture

    U(t) = integral_[1/4,1] g(t/r) dmu(r),
    g(v)=v^2 exp(-v^2/2),       dmu(r)=eta2(r)dr/r.           (5)

The source `Helfgott/Defs.phi:49` is this Gaussian function. No etaPlus profile is substituted. `Eta2Moments.moment0:52`, `moment_half:130`, and `moment_one:154` supply

    integral eta2(r)dr=1,
    integral eta2(r)/sqrt(r)dr <=1.37259,
    mu([1/4,1]) <=1.92182<2.

`Prelim/ThetaExplicit.theta_explicit:512` gives, for integers n>=10^12,

    |theta(n)-n| < n/log(n)^3 + epl(n)n,
    0<=epl(n)<=4.92*10^-7.                                 (6)

The latter bound is `epl_le:31`. `Prelim/LambdaMu.sum_vonMangoldt_lt:337` and `sum_vonMangoldt_nonprime_lt:761` give, for real v>0,

    psi(floor v)<1.03883v,
    N(v):=sum_(n<=v, n not prime) Lambda(n)<1.4262sqrt(v).    (7)

These current declarations have a bundled `Fact PlattGRH`. Their relevant analytic path is principal: `ThetaExplicit` uses `psi_two_sided`, `psi_plateau8`, `psi_range1_8`, and `psi_asymp8`; `LambdaMu.psi_bounds:306` and its prime-power assembly use those principal bounds and finite low-range inputs. A principal-only version must retain and localize that path, including the finite psi and nonprime certificates, rather than manufacture the broad Fact from principal RH. Principal RH through 10^8, the associated principal analytic inputs, and the source finite arithmetic inputs remain obligations here. This paper derivation consumes (6)-(7) explicitly; it neither validates their kernel closure nor asserts that existing broad wrappers already have narrower types.

`MajorArcs/Prop715` treats etaPlus squared and its logarithmic moment, using specialized explicit formulas. Its coefficient estimate cannot simply be renamed for etaU. Its elementary `log_ge_1e12:25` is compatible with the logarithm bound used below, but the analytic argument here is fresh partial summation with (5).

## Gaussian mixture moments

Squaring (5) and applying positive Fubini gives a mixture of

    w_rs(t)=r^-2 s^-2 t^4 exp(-C t^2),
    C=(r^-2+s^-2)/2,       1<=C<=16.

For j>-5 write

    I_j(C)=integral_0^infinity t^(4+j)exp(-Ct^2)dt
          =Gamma((5+j)/2)/(2 C^((5+j)/2)).                 (8)

In particular, g0=Gamma(5/2)=3sqrt(pi)/4>1 and I_0=3sqrt(pi)/(8C^(5/2)). Thus the symbolic coefficient is

    V=(3sqrt(pi)/8) integral integral
         r^-2 s^-2 C^-5/2 dmu(r)dmu(s).                   (9)

The log moment J is the same positive-mixture integral with I_0 replaced by the absolutely convergent integral of t^4 exp(-Ct^2)log t. These are actual integrals, not supplied numerical witnesses.

All differentiations and Fubini steps have direct domination. Uniformly on the compact r-support,

    U(t)<=32t^2 exp(-t^2/2),
    |U'(t)|<=(64t+512t^3)exp(-t^2/2),        t>0.

Consequently all weighted derivative and logarithmic integrals below converge; near zero the worst displayed powers are integrable. These bounds also justify the limiting summation-by-parts steps against the linearly growing counting functions.

Minkowski applied to (5), with ||g(t/r)||_2=sqrt(r)||g||_2, gives

    V <= 1.37259^2 * integral g(t)^2dt
      = 1.37259^2 * 3sqrt(pi)/8 <1.254.                   (10)

The last comparison uses pi<22/7 and sqrt(pi)<1.773, checked rationally. Each pair in (8) has I_2/I_0=5/(2C)<=5/2. Jensen for log(t^2) under the probability density w/V therefore gives J/V<=log(5/2)/2<1/2. Absolute integrability follows independently from |log t|<=t+1/t and the bounds I_1/I_0<=2, I_-1/I_0<=4. In particular |J|<=6V, so Jensen does not hide an integrability premise.

For the useful lower bound, integrate the two source pieces of eta2. Their first moments are respectively (log 2)/2-3/16 and 3/4-(log 2)/2, giving integral r eta2(r)dr=9/16. From (5),

    integral U(t)dt=sqrt(pi/2)>5/4,
    integral tU(t)dt=2*(9/16)=9/8.

Here sqrt(pi/2)>5/4 follows from pi>3.14>25/8. The test h(t)=(3-t)_+ on t>=0 has integral h^2=9 and h>=3-t. Hence integral U h>21/8 and Cauchy gives V>(21/8)^2/9=49/64. This is a lower bound on the smoothing norm only, not on actual major-arc B.

## Weighted variation bounds

For every pair, t|w_rs'|<=w_rs(4+2Ct^2). Using (8), then the triangle inequality under the positive mixture, gives

    D0:=integral t|w'| <=9V,
    D1:=integral t|w'||log t| <=52V.                      (11)

For D1 use |log t|<=t+1/t. The normalized pair bound is

    [4(I_1+I_-1)+2C(I_3+I_1)]/I_0
       =(20/sqrt(C)+8sqrt(C))/g0 <=20+32=52.

The prime-power estimate needs the half-weighted counterparts. Since t^-1/2<=1+t^-1, the same calculation gives

    integral sqrt(t)|w'| <=41V,
    integral sqrt(t)|w'||log t| <=136V,
    integral w/sqrt(t) <=5V.                             (12)

For explicit verification, the normalized integrals of t^j(4+2Ct^2) against each pair, for j=1,0,-1,-2, are bounded by 20,9,32,75. The last is (14/3)C<=224/3<75. Expanding (1+t^-1)(t+t^-1) yields their sum 136; the first half-weighted bound uses 9+32=41. These are uniform in both mixture variables and require no sampled Gaussian values.

## Partial summation for prime coefficients

Set A=10^12 and thetaR(v)=theta(floor v). For v>=A, (6), floor error at most 1, and log(floor v)>=27 imply

    |thetaR(v)-v| <=epsilon v,       epsilon=52*10^-6,    (13)

because 1/27^3+4.92*10^-7+10^-12<epsilon. For 0<v<A, positivity and thetaR(v)<=psi(floor v)<2v give |thetaR(v)-v|<=v.

Apply Stieltjes partial summation to f(v)=log(v)w(v/y). It extends continuously by zero at v=0; it and its counting-function boundary products vanish at infinity. The Stieltjes prime measure gives exactly sum_p(log p)^2w(p/y). Subtracting the Lebesgue measure yields the main term y(VL+J). After changing v=yt, its error divided by y is bounded by

    integral_0^infinity t r(yt) |[(L+log t)w(t)]'|dt,
    r(v)=|thetaR(v)-v|/v.                                (14)

There is no omitted endpoint prime. The counting measure includes all prime atoms; all improper integrals can first be taken on finite intervals and then passed to the limit using the stated domination.

The epsilon part in (14) is at most epsilon[V+LD0+D1], which is the first term of (1). For the remaining t<a=A/y<=10^-13, use U<=32t^2 and |U'|<=96t for t<=1/4. Thus w<=1024t^4 and |w'|<=6144t^3. The low-range contribution is at most

    integral_0^a [6144t^4(L-log t)+1024t^4]dt
      =a^5[(6144/5)(L-log a)+11264/25]
      <=a^5[(12288/5)L+11264/25] <2*10^-60.               (15)

For the last step y^-5 log y decreases throughout this range, log(10^25)<75, and the endpoint bracket is less than 200000. Using epsilon everywhere and then adding the entire low contribution overcounts safely; no subtraction of a possibly negative error is used. This proves (1).

## Small primes and prime powers

The elementary w(t)<=1024t^4 gives

    P-tlarge <=1024*7^5*y^(-5/2)*(2+L/2)^2 <10^-50.      (16)

Indeed sum_(n<=z)n^4<=z^5 for z=7sqrt(y), and log z=log 7+L/2<2+L/2. The right side decreases for y>=10^25. At the endpoint use L<75, sqrt(10^25)>10^12, and (2+75/2)^2<1600. This includes a prime exactly at the cutoff, if such an equality occurs.

For prime powers, Lambda(n)^2<=Lambda(n)log n for n>=1. Let N(v) be the nonprime counting function in (7). Partial summation on [1,infinity), whose lower boundary vanishes because log 1=0, gives

    enp <=(1.4262/sqrt(y)) integral sqrt(t)
             [|w'|(L+|log t|)+w/t]dt
        <=1.4262 V (41L+141)/sqrt(y).                    (17)

In this estimate the actual derivative integral starts at 1/y, where L+log t>=0. Extending the nonnegative majorant to all t>0 is legitimate. No prime-power asymptotic or assumed sparse-support density is used. By (10), 1.4262V<1.8. The function (41log y+141)/sqrt(y) decreases throughout y>=10^25. Using sqrt(10^25)>3*10^12 and L<75 gives the strict bound 2*10^-9. Adding (16) proves (3). Equation (4) follows from (1), J<V/2 and the exact coefficients epsilon*9=0.000468 and 1/2+epsilon*53=0.502756.

## Consumption and remaining work

The sequences in this note are the actual coefficients a_y(n)=Lambda(n)U(n/y). The two components have disjoint integer support, so their squared coefficient energies add exactly. The retained component is prime-supported above sqrt(x) for x=49y, as required by the source prime large-sieve comparison. No character, Gauss, coprime-removal or principal-subtraction factor has been altered. Those factors belong to the separate arc-energy argument and must remain there.

Equations (1)-(4) remove the need to posit a favorable etaU coefficient asymptotic merely to obtain a computable uniform upper bound. They do not remove the weighted-sieve obstruction established by other packets, and they do not prove any uncomputed nonprincipal spectral energy. A successful refined sieve still needs its own actual weighted operator inequality and enough numerical reserve.

The remaining proof work is the principal-only localization of (6)-(7), retention or validation of their finite arithmetic and principal analytic inputs, and formal Gaussian-mixture differentiation/integration, Jensen and partial summation. The source has useful ingredients, but no claim is made that this entire new derivation has already been assembled in Lean. Ordinary Gaussian/Gamma/Fubini/finite summation foundations are used mathematically. Compatible kernel validation remains separate.

## Exact receipt and source pins

The companion `eta_u_prime_coefficient_energy_checks_20261111.py` uses only integer arithmetic, Fraction, factorial, file hashes and JSON. Its 32 checks cover the rational endpoint comparisons and elementary exponential-series comparisons. It does not certify the analytic implications by executing them.

Script SHA256: `FAABDFFBB8F70AD1EAD2927C31187FDC13C8A16C24901A83C1A2AD23D739DD91`.

Receipt `eta_u_prime_coefficient_energy_checks_20261111.json` SHA256: `D581F36A158A194EA067C77475FBA576B11F10BA974BDC1F3E5C66DF4C24E8A8`.

Source root is `work/ternary-goldbach/TernaryGoldbach` in the shared workspace. Exact source pins are:

| Relative path | SHA256 |
|---|---|
| MajorArcs/Cor933.lean | 554F00DE4FA6F8F0B6B184F8E8535B8AC5C28C0DB47FA2A95119B6BA4899F66E |
| MajorArcs/Eta2Moments.lean | 3DDC63BE9937E6022B77B80238CC1666A3B122161CC0CFA02081E0E9A2DF0871 |
| MajorArcs/Prop715.lean | CD026A3D01FD8578484E43A48888885C2DC3BF696B2F7ACB89BB525E4E064DF0 |
| Prelim/ThetaExplicit.lean | F30571CFFF146129180D9A1865BAE879027CB5E1F9BCC4B3C8D1912983A45F93 |
| Prelim/LambdaMu.lean | 45A40A3209665061FF2F4F28F7CDDD1C012BCEE66FA90E555859A22D38D8568E |
| Helfgott/Defs.lean | 4CE6EA7FB475024DF403775F9480D7D01B6336A798E0CF254BD61B5AFEC79DC7 |
| Helfgott/Eta2.lean | A2FF833091A7D65D1E02BD24284CCE8C9FCBF6032BD52715CB4DCB055BD850FE |

All frozen predecessor reports are preserved. This is a new research packet, pending independent review.
