# Independent review of the direct strip evaluator

2026-11-11. **PASS as a source-backed paper convergence argument.** No mathematical correction is required. This review does not certify an implementation, an L-value, a zero-free boundary, or the desired finite spectral assertion. No Lean build, large finite sum, or spectral scan was run.

## Frozen input and sources

The reviewed note is `work/qrh-blueprint/turing-scalars/DIRECT_STRIP_EVALUATOR_CONVERGENCE_2026-11-11.md`, SHA256 `8C33A7A746D72B1ADF3C9C0A20951034E9C6F00B085C82BDC7CF7D29AAD34EEF`. Its complete contents and the complete target `Explicit/LGrowth.lean` were read independently. The latter has SHA256 `5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341`, at the campaign target revision `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

Source facts used, with line numbers in `work/ternary-goldbach/TernaryGoldbach/Explicit/LGrowth.lean`:

- Line 60 defines `psum` using the inclusive finite interval `Icc 1 n`, not `range n` and not a sum including zero.
- Line 62 proves `norm_psum_le` with bound `q+1`, under `chi != 1` and the file's `NeZero q` instance. The reviewed assumption `q>1` supplies this instance and is stronger than needed.
- Lines 81–82 define `Iint` as the Bochner integral over `Ioi 1` of `psum chi floor(t) * t^(-(s+1))`.
- Line 97 proves absolute integrability in `Re(s)>0`.
- Lines 106–150 prove `hasDerivAt_Iint`, with the multiplier **minus** `Real.log t`. The proof uses a local dominated derivative theorem; it does not assume the proposed numerical derivative bound.
- Lines 156–176 prove `LFunction_eq_mul_Iint`. The proof continues the absolutely convergent L-series identity from `Re(s)>1` by analytic uniqueness on the connected positive half-plane. It uses no zero-free assertion.
- Lines 179–198 prove the matching norm bound for the actual continued L-function.

The pinned Mathlib revision is `56a005855ea17e0b0958f73ec801ae140b0a1679`, read from `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`. `NumberTheory/LSeries/DirichletContinuation.lean:97` proves `differentiable_LFunction` for every nonprincipal character, without primitivity. `Analysis/SpecialFunctions/ImproperIntegrals.lean:178` gives the improper power integral with hypotheses exponent `< -1` and positive lower endpoint. These source facts match the domains used here. This was source inspection, not a transitive axiom audit.

## Finite Abel identity and tail

Let `A_n=sum_{k=1}^n chi(k)`, and let `N>=1` be an integer. On each interval `(n,n+1)`, the source floor-sum is exactly `A_n`; endpoint differences affect a null set only. With positive-real powers defined by the real logarithm,

`s * integral_n^(n+1) x^(-s-1) dx = n^(-s) - (n+1)^(-s)`.

Summing for `1<=n<N` gives

`sum_{n=1}^{N-1} A_n (n^(-s)-(n+1)^(-s))`
`= sum_{n=1}^N chi(n)n^(-s) - A_N N^(-s)`.

This also holds at `N=1`, with an empty integral and empty cell sum. Subtraction from the source's absolutely convergent improper integral therefore gives exactly

`f(s)-S_N(s) = s * integral_N^infinity A(x)x^(-s-1) dx - A_N N^(-s)`.

The boundary term has the stated negative sign. No congruence condition on `N` is used. The integral majorant is `(q+1)N^(-sigma)/sigma`, so the norm bound is

`(q+1)(1+|s|/sigma)N^(-sigma)`.

For `s` in the specified rectangle, `sigma>=b>0`, `|s|<=d+max(|u|,|v|)=B`, and `N>=1`. Thus both replacements by `1/b` and `N^(-b)` have the correct direction. The resulting constant `C=(q+1)(1+B/b)` is valid uniformly, including the rectangle boundary. No pole removal or source convention at `s=1` enters this nonprincipal argument.

For rational `b=p/r>0`, strict positivity of all quantities gives the exact equivalence

`C N^(-b)<e` iff `N^p>(C/e)^r`.

The integer search doubles `N`, so `N^p` is unbounded and the test terminates. It does not require computing a real power or testing equality of transcendental numbers.

## Derivative constant and whole panels

The identity `f(s)=s I(s)` holds on an open neighborhood of every point under consideration. Product differentiation and the existing `hasDerivAt_Iint` consequently give the stated actual derivative, not merely a formal derivative of a finite approximation:

`f'(s)=I(s)-s*integral_1^infinity A(x)log(x)x^(-s-1) dx`.

The second scalar integral has value `1/sigma^2`. One direct proof differentiates

`-x^(-sigma)*(log(x)/sigma+1/sigma^2)`.

Its derivative is `log(x)x^(-sigma-1)`, its value at 1 is `-1/sigma^2`, and its limit at infinity is zero. Integrability and the latter limit also follow from the elementary comparison `log(x)<=x^(sigma/2)/(sigma/2)` for `x>=1`, so this evaluation is not using differentiation under an unevaluated integral circularly. This particular evaluated-log-integral wrapper is a new small formal bridge, not a theorem asserted to exist already in LGrowth.

