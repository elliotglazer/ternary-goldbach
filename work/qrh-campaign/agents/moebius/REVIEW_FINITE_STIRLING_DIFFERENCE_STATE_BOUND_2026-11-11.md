# Review of the finite Stirling difference-state bound

2026-11-11. PASS for the finite-polynomial theorem, normalized Newton application and explicit rounded-state width refinement, with no correction to the frozen author. The author is `prime-estimates/FINITE_STIRLING_DIFFERENCE_STATE_BOUND_2026-11-11.md`, SHA256 `4980828A7CDD8A17A9C13427B683CB84B015CFD5ACFF6C9916728A7F00937CF4`.

This review is separate from the accepted rounded-initialization theorem. Its old bounds remain valid and unchanged. The new result supplies narrower sufficient capacities; it does not remove operations, prove a cost winner, construct ordinary-rule certificates or supply numerical coefficients/signs. I read the full author note, script and receipt and the three consumed predecessor contracts. Only formal polynomial coefficients and rational/integer bounds were checked, with no polynomial function samples, analytic values, transforms, builds or frozen edits.

## Finite identity and complete enumeration

For a monomial x^k, expand the exact jth finite difference as the alternating sum of(h+ts)^k for t=0,...,j. The coefficient of h^(k-m)s^m is

    binom(k,m) sum_(t=0)^j (-1)^(j-t)binom(j,t)t^m
      =binom(k,m)j!S(m,j).

The second equality follows either from the falling-factorial basis proof in the note or from inclusion-exclusion for surjections onto j labels. The conventions S(0,0)=1 and S(m,0)=0 for m>0 handle the constant term. The recurrence implies nonnegative integers, and the coefficient vanishes when m<j. Hence all differences above the actual degree vanish.

Taking absolute values only after this exact coefficient identity gives the positive envelope

    B_j=sum_(k=j)^19 sum_(m=j)^k
      binom(k,m)4^(-(k-m))20^(-m)j!S(m,j).

It holds for every real |h|<=1/4 and |s|<=1/20, of either sign, and every complex coefficient array with norms bounded by C. No division by s occurs. At s=0 all positive orders are zero; at j=0 it recovers the ordinary finite geometric bound. Auxiliary points outside the base interval are finite-polynomial arguments only, not new analytic approximation targets.

Multiplying by D=20^19 gives exactly the author's integer formula E_j. I independently computed the alternating integer coefficients rather than using the author's Stirling recursion, then reconstructed all20 E_j, all positive cross-product margins and all raw bounds. Every displayed numerator in the note matches. All degree/order pairs0<=j<=degree<=19 follow by dropping nonnegative higher-degree terms; the separate finite comparisons cover all210 such pairs. Orders exceeding the actual degree were checked as well. These are coefficient identities and inequalities, not sampled function evidence.

Each B_j is strictly below4/3. Thus norm(Delta_s^j P(h))<=CB_j<4C/3 for C>0. The frozen note explicitly handles C=0 by exact vanishing rather than asserting the false strict inequality0<0. Closed base/step endpoints are covered without a limiting argument.

## Partial Newton normalization and raw operations

The exact partial integer polynomial at stage i satisfies

    J_i(t)/(2^b v^i)=P_i(h+st),
    P_i(x)=sum_(ell=0)^i z'_(19-i+ell)x^ell,
    h=q0/v, s=F/v.

Every P_i has the same coefficient cap C and degree at most19. The divisor is stage-dependent2^b v^i, not the final2^b v^19 prematurely applied to every intermediate. Therefore its order-j difference is bounded by CB_j in that normalization. Actual c>10F gives s<1/20; the lemma's closed range also covers equality as a mathematical statement, without silently broadening the selected circuit's guard.

At an interior update, normalize the old-stage products by the new-stage factor. Their absolute bounds are C(1/4+j/20)B_j and C(j/20)B_(j-1). The exact finite comparisons prove their SUM is below4C/3. This bounds each raw product and the unadded absolute sum without relying on cancellation in the next state. The new top uses the secondary term alone. The constant insertion uses C(1+B0/4)<4C/3. Prescales have the direct C bound in their stage normalization. Binary small-factor expansion preserves the coordinate sign of its shifted summands, so every partial sum is bounded by the complete secondary product.

