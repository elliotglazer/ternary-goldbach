# Finite psi certificates at height 88000000

Date: 2026-11-11. Source and paper research with exact rational witnesses. No function, prime or zero evaluations, Lean builds, source changes or parameter search.

## Result and boundary

One fixed reuse attempt preserves 15 of the 22 original two-sided constants. The seven upper certificates for rows 15 through 21 fail; the lower certificates for rows 17 through 21 also fail. Rows 15 and 16 retain their lower inequalities. The first failed interval is [3.2e13,1e14]. All new domain conditions pass.

This is a precise obstruction to the retained certificate recipe, not a counterexample to any psi estimate. The obstruction persists with exact exponentials and even after deleting the entire nonnegative full tail above H. It comes from the retained mid-tail majorant 1142 exp(-delta^2 Y1^2/2), once the allowed window endpoint falls from 49 million to at most 43,999,987.

Consequently these seven upper certificates require changed parameters, a sharper analytic majorant, or a different proof. Merely computing the same formulas to greater precision, or improving only the full tail above H, cannot preserve all 22 constants. This note does not prove that retuning is impossible. No retuning is attempted. The existing principal RH-through-1e8 route and all its artifacts remain unchanged.

## 1. Exact source object and fixed experiment

Paths in the source discussion are relative to `work/ternary-goldbach/TernaryGoldbach/`. The actual source object is `Explicit/PsiRanges1e8.lean`, whose 22 declarations `psi_range8_0` through `psi_range8_21` cover all real x in [1e6,1e17]. Their conjunction is `psi_mid8:1188`, using the piecewise definition `cW8:1185`. The intervals are closed; the piecewise definition chooses the earlier interval at a shared endpoint. `Prelim/PsiTwoSided.cB:18` retains the small table below 1e6 and uses cW8 otherwise. `psi_two_sided:79` converts to the natural-number von Mangoldt sum.

The source has a blanket PlattGRH binder and calls `rh_upto_1e8`, but this experiment does not reuse that binder to infer RH through the missing annulus. The candidate premise is explicitly RHBelow 88000000. It is not established here and no replacement final-root hypothesis is introduced.

For every row retain the exact source values

    delta,K,y0,X,X',c,LU,E1,E8,Eh,q,sY,sYX,rX,rX'.

Only change H and Y1, and re-certify tau and mu:

    H = 88000000,
    Y1 = H/2-13 = 43999987.

This is the largest Y1 allowed by the retained radius-13 window theorem. Every row satisfies 3/Y1<=delta<=1/208. All old log, exponential and square-root witnesses remain statements about the same arguments. The new script also checks their rational geometric consequences, the cutoff y0*E1<=X, K*delta<=1, delta<=K and 0<=q<1. It does not rerun or claim kernel verification of those original elementary witness proofs.

The parser confines every row to its actual declaration and its `have hup := ...` application. It parses balanced argument parentheses and exact rational/scientific literals. The 22 indices and interval adjacency are checked. As a control, substitution of the old tau and mu reproduces both passing final inequalities for every row.

## 2. Why the analytic theorem applies below 1e8 on paper

The earlier accepted `PRINCIPAL_RH_HEIGHT_CONSUMER_AUDIT` proves the same off-line `OffC` bound and `weil_windowH` estimate for 2e6<=H<=3e10. The relevant positive polynomial in 1/H uses c3g<=36.6/H and Z3g<=210.6. The current Lean declarations still carry H>=1e8; no declarations have been changed.

The smaller lower endpoint propagates through the actual bodies as follows:

| Source | Use of the old lower-height condition |
|---|---|
| `Explicit/WeilWeights.lean:45–119`, `weil_weightedH` | Passed to `weil_windowH` at line 109. The remaining finite integration and positivity argument is unchanged. |
| `Explicit/WeilLineSum.lean:73–82,151–170` | Weighted-window application and exact low/mid finite-carrier partition. Equality belongs to the low side. |
| `Explicit/WeilNumB.lean:695–715`, `line_sum_closedH` | Passed to the preceding line-sum result. The integral-region estimate has no new lower-height requirement. |
| `Explicit/WeilNumC.lean:540–558`, `line_sum_numH` | Fixed radius 13 and the existing delta/Y1 conditions; lower height is passed through. |
| `Explicit/PsiWeil.lean:30–128` | The low finite sum uses that window result. The full-strip tail is the actual filter above H, not above 3e10, and requires H>0. Upper and lower unsmoothing pass through the height condition. |
| `Explicit/PsiRange.lean:151–310` | `psi_range_upH` and `psi_range_loH` apply these bounds and perform the displayed scalar comparisons. |

