# Assemble closed zero-free slabs into a complete family strip

2026-11-11. This is a finite-coverage and analytic-count proof plan. It proves what a complete collection of local certificates would imply; it does not supply that collection. No scan, Lean declaration, build, dependency change, or frozen-file edit is made. An isolated successful local packet is never treated as coverage of an initial height interval or a whole character family.

The recommended assembly is simple: certify nonvanishing on each **closed** tile, check an exact finite partition of the requested rectangle, and take the finite union. Count additivity and direct polygon cancellation are valid alternatives, with additional seam bookkeeping described below.

## 1. Actual function, labels, and target

For each selected primitive nonprincipal Dirichlet character chi of conductor c>1, use the exact uncompleted continued function

\[
 f_\chi(s)=L(s,\chi).
\]

It is entire. In pinned Mathlib commit `56a005855ea17e0b0958f73ec801ae140b0a1679`, `NumberTheory/LSeries/DirichletContinuation.lean:97`, `differentiable_LFunction`, gives complex differentiability everywhere when `chi!=1`. The application must bind the packet to that actual character and continuation, not merely to an array with the same length.

Let b=111/200, or more generally any specified rational b<2. Let H(c)>0 be the exact selected finite spectral height, and choose a rational T with `H(c)<T`. The requested target is the closed rectangle

\[
 R_{\chi,T}=\{s\in\mathbb C:b\le\Re s\le2,\ -T\le\Im s\le T\}.
\]

Its nonvanishing implies the same statement through the **inclusive** height `|Im s|<=H(c)`. Strict H(c)<T avoids any need to appeal to a limiting zero count at the spectral cutoff. Closed nonvanishing at T would also make equality sufficient mathematically, but this protocol explicitly checks the stricter contract requested here.

Exclusion on [b,2] rules out beta=b as well as beta>b. It is stronger than a target allowing beta<=b; its failure at a genuine zero on beta=b would not refute that weaker target. To deduce a bound for all *nontrivial* zeros, use their actual source critical-strip membership `0<Re s<1`. The slab alone makes no assertion about zeros at Re s>2; any such separate assertion must use the appropriate Euler-product theorem, not geometric coverage.

The family manifest must enumerate exactly the active primitive source characters from the selected blueprint. A different modulus inducing the same primitive character is not a new unconstrained label, and an arbitrary imprimitive L-function cannot replace its primitive continuation. The assembly argument is per exact source character; the full-family claim requires a verified complete manifest and coverage for every entry. Conductor-one zeta is a separate analytic function/row. If included, its entire pole-removed function and equivalence to the desired zeta zeros must be explicitly supplied; this nonprincipal-L protocol does not silently include it.

## 2. What one local zero-winding packet proves

For a rational rectangle `Q=[x0,x1]+i[y0,y1]`, with x0<x1 and y0<y1, a valid packet must provide the actual-function boundary enclosures and finite geometry required by the accepted polygon bridge:

* `major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md`, SHA256 `21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B`;
* independent review `independent-feasibility/REVIEW_POLYGON_CROSSING_PROOF_2026-11-11.md`, SHA `F75647007C294E13132B984A0F6241B516D5113D789AECA922B4DA265A5E73F0`.

Concretely, the source panels traverse the four sides exactly once counterclockwise. For every whole panel gamma, a coordinate rotation `u in {1,-1,i,-i}` satisfies `Re(u*f_chi(gamma(t)))>0` for all t in [0,1]. Both stored rational image vertices satisfy the same strict inequality. The image vertex at each successive source vertex is shared, including closure. Exact half-open positive-ray crossings give an integer k.

The accepted local-log proof identifies `2*pi*i*k` with the actual contour integral of `f'/f`; it does not require a based-homotopy shortcut. Boundary enclosures give nonvanishing on the complete closed sides, including all vertices. Endpoint samples alone do not prove the whole-panel inequalities.

The actual source `Explicit/RectResidue.lean:391`, `rectInt_logDeriv_mul`, then identifies k with the sum of the **actual analytic multiplicities** of interior zeros. Its `NoZerosOnSides` definition at line 360 quantifies over the closed four sides. The enclosing-ball and nonzero-center requirements can be derived from the local packet: take its bottom-left corner as center and radius `2*((x1-x0)+(y1-y0)+1)`. This contains the rectangle strictly in the half-radius ball, and boundary nonvanishing gives the nonzero center value.

