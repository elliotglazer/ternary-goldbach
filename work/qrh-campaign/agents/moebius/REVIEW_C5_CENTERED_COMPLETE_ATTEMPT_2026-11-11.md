# Independent review of the complete conductor-5 centered inverse certificate

2026-11-11. **PASS for the complete conductor-5 rectangle. No correction required.** Review of the exact closed rectangle `[111/200,2]+i[-12,12]`, the three primitive characters modulo5, and the unchanged385-pole rational inverse candidate. This is a bounded external interval certificate, not a production-height result or a Lean-kernel theorem.

## Frozen author inputs

The author note is `../zero-sum/C5_CENTERED_COMPLETE_ATTEMPT_2026-11-11.md`, SHA256 `3DD9BBB44BF455FF0FDF812255180DBFE9205746674B3FF73BDE619AD15FFE77`. The script has SHA256 `01F1E30A4CDA60482BA5DDDFCBCBB04F6BD47B16F4CA955BB54FE3B2DF37FF71`; its receipt has SHA256 `C7FB0405CE27AFC28840C2996C2209D3A3A4EEAAF6A74018337F1DDA1C8A924D`.

The candidate is still SHA256 `02C623629D3DF9218AFB7689F39698AF5C4F4D6FB6776056C4B275220D148E6E`. The numerical-model source is the accepted four-panel code, SHA256 `F1F91D5BC8B9DAF5BCA8B44FA55C1D333500662496157A453FB9E70CBD37FE4C`. Its mathematical review is `REVIEW_C5_RESIDUAL_TAYLOR_PANELS_2026-11-11.md`, SHA256 `EAB2CD5C2F08E7400C8565DB2B4C4361F50E7A2F7C58D39F67F1C7333CA23CFA`.

## Finite closed-boundary cover

The initial mesh has47 panels on each horizontal edge and768 on each vertical edge, for1630 in total. The horizontal width is289/9400<1/32; the vertical width is1/32. Every model radius is half its panel length and is at most1/64. The order is bottom left-to-right, right bottom-to-top, top right-to-left, and left top-to-bottom. Exact rational endpoints close at the original bottom-left corner, and their total length is5089/100.

This is a full boundary-cover check, not a length-only check: each panel is on its specified original edge with the correct orientation, each starts at the previous endpoint, and the final endpoint is the first. Consequently no unverified gap can be hidden by overlapping or backtracking panels.

The script permits refinement while keeping the initial model. It checks that both child endpoints stay on the initial segment and within the initial radius. It evaluates the polynomial at offsets from that same initial center and retains the original uniform analytic error. It does not silently recenter the polynomial or shrink a remainder without a new proof. A straight segment joining those endpoints stays in the same closed disk. This source path is valid, although the completed run required no refinement.

The run's saved attempts contain1630 successful evaluations, no failed evaluation, no extra center, and no child. The4000-evaluation and180-second limits were not reached. The initial failed syntax invocation performed no numerical model evaluation. A capped run would remain a separate incomplete prefix; the code does not upgrade such a prefix to a complete result.

## Horizontal and vertical analytic enclosures

The functions and normalization are unchanged: chi_k(2^j)=i^(kj) for k=1,2,3 on the unit order[1,2,4,3]. All three are primitive modulo5, with the principal channel omitted. The actual scalar residual is `r_k(s)=1-L(s,chi_k)B_k(s)`. The inverse transform `(1/4)sum_k i^(-kj)r_k` is the primitive-supported group residual. No extra factor4 belongs in its scalar moment.

Each finite-g model uses the pole-cancelled Hurwitz EM expression, with its degree18 exprel approximation and separate analytic remainder. The actual L-function identity is obtained by nonprincipal character contraction and analytic continuation. It does not identify individually deflated numerical Hurwitz values at1 with the source's totalized values. Actual L and finite g are entire.

The finite-g Cauchy estimate is on radius1/4, using the actual floor Re(center)-1/4. The smallest such floor is61/200>0. The initial-disk actual L-minus-g bound uses its own smaller radius, not an estimate valid only on the line Re(s)=111/200. The negative logarithms from initial Hurwitz bases below1 are treated with the absolute-log bound, as in the accepted model.

For the rational candidate, the relevant Taylor radius is only the initial panel radius, at most1/64. Every pole is on Re(s)=1/2, so every model center has pole clearance at least11/200>1/64; the code also verifies the individual distance lower bounds. The larger radius1/4 is used only for finite g, not asserted to be pole-free for B.

The actual residual error is bounded by

`E_L (P_bound+E_B)+G_bound E_B`.

Here E_L includes the actual L-minus-g error and the finite-g Taylor tail. The formula keeps the cross term and all coefficient uncertainty. The degree24 residual polynomial is formed before evaluating the panel variable, preserving cancellation without assuming exact computed coefficients.

Horizontal panels use a real interval of offsets from the initial center; vertical panels use an imaginary interval. Both lie inside the same proved complex disk. No lemma in this construction depends on the panel being vertical. All constants, polynomial arithmetic, rational denominators and error insertions are enclosing external ball operations. Inherited128-bit constants retain their uncertainty in the author's192-bit computation.