Thus the paper implication can use H88m once every remaining numeric premise is supplied. This propagation neither assumes critical-line location above H nor substitutes the new zero-free result for RH in the window. The accepted H88m plateau and zero-free candidates are not used to certify these finite rows.

## 3. Complete new tail witnesses

Let d=delta, t=4.4*d^2*H and r=t/(1+t). Since exp(t)>=1+t, the denominator rho=1-exp(-t) satisfies rho>=r>0. The proof of `PsiRange.TailBH_1e8_le:313–370` can be repeated with the variable H rather than its fixed bound 10.7. On the present domain,

    exp(d^2/2+|a|)<=2.7184 for |a|<=1,
    Z3g<=210.6,
    c3g<=36.6/H.

The last inequality follows from log(10/3)>=1.2039 and 36.6*1.2039>44. Hence a valid common full-tail allowance is

    tau = [2*2.7184/H] [421.2/r+(73.2/H)/r^2] E(d^2 H^2/2).

The unchanged nonnegative line sum satisfies LWH(H)<=1142 by `PsiRange.LWH_le:26`, so take

    mu =1142 E(d^2 Y1^2/2).

Here E is an exact rational upper witness for the negative exponential. Define

    S128(u)=sum_{n=0}^{128} u^n/n!,
    E(v)=1/S128(min(v,60)).

The positive exponential series gives exp(-v)<=E(v) for every v>=0. The finite polynomial is evaluated with rational arithmetic only. The cap at 60 is conservative for the low rows; no floating-point exponential is used. All denominators are positive.

Write J=.16385*LU^2-.4271*LU+7.2032+57.73*d and L=E8*(Eh+sY)*(J+mu). The exact upper and lower sufficient constants from the source are

    U=(E1/(1-q)-1)*rX' + L/(1-q) + tau*rX'/(1-q)
        +4*y0*E1/rX +253.3*E8/d/(1-q)*(1/X+sYX),
    D=(K*d+2*q)*rX' +2*y0/rX +L+tau*rX'
        +253.3*E8/d*(Eh/X+sYX).

All signs, the division by 1-q in only the upper bound, the distinct unsmoothing terms, and the Eh/X term in the lower bound are retained.

## 4. All 22 results

The decimal U and D entries below are upward rational roundings to six decimal places, not computed function values. The JSON retains every exact rational and margin. For passing rows both U<=c and D<=c are proved by integer cross multiplication.

| Row; declaration line | X to X' | Original c | U upper | D upper | Result |
|---|---|---:|---:|---:|---|
| 0; 20 | 1e6 to 3.2e6 | 32.84 | 32.838439 | 31.306880 | Both pass |
| 1; 73 | 3.2e6 to 1e7 | 31.88 | 31.874685 | 30.258865 | Both pass |
| 2; 126 | 1e7 to 3.2e7 | 31.48 | 31.474759 | 30.791999 | Both pass |
| 3; 179 | 3.2e7 to 1e8 | 31.35 | 31.347134 | 30.542081 | Both pass |
| 4; 232 | 1e8 to 3.2e8 | 31.66 | 31.652282 | 30.743869 | Both pass |
| 5; 285 | 3.2e8 to 1e9 | 32.16 | 32.159558 | 31.275764 | Both pass |
| 6; 338 | 1e9 to 3.2e9 | 33.06 | 33.057189 | 32.678271 | Both pass |
| 7; 391 | 3.2e9 to 1e10 | 34.10 | 34.095765 | 33.734980 | Both pass |
| 8; 444 | 1e10 to 3.2e10 | 35.44 | 35.432900 | 34.966298 | Both pass |
| 9; 497 | 3.2e10 to 1e11 | 36.94 | 36.931954 | 36.471567 | Both pass |
| 10; 550 | 1e11 to 3.2e11 | 38.72 | 38.715135 | 38.533874 | Both pass |
| 11; 603 | 3.2e11 to 1e12 | 40.61 | 40.604804 | 40.417403 | Both pass |
| 12; 656 | 1e12 to 3.2e12 | 42.82 | 42.812615 | 42.619217 | Both pass |
| 13; 709 | 3.2e12 to 1e13 | 45.08 | 45.070865 | 45.033221 | Both pass |
| 14; 762 | 1e13 to 3.2e13 | 47.58 | 47.579364 | 47.534517 | Both pass |
| 15; 815 | 3.2e13 to 1e14 | 50.27 | 50.324535 | 50.192050 | Upper fails |
| 16; 868 | 1e14 to 3.2e14 | 54.89 | 54.954290 | 54.823802 | Upper fails |
| 17; 921 | 3.2e14 to 1e15 | 61.38 | 65.114373 | 64.915506 | Both fail |
| 18; 974 | 1e15 to 3.2e15 | 73.30 | 77.132452 | 76.913463 | Both fail |
| 19; 1027 | 3.2e15 to 1e16 | 94.25 | 98.266727 | 97.956053 | Both fail |
| 20; 1080 | 1e16 to 3.2e16 | 132.50 | 136.784475 | 136.271971 | Both fail |
| 21; 1133 | 3.2e16 to 1e17 | 199.00 | 203.911694 | 203.029882 | Both fail |