The finite carrier must be transported from `zerosIn`/`divB` (`Explicit/Landau.lean:25,31`) to actual zeros and their intrinsic analytic orders. Entire analyticity and a nonzero boundary point show f is not identically zero. Each zero has finite positive order; only then is conversion to a natural number valid. Different local enclosing balls can yield different stored carriers, but they assign the same intrinsic multiplicity to the same actual zero. Merely adding unrelated stored `divB` entries is not the carrier theorem.

It follows that k is nonnegative. If k=0, there is no interior zero, and the already proved boundary nonvanishing covers the rest of **closed Q**. Write this verified consequence as `ClosedNonzero(chi,Q)`. It is the conclusion to extract from a packet, not an additional numerical assumption.

## 3. Primary finite coverage theorem: stacked slabs

Choose a finite strictly increasing rational partition

\[
 -T=y_0<y_1<\cdots<y_m=T,\qquad m\ge1,
\]

and define `Q_j=[b,2]+i[y_j,y_(j+1)]` for 0<=j<m. Require one verified closed nonvanishing consequence for every Q_j, with the same actual chi and function normalization.

Then f_chi is nonzero on R_chi,T.

**Proof.** For any point s in R_chi,T, its imaginary coordinate lies in at least one closed interval `[y_j,y_(j+1)]`. One elementary proof takes the least index i>=1 with `Im s<=y_i`; it exists because `Im s<=T=y_m`. Minimality gives `y_(i-1)<=Im s`. Together with `b<=Re s<=2`, the point lies in Q_(i-1), so its local closed nonvanishing conclusion applies. At a seam `Im s=y_j`, either incident closed slab suffices. At Im s=±T the first or last slab applies. No limit and no assumption of interior membership is needed.

The real-axis seam is included if some y_j=0. A possible real zero is not omitted: it would contradict the closed boundary nonvanishing of that slab. Heights of zero exactly equal to H(c), y_j, or T are all handled by the same closed statement.

This theorem does not require rational image vertices to match between two independently certified slabs. Those vertices were auxiliary devices for obtaining their individual actual-function statements. At the common source edge, the actual f_chi is the same function, regardless of which valid local approximation established its nonvanishing.

## 4. Horizontal refinement and exact tiling

If a producer certifies narrower real intervals, choose a second strictly increasing rational partition

\[
 b=x_0<x_1<\cdots<x_n=2
\]

and require every Cartesian tile `Q_(i,j)=[x_i,x_(i+1)]+i[y_j,y_(j+1)]`. Applying the interval argument independently to the real and imaginary coordinates proves the same finite union theorem. All horizontal seams, vertical seams, and their intersections are included because every tile is closed.

This Cartesian normal form provides a small exact geometry checker. It rejects missing tile indices, repeated indices, wrong endpoints, non-strict partition steps, and any unannounced positive-area overlap. The ordinary intersection of neighboring **closed** tiles on a seam is intentional and must not be rejected as an overlap error.

For non-Cartesian stored rectangles there are two sound options. Either refine all rational endpoint coordinates to a common grid and prove that every elementary grid tile is contained in at least one verified closed rectangle, or prove a separate exact tiling theorem. In the first, cover-only option, positive-area overlaps are harmless for nonvanishing, but multiplicities must **not** be summed over the overlapping rectangles. The checker must declare this cover-only mode explicitly. It cannot mix its geometry with the count-additivity rule below. The recommended standard protocol is the exact partition/tiling mode.

## 5. Count additivity, including why seam checks are necessary

Assume the same exact finite grid and nonvanishing on every local boundary, but allow local winding counts k_(i,j) to be arbitrary verified nonnegative integers. Every actual global interior zero lies off all grid seams, because those seams are part of local boundaries. It therefore belongs to exactly one local **open** interior. Conversely, every local interior zero is a global interior zero. Intrinsic multiplicity is unchanged by its assignment. Hence

\[
 N_f(\operatorname{int}R)=\sum_{i,j}N_f(\operatorname{int}Q_{i,j})
                         =\sum_{i,j}k_{i,j}.
\]

Boundary nonvanishing is essential. Without it, a zero on an internal seam would be in none of the open tile interiors. For example a linear function vanishing at the midpoint of a horizontal seam has no zero in either adjacent open slab, but does have a zero in their union. Such a seam must fail the strict boundary packet; declaring both local counts zero without that check is invalid.

