# A three-halves zero-ratio bound and its Turing consequence

2026-11-11. Paper/source research and exact rational arithmetic only. No analytic function evaluation, zero computation, Lean declaration, build, or change to a frozen artifact.

The requested paired coefficient 3/2 follows from a stronger unpaired inequality. For every real a>0 and y, define the absolutely integrable log-norm difference

    J(a,y) = integral_0^1 (log|a+iy+t| - log|a+iy-t|) dt.

Then

    0 <= J(a,y) <= (3/2)*a/(a^2+y^2).                 (1)

The proof below uses a six-term polynomial majorant on the real axis and the maximum modulus principle. It does not use a numerical boundary check, an infinite zero product, zero simplicity, or a reflection hypothesis for (1). With the independently reviewed finite-resolvent route and the existing Gamma/Euler ledger, it gives an individual-character Turing allowance b=9 when log(c H/(2pi))<=18 and the integration endpoints exceed 50. That is a paper implication; its source adapters are not new compiled theorems, and no successful auxiliary interval is asserted.

## 1. Why this proof replaces the paired scalar step

Booker's primary preprint, [Artin's conjecture, Turing's method and the Riemann hypothesis](https://arxiv.org/pdf/math/0507502), Lemma 4.3 on printed pages 17-18, states a sharper paired coefficient log4. Its proof sketch reduces to boundary inequalities and explicitly uses a computational verification on Re(w)=1/2, 0<=Im(w)<=2. The published numbering cited by Trudgian is Lemma 4.4. This report neither reuses that computation nor claims to prove the sharper coefficient log4. The weaker coefficient 3/2 has the independent proof below, and suffices for b=9 with the already chosen coarse constants.

The earlier unpaired coefficient 4 is established in `prime-estimates/UNPAIRED_ZERO_RATIO_BOUND_2026-11-11.md`. Its log-integrability and exact real-axis formula are retained. At a real zero of a-t, the intended integrand is the difference of log norms. A totalized quotient is equal only almost everywhere. Assigning any finite value to the exceptional point leaves the integral unchanged.

For y nonzero both logarithms are continuous. For y=0 the possible singularity is an affine real logarithm, including at t=1. It is absolutely integrable. Since |a+iy+t|^2-|a+iy-t|^2=4at, J is nonnegative. The formula

    (1/2) log(1 + 4at/((a-t)^2+y^2))

also proves J(a,y)<=J(a,0), with the same almost-everywhere convention. This comparison holds for every a>0, not just the zero strip.

## 2. A rationally certified real-axis bound

Direct integration gives

    F(a) := J(a,0)
          = (a+1)log(a+1)+(a-1)log|a-1|-2a log a.       (2)

The function v log|v| has its continuous value zero at v=0. Thus F is continuous at a=1 and extends to F(0)=0. For 0<a<1,

    F'(a) = log(1-a^2)-2log a.

For 0<=v<1, integrating the finite geometric lower bound for 1/(1-v) gives

    log(1-v) <= -sum_(k=1)^6 v^k/k.

Integrate the derivative bound from 0 to a. The logarithm at zero is integrable and F(0)=0. This yields

    a F(a) <= P(a^2),
    P(t) = 2t-t log t-sum_(k=1)^6 t^(k+1)/(k(2k+1)). (3)

At t=0 use the continuous extension, and at t=1 use continuity from below. No truncation remainder has been discarded with the wrong sign: every omitted term would decrease the right side.

For 0<t<=1,

    P''(t) = -1/t-sum_(k=1)^6 (k+1)t^(k-1)/(2k+1)
           <= -1.

Set u=7/8. The exact atanh integral gives

    2/15 <= log(8/7)
          = 2 integral_0^(1/15) 1/(1-v^2) dv
          <= (2/15)/(1-1/225) = 15/112.

Substituting only these rational endpoints in P and P' gives

    P(u) <= 40205673181/26990346240 < 191/128,
    0 < 50822861/3373793280 <= P'(u)
      <= 369817499/23616552960 < 1/8.                 (4)

All comparisons in (4) are integer cross-products. Strong concavity, integrated on either side of u, gives

    P(t) <= P(u)+P'(u)(t-u)-(t-u)^2/2
         <= P(u)+P'(u)^2/2
         < 191/128+1/128 = 3/2.

