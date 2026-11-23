# Independent rational replay preparation

Status: code prepared for the fixed 929-node experiment; syntax checking only is authorized at this stage. No node, weight, coefficient or half-plane evaluation has been run. This is not a completed numerical review or a verified Lean checker.

The implementation is `replay_small_rational_xi_panel_20261111.py` in this directory. Its syntax receipt records the exact code hash. All outputs must be new files in this directory. The future command requires `--authorize-full-replay`; that flag is an execution guard, not authorization to run it now.

## Fixed specification and independent arithmetic

The source pins are embedded in the code: the next-panel specification `92E778B5...E957`, independent specification review `2F05928D...CC97`, general two-fifths tail review `8C81655B...304CD`, modular identity plan and node-substitution plan. Full hashes are checked before any future numerical evaluation. The actual parameters remain T_input=32, eta=1/33, s0=3/5+14i, rho=1/64, h=1/256, K=928, degree=6. T_work=14 is used only in the coefficient error formula. The function is the unhalved normalized xi function F_b, with b=pi/4-1/33.

The replay imports only Python standard-library modules. It does not import either the producer backend or an earlier numerical helper. Its arithmetic uses 384-bit outward dyadic endpoints, 160 alternating arctangent terms for Machin pi, 112 exponential terms after reduction to at most 1/4, and 192 complex-exponential terms for sin/cos after full interval argument reduction. These differ from the producer's current 320/512-bit, 128/96/160 settings. Fractions carry exact rational values; all rounding is by integer floor and ceiling.

The negative exponential branch returns [0,2^-384] only when the exact endpoint is at most -384. This is justified by exp(1)>2, not a floating underflow convention. Every real denominator must exclude zero, and every sqrt checks ordered nonnegative endpoints and both endpoint-square inequalities. Complex reciprocals use a separately written exact edge-extrema construction, including line and point rectangles, rather than an independent norm-denominator quotient enclosure. No built-in transcendental, numerical theta, zeta, Gamma, or L-function is used.

## Independent modular and terminal assembly

Each seed is computed from exp(2v)*(-cos(2/33)+i*sin(2/33)). The replay chooses its own nearest-integer translation proposals and proves their full real boxes lie in (-3/5,3/5). It preserves the initial theta3 type, the theta2 eighth-root phase for T subtraction, and the theta2/theta4 swap under S. It must certify height growth at each S and stops at terminal lower height at least 2/5. A fifth inversion is forbidden; after four, an unresolved stopping guard rejects the fixed-precision attempt. This respects the specification review's control-flow correction.

The independent transport is forward multiplication of triangular matrices M_total such that J_initial=M_total J_terminal. This is distinct from the producer's reverse step-by-step jet unwind. Each matrix is assembled from the actual local reciprocal and positive-real square-root branch. The entire local matrix and type transition are retained. It never combines branch factors into an unproved square root of a product.

All three terminal theta types are supported, using exactly sixteen paired modes and their ordinary derivatives of orders zero through two. The constant mode appears only in theta3/theta4 order zero. The tighter fixed sixteen-mode radius 2^-277 is inserted in each terminal derivative box, relying on the separately accepted all-index proof in the specification review. The weaker general tail review is not incorrectly substituted for that radius. Matrix arithmetic propagates this radius and every earlier interval error into P; no tail is added a second time downstream.

Every P node is rounded to a center on 2^-32 and its actual L1 error is checked against 2^-24. Its center's squared Euclidean norm is checked against 2^54. The replay retains the seed, modular word, terminal mode terms, accumulated matrix, original jet, final box, center and radius. An inability to meet any bound is a failed/incomplete replay, not evidence against the actual analytic value.

## All weights, coefficients, and acceptance

For all 1857 signed nodes, the replay computes the exact-target weight h*v^j/j!*exp((1/10+14i)*v), for every j=0,...,6. It shares only the exponential for an identical signed v and obtains subsequent factors by exact multiplication by v/(j+1). The zero node is handled by the exact identities exp(0)=1 and 0^j=0 for j>0. This is necessary to check the producer's legitimate zero-radius zero-node weights.

Each weight center is on 2^-64, and its actual L1 radius must be at most 2^-48. Negative P nodes are supplied by conjugation of the corresponding positive node, with zero counted once. All 12999 center products are recomputed with integer arithmetic over 2^96; no floating point or summation error is involved. The code checks full cardinality and unique signed indices before assembly.

The Q, S, and Cauchy bounds are recomputed with this replay's own rational exponential and pi enclosures. The positive-degree spatial threshold q*exp(2V)>=2 is checked. The node/weight envelope contributions and their rho-weighted sum must remain below the specified rational total 0.091500568239<1/10. Every positive-degree coefficient contributes its actual L1 norm times rho^j to U. The whole-disk half-plane test is exactly Re(fhat_0)-U>1/10. No previously observed sign or coefficient enters it. Failure is recorded as an inconclusive half-plane result.

## Comparing the producer receipt

The code includes a schema adapter for the producer backend inspected at hash `DEE8AC9AA39F25023C77003BC2AAA5970388A016207AD5A8EE0DF8F6D912F84A`. It does not execute that backend. It binds the complete producer target dictionary, including the rectangle and grids, reads all 929 positive-node centers and radii, and converts all signed weight groups into the replay's ordering without changing values.

For every claimed node and weight ball, the entire independently computed box must fit within the producer's claimed L1-radius ball. Overlap is insufficient. This check is deliberately sufficient-only: a valid ball with an exact boundary contact could fail because the independent enclosure is wider. Such failure must be reported and investigated, never interpreted as an incorrect analytic value. Increasing precision or comparing a different rigorously justified enclosure would require a new authorized attempt.

The producer's seven coefficient integer pairs are reconstructed from its own supplied centers and checked exactly; the advertised polynomial norm, real margin and half-plane flag are checked against direct arithmetic. The actual functional conclusion then uses the independent analytic error allocation and independently verified radius bounds, not the producer's status string. The raw receipt hash is recorded. Internal producer interval intermediates are not claimed independently verified by this method: it establishes the consumed node and weight claims by a different complete computation.

## Execution boundary

Only AST parsing and Python compilation to an in-memory code object are performed now; the implementation module is not executed or imported. The syntax receipt also checks that no floating literal or non-standard-library import appears. No .pyc or producer artifact is written.

Any future full attempt is bounded by a maximum 600-second guard, checked within elementary evaluations, modes and node loops. It writes a new progress JSONL stream containing only completed nodes and weights; exhaustion leaves an explicitly incomplete prefix, not a certificate. The final receipt is written only after complete assembly and any requested producer comparison. There is no runtime prediction, fixed-precision success guarantee, full-grid acceptance claim, contour-count conclusion, or Lean proof at this preparation stage.
