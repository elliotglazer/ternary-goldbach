# Independent review: fixed finite-psi certificates at 88 million

Date: 2026-11-11. Verdict: PASS as a fixed-recipe obstruction and conditional partial reuse result. No correction to the author packet is required. The complete principal RH-through-100-million baseline remains unchanged.

Author note: `integration/FINITE_PSI_88M_FIXED_CERTIFICATE_OBSTRUCTION_2026-11-11.md`, SHA-256 `2D56AC3B810BD991B000163A43F663242789A579279D46D7E12C990A7CE63C14`.

## Independent evidence and exact scope

I read the two scalar programs and the actual upper/lower source formulas, representative complete row proofs, final closed-interval assembly, and lower-height propagation interfaces. I separately parsed both the `hup` and `hlo` application arguments in every one of the 22 declarations, checked their common values agree, and compared them with the stored inputs. Independent rational code using explicit factorial polynomial sums then reproduced all old and new envelopes, their margins and directed display roundings, and all seven obstruction rows. All 26 source/support hashes in the author's ledger matched, as did the author note hash. No author program was imported or executed. No special-function, prime or zero values, builds, source edits or parameter search were performed.

The result is exactly:

| Rows | Upper comparison | Lower comparison |
|---|---|---|
| 0–14 | Pass | Pass |
| 15–16 | Fail | Pass |
| 17–21 | Fail | Fail |

“Fail” refers to a stated sufficient numerical comparison. It does not mean the corresponding psi inequality is false. The retained source log/exponential witnesses are still required; checking the reused rational arguments and inequalities is not a fresh kernel verification of those old witness proofs.

## Source formulas, parameters and full coverage