This proves aF(a)<3/2 for 0<a<=1.

For a>=1 and 0<=t<1, integrate the elementary comparison

    a log((a+t)/(a-t))
      = integral_0^t 2a^2/(a^2-v^2) dv
      <= integral_0^t 2/(1-v^2) dv
      = log((1+t)/(1-t)).

The comparison follows from a^2>=1. Integrating in t, including the integrable endpoint by a limit, proves

    aF(a) <= F(1)=2log2 < 3/2.                       (5)

For the last strict inequality, log2=2 integral_0^(1/3) 1/(1-v^2) dv is strictly less than (2/3)/(1-1/9)=3/4, since its integrand is strictly below its endpoint value except on a null set. Equations (3)-(5) prove the real-axis bound for every a>0.

## 3. Extension to all imaginary parts without numerical checks

By symmetry it suffices to treat y>0. In the open first quadrant write z=a+iy and use the principal complex logarithm, which is holomorphic on each of z, z+1 and z-1 there. Define

    Phi(z) = (z+1)Log(z+1)+(z-1)Log(z-1)-2z Log z.

Integrating Log along the two horizontal unit segments proves

    Re Phi(z) = J(a,y).

The constants from the two antiderivatives cancel. Thus

    H(z)=Re(Phi(z)-(3/2)/z)

is harmonic in the quadrant. Here is a direct bounded-domain maximum-modulus proof, so no unproved assertion about an unbounded-domain maximum is needed.

Fix 0<r<1/2<R with R>2 and use the open quarter annulus

    U(r,R)={z: Re z>0, Im z>0, r<|z|<R}.

The function exp(Phi(z)-(3/2)/z) is holomorphic on U and has a continuous extension to its closure. On the negative-real values taken by z-1 at the lower boundary, use the upper boundary value log|z-1|+i*pi. At z=1, the product (z-1)Log(z-1) tends to zero because

    |w Log w| <= |w| (|log|w||+pi) -> 0.

There is no singularity of 1/z on this closure. These observations prove the needed one-sided continuity; global continuity of principal Log across its branch cut is not being asserted.

On the positive real segment, (4)-(5) give H<=0. On the positive imaginary segment, the two log norms in J coincide and Re(1/z)=0, so H=0. On the inner arc, the earlier comparison and (3) with all negative polynomial terms removed give

    H(z) <= J(a,y) <= F(a) <= 2a(1-log a)
         <= 2r(1-log r),

since 0<a<=r<1 and the last function is increasing on (0,1). On the outer arc the triangle and reverse triangle inequalities give, for every 0<=t<=1,

    |(z+t)/(z-t)| <= (R+t)/(R-t) <= (R+1)/(R-1).

Consequently

    H(z) <= J(a,y) <= log((R+1)/(R-1)) <= 2/(R-1).

Let E(r,R)=max(2r(1-log r),2/(R-1)). The norm of the holomorphic exponential on the frontier is at most exp(E). The bounded maximum modulus theorem gives H(z)<=E throughout U. For any fixed point in the quadrant, let r tend to zero and R tend to infinity. Both displayed errors tend to zero, so H<=0. Together with y=0 from section 2, and evenness in y, this proves (1).

This argument uses a standard maximum modulus theorem and elementary log estimates. The only finite scalar certificate is (4); it contains no evaluated logarithm or exponential. It avoids Booker's vertical-boundary computation by proving a slightly weaker but unpaired constant.

## 4. Actual zeros, true-order pairing and finite-resolvent consumption

For an actual primitive nonprincipal character chi, q>1, and parity e, retain the actual completion

    f(s)=q^((s+e)/2) completedLFunction(chi,s).

The reviewed source route `GENERAL_COMPLETED_L_REAL_RESOLVENT_SOURCE_ROUTE` proves at paper level that f is entire, has all zeros in 0<Re(s)<1, and has same-character reflection

    f(1-conj(s))=W_chi*conj(f(s)),  W_chi!=0.           (6)

This is not holomorphic symmetry f(1-s)=f(s) for a nonreal character. Its source construction uses the inverse-character functional equation followed by conjugation. At a zero rho, if f(rho+w)=w^m g(w) with g(0)!=0, (6) gives

    f(1-conj(rho)+w)
       = W_chi*(-1)^m*w^m*conj(g(-conj(w))).