## Why a mixed finite cover is sufficient

Let q be a certified upper bound for the group l1 norm on a panel. Since every character has modulus1 on the four units, q<1 gives `|r_k|<=q<1` for every primitive k.

Alternatively let p<1 bound the direct scalar moment `sum_k |r_k|^32`. Then each `|r_k|^32<=p`. The rational number `tau=(31+p)/32` is nonnegative, is below1, and satisfies tau^32>=p. The last inequality is Bernoulli's inequality applied to `(1-(1-p)/32)^32`, or AM–GM on31 ones andp. Thus `|r_k|<=tau<1`. This requires0<=p<1, which is checked. The exact moment here is the same T16 as `4sum_g |r^{*16}_g|^2`; direct scalar evaluation does not change its normalization.

Every panel therefore supplies the same kind of scalar bound regardless of which test accepted it. A finite complete cover has a finite maximum tau_*<1. The three functions r_k are holomorphic on a neighborhood of the entire closed rectangle: L is entire and the fixed rational B has no pole there. Maximum modulus then gives `|r_k(s)|<=tau_*<1` throughout the rectangle. A zero of L would force r_k=1, a contradiction. The same argument already excludes boundary zeros because the covering bounds include all endpoints.

This argument requires neither a winding count nor a simple-zero hypothesis. It includes the real axis, both signs of the ordinate, and the closed height endpoints. It does not apply maximum modulus to the nonholomorphic norm or moment; it applies it separately to each scalar analytic residual.

All1630 panels in this run accepted through l1. The moment-only branch is mathematically valid and source-reviewed but not needed or numerically exercised as an acceptance branch here. The script also evaluated and passed the moment test on every panel. The mixed-cover generality should not be presented as experimentally necessary for this particular success.

## Scope, costs and remaining formal work

The author's maximum recorded scalar bound is526447087/1073741824<.491. It is on the stated left-edge panel from111/200+(375/32)i to111/200+(187/16)i. This is a uniform all-character residual bound for this rectangle, not an estimate at sampled midpoints only.

The construction uses1630 models and panels, fewer than the older3034-panel polygon certificate, but its model construction is substantially more expensive. The recorded70.47-second time is not a controlled timing comparison with the older4.64-second run. Receipt plus candidate size is5,016,953 bytes, exceeding the older4,946,153-byte polygon receipt. Thus neither arithmetic speedup nor output-size compression has been established.

The source-loop counts are consistent with the fixed model sizes:262 truncated-series exponentials,385 pole reciprocals,15015 rational coefficient products,5005 power updates, and507 residual polynomial coefficient products per model;72 residual Horner products and3 scalar32nd powers per panel. There are no group convolutions or extra actual-L point evaluations. These are heterogeneous operations, with further analytic-bound arithmetic and overhead excluded as disclosed.

The result is on the same small conductor5 rectangle already treated by the earlier polygon pilot. It neither enlarges the certified height nor supplies a production Hcert(5) result, other conductors, or a full-family compression theorem. The older capped inverse receipt remains incomplete and unchanged; this is a new, separately checked complete receipt. External interval correctness and the reviewed analytic adapters still need formal checker/source proofs before this can discharge a Lean theorem.

## Numerical replay results

The author's read-only full `--replay` also completed with `COMPLETE_REPLAY_PASS`:1630 models,1630 panels, exact length5089/100. It regenerated and compared every stored model record, including coefficient digests and analytic errors, then recomputed every accepted panel inequality and checked its rational tau and full geometry. This took73.63 seconds. Neither replay changed the author receipt or source files.

The independent script is `review_c5_complete_centered_20261111.py`, SHA256 `4B37A6179B8611FAB43AEC29296FD2A0F871A877AA8447B5BCA50EAD99744A31`. Its full receipt has SHA256 `536ACF078D9B2E47E1EF3DF2597C3E5B2DA49090CBFF1D33F1630874E7FE6DDF`.

This independent replay recomputes every one of the1630 models and every one of the1630 accepted panels, not a sample. It uses N80/M24, degree14, radius1/8 and224-bit freshly formed constants. Its finite polynomial arithmetic is implemented explicitly and does not use the author's acb_series model, coefficient arrays, error bounds, or hashes as numerical input. It reads only the fixed candidate and exact panel geometry. Its different finite EM approximation has its own explicit actual-L error and Cauchy estimate. Thus agreement is not used as a substitute for an analytic enclosure argument.

All1630 independent l1 bounds and all1630 independent direct scalar-moment bounds pass. The maximum independent l1 bound is

`4211575223/8589934592 < .491`.

The independent run took109.45 seconds and stayed within its240-second review limit. It added no panels, refinements or function values outside the specified analytic-control disks. It separately checked the exact1630-element initial mesh, the complete perimeter5089/100, all stored attempt classifications, model/panel counts, and every rational scalar-bound implication. The author maximum526447087/1073741824 and its stated panel were independently located in the frozen receipt.

The independent calculation and the author calculation both rely on external FLINT ball arithmetic and the reviewed EM/analytic source adapters. They are not Lean-checked interval proofs. The arithmetic implementation and formal source bridge remain separate obligations before importing this external certificate into a formal theorem.
