# Assemble shared finite-strip certificates, including allowed boundary zeros

2026-11-11. Paper proof only. No new zero data, numerical run, Lean declaration, or frozen-file change. The new step in this note is an optional exact boundary-divisor adapter. Earlier notes already prove ordinary closed-slab coverage. They leave a genuine distinction: the selected conclusion permits zeros on Re(s)=111/200, whereas a zero-free contour on that line cannot pass when such a zero occurs. The adapter below resolves the logical acceptance problem, but does not supply the exact boundary-zero identities or guarantee that a producer will find them.

## 1. Current target and earlier results

Set b=111/200. The active conductors are odd c<=150000 and c divisible by 4 with c<=300000, including c=1. The reviewed manifest represents every actual primitive complex Dirichlet character exactly once, with 5,543,640,188 labels. Counting this many rows alone is not a proof of representation; the manifest's unit-group/CRT bijection and conductor proof are required.

Use the exact rational height

\[
 \widetilde c=\begin{cases}2c&c\text{ odd},\\c&c\text{ even},\end{cases}
 \quad D_c=1200000/\widetilde c,\quad
 H_p(c)=\left\lceil200+\max(1000,(704/7)D_c)\right\rceil,
 \quad H(c)=\min(H_p(c),10^8/c).
\]

In particular H(1)=60343058. The target quantifies over every nontrivial zero with **inclusive** |Im rho|<=H(c) and concludes Re rho<=b. Neither a decimal approximation nor floor(H(c)) may replace this height. A certificate through a larger exact rational height is sufficient. The old Hp-only strategy is a stronger optional coverage range, not the current target.

For c>1 the canonical function is the actual source continuation F_chi(s)=chi.LFunction(s). Primitivity and c>1 imply chi!=1, so F_chi is entire. For c=1 the canonical function is the source entire zetaF, equal to (s-1)zeta(s) away from 1 and with value 1 at 1. Its nontrivial zeros and their orders agree with zeta in the open critical strip. Raw zeta is not an entire substitute. In particular the conductor-one logarithmic derivative includes the correction -1/(s-1) in -zetaF'/zetaF.

The accepted polygon proof turns whole-boundary half-planes plus exact winding zero into nonvanishing of an entire function on a **closed** rectangle. The existing slab and block-local inverse notes then combine closed rectangles by finite coverage, without summing counts over overlaps. The family-method audit correctly warns that ordinary critical-line sign saturation is a stronger sufficient certificate and has no termination theorem from the weak strip assertion alone.

The audit's former additional narrow principal-strip requirement is historical. The new damped-symmetry application uses the same full shared H(1), together with the separately accepted RH/count/moment head through 1500. This note proves only shared-strip coverage; it neither replaces that head evidence nor asserts the final numerical psi bound.

## 2. The precise remaining boundary issue

A rectangle [b,2]+i[-T,T], T>=H(c), with boundary nonvanishing and winding zero excludes every forbidden zero. It also excludes zeros at Re=b. Failure at such an allowed boundary zero is not evidence against the target. Moving the left edge to b+epsilon leaves an unproved sliver, and finitely many positive epsilons do not remove it. Moving left and retaining an unmodified zero-winding test counts the allowed zero and cannot pass.

There is a similar distinction between a closed geometric conclusion and a count of open interiors. Zero-free **closed** local rectangles cover internal seams and the real axis. Merely summing zero counts of open interiors can miss a seam zero. At the outer height H(c), an endpoint sample is insufficient; the whole horizontal segment must be covered, or the verified domain must extend beyond H(c).

The proposed adapter permits a finite list of exact allowed boundary zeros on each complete rectangle. It divides them out analytically, applies the already accepted entire-function polygon theorem to the quotient, and concludes that these are the only zeros in that closed rectangle. Independent rectangles can then be combined by coverage even when they use different lists or normalizations.

## 3. Entire deflation at a finite exact divisor

Let F be the canonical entire function for one exact character. Fix a finite set of distinct complex points z_j and positive integers m_j. Each point must have a proved exact identity Re z_j=b. For use in a local packet the points can be restricted to its closed rectangle. Supply exact vanishing identities

\[
 F^{(k)}(z_j)=0\qquad(0\le k<m_j).
\]

A ball containing zero is not such an identity. An enclosure straddling Re=b is not an equality proof. The points need not be rational, but each exact name, its location proof, and its vanishing proof must be bound to the same actual F. Refined numerical guesses, a proposed algebraic minimal polynomial, or a label saying 'boundary zero' are not sufficient by themselves.

