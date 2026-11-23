# Review of the principal node-to-contour frontier

2026-11-11. **PASS at source-supported paper/frontier scope. No correction requested.** I found no false coefficient formula, omitted error term, endpoint gap, or claimed completed spectral computation. This review accepts the stated route and its limits, not a new evaluator theorem or a certified high-height contour.

Reviewed author file: `mellin/PRINCIPAL_NODE_TO_CONTOUR_FRONTIER_2026-11-11.md`, SHA256 `F5E5CE83EC1DD110CFBC9CF75B845C63BE2EAFF0D269297FBA2934D92998CDAD`. The entire file was read and its hash checked. All paths below are relative to `work/qrh-campaign/agents/` unless identified as source paths. No numerical evaluation, script replay, spectral scan, Lean command, or author-file edit was performed.

## 1. Checks for overstatement and scope errors

The note distinguishes the two actual principal obligations: the narrow closed strip `[.4968,.5032]` through height 1000000, and the conductor-one upper strip .555 through height 60343058. These are not interchangeable. The proposed closed rectangles begin at height 2000, overlapping the accepted external closed-2000 head. I checked that head's review, `independent-feasibility/REVIEW_PRINCIPAL_SIGNS_2000_CHUNK_2026-11-11.md`, SHA `8EC2B71F288EFF6B2C4ABE01362E8A467C23D22BA1648B62EAABE89EC7F016E8`: it explicitly gives the closed external finite-RH conclusion, not a Lean theorem.

Exclusion of the left edges Re=.5032 or .555 is stronger than the requested non-strict zero bound. The author identifies this correctly and does not promise success if a zero lies on such an edge. The right edge Re=2 is outside all nontrivial xi zeros by the actual source. Conjugation, reflection and the head cover the corresponding negative heights and lower real bound. A total zero count alone cannot locate the zeros, as the note states.

The two rationally certified P nodes use b=pi/4-1/1000001. The old low xi disk uses b=pi/4-1/33. Neither node can be inserted into that disk's quadrature, nor into a newly chosen b=pi/4-1/60343059 quadrature, without an additional change-of-b estimate. This potentially serious mismatch is explicitly prevented.

The exact-node status was checked against both node reviews. The low disk remains external-Arb evidence; the later rectangle adapter does not upgrade its numerical inputs to rational certificates. I also verified that the rectangle adapter actually has an independent review, rather than relying on the producer's older “review pending” heading.

## 2. Coefficients, tails and common node radius

All constants and formulas match the pinned corrected Fourier and node-substitution sources. Independently checking their algebra gives the following.

For `F_b(s)=exp(-i*b*(s-1/2))*xiF(s)`, fixed b and normalized coefficient `f_j=F_b^(j)(s0)/j!`, differentiation in s contributes `v^j/j!`. It does not differentiate P or b. On the displaced quadrature lines the extra factor is bounded by `exp(|v|+a)`. Combined with the P envelope and the real-strip bound, this gives the derivative boundary estimate `D*exp((T+1)a)`, and hence the displayed Q_j. Q_0 retains its tighter `M*exp(Ta)` bound. The factor 2 counts the two Fourier tails.

The omitted positive and negative discrete tails are bounded by integrals starting at V=Kh. The undifferentiated majorant `exp(2u-q*exp(2u))` decreases when q*exp(2V)>=1. The derivative majorant `exp(4u-q*exp(2u))` requires q*exp(2V)>=2. Substitution R=exp(2u) gives exactly

`S0=M*exp(-qR)` and `Sj=A*exp(-qR)*(R/q+1/q²)`.

Thus the stronger derivative cutoff is necessary and is present. The same symbol R in these formulas means exp(2V), not the auxiliary ball radius in the argument principle.

The substitution split

`wP-w_hat*p = w(P-p)+(w-w_hat)p`

gives exactly B_j plus `sum d_(j,k)*|p_k|`, followed by eta_j for finite-sum arithmetic. No mixed term is missing. Positive and negative nodes retain their signed powers in centers and use absolute powers only in errors. Conjugation transports the full negative-node enclosure; zero appears once, and has zero weight only for j>0. No old unreduced-Gaussian error is added again.

The new uniform allocation is valid. For every retained node, |v_k|<=V and

`(|v_k|^j/j!)*exp((sigma-1/2)*v_k) <= exp(5V/2)`.

There are exactly 2K+1 signed nodes, so

`B_j <= h*(2K+1)*max(e_k)*exp(5V/2)`.

The proposed common radius bound therefore implies B_j<=epsilon_B, including j=0. It is sufficient, not a claim that radius 2^-128 is automatically adequate. For implementation, epsilon_B must be nonnegative and all divisions use h>0 and positive exponentials, already implicit in the allocation.

## 3. Whole disks and polygon transfer

On the unit disk around an allowed center, `|Re(s)-1/2|<=5/2`. The real integration line removes dependence on Im(s) from the absolute envelope, so the same D bounds F_b there. The tail `D*rho^(d+1)/(1-rho)` for 0<=rho<1 and the coefficient error `sum E_j*rho^j` are correct. It is unnecessary to increase the coefficient work height merely for this analytic unit-disk bound. A different algorithm that numerically evaluates an outer circle must cover that circle, which the author separately requires.

