# Scaled Hurwitz seed jets and their complete error budget

2026-11-11. Symbolic analysis and exact rational envelope checks only. No Hurwitz, exponential, trigonometric, prime or zero values were evaluated. No evaluator, transform, Lean build or production certificate was run. The result is a proposed finite circuit and a sufficient precision allocation, not generated coefficient balls or a runtime comparison.

Scaling the normalized alpha derivatives by the mesh powers removes the large raw rising-factorial amplification in the existing shared EM seed circuit. Uniformly across its five bands and every P<=32, base-power errors delta=2^-118 and internal complex rounding errors u=2^-122 suffice for scaled coefficient errors less than 2^-102. The complete shifted P20 alpha evaluation still meets its 2^-82 character-summed allocation. A weighted Pascal-matrix argument pays the midpoint shift without an exponential-in-the-number-of-updates bound.

This is an interface change. The consumer must evaluate the scaled coefficients at the scaled displacement. Converting them back to raw coefficients would multiply their error radii by D^k. The result does not show that the old immutable raw coefficient boxes contain these new enclosures.

## 1. Exact function and parameter contract

Use the actual continued Hurwitz function f(alpha)=zeta(s,1+alpha), s=1/2+it, |t|<=V, alpha in[0,1]. Retain all function, EM remainder and derivative identities from the pinned shared circuit in section 8. At a coarse anchor a=j/D define

    C_k(a)=f^(k)(a)/k!=(-1)^k(s)_k zeta(s+k,1+a)/k!,
    U_k(a)=C_k(a)/D^k,             0<=k<P<=32.

The same D is used at the new midpoint b=a+1/(2D); it is not replaced by 2D in the coefficient normalization. For a nearest fine anchor and target alpha, h=D(alpha-b) obeys |h|<=1/4. The exact finite evaluation is sum U_k(b)h^k. At an even fine anchor the midpoint shift is absent. Endpoints remain restricted to[0,1]. Negative heights and t=0 are included.

| V | D | N=ceil((V+160)/3) |
|---:|---:|---:|
|500|512|220|
|1000|1024|387|
|2000|2048|720|
|5000|4096|1720|
|10000|8192|3387|

Write z=1+a, b_EM=N+z, and b=b_EM in sections 2--4 only. Thus 1<=z<=2 and N+1<=b<=N+2<=3389. The midpoint anchor b in the shift section is unrelated to this EM endpoint. Set A=(V+32)/D<5/4. For all k<P,

    R_k=(-1)^k(s)_k/(D^k k!),
    |R_k| <= A^k/k! <=5/4.

Indeed |s+j|<=V+j+1<=V+32, and the positive sequence (5/4)^k/k! increases only from k=0 to k=1. The bound applies to the scaled rising products themselves, not to a later cancellation of large raw quantities.

## 2. Scaled finite EM circuit

Retain m=64 and the exact signed rational constants

    gamma_r=6^(2r) B_(2r)/(2r)!,      |gamma_r|<4, 1<=r<=64.

For x=n+z>=1 let B_x=x^(-s). The head is

    D_k=sum_(0<=n<N) B_(n+z)(n+z)^(-k),
    head_k=R_k D_k.

Generate R by R_0=1 and R_(k+1)=-R_k(s+k)/(D(k+1)), rounding after each multiplication. Its first factor has norm<=5/4; every later factor has norm<=5/8. Generate each head term from its one B_x leaf by repeated multiplication by the exact real rational 1/x, then round. Accumulate the terms exactly on one dyadic grid.

Retain E_0=1, E_(ell+1)=E_ell(s+ell)/(6b) through ell=P+126. More precisely the largest stored index is P+126, so the final update uses ell=P+125. Every factor has norm<=1/2, as in the original circuit. Define the scaled lambda recurrence

    lambda_0=1,
    lambda_(k+1)=-lambda_k*6/(D(k+1)).

