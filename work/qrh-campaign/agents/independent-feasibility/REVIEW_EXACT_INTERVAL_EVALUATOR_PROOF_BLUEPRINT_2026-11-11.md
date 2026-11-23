# Independent review of the exact interval evaluator blueprint

Verdict: **PASS as a source-supported implementation blueprint, not as an implemented or proved generic checker.** No mathematical obstruction was found in the proposed restricted acceptance contract. The interval-validity and initial-theta-type conditions below must be explicit in its eventual definitions; they are not conclusions supplied by a producer or a JSON label.

Reviewed author file: `integration/EXACT_INTERVAL_EVALUATOR_PROOF_BLUEPRINT_2026-11-11.md`, SHA256 `E3ACCCDAB3D3A6F34D51702843A4D7A6807D0CD4DE52DA7AA2485BB3C0835398`. The author file was read in full and left unchanged. This review includes the prior r=1/8 node report and its independent review, and direct inspection of the pinned Mathlib exponential, arctangent, square-root and theta APIs and the target Xi definition. No Lean/Lake execution, new numerical node, or scan was performed.

## Exact target and logical boundary

The checker must take independently fixed rational r and natural T>=1, compute eta=1/(T+1), and interpret the certificate as evidence about that input's actual P(r+i(pi/4-eta)). Neither a file hash nor a claimed input field can replace this binding. An untrusted JSON converter is acceptable for a theorem about the resulting typed value, provided the theorem names the independently fixed input; it does not prove a statement about the JSON bytes.

The separation into arithmetic containment, actual elementary functions, actual theta/modular identities, and final kernel-checked acceptance is correct. In particular, proving `accepts -> enclosure` does not prove that a given receipt is accepted. Both the generic soundness theorem and the concrete finite acceptance proof remain to be constructed. The author explicitly leaves the actual P normalization wrapper open rather than inserting its conclusion as a hypothesis.

Two definition-level requirements should be copied into the implementation contract:

1. Every input and witness interval has ordered endpoints L<=U, with positive rational denominators. This is needed even when the interval denotes an empty set vacuously: later graph nodes cannot manufacture existence from such an interval. For a scalar sqrt gate with input [a,b], require 0<=a<=b and 0<=L<=U, L^2<=a, b<=U^2. Checking only L>=0 and the square inequalities would allow a negative upper endpoint. The source `sqrt_le_iff` explicitly requires nonnegativity of that upper endpoint.
2. The modular word's initial selected type is theta3, and every edge verifies its type transition. An arbitrary valid word for theta2 or theta4 cannot be plugged into the final theta3 formula. The blueprint's fixed P target and checked selected-type language support this requirement, but the eventual root state must enforce it.

## Arithmetic and elementary gates

The reciprocal candidate set is complete. For Re(1/z)=x/(x^2+y^2), the gradient is ((y^2-x^2),-2xy)/(x^2+y^2)^2 and cannot vanish away from the origin. On vertical edges the only extra stationary coordinate is y=0 (or the coordinate function is constant when x=0); on horizontal edges it is x=+/-y. The imaginary component follows by swapping coordinates and negating. Corners cover constant-edge cases. Restricting these candidates to each segment and handling point/line rectangles gives the claimed full-image enclosure. Excluding the origin is essential and correctly required.

For x>0 the principal-root construction has n>=x>0 and u=sqrt((n+x)/2)>0. With v=y/(2u), one has 2uv=y and u^2-v^2=x using n^2=x^2+y^2. The positive real part identifies the principal root. These are identities of the same actual x,y; interval overlap would not prove them. Its holomorphic derivative identity remains a separate analytic fact, as the blueprint says.

The proposed real exponential remainder is a valid weakening of `Real.exp_bound'`: for 0<=t<=1/2 and N>0, t^N*(N+1)/(N!*N)<=2^-N*(N+1)/(N!*N). Rescaling by a checked x=2^k t and finitely many squarings, and handling negative x through a strictly positive exp(-x) enclosure, is sound. A usable reciprocal denominator may require more precision; this is a producer issue, not permission to divide through zero.

The complex exponential source bound gives error 2*R^N/N! when |z|<=R and R/(N+1)<=1/2. Its source theorem does not require N>0; the N=0 case is valid but crude. Applying it to the imaginary reduced argument supplies both sin/cos coordinate errors. The full interval X-2k*pi, including pi uncertainty and signs of k, must be reduced. No monotonicity of sin/cos is needed. The Machin formula in the pinned source is 4*atan(1/5)-atan(1/239)=pi/4, so the stated alternating-series route has the correct normalization. Signed eighth-root selection must prove the residue-class identity, not merely an eighth-power equation.

