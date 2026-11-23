# Review of exact residue finite differences

2026-11-11. Independent mathematical/source and exact-integer review. PASS for the two conditional finite-polynomial circuits in the V2 author report. This is not a Lean/MM0 theorem, actual coefficient certificate, spectral result, measured runtime improvement or adoption into the operation ledger.

The reviewed author is `integration/EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2_2026-11-11.md`, SHA256 `691A9B744FCCE7C7A8F0D8F18F08F70A68C758D2FFFF1C5E826F138E1257D025`. I read the full report, both author checkers and receipts, and the relevant source interfaces. One inaccurate draft sentence bounded differences themselves by 4C. The versioned successor correctly bounds their supporting polynomial values by 4C and the integer differences by 2^j*4C*Q. No remaining correction is requested. The predecessor is not the accepted version.

## Exact target and geometry

The source consumer is the degree-19 polynomial of the twenty delivered complex coefficient centers for f(alpha)=zeta(s,1+alpha), evaluated at h=Dout*(a/c-k/(2Dout)). Separate finite-head/residue corrections in the attachment to L remain required. The first four output normalizations are 512,1024,2048,4096. The final normalization is8192, although its source seed grid has D4096. The joint construction's equation6 explicitly supplies the final 2^-k coefficient postscaling. The m159 refinement preserves it. Neither source order P27/P28 nor an unscaled derivative is substituted for these twenty output coefficients.

Set F=2Dout, v=2c, r=Fa-kc and Q=2^b*v^19. If a coordinate center is n_j/2^b, direct expansion gives

    I(a)=sum_j n_j*r(a)^j*v^(19-j),
    P_coordinate(h(a))=I(a)/Q.

Thus the integer step is F, and the denominator of h is2c. All subsequent identities concern this exact stored-center polynomial. Common-grid alignment must be an exact shift of the actual signed dyadic encodings. An assumed b122 grid cannot replace that check.

The ties-up formula and clipped cell endpoints in author section1 are correct. Section8 separately binds the occupancy manifest's ties-down formula and the reversed strict endpoints. Both satisfy |h|<=1/4. Reflection a->c-a preserves untrimmed bucket sizes and units but does not identify anchor coefficients. A concrete implementation must use its declared tie rule in both geometry and coefficient lookup. The current independent check includes184 exact ties and both endpoint conventions.

## Initialization and updates

For a long block L>=20, all twenty initialization points are admitted points of one cell. The prescaled polynomial Horner evaluation takes nineteen signed wide-by-small products and nineteen additions per coordinate and point. The triangular table takes190 subtractions per coordinate. Pascal's identity proves the binomial expression for each forward difference; degree at most19 proves the twentieth difference vanishes. This is an integer polynomial argument, with no analytic evaluation or convergence input.

The live state at position i retains precisely orders j<=min(19,L-1-i). Increasing-order updates read the old higher slot, so they implement

    Delta^j I(a+1)=Delta^j I(a)+Delta^(j+1) I(a).

The highest order remains constant only when it is still retained. Dropping slots near the endpoint prevents their supporting nodes from leaving the block. Summing the update counts gives19L-190. The author correctly keeps Horner for L<20 in this first variant. Nonunit numerators still require advances; exporting only units is a separate checked coverage condition. Empty-unit pruning, trimming and partitioning need an exact manifest proof.

I independently checked every live slot, not just the exported order-zero value, against its binomial formula for all twenty monomial bases on bounded exact integer blocks of lengths20,21 and longer. The check physically prunes the state. These fixtures test the construction; the general proof is the polynomial identity above.

## Screened full-state variant

Section8 permits twenty initialization points in a shorter endpoint bucket only under the checked guard c>20F. Since F=2Dout, every supporting point at distance j<=19 from an admitted physical numerator satisfies

    |h(a+j)|<=1/4+19Dout/c<29/40<3/4.

The resulting extra points may lie outside the cell or outside alpha in[0,1]. Only the finite polynomial is evaluated there. No Hurwitz comparison is used at those points. At each actual unit output the original in-cell actual-function theorem still applies. The same argument bounds the support of every live full difference, not just initialization.

This version keeps all twenty orders and charges19(L-1) advances. Its total complex additions/subtractions are19L+551, compared with19L+380 for the pruned method. It also pays initialization in every nonempty integer bucket, including a bucket with no units, unless a distinct checked pruning rule is supplied. The occupancy necessary screen phi(c)>20B_c implies c>20F: otherwise every cell has length at most20, and phi(c)<=c-1<=20B_c. This implication is valid without a unit-distribution assumption. It is not a cost-sufficiency result.