There is also an integral proof: f'/f is continuous on all closed tile edges, so the oriented integral on an internal edge cancels with that on its reverse. Finite interval subdivision/additivity gives

\[
 \operatorname{rectInt}_R(f'/f)=\sum_{i,j}\operatorname{rectInt}_{Q_{i,j}}(f'/f).
\]

The outer and local argument principles give the same count formula. This proof uses the same actual f on both sides of every edge and requires its nonvanishing there; a totalized expression for f'/f at a zero does not repair the missing integrability/argument-principle hypothesis.

If the sum of the verified local counts is zero, nonnegativity implies each count is zero. The closed-cover theorem then excludes every zero in R. A negative local count is not an admissible way to cancel a positive one; it signals an orientation, geometry, analytic, or arithmetic error in this entire-function protocol.

## 6. Direct cancellation of stored polygons is a stronger data contract

Actual contour-integral cancellation does not require the stored rational image polygons of adjacent packets to coincide. **Direct finite polygon cancellation does.** To use that more economical route, impose a global source-edge mesh for one fixed actual function and one stored rational image value at every global source vertex.

Each internal source edge is recorded twice with exactly reversed panel subdivision and exactly reversed image-vertex sequence. Each whole-panel half-plane assertion and the common image vertices are verified as in section 2. Then every rational image edge `(a,b)` on a seam is paired with `(b,a)`. The accepted half-open crossing rule obeys `C(b,a)=-C(a,b)`, including ray endpoints and zero-length image edges. Thus all seam contributions cancel exactly, leaving the image polygon for the outer boundary. The actual contour integrals cancel in parallel.

If adjacent independent packets use different subdivisions, first refine their source mesh. If their rational image values differ at a shared point, one must either retain the independent local-packet/count route or construct and verify common replacement vertices. It is not valid to cancel nonidentical image edges merely because they approximate the same actual seam. A replacement vertex must lie in every incident strict panel half-plane; linear interpolation of one packet's old image edge alone does not prove the other packet's half-plane constraints.

The local-log connector argument in the accepted polygon proof is sufficient to justify independent polygons via their actual integrals. It does not turn them into identical finite edge lists. This distinction prevents both a hidden seam error and an unnecessary requirement that all independent local certificates be regenerated.

A separately verified zero-winding outer boundary could also exclude the full interior directly, without checking an internal mesh. That is a different valid protocol. It must actually certify that outer boundary; an incomplete set of unrelated interior pilots is not such a certificate.

## 7. Character, inverse-character, and normalization transport

Every local packet carries an exact function key: conductor, actual primitive character, evaluation convention, and analytic normalization. The key must be resolved to a source object by a proof, not solely a string or hash. A hash binds bytes; it does not establish character multiplicativity, conductor, or equality of continuations.

For complex Dirichlet characters the exact identity is

\[
 L(\bar s,\chi^{-1})=\overline{L(s,\chi)}.
\]

It follows first on Re s>1 from absolute convergence and `chi^{-1}(n)=conj(chi(n))`, including zero values at nonunits, then everywhere by continuation. It preserves zero multiplicity, as seen by conjugating the local analytic power series. Consequently a **positive-height** certificate for chi transports to a negative-height certificate for chi inverse, not automatically to chi itself.

To assemble both signs for one nonreal chi, either certify its whole interval [-T,T] directly, or certify [0,T] for chi and for chi inverse and explicitly reflect the latter. Their closed intervals include the real-axis seam. If chi is real, a proved `chi=chi^{-1}` allows reuse. A root phase used to make a completed function real on the critical line supplies no general substitute for this character-label identity.

Under conjugation the source rectangle and image curve both reverse orientation; for a packet-level CCW protocol, reorder the reflected source panels back to CCW and conjugate their image data with the proper order. The simplest assembly route transports the already proved closed-nonvanishing statement, avoiding any ambiguity about a reflected crossing sign.

Multiplying L by an analytic nonvanishing factor preserves its zeros and orders on a tile, but that factor must be proved nonvanishing on the full tile. If packets use different normalizations, first transport each result to the same actual f_chi. Raw cancellation of logarithmic derivatives from differently normalized functions is not justified merely by matching character names. In particular, the nonprincipal Hurwitz combination across s=1 is identified with L by cancellation and analytic continuation; individual totalized Hurwitz values are not interchangeable with their pole-subtracted limits.

