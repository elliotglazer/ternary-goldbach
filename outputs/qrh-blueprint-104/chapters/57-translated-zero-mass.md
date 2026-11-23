# Resumed principal-energy research, 2026-11-11

The new analytic ingredient is a translated positive zero-mass bound for the actual zeta function. It improves the source's coarse Jensen window count from150 to45 in the relevant finite range and excludes the clustered countermodel in MAJOR_UPPER_PRINCIPAL.md. Combining it with an actual-smoothing Gram bound gives a concrete route: nonvanishing to the right of2/3 through height40,000,000 would suffice for the broad principal target. That finite nonvanishing statement has NOT been proved or computed here. The strongest explicit density estimate examined without a finite-RH input is too weak to replace it at this threshold.

This is research, not a completed replacement theorem. No Lean builds, canonical edits, new axioms, or sorries were used. The endpoint remains x>=4.9e26. Nothing below uses the local[-4,4] lower-energy result as an upper bound.

## Target and normalization

Use W(delta)=sum_(q in Qset150000) mu(q)^2/phi(q) *1_(|delta|<Dq), where Dq=1200000/qt(q). The earlier chapter proves the exact reduction

    sqrt(Ep)<=||e||_(L2(W))+5e-12,
    e=SsumG 1 (fP delta) x/x-Fourier(etaPlus)(-delta).

W<=13.59756<14, its support is[-600000,600000], and integral W<5000^2. Ep<=1e-4, together with the separate nonprincipal N<=1.23 estimate, supplies J<10. This report addresses only Ep.

The source unconditional explicit formula gives e as a limit of finite zero sums with coefficients m(rho)x^(rho-1), plus a normalized vertical remainder whose weighted norm is<1e-15. Keep the original zerosRectD/multRectD carriers and the common good-height sequence. The low/high split below is uniform in the outer rectangle height, so Fatou and the source pointwise limit are sufficient.

## 1. Actual-zeta translated mass: a new useful analytic lemma

For every real c and every finite set of nontrivial zeta zeros with their true multiplicities,

    sum_rho m(rho) (2-beta)/((2-beta)^2+(gamma-c)^2)
      <= Re(logDeriv xiF (2+ic))
      <= 3+(1/2)log(1+|c|/2).                                (P)

The first inequality follows exactly as the mass-at2 argument, but use xi_partial_approx at2+ic. Its actual statement is uniform on any fixed compact disk. Enlarge the xi square to contain the chosen finite zeros, take real parts, drop omitted positive summands, transport multiplicities through WeilBridge, and let the arbitrary approximation error tend to0. Nonvanishing at real part2 is supplied by the absolutely convergent Euler product, not QRH. The positivity only needs0<beta<1.

For the upper bound, the existing logDeriv_xiF identity and zetaF=(s-1)zeta give

    xi'/xi(s)=1/s+1/(s-1)-log(pi)/2+digamma(s/2)/2+zeta'/zeta(s).

At s=2+ic, the first two real parts total at most1.5, and -log(pi)/2<=0. Also

    |zeta'/zeta(2+ic)|<=sum_(n>=2) Lambda(n)/n^2
       <=sum_(n>=2) log(n)/n^2 <1.

An elementary certificate for the last inequality is

    log2/4+log3/9+integral_3^infinity log(t)/t^2 dt
      < .7/4+1.1/9+(1.1+1)/3 <1.

For v=|c|/2, the digamma series gives

    Re digamma(1+iv)=-EulerGamma+sum_(n>=1) v^2/[n(n^2+v^2)].

The positive summand, viewed as a function of n>0, decreases. Its sum is at most its first value plus its integral from1 to infinity, hence at most

    1+(1/2)log(1+v^2)<=1+log(1+v).

