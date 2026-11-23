# Wstar: lowering the height floor and separating squarefree conductors

2026-11-11. New conditional paper proof and exact rational metadata. All prior reports and receipts are unchanged. No L-function, zero, prime, transform or analytic function values were evaluated; no Lean declarations or builds were made.

The star height floor can be reduced from 1000 to 300 without changing the convenient uniform remainder allowance 2e-12. The proof must retain separate geometric sums for the two Gaussian regimes. The weighted statistic also permits beta<=.5075 only at squarefree primitive conductors and beta<=.62 at all other primitive conductors. These are sufficient finite spectral conditions, not established facts about the actual zeros. Under those conditions the bounds A<4e-12 and B<42 fit the independently reviewed A4e-12/B62 Wstar allocation. This does not discharge the separate plus, base-gap or principal inputs.

## 1. Definitions and a predecessor range correction

Keep R=132900, Dc=8R/qt(c), qt(c)=2c for odd c and c for even c, y=x/49>=Y=10^25. Primitive nonprincipal conductors are odd c<=R or 4|c<=2R. For F in {1000,500,300}, define

    H_F(c)=ceil(max(F,(704/343)Dc)).                    (1)

The exact maximum for all three profiles is H_F(4)=545549. The predecessor `WSTAR_CUTOFF_BASELINE_TRADEOFF`, SHA55D2E58D..., incorrectly stated a maximum 363700 in its section 4; that is H_F(3), not the family maximum. Its script already computed conductor4 correctly. Replace only that prose range by H<=545550. The cited analytic envelope already covered H<1.3e6, so no predecessor count or tail coefficient changes. This note records the correction without modifying the frozen predecessor.

Use its actual complete closed carriers, multiplicities, omegaA/omegaB weights and canonical count proof. In particular omegaA(c)=0 for every nonsquarefree c: every eligible q is then nonsquarefree and mu(q)=0. This removes that conductor only from QA, not from QB, the actual spectrum or other consumers.

## 2. Full-strip Gaussian tail, with the two sums separated

The actual positive-mixture identity is

    FU(s,d)=integral_[1/4,1] eta2(r) r^(s-1) Gr(s,dr,0) dr.

For beta>0 its absolute mixing mass is at most 4(log2)^2<2. This follows from the exact moment 4((1-2^(-beta))/beta)^2 and 1-exp(-z)<=z. Compact r support and the Gaussian majorant justify absolute Fubini. There is no shift s+2.

At every actual nontrivial zero, 0<beta<1. `ZeroSumBound.norm_G_tail:105` applies on the larger real-part domain [-1,1]. For |d|<=Dc/49, let D=Dc/49 and H=H_F(c). Then H>=32pi D and H>=300, hence H>=max(10pi D,50). With k=floor((|gamma|-H)/4.4),

    |FU(rho,d)|<=2[EB(H) rhoB^k + EA(H,D) rhoA(D)^k],
    EB(H)=.892H exp(-.1598H),
    EA(H,D)=.588u^2 exp(-.1065u^2), u=H/(pi D)>=32,
    rhoB=exp(-.1398*4.4),
    rhoA(D)=exp(-1.93*4.4/(pi D)).                       (2)

Monotonicity of u^2 exp(-.1065u^2) on u>=10 and of the geometric factor handles the smaller twist dr. The actual zero-twist EA contribution is exactly zero. D in (2) is a positive uniform upper bound; no division by the actual zero twist is used.

The full-strip finite-window count of `ZeroSumGen.count_tail_windowG:121` is

    count_k<=2 Z3g(BP(c),H)+2 c3g(11,H)(k+1).

The old explicit polynomial bound still gives Z3g<400 for 300<=H<=545550 and c<=265800. Its upper logarithm estimates only improve on this smaller domain; its denominator log(10/3)>1 is independent of H. Also c3g(11,H)=48.4/[H log(10/3)]<53/H. Thus at F=300 the geometric sum with ratio rho is bounded by

    S(rho)=800/(1-rho)+(106/300)/(1-rho)^2.             (3)

This is a base-height bound plus the source's linear growth in k. It does not assume at most400 zeros in remote windows. Both signs and true orders are already counted.

The elementary inequality (1-exp(-a))^-1<=1+1/a gives

    (1-rhoB)^-1<3,
    S(rhoB)<2400+(106/300)*9<2404.

For the A regime retain the deliberately loose old G0=1+600001/2.7. Since D<=600000 and 1.93*4.4/pi>2.7, (1-rhoA)^-1<=G0 and

    S(rhoA)<=800G0+(106/300)G0^2<2e10.                (4)

