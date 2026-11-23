# A fresh finite-RH theta-error and binary-cutoff frontier

Date: 2026-11-11. Scope: conditional paper proof and exact rational scalar certificate. No zero, prime, zeta, L-function or Bessel values were evaluated. No Lean declaration, build or selected-strategy change is made.

## Result and its limits

Put A=10^16 and X=10^27. For any real Q with 1<=Q<=50, suppose the Riemann hypothesis holds for every nontrivial zeta zero with 0<Im(rho)<=H(Q), including multiplicities, where

    H(Q)=4*10^10*Q.

Subject to the analytic Logan identities and inequalities identified below, the existing height-1500 head certificate and the reviewed analytic zero-count bound imply, for every real A<=x<=X,

    |theta(x)-x| < a(Q)*sqrt(x)*log(x)^2,
    a(Q)=31/1000+2261/(1000*Q).                         (1)

Here theta is the ordinary right-continuous prime sum. This is a new sufficient theta inequality. It does not interpolate Johnston's table or claim his unprinted pi coefficient. The proof does not invoke Johnston Theorem 3.2, Corollary 3.3 or Theorem 4.1, nor Büthe's finite-range Theorem 2. In particular it does not inherit their RH-through-3*10^12 initialization or their finite prime-count patches.

Combined with binary Goldbach through the even B in the table below, (1) replaces the explicit prime ladder through X by a theorem-level Bertrand patch and a theta-difference argument. All original large-N major, minor and nonprime consumers at N>=X remain unchanged. The nonprincipal spectral family is unchanged. The extra principal RH height, completeness proof, and new Logan analytic formalization must be charged against the work removed. No end-to-end saving or preferred choice is established here.

## Analytic interface and source conventions

