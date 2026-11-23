# Review of the even Gauss-support height profile

2026-11-11. PASS for the conditional source/paper implication and exact scalar profile. No correction requested. This establishes a coherent sufficient height prescription under actual ordinary finite RH, not that its finite spectra have been certified. No analytic or spectral values, builds or source edits were performed.

Reviewed author: `moebius/EVEN_GAUSS_PLUS_HEIGHT_PROFILE_2026-11-11.md`, SHA256 `D3408AA27763D7E3C475E7B27DB124FDE9C16EDC916CEE061563B31D9A2DD88B`.

I read the complete note, script and receipt, the coupled-profile predecessor and the relevant source bodies in Prop942 and Thm714. I also checked the ambient transfer against ArcChars and the exact support argument previously reviewed in the demand matrix. All eight band estimates were independently recomputed; this review does not merely inherit acceptance of the coupled-profile candidate.

## Profile and spectral quantifiers

The profile uses u0=23,21.5,20.5,19.5 on the half-open bands separated by 100,1000,10000. Odd primitive conductors use u0, and conductors divisible by four use u0-.4. Thus the even values are 22.6,21.1,20.1,19.1. The floor term is 255, with the separate 200 shift. All ceilings are applied to the complete real expression.

"Odd unchanged" means unchanged from the coupled four-band candidate, not from the older fallback. I checked directly that all new u values are no larger than the applicable fallback values 23.3 or 19.89, and that 255<=260. Hence the ceiling-safe comparison to the fallback, and then to its original source endpoints, is valid without assuming RH at those larger endpoints.

The common requirement is ordinary finite RH for all actual primitive nonprincipal characters at odd c<=132900 and 4|c<=265800, through the closed height H=max(Hplus,Hbase). It includes both signs and nontrivial real zeros. Actual multiplicities remain in the analytic sums. It does not assume simplicity or that a list of critical-line zeros is complete. Conductor one keeps the separate principal RH-through-10^8 input. The absence of primitive conductors congruent to 2 modulo 4 does not remove those ambient moduli from the character expansions.

## Support factor and the two removals

The quantity bounded before applying the support fraction is exactly

    |tau_q(psi)|*|Schar(psi^-1,coprimePart(q,cP(x)),beta)|/x.

`Bombieri.norm_sq_gaussSum:135` says a nonzero term has c|q, squarefree q/c, and gcd(c,q/c)=1. If 4|q, those conditions force the full 2-adic exponent into c, so 4|c. Counting local primitive characters gives support fraction at most 1/2. If 4 does not divide q, no even primitive conductor occurs. Therefore the odd and even ambient bounds may be used separately as in formula (2). The factor one-half is applied to the sum of squares divided by phi(q), not to an individual character value or its norm.

The primitive-to-coprime transfer in `ArcChars:379-440` first pays the inner removal of 1e-15*x, multiplied by at most sqrt(c)<516 in the Gauss-weighted bound. The outer additive removal is paid later in the full residual. The author includes both; neither is discounted by the support count without proof. Inversion preserves the conductor, and qt(c)<=qt(q) transfers the twist domain. For odd c induced into even q, the stronger 2c<=q is retained.

The resulting bounds b_odd<5e-7 and b_even<9.94e-7 imply

    Eplus < max((5e-7)^2,(9.94e-7)^2/2)
          =4.94018e-13.

At q=1,2 the nonprincipal sum is empty. The principal and removal parts still apply. No principal character is incorrectly counted as a supported even primitive term.

## All source errors and the continuum of each band

`Prop942.errP:50` consists of the origin contribution, E1/sqrt(x), E2, and the vertical term. `prop_9_4_2:76` accepts explicit GRHUpTo at the working height and requires T>=200+max(10*pi*|delta|,50). Here T-200>=255 and u>=19.1, so that domain is satisfied. At delta=0 the source EA term uses its explicit zero branch.

The E1 and count functions are nondecreasing in positive T. Their comparison to the already checked larger fallback endpoint gives E1<=7.66e6/sqrt(c) and Z3g<=177.26. This is a comparison of upper-bound functions, not a reuse of an unavailable larger RH premise. Since sqrt(x)>2.21e13, the scaled E1 contribution is <3.47e-7. The origin and vertical contributions are independent of T and remain at most 1e-17 each after multiplication by sqrt(c); the original conductor, twist and x domains remain satisfied.

I checked the hypotheses of `Thm714.E2_gen_le:101` individually. T1=255 is at least 7 and at most T-200. Its shifted ratio is at least the selected u. Its growth bound follows from 11*4.4<=.09*455*1.2039, using `c3g_le`. The rhoB factor 2.1768 and smoothing factor 129.24 are unchanged.

