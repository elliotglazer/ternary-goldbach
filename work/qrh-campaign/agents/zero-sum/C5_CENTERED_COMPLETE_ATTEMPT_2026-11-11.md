# Conductor-5 complete-boundary attempt with centered residual models

2026-11-11. This is a separately versioned external interval attempt on exactly [111/200,2]+i[-12,12], using the same frozen385-pole candidate as the preceding local tests. No fit, height extension, other conductor, production scan, or Lean proof is part of this task. The preceding capped interval sweep remains unchanged and incomplete.

## Fixed inputs and cap

The actual primitive characters are chi_k(2^j)=i^(k*j), k=1,2,3, on the residue order [1,2,4,3], extended by zero off units modulo5. The candidate is `c5_global_inverse_candidate_20261111.json`, SHA256 `02C623629D3DF9218AFB7689F39698AF5C4F4D6FB6776056C4B275220D148E6E`. Its exact binary-rational coefficients define three functions B_k(s), each a constant plus385 simple fractions. All poles have real part1/2, at least11/200 to the left of the closed target rectangle.

The accepted analytic model is `c5_residual_taylor_panels_20261111.py`, SHA256 `F1F91D5BC8B9DAF5BCA8B44FA55C1D333500662496157A453FB9E70CBD37FE4C`, with the four-panel review `EAB2CD5C2F08E7400C8565DB2B4C4361F50E7A2F7C58D39F67F1C7333CA23CFA`. The width study and its review motivated this new attempt; they were not treated as a uniform width theorem.

The initial counterclockwise mesh has47 equal segments on each horizontal edge and768 on each vertical edge, hence1630 initial segments. Horizontal lengths are289/9400<1/32, and vertical lengths are1/32. One degree12 finite-g/candidate model is constructed at each initial midpoint; the residual polynomial has degree24. Each model has initial radius equal to half its segment length, at most1/64. The run may bisect failed segments while retaining the same initial model, center, and rigorous initial-disk error. Every child endpoint is checked to lie on the initial segment and in its initial disk. No unsupported recentering or error shrinkage occurs.

The hard limits are180 seconds or4000 actual panel evaluations. The program checks both before each new model and each panel evaluation. Every attempted panel, its pass/fail tests and its parent model are retained. If capped, it writes an explicit incomplete status and only a partial prefix of the original boundary. An initial syntax-only invocation failed before any model evaluation; the corrected invocation is the only numerical attempt.

## Horizontal and vertical analytic contract

The model gives scalar enclosures for the actual holomorphic residuals

    r_k(s)=1-L(s,chi_k)B_k(s).

It uses the same explicit N64/M20 pole-cancelled Hurwitz EM expressions and degree18 exprel polynomial with separate remainder. Finite-g Taylor coefficients are enclosed by elementary ball series arithmetic. The finite-g Cauchy bound uses the closed radius1/4 disk, its actual minimum real part, and the absolute-log bound on initial Hurwitz bases below1. The actual L-minus-finite-g bound is separate and recomputed for the initial panel disk. All outer real floors are positive; the smallest is61/200. No fixed .555 bound is used where a disk extends farther left.

The rational B_k Taylor tail is bounded from its exact pole distances. Since each initial radius is at most1/64<11/200, every required pole inequality is strict. The finite-g radius1/4 is not asserted to be pole-free for B_k. The radius belongs only to the entire finite-g Cauchy estimate.

The degree24 polynomial is formed by multiplying the degree12 coefficients before substituting the complex panel variable. Its analytic error is

    E_res,k=E_L*(P_bound,k+E_B,k)+G_bound,k*E_B,k.

For horizontal panels, the variable is the real interval between endpoint offsets from the initial center; for vertical panels it is the corresponding imaginary interval. Both lie in the same proved disk, so the bounds require no vertical-only assumption. The candidate and actual L-functions are the same analytic functions all around the rectangle.

## Mixed acceptance and the complete-cover implication

From the three scalar residual boxes, form the exact primitive group coefficients

    r_{2^j}=(1/4) sum_{k=1}^3 i^(-k*j)r_k.

Each panel may pass either of these sufficient tests:

    q=sum_j |r_{2^j}| <1,
    p=sum_{k=1}^3 |r_k|^32 <1.

The second is the exact T16 quantity from the accepted group-moment identity, evaluated directly through scalar boxes rather than interval convolution powers. It does not omit a normalization factor. This avoids the extra convolution wrapping observed in the width test.

An l1 panel records the rational upper bound tau=q. A moment-only panel records tau=(31+p)/32. For0<=p<1, Bernoulli's inequality gives tau^32>=p and tau<1; the program checks these rational inequalities. Thus either method supplies the SAME kind of bound |r_k(s)|<=tau<1 for every primitive k throughout its whole panel. The method may differ on neighboring panels.