## 8. Finite certificate acceptance checks

A checker for the partition protocol must verify all of the following before claiming full-strip coverage:

1. **Target binding.** The exact rational b, the specified H(c), and T satisfy b<2 and `0<H(c)<T`. The conductor/character key and normalization resolve to the intended source function, and its entire/nonprincipal proof is available. Equality of approximate decimal labels is not sufficient.
2. **Coverage.** The first and last height endpoints are exactly -T and T, every step is strictly increasing, and every required slab or grid index appears exactly once. In grid mode the real endpoints are exactly b and 2. Reject gaps, duplicate cells, reversed or zero-width cells, and unannounced positive-area overlaps. Exact rational equality is required at joins; overlapping floating endpoint balls do not prove adjacency.
3. **Local perimeter.** Each packet binds to its claimed tile, traverses every source side exactly once CCW with no skipped interval, and shares its local source/image vertices through closure. Matching only total perimeter or starting/ending points is insufficient.
4. **Whole-edge semantics.** Regenerate or formally check every actual-function panel enclosure and strict half-plane inequality, including corners and every internal seam. A sampled nonzero edge, an uncertain enclosure touching zero, or a producer status `INCOMPLETE` is not acceptance.
5. **Actual count.** Apply the accepted polygon and source argument-principle bridge to actual analytic orders. Require local count zero for cover mode, or verified nonnegative counts and the exact sum for count mode. Do not discard repeated multiplicity or treat an isolated numerical root as simple by default.
6. **Assembly mode.** Use the finite closed-cover theorem, actual-integral count additivity, or direct shared-polygon cancellation consistently. The last mode additionally requires globally identical reversed seam edge data. Cover-only overlaps must never enter a count sum.
7. **Label completeness.** Verify a complete entry for every source character in the requested family manifest. A repeated character, an inverse substituted without reflection, a missing conductor, or reuse of a packet for another root phase/function is rejected. Cross-character rectangles do not stitch into a single character's strip.

These are concrete correctness checks, not new mathematical assumptions to add to the final theorem. Their finite data and the proofs of their analytic enclosure semantics still have to be produced.

## 9. What the conductor-101 pilot would contribute

The current pilot note `zero-sum/C101_RIGHT_SLAB_CERTIFICATE_2026-11-11.md` was read as a work-in-progress artifact, SHA `83136C09EB5E4F1454439CE19ECAA40907FAFAB84E89D14CBE53E01510D39635` at inspection. Its final result was not yet appended. This note does not assume it passed or freeze that in-progress file.

Its actual character is the primitive nonprincipal odd nonreal character

\[
 \chi_1(2^j\bmod101)=e^{2\pi i j/100},\qquad\chi_1(0)=0.
\]

Its inverse is label 99 under the same generator and positive-exponent convention. Its requested rectangle is exactly

\[
 [111/200,2]+i[7999/8,8001/8].
\]

If its local analytic/arithmetic packet and zero-winding proof are accepted, section 2 gives closed nonvanishing on precisely that rectangle for chi1. It supplies one full-width slab near height 1000 and, by explicit conjugation, one reflected slab for chi99. It does not cover [0,1000], any seam to an absent neighbor, the negative band for chi1, all 99 nonprincipal characters, or H(101).

To use it in the primary protocol, its two height endpoints must occur in the exact partition for the same chi1 target, and all remaining partition slabs must be supplied and checked. Any final complete-family claim must wait for the full per-character finite cover and its source-bound proofs. The assembly theorem explains how that conclusion follows; it does not supply the missing data.

## 10. New evaluator companion is not an input

The parent reports a new, not-yet-reviewed note `work/qrh-blueprint/turing-scalars/DIRECT_STRIP_EVALUATOR_CONVERGENCE_2026-11-11.md`, SHA `D3DDBA28BB744532573C19DFFEA61F63EAADBA0AFCB53173CA51F71EFC9D0B0D`, proposing a direct Dirichlet-tail and derivative-bound evaluator with terminating refinement on a fixed nonzero boundary. This assembly does not consume that proposal or assert its correctness. Even a future proved termination theorem conditional on boundary nonvanishing would not itself prove that the prohibited strip contains no zeros; local winding counts and complete coverage would remain necessary. Its producer proof belongs to a separate independent audit.
