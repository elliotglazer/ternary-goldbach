# Independent review: weak second-choice totient estimates

Research review, 2026-11-10. No Lean compilation or source changes.

**Verdict: the proposed weak second-choice bound and its separate H2 transport/layer budget pass the paper and source audit.** This result is conditional on the other analytic inputs to the raw Type I/II theorems, the finite exact totient theorem, and the first-choice totient repair. It does not remove the separate large-sieve totient dependency or certify any Lean declaration.

Reviewed files in `agents/independent-feasibility`:

- `SECOND_CHOICE_WEAK_TOTIENT.md`, SHA256 `FF5A0A1402C721D57EBB06193D925F0B9FB2D619975D40AC0F3A211F15F70AF4`.
- `second_choice_weak_totient_check.ps1`, SHA256 `F902A9AFC4388F670468AA6EAF9B458917CD0A78A756D0E5DDC3CDDFC523228F`.

All source paths below are under the pinned `work/ternary-goldbach/TernaryGoldbach/MinorArcs`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

## Exact scope and denominator domains

Write B=2^1000, S=2^500, z=T^3 and L=log T. `SecondFinal.lean:72-73` obtains a fresh approximation with denominator q'<=Q2(T)=T^2/349. This is not the original denominator. `SecondChoice.second_case_split` preserves that fresh approximation in cases a and b and supplies a second approximation with the larger original Q in bridge case c.

The elementary estimate v=q'/phi(q')<=2(q')^(1/4) therefore implies v<=2sqrt(T) in every case. At T<=S all fresh denominators are below B, so the finite exact theorem supplies the old logarithmic helper inequalities at their original comparison radii. Those radii must not themselves be restricted to B. The repaired first-choice theorem handles the bridge's use of the first branch. At T>S the new weaker bounds are used instead.

The raw estimates retain their other assumptions. In particular, reusing them here is not a claim that their prime or Mobius inputs have been replaced.

## Raw Type II terms

I compared the expressions against `TypeIILarge.lean:566` (`typeII_638`) and `:620` (`typeII_641`), and their actual instantiations in `SecondTypeIIa.typeII_a1` and `SecondTypeIIb.typeII_b`. The four terms M1, M2, M3 and M4 are all accounted for.

### M1, case a1

The exact prefactor is 4T^3/sqrt(8phi(q')). Since q'>T/6 and v<=2sqrt T, its square after division by T^(11/4) is at most 24<25. Thus the factor 5 is valid.

The source hypotheses 16q'<=X=T^3/U make both the first logarithm and the log-log difference nonnegative. The bounds log(X/(16q'))<=2L, log(2q')<=3L and the log-log difference <=log(2L)<=2L give A<=8L^2. Here dropping the subtraction loglog8 is in the upper-bound direction because it is positive.

The last term in D uses the source constant `zeta3<=27`, not the Riemann-zeta value at 3. As q'>T/6, sqrt(T^3/(16q'))<=T. With U>=1224.99T, its contribution is <=54/1224.99<.05. Hence D<=5L. This gives M1<=5sqrt(40)L^(3/2)T^(11/4)<40L^2T^(11/4).

### M1, case b

Here d=|delta'|q' satisfies 4T/3<d<=349T (`b_facts`), epsilon<=.142451, and c=d(1+epsilon)/4. The source's prefactor is exactly 4T^3sqrt(v/d); it is again <5T^(11/4). No factor 2 is lost in converting from phi(q').

The source parameters imply X/(8d)>1, c<=99.68T<=T^2, and 8d/c>28. Thus the logarithms have the required signs. The note's A<=6L^2<=8L^2 and D<=5L follow as stated. The same M1 bound is valid.

### M2, both cases

The common source prefactor is 4sqrt(kap1*v*T^3/2)<=4T^(7/4), using kap1<=.24083<1. The logarithmic auxiliary c is 2q' in a1 and d(1+epsilon)/4 in b. In a1, X/c>=8. In b, X/c>=T/(1225*99.68)>49 at T>=6e6. Therefore log(X/c)>=1, so the inverse logarithm inside the square root can be removed in the upper-bound direction.

With sqrt(c),sqrt(X)<=T, sqrt(log c)<=2sqrt L and e<3, the bracket is at most 2T+20T sqrt L<=22T sqrt L. Consequently M2<=88L^2T^(11/4). The exponent 11/4 includes both the T^(7/4) prefactor and the T from this bracket.

### Retained M3, M4 and case a2

The statements and proofs of `a1_M3_le`, `b_M3_le`, and `a1_M4_le` bound the remaining raw expressions without a totient estimate. Their displayed coefficients match those used in the note. The proposed loosenings are valid for L>=15.6:

- In a1 the four inner contributions are at most 12sqrt L, 2L^(3/2), 4sqrt L and 2sqrt L. Their sum is <=20L^(3/2), and the outer factor 4*.49075 is <2.
- In b the corresponding contributions are at most 8sqrt L, 2L^(3/2), 4sqrt L and 2sqrt L, giving the stated 32L^(3/2) after the outer factor.
- The exact M4 coefficient 8*1.4262*1.73207*sqrt(.24083*.50001) is <32.

Thus M3+M4<=72L^2T^(5/2), and 40+88+72=200 proves the advertised bound after using T>=1. The case a2 estimate in `SecondTypeIIb.lean:21` comes from `typeII_639`, whose raw bound has no phi factor; its retained 1.413L^(3/2)T^(5/2) bound is smaller. No second-choice Type II branch is omitted.

## Type I and exact assembly

