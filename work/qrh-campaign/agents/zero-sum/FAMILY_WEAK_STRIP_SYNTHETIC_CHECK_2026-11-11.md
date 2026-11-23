# Exact synthetic check of weak-strip certification

2026-11-11. External rational arithmetic and a paper analytic argument only. No L-function evaluation, Lean build, canonical source edit or frozen-packet edit.

The three principal fixtures all satisfy the weak strip bound, but ordinary critical-line sign saturation cannot certify their complete zero count. Multiplicity-aware contour and cluster certificates do certify that count. A fourth fixture shows why equality at the allowed real boundary needs additional evidence: its strict boundary-nonvanishing test is inapplicable, while an exact factor certificate settles the weak inequality.

## 1. Reproducible files and acceptance scope

The files alongside this note are:

* `family_weak_strip_synthetic_20261111.py`, SHA256 `CABE7EF7CE948C6F1784191264FB149C5D009AA9D4F59BD7ACD7C70FBFFCE296`.
* `family_weak_strip_synthetic_20261111.json`, SHA256 `8BBDDA6E2F60AE21C77128F624910928841D509E79EA78BFE45805F66C54865C`.

From the repository root, run:

```powershell
& work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/zero-sum/family_weak_strip_synthetic_20261111.py
```

The script uses only Python's standard library, with complex numbers represented by two exact `Fraction` values. It writes the adjacent receipt deterministically. A replay should be run in a copied directory if preserving frozen files byte-for-byte during review. Acceptance requires `PASS_EXACT_SYNTHETIC_ONLY`, every asserted count and every panel check; an exit code alone is not the mathematical certificate.

The receipt retains the polynomial coefficients, ordered rational panel endpoints, their exact images, chosen half-plane, strictly positive certified margin and exact winding. It does not infer zero counts from a sampled list of roots. The separate complete linear factorizations and derivative orders are cross-checks and supply the special boundary-factor evidence in Section 5.

## 2. Whole-panel analytic certificate

Let a degree-n polynomial p be restricted to the oriented segment from a to b. The script computes exact coefficients q_j in

\[
 p(a+t(b-a))=\sum_{j=0}^n q_jt^j,
\]

and exact Bernstein coefficients

\[
 B_k=\sum_{j=0}^k q_j\frac{\binom{k}{j}}{\binom{n}{j}}.
\]

The binomial theorem gives, for every real t in [0,1],

\[
 p(a+t(b-a))=\sum_{k=0}^n B_k\binom{n}{k}t^k(1-t)^{n-k}.
\]

The scalar coefficients in this last sum are nonnegative and sum to one. The script chooses one of the four real linear functionals Re, -Re, Im and -Im, and accepts the panel only if its value at **every** B_k is at least a recorded rational margin greater than zero. Therefore the image of the entire panel lies in one open half-plane avoiding zero. This proves panel nonvanishing, rather than merely testing endpoints or a mesh.

The exact endpoint images belong to that same half-plane. Their joining chord and the analytic panel are homotopic there, relative to their endpoints. Shared rational input endpoints have identical exact output images. Consequently the closed image polygon has the same winding as the actual polynomial on the entire contour.

The checker uses four counterclockwise rectangle sides: bottom rightwards, right upwards, top leftwards and left downwards. It explicitly verifies ordering, side membership, strict orientation, adjacency and closure. For polygon edge (a,b), it counts +1 if Im(a)<=0<Im(b) and det(a,b)>0, -1 if Im(b)<=0<Im(a) and det(a,b)<0, and zero otherwise. These are the half-open positive-ray crossing conventions in the previously reviewed polygon proof; each chord avoids zero by the half-plane certificate.

This reuses, rather than replaces, the accepted generic analytic/count implication:

* `../major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md`, SHA256 `21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B`.
* `../independent-feasibility/REVIEW_POLYGON_CROSSING_PROOF_2026-11-11.md`, SHA256 `F75647007C294E13132B984A0F6241B516D5113D789AECA922B4DA265A5E73F0`.

Polynomials are holomorphic on a neighborhood of every rectangle here. The argument principle thus identifies the computed winding with the interior zero count **with multiplicity**. The source-level bridge remains `TernaryGoldbach/Explicit/RectResidue.lean`, in particular `rectInt_logDeriv_mul`; this packet does not implement that bridge in Lean.

The script also checks clockwise/counterclockwise winding on a square and rejects copied records with a zero margin or a missing panel. These bounded rejection checks are not a claim of a formally verified Python parser or checker.

## 3. Sign saturation fails even with exact values

Set b=111/200, closed target height H=1 and enclosing top T=3/2. Write

\[
 q_a(s)=(s-a)^2+1.
\]

The principal fixtures are

\[
 p_o=q_{27/50}q_{23/50},\qquad
 p_2=q_{1/2}^2,\qquad p_3=q_{1/2}^3.
\]

Their real-coefficient factorizations respect conjugation and reflection about Re(s)=1/2. The script checks their complete linear factorizations and the exact derivative criterion for each stated multiplicity. There are no central zeros.

On the critical line, put delta=1/25. Exact coefficient identities checked by the script give

\[
 p_o(1/2+it)=(1+\delta^2-t^2)^2+4\delta^2t^2>0,
\]

\[
 p_2(1/2+it)=(1-t^2)^2,\qquad
 p_3(1/2+it)=(1-t^2)^3.
\]