Put P(s)=product_j(s-z_j)^{m_j}. There exists an **entire** Q with F=P Q. Here is a direct construction, not an application of an entire theorem to a raw totalized quotient.

At z_j the vanishing derivatives and analytic Taylor expansion give F(s)=(s-z_j)^{m_j}h_j(s) on a neighborhood, with h_j analytic. Write P(s)=(s-z_j)^{m_j}P_j(s), where P_j(z_j)!=0 by distinctness. After shrinking that neighborhood, h_j/P_j is analytic. Away from all z_j use the ordinary quotient F/P. These definitions agree on punctured neighborhoods, so they give a single function Q analytic at every complex point. Its value at z_j is

\[
 Q(z_j)=\frac{F^{(m_j)}(z_j)}{m_j!P_j(z_j)}.
\]

The identity F=P Q holds everywhere, including each z_j. Thus Q is globally entire, even though its computational representation away from the list is a quotient. The source `natCast_le_analyticOrderAt` and its iterated-derivative characterization provide the local factorization; translation moves their convenient Taylor-at-zero statements to z_j. A new finite gluing argument is still needed in Lean, but no new analytic assertion is being assumed.

It is enough to prove the order is **at least** m_j before deflation. If a later zero-free-quotient certificate succeeds on a rectangle containing z_j, Q(z_j)!=0 forces the order to be exactly m_j. Under-recording an actual multiplicity leaves a quotient zero and makes that local certificate fail. Over-recording requires a false vanishing identity and must be rejected before contour checking. The empty list gives P=1 and Q=F, recovering ordinary zero-free packets.

For a producer, quotient evaluation near z_j needs a proved local Taylor/divided-difference enclosure, or another representation with a verified identity. Numerically evaluating F/P across P=0 is not a valid enclosure. This note supplies the analytic extension, not that new numerical evaluator or any boundary list.

## 4. One local packet and its actual conclusion

A local packet names one canonical character/function, a nondegenerate closed rational rectangle R, one finite exact divisor as above, and one fixed analytic normalization for its entire quotient. It can simply use Q. It can also use G(s)=A exp(alpha s) Q(s) for specified complex constants A!=0 and alpha. This includes a fixed tilt alpha=-i t_b. G is entire and has the same zeros and orders as Q. The phase of exp(-i t_b s), including its real-part-dependent phase, belongs in the actual evaluated function; exp(t_b Im s)Q(s) alone is not a holomorphic substitute.

The packet partitions all four sides once counterclockwise, with exactly shared source vertices and exactly shared rational image vertices through closure. For every whole source panel, its proved analytic enclosure and both adjacent image vertices lie in the same strict coordinate half-plane excluding zero. All approximation and arithmetic errors must be included. The accepted half-open ray-crossing rule computes the integer winding of the rational polygon. Require this winding to be exactly zero.

The polygon proof identifies the actual integral of G'/G with that integer. The source rectangle theorem applies because G is **globally** differentiable. Its nonzero-center and ball-containment hypotheses can be supplied from a boundary corner: if the rectangle has width w and height h, choose radius 2(w+h+1) about that corner. The full rectangle lies strictly in the half-radius ball. Boundary nonvanishing gives the nonzero corner value.

The source counts the natural local orders of all interior zeros. Since G is entire and not identically zero, these are positive at every zero. A zero integer count therefore excludes every interior zero. The half-plane witnesses already exclude boundary zeros, so G and Q are nonzero on closed R. Consequently **every zero of the actual F in closed R is one of the listed points z_j, lies on Re=b, and has its exact recorded multiplicity**.

This conclusion is about F, not just its quotient. F is allowed to vanish on a side or corner at a listed boundary point. No argument principle is applied directly to F on that contour in this case.

A useful equivalent normalization route permits an entire alternative F_tilde whose ratio to F is proved analytic and nonzero on a neighborhood of R. For example, the actual nonprincipal entire completion, with its conductor factor, is such an alternative on Re>=b because the Gamma factor is analytic and nonzero there. One then deflates the **entire F_tilde** and certifies its entire quotient, before transporting zeros and orders back to F. One must not apply `rectInt_logDeriv_mul` to a function known only locally holomorphic. Nor may a totalized Gamma-times-L formula at a Gamma pole replace the source entire completion. The local ratio theorem and exact normalization are additional checked obligations for this alternative.

## 5. Complete paper acceptance statement and proof

