# Independent review: shared-strip coverage and exact boundary divisors

2026-11-11. **PASS as a paper certificate-acceptance theorem and source plan.** No mathematical correction is required. This verdict does not certify a single new spectral row, guarantee producer termination, or establish any new Lean theorem.

Reviewed author: `zero-sum/SHARED_STRIP_COVERAGE_ASSEMBLY_2026-11-11.md`, SHA256 `077F494EC96844D3422631DE26377D6DB152A1EF7058E274D567D9820E3DF6ED`. The complete frozen note was read. All 25 source/predecessor hashes in its tables were independently checked and match. Relevant source bodies, the prior family scope audit, spectral erratum, character-manifest plan, and earlier rectangle rules were inspected. No evaluator, spectral scan, Lean build, or source mutation occurred.

## 1. Target and scope are preserved

The height is the exact rational `min(Hp(c),10^8/c)`, not its floor, and the target includes both signs through the closed height. The active conductor set and all actual primitive labels remain required. The count 5,543,640,188 is not used as a substitute for the manifest's bijection, primitivity proof, or inverse-label identity. The older Hp-only target is correctly described as a sufficient larger domain.

For c>1, a primitive principal character would have conductor 1, contradicting primitivity. Thus the source nonprincipal L-function is entire. At c=1 the canonical function is zetaF with its removable value 1 at s=1. The source definition is an update, not the everywhere-totalized product `(s-1)*zeta(s)`. The earlier spectral erratum's logarithmic-derivative correction is retained.

The prior scope audit's warning about termination remains valid: a true non-strict bound beta<=.555 does not guarantee success of a boundary-nonzero test on beta=.555, or critical-line sign saturation. The new note does not turn a sufficient certificate rule into such a termination claim. Its historical qualification of the former extra narrow principal-strip task does not assert the shared finite spectral data or final psi theorem have been proved.

## 2. The boundary-divisor construction is mathematically sound

Let the proposed points z_j be distinct, with positive integer orders m_j and exact proofs `Re z_j=b`. The vanishing of derivatives of orders below m_j gives an analytic local factor `(s-z_j)^m_j` of the actual entire F. This is supported by the inspected `natCast_le_analyticOrderAt` and `natCast_le_analyticOrderAt_iff_iteratedDeriv_eq_zero` declarations in Mathlib's `Analysis/Analytic/Order.lean`.

For `P=product_j(s-z_j)^m_j`, write `P=(s-z_j)^m_j P_j` near z_j. Distinctness gives `P_j(z_j)!=0`. Dividing the local analytic factor of F by P_j therefore defines an analytic quotient at z_j. Away from the finite list, use F/P. These definitions agree on punctured neighborhoods and so give a globally entire Q satisfying F=P Q. The displayed value

    Q(z_j)=F^(m_j)(z_j)/(m_j! P_j(z_j))

has the correct factorial and remaining-factor normalization. It follows either from the local Taylor coefficient or differentiating F=P Q at the first possibly nonzero order. No exact-order hypothesis is needed before the quotient is built. If a later certificate proves Q(z_j)!=0, the order becomes exactly m_j. Under-recording a multiplicity leaves a zero of Q; over-recording would require a false derivative-vanishing proof.

This addresses the principal source-sensitive issue: `RectResidue.rectInt_logDeriv_mul:391` assumes global differentiability of the function being counted. The note does not apply it to a raw totalized quotient or to a function known only locally holomorphic. The finite gluing and its eventual Lean implementation remain explicit work.

The construction requires exact root names, locations, and vanishing proofs tied to the same F. An interval containing zero, a box meeting the vertical line, or an unverified algebraic label does not supply these facts. Near a listed root, numerical F/P is not a valid evaluator without a divided-difference or Taylor extension. The author records this additional evaluator requirement. The adapter creates no new boundary-zero evidence and makes no assertion that a producer can find such exact identities.

## 3. Local closed-rectangle conclusion

The packet's target may be Q or the fixed entire normalization `A*exp(alpha*s)*Q`, with A nonzero. This multiplier changes neither zeros nor orders. The note correctly excludes the nonholomorphic surrogate `exp(t_b*Im(s))*Q(s)` and retains the full complex phase of a holomorphic tilt.

