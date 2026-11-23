# Independent review of the common Tplus assembly

2026-11-11. PASS at conditional paper/source assembly scope. No correction requested. This review binds `independent-feasibility/GLOBAL_FINITE_RH_TPLUS_PAPER_ASSEMBLY_2026-11-11.md`, SHA256 `24E1A29A0FEAFFA297159DAE04CDD0613C5A38757F5F44B63B01A2B5E5D1280A`.

I read the complete assembly and the independent plus, base-gap, weighted-principal and exact-source-mass reviews. I rechecked the actual `GRHUpTo` definition and restriction theorem, the `MinorTotal` split consumer, and the integrated cubic identity. The floor300 and mixed-star components were independently reviewed in this directory earlier. This review joins those results; it does not repeat their entire analytic proofs or certify any finite spectrum. No author code, analytic evaluator, Lean build or numerical zero computation was run.

## Domain and height union

`MajorArcs/GRH.lean:32-37` quantifies over actual L-function zeros with strict real strip and closed absolute imaginary height. Its monotonicity theorem restricts this property to any smaller real height. The assembly retains both signs, real nontrivial zeros and the closed endpoints. It does not turn a zero-free boundary, sign sample or incomplete zero list into this predicate.

The stated conductor domain is sufficient. For c=2d with d odd, reduction of units modulo 2d to modulo d is an isomorphism. Every character therefore factors through d, a proper divisor, including c=2. This excludes primitive conductors of exact 2-adic valuation one algebraically. Implementing that exclusion remains a formal adapter. Conductor one remains the separate principal case. Inversion preserves the primitive conductor.

For c dividing an ambient modulus m, the proof of qt(c)<=qt(m) handles all parity cases. In the only nontrivial case, c is odd and m even, so m/c is an even positive integer and m>=2c. Thus the original modulus, rather than the denominator after doubling a phase, gives the required twist range. This also covers imprimitive ambient labels; zero Gauss coefficients need no special exclusion.

The height comparisons are comparisons before applying the same ceiling function. The exact lower coefficient 19.89*3*531600=31720572 exceeds 27000000. Also 19.89*3>704/343 and the plus height is at least460. Therefore Hbase and Hstar are both at most Tplus. No extra ceiling unit belongs in these two comparisons. The exceptional even-conductor coefficient is already the smaller one used throughout the proof.

The additional comparison Tplus<Hold is attributed to the reviewed plus calculation, which pays the full ceiling overshoot on each of its four conductor ranges. It compares positive numerical bound functions and does not assume RH between the two heights. Exact checks reproduce Tplus(4)=19456569 and Hstar(4)=545549. A larger certificate asserting only beta<=.62 would not substitute for ordinary finite RH. Here beta=1/2 supplies every smaller-carrier location requirement.

## The three quantitative joins

The plus implication is accepted through `audit/REVIEW_PLUS_FINITE_RH_HEIGHT_REDUCTION_2026-11-11.md`, SHA256 `55690D3DE67252888EB84C29F40674CAA126E3C5B4E43F4D56CB3AD20421A4E9`. That review checks the actual explicit-height Prop942 input, all four error terms, the new high tail, and primitive-to-ambient transfer. The resulting weighted coefficient bound4.25e-7 gives Eplus<7.02e-13 after the factor1/phi and the finite character count cancel. It does not acquire another factor phi. The retained principal and outer-removal terms then give the reviewed residual sum with rho=8.85e-7.

Integration of this already-summed residual gives Z/x<.006 squared. The exact check uses16R*rho squared*19, without a second numerator count. The Fourier main term gives Yp/x<2.951 squared, so Minkowski gives X/x<2.957 squared<8.79. These physical-to-normalized conversions agree with the weighted-principal contract.

For star, restricting the common RH property to Hstar retains the smaller complete carrier used in the floor300 count calculation. It does not replace that carrier by all zeros through Tplus. The earlier independent floor review `422940369A04ED695A45EF28F20F154349932CEBC0242EEEE15FF3373D5CE6A4` checks the full-strip high tail below5e-15 and the complete remainder below2e-12. The mixed-profile review `8713202EA752207E7B0C5DC80FD6A68BD7A3A1FC5DF30E5F44BF9B1D252E30FD` checks the finite weights, multiplicities and all-scale powers. Ordinary RH supplies the stronger line location; weakening its line comparisons by12/5 and10^6 is legitimate. With the displayed rounded count bounds the exact squared comparisons give A<4e-12 and B<6.48 squared<42<62.