A finite certificate for the shared strip is accepted only when its arithmetic manifest has been proved to enumerate every active primitive source character with its exact H(c), and for every such character it supplies a finite set of accepted local packets from Section 4 whose **closed** rectangles cover

\[
                 [b,2]+i[-H(c),H(c)].
\]

Coverage is an exact rational set-inclusion check, not overlap of approximate endpoints. One sufficient implementation refines all rational rectangle coordinates and target endpoints to a common grid and verifies that each target cell is contained in at least one accepted rectangle; closed faces, degenerate boundary cells, and corners must also be covered, or follow from a checked full-dimensional closed-cell cover. A simpler stacked partition uses all heights from -T to T, T>=H(c), and full real width [b,2]. Different valid packets can overlap. Their counts are not added.

The resulting conclusion is: for every actual active primitive character, every nontrivial zero through inclusive height H(c) has real part at most b.

To prove it, suppose such a zero had beta>b. Source nontrivial-strip membership gives beta<1<2. Exact coverage selects a local closed rectangle containing that very zero, including when its ordinate equals a seam or +/-H(c). Section 4 says any actual zero there lies on Re=b, a contradiction. This argument does not divide multiplicities or require zeros to be simple. It also covers gamma=0. It does not require the boundary divisor lists of overlapping packets to be disjoint or identical: each packet has already proved a statement about the same actual function. If two accepted packets both list the same point, their recorded orders necessarily agree by their local conclusions, but no duplicate count is summed.

With empty divisors everywhere, the acceptance statement reduces to the earlier closed zero-free cover and gives the stronger exclusion of Re=b as well. If exact boundary-zero evidence is unavailable, the empty-divisor route remains the required ordinary packet type; an unresolved boundary box must not be silently accepted. The optional adapter gives no claim that actual zeros on b exist, can be recognized effectively, or have finite exact descriptions a producer can discover.

## 6. Signed heights, inverse labels and lower real-part bound

The manifest's inverse label is coordinate negation in the unit-group character coordinates. It has the same actual conductor, primitivity and H(c). The identity

\[
 F_{\chi^{-1}}(\overline s)=\overline{F_\chi(s)}
\]

for c>1 follows on Re(s)>1 by conjugating the absolutely convergent Dirichlet series, using `MulChar.star_apply'`, and then everywhere by analytic continuation of the entire functions. The analogous identity holds for zetaF by its zeta conjugation identity and removable value at 1. Conjugating a local power series preserves its first nonzero degree, so orders are preserved.

Thus it is enough to give accepted **closed positive-height** coverage [b,2]+i[0,H(c)] for every primitive label, and then transport the result for chi inverse to the negative half for chi. For a nonreal character, its own positive row alone does not supply its negative row. A one-representative-per-inverse-orbit protocol must instead include both signs for that representative before transporting the whole result to its partner. Real characters require an exact identity chi=chi inverse, not an approximately real table.

The point at height zero is included in the positive and reflected closed domains. No doubling rule discards a possible real zero. Reflecting a packet also conjugates its exact boundary divisor. The simplest use transports the already proved local statement about F. If one instead replays the reflected polygon, both source orientation and image conjugation must be handled to restore counterclockwise traversal.

The shared upper bound gives the required lower bound as well. In 0<Re(s)<1, the actual source completed-L factor differs from L by an analytic nonzero Gamma factor. The primitive functional equation relates its value at 1-s to the inverse-character value at s with factor c^(s-1/2)rootNumber(chi), which is analytic and nonzero; the source norm theorem gives |rootNumber|=1. It therefore sends a zero rho of chi to 1-rho of chi inverse with the same order. Applying the certified upper bound to that partner, whose ordinate is -Im rho and whose height is the same H(c), gives 1-beta<=b, hence beta>=1-b=89/200.

Equivalently, combine functional equation and conjugation to reflect inside the same character by rho->1-conj rho. This preserves ordinate and order. Fixed points at beta=1/2 are allowed; neither construction requires two distinct zeros or division by two. For c=1 use the source entire xi symmetries and its nonzero local factor relating xi to zetaF in the strict strip, rather than the nonprincipal Gamma formulas at a pole.

Different tilts, quotient lists and image polygons on different local rectangles are harmless after each has yielded its statement about the canonical F. They cannot be cancelled as raw polygon edges. Direct cancellation requires the same actual integrand and identical reversed edge data, a stricter protocol not needed here.

## 7. Transport into the actual finite zero sums