`SecondTypeI1.typeI1_second` uses the totient bound in its bracket hbr. The exact term is 2q'/phi(2q'), not v itself. The source proves 2q'/phi(2q')<=2v, so the new bracket <=4sqrt T+2.67+2L is valid. Its multiplier is at most 3T^2 by `xq_delta0_le` and `minInv_le_delta0` in both cases a and b.

The retained tB, tC and tD bounds match the source, including `b441_second`'s coefficient .0407L^2+.1417L+.0155. Their addition gives

    |S_I1| <=12T^(5/2)+(.0407L^2+6.1427L+9.8669)T^2.

`SecondTypeI2.typeI2_second` combines `b450_second`, `b451_second`, and `b452_second`. Its retained .031L^2+3185.8L+8455.3 expression does not use the changed logarithmic totient helper. It still depends on the raw theorem's separate analytic inputs.

The assembly at `SecondFinal.lean:96-109` includes 3log(T^3)=9L. Summing every term, dividing by T^3, and using L,T>=1 produces coefficient

    200+12+.0717+3191.9427+8465.1669+9
      =11878.1813 <12000.

The weak normalized bound 12000L^2T^(-1/4) therefore follows in cases a and b.

## Bridge case

`SecondBridge.bridge_le` establishes T/3.0001<=t<=T/3 before using the sharp totient estimate. The replacement uses the repaired theorem `FirstChoiceFinal.theorem_3_1_1_first`, retains these t bounds, and replaces only the subsequent totient control.

At T>S, the same elementary logarithmic argument as in the H1 review gives R(T^3,t)<=log t<=L. The first normalized term is at most (L^2+.8764)*sqrt(2sqrt T)*sqrt(3.0001/T)<6L^2T^(-1/4). The second is <5T^(-1/2). The L_t term has its actual factor 2/t; bounding its bracket by 73.35sqrt(T)L and 2/t by 6.0002/T gives <441LT^(-1/2). Finally the source's 3.8T^(-1/2) is <4T^(-1/2).

Thus coefficient 456 is valid. It is below 12000 and does not use `div_totient_le_loglog`. The bridge is included in the all-branch conclusion.

## H2 transport, including every convolution scale

The new envelope is H2(r)=12000 log^2(max(r,S))/max(r,S)^(1/4). Its plateau is continuous; it is nonincreasing, while rH2(r) is increasing. These are the same elementary derivative checks as H1, with no factor 2 inside the logarithm.

The crucial inequality comes from the level hypothesis, not from a first-branch radius bound. If n<=y^(1/3)/6 and m=min(1,w)n, then

    m <=(wy)^(1/3)/6=T/6.

For w<=1 this follows from w<=w^(1/3); for w>=1 from 1<=w^(1/3). It holds even in the second branch. For T>S, max(S,m)<=T and the decreasing function E(T)=12000(log T)^2T^(-1/4) gives E(T)<=H2(m). For T<=S the finite-denominator proof supplies the original hfun bound. H2(m)<=H2(n)max(1,1/w), so integration over all w>=670/n costs at most 1.398H2(n). The existing small-w tail is unchanged.

Combining first and second branches uses max(g+H1,h+H2)<=max(g,h)+H1+H2. This is valid because both envelopes are nonnegative. No gap in w, no large-w cutoff, and no unproved bound on the fresh denominator are introduced.

## Separate full layer budget

The exact source-weight calculation from `GLOBAL_TOTIENT_TAIL_REVIEW.md` applies to H2. Put Ls=log S and C2=12000S^(-1/4). The initial term contributes at most 45C2Ls^2. The middle sum contributes at most

    3C2[Ls^3+4Ls^2+32Ls+128].

For the actual asymptotic witness m=floor(y^(1/4)), log x<4+4log(2m)<8+4log m. The derivative of H2(m)(8+4log m), above S, has the sign of -u^3+10u^2+16u, negative for u>=12; here u>=log S>12. The terminal term is therefore <=C2Ls^2(8+4Ls). The finite cells satisfy the same bound because log x<235.

Hence the polynomial is **7Ls^3+65Ls^2+96Ls+384**. Coefficient 65, rather than the parent's sharper possible 64, is correct for the chosen terminal constant 8 and does not weaken the conclusion materially.

I ran the author's script successfully and independently checked the integer reduction:

    P(350)=308121484,
    16800*P(350)=5176440931200,
    5176440931200*10^24 <2^125.

Using Ls<350 and 1.398*12000<16800 proves the complete H2 cost <1e-24. Its floating diagnostic is 1.2169754143981723e-25 and is not needed for the exact comparison. Adding H1's <1e-60 remains <2e-24, within the previously checked 1e-6 numerical allowance.

## Remaining obligations and conclusion

The new bounds account for all four Type II terms, Type I, the bridge, the fresh approximation, all convolution scales, and the initial/middle/terminal layer contributions. I found no mathematical defect in the stated conditional route.

Formal work remains for the finite exact totient theorem, the first-choice repair, each weakened raw bound and its assembly, H1/H2 calculus and transport, and the consuming numerical theorem. Other prime and Mobius premises of the raw estimates and the base-gap theorem remain separate.

There is also a distinct global totient call in `LSQuot3.lean:121`: it bounds P/phi(P) for the product P of a varying prime set by applying `div_totient_lt` with comparison radius exp(V). The second-choice argument does not address it. Therefore the reviewed result is a paper removal of the identified pointwise Type I/II sharp-totient uses, not a full removal of global totient input from the Goldbach proof. No Lean declaration or axiom closure was checked.