Its exact value is (-1)^k(6/D)^k/k!, with magnitude<=1. Both E and lambda are rounded after each update. Round the fixed gamma_r to the same requested absolute tolerance once and reuse them, retaining their exact rational definitions as the acceptance targets.

For each k, form

    S_k=sum_(r=1)^64 gamma_r E_(k+2r-1),
    Z_k=b E_k/(s+k-1)+E_k/2+S_k/6,
    F_k=lambda_k Z_k,
    U_k^(EM)=head_k+B_b F_k.                         (1)

All denominator and domain checks are inherited explicitly: |s+k-1|>=1/2, x>=1, b>0, D>0 and k+1>0. This includes t=0,k=0. Formula (1) includes the pole-type term and every Bernoulli correction. It is the original finite formula divided by D^k, since lambda_k E_k=R_k/b^k. No approximation is used in this identity.

Each scaled remainder is at most the raw coefficient remainder, because D>=1. The rational version of the original bound is

    |U_k-U_k^(EM)|
      <=108(N+2)/(127.5)*2^-128 <2^-116.             (2)

The actual Hurwitz EM identity and its Bernoulli bound remain analytic proof obligations from the original source packet; this note does not replace them by successful scalar tests.

## 3. All seed-rounding errors

Every u below is a complex absolute error, not a coordinate halfwidth. A nearest common coordinate grid of step u suffices, since its Euclidean error is at most u/sqrt(2)<u. Initial B centers may be rounded to this common grid, provided their certified total error remains at most delta. All additions designated exact are additions on this shared grid with sufficient integer capacity. Exact rational factor multiplications/divisions are followed by the indicated rounding; numerator and denominator work is still charged.

Take

    eta=2^-100, delta=2^-118, u=2^-122.

R_0,E_0,lambda_0 are exact. The recurrence errors obey

    |Rhat_k-R_k|<=3u,  |Ehat_ell-E_ell|<=2u,
    |lambdahat_k-lambda_k|<=2u.

For R the initial noncontracting factor acts on zero initial error. Later errors satisfy e_next<=(5/8)e+u. Lambda factors are at most6/512, so2u suffices; E factors are at most1/2. We may use |Rhat|<=5 and |Ehat|<=2 throughout. These are deliberately loose.

A head term after k updates has error<=delta+ku. Therefore Dhat_k has error<=N(delta+Pu). The final rounded head multiplication has error

    E_head <=5N delta+(5NP+3N+1)u.                  (3)

For the corrections, the true S satisfies

    |S_k| <=4 sum_(r>=1) 2^(-(k+2r-1)) <=8/3.

With |gammahat-gamma|<=u and each product rounded by u, each term error is at most4(2u)+2u+u=11u. Exact accumulation gives |Shat-S|<=704u and |Shat|<=4. Separately round the three terms defining Z. Their respective errors are bounded by

    (4b+1)u,       2u,       119u.

Thus |Zhat-Z|<=(4b+122)u, |Z|<=2b+1, and |Zhat|<=2b+2. The rounded lambda-times-Z multiplication has error

    E_F <=(4b+122)u+(2b+2)2u+u=(8b+127)u.

Since |B_b|<=1, |Bhat_b|<=2 and |F|<=2b+1, the final rounded endpoint multiplication contributes

    E_endpoint <=(2b+1)delta+[2(8b+127)+1]u.        (4)

One final rounded head-plus-endpoint addition adds u. Combining (2)--(4), at N<=3387,b<=3389,P<=32,

    |Uhat_k-U_k|
      < 23714 delta+606562u+2^-116
      = (493025/2097152) eta
      < eta/4.                                    (5)

The exact script checks all25 combinations of the five bands with P in{20,24,27,28,32}, as well as the uniform bound. Rounded R, E, lambda, gamma, head terms, endpoint terms and final outputs are all paid in (5). There is no exact huge raw R_k table hidden in the allocation. The exact gamma table and rational factors still require finite arithmetic and their own representation bounds.

## 4. Magnitudes and elementary leaf requirements

