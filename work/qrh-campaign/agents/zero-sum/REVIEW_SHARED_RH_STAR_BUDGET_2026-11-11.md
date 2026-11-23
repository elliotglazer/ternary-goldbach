# Independent review of the shared-RH star budget

2026-11-11. PASS for the conditional paper composition and exact scalar budget. No correction requested. The uninflated floor300 statistics give the stated star bounds under ordinary finite RH on their complete carriers. The larger plus allowance is compatible with the original cubic budget. No actual spectrum, compiled theorem, runtime saving or shorter plus-height result follows from this review.

Reviewed root author `work/qrh-blueprint/SHARED_RH_STAR_BUDGET_2026-11-11.md`, SHA256 `A5457ABF7E67FD98C88F46B8F08DF4F8BD35B44B48A3B734E5F660F94CCAA993`; checker `43384BF37C7DA48D4D11B4D9B5D8D2A8D4CF32AE5B9A2FCBBE45732AA7846B2D`; receipt `32CBBA77D2C2C37CA0F4DD4E055DB2131D0E4DC6571A8CB0104FC402665C36C4`.

I read the complete author packet, the floor300 proof and its independent review, the weighted-principal and joint-cubic contracts, and the demand matrix with its independent support review. I independently reconstructed the new scalar calculations without running the author's checker. I authored the older floor300 packet, so its analytic proof is a reused dependency here, not newly independent validation of that proof. Its separate moebius review, SHA `422940369A04ED695A45EF28F20F154349932CEBC0242EEEE15FF3373D5CE6A4`, supplies that independent check.

## Carrier, weights and remainders

The active domain is R=132900, x>=4.9e26, y=x/49>=10^25. Restrict a taller closed ordinary-RH certificate to the complete actual carrier through

    Hstar(c)=ceil(max(300,(704/343)*1063200/qt(c))).

It follows that every retained beta equals1/2, and consequently y^(2 beta-2)=1/y<=10^-25. This is an equality for each occurrence with its true multiplicity, not a heuristic replacement by expected line zeros. Real nontrivial zeros and height-endpoint zeros remain included. If certificates are organized by positive ordinates, inverse-character coverage must first supply the negative ordinates as required by the parent carrier theorem. No such coverage is inferred from one character's positive row alone.

The carrier must stop at Hstar, rather than at the taller certificate height. Its count majorant and translated-window bound apply on that selected range. The saved floor300 numerators divided by10^37 are

    2320260719784375582/10^37 <2.321e-19,
    17521273377323822834049091/10^37 <1.753e-12.

These retain the actual Gauss/cofactor weights and all nonprincipal primitive labels. No dimension factor is added or removed. The A weight vanishes at nonsquarefree conductors; the B weight does not. The metadata already accounts for this distinction. The primitive-conductor exclusions do not delete imprimitive ambient characters.

The factors12/5 and10^6 in the previous mixed-strip application were solely upper bounds for the extra real-part growth. With beta=1/2 they are unnecessary. The new Q bounds are actual upper bounds conditional on RH, not merely a hypothetical baseline. The count estimate itself remains an analytic upper bound, not an asserted exact number of zeros.

The inherited G=7e6 Gram estimate is on the finite low carrier. Above Hstar, the separately reviewed full-strip Gaussian majorant uses only0<beta<1 and y^(beta-1)<=1. Its geometric window count has growing k dependence; it does not reuse a fixed400 cap at infinite height. The floor300 high tail is <5e-15, the origin/vertical part <1e-18, and the coprime removal <=1e-12. Together with the exact Gauss measures these give TA<8e-9 and TB<.00048. The star twist already contains the factor1/49. No extra49 or principal term belongs in these nonprincipal statistics.

The principal c=1 residual is treated by the separate weighted-principal proof. Its RH-through1e8 and other principal inputs are retained. The present argument neither proves nor requires the newer direct-B sieve result.

## Norm and cubic comparisons

The differences1.284e-6-8e-9 and .004-.00048 are positive. Their squares strictly exceed7e6 times the respective rounded Q upper bounds. Thus the full actual energies satisfy

    sqrt(A)<1.284e-6,  A<1.648656e-12,
    sqrt(B)<.004,      B<1.6e-5.

For rho=8.85e-7, I checked16*150000*19*rho^2<.006^2. The same integrated residual estimate therefore still supplies X/x<8.79 and the complete weighted principal/removal norm p<1.902e-6. This check is necessary when changing the plus allowance.

The actual physical-arc identity gives the cubic upper bound

    sqrt(8.79)*(p+sqrt(A)+rho*sqrt(B))+rho*C.

The principal norm appears once inside the star-product norm. The external square root is the distinct Cauchy factor from X. No cross term has been dropped. Reconstructing C and the old error allowance from their original expressions, and using2.965^2>8.79, gives exactly

    E-2.965*(1.902e-6+1.284e-6+rho*.004)-rho*C
      =228023139/10^13 >0.

This preserves the old cubic allowance and unchanged Fourier tail, conditional on the stated residuals and all other original consumers. It is not an independent proof of those consumers.

## Plus cap and optional support saving

The orthogonal principal split requires the positive cap

    Eplus <= (rho-516e-15)^2-(2.83e-7)^2.

I verified positivity before squaring and that7.03135e-13 is rounded downward. The uniform weighted coprime coefficient8.385e-7 has square below that cap. Parseval contributes1/phi(q), so at most phi(q) labels give this energy bound without another dimension loss. Inner coprime removal must already be included in the coefficient; the displayed outer-removal term is separate.

The optional even-family improvement has an independent dependency. The demand matrix is SHA `54B08C6DA98CFD0F27FE055371CFFF07A167BC8987225F7865439515623F9A4E`; its prime_estimates review is SHA `BF51DF7E0C1B99A59FCECF73941BD18DBA55029700EE2AFB84948B95703B289A`. I read its exact support proof. Nonzero Gauss weight requires q/c squarefree and coprime to c. At4|q this forces the full2-adic exponent into c, and the supported fraction is at most1/2. At4 not dividing q, no even primitive ancestor occurs. Inversion preserves the conductor. Therefore the piecewise coefficients8.385e-7 for odd c and1.1858e-6 for4|c yield energy bounded by the larger of their squared values with the second divided by2; both are below the cap. The factor1/2 is not valid for all even q, and the argument does not use it that way.

This support fact changes the sufficient coefficient target, not an already proved analytic height. A new plus-height construction must still cover all four source errors, removals, and the required star/base-gap union. The uniform coefficient option does not need the support-count refinement.

## Exact evidence and scope

Independent script `zero-sum/review_shared_rh_star_budget_20261111.py`, SHA256 `83FA4D0AC5D528B2F1A659809D766753E6A2DE234CB328A0E51E014346138FD7`; receipt `zero-sum/review_shared_rh_star_budget_20261111.json`, SHA256 `806EEF61F4A7EECE2B95067331EB210A00445AC3B910A310D264D0906210708D`. All42 exact checks passed. They bind the author inputs, floor receipt and support reports, reconstruct every saved new scalar, and check the norm/cap/cubic comparisons. No conductor enumeration or analytic evaluator was rerun.

Actual finite RH, principal/head inputs, formalization of the count/Gram/tail and physical-arc proofs, compatible kernel validation, auxiliary completeness work and any newly shortened plus-height proof remain open obligations. This review accepts the new implication and arithmetic; it does not establish end-to-end cost dominance or a complete PlattGRH-free theorem.