Paths in this section are relative to `work/ternary-goldbach/TernaryGoldbach/`. `Explicit/PsiRange.lean:151–160` and `246–256` give the exact upper and lower hypotheses. The author's U and D agree term by term. In particular, only U divides its line, tail and vertical terms by 1-q; U has `4*y0*E1/rX`, whereas D has `2*y0/rX` and the different vertical term `Eh/X+sYX`. The lower leading term is `(K*delta+2*q)*rX'`, not the upper exponential expression.

All unchanged arguments were recovered from the actual applications in `Explicit/PsiRanges1e8.lean`, including the matching lower applications that the producer parser does not itself extract. The experiment changes only H to 88000000, Y1 to 43999987, and the tau/mu witnesses. The old 44 scalar comparisons pass under their original tau/mu. Every new row satisfies the window, delta, cutoff, root-witness, positivity and q<1 conditions. The interval endpoints are adjacent from 10^6 to 10^17. `cW8:1185` assigns a shared endpoint to the earlier interval; `psi_mid8:1188` uses the closed source ranges. Thus the first 15 passing rows give the unchanged piecewise bound through the closed endpoint 3.2*10^13, not the full 10^17 result. The next interval is [3.2*10^13,10^14]. Its failure does not remove the already covered common endpoint.

The lower-height source adaptation remains explicit. The reviewed `PRINCIPAL_RH_HEIGHT_CONSUMER_AUDIT` and its independent review justify the generic off-line window bound for 2*10^6<=H<=3*10^10. In the subsequent chain, `WeilWeights:109` passes the lower-height hypothesis to `weil_windowH`; `WeilLineSum:151–167` splits the actual finite carrier at Y1 and combines the low and middle estimates; `WeilNumB:697–715` and `WeilNumC:540–558` pass this through their integral estimates. `PsiWeil:53–70` then splits at H, using actual RH only on the closed low carrier and the full-strip tail on the complementary filter. Equality belongs to the low side at both splits. No annulus or multiplicity is discarded, and no location information above H is supplied by the candidate zero-free theorem. The currently written Lean declarations still retain their old H>=10^8 binders; new paper adapters are required before these rows could be formalized at H88.

## Upper witnesses and the precision-independent obstruction

For v>=0, the polynomial S128(min(v,60)) is positive and is no larger than exp(v). Its reciprocal is therefore a valid upper witness for exp(-v), including the capped large-v case. There is no numerical exponential call. The tail uses the complete source TailBH shape: with t=4.4*delta^2*H and r=t/(1+t), the inequality exp(t)>=1+t gives 1-exp(-t)>=r>0. Both `421.2/r` and `(73.2/H)/r^2` occur, and the prefactor is `2*2.7184/H`. The bounds on Z3g, c3g and the exponential prefactor follow from the same source arguments with the new H; the old height-specific 10.7 constant is not reused.

The middle witness is mu=1142/S128(min(delta^2*Y1^2/2,60)). `PsiRange.LWH_le:25` proves an upper bound of 1142 through an analytic window sum. It does not say that LWH equals 1142. This distinction is essential in the obstruction proof.

For each of rows 15–21 put v=delta^2*Y1^2/2. The exact checks give 0<v<10. The first omitted term after degree128 is v^129/129!, and each subsequent ratio is at most v/130<1. Therefore

    exp(v)<=A(v)=S128(v)+(v^129/129!)/(1-v/130),
    1142/A(v)<=1142*exp(-v).

U and D are increasing in mu and tau because all their multipliers are nonnegative and 1-q>0. Replacing mu by this lower witness and tau by zero thus lower-bounds the recipe that retains the fixed factor1142 and all other source row witnesses, even with exact exponentials and any nonnegative full-tail allowance. Independent reconstruction gives the following downward-rounded excesses over c:

| Row | Upper excess lower bound | Lower excess lower bound |
|---|---:|---:|
| 15 | .054534 | -.077951 |
| 16 | .064289 | -.066199 |
| 17 | 3.602078 | 3.403211 |
| 18 | 3.595795 | 3.376806 |
| 19 | 3.598373 | 3.287700 |
| 20 | 3.536102 | 3.023598 |
| 21 | 3.588746 | 2.706934 |

All seven upper lower-bounds are strictly positive. The last five lower lower-bounds are also positive. Negative lower-bounds for rows15–16 do not certify success; their lower comparisons pass using the independent complete upper witnesses instead.

Y1=H/2-13 is maximal for this fixed radius-13 window interface. Decreasing a nonnegative Y1 increases the retained exponential middle allowance; it cannot repair these positive excesses. Increasing arithmetic precision or improving only the nonnegative full tail cannot repair them either. Changing the factor1142, any other retained row witness, the smoothing parameters, the radius/window theorem, or the analytic bounding method lies outside this conclusion. In particular, the lower bound is not a lower bound on LWH, the actual zero sum, or the actual psi error.

## Remaining obligations and frozen pins

The original `Prelim/PsiTwoSided` table definition and its coarse arithmetic bounds do not prove the missing analytic rows. The actual theta and local-Mertens consumers need these finite estimates and their separate unbounded branches. The newly reviewed 88-million Mertens window still assumes the actual E1_local inequality, so using its original Platt-dependent producer to fill the missing rows would be circular. The separate plateau and zero-free results do not resolve this fixed finite-row obstruction. No complete new principal-height target or end-to-end cost saving is established.

| Artifact | SHA-256 |
|---|---|
| Fixed-row script | `9751A8EDD1BDF77BADFD86F148DEA3402F1FAA83279261A12E7D2585B5D3BDE2` |
| Fixed-row receipt | `315D523F9B98F8C1786BC99EB11EB0FBDFDA0CFA33D5F50FB7C4F56F9C0201CC` |
| Obstruction script | `A778419539BE80812B0F15B5F08B0E3668A4A69815F97870B8E2B9F122176C08` |
| Obstruction receipt | `C835A92CD445CD35D39DC820C4ABEAF02A38851ED76EDCFF17A5A733C3D011B1` |
| `Explicit/PsiRanges1e8.lean` | `26BDF0EEEAD4C7628B3205ECF1B52BB05A914E492A3721DCA6B784F6FE3C1120` |
| `Explicit/PsiRange.lean` | `69E94599D2120C5FCE3B737E623C2F355654FB5989CE0FF8E9A035513EB30037` |
| `Explicit/PsiWeil.lean` | `A7A27F44FDF35397EBBFD236D9BCE14458E8A8107C11AAD691EAA802C11BEA1A` |
| `Explicit/WeilNumC.lean` | `34AAC46509116026B6A459EAFDE37005D5A45E0D291214B06A7587D72FC8C5DE` |
| `Explicit/WeilLineSum.lean` | `0F92B8BEDB16E53E0832D3E4D9C3E149273EDED69C2FC4CDCC3F4DE3444A5205` |
| `Explicit/WeilWeights.lean` | `387B2A44441ADF94FF0EFF3ED3246370CD04D9766BCEE83035FE162B111F10E9` |

The remaining source/support hashes are bound by the verified 26-entry author ledger. The lower analytic foundations, existing finite arithmetic proofs and implementation of the relaxed-height adapters remain separate from this bounded review. No further parameter search was undertaken.