The source nonprincipal `zerosRect_cases` classifies a rectangle zero as either the point 0 or a zero in 0<Re(s)<1. The point 0 is a possible trivial zero and stays in the separately bounded zero-at-zero term. This shared-strip argument does not assert beta>=89/200 for that point. A real nontrivial zero is different: it has gamma=0 but beta in (0,1), and is covered by Sections 5 and 6.

For a finite consumer carrier choose an auxiliary containing height U greater than the finite cutoff H(c). Any nontrivial zero with inclusive |gamma|<=H(c) then lies strictly inside the source rectangle at U; its distance from 2 is less than 2+H(c)<U+3=RT(U)/2. The divisor weight `(divB F 2 (RT U) rho).toNat` equals its finite analytic order. The same equality in any other containing source ball follows from `divB_eq_of_mem`; changing a containing rectangle cannot change the multiplicity. At conductor 1 the source `zerosRectD_zetaF_strip` has already removed the point-0 alternative, and `analyticOrderAt_xiF_eq` supplies the xi/zetaF order transport used for symmetry.

Therefore every nontrivial summand of each finite low-zero sum through the exact H(c), with its actual source weight, satisfies 89/200<=beta<=111/200. Zeros exactly at the finite cutoff remain in this low part; the complementary high part uses the strict inequality |gamma|>H(c). A source finite approximation at some smaller height is handled as a subset, not by assuming it contains the entire closed cutoff. No count estimate, zero spacing, or numerical simplicity test is needed for this transport.

An imprimitive ambient modulus must first be reduced to its actual primitive source character as required by the existing explicit-formula/character-transfer argument. This note certifies the primitive label at its conductor height. It does not replace H(c) by an ambient-modulus height, omit labels with small Gauss weights, or identify an imprimitive Euler-factor zero with a primitive zero. In the strict right half-plane the finite Euler factors 1-chi(p)p^(-s) are nonzero since their subtracted term has modulus at most p^(-Re(s))<1; any use of this order-preserving local factor still needs the exact source level-change identity and its separate principal convention.

## 8. What has and has not been resolved

This adds a complete paper acceptance route for the weak closed real-part bound in the presence of *proved exact* boundary divisors. The original zero-free route is still sufficient and usually simpler. Both routes cover rational nonintegral heights, all seams, real zeros, all inverse labels and actual multiplicities without adding counts on overlaps. No new premise belongs in the intended final Goldbach theorem: the finite certificate data, equality proofs and analytic checker are internal obligations.

No full-family certificate is produced. The true weak inequality alone does not guarantee that a zero-free-boundary search terminates; exact boundary zeros can obstruct it. Nor does it guarantee that a machine will discover the exact vanishing/location identities required by deflation. Sign saturation remains a valid stronger acceptance route, not an assumed consequence of the weak strip. Numerical enclosures containing zero supply neither boundary equality nor multiplicity. These limits survive the removal of the extra principal narrow-strip requirement.

The next implementation boundary is concrete: add a checked local consequence 'all zeros in this closed rectangle belong to this exact allowed divisor' beside ordinary closed nonvanishing, and let the finite-coverage layer consume either consequence. Do not accept an unresolved interval as a divisor record, and do not extend a local certificate's height or character scope by inference from nearby successful packets.

## 9. Source and predecessor pins

