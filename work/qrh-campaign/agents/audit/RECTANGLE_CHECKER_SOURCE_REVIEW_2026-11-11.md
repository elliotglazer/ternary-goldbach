# Independent rectangle-checker source/bridge review — 2026-11-11

Verdict: **PASS as a mathematically sufficient source-directed plan.** No blocking flaw was found in the proposed local-log transfer, exact half-open crossing rule, or application of the existing rectangle residue theorem. The ledger does not already supply those new Lean bridge proofs. In particular, actual interval/evaluator soundness and carrier/multiplicity transport remain indispensable.

Reviewed ledger: major-constants/RECTANGLE_CHECKER_SOURCE_LEDGER_2026-11-11.md, SHA25693A2B60572F8D02E1EF47BD6672DA01D21F70927C1D8DB3EF36930E2436EA91A. Read the actual target files and pinned cached Mathlib APIs. The cache HEAD was independently checked as56a005855ea17e0b0958f73ec801ae140b0a1679, matching the stated dependency pin. No compiler, canonical source modification, dependency modification or frozen131-package edit was performed.

## Exact residue-theorem contract

`Explicit/RectResidue.lean:391`, rectInt_logDeriv_mul, has the ledger's stated binders: globally complex-differentiable f; R>0; f(c)!=0; strict coordinate order for z,w; the ENTIRE CLOSED rectangle contained in the OPEN ball(c,R/2); nonvanishing on all four closed sides; and a holomorphic multiplier on an open neighborhood. Taking h=1,U=univ removes only the multiplier requirements, not any f, geometry or nonvanishing condition.

The source rectInt definition at22 is bottom minus top plus i times right minus i times left. With strict coordinate orders this is counterclockwise. NoZerosOnSides at360 includes every corner and all side endpoints. A panel checker must cover those full closed sides; endpoint-only samples do not discharge it.

The center need not be in the rectangle or be its corner. c=2 is valid once f(2)!=0 is proved, and a certified nonzero boundary corner is also a valid center if a sufficiently large R is chosen. The enclosing inequality must be strict. For example, on[-.1,1.1]×[-T,T] with T>=0 and c=2, norm(s-2)<=2.1+T< T+3; hence R=2(T+3) provides strict slack. Checking only the vertices suffices to derive the full-rectangle estimate only with the explicit coordinate/convexity argument.

No zero-free assumption on the enclosing ball or its boundary is required. Conversely, f(c)!=0 cannot be omitted: it rules out the identically zero function and permits finite analytic-order factorization. `Landau.lean:41` factor_ball uses that premise and entire analyticity to show all relevant orders are finite. Its proof at62 uses divisor nonnegativity before replacing integer divisor values by toNat. These are actual orders, not a supplied list or distinct-zero count.

The inspected generic theorem and supporting Landau statements contain no Fact PlattGRH binder. This is a direct source-type/body inspection, not a new compiled transitive axiom audit.

## Local logarithms and endpoint-error cancellation

For unit u in{1,-1,i,-i}, put ell_u(z)=log(u*z). The actual and rational curves must lie in H_u={Re(u*z)>0}. This condition implies u*z belongs to the slitPlane and z!=0. The inspected Mathlib `HasDerivAt.clog_real` at LogDeriv.lean:87 requires exactly that slit-plane hypothesis; nonzero alone would not suffice. Its derivative is the input derivative divided by its value. Applied to u*w(t), cancellation gives w'(t)/w(t).

The FTC API at FundThmCalculus.lean:1148 additionally requires the derivative to be interval-integrable. Entire f composed with an affine input panel has continuous derivative; nonvanishing on the compact panel gives continuity of its logarithmic derivative. The rational image edge is affine and nonzero. Thus the needed integrability follows, but must be included in the formal bridge. Ordinary differentiability of an arbitrary real curve would not by itself supply this integrability. At panel endpoints, slitPlane is open, so derivative-at-point statements follow from the strict half-plane value and the ambient affine extension; no unjustified principal-log differentiation at a branch-cut point is needed.