The full Wstar bound includes the integrated principal term1.902e-6. It is not a pointwise constant and must not receive another factor sqrt(j). The reviewed A4e-12/B62 allocation fits j*(3.67e-6) squared. All principal and removal terms are present. The Wplus inequality uses the same plus residual and the actual star Fourier main term.

The identity Sp squared*Ss-Ap squared*As=Sp squared*(Ss-As)+As*(Sp-Ap)*(Sp+Ap), followed by Cauchy-Schwarz and Minkowski, gives the displayed integrated error. Its rational AM-GM majorant is exactly the old cubic allowance. Thus this substitution does not spend any of the final joint margin. The physical arc partition, Fourier tail and source main-term estimates remain separate requirements.

The base-gap implication is accepted through `integration/REVIEW_BASE_GAP_REDUCED_FINITE_RH_HEIGHT_2026-11-11.md`, SHA256 `2E902497CE7445F78CEF7A2F229D0A9042FAF4FB573AB1A01B79D05331635076`. That review checks the original parity-specific geometry, scale y=x/49, four explicit-formula terms and the full-strip high tail. The common conductor restriction supplies its finite-RH premise. The Gauss square cancels the conductor factor, and vector Minkowski pays2e-9*sqrt(phi(m)) for the coprime restriction. Since phi(m)<=265800<516 squared, the resulting bound is .024001032. Adding the separately retained terms gives .024547036<.03. The independently reviewed lower ghat envelope435635673/13700000000 exceeds .03.

`MinorTotal.lean:395-403` confirms that the split needs y*ghatY at the base radius. The old hardcoded gap wrapper is one way its current source supplies this; it is not the required mathematical threshold. The replacement must adapt this split at R132900 and use the direct ghat bound. Passing .024547036 into an unchanged .014 or .0121 wrapper would be invalid. The assembly explicitly avoids that error. Principal cases m=1,2 remain covered separately.

## Final budget and retained obligations

The source-mass review `0B224BB58D88D63D9F787D88CA1CB33CA85C411DB8B733307064AE8D82EA84BD` independently reconstructs the nine cells and asymptotic branch using the saved rational enclosures. Its c_132 checkpoint and nonnegative monotonicity give exactly the mass fraction in the assembly. I independently checked the conversion to lower I and its exact fraction537129254732779210450233/62500625000000000000000.

The quoted final margin is identical to that reviewed joint major-minus-minor-minus-nonprime margin and lies strictly between .0013565 and .0013566. I did not regenerate the nine analytic cell enclosures here. Reusing their margin is justified because the new plus/star implications preserve the same cubic allowance, and the new gap implication meets the actual ghat premise. The old independently rounded minor number1.0376 is unnecessary and is not claimed.

The all-scale statement retains the reviewed xOf relation at N0=989*10^24. Restricting its large-N consequence to1e27 is legitimate. The original inclusive BinaryGoldbachInput through4e18, its finite coverage and overlap, principal RH through1e8, exact head/reciprocal data, source constants, and the unbounded arithmetic descendants remain obligations. This assembly proves none of those inputs. Nor does it establish a global QRH provider or use one as a substitute.

The required source refactors remain explicit: natural-R geometry and energy statements, principal-only localization, direct ghat consumption, integrated cubic assembly and the final joint scalar argument. Invoking current blanket Fact PlattGRH wrappers would not implement the proposed dependency reduction. This is a reviewed conditional route, not a compiled or standard-axioms-closed end theorem.

## Independent evidence

Own `review_global_tplus_assembly_20261111.py` performs53 exact checks: the author hash, all25 table pins, their table cardinality, and26 rational identity/inequality checks. Its SHA256 is `9C0C468ABE32F952513AFBB6AC96C79E4AC7D36C195D3EAAC98E5EEDD1785AA6`. It imports no author script and enumerates no spectrum or arithmetic family. The receipt is `review_global_tplus_assembly_20261111.json`, SHA256 `51034A55F2F466882CFA2236B1D2BCB2A413C8729910A6AE96F9333D7F6C714A`.

The checks support only the stated assembly and pin comparisons. Component reviews retain their own lower proof boundaries, and actual finite-RH certification still requires complete endpoint and auxiliary-height handling. No runtime, proof-size or computational advantage follows solely from this height union.