For failing comparisons the stored downward rounding also exceeds c. The first receipt checks 178 exact statements, including all 44 old passing comparisons and the new domain conditions. Failure is retained as a result, not converted into a passing assertion.

## 5. A genuine fixed-envelope obstruction, independent of witness precision

To exclude the possibility that those failures are merely the chosen upper exponential witness, put v=d^2 Y1^2/2. For all seven rows 0<v<10. With T=v^128/128!, the positive series remainder gives

    exp(v)<=S128(v)+T*(v/129)/(1-v/130)=A(v).

Indeed the first omitted term is T*v/129 and all subsequent term ratios are at most v/130<1. Therefore

    1142/A(v) <=1142 exp(-v).

In each U,D formula replace mu by this LOWER bound and tau by zero. This lower-bounds the sufficient numerical envelope that keeps the factor 1142, even if its exponential is evaluated exactly. It does not lower-bound the actual LWH(H), actual line sum, or actual psi error.

The following are downward rational roundings of the resulting excess over c:

| Row | U with tau=0 minus c, lower bound | D with tau=0 minus c, lower bound |
|---|---:|---:|
| 15 | 0.054534 | -0.077951 |
| 16 | 0.064289 | -0.066199 |
| 17 | 3.602078 | 3.403211 |
| 18 | 3.595795 | 3.376806 |
| 19 | 3.598373 | 3.287700 |
| 20 | 3.536102 | 3.023598 |
| 21 | 3.588746 | 2.706934 |

Positive entries prove failure of that retained numerical comparison. Negative entries alone prove nothing about acceptance; lower acceptance for rows 15–16 instead follows from the complete upper witnesses in Section 4. The second receipt checks 21 exact statements and retains all rational lower bounds.

Since Y1 was already maximal, decreasing it only increases the retained exponential mid-tail envelope. Greater arithmetic precision, a smaller Y1 or an improved full-tail estimate alone cannot repair these positive excesses. A sharper estimate of the actual LWH(H) could change this conclusion; it would be new analytic input to the recipe, not a consequence of this calculation.

## 6. Downstream consequence without a circular theta argument

At paper scope the first 15 certificates provide the unchanged cW8 estimate through 3.2e13 from RH88m and the lower-height Weil adaptation. They do not provide the whole `psi_mid8` or `psi_two_sided` through 1e17. The source's coarse facts such as cB<=200 are arithmetic properties of its definition; keeping those definitions does not establish the missing psi inequalities.

`Prelim/ThetaExplicit.lean:148–151,386–398` uses the finite psi result to obtain theta estimates. Its final `theta_explicit:512` also needs the separate large-range psi branches. `Prelim/MertensProduct.lean:69–76` then obtains `psi_err` using theta and the prime-power discrepancy, and `E1_core:124–221` and `E1_local:262–329` use that error on an unbounded interval. Thus using the old theta or local Mertens theorem to fill these finite psi rows would conceal the very dependence being removed.

The H88m Mertens-window candidate explicitly retains `E1_local` as a prerequisite. Its unchanged Aloc/Bloc contain the bounds 1/log^3(M) and epl<=4.92e-7; its domain is every real t>=M>=M0>=1e12, without an upper cutoff. Passing these 15 rows alone does not discharge that prerequisite. The seven finite gaps and the separately retained unbounded psi scalar branches must still be resolved before any complete principal-height reduction. The accepted H88m plateau and zero-free results supply neither the missing finite-row comparisons nor a completed Mertens producer.

This branch stops at the fixed-recipe obstruction. There is no new height target adoption, source implementation, kernel-validity claim or cost saving.

## Evidence and source pins

The source hashes below bind the exact declarations and proof bodies inspected. The scalar scripts use only rational/integer arithmetic and source parsing; they do not import the original generator or call a special-function implementation. Their checks are external paper evidence, not Lean acceptance.