`IA_le:210` gives IA<=1+3.1416*(|delta|+1)/8.492. The two rational coefficient bounds imply IA<=a+K/c with a=1.371 and K=393400. Expanding before taking conductor bounds yields

    (2Za+2Ca^2)*sqrt(c)
      +(2ZK+4CaK)/sqrt(c)+2CK^2/(c*sqrt(c)).

For L<=c<=U, positive sl with sl^2<=L and su^2>=U give exactly the displayed G(L,U). All coefficients are nonnegative. The overlapping closed bounding bands contain the actual half-open definition bands, including the threshold conductors. Thus this is a uniform inequality, not a check of the endpoints of a possibly nonmonotone unsplit expression.

I independently formed the positive exponential-series polynomial by a Horner recurrence. The inequality exp(z)>=P(z)^64 follows from the positive series at z/64 and the exponential multiplication law, for every nonnegative z. The exact EB and all eight EA comparisons pass. Source monotonicity extends them to larger T-200 and shifted ratios. Recombining the complete E2 expression, including the sqrt(c) bound in the EB term, gives <1.49e-7 for every odd band and <6.46e-7 for every even band. The factor 516 is a norm bound, not a count of characters.

Adding E1, both remaining source terms and the inner coprime removal gives the claimed b_odd and b_even. There is no illicit call to the old smaller-E2 guard in `errP_le_of`.

## Full residual and common-RH star/base-gap composition

Orthogonality of the principal constant vector to the centered nonprincipal vector gives the full residual bound after outer-removal Minkowski. The positive-radius comparison

    4.94018e-13+(2.83e-7)^2 < (7.58e-7-516e-15)^2

passes. Hence the proposed profile supplies rho=7.58e-7 and may safely use the older rho=8.85e-7 residual interface. It does not supply the old Eplus<=1.80625e-13 statement. Accordingly the old bundled upper-J proof with that smaller coefficient cannot be reused. The direct integrated-residual argument is the valid route: even rho=8.85e-7 satisfies 16*150000*19*rho^2<.006^2 and therefore retains X/x<=8.79 and the integrated principal norm 1.902e-6.

The height maximum is correctly handled. Since 19.1*3*1063200>54000000 and the odd comparison divides both sides by two, Hbase<=Hplus. Also 455>300 and 19.1*3>704/343 imply Hstar300<=Hplus. Ceiling monotonicity preserves both comparisons. The base-gap proof uses its own larger twist domain, not the star twist divided by 49.

Ordinary RH on the common closed carrier implies the weaker squarefree .5075 and nonsquarefree .62 strip conditions in the independently reviewed floor300 packet. Its count, remainder and source-transfer implications therefore give A<4e-12 and B<42<62. The stronger line-statistic estimates sqrt(A)<1.284e-6 and sqrt(B)<.004 also pass independently, but are unnecessary for sufficiency. The old rho=8.85e-7, A4e-12/B62 weighted-principal row fits the original star and cubic allowance. The integrated principal norm is added once. This composition does not depend on the direct B<1915 source sieve or on a new rounded-star allocation.

All eleven saved height examples were independently recomputed, including the threshold cases 96/100, 996/1000 and 9996/10000. The floor case c=265800 does not decrease, as reported. These examples do not establish a cost reduction in a particular producer schedule; the preceding uniform comparisons establish the mathematical domains.

## Evidence and remaining boundaries

Independent script: `audit/review_even_gauss_plus_height_20261111.py`, SHA256 `2C77007F10B463BC4EA851421662DD881E90D3A76512D6C3A3512086BAB5DA75`.

Independent receipt: `audit/review_even_gauss_plus_height_20261111.json`, SHA256 `0D585B04D0423B923D746320787AE6C7D7717F4E5D3660F3D584BD115404A726`.

All 64 exact checks passed. They verify the three frozen author pins, ten input pins, all eight expanded band estimates, positive polynomial bounds, source domain constants, removals, residual radius, height examples and the conservative common-RH star composition. The author script was neither imported nor executed.

Author source SHA256 is `0A2F8DE733652B502BE6F630273364FA07136A663FB8372DF6D9472AB8342079`; author receipt SHA256 is `EEFA6D42ACF703E65C456BA8DC2A6F678F20E288983E5CCD4CB0B85CDDD392AB`. Source pins include Thm714 `7BBF8F06B1A0B703A0C00FF1E5E64997792C4E93629CED591FCB6A646301FD3F`, Prop942 `35B170971DBD0F1C6646CD86ECE8C3A86021085C1B07730141CD6311D9CA5716`, and ArcChars `0A5BA0770CC02C94C0A802FF78FC297FE7B5776153516033ECC189331A6041CF`.

Actual finite-RH evidence, principal and finite arithmetic inputs, natural-R and one-sided lower/upper consumer refactors, source/kernel validation and final assembly remain obligations. The reviewed proof is a coherent conditional alternative, not an accepted runtime plan or a new final premise. No old frozen report was changed.