The ideal finite-EM vector obeys a factorial majorant. From the factorizations in section 2,

    |U_k^(EM)| <= C A^k/k!,    C=N+2b+1<=3N+5.

For the endpoint estimate, factor E_k out of E_(k+2r-1); the remaining factor is bounded by2^(-(2r-1)). This gives |F_k|<=(2b+1)|R_k|/b^k. It justifies the majorant without using the bounded but unstructured estimate (5).

The exact full translation by1/2 has entries binom(j,k)2^(-(j-k)). It maps this majorant to

    C A^k/k! sum_(ell>=0) (A/2)^ell/ell!
      <=C*(5/4)/(1-5/8)=(10/3)C<4C.

The geometric majorant for the exponential series uses only A/2<5/8. Every partial positive shift matrix is entrywise bounded by the complete unpruned matrix. Omitting updates can only decrease its entries. The induced maximum-row-sum norm is at most2^P: bound binom(j,k)<=2^j and use (P-k)2^k<=2^(P-1). Consequently perturbations at any intermediate step contribute at most2^P(eta+L_P u_T)<1 for the allocation below. Every shifted center has magnitude<4C+1<2^16. Head/endpoint stored centers also fit this conservative bound. Exact rational division intermediates, raw integer products, phase arguments and exponent fields are not claimed to fit16 bits.

The elementary leaf remains

    B_x=x^(-1/2) cis(-t log x),  1<=x<=3389.

Sufficient suballocations are log error<=delta/[8 max(1,V)], amplitude error<=delta/8, cis evaluation error at the proposed phase<=delta/8, and final product rounding<=delta/8. Unit-phase Lipschitz continuity and amplitude<=1 pay the phase perturbation. Products of these tiny errors fit the remaining slack. Uniformly, log error2^-135 suffices because10000*2^-135<delta/8; amplitude and cis errors2^-121 suffice.

These suballocations are targets for the rational elementary checker, not supplied leaf values. A working grid with u=2^-122 is sufficient for the seed recurrence gates, but is not a claim that every elementary calculation needs only122 fractional bits. Phase range reduction, pi enclosures, intermediate rational operations and proof witnesses require their own guards. For example the phase magnitude is<90000 and its integer reduction is finite, but the required certified cis construction must still be instantiated. Optional across-height B recurrences also retain their accumulated-error guards from the original circuit. Lower seed precision does not eliminate those costs.

## 5. Stable finite midpoint shift

Return to midpoint anchor b=a+1/(2D). The exact translated first20 scaled coefficients of the degree-(P-1) polynomial are

    Utilde_k(b)=sum_(j=k)^(P-1) binom(j,k) U_j(a) (1/2)^(j-k).

Use precisely the reviewed pruned loop, with displacement1/2 instead of1/(2D): outer i=P-2,...,0; inner j=i,...,min(P-2,i+19) in increasing order; update

    A_j <- A_j+(1/2)A_(j+1).

There are L_P=20P-210 updates. The half-scaling is exact with signed dyadic exponents. Give each complete update total complex absolute rounding error<=u_T.

Here is the stronger rounding proof needed after scaling. Write each ideal update as a nonnegative matrix I+(1/2)E_(j,j+1). Its product and every prefix are entrywise>=I. For an error injected into slot j, let S be the remaining suffix. The complete product SP dominates S entrywise, and inserting the omitted unpruned updates can only increase entries. Therefore, for the final evaluation at |h|<=1/4, the absolute contribution of this injection is at most

    u_T sum_(k<20) (1/4)^k binom(j,k)(1/2)^(j-k)
      <=u_T(3/4)^j <=u_T.

This argument is for an additive injection at its actual update location; it does not falsely identify the suffix with a complete translation. It handles arbitrary complex error directions by componentwise nonnegative majorization. The same bound applied to each initial coefficient error<=eta gives less than4eta per residue. Thus the character-summed bounds are

    E_seed <=2532eta,
    E_shift_round <=633 L_P u_T.                    (6)