| File | SHA-256 |
|---|---|
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiRanges1e8.lean` | `26BDF0EEEAD4C7628B3205ECF1B52BB05A914E492A3721DCA6B784F6FE3C1120` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiRange.lean` | `69E94599D2120C5FCE3B737E623C2F355654FB5989CE0FF8E9A035513EB30037` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiWeil.lean` | `A7A27F44FDF35397EBBFD236D9BCE14458E8A8107C11AAD691EAA802C11BEA1A` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/WeilNumC.lean` | `34AAC46509116026B6A459EAFDE37005D5A45E0D291214B06A7587D72FC8C5DE` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/WeilNumB.lean` | `D5643FC76A2C7E4ECA88A4ACCC5EA8A959E8B77771572B511A464BF69460E356` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/WeilLineSum.lean` | `0F92B8BEDB16E53E0832D3E4D9C3E149273EDED69C2FC4CDCC3F4DE3444A5205` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/WeilWeights.lean` | `387B2A44441ADF94FF0EFF3ED3246370CD04D9766BCEE83035FE162B111F10E9` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/WeilWindow.lean` | `E62BC53DCE170675C2D4814FB47BBC92C5457103A2ABF4F0C66326BD4C2328BE` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiPlateau.lean` | `9138464FF2638DEEB39EAA58E7FB39F0CFD68895CE599CCB189EF3F6EE8F8D4D` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/ZetaZeroSums.lean` | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/ZeroSumGen.lean` | `9096C5D611A09FFCF5A4516BFDDC1E518B9917C52B5BC206216AF86A31A52389` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/PsiTwoSided.lean` | `9E2790AC0B3707D4A51B79735711BC9D7470694E8BFE6B96762E38F39F929E3C` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/PsiRangeCert.lean` | `74EB23FDE577B3F110BF0093B6B7B5C7EC208E4F610AED9A2DCCA5E478B0A298` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/ThetaExplicit.lean` | `F30571CFFF146129180D9A1865BAE879027CB5E1F9BCC4B3C8D1912983A45F93` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/MertensProduct.lean` | `8182DC2B990DC8D65AC76D3CC55847B26922E2062CD154C14367D5DB97F71A0F` |
| `work/qrh-campaign/agents/integration/finite_psi_88m_fixed_rows_20261111.py` | `9751A8EDD1BDF77BADFD86F148DEA3402F1FAA83279261A12E7D2585B5D3BDE2` |
| `work/qrh-campaign/agents/integration/finite_psi_88m_fixed_rows_20261111.json` | `315D523F9B98F8C1786BC99EB11EB0FBDFDA0CFA33D5F50FB7C4F56F9C0201CC` |
| `work/qrh-campaign/agents/integration/finite_psi_88m_midtail_obstruction_20261111.py` | `A778419539BE80812B0F15B5F08B0E3668A4A69815F97870B8E2B9F122176C08` |
| `work/qrh-campaign/agents/integration/finite_psi_88m_midtail_obstruction_20261111.json` | `C835A92CD445CD35D39DC820C4ABEAF02A38851ED76EDCFF17A5A733C3D011B1` |
| `work/qrh-campaign/agents/integration/PRINCIPAL_RH_HEIGHT_CONSUMER_AUDIT_2026-11-11.md` | `207EEAF68F7FB51351B4C37E991A09664F1B7852CCE29D82C75B2D4B8B776D63` |
| `work/qrh-campaign/agents/moebius/REVIEW_PRINCIPAL_RH_HEIGHT_CONSUMER_AUDIT_2026-11-11.md` | `30736389905515E2AA502E924A299DCBEB4CBE6F9151477838592FA87B4E69D9` |
| `work/qrh-campaign/agents/integration/PRINCIPAL_JOINT_PLATEAU_CANDIDATE_2026-11-11.md` | `CDE39E8AFDB868AFE2F5258BD154C79A36D43F1DBB0EE527DA633BD452EC0BB8` |
| `work/qrh-campaign/agents/moebius/REVIEW_PRINCIPAL_JOINT_PLATEAU_CANDIDATE_2026-11-11.md` | `5D4644C42C506CBA3503DABEC1D586678D4A6CD75F380AC2DECA5D72CE9C0251` |
| `work/qrh-campaign/agents/integration/PRINCIPAL_ZERO_FREE_88M_CANDIDATE_2026-11-11.md` | `C2B2BEDA22F72218AA4977368F5CA77D504DA4F58EF7881B3087EA9ECC9B7045` |
| `work/qrh-campaign/agents/moebius/REVIEW_PRINCIPAL_ZERO_FREE_88M_CANDIDATE_2026-11-11.md` | `E13CC72D1F5831CBBAEB44A7682F4CFE54620090F604F4D52ED579D6DE39BD22` |
| `work/qrh-campaign/agents/integration/MERTENS_WINDOW_88M_CANDIDATE_2026-11-11.md` | `8563FF50361538BCB78CA86F5F89ECF6C4D9490D006E098A2D4BEB35C70992F3` |