Write A_j=f(p_j), B_j=v_j and E_j(u)=ell_u(A_j)-ell_u(B_j). Shared input and image vertices must be EXACTLY equal between adjacent panels and at closure. Whole-panel witnesses put both A_j and B_j in the intersection of the adjacent half-planes. The connector B_j+t(A_j-B_j),0<=t<=1, lies in that convex intersection and is nonzero. Both local-log derivatives on it are identical, so FTC gives E_j(u_previous)=E_j(u_next).

For panel j, the actual integral minus its rational-image edge integral is

    E_(j+1)(u_j)-E_j(u_j).

The connector identity and exact cyclic closure make the sum zero, including the first/last join. This is direct integral telescoping. It does not assume equality of principal logarithms on overlapping charts; their possibly nonzero constant difference cancels through the connector identity. Nor does it assume a based homotopy between loops with different basepoints.

Subdivision and affine-reparameterization lemmas must still identify the sum of the actual panel integrals with source rectInt. They must retain the signs on reversed top/left sides and any shared head-prefix reversal. This is an explicit missing formal lemma, not supplied by the mere fact that a list of vertices is closed.

## Exact crossing rule, including ray vertices

Let L(z)=log(-z), and for a nonzero straight edge from a to b avoiding0 let C(a,b) be the stated integer:

- +1 when Im(a)<=0<Im(b) and det(a,b)>0;
- -1 when Im(b)<=0<Im(a) and det(a,b)<0;
- 0 otherwise.

The correct edge identity is

    integral_0^1 (b-a)/(a+t*(b-a)) dt
      = L(b)-L(a)+2*pi*i*C(a,b).

This sign agrees with the source identities at RectResidue.lean:84/89 and Mathlib's principal argument convention. At positive real z, arg(-z)=pi. Therefore an upward edge STARTING on the positive ray receives+1; a downward edge ENDING there receives-1. An upward edge ending there and a downward edge starting there receive0. Horizontal positive-real edges have the ordinary real logarithmic integral and C=0; horizontal negative-real edges similarly have C=0. An edge between opposite real rays would contain0 and is excluded. Zero-length edges have zero integral and C=0. A nonhorizontal straddling edge with determinant0 also contains0 and is excluded.

A useful complete proof split, consistent with the ledger, is available without one-sided integration limits. If the edge avoids the positive real ray, log(-z) is analytic along the whole edge and C=0. If it meets that ray, a straight edge avoiding0 cannot also meet the negative real ray, so G(z)=log(z) is analytic along the whole edge. At its endpoints L=G+pi*i*epsilon, where epsilon=+1 for Im<=0 and-1 for Im>0. Determinant geometry gives epsilon(a)-epsilon(b)=2*C(a,b), including the ray-endpoint cases. FTC for G yields the displayed edge identity. A horizontal positive edge and a zero-length positive vertex are included in this second case.

Summing this identity over a closed polygon telescopes the L endpoint values and gives2*pi*i times the exact crossing sum. The rational polygon need not be simple; its edge integrals and integer winding remain valid. Exact rational vertices make the determinant and sign checks decidable. Strict half-plane witnesses are sufficient to exclude0 on every edge.

As a finite regression only, checked11,160 admissible triangles with nonzero integer vertices in[-2,2]^2, including repeated vertices and vertices on the ray: the rule is antisymmetric under edge reversal and its closed sum agrees after a quarter-turn rotation. This is not a proof of the analytic edge identity; the preceding branch argument is the mathematical justification requiring formalization.

## Why the based-homotopy issue is avoided

Mathlib `Topology/Homotopy/Path.lean:50` defines Path.Homotopy relative to{0,1}. A straight interpolation between f(p0) and a distinct rational v0 generally moves the loop basepoint. Closedness does not make this a relative-endpoint homotopy. The ledger correctly rejects that shortcut. Its local-log/connector method establishes equality of boundary integrals directly and therefore requires no unproved free-to-based homotopy conversion. A future topological implementation would need a separate free-homotopy invariance/basepoint transport theorem.

## From winding to actual multiplicities

Once actual whole-panel enclosure, geometry, subdivision and edge identity are proved, the polygon crossing integer k determines source rectInt(logDeriv f)=2*pi*i*k. Apply rectInt_logDeriv_mul with h=1 and cancel the nonzero factor2*pi*i. The conclusion is equality of k with the sum of toNat(divB) over the actual filtered analytic zero carrier.

