# Independent review of the small rational xi panel

**PASS at reviewed paper-analysis plus independently replayed exact external arithmetic scope.** All 929 producer node balls, all 12999 weight balls, the seven exact coefficient sums, and the whole-disk positive-real comparison passed. No correction to the frozen producer is requested. This is not a Lean proof or a generic verified checker.

## Frozen target and evidence

The target is F_b(s)=exp(-i*b*(s-1/2))*xiF(s), with the source's unhalved xiF, b=pi/4-1/33, center s0=3/5+14i, and closed disk |s-s0|<=1/64. The rectangle is [379/640,389/640]+i*[1791/128,1793/128]. Its corners have squared distance 1/8192<1/4096 from s0, so the entire rectangle lies in the disk. The quadrature uses h=1/256, K=928, V=29/8, and degree six. T_input=32 fixes b; T_work=14 bounds the coefficient center's height and is not substituted for T_input.

| Artifact | SHA256 |
|---|---|
| Producer backend `integration/rational_xi_panel_backend_20261111.py` | `DEE8AC9AA39F25023C77003BC2AAA5970388A016207AD5A8EE0DF8F6D912F84A` |
| Producer candidate `integration/rational_xi_panel_candidate_20261111_01.json` | `1B55E8A2665EF872056DE9747670E6F47017863A49D9E2C9A2D6604B6F74D09F` |
| Producer result note `integration/RATIONAL_XI_PANEL_CANDIDATE_RESULT_2026-11-11.md` | `B4D9BAECA29EC60B3B40ED7E17B3561A7EC6102C76CFBBD971D895DCAD44E35E` |
| Independent implementation `independent-feasibility/replay_small_rational_xi_panel_20261111.py` | `E7C235B05B18818E1C5F44E631BCD924021F2A21D3ADB6D94A2EFE7032C4E171` |
| Independent preparation plan `independent-feasibility/SMALL_RATIONAL_XI_PANEL_REPLAY_PLAN_2026-11-11.md` | `775A322650A79CE850D2AC6431551103D5D9B1084349430617998D8A20774BAC` |
| Complete independent receipt `independent-feasibility/small_rational_xi_panel_replay_20261111_01.json` | `A8C296D1150E79D928D4990B90D25D4C6BC1F359DC2A1CB89377309185E3C51B` |
| Coordinator's saved-data comparison `independent-feasibility/small_rational_xi_panel_comparison_20261111_01.json` | `720B4C7A021EB50421747CF6D7A889242995C26BD11D560A586230B87B89B9AC` |
| Separate saved-data audit code `independent-feasibility/audit_small_rational_xi_panel_saved_20261111.py` | `0D18A0E2B279432FC394CA18F736B751FBA4DAF6E5DD51450C9A66FF8642CDEB` |
| Separate saved-data audit receipt `independent-feasibility/audit_small_rational_xi_panel_saved_20261111.json` | `5166857F7F1434E3B685DB2BDBDEF664743C0077A32ACE47964E03A4F27E1430` |

The specification and its review are pinned in both programs at `92E778B5D9C767D18461CD0B239F94FD38B15023B13576FFBBC2EFFE8D00E957` and `2F05928D57B1E76F513095FE5CCA4D5930EF314EB658EE748016E52FBE84CC97`. The source composition is the reviewed node-substitution note `5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571` and modular plan `C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D`.

The producer source, result note and relevant rational helper definitions were read. The two producer code/data hashes above were independently recomputed and match. The author's frozen result note correctly records independent verification as pending at its freeze; a later review does not rewrite that historical status.

## Mathematical and implementation review

The elementary backend has no numerical transcendental input. Machin alternating bounds enclose pi; range-reduced Taylor bounds enclose real exponential and complex cis. The exponential cutoff is applied to each actual rational endpoint separately. An endpoint <=-384 receives [0,2^-384], then outward rounding; an interval crossing that threshold retains the independently computed upper endpoint. This is not exact replacement by zero. Its proof uses exp(1)>2, and every subsequent coefficient multiplication propagates the error. At the author's 320-bit working precision, rounding that upper endpoint to 2^-320 is conservative.

The reviewed exact reciprocal helper enumerates all coordinate extrema of 1/z over the full nonzero rectangle. It does not infer a set enclosure from point overlap. Square-root bounds follow integer square comparisons. For S, -i*t has strictly positive real part, and the constructed square root has positive real part; this fixes the principal branch. The branch's holomorphic derivative formulas come from the reviewed analytic identities, not from the numerical root identity alone.

Every word starts at classical theta3. A T step subtracts n, so theta2 reconstruction uses exp(+pi*i*n/4); theta3 and theta4 swap when n is odd, with no scalar phase. S swaps theta2 and theta4 and fixes theta3. The source ordinary derivatives obey

`f0=A*g0`,

`f1=A*(-g0/(2t)+g1/t^2)`,

`f2=A*(3g0/(4t^2)-3g1/t^3+g2/t^4)`.

The author applies the preceding constant T phase to all three entries after each reverse S. The independent implementation instead multiplies triangular matrices along the forward word and applies the accumulated matrix to the terminal jet. Both enforce the initial type and preserve each local branch factor.

Terminal stopping is certified at Im(t)>=2/5. The overlapping inversion guard is Im(t)<1/2, with a four-S cap and mandatory stop/refinement after the fourth inversion. The implemented producer does not silently infer Y>=1. Sixteen paired modes cover theta2, theta3 and theta4, with the correct half-integer/integer indexing, theta4 alternating sign, and constant term only for theta3/theta4 derivative zero. The 2^-277 terminal radius is the sharper fixed sixteen-mode bound proved in the specification review, not the weaker general tail formula at N=16. Padding both coordinate intervals by that analytic norm bound is safe; later interval and L1 calculations account for the resulting box geometry.