## Independent all-index check of the restricted theta tail

Here is a complete bound justifying the blueprint's uniform constant, including N=0. Let a=u+k, u=N+1/2>=1/2, k a nonnegative integer, Y>=1, and j in {0,1,2}. Since 3<pi<4,

`(pi*a^2)^j <= 16*a^4`.

Also `a^4 <= 2*exp(a^2)`, by the quadratic term of the exponential series. The two signed modes therefore contribute at most

`2*(pi*a^2)^j*exp(-pi*Y*a^2) <= 64*exp(-2*Y*a^2)`.

The last step uses pi*Y-1>=2Y. Since (u+k)^2>=u^2+k, summing yields at most

`64*exp(-2*Y*u^2)/(1-exp(-2*Y)) <= 128*exp(-2*Y*u^2)`.

Indeed exp(2Y)>=exp(2)>=4, so the geometric denominator is safely bounded. For natural M<=2Y*u^2, exp(1)>=2 implies exp(-2Y*u^2)<=2^-M. Thus the rational replacement is valid for every index, not only the four modes of the old fixture. Integer-mode tails admit the same estimate with their own first omitted positive integer; their zero-mode constant is exactly 1 only at derivative order zero and must be included separately. Enlarging both coordinate radii by a norm-tail bound is safe; a later disk conversion must account for both coordinate widths.

This proof requires Y>=1. The modular reduction's Y>2/5 guarantee does not imply it. The blueprint explicitly retains this restriction and does not claim all-input or all-word completeness. General coverage requires a proved tail valid at the weaker threshold or a different accepted evaluation route.

## Analytic composition and termination

The seed identity is exact: i*exp(2r+2i(pi/4-eta))=exp(2r)*(-cos(2eta)+i*sin(2eta)). T>=1 and pi>3 place w strictly inside |Im w|<pi/4 and tau in the upper half-plane. Local S square roots must retain the holomorphic principal branch there. Multiplying local factors cannot be replaced by selecting a square root of their product. Finite word induction with the actual holomorphic S/T identities gives the jets; numerical square-root identities alone do not justify differentiated formulas.

The final coefficients have the correct unhalved normalization. From theta3(tau)=1+2*sum_{n>=1} exp(pi*i*tau*n^2), the expression exp(w/2)*(6*tau*theta3'(tau)+4*tau^2*theta3''(tau)) equals

`sum_{n>=1} (8*pi^2*n^4*exp(9w/2)-12*pi*n^2*exp(5w/2))*exp(-pi*n^2*exp(2w))`.

This checks the signs, factors of two and derivative convention. Establishing convergence, differentiation and identification with the actual source Fourier kernel remains a theorem-producing task; the source Xi file alone does not package that bridge.

Checking finite lists and bounded earlier references is well-founded. Finite rational operations and supplied Taylor lengths terminate even if impractically expensive; fuel may safely reject. This does not require an analytic search for precision or a proof that the producer finds a modular word. For a fixed admissible finite computation, interval widths can be driven to zero when positive-domain tests have clearance. That does not promise containment in an arbitrarily frozen boundary-tight witness box, a uniform runtime, sign decision at zeros, or completion of a spectral search. Those claims are not needed for the proposed soundness theorem.

## Source pins and remaining work

Recomputed hashes match the blueprint for `Analysis/Complex/Exponential.lean` (`564992EF...86F0`), `Analysis/Real/Pi/Bounds.lean` (`58E8B7A9...B036`), both JacobiTheta files (`7C29B4B0...6B5C`, `CC4E420D...8820`), and target `Explicit/Xi.lean` (`988EDFBC...3D1F`). Direct source inspection confirms the cited arctangent, square-root and exponential roles. Classical theta2/theta4 wrappers, differentiated modular identities, the P bridge, generic checker soundness, concrete kernel evaluation, and final axiom audit remain work; this review does not claim their implementation or elaborated compatibility.

The accepted r=1/8 seed and local node evidence are not reopened. They remain useful fixtures, while the generic theorem and its closed Lean instance are absent. No correction to the frozen author note is required for its stated blueprint scope; the explicit definition-level conditions above are mandatory when implementing it.