The independent fixtures explicitly use ties down, including short endpoint cells and polynomial-only points beyond the final physical numerator. All full-state slots are checked. The occupancy family's global totals and screened conductor counts belong to its separate review; this review does not inherit them merely from a pinned report.

## Width and error bounds

The source reports give complex center magnitudes below2^16. On the original cell, |P|<(4/3)*2^16<2^17. The binomial formula therefore gives |Delta^j I|<2^(17+j)Q, with every supporting node admitted. Raw additions/subtractions are below2^37 Q. Partial Horner sums obey the corresponding geometric bound after factoring v^(19-j); no large formal monomial expansion is required.

At c=265800, v^19 has362 bits. For b122, Q has484 bits. The stated521-bit signed live capacity and522-bit signed temporary capacity are sufficient. These are conservative bounds, not a minimum-width claim. In the screened full-state variant, the geometric factor becomes4, so live and temporary capacities become522 and523 bits. Its setup r can exceed c/2; the bound |r|<3c/2 is retained and priced. A finer actual coefficient grid increases b and every dependent width.

The exact signed rounding inequalities

    (2m-1)Q <= 2^(g+1)I < (2m+1)Q

prove the intended nearest-dyadic conversion, including negative inputs and ties toward positive infinity. Each coordinate error is at most2^(-g-1), hence the Euclidean complex error is strictly below2^-g. At g100 this is below the old u_H. For b122, cancelling the common powers of two leaves a384-bit denominator. Quotient/remainder or equivalent exact witness checks remain required; cancellation is not permission to omit division work.

Coefficient uncertainty and analytic target/shift remainders compare the actual function to the exact stored-center polynomial. Exact finite differences introduce no new coefficient error and require no repeated uncertainty propagation. The final rounding contributes below633u_H after the actual unit-character sum and c^-s normalization, replacing the old1688u_H. The first-four-band and joint final-band alpha budgets therefore remain valid. The output center need not equal the old rounded Horner center. This replacement does not change conductor phases, character transforms, height interpolation, exceptional precision or strict sign/count requirements.

## Cost and acceptance limits

For the long method the nineteen complex prescales,380 initialization products,380 initialization additions,190 triangle subtractions,19L-190 advances and U final complex conversions reconstruct the author's complete displayed arithmetic skeleton. One complex product by a real integer represents two signed integer products. Setup of v powers, common-grid alignment, coefficient binding, unit coverage, cache access, memory traffic and proof production are additional named costs. Prescales are reusable only for the same polynomial/cell/conductor/height.

The twenty-point initializer prevents an unweighted product-count win for U<=20 even before charging prescales. U>20 is merely necessary for that restricted comparison. Wide exact additions and final conversions may erase a nominal saving. The full-state method has its distinct advance/width prices. Its counts cannot be inserted into the pruned formula or vice versa. A direct initializer, variable-step jump or shared result from another polynomial would require a new checked identity and cost model.

Concrete ordinary-rule acceptance still needs the coefficient/parameter bindings, exact integer arithmetic, final rounding and exhaustive unit-output coverage. The author checkers and this replay do not supply those future production witnesses. No source/kernel axiom check, build, analytic value or transform was run.

## Reproducible evidence

The independent script `audit/review_exact_residue_difference_20261111.py`, SHA256 `2FE0DA2C7A645D4435978A440A2A33C6050AA591EBA60F4E2FA9EA0852EA099C`, passed530996 checks. It checked209800 pruned live slots and28800 full-state slots, exact rounding, geometry, counts and widths. Receipt `audit/review_exact_residue_difference_20261111.json` has SHA256 `E186C9F72D6F03374CF49A0AC351A6FB2101DD2195388B5A00A322B75E7D76CC`. It hashes the final V2 author, four author script/receipt files and all seven cited source/report inputs. It imports no author evaluator or checker and uses integer/Fraction arithmetic only.

The decisive source interfaces are the scaled seed report sections4-6, joint quarter-mesh report sections2-3, m159 supplement, nearest-anchor source paragraph in the R138000 contraction report, shifted-jet seed report, and reconciled operation schedule sections1-2. Their full immutable hashes are retained in the independent receipt. The seventh pin is the occupancy author, used here only for the exact tie convention and reference-circuit interface. Its aggregate metadata acceptance remains separate.