The note requires a strict rotated half-plane inequality on every closed panel, not merely zero exclusion at a midpoint or sampled points. It requires polynomial-evaluation error, both panel endpoints, an exact CCW side partition, shared rational surrogate vertices, closure and the prescribed half-open crossing convention. These match the polygon theorem. A count of zero is then stronger than boundary nonvanishing and is the required condition for interior exclusion.

Holding b fixed throughout a polygon is essential: it defines a single entire F_b and an entire nonvanishing multiplier to xiF. Separate rectangles may use different b, but their normalized image edges cannot be cancelled as if they were the same function. The author's treatment of shared seams preserves this distinction.

The final workload observation `h<=6a/J` implies `K=V/h>=VJ/(6a)` for positive quantities. It is only a scale warning, not a timing claim. Arbitrary precision for evaluation does not imply a nonzero contour margin. The final paragraphs explicitly preserve that open spectral issue.

## 4. Actual source carrier and closed-height transfer

I inspected `TernaryGoldbach/Explicit/Xi.lean`, `RectResidue.lean` and `WeilBridge.lean` at the Goldbach source pin. xiF is unhalved, entire, satisfies xiF(1-s)=xiF(s), and is nonzero for Re(s)<=0 or Re(s)>=1. `xiF_eq_zero_iff` is only a zero-location statement on 0<Re(s)<1; the note does not use it as an order theorem.

`RectResidue.rectInt_logDeriv_mul` requires strict rectangle ordering, a nonzero anchor, positive auxiliary radius, inclusion of the entire closed rectangle in the indicated open ball, and `NoZerosOnSides`. Taking h=1 and U=univ gives the required count. The polygon proof supplies an explicit anchor and ball construction. Entirety and a nonzero anchor rule out infinite analytic order; zeros contribute positive natural orders before the `.toNat` sum is interpreted. Boundary half-planes then extend a zero interior count to the closed rectangle.

The factor relating F_b to xiF is entire and nonzero. On the nontrivial strip, the xiF/zeta factor is locally analytic and nonzero. Source `WeilBridge.analyticOrderAt_xiF_eq` already proves the xiF/zetaF order equality; an adapter from zetaF=(s-1)zeta to actual zeta is still needed if that carrier is used. This is compatible with, and can shorten, the author's stated remaining order work.

`multRectD_eq_mult` has two strict height hypotheses, one for each carrier. Consequently an endpoint at |Im|=H needs every relevant carrier parameter strictly greater than H, not just the evaluator's work bound T=H. The note's T versus T' distinction is correct; when instantiated, both explicit strict hypotheses must be supplied. This is an implementation clarification, not a defect in the proposed outer-carrier construction.

## 5. Verified pins

The following were read and locally hashed. Producer/review hashes explicitly quoted by the frontier match.

| Artifact | SHA256 |
| --- | --- |
| `integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md` | `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99` |
| `integration/PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md` | `5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571` |
| `major-constants/REVIEW_PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md` | `FB75E5919ECFD5F7800290C64DD1C0DFFCA7EA4FDFAE4B5FB4BFBBF4B3B27DAD` |
| `mellin/REVIEW_PRINCIPAL_ONE_NODE_BOUND_2026-11-11.md` | `6ABD86362059F5BFED71A5DA72D59DC6774ED2B338E9E9189899E79C425254B9` |
| `mellin/REVIEW_R1OVER8_P_NODE_EXACT_2026-11-11.md` | `3F6684C81A95E2ACC9A4BA7EEDC449E0D4D95F0375ABE5AE0A01346AB894C09A` |
| `prime-estimates/PRINCIPAL_MODULAR_XI_PANEL_PILOT_2026-11-11.md` | `85EDD45B5DEB8E96AEC957AA956E90AEBEC4B9B0C9BE31C7D06FA52DAE6E2D49` |
| `major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md` | `21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B` |
| `mellin/PRINCIPAL_MODULAR_RECTANGLE_ADAPTER_2026-11-11.md` | `3ACC47F6948ADE678D9F615D8701E3C51C818B381C12338BC8AADB709E51D89C` |
| `audit/REVIEW_PRINCIPAL_MODULAR_RECTANGLE_ADAPTER_2026-11-11.md` | `728C59BB9CEA202C36EDDFE90EB34CC40D3B51CD90733FEE43CF3E494F75CDBB` |
| Source `Explicit/Xi.lean` | `988EDFBCA182F1A7618C88A6EA9B253BFEFEBFA3DA86C3CDC74F5DAC19523D1F` |
| Source `Explicit/RectResidue.lean` | `6B9C3236C2B4470AA37D3948DAB163573A1A7AFDDE8E963EF127F815EB0B88CF` |
| Source `Explicit/WeilBridge.lean` | `285F825F4916B8D8F40256090F56E773140AB2FC2C48E3F057F68A838E17C73E` |

Acceptance is limited to this exact frontier report and the mathematical composition checked above. No new node values, high-height data, finite strip, global provider, executable checker, or Lean closure is accepted by this review. The requested next milestone remains a complete fixed-b rational coefficient-to-panel packet with every error and strict inequality actually checked.