The factors633 and the complete residue character normalization are unchanged from the reviewed shift packet. In particular finite sums, the conductor factor c^-s and all relevant source character labels remain required; this is not a replacement by an arbitrary vector of coefficients.

## 6. Complete alpha allocation

Evaluate the resulting first20 coefficients by Horner at exact h=D(alpha-b), |h|<=1/4. If each multiplication and addition has complex absolute error<=u_H, its geometric error sum is at most(8/3)u_H per residue, hence1688u_H after the character sum. Usually h is rational rather than dyadic. If an approximate h is used, its derivative-weighted argument error must be paid separately.

The actual-function remainders are unchanged by coordinate scaling:

    E_target <1266(5/16)^20/20! <2^-84,
    E_shift <1266(15/16)^P/P!.

They come from two distinct Taylor steps on real segments contained in[0,1]. They are added, not identified. The complete isolated alpha error obeys

    E_alpha <E_target+E_shift+2532eta
              +633 L_P u_T+1688u_H.                 (7)

Use eta=2^-100, u_T=2^-110 and u_H=2^-100. Exact rational checks prove (7)<2^-82 for P=27,28,32. The actual seed error (5) is smaller than eta, but (7) intentionally uses the looser eta. Even fine anchors satisfy the same bound with no midpoint contribution. The last coarse anchor at alpha=1 still needs only20 coefficients.

The remaining finite heads, conductor phases, transform gates, height interpolation, exceptional repairs, nonvanishing tests and completeness checks have not been charged to (7). The allocation is the same isolated alpha component as in the prior report. No sign or nonzero margin follows from it alone.

## 7. What this changes in the cost model

For the V10000,P28 band the raw sufficient plan requested383 base-power error bits and388 head-recurrence bits. This alternative requests118 and122 respectively, uniformly through P32. These are sufficient absolute fractional-error exponents for different normalized interfaces. They are not minimal precision, total word widths or speed ratios.

Base-argument counts, independent seed slots, head recurrence counts,64-correction counts and midpoint update counts are unchanged. The scaled R and lambda are now rounded contracting or nearly contracting recurrences, whose errors are explicitly included. Seed stored centers and midpoint work centers have the uniform2^16 magnitude bound above. The eventual total mantissa width must include this magnitude allowance and the implementation's guards. Multiplication numerators and exact rational-factor work have larger widths. Conductor sums and later transforms require their separate magnitude bounds.

The proposed acceptance data bind s,V,D,N,m,P, the coarse anchor, all elementary B_x targets, the exact signed Bernoulli constants, every rounded recurrence and the scaled coefficient semantics. Midpoint consumers bind the same D and exact rational h. Ordinary PA or Lean acceptance must prove the analytic function identities and finite rounding checks, rather than accepting a native numerical result. This report supplies a symbolic conditioning improvement and a finite allocation. It supplies neither an implementation nor new coefficient data.

## 8. Frozen inputs and reproducible scalar receipt

Paths are relative to work/qrh-campaign/agents. All listed input hashes were checked. The new script evaluates only rational majorants, factorial bounds and integer metadata; it does not import an evaluator or compute any function value.

| Artifact | SHA256 |
|---|---|
| integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md | 1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E |
| integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md | 861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895 |
| independent-feasibility/REVIEW_SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md | F190270EC3A359A1251E24C1039826EFE13897499DE540EA9F877331804748BB |
| prime-estimates/scaled_hurwitz_seed_bounds_20261111.py | 51814FE2AA93B10AF604E635AD38831E8E6DDBAFEB32EB6A3DA5E1BDA98B52C5 |
| prime-estimates/scaled_hurwitz_seed_bounds_20261111.json | 2705A1CFACB0C9CECDA842DDF73A37696DF8A1BAD250AEA7F383D63AC11A99E8 |

The script passes25 seed allocations, the uniform worst case, three full alpha allocations, and the intermediate-magnitude perturbation and log-suballocation inequalities. Actual function identities and generic matrix/rounding proofs are paper obligations, not established merely by this finite replay.