The actual P reconstruction is

`exp((v+i*b)/2)*(6*tau*theta3'(tau)+4*tau^2*theta3''(tau))`,

where tau=i*exp(2(v+i*b)). Thus the final phase is pi/8-1/66, and the real factor is exp(v/2). Expanding theta3 confirms coefficients -12*pi*n^2*exp(5w/2) and +8*pi^2*n^4*exp(9w/2) in the full kernel. There is no extra factor two, omitted phase, constant, or n=0 contribution.

Negative nodes use P(-v+ib)=conj(P(v+ib)), requiring both kernel evenness and conjugation. The zero node is counted once. Every signed weight is h*v^j/j!*exp((1/10+14i)*v); neither odd powers nor the real exponential are made even. At v=0, weight zero is exactly h and all six positive-order weights are exactly zero. Integer center products on grids 2^-32 and 2^-64 sum over denominator 2^96, with no summation rounding error.

The coefficient budget is the full Q_j+S_j+B_j+weight-error sum. The derivative Q_j retains its extra exp(1/66) factor, and S_j uses the threshold q*exp(2V)>=2. The product error split w(P-p)+(w-w_hat)p is exact; no cross term is missing. Terminal tails already reside inside each node radius and are not added again to the quadrature error. The Cauchy remainder uses the reviewed unit-disk majorant D and normalized coefficients F_b^(j)(s0)/j!. The total is below 0.091500568239<1/10 after rho weighting.

## Independent computation and consumed claims

The independent implementation was written before numerical execution and imports no producer algorithm. It uses 384-bit rational outward intervals, 160 Machin terms, 112 exponential terms after reduction to <=1/4, 192 cis terms, its own reciprocal and sqrt construction, and the forward matrix assembly. This differs from the producer's 320-bit, 128/96/160-term arithmetic and reverse unwind. Each may choose its own certified word for the same exact input. No built-in theta, zeta, Gamma, special-function library, Arb box, or previously computed coefficient is an acceptance input.

The completed comparison checked all 929 actual P claims and all 12999 actual weight claims. For each producer center/radius, the independent full box is contained in the claimed ball using a rational L1 bound. Merely overlapping two boxes was never sufficient. All seven coefficient integer pairs were then recomputed from the producer's supplied centers, and the final polynomial bound and strict comparison were verified. The independent recomputation also established its own analytic allocation from rational pi and exp bounds.

This audits the consumed numerical claims by a separate computation. It does not certify every unused producer event, stored intermediate, timing label, authorization field, or diagnostic status. Such metadata cannot supply a premise. In particular, the receipt is not a complete standalone operation-proof trace: weight events and a per-node initial Machin event are not all retained. The actual node and weight enclosures can still be independently established, and a future formal checker may deterministically recompute their elementary steps.

The candidate contains all three terminal types: theta2 at 120 nodes, theta4 at 387, theta3 at 422. Its S-step counts are zero at 687 nodes, one at 236, two at six. All 929 producer nodes used 320-bit precision. These counts were independently read from the frozen data; they describe exercised cases, not a proof of generic completeness or all possible four-S paths.

## Scope of the eventual conclusion

The producer's exact polynomial lower bound is

`Re(c0)-U = 38298917929334686432095733439357895762079 / 2722258935367507707706996859454145691648 > 14.0688`.

Subtracting the complete error E=91500568239/10^12 leaves more than 13.977299. The completed full independent containment comparison, reviewed paper composition and external exact arithmetic establish Re(F_b)>0 on the entire closed disk, hence on the specified rectangle. The nonzero exponential transfers nonvanishing to xiF. The constant image polygon 1 and its zero crossings are justified by that whole-region positive-real conclusion, not by samples alone.

This is one bounded local experiment. It does not extend a zero-free strip, count a spectral family, certify a high-height domain, prove generic checker soundness, establish kernel acceptance, or complete the QRH/Goldbach proof. The analytic interfaces remain reviewed paper mathematics awaiting formalization. Neither Python execution nor an independent external replay is a new axiom or a Lean theorem.

## Completed numerical verdict

The coordinator executed the independent implementation once under the authorized 600-second cap. It exited successfully with `PASS_INDEPENDENT_RATIONAL_PANEL`, 929 nodes and 12999 weights. The completed receipt was hashed and inspected through its consumed fields. The coordinator then ran the prepared adapter/comparison against the frozen producer receipt; every claimed ball passed full independent containment.

I separately ran `audit_small_rational_xi_panel_saved_20261111.py` on those immutable saved results. This second saved-data audit imports no evaluator and performs no new node, weight or elementary-function evaluation. It independently reconstructs the full signed-index map, all 13928 containment tests, all seven sums, polynomial norm, margin, exact error bound and rectangle geometry. It agrees with the coordinator's comparison. Seven negative controls reject a shifted node center, false zero node radius, omitted node, duplicated node index, changed coefficient integer, changed target shift, and negated negative-grid odd-order weight. These controls concern consumed claims; unused internal metadata is not a premise of this audit.

The separate receipt/control review at `audit/REVIEW_RATIONAL_XI_PANEL_RECEIPT_CONTROLS_2026-11-11.md`, pin `F0386856DA835AB2D4DFBE1E0A4B7BB78DA64E76850BA6AC554AEF358A33A826`, covers additional producer control mutations. Its work is distinct from the all-node mathematical containment verification here; this review does not infer true-value containment from those mutation tests.

Final verdict: **the exact fixed candidate passes independent mathematical/source review and complete external rational numerical verification for this disk and rectangle.** No runtime extrapolation, larger-domain coverage, spectral-completeness claim or formal kernel status follows. All frozen producer artifacts remained unchanged.