If the finite accepted segments cover the exact closed rectangle boundary, their finite maximum tau is still below1. Each r_k is holomorphic on a neighborhood of the entire rectangle, since actual nonprincipal L_k is entire and B_k has no pole there. Maximum modulus therefore bounds |r_k| strictly below1 throughout the rectangle. L_k(s)B_k(s) cannot vanish there, hence L_k itself cannot vanish. This includes real-axis zeros, multiplicities, both ordinate signs, and every boundary point. No separate polygon winding is needed for this inverse certificate.

Full PASS requires exact oriented endpoint connectivity, closure, and total perimeter5089/100, plus every recorded panel's domain and residual test. Isolated successful panels or a partial prefix cannot trigger the implication. Rational candidate coefficients are untrusted witness data until these tests pass. No RH, simple-zero or root-spacing premise is used.

## Completed result

The process exited successfully with status `PASS_EXTERNAL_COMPLETE_C5_GLOBAL_INVERSE`. All1630 initial panels passed the l1 test, and all also passed the separately computed direct scalar moment test. No numerical panel failed, no refinement occurred, and no cap was reached. The exact geometry checker verified the full oriented boundary, including horizontal edges and all corners, with total perimeter5089/100. There are1630 distinct models and1630 accepted panels.

The maximum recorded scalar residual bound is

    526447087 / 1073741824 < .491.

It occurs on the left-edge panel from111/200+(375/32)i to111/200+(187/16)i. This gives one explicit uniform bound below1 for all three actual residuals on the boundary, and by maximum modulus throughout the rectangle. Hence the external certificate excludes zeros of every primitive L-function modulo5 on this closed rectangle. It excludes possible zeros on the real axis and at heights exactly12 as well. It establishes no larger spectral range than the older conductor-5 polygon pilot, and remains far below the required production Hcert(5).

The mixed finite-cover theorem remains part of the checker contract, but this particular run did not need a moment-only panel. Thus the rational moment-to-tau conversion is implemented and algebraically checked, not numerically essential to this result. It should not be advertised as an experimentally necessary improvement here.

| Recorded quantity | Value |
| --- | ---: |
| Initial models built |1,630|
| Panel evaluations |1,630|
| Failed panel evaluations |0|
| Maximum refinement depth |0|
| l1 acceptances |1,630|
| Moment-only acceptances |0|
| Model-build time |69.83927 seconds|
| Panel-evaluation time |.39451 seconds|
| Total time after imports |70.47496 seconds|
| Receipt size |4,859,798 bytes|

These are one-run measurements, not a controlled comparison with the older4.64-second polygon construction or a production throughput forecast. The new construction uses fewer contour panels than the older3034-panel certificate, but it builds substantially more expensive rational/Taylor models. The receipt plus the unchanged157155-byte candidate totals5,016,953 bytes before source files; this is not a demonstrated proof-output compression over the older4,946,153-byte polygon receipt.

Source-loop operation counts are427060 truncated-series exponentials,627550 pole reciprocals,24474450 rational-jet coefficient products,8158150 inverse-power updates,826410 residual-polynomial products, and117360 scalar residual Horner products. There are1630 outer and1630 initial-disk analytic-control calls, and4890 scalar32nd powers for the moment tests. Candidate coefficients are parsed once and reused. There are no group convolution calls or extra actual-L point calls. These counts omit scalar error-bound exponentials, elementary interval overhead and data serialization, and do not assign equal cost to different operations.

This demonstrates that the global-inverse certificate format can accept a complete actual-function rectangle with the prescribed primitive family. It does not establish an arithmetic saving over characterwise methods or a manageable production inverse representation. The candidate was fitted using shared character values, and this checker still builds all three finite-g character models. No unproved compression of5.54 billion characters follows.

## Frozen files and replay

* `c5_centered_complete_attempt_20261111.py`: SHA256 `01F1E30A4CDA60482BA5DDDFCBCBB04F6BD47B16F4CA955BB54FE3B2DF37FF71`.
* `c5_centered_complete_attempt_20261111.json`: SHA256 `C7FB0405CE27AFC28840C2996C2209D3A3A4EEAAF6A74018337F1DDA1C8A924D`.

The receipt retains every model's exact domain, error bounds and coefficient digest, every attempted panel with both bounds, and every accepted panel with its chosen criterion and rational tau. A coefficient digest is an integrity check, not a proof of its value. The read-only `--replay` entry point reconstructs every finite model from the pinned explicit EM and rational data, checks the stored model record, recomputes all panel inequalities, validates tau and checks complete geometry. It does not accept a digest in place of an interval computation. No builtin zeta, L, Gamma or zero oracle is used.

The author made one numerical attempt after the syntax-only failure. Independent review/replay is requested against these frozen files. The result is an external finite-data certificate under the stated analytic interval theorems; the source adapters and formal checker still require Lean proofs before it can discharge a formal theorem.
