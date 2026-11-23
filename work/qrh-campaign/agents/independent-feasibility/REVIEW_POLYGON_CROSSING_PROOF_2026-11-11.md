# Independent review of the expanded polygon crossing proof

2026-11-11. **PASS as a paper proof of the stated generic analytic bridge. No mathematical correction required.** This verdict is stronger than acceptance of an implementation plan, but is not a Lean proof, a verified checker implementation, or acceptance of any numerical enclosure.

Reviewed note: `major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md`, SHA256 `21acea6753546cb2d22e8be2949fa02a3d6a030b21960c6a024731514f09e08b`, relative to `work/qrh-campaign/agents/`. I read the expanded proof and the actual pinned source APIs. Mathlib cache HEAD was independently checked as `56a005855ea17e0b0958f73ec801ae140b0a1679`. No Lean process, canonical source change, dependency change, or frozen-package edit occurred.

## Exact half-open edge identity

For a zero-free affine segment gamma(t)=a+t(b-a), the proof of

    integral_0^1 (b-a)/gamma(t) dt
      = log(-b)-log(-a)+2*pi*I*C(a,b)

is complete with the stated convention. If the segment avoids the positive real ray, -gamma stays in the principal logarithm's slit plane, including endpoints. FTC for log(-gamma) is legitimate. A nonzero crossing clause would give a positive-ray point with real coordinate det(a,b)/(Im(b)-Im(a)), contradicting this case.

If the segment meets the positive ray, it cannot also meet the negative ray: the affine image is convex, and opposite real points would force zero onto the segment. Since zero was already excluded, gamma now lies wholly in the slit plane for log(gamma). The exact endpoint formula is

    log(-p)=log(p)+pi*I*epsilon(p),
    epsilon(p)=+1 when Im(p)<=0, and -1 when Im(p)>0.

The positive-real equality case has epsilon=+1 because arg(-p)=pi. The source identities `RectResidue.log_sub_log_neg_of_im_pos/neg:84,89` give the other two cases with the claimed signs. Pinned Mathlib `Complex.Arg` supplies arg_ofReal_of_nonneg and arg_ofReal_of_neg. If the endpoint groups differ, the unique real-axis intersection is positive, so the determinant has the same sign as the imaginary difference. Hence epsilon(a)-epsilon(b)=2*C(a,b), yielding the edge identity without an integral across a logarithm branch cut.

The four positive-ray endpoint conventions are therefore exactly:

| Event | Contribution |
|---|---:|
| Upward departure from the positive ray | +1 |
| Downward arrival at the positive ray | -1 |
| Upward arrival at the positive ray | 0 |
| Downward departure from the positive ray | 0 |

A touch and return cancels over the neighboring edges. Horizontal positive-ray edges and zero-length positive vertices use log(gamma), with crossing0. Horizontal negative-ray edges use log(-gamma), also with crossing0. Non-real horizontal edges fall into the appropriate zero-crossing case. A strictly straddling edge with determinant0 would pass through zero and is excluded by the hypothesis; no discarded determinant-zero case remains. Reversal negates both the integral and C. The displayed counterclockwise square has total+1, fixing orientation.

The derivatives used by FTC are continuous on the compact interval because the denominators are nonzero there. The ambient affine curves are defined on all real parameters. Slit-plane membership at each endpoint is strict and open, which supplies ordinary derivatives there. The proof does not differentiate log(-p) at a positive-ray point or require an unjustified endpoint limit.

## Local-log transfer and subdivision

For H_u={p:Re(u*p)>0}, u nonzero, ell_u(p)=log(u*p) has derivative along a curve equal to the curve derivative divided by its value. The certificate provides membership of the entire actual panel image and both rational polygon endpoints in H_u; convexity then also covers the polygon edge.

At a shared join, the actual image A_j and rational vertex v_j belong to both adjacent half-planes. The straight connector from v_j to A_j stays in their convex intersection. Applying FTC in both charts gives equality of their endpoint-log differences. It does not assert equality of the logarithms themselves. Thus the difference between the actual-panel integral and polygon-edge integral is a right connector term minus a left connector term, and these cancel cyclically, including the closing join. Different actual and rational basepoints cause no problem; a based homotopy is not assumed.

Summing the edge identity telescopes the single-valued endpoint expression log(-v_j). The image polygon need not be simple. The result is the signed crossing sum, with self-intersections away from zero allowed.