The companion checks by positive rational exponential Taylor lower sums

    exp(47.94)>267.6*10^18        (200-degree sum),
    exp(.1065*32^2)>.588*32^2*10^44 (500-degree sum).

Since EB decreases for H>=300 and EA decreases for u>=32, these imply EB(H)<1e-18 and EA(H,D)<1e-44. Equations (2)-(4) give

    sum_(|gamma|>H) m |FU(rho,d)|
       <2[2404*1e-18+2e10*1e-44]<5e-15.              (5)

This argument first bounds every source finite subcarrier. The geometric majorant proves positive absolute summability and permits the same true-order/good-height limiting identification as the predecessor. Multiplication by y^(rho-1) cannot increase the bound because beta<1 and y>=1. No global QRH or high-zero critical-line assumption is used.

For F=500 a retained intermediate calculation gives EB(500)<1e-31 by a 300-degree positive Taylor sum, while a common geometric majorant <2e10 is sufficient. Its resulting tail is <5e-21. It is a separate saved alternative, not needed for the selected F=300 argument.

The low Gram's 400-per-3.48-window estimate also remains valid in this smaller finite domain. It uses the off-line radius2.7 disk containing width1 and vertical half-length1.74, not the radius2.3 critical-line specialization. The old polynomial estimate covers the small surrounding-window enlargement. Hence the full-strip G=7e6 from the weighted-statistic report is unchanged.

## 3. Complete remainder is still below 2e-12

The predecessor's source-sharp vertical plus zero-at-zero contribution is <1e-18. Its actual primitive-to-coprime removal is <=1e-12. These estimates depend on the twist/conductor/physical-scale domains, not on F; those domains have not changed. Combining them with (5),

    e <1e-12+1e-18+5e-15 <2e-12.

Nontrivial real zeros remain in the low carrier; the separate zero at the complex number0 is handled by the zero-at-zero term. The principal pole/main term is not part of this nonprincipal calculation.

The exact Gauss-weight measures are unchanged. With sum_squarefree_q 1/phi(q)<14,

    TA <e sqrt(8R*14)<8e-9,
    TB <e sqrt((3R/2)*(8R)*(2R))<.00048.              (6)

This is the actual coprime remainder in the parent QA/QB reduction, not just a primitive high-zero sum. The factor49 is already in the star twist and Gram normalization; it is not inserted again into these pointwise errors.

## 4. Exact count metadata at both smaller floors

The scripts reuse the predecessor's proved count inequality, not an asymptotic count heuristic. For each H, choose the least positive integer k with (8/3)^k>c*(1.01H)/6 and use the ceiling of

    1.01H*(k-1)/3+1+(200/H)(42+6.93k).               (7)

This comes from closed-count averaging over [.99H,H] and [H,1.01H]. Now .99H>=297>50, so the same Turing and Binet domains apply. It bounds all actual zeros with multiplicity, either parity, including real zeros. It does not certify their real parts.

Each script enumerates132899 nonprincipal conductors and all199350 eligible moduli, checks sum_eligible_c c*number_primitive(c)=phi(q)^2 at each modulus, and rounds every nonnegative weighted contribution upward at denominator10^12. There are130718 conductors at floor500 and129264 at floor300. The different number at the floor is expected because the conductor-dependent term is unchanged.

| Floor F | All-line QA upper | All-line QB upper |
|---:|---:|---:|
|1000, predecessor|2.335e-19|5.966e-12|
|500|2.324e-19|2.921e-12|
|300|2.321e-19|1.753e-12|

Decimals round upward. The F=300 exact weighted-count numerators, before division by 10^12*Y, are2320260719784375582 for A and17521273377323822834049091 for B. Each receipt also splits B into squarefree and nonsquarefree conductor contributions; their separately rounded sum need not equal the directly rounded B total.

## 5. Independent check of the proposed real-part profile

Require only the following finite conditions through H_F(c): beta<=203/400=.5075 for squarefree primitive c; beta<=31/50=.62 for nonsquarefree primitive c. These are upper bounds on every actual nontrivial zero in the complete carrier, not just zeros found on a line. Closed heights and multiplicities remain mandatory.

Relative to the all-line count baseline, the first condition multiplies each weight by at most10^(3/8)<12/5. The second multiplies it by at most10^6 exactly. Consequently

    QA<=(12/5)*QA_line,
    QB<=10^6*QB_line.                                  (8)