Entire analyticity and nonzero-center nontriviality ensure every interior zero has finite strictly positive order and every divisor value is nonnegative. To deduce no zeros from k=0, explicitly show any claimed interior zero belongs to zerosIn f c R (R/2), using strict geometric inclusion and its nonzero analytic order; it would contribute a positive summand. For k>0, the conclusion is the multiplicity sum, never merely the number of distinct roots. Boundary nonvanishing then permits the closed-rectangle formulation.

The remaining carrier comparisons are real proof obligations. The source zetaF is the entire Function.update at1, not the raw product there (`ZetaGrowth.lean:17–30`). For nontrivial strip zeros, the nonzero factor s-1 identifies zeta zeros with zetaF zeros and preserves order. When changing to xi, `WeilBridge.lean:38/55` supplies analytic-order/divisor equalities with the stated real-part and containing-ball conditions. `multRectD_eq_mult` at87 uses STRICT ordinate inequalities, so closed-height sets require larger auxiliary radius parameters before filtering. `ZetaZeroSums.zerosRectD_zetaF_strip:39` is unconditional; its nearby rh_upto_1e8:30 is a separate Platt-dependent theorem and must not be used.

For a head rectangle with bottom ordinate0 and top t, whole-side certificates exclude real and top-boundary zeros. Only after the actual horizontal extent covers the critical strip and the unconditional extra-zero exclusions are proved can its count be called the complete positive-ordinate N(t). Shared bottom/right/crossbar/left pieces require their correct orientations. The later monotone-grid bound for Q1500 must consume these complete counts, not Hardy-Z sign changes or stored monotonicity alone.

## Exact outstanding work

The plan has not implemented: rational interval arithmetic and evaluator semantics; the complex EM identity/remainder and pole-cancelled source-function identity; a genuine chi3 construction with required character properties; coefficient soundness for finite Taylor algebra; local-log/subdivision/connector and exact crossing lemmas; source carrier/order transport; and the final head-grid integration lemma. The new Taylor estimate requires explicit0<=h<1 at outer radius1, correct coefficient truncation at degree<K, and an outer bound for the finite entire approximation g. It must not apply an EM remainder bound outside that bound's real-part domain. The ledger correctly distinguishes the finite-g outer bound from the actual-panel EM error.

The existing source argument-principle theorem supplies completeness and true multiplicity once these hypotheses are proved. The source ledger therefore describes a valid route, not a completed checker or a license to install its desired conclusion as an assumption.

## Source pins inspected

Target paths below are relative to work/ternary-goldbach/TernaryGoldbach. Mathlib paths are relative to the pinned cache's Mathlib directory.

| Source and relevant lines | SHA256 |
|---|---|
| Explicit/RectResidue.lean:22,84,89,360,391 | 6B9C3236C2B4470AA37D3948DAB163573A1A7AFDDE8E963EF127F815EB0B88CF |
| Explicit/Landau.lean:25–43,62 | 6D2A7B97640A49ECBC61F7406006214DB798E9989D8F25740DF3E42600520656 |
| Explicit/WeilBridge.lean:38,55,87 | 285F825F4916B8D8F40256090F56E773140AB2FC2C48E3F057F68A838E17C73E |
| Analysis/SpecialFunctions/Complex/LogDeriv.lean:87,127 | 1DD451C4750B8B9644B7D0A90855EDE26DB7DAC73204BA9ED6124E89F6A1EF19 |
| Analysis/SpecialFunctions/Complex/Arg.lean:599,633 | 1A72570B228D5DE36E5EB12E8F92AFA3990268A525A22210D0899E22B5965514 |
| MeasureTheory/Integral/IntervalIntegral/FundThmCalculus.lean:1148 | 03E854B51266E525A740F7851C916A02A559216CA5E9B4252C07B07F2EB5F23A |
| Topology/Homotopy/Path.lean:50 | 0BFD851BEA035E88293E7B0FF28BE3FA85AB0F972E89BFCD2CB0C14112D96946 |

Additional direct type checks covered ZetaGrowth, ZetaZeroSums, DirichletContinuation.LFunction/differentiable_LFunction, ZMod.LFunction, CauchyIntegral's power-series theorem and Liouville's Cauchy derivative estimate. No claim of a complete transitive axiom audit or exhaustive Mathlib search is made.
