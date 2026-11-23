# Turing surplus for finite RH without exact count saturation

2026-11-11. Research result: the existing closed-count upper bound can certify finite RH under U<K+2, instead of U<K+1. This is a proved paper implication for the actual primitive nonprincipal family. It does not supply any signs, guarantee a guard height, certify an exact zero list, or claim runtime savings. No evaluations, Lean changes/builds, or frozen-artifact changes occurred.

## 1. Exact target and improved acceptance rule

Fix a primitive nonprincipal character chi of conductor c>1, T>50, and h>0. Let C_chi(T) be the full multiplicity count of nontrivial zeros with closed |Im rho|<=T, including all real zeros. Let Ccrit_chi(T) be its critical-line subcount. Require a certified nonnegative integer K satisfying

\[
 K\le Ccrit_\chi(T). \tag{1}
\]

The critical-only condition is essential. An arbitrary lower count of known zeros is insufficient. Disjoint critical-line sign intervals, with each counted once per certified root, supply such a K. They need not contain every critical-line zero. Any central contribution must also be a valid critical-line lower count; the default contribution zero is always sound and requires no evaluation at t=0.

Retain the exact accepted upper-count construction. Let Abar bound the Gamma/main integral from above, let W be the sum of H-v over certified auxiliary sign intervals inside (T,H), H=T+h, using both character channels, and let b bound each canonical S integral in absolute value. Then

\[
 C_\chi(T)\le U=\frac{\overline A-W+2b}{h}. \tag{2}
\]

The new strict test is

\[
 U<K+2,
 \quad\text{equivalently}\quad
 \Gamma_2=h(K+2)-\overline A+W-2b>0. \tag{3}
\]

Under (1)-(3), every nontrivial zero with |Im rho|<=T lies on Re rho=1/2. Thus the conclusion is precisely `GRHUpTo chi T`, including its closed-height convention. It implies the original-RH consumer at any smaller selected height. It also suffices for a weaker beta upper cap, but no change of analytic route is needed.

For the measured deficit D=(Abar-W)/h-K, the exact new test is

\[
 D+2b/h<2. \tag{4}
\]

The old U<K+1 remains the stronger exact-saturation test. A record passing only (3) must be tagged as finite-RH-only, not as exact count C=K.

## 2. Actual same-character reflection and proof

Use the completion already fixed in the independently reviewed family plan:

\[
 \Psi_\chi(s)=c^{(s+a)/2}\operatorname{completedLFunction}_\chi(s).
\]

It is entire and not identically zero. In the open critical strip it differs from L(s,chi) by holomorphic nonzero Gamma/exponential factors. The primitive functional equation and conjugation give

\[
 \Psi_\chi(1-\overline s)=\epsilon_\chi\overline{\Psi_\chi(s)},
 \qquad |\epsilon_\chi|=1. \tag{5}
\]

This is reflection within the SAME character, even when chi is nonreal. It is not the different assertion that a nonreal character's zeros occur at both signs of the ordinate.

Suppose rho is an off-line nontrivial zero in the closed carrier. Its reflection rho'=1-conj(rho) is another zero of the same L-function. It has the same imaginary part, lies in the same open strip and closed-height carrier, and is distinct from rho because Re rho is not 1/2. Both have positive integer multiplicity, and neither belongs to the critical-line subcount. Hence

\[
 C_\chi(T)\ge Ccrit_\chi(T)+2\ge K+2,
\]

contradicting (2)-(3). This proves the claim. Equal reflected multiplicities are not required for this minimal proof. Zero membership, distinctness, and positive multiplicity suffice.

For completeness, equal orders also follow from (5). If Psi(rho+z)=sum_{j>=m} a_j z^j with a_m nonzero, then