For the first identity, vanishing of the second summand would force t=0, at which the first is positive. Thus p_o has no critical-line sign changes. The square p_2 never changes sign even at its two distinct critical-line roots. The cube p_3 has exactly one sign change at each of -1 and 1, although each root has order three. A family of ordinary disjoint strict sign intervals can count at most two roots of p_3 in total. The analytic reasoning here establishes the sign counts; they are not inferred from numerical sampling.

| Fixture | Zeros | Total multiplicity C | Maximum ordinary sign count K | C-K |
|---|---|---:|---:|---:|
| p_o | .54 +/- i and .46 +/- i, simple | 4 | 0 | 4 |
| p_2 | .5 +/- i, each double | 4 | 0 | 4 |
| p_3 | .5 +/- i, each triple | 6 | 2 | 4 |

All these zeros obey Re(s)<b. Nevertheless, for any sound upper count U>=C, the sign-only acceptance inequality U<K+1 is impossible. This is a structural deficit of the lower evidence, not a precision failure. Counting an exact sampled zero with a proved derivative order would be a different, multiplicity-aware method.

## 4. Contours and clusters accept all three fixtures

For each polynomial, the receipt certifies four complete rectangles:

* Full count: [0,1] x [-3/2,3/2].
* Forbidden right region: [111/200,2] x [-3/2,3/2].
* Upper cluster: [9/20,11/20] x [9/10,11/10].
* Lower cluster: [9/20,11/20] x [-11/10,-9/10].

The two cluster rectangles are disjoint, lie in the full rectangle, and have real upper endpoint 11/20<111/200. Their counts add exactly to the full count. This supplies a multiplicity-aware completeness certificate without requiring separate isolation of every zero.

| Fixture | Full count (panels) | Forbidden count (panels) | Upper/lower counts (panels each) |
|---|---:|---:|---:|
| p_o | 4 (20) | 0 (20) | 2,2 (10,10) |
| p_2 | 4 (20) | 0 (20) | 2,2 (8,8) |
| p_3 | 6 (32) | 0 (26) | 3,3 (12,12) |

The whole-panel certificates, followed by the argument principle, prove every count in this table. The complete factorization check additionally excludes zeros outside the displayed full rectangle; the count-plus-cluster implication itself only needs completeness in the designated enclosing rectangle.

The forbidden-region route and the full-count-plus-allowed-clusters route are separate valid acceptance paths. The second demonstrates directly that a multiple zero need not be split into simple sign changes to count it correctly.

## 5. Equality at the real boundary is not hidden

The fourth fixture is

\[
 p_b(s)=q_b(s)q_{1-b}(s),\qquad b=111/200.
\]

It has simple zeros b +/- i and (1-b) +/- i, so the desired weak inequality is true. The full count is four. However, p_b has zeros on the left edge of [b,2] x [-3/2,3/2]. The script records their exact zero values and edge membership under

`EXACT_BOUNDARY_ZERO_STRICT_PANEL_CERTIFICATE_INAPPLICABLE`.

It does **not** pretend that tighter rounding, greater precision or more subdivisions yields strict nonvanishing on that contour. This is an honest unresolved case for the plain strict-boundary contour path.

An additional algebraic certificate resolves this particular polynomial. The script proves the exact identity p_b=q_b q_(1-b), and the exact complete factorization of q_b with roots b+i and b-i. Those roots satisfy the allowed equality. It then supplies a whole-panel, zero-winding right rectangle for the remaining factor q_(1-b). The combination accepts the weak strip conclusion. The extra exact factorization is available because this is a constructed polynomial; no such factor certificate is asserted for an unknown Dirichlet zero at Re(s)=b.

Moving the left contour to b+epsilon alone would not prove the desired statement: it leaves the sliver (b,b+epsilon] unexamined. This packet does not use that substitution.

## 6. Closed height is retained

Every fixture has zeros at both target height endpoints, Im(s)=+/-H with H=1. The selected full and forbidden contours instead have top T=3/2>H, so all closed-target zeros are included in their interiors where relevant. The upper and lower clusters straddle +1 and -1 and count their multiplicities.

The script separately checks that the contour [0,1] x [-H,H] has actual zeros on its horizontal sides and marks its strict boundary certificate inapplicable. No count with top below H is substituted. In a general analytic problem, searching for a nonzero top above H also requires controlling the intervening region; our T=3/2 certificates cover that entire larger region. If a disallowed zero existed there, this stronger contour would not accept merely because its height exceeded H.

## 7. Consequence for the next implementation step

The next family checker should retain the sign route as a cheap sufficient path and also accept full rectangle counts together with disjoint allowed cluster counts, or direct forbidden-region exclusion. This fixture suite is a regression target for those alternatives. It demonstrates that these paths can accept true weak-strip instances that ordinary sign saturation cannot accept, even with exact evaluations.

For an analytic evaluator, any proposed termination argument must separately show that **all** enclosure errors can be driven to zero. Increasing arithmetic precision while leaving a fixed analytic remainder does not establish this. The present fixtures have exact polynomial values and exact Bernstein bounds, so no analytic approximation floor is involved. No claim is made here about termination of a principal K0 approximation with a fixed error floor.

This does not supply spectral evidence for a single actual character. The polynomials are not asserted to be L-functions or counterexamples to GRH. A future L-function application still needs the actual holomorphic function adapter, certified entire panels, complete domain coverage, and handling of exact equality at the allowed boundary when it occurs. The previously proposed bounded c101 right-slab experiment can exercise the analytic panel path, but was not run as part of this packet.
