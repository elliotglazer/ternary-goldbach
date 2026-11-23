# Independent review of sparse auxiliary certificate scheduling

2026-11-11. Verdict: PASS as a conditional certificate and cost schedule, without correction. This review supplies no signs, margins, probabilities, zero counts, spectral success, implementation, or measured saving. No evaluator, transform, build or production scan was run. The author and its four listed input files were read at the relevant mathematical and cost interfaces, and all five hashes were checked. Previously reviewed analytic count and sign adapters are inputs to this review, not re-proved here.

## Frozen inputs

Paths below are relative to `work/qrh-campaign/agents`.

| File | SHA256 |
|---|---|
| zero-sum/SPARSE_AUXILIARY_CERTIFICATE_SCHEDULE_2026-11-11.md | 63E77B1CACD9209FB7D475F6CAA8C0D097281F6CA7B5F19475BD02827B8F0CCD |
| zero-sum/SELECTED_SIGN_CHECKER_COST_SUPPLEMENT_2026-11-11.md | D4507C3C7F7B513621240AC2BB4B0142B371465FC7AFD5892C2993F0404F4C41 |
| integration/R132900_POST_TRANSFORM_CERTIFICATE_COST_2026-11-11.md | F718551E44C343FB874AAD919290D002F402760B5B6B44772B534C087AF2D054 |
| zero-sum/REVIEW_R132900_POST_TRANSFORM_CERTIFICATE_COST_2026-11-11.md | 8A69A2954AB6903557476003A21F967ECCDC93AA47AF5A63BFFEFC9B5C2253F6 |
| zero-sum/AUXILIARY_FIXED_ORDER_SPECTRAL_INVENTORY_2026-11-11.md | 80DB1F3EF97114F332D4A23A96DFE585E234ACA87D01FC50234B95C1B576F186 |

## Count and interval derivation

The post-transform packet section 4 supplies the actual closed-count inequality

    C_chi(T) <= (Abar - W + 2b)/h.

For h>0, its strict comparison with K+d is exactly W>Abar+2b-h(K+d). The author's R therefore has the correct sign, factor two and normalization. K must remain a critical-line lower count, not an arbitrary collection of zero boxes. With d=1, integrality and K<=C give exact saturation. With d=2, the separately supplied off-line-pair theorem gives finite RH only. The schedule explicitly preserves that distinction. Neither rule removes central zeros or zeros exactly at the closed main height from C.

For a strict opposite-sign bracket (u,v) inside (T,H), continuity gives a critical-line zero gamma in that open interval. Its contribution to the integrated added count is H-gamma>=H-v. Disjoint open brackets with strict, hence nonzero, endpoints select distinct zeros even when adjacent brackets share an endpoint. A true multiplicity greater than one only improves the count lower bound; a same-sign or unresolved interval contributes no evidence. No auxiliary completeness or simplicity assumption is used.

A real character's positive bracket gives the two signed ordinates, hence weight 2(H-v). For a nonreal conjugation orbit, the two distinct positive channels supply the signed count through inverse-character identification, with weight H-v in each channel. This is not permission to double one nonreal channel. The main and auxiliary interval sets are separated by T, and the manifest retains the actual inverse labels.

If all retained right endpoints are at most T+L, W>=kappa(h-L). Since every right endpoint is strictly greater than T, each weight is strictly below lambda*h; thus any success with R>=0 requires kappa>R/h. At R=0, empty evidence fails the strict test; at R<0 it succeeds. All three endpoint cases are handled correctly.

At fixed H, opposite-sign parent endpoints and a strict midpoint guarantee an opposite-sign child. Keeping that child does not decrease weight because its right endpoint is no later than the parent's. A same-sign parent and opposite-sign midpoint produce two disjoint open brackets. The parent must be removed before any overlapping child is retained. The author's replacement rule imposes this. A new H would change the weights and count integral, so h30 and h50 remain separate attempts rather than interchangeable evidence.

## Stopping, source sharing and failures

