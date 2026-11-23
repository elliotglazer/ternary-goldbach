# Independent review of closed-slab family assembly

2026-11-11. Verdict: PASS as a paper proof of the stated finite-coverage and count-additivity implications. No mathematical correction is requested. This review does not certify a slab's numerical enclosures, a complete strip, or any character family. No Lean/Lake command, spectral scan, dependency edit, canonical declaration, or frozen-source mutation occurred.

## Pins and direct source checks

The reviewed note is `major-constants/FAMILY_STRIP_SLAB_ASSEMBLY_2026-11-11.md`, SHA256 `5064865E9CE249A896B6B083278938E0E77762B88DE4539E038E624AC011FF93`. The two accepted bridge inputs match their frozen hashes:

* `major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md`: `21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B`.
* `independent-feasibility/REVIEW_POLYGON_CROSSING_PROOF_2026-11-11.md`: `F75647007C294E13132B984A0F6241B516D5113D789AECA922B4DA265A5E73F0`.

I read both bridge documents and directly checked `Explicit/RectResidue.lean:360,391` and `Explicit/Landau.lean:25,31,40` in target `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Their file hashes are respectively `6B9C3236C2B4470AA37D3948DAB163573A1A7AFDDE8E963EF127F815EB0B88CF` and `6D2A7B97640A49ECBC61F7406006214DB798E9989D8F25740DF3E42600520656`. I also checked the actual `LFunction_eq_LSeries` and `differentiable_LFunction` declarations in the pinned Mathlib `DirichletContinuation.lean`. These are read-only source checks, not a build or transitive axiom audit.

The parent's pending `DIRECT_STRIP_EVALUATOR_CONVERGENCE_2026-11-11.md` is not an input to this verdict. No assertion about its proof or correctness is needed below.

## One packet and the intrinsic natural multiplicity count

The local conclusion follows from the accepted polygon bridge only when all its hypotheses are supplied: an exact once-counterclockwise source-side partition, strict whole-panel half-plane enclosures for the actual function, shared rational image vertices within the packet, and the exact half-open crossing calculation. Merely sampling endpoints or printing a zero crossing sum would not suffice.

`NoZerosOnSides` quantifies over all four closed sides, including corners. The source argument principle also requires an entire function, a nonzero center, and strict inclusion of the closed rectangle in an open half-radius ball. The proposed center at the bottom-left corner and radius 2*(dx+dy+1) satisfy these conditions: boundary nonvanishing supplies the center value, and distance is at most dx+dy<radius/2. No zero-free enclosing ball is required.

The finite divisor support in `zerosIn` is not itself a canonical global list. To compare packets, use the intrinsic analytic order of each actual zero. Entire analyticity and one nonzero value exclude infinite order everywhere by the identity theorem. Orders at zeros are then positive natural numbers. On each enclosing ball, the source divisor equals that order; its natural conversion is justified only after finiteness and nonnegativity. Thus two local carriers assign the same order to a common actual zero, even if their surrounding balls and other support entries differ.

For a bounded region E in the target rectangle, one may express this as the finite natural counting measure

    mu_f(E) = sum over actual zeros rho in E of ord_rho(f).

The sum is finite by compactness and isolated zeros, using the nonzero boundary point to exclude an identically zero f. This is the count that the source argument principle identifies with the local nonnegative winding integer. It is not a sum of arbitrary stored divisor entries. Local winding zero therefore excludes the open interior, and `NoZerosOnSides` supplies the rest of the closed tile. The reviewed note makes this necessary carrier conversion explicit.

## Closed coverage and seams

For a strict rational partition -T=y0<...<ym=T, every y in [-T,T] belongs to a closed interval [yj,yj+1]. The least upper partition-index argument in the note covers y=-T, y=T, and equality at every internal seam. The same argument in the real coordinate proves the Cartesian grid result. Consequently the union of the closed verified tiles is exactly the closed target rectangle.

No extra continuity or limiting argument is needed at a seam. A zero on that seam would violate the closed nonvanishing conclusion of an incident tile. This includes a real-axis seam and a zero whose height is exactly Hcert or T. The strict protocol Hcert<T is sufficient for the inclusive target |gamma|<=Hcert. Equality Hcert=T would also follow from closed nonvanishing mathematically, but the reviewed protocol deliberately requires the stricter inequality and does not silently weaken it.

The standard geometry checker is correctly required to reject missing indices, duplicate entries, reversed or degenerate rectangles, endpoint mismatches, and unannounced positive-area overlaps. The one-dimensional intersections of adjacent closed tiles are intentional, not overlap errors. For a separate cover-only mode, positive-area overlap is harmless for nonvanishing, provided every elementary tile of a common exact rational refinement is contained in a verified rectangle. Such overlapping rectangles cannot be summed as disjoint zero counts. The note keeps these modes distinct.

The nonvanishing target excludes beta=b as well as beta>b. It is therefore stronger than beta<=b. Failure to produce a closed nonvanishing certificate at beta=b need not refute the weaker desired strip. Also, geometric coverage through real part 2 alone cannot rule out roots beyond 2. The source critical-strip membership or Euler nonvanishing must be supplied to conclude a bound for all nontrivial zeros, as stated.

## Count additivity versus stored-edge cancellation

Under the exact grid and nonvanishing of every tile boundary, no actual zero lies on a grid seam. Each zero in the global open interior lies in exactly one local open interior, and every local interior is contained in the global interior. Finite additivity of the natural counting measure therefore gives

    mu_f(int R) = sum_tiles mu_f(int Q) = sum_tiles k_Q.

This proof includes arbitrary positive multiplicities. It fails without seam nonvanishing: a seam zero belongs to none of the adjacent open interiors. The note explicitly excludes that failure mode. Since every k_Q is nonnegative, a zero total cannot result from cancellation of positive and negative local counts.

The alternate integral proof is also valid. On each actual closed seam, f is nonzero, so f'/f is continuous there. The same function is integrated in opposite directions on the two incident tiles, and subdivision/additivity cancels the integrals. Entire f may have interior zeros; only seam continuity is needed for this cancellation, while the argument principle supplies the interior counts. Totalized division at a seam zero would not supply these hypotheses.

Neither argument requires adjacent packets to use identical rational approximations to the same actual function value. Independent local polygons can each prove their actual local count through the accepted connector identity. Their integers can then be added using the intrinsic counts or actual integrals.

Direct cancellation of stored polygon edges is a different contract. A common source mesh, a single rational image value per global vertex, and exactly reversed seam-edge lists make each edge (a,b) pair with (b,a). The exact half-open crossing rule satisfies C(b,a)=-C(a,b), including real-ray endpoints and zero-length image edges. These stronger data suffice for direct finite cancellation. Approximate agreement of unrelated image vertices does not suffice. Any new shared replacement vertex must satisfy every incident strict half-plane condition; a refinement cannot invent that proof from just one neighboring polygon.

## Exact labels, inverse reflection, and normalization

The analytic function is `chi.LFunction` for the exact primitive source character. A byte hash, a numerical label, or an inducing modulus alone does not prove equality of characters or continuations. The family manifest and function-key proof remain necessary. Mixing slabs for different characters cannot form a strip for one of them.

The correct identity is

    L(conj(s),chi_inverse) = conj(L(s,chi)).

It follows from absolutely convergent Dirichlet series on the right half-plane and continuation, including the zero values at nonunits. Conjugating the local power series preserves the exact order of each zero. Thus a positive-height slab for chi gives a negative-height slab for its inverse. It does not in general give a negative-height slab for chi. A real-character equality chi=chi_inverse must be proved before reusing the same positive data for both signs.

Reflecting a counterclockwise source boundary reverses its orientation. Conjugation of the image reverses its winding, and reordering the source boundary back to counterclockwise reverses the parameter order again. The resulting count is preserved. Transporting the already proved closed-nonvanishing proposition avoids these packet-order details, as the note recommends.

An analytic nonvanishing normalization factor preserves zeros and their orders on the tile, but its analyticity and nonvanishing there must be proved. Before adding actual logarithmic-derivative integrals, all packets must be transported to the same function. Different normalization factors can contribute different edge integrals even when the zeros agree. Pole-subtracted Hurwitz continuation at s=1 is another actual-function identity to prove, not a permission to use unrelated totalized values.

## Scope of the conductor-101 example and remaining work

The note treats the conductor-101 artifact as an in-progress example and assumes no successful result from it. Its stated slab is only [111/200,2]+i[7999/8,8001/8] for the fixed label chi1. Even after acceptance, it would contribute that slab for chi1 and its reflected slab for inverse label chi99. It would not cover an initial height interval, a neighboring absent seam, the negative band for chi1, all conductor-101 characters, or the selected height Hcert(101). The discussion does not overstate this scope.

Still required are actual complete per-character packet collections, sound analytic enclosure and interval-checker implementations, the local polygon/source argument-principle adapters, finite intrinsic-order carrier lemmas, exact geometry and label completeness proofs, and the final source-level strip conversion. The pending evaluator-convergence proposal is neither used nor approved by this review. Even a future conditional termination result for nonzero boundaries would not establish zero winding or full coverage by itself.

The assembly implications are sound on paper. No new full strip, family assertion, or Lean theorem is established by the present review.