Use EulerGamma>=0. Adding the estimates proves(P). The series is the specialization of [NIST DLMF5.7.6](https://dlmf.nist.gov/5.7.E6). The inspected Mathlib Gamma/Digamma.lean supplies recurrence identities but the needed series theorem was not found by the scoped search; deriving it from the Gamma product or adding its analytic bridge is future formal work. This is a mathematical derivation, not a claimed compiled API.

Unlike the mass.07 at one fixed center, (P) controls coherent clusters at every height. For example, the earlier multiplicity15 quartet at height100 would contribute more than21 to the translated mass at c=100, while (P) is less than5. It is therefore excluded by this actual-zeta information.

## 2. A local count45 through40 million

Assume the genuine global7/8 provider, together with reflection, so1/8<=beta<=7/8. For |gamma-c|<=1.74, put a=2-beta in[9/8,15/8]. Then

    a/(a^2+(gamma-c)^2)>=.26.

Check the concave quadratic a-.26(a^2+1.74^2) at its two endpoints; both values are positive. Thus every interval of length h=3.48 centered at |c|<=40,000,010 has total multiplicity less than45. Indeed log(1+|c|/2)<17, so the count is bounded by

    (3+17/2)/.26<45.                                         (C)

The logarithm comparison follows from2.7^17>20,000,006 and e>2.7. All scalar comparisons are rational except the independently standard e>2.7.

Partitioning[-40,000,000,40,000,000] into such intervals gives a total zero multiplicity bound

    N_low <=45*(2*40,000,000/3.48+2)<1.1e9.                   (N)

These constants are deliberately loose. They use neither a list of low zeros nor simplicity. The all-height version(P) is also available for other finite partitions.

## 3. Actual etaPlus Gram kernel, including off-line real parts

Let h(u)=hH(200,exp u), and retain the source-derived Fourier projection norms

    ||h||_2<2, ||h'||_2^2<=19.5, ||h''||_2<19.2.

They are the same genuine projection/inversion obligations already detailed in MINOR_ENERGY_QRH.md. No compact smoothing replaces etaPlus here.

For real sigma in[-3/4,3/4], set k=sigma+2 in[5/4,11/4], a=2-sigma=4-k, z=exp(2u), and E=exp(k u-z). Then

    M2(sigma+i tau)=mellin(etaPlus^2)(sigma+i tau)
                   =integral h(u)^2 E(u) exp(i tau u)du.

Elementary scalar bounds, uniform in this enlarged sigma range, are

    E<=1, zE<=1, z^2 E<=3,
    |E'|<=5, |a^2 E-E''|<=33.

For z<=1 use k/2>=5/8>0. For z>=1 use k/2<=11/8<3/2 and the maxima of z^(j+3/2)exp(-z); the same rational Taylor checks as in MINOR_ENERGY_QRH.md prove the slack constants1,1,3. The operator identity is

    a^2 E-E''=[16-8k+(4k+4)z-4z^2]E.

Here |16-8k|<=6 and4k+4<=15, giving33. Two integrations by parts, with the Gaussian/logarithmic endpoint domination already described in that chapter, yield

    |M2(sigma+i tau)|<=min(4,428/(25/16+tau^2)).                (G)

The first bound is ||h||_2^2 sup E. For the second, the numerator is bounded by

    2*(19.5+2*19.2)*1+4*2*4.5*5+4*33=427.8<428,

and a>=5/4. This is a new extension of the previous squared-smoothing kernel to negative real parts, not an application of its old nonnegative-sigma theorem outside its domain.

Plancherel in the FULL delta line now supplies the exact off-diagonal identity

    integral F(rho,delta) conjugate(F(rho',delta)) ddelta
       =M2(beta+beta'-1+i(gamma-gamma')).                     (G2)

Since the global strip gives beta+beta'-1 in[-3/4,3/4], (G) applies to every pair. Full-line Plancherel is used only on a finite-height sum; the high-height tail is separately controlled below.

## 4. Multiplicity-safe Schur bound

Expand multiplicities as repeated indices. For a fixed ordinate gamma, split other ordinates into the two distance intervals [jh,(j+1)h] on each side, h=3.48. Every interval has at most45 points counting multiplicity by(C). For j=0,1,2,3 use the bound4; for j>=4 use428/(jh)^2 and sum_(j>=4)1/j^2<=1/3. Thus every row of the absolute Gram matrix has sum at most

    90*[16+428/(3h^2)]=6308120/2523<2600.                    (R)

The same bound holds for columns. The elementary Schur inequality therefore gives, for arbitrary complex coefficients c_rho,

    integral_R |sum_low c_rho F(rho,delta)|^2 ddelta
       <=2600*sum_low |c_rho|^2,

with repeated-index sums, equivalently multiplicity-weighted sums. This argument needs no separation and does not discard a multiplicity factor. With c_rho=x^(rho-1) and W<14,

    ||sum_low m x^(rho-1)F(rho,delta)||_(L2(W))^2
       <=14*2600*sum_low m x^(2beta-2).                      (B)

All phase dependence is handled by this inequality, so the result is uniform for every x in the intended range.

## 5. Quantified finite nonvanishing route, still unproved

The new finite arithmetic/analytic task would be to prove

    zeta(beta+i gamma) !=0 for beta>2/3,
      |gamma|<=40,000,000, beta<=7/8.                         (ZF)

This is weaker than bounded RH and is not currently available as a campaign theorem or certificate. Do not insert it as a new external assumption.

If (ZF) is proved, every low zero has beta<=2/3. Equations(N),(B) give

    low norm^2 <=40,040,000,000,000*x^(-2/3)<.0095^2,

because x>=x0>e^61 and the exact Taylor check gives exp(122/3)>40,040,000,000,000/.0095^2. This remains valid for arbitrarily large x; there is no endpoint-only phase argument.

A possible proof-producing finite certificate is an argument-principle computation for the ENTIRE source zetaF on the rectangle2/3<=Re(s)<=2,0<=Im(s)<=40,000,000, with boundary nonvanishing and winding number0. Precisely, Explicit/ZetaGrowth.lean:17 defines zetaF as Function.update (fun s => (s-1)*riemannZeta s) 1 1, and zetaF_one at line22 proves its value1 at the removable pole. The raw pointwise product at1 must NOT be used for this contour. The pole is removed before counting. The real bottom edge and Re(s)=2 edge have analytic nonvanishing proofs. The other two edges require rigorous function/derivative enclosures, for example through Euler--Maclaurin, and rational replay of the winding computation. Symmetry handles negative heights. This would certify actual zeta information rather than assume a right-edge count or import Platt's result.

No such rectangle computation was run here. A naive quadrature using Euler--Maclaurin with truncation length comparable to height at every sample would be very expensive; neither runtime nor certificate size has been established. A practical implementation would need fast reusable zeta evaluation and a kernel-checkable error theorem. The report does not present(ZF) as a routine completed check.

## 6. Existing actual-smoothing high tail is already sufficient

For all |delta|<=600000, take T0=40,000,000. The source norm_mellin_fP_tail applies because T0>=200+max(10pi|delta|,50). Its prefactor Cg*(2aH)<130. With T'=T0-200, the source definitions give

    EB(T')=.892*T'*exp(-.1598*T')<1e-100,
    EA(T',delta)<=.588*u^2*exp(-.1065*u^2)<5e-19,
    u=T'/(pi|delta|)>=21.2.

At delta=0, EA=0 directly. The decreasing u-tail is justified by u>=21.2. Also

    1/(1-rhoA(delta))<300000,
    1/(1-rhoB)<300000.

For the source tail windows, Z3g(BPz2,T0)<170 and c3g(10,T0)<2e-6. Consequently each geometric count sum is less than

    2*170*300000+2*(2e-6)*300000^2<1.1e8.

Multiplying the transform prefactor shows the entire high-zero coefficient sum, after factoring x^(7/8), is<1e-8. Use the global7/8 bound here, not the source's older coarse x bound. Its normalized weighted norm is therefore

    <5000*1e-8*x^(-1/8)<3e-8.

Together with the low norm, vertical and removal terms,

    sqrt(Ep)<.0095+3e-8+1e-15+5e-12<.01.

The tail calculation is fully independent of(ZF). It uses the actual bandlimit200 and does not apply the source tail theorem below its stated threshold.

## 7. Density comparison: the missing strength is quantitative

Equation(B) also exposes the precise density moment instead of requiring all of(ZF). A sufficient low-height condition, reserving norm.009 for this part, is

    sum_low m x^(2beta-2)<=.009^2/(14*2600).                  (D)

This is a derived research criterion, not a proved density estimate. For a cumulative count N_all(s,T0) of all signs with beta>s, Stieltjes summation bounds its left side by

    N_low*x^(-1)+2 log(x)*integral_(1/2)^(7/8)
                                x^(2s-2)N_all(s,T0)ds.

This handles the critical/left half by its x^(-1) bound. Conjugation gives twice the positive-height count, with any real zeros handled separately; the zeta real-strip nonvanishing proof can remove that extra case.

For orientation, the following are floating diagnostics of the common-beta count allowed by(D) at x0, not necessary conditions on actual zeros:

| common beta | allowed count, all signs, for this sufficient bound |
|---|---:|
|2/3|1.383e9|
|.70|2.299e7|
|.75|49259|
|.80|105.55|
|.825|4.886|
|.85|.2262|
|.875|.01047|

Thus this particular absolute Gram-row method effectively needs a right-edge zero-free region. A few high-beta zeros could still be treated individually with better window geometry or actual phase information, but a loose all-height count cannot be substituted.

The primary-source literature check found a material correction: equation(1.5) of Kadiri--Lumley--Ng reports Ramaré's corrected positive-height estimate

    N_+(sigma,T)<=965*(3T)^(8(1-sigma)/3)*(logT)^(5-2sigma)
                   +51.5*(logT)^2,
    sigma>=.52, T>=2000.

Its footnote explicitly replaces the erroneous4.9 coefficient. Their sharper Theorem1.1 uses finite RH through H0=3.0610046e10; equation(2.1) invokes that input to discard the lower zero count. It cannot be imported as a proof free of the excluded verification. See [Kadiri, Lumley and Ng, Explicit zero density for the Riemann zeta function](https://www.cs.uleth.ca/~kadiri/articles/Explicit-zero-density-for-the-Riemann-zeta-function-JMAA-May2018.pdf), equations(1.5),(2.1).

Evaluating the corrected expression at sigma=.875 gives approximately1.279e7 for T=2000,7.076e8 for T=1e6, and5.222e9 for T=4e7, all positive-height counts. At the last height this is even larger than the source-derived total-count bound1.1e9. These published constants do not close(D); using the uncorrected4.9 would still be vastly too weak here. This is a comparison with the specific estimates inspected, not a claim that no stronger density theorem or method can exist.

## Evidence, interfaces and honest status

resume_principal_20261111_constants.py exited0. Its acceptance assertions use Fraction arithmetic and positive Taylor lower sums only. They check the window constants, Schur sums, all-x reductions, and high-tail budget. The printed density/count tables use ordinary floating arithmetic solely for scale comparisons. The script proves no zero-free statement.

Relevant pinned source interfaces are xi_partial_approx (XiPartial.lean:776), logDeriv_xiF (Xi.lean:142), the Euler-series/logarithmic-derivative identity used by XiMass, multRectD_eq_mult (WeilBridge.lean:87), polyDatum_zeta2 (ZetaPoly.lean:505), count_tail_windowG (ZeroSumGen.lean:121), and norm_mellin_fP_tail (EtaPlusMellin.lean). The original projection norm ingredients are HHFourier.lean and HHFourier2.lean. All were treated as source interfaces, not newly compiled claims.

The completed mathematical progress is(P), the extended actual-smoothing Gram bound(G), the multiplicity-safe row estimate(R), and a quantified finite-height route with a small existing high tail. The unresolved decisive leaf is actual-zeta right-edge information strong enough for(D), for example(ZF). No supplied literature estimate or local numerical certificate currently proves it. Even a completed Ep proof would still leave the separate nonprincipal and cubic major-arc targets.

