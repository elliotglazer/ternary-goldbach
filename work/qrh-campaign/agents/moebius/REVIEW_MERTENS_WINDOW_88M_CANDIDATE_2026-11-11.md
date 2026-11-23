# Independent review of the 88-million Mertens window

Date: 2026-11-11. Verdict: PASS, with the local-variation prerequisite retained exactly. No correction to the frozen author note is required. This is a paper adaptation of the Gaussian-window part of the proof, not a theorem deriving the full Mertens output from RH88 alone.

Reviewed author: `integration/MERTENS_WINDOW_88M_CANDIDATE_2026-11-11.md`, SHA-256 `8563FF50361538BCB78CA86F5F89ECF6C4D9490D006E098A2D4BEB35C70992F3`. Scalar script: `A7F7ECA6A1582A9EFEA536279B428F9A0063E2DB46ED33071A75AB8680C1DEB7`. Receipt: `F41188D02C2C25CF3272760C64AEAE5E08BE1A29BE3B804E05FE0235031D1085`.

I read the actual small- and large-v edge proofs, the Mertens window identity and its numerical consumer, the local-bound producer, and the explicit Gaussian error definitions. Independent Fraction arithmetic reproduced all 12 stored rational values and passed all 20 comparisons. All eight source hashes and three author-packet hashes matched. I did not execute or import the author script, evaluate analytic functions, build Lean, or change frozen files.

## The new edge bound is for the correct measure and actual function

Paths below are relative to `work/ternary-goldbach/TernaryGoldbach/`. `Prelim/PNTMertens.lean:477` defines the actual E1Lambda as the finite von Mangoldt sum divided by its index, minus log(x). Its bounds at lines482 and500 follow from finite-sum/Chebyshev estimates, without a principal RH premise. `Prelim/MertensWindow.lean:127` gives E1Lambda(u)=-log(u) below 1.

The intermediate inequalities at `MertensWindow:521–530` therefore establish, for every real Y>=1 and 0<v<=1,

    |E1Lambda(Yv)-E1Lambda(Y)| <= C-log(v),
    C=2log(4)+8.

This includes Yv<1: then log(Y)>=0 and -log(Yv)<=-log(v). No local-variation assumption is needed on this side of the edge.

Crucially, `edge_le:548` integrates against ordinary Lebesgue dv on Ioi(0), not dv/v. `gsm_le_rpow:90` gives the nonnegative multiplier bound exp(1/2)*v^r, r=1/delta. For r>0,

    integral_(0,1] v^r dv=1/(r+1),
    integral_(0,1] (-log v)v^r dv=1/(r+1)^2.

For example, substituting v=exp(-u) introduces the Jacobian exp(-u), so the second integral is integral_0^infinity u exp(-(r+1)u) du. Integration by parts gives the displayed value; the boundary terms vanish since r+1>0. This also proves integrability, rather than using a formal improper antiderivative. Equivalently v^(r+1)log(v) tends to zero at the omitted endpoint. The singleton v=1 causes no measure or sign issue.

Both C-log(v) and gsm are nonnegative on this interval. Their product bounds the unsigned edge integrand. Consequently its integral is at most

    exp(1/2) [C delta/(1+delta)+delta^2/(1+delta)^2].

The existing exp-half and log-four bounds at lines535 and540 imply that this is <=17.77delta whenever 0<delta<=1/11000000. The exact largest coefficient used in the rational check is 244225616661/13750000000, strictly below 17.77. This is a uniform delta-range argument, not a numerical integration.

## The remainder of the edge argument is retained

The actual edge integrand is integrable by `MertensWindow:562–567`, using measurable E1Lambda and its Gaussian integrability. The source splits Ioi(0) disjointly into Ioc(0,1) and Ioi(1) at lines568–569; replacing the first bound leaves this complete split intact.

For v>1, write M=floor(Y). The proof at lines606–659 uses the local estimate twice, at Yv and Y, relative to the same M. Since M<=Y<M+1 and M>=1, log(Y/M)<=1/M. Then log(v)<=2sqrt(v), and the exact ordinary-dv Mellin moments give

    large edge <= (2A+2B/M) M1 +2B G,
    M1=exp(delta^2/2)(exp(2)-1),
    G=exp(9delta^2/8)(exp(3)-1)/(3/2).

Thus only 21.1delta changes to 17.77delta. In the numerical window consumer, integer x and Y>=x imply floor(Y)>=x, so the assumed uniform local estimate supplies exactly the two needed cases M=x and M=floor(Y). Positivity of A, B, M1 and both floor denominators is preserved. A bound only at M=x would not by itself justify the displayed reuse of this source proof.