Target source revision: `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Mathlib revision: `56a005855ea17e0b0958f73ec801ae140b0a1679`. These are source references, not assertions that the new composition is compiled.

| File and relevant declarations | SHA256 |
|---|---|
| `TernaryGoldbach/Explicit/RectResidue.lean`: `NoZerosOnSides`360, `rectInt_logDeriv_mul`391 | `6B9C3236C2B4470AA37D3948DAB163573A1A7AFDDE8E963EF127F815EB0B88CF` |
| `TernaryGoldbach/Explicit/Landau.lean`: `divB`25, `zerosIn`31, analytic factorization | `6D2A7B97640A49ECBC61F7406006214DB798E9989D8F25740DF3E42600520656` |
| `TernaryGoldbach/Explicit/ExplicitFormula.lean`: `RT`295, `zerosRect`298, `multRect`302, `divB_eq_of_mem`384 | `8CDDDBE6934871CA37260E435BE639A49AC33F4A8D92CBB2E33AB9D330869C35` |
| `TernaryGoldbach/Explicit/ZeroSums.lean`: `zerosRect_cases`159 | `3E5CD828CC6ADD2AF6D17F03F97E65F15720AEAF907826847EF191DEA8BCB72D` |
| `TernaryGoldbach/Explicit/ZetaGrowth.lean`: zetaF17, removable value/entireness | `ED2158522FECDF70720AF464B28DE6E101666A3ED6AB7568729A5A8EA591E9E4` |
| `TernaryGoldbach/Explicit/ZetaZeroSums.lean`: strict-strip carrier39 | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| `TernaryGoldbach/Explicit/WeilBridge.lean`: `analyticOrderAt_xiF_eq`38 | `285F825F4916B8D8F40256090F56E773140AB2FC2C48E3F057F68A838E17C73E` |
| `TernaryGoldbach/Explicit/Xi.lean`: xi reflection24 | `988EDFBCA182F1A7618C88A6EA9B253BFEFEBFA3DA86C3CDC74F5DAC19523D1F` |
| `TernaryGoldbach/Explicit/XiPartial.lean`: xi conjugation669 | `8F47E96329BF7F1CC69F82C3AB5A422087F692BECB74EF70A7908BC323623770` |
| `TernaryGoldbach/Explicit/LGrowthLeft.lean`: `norm_rootNumber`221 and explicit completion/Gamma adapter | `59B0B227CC2D9472C6389231E8CC3998698F1F3E59139A8D110F32FF64F2F3D4` |
| `Mathlib/Analysis/Analytic/Order.lean`: local order factor167, derivative characterization348, Taylor factor393 | `2426AEF2574C3DF5758D40D81DD33A6A62E07235F2B7B3F980512D4E80FDF46C` |
| `Mathlib/NumberTheory/LSeries/DirichletContinuation.lean`: nonprincipal entire97, level-change148, completion249/258, primitive functional equation283 | `ECF79F2A64EF2E7215729EBB2E7D5ADAA03468B18BBDA0040680AA925D4673F1` |
| `Mathlib/NumberTheory/MulChar/Lemmas.lean`: conjugate/inverse73/79 | `8B72DD4496B40E0E4F5B9ED09E47FCC1777B597960F70FF14B6C43E8B5E0FF81` |

Predecessor paths below are relative to `work/qrh-campaign/agents/`. Their earlier selected-height or principal-strip prose is historical where explicitly superseded in Sections 1 and 8; their mathematical certificate rules are reused unchanged.

| Artifact | SHA256 |
|---|---|
| `zero-sum/RESUME_SPECTRAL_CERTIFICATE_STRATEGY_2026-11-11.md` | `9EADB2E516E16C33AB0B0B618C771723712716ABA38B54F4965A37BF158A46CB` |
| `zero-sum/RESUME_SPECTRAL_CERTIFICATE_STRATEGY_ERRATUM_2026-11-11.md` | `647989F9B605B41080066ABF01DF388E0EE6D893AA0D769E1501C815A0687C1F` |
| `moebius/SPECTRAL_CERTIFICATE_STRATEGY_REVIEW_2026-11-11.md` | `2E39BDF6741A252F6A9F6DE8F9812AFFB5611D431AE424543536B4A48D0922CE` |
| `audit/FAMILY_ROUTE_SCOPE_AUDIT_2026-11-11.md` | `BBE918AF20B0FB20E82A3BEA5EDB9F32EBA27B808D46EA0A9073091CCADA150A` |
| `zero-sum/FAMILY_CERTIFICATION_TERMINATION_LIMITS_2026-11-11.md` | `8E98E114689E3468F16088D82EF7568967A5015431A34C072CD101873CBF31FC` |
| `major-constants/FAMILY_STRIP_SLAB_ASSEMBLY_2026-11-11.md` | `5064865E9CE249A896B6B083278938E0E77762B88DE4539E038E624AC011FF93` |
| `major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md` | `21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B` |
| `independent-feasibility/REVIEW_POLYGON_CROSSING_PROOF_2026-11-11.md` | `F75647007C294E13132B984A0F6241B516D5113D789AECA922B4DA265A5E73F0` |
| `zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md` | `53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54` |
| `integration/REVIEW_FAMILY_CHARACTER_MANIFEST_2026-11-11.md` | `EEE3BAE662500804EAEC0268A8612D0E01ED1C2FAF5D0208D442A97739794664` |
| `zero-sum/PSI_DAMPED_SYMMETRY_SOURCE_JOIN_2026-11-11.md` | `7574552D55981DCEC5CF5A419D6CEEB6FC7A264FE4A81CBAA8D0C3880F6DAFBE` |
| `moebius/REVIEW_PSI_DAMPED_SYMMETRY_SOURCE_JOIN_2026-11-11.md` | `8337D4EF50E27F37C20C16C59E04F3664886B21DBCE13CCFDCCC924B3F6C8D20` |