The first inequality uses omegaA=0 for nonsquarefree c. For the second it is safe to overcount the squarefree part by10^6 as well. The independent rational allocation check uses the exact stored baseline bounds and proves, for F=1000,500,300 separately,

    7e6*(12/5)*QA_line <(2e-6-8e-9)^2,
    7e6*10^6*QB_line <(6.48-.00048)^2,
    6.48^2<42<62.

Combining (6)-(8) with the actual Gram/Minkowski reduction therefore gives A<4e-12 and B<42. This confirms the root's proposed split even at the old F=1000; lowering the floor improves the count bounds and does not consume the remainder allowance.

The source/paper-reviewed weighted-principal allocation gives

    sqrt(49^2 Wstar/x^3)<1.902e-6+sqrt(A)+8.85e-7*sqrt(B).

For completeness the scripts verify (7.875)^2>62, (2.964)^2<8.79 and

    1.902e-6+2e-6+8.85e-7*7.875 <2.964*3.67e-6.

Thus its A4e-12/B62 row applies. The plus residual, integrated plus bound and principal certificate consumed by that allocation have not been proved here.

## 6. Height-union implication and remaining work

The new H_300 profile is strictly a star certificate requirement. It does not bound the base-gap twist u/(2q). That separate consumer has its own reduction under investigation.

There is a useful conditional comparison with the proposed plus profile

    Hplus=ceil(200+max(260,u(c)*3.1416*Dc)), u(c)>=19.89.

The expression inside this ceiling exceeds both300 and (704/343)Dc, since its constant floor is460 and19.89*3.1416>704/343. Hence H_300(c)<=Hplus(c) for every conductor. This is a mathematical comparison of candidate formulas, not an acceptance of the plus error proof or a full union certificate. Real-part demands must also be composed: the squarefree .5075 and nonsquarefree .62 requirements cannot be erased merely because a taller certificate exists with a weaker real-part bound.

The remaining substantive task is actual finite spectral evidence, or a proved aggregate theorem, at the stated profile. No probability of success, computation saving or runtime has been inferred. All analytic wrappers and finite metadata checks remain to be internalized in the eventual proof system.

## Evidence and reproduction

The scripts evaluate only integers and fractions, including finite positive Taylor sums used as exponential bounds. No exponential function values are called. Each refuses to overwrite its own receipt. Run the named script with `work/qrh-campaign/interval-env/Scripts/python.exe`; to replay, use a separate output location or inspect an independently reconstructed receipt rather than deleting the frozen original.

The first floor500 development attempt rejected an incorrectly rounded expected maximum545550; no receipt was emitted. It was corrected to the exact545549 before the successful run. This was metadata validation, not a failed spectral test.

| File | SHA256 |
|---|---|
|zero-sum/WSTAR_CUTOFF_BASELINE_TRADEOFF_2026-11-11.md|55D2E58DA0F13A77ECC3AB097E5CAC45D58EE247178F8A8D5824756A45E1C2AB|
|zero-sum/wstar_critical_baseline_metadata_20261111.json|A5CA555478A01B9785FB7F04D754AB547CCE280775862DB76863511CB29FAE18|
|zero-sum/wstar_floor500_metadata_20261111.py|71FF612FEF6CFAC1EC747FBEFD67B744B07A60263A5C0D9BB02B3D52AF444073|
|zero-sum/wstar_floor500_metadata_20261111.json|4CAF3600A367B6DE55FEDF10D218007E86CBBC35C021828110825E7F3E8698A4|
|zero-sum/wstar_floor300_metadata_20261111.py|624B5414A2517C5AAE75C0D3179CC1509097CEC74696BBE9EA1A23AC914B5EC3|
|zero-sum/wstar_floor300_metadata_20261111.json|7750B7D1BB25A96D9B4F54A75C4090B9C7ECE591D905DEDC7D244FBA12CCDAD5|
|qrh-blueprint/WEIGHTED_PRINCIPAL_WSTAR_BUDGET_2026-11-11.md|22A6A16880BE2FA5CB0FF393C533BD60B1AFCD32C751E5A0D64FE7ADAB7C40F7|

All source and analytic dependency pins are inherited explicitly from the predecessor: `ZeroSumBound.norm_G_tail`, `ZeroSumGen.count_tail_windowG`, the actual etaU mixture/vertical source join, `ArcCharsStar.coprime_split_star`, and the canonical count/Binet/endpoint papers. Their declarations and domains have been rechecked for F=300 as detailed above. Paths in the table are relative to `work/qrh-campaign/agents/`, except the root budget under `work/`.
