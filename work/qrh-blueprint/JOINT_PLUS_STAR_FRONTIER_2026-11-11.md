# A joint plus and star error frontier

2026-11-11. Conditional paper and exact scalar calculation, pending independent review. This does not supply actual energies, finite RH, numerical certificates or a Lean/MM0 theorem. The purpose is to price a weaker plus estimate against the newly available direct bound B<1915 without introducing a separately rounded star parameter.

Use the actual functions, tagged arc measure and normalizations in INTEGRATED_CUBIC_RESIDUAL_CONTRACT and the independently reviewed PLUS_STAR_CUBIC_BUDGET_REALLOCATION. Retain R=132900, x>=4.9e26, y=x/49, j=8.79, the principal integrated norm p=1.902e-6, and

    C=914205504131/4687500000,
    E=64019155993729/312500000000000000.

Suppose the full plus residual obeys sum_b |r_b|^2<=rho^2, its integrated consequence Z<.006^2 holds, and the actual star energies satisfy A<=a^2 and B<=1915. The latter B bound retains the principal-only localization, coefficient and finite inputs from the reviewed source-sieve argument. It is not an unconditional numerical assertion.

The weighted principal argument gives the normalized full star norm at most p+a+rho*sqrt(1915). The physical cubic Cauchy bound and the existing rational plus envelope therefore give

    error/(x^2/49) <= sqrt(j)*(p+a+rho*sqrt(1915))+rho*C.

This follows directly by multiplying the full star norm by sqrt(X/x)<=sqrt(j). There is no further sqrt(j) on p inside the norm and no extra character count. No adverse cross term is discarded. The Fourier tail, base-gap requirement and final scalar margin are unchanged if the displayed expression is at most E.

For an entirely rational sufficient test, use sqrt(j)<2.965 and sqrt(1915)<43.762, both verified by squaring positive rationals. Then

    2.965*(p+a+43.762*rho)+C*rho <= E

suffices. It produces the following rows. Each chosen rho is the largest multiple of 1e-9 allowed by this particular rational envelope. This is not an optimum among all possible inequalities or proofs.

| A upper bound | Full plus radius rho | A sufficient nonprincipal plus energy cap |
|---:|---:|---:|
|0|6.13e-7|2.95679e-13|
|1e-12|6.04e-7|2.84726e-13|
|4e-12|5.95e-7|2.73935e-13|
|9e-12|5.86e-7|2.63306e-13|
|1e-10|5.22e-7|1.92394e-13|

The last column rounds downward the exact cap

    (rho-516e-15)^2-(2.83e-7)^2.

It uses orthogonality of the principal constant vector and centered nonprincipal vector, then pays outer removal by vector Minkowski. This is the same source-level identity as the reviewed reallocation. Every difference is positive. The A=0 row is a formal allocation endpoint, not a vanishing assertion.

All five rho values obey 16*150000*19*rho^2<.006^2. Hence the retained upper X and integrated principal arguments apply without changing their constants. This condition is checked independently of the cubic reserve.

Research consequence: A<=9e-12 permits rho=5.86e-7 while keeping B<=1915 and the original cubic allowance. A shorter plus-height argument may spend the difference from the previously available 5.12e-7. A alone becoming easier does not save a shared spectrum: the plus and base-gap requirements must also be reduced. Any changed height profile still needs its own analytic proof, completeness domain, scalar joins and operation inventory.

The exact checker check_joint_plus_star_frontier_20261111.py checks three source-report pins, both root witnesses, all five positive reserves, the next grid point's failure within this envelope, the Z constraint and exact energy caps. Its immutable JSON receipt is joint_plus_star_frontier_20261111.json. It uses only Fraction arithmetic and SHA256. No special function, zero, prime candidate or transform was evaluated, and no build was run. Actual A remains open; no certificate or runtime savings are credited by this note alone.