\[
 \Psi(\rho'+w)=\epsilon_\chi\sum_{j\ge m}\overline{a_j}(-w)^j.
\]

The first nonzero coefficient still has index m. This stronger fact is useful for parity refinements but is not a mandatory extra theorem for (3).

No hypothesis excludes real zeros. A real off-critical zero reflects to a distinct real zero, and both remain in C(T), so the same contradiction works. A zero at |Im rho|=T also reflects within the same boundary and contributes two. No top-path zero-free certificate is needed when the accepted a.e./closed-count upper-bound adapter is used. Unaccounted critical-line zeros at the center or boundary can remain if their total unaccounted multiplicity is at most one. That is compatible with finite RH.

The threshold is strict. A reflected off-line pair is consistent with residual count exactly two. Entire functions satisfying the reflection symmetry can have exactly that configuration; symmetry alone cannot replace <2 by <=2. This observation is about the logical information used here, not a claim about actual Dirichlet zeros.

## 3. Character channels and exact-count guardrails

For nonreal chi, positive ordinates of chi and chi inverse supply the positive and negative critical-line subcounts of chi. K is their sum plus any separately proved central lower contribution. Conjugation preserves analytic multiplicity. For real chi, each positive critical-line interval supplies two zeros, at opposite nonzero ordinates, so its contribution to K is doubled.

Exactly the same convention applies to W in (2): two positive channels for a nonreal inverse pair, or twice one positive channel for a real character. The two S allowances remain 2b. Processing one representative of an inverse orbit avoids duplicating a count proof, but does not halve the positive-channel data or the allowance again. The two members have equal full closed counts by conjugation.

The new rule does not infer simplicity, exact central multiplicity, C=K, equality to a serialized zero list, or a reciprocal-zero sum identity. In particular, the independently accepted principal head counts and centered reciprocal moments through 1500 must retain their existing exact-count evidence. This note does not weaken those consumers. The principal zeta entry also has its separate pole/count normalization and is not covered by (2). A positive-ordinate-only principal count would need additional treatment of real zeros before borrowing an off-line-pair argument.

For real chi and nonreal off-line zeros, conjugation and reflection produce a quartet. A <4 rule is possible only if off-critical real zeros have independently been excluded and all four members belong to the counted carrier. That premise is not free in this family, so the uniform selected rule remains <2.

## 4. Guard selection and what can be saved conditionally

For fixed T,h,K,Abar,b, collecting another valid disjoint auxiliary interval increases W and improves Gamma_2. Stop as soon as Gamma_2>0. A complete auxiliary zero list is unnecessary. Interval upper endpoints, not guessed root midpoints, determine W. Tightening a valid upper endpoint also improves it.

Changing h changes Abar, b, and every weight H-v. Consequently a measured D at one h cannot be reused as a bound at a new h. An unproved expectation that the next interval will contain a sign change is not a certificate. Sparse certified intervals, nonuniform interval endpoints, and per-orbit h are allowed by (2), but their actual measured weights must pass (3). If the available evaluator window ends first, the orbit remains unresolved or uses a separately proved alternative.

Here is a bounded exact illustration under the current ORIGINAL-RH R132900 heights, not the earlier QRH min-height profile. For T equal to the selected height,

\[
 T=10^8/c\quad(c\text{ odd}),\qquad
 T=\max(10^8/c,200+7.5\cdot10^7/c)\quad(c\text{ even}).
\]

Thus c<=265800 and cT<=128160000. For each listed h below,

\[
 (8/3)^{18}>[128160000+265800h]/6.
\]

Using pi>3 and exp(1)>8/3 gives log(c(T+h)/(2pi))<18. The accepted elementary Turing theorem therefore permits the rational b=42+6.93*18=166.74. The rows certify only the implication from the displayed FUTURE measured-D bound.

| h | Required measured D | Strict surplus 2-D-2b/h | Extra dense steps per large-branch character |
|---:|---:|---:|---:|
|200|<=1/4|413/5000|2560|
|250|<=1/2|519/3125|3200|
|375|<=1|346/3125|4800|
|500|<=5/4|519/6250|6400|

All h are multiples of five, so extending the same 64/5 density grid changes its ceil-based count by exactly 64h/5. With the already reviewed 4,333,246,843 large-branch labels, the h=250 dense illustration adds 13,866,389,897,600 outputs; h=1000 adds 55,465,559,590,400. These counts omit adaptive stopping, sparse evaluation, shared seed work, and every arithmetic/verification cost. No row establishes an actual passing character, so this is not a forecast of saved work.

The original seed window is not automatically valid above its old V. Even h=200 requires a new domain check near conductor10001; a smaller count allowance cannot license extrapolation of old D,N,J, error or width bounds. Integration's separate evaluator/closure design owns that check. Reusing unused capacity within an already proved window is allowed only for actual endpoints covered by that proof.

## 5. Sharper allowances and avoiding a guard

There is a free one-sided refinement of the accepted elementary proof. Put Z_t=log(ct/(2pi)). Its actual horizontal bounds are

\[
 I(t)<1717/500+(3/4)Z_t,\qquad I(t)>-128-21Z_t.
\]

Since pi integral_T^H S=I(H)-I(T), the upper allowance needed by (2) can use

\[
 b_+(c,T,H)=\bigl[65717/500+(3/4)Z_H+21Z_T\bigr]/\pi \tag{6}
\]

per character. Replace 2b by any certified upper enclosure of 2b_+ throughout (2)-(4). The general absolute theorem replaced Z_T by Z_H and rounded coefficients upward. Formula (6) avoids those losses without new analytic input. It does not halve the two-character allowance. All log/pi enclosures must be directed correctly. The scalar table deliberately uses the simpler previously accepted b, so it does not depend on a new evaluator for (6).

The published Rumely bound 1.8397+.1242 log(cH/(2pi)) would be much more consequential if its analytic proof were completed internally. Under the same log<18 witness, b<4.0753; h=6 and a future D<=1/2 would give surplus 4247/30000>0 for the <2 test. This is an unadopted comparison. The campaign's primary-source audit retained Rademacher, Hadamard/Gamma, and lower-horizontal estimates as unproved analytic producers. A citation or scalar check cannot replace them. The already accepted elementary route remains the basis for the four rows above.

A separate canonical-argument/top-contour certificate can count zeros without an auxiliary Turing interval, but then it must prove all argument branches and path nonvanishing for the actual functions. Endpoint values or principal arguments alone do not suffice. The current work supplies no conditioning or cost bound showing that alternative is cheaper.

## 6. Pins and implementation obligations

All agent paths are under `work/qrh-campaign/agents`. The accepted family review `major-constants/REVIEW_FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md`, SHA256 `3033D761A2FE3F1B140A750CD1261D640EF8D1E98FA81711A438EB899A8AFE58`, sections 1-3 derives (5), the actual completed-zero carrier, and the count normalization. Its conjugation/argument adapters remain formalization obligations.

The endpoint addendum `zero-sum/FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md`, SHA256 `6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4`, proves the a.e./closed-count form used by (2). `integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md`, SHA256 `72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C`, supplies the two horizontal bounds and the unconditional primitive nonprincipal integrated-S estimate. These are reviewed paper inputs, not newly compiled declarations.

Directly reread source at target `23b2d68ca344203d4384e0aff7affa4ec034bef9` and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`:

| Source | Lines | SHA256 |
|---|---|---|
| Mathlib/NumberTheory/LSeries/DirichletContinuation.lean | 249 entire completion; 259 relation to L; 283 primitive FE | ECF79F2A64EF2E7215729EBB2E7D5ADAA03468B18BBDA0040680AA925D4673F1 |
| TernaryGoldbach/Explicit/LGrowthLeft.lean | 221 root-number norm; 269 actual FE use | 59B0B227CC2D9472C6389231E8CC3998698F1F3E59139A8D110F32FF64F2F3D4 |
| TernaryGoldbach/MajorArcs/GRH.lean | 32 closed-height target | 89C6DF8490955EEA8F4141498BCA6D163355C2E7765C9ECD09F8CEE5B257A070 |

The height/label input is `zero-sum/CONDITIONAL_R132900_SPECTRAL_PRUNING_INVENTORY_2026-11-11.md`, SHA256 `7AA9BF4D456CE25685D69427966DC7F61D0914DD091A95B74F9C242B95CADB27`, and its JSON `E94D87827C3A4D37CA34F07001F16EA7AEE8854684F8BC156C3D4AC6D96B65CF`. Only those saved metadata were read; no inventory was rerun.

The owned Fraction-only check `turing_spectral_surplus_scalars_20261111.py` has SHA256 `9D834E4AAF2490211CC8635A20FE44BE5076653A1C60C16AFCB934EB9519E1D5`; its receipt has SHA256 `31097AAF676A81004A79D2E564EE3318DEA6ACDBF1C275E9E99AED38CC05073D`. It verifies the conductor-height cap, four conditional allowances and dense output products, plus the unadopted Rumely scalar comparison. It computes no log, Gamma, character, L-value, zero or sign data.

The new formal work specific to the basic <2 gate is small in statement scope: actual same-character zero reflection, finiteness/positive multiplicity of the closed carrier, a critical-only subcount, and the two-extra-zeros contradiction. It inherits the substantial count/evaluator/Turing foundations. Nothing in this note promotes an actual production packet to PASS.