For each of the four sides, the required enclosure is for every point of every panel. The actual image and both rational polygon vertices must lie in one strict half-plane excluding zero; vertices are shared exactly through the closed contour. This supplies boundary nonvanishing and the compatible homotopy to the rational polygon. Finite samples or successful endpoint values alone do not satisfy the packet.

The nonzero-center/ball conditions of the source rectangle theorem can indeed be met by choosing a boundary corner and radius `2*(width+height+1)`. Every point in the rectangle is at distance at most width+height from that corner, strictly less than the half-radius; the certified boundary gives the nonzero corner value. Taking the theorem's holomorphic weight to be 1 yields the sum of actual natural zero orders in the open interior. A zero integer winding forces that sum to vanish. Boundary nonvanishing then gives a closed-rectangle nonvanishing conclusion for Q.

Combining F=P Q with this conclusion says every F-zero in the closed rectangle is among the listed points and lies on Re=b. The order at any listed point in the rectangle is exactly the recorded order. No argument principle is applied directly to F across its permitted boundary zeros.

The optional alternative entire completion is also appropriately qualified. Its ratio to canonical F must be analytic and nonzero near the rectangle, and deflation must be performed on the actual entire alternative. The Gamma-factor formula valid in that neighborhood must not be substituted as a globally entire totalized formula.

## 4. Coverage, seams, and inverse characters

The global proof is by pointwise closed-set coverage. Any hypothetical forbidden zero has b<beta<1<2 and ordinate in the closed requested range, so it belongs to at least one accepted local rectangle. That packet forces its real part to equal b, a contradiction. The proof works at horizontal seams, outer heights, corners, and gamma=0 because these are part of the closed coverage. It does not add open-interior counts or assume that overlaps have disjoint zero sets.

Different local divisor lists, tilts, and polygons are harmless after each packet has established its conclusion about the canonical F. They cannot be cancelled as raw contour edges merely because their geometric sides coincide. The note makes that distinction. Its suggested rational grid coverage check includes faces/corners, or requires a full-dimensional closed-cell cover from which their coverage follows. Thus no lower-dimensional gap is silently ignored.

For c>1, conjugating the absolutely convergent Dirichlet series and using `MulChar.star_apply'` proves the inverse-character identity on Re(s)>1. Analytic continuation applies to the holomorphic function obtained by conjugating both argument and value, yielding the stated identity everywhere. The same local power-series argument preserves zero orders. The inverse label has the same conductor and height.

Therefore positive closed coverage for every label can cover negative ordinates by transporting the inverse label's result. A nonreal character's own positive row is insufficient. A protocol keeping only one inverse-orbit representative must give both signs for that representative. The real axis is retained; reflecting polygons directly requires the orientation adjustments stated by the author.

The source primitive functional equation has exactly the inverse-character channel and the nonzero factor `c^(s-1/2)*rootNumber(chi)`. In the strict critical strip the Gamma factors are locally analytic and nonzero. It consequently transfers a zero to 1-rho of the inverse character with the same order. Applying the upper bound at its unchanged absolute ordinate gives beta>=.445. Conductor one uses the source xi identities and the nonzero local xi/zetaF factor instead. Neither transfer assumes simplicity or a two-element orbit at a fixed point.

## 5. Consumer transport and remaining obligations

The source's possible nonprincipal zero at the complex point 0 is kept separate from real nontrivial zeros. It is not assigned the lower bound beta>=.445. A real nontrivial zero has beta in (0,1) and is included by the closed height coverage.

Choosing an auxiliary carrier height U>H puts all inclusive low zeros strictly inside the source rectangle and its inner disk. Equality of their divisor weights with analytic orders makes the result independent of the carrier ball. A smaller finite approximation is treated as a subset, not as the complete low carrier. The high complement uses the strict inequality |gamma|>H, so zeros at the cutoff are neither omitted nor assigned to an unproved range.

The primitive-to-imprimitive passage also remains separate. It needs the actual source level-change identity, conductor indexing, and the principal convention. The finite Euler factors are nonzero for Re(s)>0, but that fact is not a license to replace the primitive conductor height by the ambient modulus height or omit a character with small Gauss weight.

This review accepts the analytic boundary-divisor rule and finite coverage implication. It does not accept a full-family record, exact boundary-zero data, interval-library correctness as a Lean fact, or a producer termination guarantee. The manifest, individual packets and any exact identities must be supplied and formally checked as internal obligations, alongside the other original Goldbach dependencies. No new premise is authorized at the final theorem.