The input geometry must independently establish a once-counterclockwise partition of each rectangle side. A closed list of points on the boundary is insufficient, and the note does not make that shortcut. `rectInt` is bottom minus top plus I times right minus I times left. Real affine substitution therefore gives the correct signs for reversed top/left panels. The pinned `smul_integral_comp_mul_add` theorem has the quoted real-scalar statement and includes c=0. Pulling I out of a vertical integral and using adjacent-interval additivity completes the identification. Degenerate input panels contribute zero. No complex-scalar version of a real change-of-variable theorem is being assumed.

## Actual analytic multiplicity and carrier

The inspected `RectResidue.rectInt_logDeriv_mul:391` requires an entire f, positive R, f(c)!=0, strict corner ordering, the entire closed rectangle inside the open ball(c,R/2), and nonvanishing on all closed sides. Taking multiplier1 on univ discharges its multiplier conditions only.

The proposed choice c=z and R=2*(dx+dy+1) supplies the auxiliary geometric hypotheses: dx,dy>0 and every rectangle point has distance at most dx+dy<R/2 from z. Whole-side panel coverage gives f(z)!=0 and the exact `NoZerosOnSides` predicate, including corners. No zero-free hypothesis on the enclosing ball is needed.

The divisor carrier is not an externally supplied root list. `Landau.divB` is the source meromorphic divisor on the closed ball; `zerosIn` filters its finite support by the strict radius. Entire analyticity and a nonzero value at c exclude infinite analytic order everywhere by the identity theorem on connected complex space. The source `factor_ball` already uses this argument and divisor nonnegativity. For an actual interior zero, its finite analytic order is strictly positive, hence the divisor is nonzero and its point belongs to the filtered carrier. Conversely, the existing rectangle theorem's proof uses divisor_apply and analyticOrderAt_eq_zero to show every carrier point is a genuine zero.

Consequently `.toNat` represents the true positive order after these facts are supplied; it cannot hide infinite order or a negative pole multiplicity. Cancelling the nonzero2*pi*I identifies the integer crossing sum with a sum of these natural multiplicities. A zero sum excludes any interior zero, and boundary nonvanishing extends exclusion to the closed rectangle. For a nonzero sum the result is a multiplicity count, not a distinct-root count.

## Source checks and limited regression evidence

Direct reads covered `Explicit/RectResidue.lean:22,84,89,360,391`, `Explicit/Landau.lean:25–62`, Mathlib `Complex/LogDeriv.lean:87`, `Complex/Arg.lean:223,245,263`, `IntervalIntegral/Basic.lean:973`, and `FundThmCalculus.lean:1148`. Their hypotheses and signs match the paper proof. The accompanying `review_polygon_crossing_20261111.py/.json` pins these source files and the reviewed note.

As a finite regression only, the script checked2208 zero-free integer-coordinate edges in[-3,3]^2, including48 zero-length edges,312 horizontal edges and261 edges with a positive-ray endpoint. It checked the two-case epsilon rule, reversal, and11040 exact rational subdivisions. It also checked crossing-sum invariance under a quarter-turn for97488 admissible triangles. These exact checks support the convention; the universal analytic proof is the two-case argument above, not this finite test.

## Exact remaining work

There is no unresolved paper-proof gap in this generic bridge under its stated hypotheses. The following work remains unproved in Lean:

1. The universal edge identity with its branch and determinant cases, the connector identity, cyclic telescoping and oriented subdivision lemmas.
2. The explicit finite-order/support equivalence and cast/positivity steps connecting the existing divisor sum to the desired actual zero carrier.
3. The rational checker semantics: shared vertices, once-oriented side coverage, exact signs and the soundness of all interval-enclosure operations.
4. For each actual application, the analytic enclosure theorem for its exact f, including coefficient identities, Taylor/EM or other remainder bounds and removable-singularity values. External Arb success alone does not establish these premises.
5. Any additional carrier conversion to zeta, xi, Dirichlet characters or closed-height families, followed by the final theorem-type and transitive-axiom audit.

Thus the expanded note completes the paper proof from whole-panel analytic enclosures to an actual rectangle multiplicity count. It does not yet discharge those enclosures, implement a formally checked polygon evaluator, certify the principal strip or family, or remove PlattGRH from a Lean root.