The final factor is holomorphic and nonzero at zero. Hence reflection preserves the actual analytic order m. It fixes critical-line zeros, including a possible central zero, and preserves the ordinate of every zero. It does not require same-character invariance under gamma -> -gamma.

For a reflection-invariant finite carrier with these true weights, a two-point orbit rho=beta+i gamma and 1-conj(rho) has parameters a=3/2-beta and 2-a at y=t-gamma. Applying (1) to both gives the requested paired inequality

    J(a,y)+J(2-a,y)
      <= (3/2)*(a/(a^2+y^2)+(2-a)/((2-a)^2+y^2)).     (7)

Fixed critical-line orbits are counted once with their actual multiplicity and use (1) directly. There is no division by two at a fixed point and no assumption that central multiplicities are even.

In fact no orbit decomposition is needed to consume (1). Every finite carrier with nonnegative true weights satisfies

    sum m_rho J(3/2-Re rho,t-Im rho)
       <= (3/2) sum m_rho Re(1/(3/2+it-rho)).          (8)

For the actual finite approximation (F), choose the complete good-height square carrier containing the compact horizontal segment and its exact analytic orders. Let its real resolvent differ from Re(f'/f) by at most epsilon. The reviewed finite zero-polynomial removal supplies an analytic nonzero remainder and the integrated log-ratio error at most epsilon. Applying (8) therefore gives

    integral_(1/2)^(3/2) (log|f(s)|-log|f(s+1)|) d sigma
       >= -(3/2) Re(f'/f)(3/2+it)-(5/2)epsilon.

Let epsilon tend to zero. All logarithmic singularities are integrable; no infinite product or infinite-integral interchange is required. Central zeros are retained in the finite polynomial. Reflection and exact orders are still used in the source proof of (F); the new scalar bound creates no additional pairing obligation.

## 5. Quantified Turing consequence and limits

The previously frozen moderate-allowance ledger has independent review `9CAADE78...`. For t>50 and Z_t=log(qt/(2pi)), it supplies Gamma/Euler bounds

    Re(f'/f)(3/2+it) <= Z_t/2+2.525,
    Gamma/conductor shift >= Z_t/2-1/40,
    the two remaining Euler tails > -2.368,
    I_chi(t) < 3.434+(3/4)Z_t,

where I_chi(t)=integral_(1/2)^infty log|L(sigma+it,chi)| d sigma with the inherited integrable convention. Substituting coefficient 3/2 in the lower ledger gives

    I_chi(t) > -(1/4)Z_t-6.1805.                     (9)

The canonical Littlewood identity pi integral_(t1)^(t2) S_chi(t) dt=I_chi(t2)-I_chi(t1), with 50<t1<t2<=H, now gives

    |integral_(t1)^(t2) S_chi(t) dt|
        < (9.6145+Z_H)/pi.                           (10)

Both endpoint orientations are covered by the upper and lower bounds; Z_t<=Z_H. At Z_H<=18, 27.6145<9*(3.14)<9pi, hence b=9. At Z_H<=20 the same proof gives b=10. The conductor, primitive character, actual parity, and canonical argument conventions are unchanged. Principal zeta and imprimitive Euler factors are not silently included in this new theorem.

For the current two-channel RH-only surplus gate, the sum of the two individual allowances is at most 2b. With D=(Abar-W)/h-K, the sufficient test is D+2b/h<2. Thus b=9, h=13 and a certified D<=1/2 leave count reserve 3/26. At h=12 that same coarse D cap only gives equality and does not suffice. The actual-family height bound qT<=128160000 and q<=265800 yields Z_(T+13)<18 using the exact witness

    (128160000+265800*13)/6 < (8/3)^18 < exp(18),

with 2pi>6 and exp(1)>8/3. The finite positive exponential series proves the latter strict inequality.

This is a sufficient measured-surplus condition, not a guarantee that D<=1/2 is attained, that any sign test succeeds, or that an existing evaluator covers T+13. Every needed extension of the V/J/seed/error domains remains a separate obligation. Exact zero counts, list saturation, boundary nonvanishing, and principal reciprocal-head data are not consequences of the RH-only +2 gate. No runtime or end-to-end work reduction is asserted before those obligations and actual receipts are supplied.

## 6. Source and artifact pins

The Mathlib files below were inspected at commit `56a005855ea17e0b0958f73ec801ae140b0a1679`, under `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib`.

| File | Relevant source | SHA256 |
|---|---|---|
| Analysis/Complex/AbsMax.lean | `Complex.norm_le_of_forall_mem_frontier_norm_le`, line 404; bounded U, `DiffContOnCl`, frontier bound, closure conclusion | 4240A1997FE901152346C84478761A54D52D9F520D96BB20D840BF2D3F34F5E8 |
| Analysis/SpecialFunctions/Complex/LogDeriv.lean | `Complex.hasDerivAt_log`, line 37; `differentiableAt_log`, line 41, on slitPlane | 1DD451C4750B8B9644B7D0A90855EDE26DB7DAC73204BA9ED6124E89F6A1EF19 |
| NumberTheory/LSeries/DirichletContinuation.lean | entire nonprincipal completion, line 249; ordinary/completed relation, line 258; primitive FE, line 283 | ECF79F2A64EF2E7215729EBB2E7D5ADAA03468B18BBDA0040680AA925D4673F1 |

The earlier unpaired source map supplies `MeromorphicOn.intervalIntegrable_log_norm`, the real integral of log through zero, and continuous v log|v|. New formal work consists of the finite log majorant, strong-concavity calculation, quarter-annulus frontier/continuity adapter and maximum-principle application. None has been elaborated here. The completed-L finite approximation and canonical Littlewood assemblies retain their own explicitly listed formal obligations.

Paper inputs relative to `work/qrh-campaign/agents`:

| Input | SHA256 |
|---|---|
| prime-estimates/UNPAIRED_ZERO_RATIO_BOUND_2026-11-11.md | D315AE5C7B98C8A8E1042FE548B7A5FB704CEB200CFA48E36509A5A23910DB1B |
| moebius/REVIEW_UNPAIRED_ZERO_RATIO_BOUND_2026-11-11.md | B42C970619E291A81BCFD1B3FBB39498CA471FB07F7DDC47B9DB8D52BAC8D3D4 |
| prime-estimates/GENERAL_COMPLETED_L_REAL_RESOLVENT_SOURCE_ROUTE_2026-11-11.md | 45B41467F5C57AB991088874D32B1163211709CAE4D9577D300E363F37D7317B |
| independent-feasibility/REVIEW_GENERAL_COMPLETED_L_REAL_RESOLVENT_SOURCE_ROUTE_2026-11-11.md | 45A360EFE4BB85EDB9741E94A5D3E8568083DDBA86A8C421FA246A245C5D7D02 |
| major-constants/TURING_MODERATE_ALLOWANCE_PROOF_PATH_2026-11-11.md | A480D72440F4A5D2C2BF539EB6D3C152428772060A7BFAF35582BCCDB525707D |
| integration/REVIEW_TURING_MODERATE_ALLOWANCE_PROOF_PATH_2026-11-11.md | 9CAADE7892BE7D6F5A860225016F1D345B2A6BB1E8122177055431FCCBFEA36C |
| major-constants/TURING_SPECTRAL_SURPLUS_REDUCTION_2026-11-11.md | 6E7CD152D57679AFBEF754D9A1C0060AAA3F28C6E2DB1F6EFB4BD24A6B15C401 |
| independent-feasibility/REVIEW_FINITE_RH_PAIR_DEFICIT_2026-11-11.md | 97645AB7A3A9EC3B807DD4BFDD022175455A0F1DEF46F676141E6C587164C7E5 |

The sole newly executed program is `three_halves_zero_ratio_scalars_20261111.py`, SHA256 `226FEA8F06929686BD818D5572E6F2B795891C50941D0987AACDE6109F6CF614`. It checks 14 rational identities/inequalities and writes `three_halves_zero_ratio_scalars_20261111.json`, SHA256 `A32F2B8DCE0D96E1C1DBD7142CCB886494F9B3B2F1332A52062F38B27FBC385D`. No logarithm, exponential, Gamma, L-function or zero value is evaluated. The scalar receipt supports the displayed rational calculations, not the analytic proof by itself.