The finite refinement depth, precision schedule and frozen fallback make this a bounded attempt, not a guaranteed termination theorem for true RH. A zero endpoint, fixed analytic error floor or inadequate auxiliary weight may still prevent closure. A full-family acceptance requires a complete manifest of accepted orbit records, including any orbit closed immediately by R<0. A cap or failed fallback remains INCOMPLETE.

The source error radius agrees with the post-transform packet: r_L+M[e(1+f)+f]+r_arithmetic. Interpolation must consume the actual completed source required by its theorem. An elementary sign-equivalent proxy cannot silently replace that source. The cited input packet states this distinction, and the author requires compatible source functions, normalization, domains and errors before choosing a circuit.

The cost union is correctly hierarchical. A shared seed is charged once for its exact global height and compatible precision/order; a residue and character circuit is charged at its actual conductor and height. The displayed height-only sum is a schematic sum at one fixed tier. The author's separate precision-tier and cache clauses require extra tiers and changed orders to be separate dependency objects. Closing an orbit removes future requests from that orbit, but not source dependencies required by another orbit. One difficult orbit at every conductor can preserve every late transform.

The direct-row crossover cancels the residue term only when the two alternatives actually consume the same validated inputs and precision. A fixed transform cannot be priced by multiplying its full cost by the active-character fraction. Likewise, sparse interpolation requests may still cover all coarse neighborhoods. The schedule charges guard samples outside the nominal auxiliary window and any direct backend's different prerequisites. These restrictions prevent local circuit minima from hiding a larger global dependency union.

The dense comparison reproduces the cited per-step G=122841198690 and A=254481748047. The exact added-step counts are 30*(64/5)=384 and 50*(64/5)=640. These counts exclude other operation categories, seed/residue construction, phase/count arithmetic and operand-width effects, as the note says. They are not elapsed-time comparisons or new seed-domain proofs.

Checking may omit discarded search guesses, but generation pays them. Retained dependencies still require ordinary sound arithmetic and analytic adapters. Native success flags or cached approximate arrays are not proof inputs. Reusing a higher-precision certificate requires valid outward conversion; it does not erase its production cost.

## Expected-cost calculation

For a finite schedule and a supplied probability model, linearity gives sum F_cj*Pr(I_cj=1) for fixed-price shared transforms. The analogous seed term uses the union event across conductors. No independence is needed. Adaptive precisions and repairs require their own indicators and prices. The union bound min(1,sum p_o,j) is valid when p_o,j bounds the actual request event, including interpolation neighborhoods; it is not supplied by a mean fraction of difficult characters.

For the normalized comparison take C_D>0, alpha>=0 and beta<1. This positivity is implicit in the note's nonempty dense cost comparison and is made explicit here. Let p=Pr(E), where E includes complete closure and all noncommon generation/checking costs <=beta*C_D. Outside E, the exploration cap plus fully charged fallback is <=(1+alpha)*C_D. Therefore

    E[C_adaptive]/C_D <= p*beta+(1-p)*(1+alpha)
                         = 1+alpha-p*(1+alpha-beta).

It is strictly below one when p>alpha/(1+alpha-beta). For alpha=1/16 and beta=1/2 the denominator is 9/16 and the threshold is 1/9. The example is conservative: if the exploration cap already covers a successful complete attempt, beta can be reduced to that cap. Its looser beta=1/2 is still a valid sufficient bound.

The cap must be checked before indivisible tasks are launched and include adaptive bookkeeping and retained proof checking. Failed sparse work is charged even when unused. Cache reuse may reduce the fallback cost, but the proof safely charges its full C_D again. If C_D is only an upper budget, this compares with that budget, not an unknown actual baseline. If the dense fallback fails, the formula remains a cost bound on attempts and establishes no certificate. Memory, bytes and I/O need their own charged contracts.

## Scope of the verdict

The proposed schedule is sound conditional on the retained analytic and arithmetic certificates. It gives an explicit stopping inequality and a correct conditional expected-cost criterion. It supplies no success distribution, no bound on the actual request union, and no unconditional or measured end-to-end saving. Principal and small-conductor obligations remain outside this large-branch schedule. No .555-strip result is substituted for the original-RH target, and no exact-count or reciprocal-moment consequence is inferred from finite-RH-only surplus.