The j19 general-product entry is unused by the degree19 initializer but is a valid conservative extra check. All actual initialization branches, including the top and j0 insertion, are covered. The accepted descending initialization order remains essential. No operation count changes follow from the narrower magnitudes.

For traversal, the physical base h_n remains in the original cell and every order is bounded by CB_j. The further exact comparisons B_j+B_(j+1)<3/2, j0..18, bound each raw sum before acceptance. The largest is the j0 value printed in the note. This is stronger than merely bounding each summand by4C/3. The ascending update reads two old adjacent orders at the SAME physical base; already updated lower entries are not its inputs. No advance past the final physical numerator is needed. Nonunits are still traversed, and no unit-only or skipped-gap recurrence is substituted.

## Join to one-time rounded initialization

The earlier rounded-state theorem supplies a norm error below2^-102 in every live order, with no intermediate rounding. For C=2^16, the new envelope gives

    live norm <(4/3)C+2^-102<2^17,
    raw update norm <(3/2)C+2*2^-102<2^17.

The second statement uses the order-specific adjacent envelope and both current errors, not an invalid claim that arbitrary two numbers below2^17 add within2^17. Thus both stored states and actual raw traversal additions fit p+18 signed bits. At the reviewed maximum p197, both require215 bits. The binomial precision rule, all-order error proof,31u/12 evaluation budget, final dyadic conversion and actual-function source terms are unchanged.

Exact b100 Newton states and raw products have magnitude below(4C/3)2^100 v^i, hence below2^117 Q0 with Q0=v^19<2^362. They fit480 signed bits. The shifted initialization numerator and rounded mantissa times Q0 each fit p+380 signed bits; their raw subtraction fits p+381 and its double p+382. At p197 these are577,578 and579. This bounds the operands before using the accepted small residual. All40 coordinate initialization-round witnesses remain necessary.

I independently checked every one of the260 saved precision/width rows and the unchanged largest-bucket precision. These are sufficient capacities for validated inputs. They do not bound arbitrary supplied encodings, price generation/checking, or make wide initialization conversions free. The independent final receipt also verifies the three predecessor hashes. The earlier draft scalar run was extended to check these final width rows and the note's printed integers; only the final receipt below is used for this verdict.

## Evidence, limits and pins

The owned checker passed3334 exact statements. Its alternate monomial coefficient construction checks all20 monomial degrees against all20 difference orders, finite envelope truncations, raw Newton/advance inequalities, rounding slack and all260 width rows. The author's576 assertions were read, not executed. The author's final receipt hash matches the consumed bytes.

|Artifact under work/qrh-campaign/agents|SHA256|
|---|---|
|prime-estimates/FINITE_STIRLING_DIFFERENCE_STATE_BOUND_2026-11-11.md|4980828A7CDD8A17A9C13427B683CB84B015CFD5ACFF6C9916728A7F00937CF4|
|prime-estimates/finite_stirling_difference_envelopes_20261111.py|2BC8FDEE1E1D9BD81210858CA6AA28441C4620A34A74DCAEF32D2E1E1F620403|
|prime-estimates/finite_stirling_difference_envelopes_20261111.json|6DE1E74B9593BAC00D9849D0B519C10E2C9243D2D2850A209AC89B5C71014E46|
|moebius/review_finite_stirling_envelope_20261111.py|1C773AD9FE68B7BFD67C5B815DD30E410960806BBF18B47546D777AAF444EAD3|
|moebius/review_finite_stirling_envelope_final_20261111.json|34B332B7C0F3DCD90A8BC8581EC7B3EA1B5B9C33B4923E110124200A3D6D0DD5|

The three consumed author pins are Newton55576F70, ten-guardAFA91F89 and rounded-initializationFB0B0F9A, with full paths/hashes retained in the author receipt. Their prior independent reviews remain separate. Acceptance here is the new finite algebra and its explicit capacity consequences. Ordinary-library implementation, checked applications, actual coefficient/certificate production, complete cost comparison and spectral completeness remain outstanding.
