# Independent review of the lossless two-step receipt

2026-11-11. **PASS for the stated conditional arithmetic scope. No correction requested.** All sixteen gates enclose the full images of their advertised input sets, and all six listed domain conditions hold. The input tau enclosure is still an unproved seed in this packet. This review supplies no analytic seed proof, later modular steps, complete coefficient calculation, spectral conclusion or Lean theorem.

## Frozen packet and independent replay

The reviewed integration artifacts are:

| Artifact | SHA256 |
|---|---|
| `LOSSLESS_MODULAR_TWO_STEP_2026-11-11.md` | `2AC88432744B5D99FC821A16E2A0AD2B3AC9AB5483956F1A0B8DB2FAD8CD4230` |
| `lossless_modular_two_step_20261111.py` | `9A0EFE7074098764FDE27273836158B343F67FF300352B37F6E01B9ED74DE7E6` |
| `lossless_modular_two_step_20261111.json` | `31DD05C2F85A02D29037E91BA63BE85AEC5C55063FED96010552C5BCF0034FBE` |

I read the complete report and implementation, including its fixed recipe, generator, verifier, reciprocal regressions and seven corruption controls. I independently replayed the frozen data using only standard-library rational arithmetic, without importing the producer or Arb and without generating any new analytic values.

New review script `review_lossless_modular_two_step_20261111.py` has SHA256 `F9A4F12BD32AC7EC8D3CDEDA0D019B569DD35CCEB58E0D522110E3471E7057FC`; its JSON receipt has SHA256 `E88DC43ADFC86B22F0FFD4AA96E50AFEF739227A82CFEBA0A516F8958FA05150`.

The replay checks six artifact hashes, all seventeen node records and operand identities, sixteen arithmetic gates, six domain conditions, two additional independent-product square checks, two reciprocal examples with non-corner extrema, and rejection of a rectangle containing the pole. The seed and first translated box exactly match the prior independent lossless diagnosis. The nine corresponding old presentation snapshots contain the new exact internal balls. No original artifact was modified.

## Set semantics and source expression

A real record means the closed interval `[mid-rad,mid+rad]`, with exact signed-exponent dyadics. The redundantly stored lo and hi are checked equal to those endpoints, and the radius is nonnegative. A complex record means the Cartesian product of its real and imaginary intervals. This avoids the previous precision-rounded endpoint export. No claim about arbitrary constructor round trips is required: the verifier uses the serialized exact numbers directly.

The fixed recipe binds the input identities and constants. Its first gates are `translated=tau+1`, `S_output=-1/translated`, and `root_argument=-i*translated`. The root graph then uses the same projected x and y in `sqrt(x^2+y^2)`, `u=sqrt((norm+x)/2)`, and `v=y/(2u)`, assembles `u+iv`, and takes its reciprocal. These agree with the frozen helper's first translation and `root_factor` expression at T=1000000,r=0. Inversion signs and the factor two in the divisor are correct.

The verifier's unproved-seed result must remain visible. Its arithmetic conclusion is valid for any value in the supplied tau box; it does not itself establish that `-cos(2/1000001)+i*sin(2/1000001)` belongs there. A future seed theorem must identify both that expression and the exact box. The free-form description is not such a theorem.

## Every scalar and affine gate

Translation and rotation use exact coordinate images. Projection and complex assembly preserve the exact displayed coordinate intervals. Addition, positive scaling, and division are verified over the Cartesian product of their input intervals. Thus these steps remain sound even when true operands share ancestors: independence enlarges the possible set rather than assuming a false algebraic relation.

For square, the correct unary range includes zero only when the input interval crosses zero. Both actual square inputs are sign definite, and I also checked that the output contains the independent product of two copies of the input interval. Consequently neither square here relies on a tighter correlated rule than independent multiplication would permit. The unary operation must nevertheless retain its declared meaning in a general verifier.

For each nonnegative square root, the input lower bound is nonnegative, the output lower bound is nonnegative, and the squared output endpoints bracket the entire input interval. Monotonicity of square on the nonnegative axis then proves full containment. The root_u and doubled divisor have strictly positive lower bounds. Division therefore has no zero-denominator exception; its extrema are the four endpoint quotients, also reproduced independently by multiplying by the reciprocal denominator interval.

## Complex reciprocal bounds are full-set bounds

For `1/(x+iy)`, the two components are `f=x/(x^2+y^2)` and `g=-y/(x^2+y^2)`. The input rectangle is compact and excludes the origin. Both functions are continuously differentiable near it. Their gradients cannot vanish in its interior: simultaneous vanishing would require x=y=0. Coordinate extrema therefore occur on edges.

On a vertical edge, f has an interior stationary point only at y=0, unless it is constant. On a horizontal edge, its stationary points are x=+/-|y|. For g the corresponding candidates are y=+/-|x| on vertical edges and x=0 on horizontal edges. Corners cover endpoint extrema and constant-edge cases. Every candidate coordinate is rational, so each component extremum is an exact rational comparison. Degenerate rectangles are also covered by the same edge candidate rule, provided they exclude the origin.

The author implements those candidates separately for each component. My independent implementation uses their overinclusive union for both components. All added points lie on the rectangle, so they cannot exceed the true extrema; the necessary extrema are still present. Both actual reciprocal gates pass. For `S_output`, negating a component range reverses its endpoints; for A the sign is positive. The two independent regression boxes reproduce the author's exact ranges and exercise extrema inside edges rather than only corners.

This improvement is mathematical, not an acceptance shortcut. A coarse independent denominator bound can be too large to fit a valid output ball. Failure of that coarse sufficient condition does not refute the operation. The exact rectangle-image test here establishes the required containment directly.

## Principal-root identification and composition

For any exact input z=x+iy with x>0, put `n=sqrt(x^2+y^2)`, `u=sqrt((n+x)/2)`, and `v=y/(2u)`. Then u>0, `n^2-x^2=y^2`, and

`v^2=(n-x)/2`, `u^2-v^2=x`, `2uv=y`.

Thus `(u+iv)^2=z` with positive real part, identifying the principal square root on the right half-plane. The graph's operand identities preserve this exact expression even though its interval arithmetic forgets correlations to obtain safe enclosures. It does not assert that every arbitrary point in the resulting root box squares to the same input z.

The A gate contains the reciprocal of the **whole** root box. In particular it contains the reciprocal of each exact principal-root value produced from the original input set. This proves the desired composition without replacing full-input verification by agreement at an intended point.

The six recorded domain tests are enough for these arithmetic and branch assertions. They do not by themselves verify every stopping, growth or step-selection condition of an entire modular-reduction run. No such larger termination or complete-word result is claimed by this packet.

## Preserved failures and remaining boundary

The seven producer corruption controls are reasonable negative examples for its fixed recipe and arithmetic tests; they are not an adversarial completeness proof. The integer/exponent guards bound this small Fraction experiment. They do not establish a resource-safe parser or a general large-exponent implementation.

All original presentation-endpoint failures retain their original status. This new, differently serialized graph establishes a full-input arithmetic fact for one translation and one inversion/root only. It neither includes nor repairs the later failed root-v edges. The next separate obligation is a proved enclosure of the stated transcendental seed inside this exact internal box. After that, further graph stages, elementary-operation soundness and the source-to-modular-theta identities still require their own proofs and receipts. No spectral or whole-pilot conclusion is accepted here.