The primary references are Johnston, [arXiv:2109.02249v2](https://arxiv.org/pdf/2109.02249v2), printed pp. 2-3, and Büthe, [arXiv:1410.7015v4](https://arxiv.org/pdf/1410.7015v4), Proposition 3, together with Büthe, [arXiv:1511.02032v2](https://arxiv.org/pdf/1511.02032v2), Proposition 2, printed p. 4. Johnston's larger-range proof has an additional initialization dependency; the present argument works directly from the local analytic interfaces.

Use the actual entire even Logan function

    ell(z)=(c/sinh(c))*sum_{k>=0}(c^2-(epsilon*z)^2)^k/(2k+1)!.

Thus ell(0)=1. Let lambda=ell(i/2), and w(rho)=ell((rho-1/2)/i)/lambda. The unit-mass kernel convention is eta_c(t)=c*I0(c*sqrt(1-t^2))/(2*sinh(c)) on [-1,1], zero elsewhere, scaled by epsilon. Büthe 2018 writes a differently scaled eta; its corresponding lambda scales too. The normalized smoothing is unchanged, but unnormalized nu constants must not be transported between conventions.

The required analytic interfaces are:

1. The normalized explicit formula for x-psi_(c,epsilon)(x), with the weighted nontrivial-zero sum and an absolute remainder <3. Section 3 below supplies the weakened constant without the historical inverse-square numerical bound.
2. The high and intermediate zero-tail inequalities of Büthe Proposition 3, equivalently Johnston Lemma 2.1. The high exponential is exp(.71*sqrt(c*epsilon)). The original intermediate domain is a*c/epsilon>=1000. Johnston's displayed a*c/e is treated as a typographical error, not as the consumed hypothesis.
3. Johnston Lemma 2.3 at its alpha=0 specialization, with B0=epsilon*x*exp(-epsilon)*I1(c)/(2*sinh(c))>1. Its error is

       exp(2epsilon)*(L+epsilon)*[
         epsilon*x/log(B0)*I1(c)/sinh(c)
         +2.01epsilon*sqrt(x)+.5loglog(2x^2)].          (2)

4. The general I1 inequality in Lemma 2.4 with lower parameter c0=20. We prove its needed finite constant D(20)>.97 below, rather than reuse a printed .98 bound outside its domain.

All four are mathematical proof obligations for the eventual trusted implementation. Their use here is source-faithful, but this report does not implement them. The source inventory in `integration/FINITE_RH_LOGAN_SOURCE_FEASIBILITY_2026-11-11.md` identifies a possible contour starting point and the missing arithmetic/decay joins. The target `BKLNW_app` Real.sqrt/sin expression is zero below its cutoff and is not the entire ell above; its unresolved Fourier assertion is not an input. The existing exponentially decaying GoodSmoothing API also does not directly admit Logan.

## Existing head data replace two historical numerical leaves

Let N(t) count positive-ordinate nontrivial zeros with their analytic orders and closed cutoff. The existing head packet supplies absence of zeros through height 14, N(1500)=1069, and the centered moment

    Q_1500=sum_{0<gamma<=1500} m*(1/gamma-1/1500)<1.668.

It is not the uncentered reciprocal sum. The reviewed analytic count, for t>=1500, is

    N(t)<=g(t)+5log(t)+167/8,
    g(t)=t/(2pi)*(log(t/(2pi))-1).                    (3)

For U>=1500, finite Abel summation gives exactly

    sum_{0<gamma<=U}m/gamma
      =Q_1500+N(U)/U+integral_1500^U N(t)/t^2 dt.

Atoms at both endpoints are included; multiplicities are unrestricted. Write ell_t=log(t/(2pi)). Integrating (3) gives the upper bound

    ell_U^2/(4pi)+1.668-((ell_1500-1)^2+1)/(4pi)
      +(5log(1500)+207/8)/1500-5/U.

The exact script proves ell_1500>5.47 and log(1500)<7.32 using finite rational exponential bounds. With pi<22/7, twice the U-independent excess is <1/10. Conjugation preserves orders. Hence

    sum_{0<|gamma|<=U}m/|gamma|
      < log(U/(2pi))^2/(2pi)+1/10.                  (4)

This avoids a new reciprocal-sum certificate through 5000. N(1500) cancels from (4). The separate companion `RECIPROCAL_HEAD_REUSE` proves a sharper .08, but the scalar proof here uses only its own .1 certificate.

For the explicit-formula constant, the same existing head gives

    sum_{0<|gamma|<=1500}m/gamma^2
      <=(2/14)*(1.668+1069/1500)<.341.

For the tail, integration by parts and (3) give, after dropping the negative boundary term,

    sum_{|gamma|>1500}m/gamma^2
      <=4*integral_1500^infinity (g(t)+5log(t)+167/8)/t^3 dt
      =2log(1500/(2pi))/(1500*pi)
        +(10log(1500)+187/4)/1500^2
      <12/(3*1500)+(80+187/4)/1500^2<.003.

Thus the full inverse-square sum is <1. The count bound makes the upper boundary vanish. In Büthe 2018 Proposition 2's proof, reflection and evenness bound the normalized constant-zero sum by one half of this inverse-square sum. Replace the historical <.025 contribution by <.5. The other terms admit the coarse bounds 2.2, .006 and .008, whose sum with .5 is <3. For example Euler's constant <=1 and log(pi)<1.4 give the first bound; x>=10 gives the .006 bound; epsilon<=10^-4 gives the .008 bound by monotonicity of -epsilon*log(epsilon) and log10<2.5. This proves the needed Theta(3) replacement from the same explicit-formula identity. It does not require Rosser's separate inverse-square .05 certificate. Real nontrivial zeros are excluded by the usual real-axis zeta identity, a retained analytic source fact.

## Uniform parameters and domains

For A<=x<=X set

    L=log x, c=L/2+6, epsilon=L^(5/2)/(Q*sqrt(x)),
    a=sqrt(2/c), t2=sqrt(2c)/epsilon.

The exact scalar script proves 2.3<log10<2.31, hence 36<L<63, log A<37 and log X>62. The function epsilon decreases in L>5. Therefore

    epsilon<37^2*7/(Q*10^8)<=.00009583<10^-4,
    24<c<37.5, c*epsilon<.00375.

In particular every epsilon domain above holds. Also 0<a<1 and t2>6/epsilon>60000, so both the intermediate threshold >=1000 and reciprocal-bound domain hold. The inequality Q*(1/2+6/L)<L^(3/2) proves c/epsilon<sqrt(x).

The logarithmic derivative of c/epsilon as a function of L is

    1/(L+12)+1/2-5/(2L)>0.

Let S=3163*10^10, so sqrt(X)<S. At X, use L>62 and sqrt(L)>39/5 to obtain

    (c/epsilon)/Q
      < (75/2)*S/(62^2*(39/5)) <4*10^10.             (5)

Every low/intermediate zero in the proof is consequently inside H(Q). Zeros above H(Q) are covered only by the unconditional high tail; no RH premise is extended there.

For the Bessel lower bound, its positive defining series gives

    I1(20)>=sum_{n=0}^{40}10^(2n+1)/(n!*(n+1)!).

Since sqrt(10pi)>5.6 and sinh20<exp20/2, D(20)>11.2*I1(20)/exp20. A rational upper Taylor bound on exp1, raised to the twentieth power, and the displayed lower sum prove D(20)>.97. The general Lemma 2.4 then applies at all c>24. No Bessel value routine or numerical monotonicity test was used.

## Error ledger, normalized by sqrt(x)*L^2

All following inequalities hold over the full parameter ranges, not just at sampled endpoints.

For the low zeros |gamma|<=t2, finite RH and the positive kernel give |w(rho)|<=1. Equation (4) therefore applies without an extra smoothing factor. Moreover

    log(t2/(2pi))
      =L/2+log(Q/(2pi))+.5log(1+12/L)-2log L
      <L/2+2.1+.15-7.16=L/2-4.91.

The logarithm is positive since t2>60000. The normalized main part is bounded by

    (1/2-4.91/63)^2/(2*3.14)<.0284.

The additive reciprocal excess costs at most .1/36^2.

For the intermediate range, put z=sqrt(c*(c-2)). Then z<=c-1 and

    cosh(z)/sinh(c)
      <=(exp(-1)+exp(-c))/(1-exp(-2c))
      <(3/8+2^-24)/(1-2^-48)<.38.

Since 1+11c*epsilon<1.05 and log(c/epsilon)<L/2, the normalized intermediate contribution is <1.05*.38/(4*3.14*36)<.0009.

For the high range,

    (x+1)/(sqrt(x)*sinh(c))
      =2exp(-6)*(1+exp(-L))/(1-exp(-2c))<.0051.

The script proves exp6>400. Also .71sqrt(c*epsilon)<.045, so its exponential is <1.05; log(3c)<5. The normalized high contribution is <.16*.0051*1.05*5/(2*36)<.00006.

For (2), the lower Bessel bound and sqrt(pi*(L+12))<3sqrt L give

    B0/sqrt(x)>.97*.99*L^2/(3Q)>1,

so log B0>L/2. The prefactor satisfies

    exp(2epsilon)*(L+epsilon)/L<1.0003.

The first term of (2) is therefore at most

    4.0012/(Q*sqrt(pi))*sqrt(L/(L+12))<2.261/Q.

The remaining desmoothing terms, Theta(3), and the half-Lambda jump from normalized psi to ordinary psi cost less than

    2.01*10^-4*1.0003/36
      +2.5*1.0003/(10^8*36)
      +3/(10^8*36^2)+1/(2*10^8*36)<.000006.         (6)

Here .5loglog(2x^2)<2.5 follows from 2L+log2<127<exp5. At a prime power the normalized-to-ordinary jump is at most L/2. This payment permits use of the ordinary right-continuous theta in the gap argument.

Finally the elementary Chebyshev bound theta(t)<=t*log4 and the finite prime-power identity imply

    psi(x)-theta(x)
      <=log4*sqrt(x)+2L*x^(1/3).

Indeed the number of exponents is at most L/log2, and every exponent >=3 contributes at most log4*x^(1/3). Since 400^6<A, log4<1.387 and L<63, division by sqrt(x) gives <1.387+126/400=1.702<1.71. Its normalized cost is <.00132. This is an elementary producer, not an imported stronger prime-counting estimate. The existing source theta_le bound needs the routine floor extension to real t and the finite prime-power identity in the eventual implementation.

Adding all nonsmoothing entries gives

    .0284+.0009+.00006+.000006+.00132+.1/36^2
      <.030764<.031.

Together with 2.261/Q this proves the conditional statement (1). All strict inequalities are preserved at the closed x and Q endpoints by the displayed rational slack.

## Complete prime-gap and low-range join

Set U=S*63^2=125539470000000000. For even B>=2A with

    2*a(Q)*U < B-4,                                 (7)

and A+B<=n<=X, put x=n-4 and y=n-B. Then A<=y<=x<=X. The function sqrt(t)*log(t)^2 increases for t>=A, so (1) and (7) give theta(x)-theta(y)>0. Hence a prime p satisfies y<p<=x. It is odd, and n-p is even in [4,B]. Binary Goldbach through B therefore gives the desired ternary representation.

For odd n<=B+3, use the prime 3 and binary Goldbach for n-3. For the remaining odd B+3<n<=A+B, Bertrand supplies one prime A<p<2A. Since B>=2A, the even number n-p lies between 6 and B-2. There is no gap at A+B. Existence of this Bertrand prime is enough; no chosen prime value or ladder certificate is required. The cached Mathlib theorem `Nat.exists_prime_lt_and_le_two_mul` supplies A<p<=2A, and p>2 with parity rules out equality. The original small exceptional cases of ternary Goldbach are unchanged.

The following convenient choices satisfy (7). The coefficient and margins are checked by the exact script.

| Q | Principal RH height H | a(Q) | Binary cutoff B |
|---:|---:|---:|---:|
| 1 | 4*10^10 | 2.292 | 6*10^17 |
| 2 | 8*10^10 | 1.1615 | 3*10^17 |
| 4 | 1.6*10^11 | .59625 | 1.5*10^17 |
| 8 | 3.2*10^11 | .313625 | 8*10^16 |
| 16 | 6.4*10^11 | .1723125 | 5*10^16 |
| 32 | 1.28*10^12 | .10165625 | 3*10^16 |
| 48 | 1.92*10^12 | 3749/48000 | 2*10^16 |
| 50 | 2*10^12 | .07622 | 2*10^16 |

These are illustrative rational choices, not optimized. The same theorem permits any real Q in [1,50]; exact binary cutoffs can instead be chosen as `2*max(A,ceil(a(Q)*U+3))`. The separate cost note records that Q=47 already reaches the floor B=2A, so Q=48/50 have no binary-range advantage under this allocation.

## Work comparison and unresolved implementation

The binary interval factors versus 4*10^18 in the displayed rows range from 20/3 to 200. This counts range, not machine work. The explicit prime ladder is omitted from this conditional route, including its generation and certificate checking. In exchange principal RH/completeness rises to heights 4*10^10 through 2*10^12, and the actual Logan kernel, explicit formula, tails and desmoothing inequalities require trusted mathematical implementations. Existing head data and the analytic count proof are reused; neither new height-5000 data nor a historical inverse-square receipt is required.

The original nonprincipal family and all large-N major/minor/nonprime estimates are preserved. The old binary theorem cannot simply be relabeled as a smaller computation: actual generation and aggregation must be restricted to B to realize that saving. Likewise a published high-RH computation is not itself a Lean or MM0 certificate.

The root's cost screen reports millions of core-hours for published RH through 3*10^12 and a much cheaper per-rung figure for the repository's special Proth checker. Those algorithms and hardware differ, so no timing ratio is inferred here. End-to-end comparison must include generation, completeness, certificate representation, Lean elaboration and kernel checking, and MM0 generation and verification. A smaller ladder or binary interval alone does not establish a better total. The new family is a mathematically sufficient option conditional on its named inputs; no preference or throughput forecast is claimed.

## Frozen evidence

Paths below are relative to `work/qrh-campaign/agents` unless stated otherwise.

| Artifact | SHA256 |
|---|---|
| `major-constants/efficiency_johnston_frontier_20261111.py` | `F604ED6FD4B2E48D3809C38358449F1FB4BA8DEFB1C76DAF3461204FE0532FC2` |
| `major-constants/efficiency_johnston_frontier_20261111.json` | `46CF6EF8910874F372BC34D4B34A67F154ED135D02C0FB92512C8765AB9369CE` |
| `moebius/PSI_HEAD_COUNTS_REVIEW_2026-11-11.md` | `0BD2AF981C7F8A201F15597A7EE4C7B9812053C4987231C8EB02E5A6AA8BA491` |
| `mellin/RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md` | `4648E4C454F4344D4F110E878F6CF619F5AC2128CAC91C2658E443FA3D1DF303` |
| `major-constants/RESUME_PSI_ANALYTIC_COUNT_REVIEW_2026-11-11.md` | `82B2A416EAE9E4F16F8147C92776AB7D5063355E3EABE828615281AA64D8C418` |
| `zero-sum/RECIPROCAL_HEAD_REUSE_2026-11-11.md` | `8EC98EEAC527630E0D3F558B63A0CE9897189DA389932FC7B0F536510EA9D27F` |
| `integration/FINITE_RH_LOGAN_SOURCE_FEASIBILITY_2026-11-11.md` | `BAC6EA85A6F9A0B5E3501BA3731C1CA748496AC2C59C20ECBAA7738BE4CE5DC1` |
| `moebius/EFFICIENCY_Q_FRONTIER_SELECTION_2026-11-11.md` | `9905D47D869D8E6C568C7A1EFA7E4C8D5523FE47B4F4167B9E838C363211F64B` |

The cached Mathlib Bertrand file at `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/NumberTheory/Bertrand.lean` has SHA256 `91AED0AE5E324993157982FF06A5EB8002FD7224C2A3FA1B47DB937650CEF9DD`, theorem at line 225. This is a source/API observation, not a target elaboration claim.

The scalar script uses only integers, Fractions, factorials and finite Taylor inequalities with rational geometric remainders. It completed with exit 0. Its receipt proves the listed scalar comparisons conditional on the analytic identities above. It does not certify finite RH, the old external head data inside a proof kernel, or a positive spectral margin.