It follows that `|f'(s)| <= (q+1)(1/sigma+|s|/sigma^2) <= L`. The rational constant `L=(q+1)(1/b+B/b^2)` has no missing factor from real versus complex differentiation.

For a segment `a+t(c-a)`, the real parameter derivative is `(c-a)f'(a+t(c-a))`. Convexity of the rectangle keeps the segment inside the set where the bound holds. Integration along the segment yields the claimed Lipschitz inequality. Every boundary panel is horizontal or vertical, so its Euclidean length and its midpoint are rational. A point error `<e` at the midpoint gives the whole-panel complex disk of radius `e+L*ell/2`; either coordinate error is bounded by that same radius. This is a genuine whole-panel estimate, including both endpoints.

## Finite arithmetic and termination

The point evaluator is conditional on a sound finite description of the actual character and sound convergent elementary interval primitives. The note explicitly retains those formalization dependencies. An arbitrary floating table or an opaque function with no checked character identity does not meet this condition.

Once `N` is fixed, all `N` elementary expressions are finite. Give each completed term a complex error `<e/(3N)`, including the root-of-unity and product errors; use a tail `<e/3`; and, if needed, round the final center with error `<e/3`. The strict triangle inequality budget totals `<e`. Exact summation of rational centers introduces no additional error. This is an existence and termination argument for finite arithmetic refinement, not a claim that a current external interval program has been proved sound.

If the entire compact boundary is nonzero, let `m0` be its positive minimum norm and let `ell_max,j` be the largest stage-j panel length. Both `e_j` and `ell_max,j` tend to zero. At any true midpoint, one of the four signed coordinate functionals has value at least `m0/sqrt(2)>m0/2`. Select j large enough that

`2 e_j + L ell_max,j/2 < m0/2`.

Then that coordinate of the computed midpoint center minus its entire panel radius is strictly positive. At either stored endpoint, the same coordinate is at least the true midpoint coordinate minus `L ell_max,j/2` minus the endpoint evaluation error; it is therefore positive as well. The four tests find such a coordinate without knowing `m0`. There are finitely many terminating evaluations at each stage. Exact dyadic subdivision preserves rational geometry.

One rational value must be stored per shared vertex, including the closing vertex. That common value lies in both adjacent accepted half-planes, as does the actual image of the common input vertex. The connector lies in their intersection by convexity. This is precisely the local-log cancellation contract of the accepted `POLYGON_CROSSING_PROOF_2026-11-11.md` (SHA256 `21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B`), independently reviewed at SHA256 `F75647007C294E13132B984A0F6241B516D5113D789AECA922B4DA265A5E73F0`.

Geometry checks must still establish one counterclockwise traversal of the four sides, with no gaps or extra turns. Then the polygon's exact integer crossing sum equals the actual boundary integral divided by `2*pi*i`. The source argument principle at `Explicit/RectResidue.lean:391`, with actual-order/carrier adapters from that accepted plan, supplies the interior zero count with multiplicity. Entirety and boundary nonvanishing rule out poles and identically-zero degeneration. Boundary nonvanishing also makes this the closed-rectangle zero count.

## Independent exact checks and remaining scope

The new script `review_direct_strip_evaluator_20261111.py` uses only Python rational/integer arithmetic. It independently reconstructs `B=8017/8`, `C=6818224/37`, and `L=1363644800/4107`, and checks the strict cutoff test at exponents 106 and 107. It confirms that the least dyadic cutoff for tail allowance `10^(-12)/3` is `2^107`. Five small arbitrary rational-coefficient tests check the finite Abel endpoint convention at `s=1`; those tests supplement, rather than prove, the telescoping argument above. No sum with a large cutoff was attempted.

Reproduce with `work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/major-constants/review_direct_strip_evaluator_20261111.py`.

- Script SHA256: `F3C07143EBA1A8A4BEF374DDE2BB49C5DA357EF44402532924918759267787E0`.
- Receipt `review_direct_strip_evaluator_20261111.json` SHA256: `5252A071B833D5C03FC21CAEF4C3E318561ABB026150CFEBA0363D57A8F92CA1`.

The accepted conclusion is conditional search completeness for a fixed rational positive-half-plane rectangle whose actual boundary is nonzero, together with soundness of an eventual winding certificate after the listed arithmetic and analytic adapters are implemented. The unknown `m0` is used only in the termination proof, not accepted as checker evidence. Success may have positive winding. Requiring zero winding is an additional check and is not guaranteed by boundary nonvanishing. A boundary passing through a zero need not terminate. The note neither establishes the desired spectral statement nor offers a practical full-family computation. The displayed cutoff appropriately illustrates this limitation.

Still unimplemented are the finite Abel wrapper, evaluated derivative bound, segment estimate, effective character manifest, elementary interval semantics, and the polygon/actual-order adapters. No new hypothesis has been accepted at a Goldbach root, and no external arithmetic output has been treated as a trusted Lean operation.