## Complete Gaussian error and numerical recomposition

At H=88000000 and delta=1/11000000, delta*H=8. `Explicit/PsiExplicit.lean:199` requires H>0, actual RHBelow(H), delta>0, b<=a, b<=0 and y>=1; all hold for a=2,b=0,y>=10^12. The target smoothed sum and its mass M1 are exactly those in `MertensWindow.E1_window:363`.

The line term is bounded by the nonnegative analytic window sum through 3e10, with the same max(1/2,6m) denominator; no head-zero data are inserted. The sum bound571 yields LineB2H<4246.5. In TailBH the two terms are both retained. With t=4.4delta^2H and r=t/(1+t)>0, 1-exp(-t)>=r. The bounds Z3g<=210.6, c3g<=36.6/H, exp(-32)<=1.3e-14 and exp(2+delta^2/2)<=7.3892 give TailBH<3e-13. The c3 coefficient is recomputed at H, not copied from the old 1e8 specialization.

The vertical calculation retains 1/delta and the division by 2pi. Since y>=10^12, 1/sqrt(y)<=sqrt(y)/10^12; the stated rational expression is below .0044sqrt(y). Hence the complete ErrGH is <=4247sqrt(y)+3e-13y. The same elementary exponential estimates give M1>=6.389>0 and G<=12.724 at the new delta.

The actual window identity integrates the smoothed error with dy/y^2, giving 2*4247/sqrt(x)+3e-13 log(Y/x), and adds both unsigned edges. This is a different integral from the small-v edge above; neither measure is interchanged. The numerical recomposition in `MertensProduct:531–624` then gives exactly

    4A+4B/x+[8494/sqrt(x)+3e-13log(Y/x)+4BG+35.54delta]/M1.

For x>=10^12, log(x)>=27 implies B<=1/4. Substituting the unchanged Aloc and Bloc definitions at lines250–251 proves the original coefficients 1443,13,16 and 8.4e-6. The independent exact remaining constant margin is

    26703007/702790000000000 > 0.

The old 21.1delta edge estimate fails this particular final constant comparison at the new delta, as claimed. That failure says nothing about the actual error. The repaired result applies to every integer x>=10^12 and real Y>=x with log(Y/x)<=20001, including Y=x and the closed logarithmic endpoint, without an absolute upper cutoff on x or Y.

## Retained prerequisites and source pins

The premise is the actual uniform local estimate with A=Aloc(x), B=Bloc(x). The existing `MertensProduct.E1_local:262` is explicitly under `Fact PlattGRH`; its proof uses E1_core and global theta/psi estimates. This review does not replace that producer. Likewise `E1_var:639` has a separate E1_diff branch past exp(20000). The finite cB and unbounded psi work remains separate. The 88-million zero-free and plateau candidates are not needed as additional assumptions in this isolated Gaussian-window adaptation.

| Source | SHA-256 |
|---|---|
| `Prelim/MertensWindow.lean` | `DE134E2DE88E9B16D252F4AC2DB2E0F930A69E9CA2CF4DB45634F748E3934034` |
| `Prelim/MertensProduct.lean` | `8182DC2B990DC8D65AC76D3CC55847B26922E2062CD154C14367D5DB97F71A0F` |
| `Prelim/PNTMertens.lean` | `4AA483982E40BF82955B2D4A561FBC86D1206BDD5769B81B2EAFFBF25BED83E2` |
| `Explicit/PsiExplicit.lean` | `33A24C9E1606011AAC8930EC978BA027E90A2A66E0888DB18915ACC2FBF85BB1` |
| `Explicit/PsiPlateau.lean` | `9138464FF2638DEEB39EAA58E7FB39F0CFD68895CE599CCB189EF3F6EE8F8D4D` |
| `Explicit/PsiPlateau1e8.lean` | `F5BEB066695D24085A74706C9FFE3219A2A053E2C1854FC3E209BD0CD78E392C` |
| `Explicit/ZetaZeroSums.lean` | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| `Explicit/ZeroSumGen.lean` | `9096C5D611A09FFCF5A4516BFDDC1E518B9917C52B5BC206216AF86A31A52389` |

This source-level review accepts the new logarithmic edge proof and its conditional numerical window consequence. It does not establish complete principal-height reduction, a final-root closure, or elaborated axiom closure. Formal implementation of the new integral bound and threshold specialization remains outstanding.
