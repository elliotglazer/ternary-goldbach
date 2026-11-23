# Independent review of the finite-RH theta frontier

2026-11-11. PASS at the conditional paper and exact-scalar scope described below. No correction to the frozen author packet is required. This is not a finite-RH verification or a Lean theorem. No prime or zero evaluation, analytic numerical evaluator, build, or source modification was used.

## Mathematical scope

The candidate uses A=10^16, X=10^27, 1<=Q<=50, L=log x,

    c=L/2+6, epsilon=L^(5/2)/(Q sqrt x), H=4*10^10 Q.

It claims the ordinary Chebyshev theta bound

    |theta(x)-x| < (.031+2.261/Q) sqrt(x) (log x)^2

for every real x in [A,X], conditional on complete critical-line location through H and the specified low-head/count inputs. The independent checks below concern the full continuum, not just endpoint samples. The proposed gap consequences also require the binary Goldbach certificate at the corresponding B. They do not discharge any nonprincipal spectral obligation.

## Source and normalization checks

I read Johnston, *Improving bounds on prime counting functions by partial verification of the Riemann hypothesis*, published DOI 10.1007/s11139-022-00616-x, section 2 and the relevant source-consumption steps of section 3. The source is [the published article](https://link.springer.com/article/10.1007/s11139-022-00616-x). The candidate uses its smoothed explicit formula and tail, desmoothing, and Bessel estimates. It does not invoke the later theorem's bootstrap at height 3*10^12. The published section uses half-weight endpoint prime-counting functions. The independent review preserves a separate log(x)/2 allowance before applying an ordinary psi-minus-theta estimate.

The source's displayed intermediate hyperbolic-ratio manipulation in section 3 is unnecessary here. The candidate keeps the denominator 1-exp(-2c) and bounds it explicitly. The Bessel lower constant .98, used in the source at larger c, is also unnecessary: a fresh positive-series proof gives D(20)>.97, valid throughout the present c range.

The final candidate replaces the published two-unit formula remainder by a three-unit remainder proved directly from Büthe's original formula. This avoids importing a sharp historical inverse-square sum; the replacement is checked below. The full analytic lemmas still need formal proofs or source-faithful formal imports. This review does not replace those obligations with sampled numerical evidence.

## Uniform parameters and zero-sum split

On the whole interval, 36<L<63, 24<c<37.5, and log A<37. The logarithmic derivative of epsilon is 5/(2L)-1/2<0. Consequently

    epsilon < 37^2*7/10^8 < 10^-4,
    c epsilon < .062^2.

The low/middle split t2=sqrt(2c)/epsilon exceeds 60000, and t2<c/epsilon because c>2. The middle-band parameter sqrt(2/c) belongs to (0,1). All lower-height side conditions of the source estimates hold. Since c<2L/3 and Q<=50, c/epsilon<sqrt x follows from 100/3<36*6. In particular its logarithm is less than L/2.

The logarithmic derivative of c/epsilon is

    1/2 + 1/(L+12) - 5/(2L) > 0.

Thus its largest value is at X. Using log X>62, sqrt(62)>7.8, sqrt X<3163*10^10 and c<37.5 gives c/epsilon < 4*10^10 Q. The finite RH premise covers every low and middle zero actually consumed, including closed upper cutoffs. Conjugation transfers positive-height location to negative height with the same multiplicity. The high tail is estimated unconditionally by the cited analytic tail theorem, not by extending finite RH past H.

## Centered head and Abel calculation

The existing head datum is centered:

    Q_A0 = sum_{0<gamma<=A0} m_rho (1/gamma-1/A0) < 1.668,
    A0=1500.

It must not be called the uncentered reciprocal sum. With N(t) the complete positive closed count, a finite Abel identity gives, for T>=A0,

    sum_{0<gamma<=T} m_rho/gamma
      = Q_A0 + N(T)/T + integral_A0^T N(t)/t^2 dt.

The endpoint count N(A0) cancels exactly. No assumption N(A0)=1069 is needed in this identity or the following bound. Insert the separately reviewed unconditional bound

    N(t) <= t(log(t/(2*pi))-1)/(2*pi) + 5 log t + 167/8.

Direct integration and conjugation give

    sum_{0<|gamma|<=T} m_rho/|gamma|
      <= log(T/(2*pi))^2/(2*pi) + R,

where

    R = 2[1.668 - ((log(A0/(2*pi))-1)^2+1)/(4*pi)
                    + (5 log A0+207/8)/A0] < .1.

The rational directions are correct: log(A0/(2*pi))>5.47, pi<22/7 and log A0<7.32 supply an upper bound for R. The negative square uses a positive base. The explicit rational upper bound is checked independently. This replaces the source's separate reciprocal head through 5000 with the existing centered moment and analytic closed-count theorem. Neither RH location alone nor a partial root list supplies that centered moment. Its certificate completeness and true multiplicities remain required.

## Inverse-square replacement and the formula constant

The companion `zero-sum/INVERSE_SQUARE_HEAD_REUSE_2026-11-11.md`, SHA256 `1C4A0493A913D1E57EF6DBF9C8D9DE0F4E8DD4E2F14ED506FD8970CD9D1702F0`, introduces a distinct use of the head data. Here N(1500)=1069 and exclusion of all nontrivial zeros with |gamma|<=14 are required. The centered moment alone is not the entire finite input.

I independently checked the head estimate

    sum_{0<|gamma|<=1500} m/gamma^2
      < (2/14)(1.668+1069/1500) = 3571/10500.

For the complementary tail, finite Abel summation gives the upper-bound limit 4 integral_1500^infinity B(t)/t^3 dt. The upper endpoint N(U)/U^2 tends to zero under the analytic count envelope. Integrating that envelope yields

    2 log(1500/(2*pi))/(1500*pi)
      + (10 log1500+187/4)/1500^2
      < 2723/10^6.

Consequently the complete inverse-square sum is below 7199183/21000000 < .344 < 1. This also proves its summability. The closed-head/open-tail split is exact.

I read [Büthe, arXiv:1410.7015v4, Proposition 2](https://arxiv.org/pdf/1410.7015v4), including its kernel definitions and formula domain. The even nonnegative kernel gives |a(rho)|<=1 throughout the true critical strip and a(1-rho)=a(rho). On each complete symmetric finite height carrier, reindexing by reflection therefore turns sum m*a(rho)/rho into half of sum m*a(rho)/(rho*(1-rho)). Since |rho*(1-rho)|>=gamma^2, the latter has norm below 1/2 and converges absolutely. This justifies removing the constant part of the source's (x^rho-1)/rho term. It does not assume absolute convergence of an unsmoothed reciprocal-zero sum.

The remaining source constants are bounded by 2.2+.006+.008, so the total is below 3. Its domain log x>2/|log epsilon| follows from L>36 and epsilon<10^-4. The existing finite head evidence, kernel transform and positivity, source formula, reflection/order transport, analytic count bound and elementary Euler-constant facts remain explicit proof obligations at formalization time. No new zero-location data or new Hadamard-product theorem is introduced by this adapter.

## Error allocations

All entries below are after division by sqrt(x)L^2.

* Low zeros: log(t2/(2*pi))/L <= 1/2-4.91/63. This follows from log(Q/(2*pi))<2.1, log(1+12/L)/2<.15 and log L>3.58. The quantity being squared is positive since t2>60000. The logarithmic part contributes less than .0284. The Abel excess adds less than .1/36^2.
* Middle zeros: writing d=sqrt(c(c-2)), c-2<=d<=c-1 gives a hyperbolic ratio at most (3/8+2^-24)/(1-2^-48)<.38. With 1+11c epsilon<1.05 and log(c/epsilon)<L/2, the contribution is less than .0009.
* High zeros: the exact prefactor (x+1)/(sqrt(x)sinh c) equals 2 exp(-6)(1+1/x)/(1-exp(-2c)). It is below .0051. Also exp(.71 sqrt(c epsilon))<1.05 and log(3c)<5. These give a contribution below .00006.
* Desmoothing: the positive I1(20) series and a rational exponential upper bound imply D(20)>.97. Therefore B0/sqrt x > .97*.99*36^2/(3*50)>1, so log B0>L/2. The remaining outer factor is below 1.0003. The main contribution is less than 4*1.0003/(Q sqrt pi)<2.261/Q.
* The remaining desmoothing terms, the modified explicit-formula error 3, and the half-weight jump contribute less than .000006 together. The jump is explicitly 1/(2 sqrt x L) in this normalization. A separate independent exact supplement checks the increase from 2 to 3, rather than silently reusing the earlier receipt.
* For ordinary counts, psi(x)-theta(x)=sum_{k>=2}theta(x^(1/k)), with the finite range k<=floor(L/log 2). The elementary theta(t)<=t log 4 gives a square contribution at most log 4 sqrt x and the remaining contribution at most 2L x^(1/3). Since x>=10^16>400^6 and L<63, their sum is less than 1.71 sqrt x. Its normalized contribution is less than .00132.

The fixed allocations sum to

    .0284+.0009+.00006+.000006+.00132+.1/36^2 < .031.

Thus the stated coefficient is correct if the analytic and finite inputs are supplied. In particular Q=50 gives .07622, not .076. The final gap test must use the former or the exact general formula.

## Gap coverage and the low interval

For each fixed Q the error envelope a(Q)sqrt x log^2 x is increasing for x>=A. With ordinary theta, x=n-4 and y=n-B, the strict inequality

    2 a(Q) sqrt X log^2 X < B-4

implies theta(x)-theta(y)>0 whenever A<=y<x<=X. Hence there is an actual prime in (n-B,n-4], which is sufficient for the inclusive target interval [n-B,n-4]. No endpoint convention is lost.

For B>=2A, Bertrand supplies one prime p with A<p<2A. It is an existential prime, requiring no stored ladder. The base prime 3 covers odd n<=B+3. For B+5<=n<=B+A, p<=n-4 and p>=n-B. For larger n, y>A and the analytic argument applies. The binary certificate then represents the remaining even difference between 4 and B. This is a uniform theorem replacing the ladder, conditional on the required binary and spectral inputs; a positive psi increment alone would not have sufficed.

Independent exact checks establish the strict gap inequality for the eight pairs (Q,B): (1,6*10^17), (2,3*10^17), (4,1.5*10^17), (8,8*10^16), (16,5*10^16), (32,3*10^16), (48,2*10^16), and (50,2*10^16). These are sufficient parameter choices, not measured computation optima.

## Independent arithmetic evidence

The new script uses Fraction arithmetic and recurrence-generated positive polynomial terms. It imports no author module and calls no analytic-function implementation. It uses different truncation lengths from the author. All 45 initial checks passed once. The subsequent inverse-square/formula-constant supplement passed nine additional exact checks. Its changed residual bound is the one consumed in the final conclusion.

| Owned artifact | SHA256 |
|---|---|
| `review_johnston_frontier_scalars_20261111.py` | `2E997D5720B80722C59BDC43D7AC72829C8877006944C37849C297C353E0BEB1` |
| `review_johnston_frontier_scalars_20261111.json` | `AC2F3CEA3A14BFF8F79E07A923DF487A0971C2566F496BF64C0D29B9A367F28B` |
| `review_johnston_inverse_square_20261111.py` | `CF0B50E77E869C0B643D70700B8F9A1A924EDF4423CBAE6DF97D56BB442F189A` |
| `review_johnston_inverse_square_20261111.json` | `BB0FCCF476701BE8BE484A90F5470A5AA2358110BE9ECF1B90CDA45386CEA0A0` |

The rational pi bounds and positive-series/error identities are mathematical inputs to the scalar checks, not automatically proved by Python. The receipt establishes the finite rational comparisons under those identities. No performance conclusion follows from this small check.

## Final version comparison and remaining work

I read the complete final report and scalar source and verified these hashes:

| Author artifact, relative to `work/qrh-campaign/agents/major-constants` | SHA256 |
|---|---|
| `EFFICIENCY_JOHNSTON_FINITE_RH_FRONTIER_2026-11-11.md` | `0305EF19674FF97D13C2FA3F897E1106B5B0C4618287C9002842B87233F617DF` |
| `efficiency_johnston_frontier_20261111.py` | `F604ED6FD4B2E48D3809C38358449F1FB4BA8DEFB1C76DAF3461204FE0532FC2` |
| `efficiency_johnston_frontier_20261111.json` | `46CF6EF8910874F372BC34D4B34A67F154ED135D02C0FB92512C8765AB9369CE` |

All eight artifact pins in the author's evidence table matched the files. A saved-data-only comparison also matched all eight parameter rows, every exact gap margin, the fixed allocation, reciprocal excess, updated residual with constant 3, and inverse-square total against my independently generated fractions. It performed no numerical function evaluation or file write.

The cached Bertrand source at `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/NumberTheory/Bertrand.lean:225` has the claimed quantifiers: for nonzero natural n there is a prime p with n<p<=2n. At n=A, primality and parity exclude p=2A. This is a source/API observation, not a target build result.

No mathematical defect was found in this bounded composition. Its conclusions remain conditional on the complete critical-line certificate through H, trusted replay of the existing head data, and the analytic count and Logan proofs. In particular the reciprocal reduction reuses external head evidence; it does not turn it into a proved kernel statement. The Logan transform, contour formula, zero-tail bounds, Bessel inequality, and desmoothing estimate remain substantial analytic formalization work. The ordinary psi/theta finite prime-power identity and real-floor extension, true-order reflection, closed-height passage, and scalar elementary-function enclosure lemmas also need implementation. The existing target's real sqrt/sin expression cannot substitute for the actual entire Logan function.

This route supplies mathematically sufficient alternatives to the explicit ladder without QRH, CHL zero-density bounds, a new reciprocal head through 5000, or a 3*10^12 bootstrap. It leaves the chosen binary theorem, nonprincipal family, and large-N target consumers intact. Generation, proof representation, Lean checking and MM0 checking must be costed separately; this review establishes no runtime winner and makes no change to the selected strategy.
