# Independent review of complex-cluster family completeness

2026-11-11. **PASS as a paper-level sufficient certificate interface.** No mathematical correction is required. The proposed cluster inputs remove ordinary sign counting's dependence on simple critical-line zeros, while retaining exact multiplicities, inverse-character bookkeeping, and the existing closed-count/Turing inequality. This is not an accepted finite family certificate or an unconditional producer-termination theorem.

No Lean/Lake build, actual L-function scan, canonical edit, producer edit, or frozen-package change was made. A small independent rational calculation checks only the stipulated multiset arithmetic; the analytic conclusions are reviewed from the proof, not inferred from that calculation.

## Pinned artifacts

Producer files are in `work/qrh-campaign/agents/integration/`.

| File | SHA256 |
| --- | --- |
| `FAMILY_COMPLEX_CLUSTER_COMPLETENESS_2026-11-11.md` | `D0E34538D735CBABD6C88E164463C4B04AFF56E62B2FCBC9904DD7A0E2923ED3` |
| `family_complex_cluster_fixtures_20261111.py` | `D200271D12F828507CA00EAA33C0AAEFD40EF5786204070C6503E802AF79EBCC` |
| `family_complex_cluster_fixtures_20261111.json` | `5ABF6AFE58F73E70146D6AA09BE9957D4D29FD430DE1655875C9B27E749BCF6F` |

All were read and hash-checked. Reviewer files beside this report are:

| File | SHA256 |
| --- | --- |
| `review_family_cluster_arithmetic_20261111.py` | `82166D5D62DA2A4EDAA2138EA98CB52C0092A69D024D72CF0121DF2FA3C93990` |
| `review_family_cluster_arithmetic_20261111.json` | `7BE57437590496BAF6EAFE64F1D922CA2005650ED7912952E690D07A5E1F0144` |

The reviewer script completed with exit0. It does not execute the producer or write any producer file.

## 1. Actual zero carrier and exact orders

The carrier is exactly the nontrivial zeros of the actual source `DirichletCharacter.LFunction chi`: f(rho)=0 and 0<Re(rho)<1. For a primitive character of conductor c>1, nonprincipality gives an entire nonzero function. Thus bounded regions have finitely many zeros, each with a positive finite analytic order. An order must not be replaced by1 or converted from infinity without proving finiteness.

Within the open critical strip, the Gamma and conductor factors relating this L-function to its entire completion are analytic and nonzero. They preserve analytic order. This is the correct carrier bridge to the completed-count theorem; no cancellation at a Gamma pole is being assumed on this domain.

The standard rectangle contract keeps its closed rectangle inside 0<Re(s)<1. Consequently its argument-principle count is exactly the nontrivial count asserted by the record. Raw-L contours extending into other real parts can count trivial zeros and need a separate bridge; the note explicitly forbids silently treating those counts as nontrivial.

The accepted polygon theorem can provide the claimed exact count only after the entire boundary panels, shared vertices, orientation, and zero-free side conditions are certified for this actual function. The proposed interface does not weaken those conditions to endpoint samples. A region containing multiple zeros or one multiple zero remains valid: winding counts their total order.

## 2. Main supports, overlaps, and saturation

The main rule requires that every zero counted in a support lies in the closed height range |Im rho|<=T and satisfies Re rho<=111/200. Geometric support containment is sufficient, but not necessary if an explicit localization theorem proves those two facts. This is a correct formulation for general region records.

Exact counts add only under zero-disjointness: no actual target-character zero may belong to two supports. Pairwise disjoint regions suffice. For open rectangle interiors, touching closures are harmless because the independently certified boundaries contain no zeros. Overlapping interiors need an actual no-double-count proof or a count of their union. A list of different record identifiers is not such a proof.

Under this condition, K is exactly the order count of the union, hence K<=C_chi(T). If the Turing upper bound gives C_chi(T)<K+1, integer-valuedness proves equality. Since every omitted zero would contribute a positive integer order, equality forces every target zero to belong to the union. Its real-part bound then follows. This is valid for arbitrary multiplicities and does not force RH or simplicity.

The extension mixing ordinary signs with exact clusters also works: a sign support supplies a lower bound1 rather than an exact count, but zero-disjointness still makes K a lower bound for the union. If K=C, the chain K<=count(union)<=C has equality throughout. A sign interval intersecting an already counted cluster cannot be added again. The note preserves this requirement.

## 3. Inverse characters and real-axis clusters

All counts are first interpreted as counts in one target character chi. A positive-height region for its inverse is transported by complex conjugation to a negative-height region for chi. The conjugation identity preserves real parts and analytic orders. The orientation reversal of a contour cannot be ignored when reusing a signed winding; transport of the already proved natural count avoids that trap.

After transport, the same joint zero-disjointness rule applies. Adding the two full-plane counts for chi and its inverse would double count the same target spectrum; the proposed rule does not do that.

A central region meeting Im(s)=0 counts **all** zeros it contains. It is not limited to zeros at s=1/2 or even to real zeros. Its order count is added once directly for chi, with positive and transported-negative regions arranged not to overlap it. Several disjoint central regions may cover possible off-central real zeros in the open critical strip. This fixes the limitation of a central-value-only sign record.

For a self-conjugate character, positive regions and their conjugates are disjoint because the heights are strictly positive and negative. Their counts are doubled. A central region remains counted once, even if it contains a symmetric pair of nonreal zeros. No special value of the root number or assumption about central nonvanishing is needed for this counting rule.

## 4. Auxiliary weights and endpoint conventions

For H=T+h, h>0, finite order-counting gives exactly

```
integral_T^H [C_chi(t)-C_chi(T)] dt
 = sum_(T<|Im rho|<=H) ord(rho)*(H-|Im rho|).
```

This follows by integrating each finite indicator over t. A zero at |Im rho|=H has weight0. A zero at |Im rho|=T already belongs to the closed base count and contributes no added weight. The strict lower condition in the auxiliary record is therefore essential.

For each zero-disjoint auxiliary support, every counted zero has T<|Im rho|<=v_j<=H. Comparing each summand with H-v_j yields W<=the integrated added count. Missing auxiliary zeros merely weaken W. The proof needs no restriction Re rho<=.555 in the auxiliary zone; imposing that restriction would reintroduce an unnecessary obstacle.

For standard positive rectangles, a lower edge at T is permitted only because the support is its open interior and the boundary is certified zero-free. A box straddling T cannot contribute its whole order without splitting or localization. Likewise a box reaching beyond H cannot contribute all its count from geometry alone. The proposed contract handles both points correctly.

Positive inverse-character auxiliary counts are transported exactly as main counts. Real-character reuse doubles the positive contribution; direct two-sided target-character supports need no such doubling. Main and auxiliary counted zeros are distinct automatically from their closed/strict height conditions.

## 5. Exact Turing join and finite arithmetic contract

Let A be the exact Gamma integral and I_S the integral of the two canonical S channels. The existing closed-count identity gives

```
h*C = A+I_S-L,
```

where L is the actual integrated added count. With Abar>=A, Bbar>=B, I_S<=2B, and W<=L,

```
C <= U=(Abar-W+2*Bbar)/h.
```

The sign of W is correct: it is subtracted. Combining U<K+1 with the main lower count proves the selected closed-height finite strip. Neither a separate nonzero top boundary nor the absence of real zeros is assumed in this abstract implication.

A minor implementation clarification should be retained: the analytic implication permits real T,H, but a literal *rational* comparison of U with K+1 needs rational certificate choices T,H (and hence rational h), or separately verified enclosures for all real quantities in the denominator and weights. Rational T>Hcert and rational H>T are available choices in the stated gap/existence argument. This is not a defect in the mathematical inequality, and it does not license rounding Hcert downward.

The canonical S and Gamma/count normalization remain required. In a **pure cluster** implementation, the numerical Hardy root phase epsilon and Fourier real-valued evaluator are no longer needed just to obtain K and W; direct analytic L-function contour values suffice. They remain useful if sign evidence is mixed in. Canonical Euler-log S, Gamma phase normalization in G, and the exact count/order theorem are different obligations and cannot be dropped with epsilon.

## 6. Boundary equality and conditional existence

An ordinary zero-free-boundary rectangle contained in Re<=b cannot include a zero exactly at Re=b in its interior. A similar issue occurs at a prescribed top boundary T. The note correctly requires exact boundary-location/order evidence, a justified boundary-count convention, or for height a separately checked larger T. Moving the real boundary to b+epsilon does not establish the original target.

The optional strict-margin existence argument is sound at its stated scope. Local finiteness and a strict real-part margin for the original closed target allow T to be chosen slightly higher, avoiding zero ordinates and retaining the margin. Since B(c,H)=O(log H), arbitrarily large H permit 4B/h<1/2, and one can choose a nonexceptional rational H. Finitely many disjoint small main regions then cover all main zeros inside the allowed strip, and finitely many auxiliary regions cover all auxiliary zeros regardless of their real parts or multiplicities.

Thin auxiliary height extents make L-W<h/4. The stated convergence capabilities make the combined enclosure error `(Abar-A)+2*(Bbar-B)<h/4`. More explicitly,

```
h*(U-C) = (Abar-A)+2*(Bbar-B)+(2B-I_S)+(L-W),
```

and `2B-I_S<4B`, so the three strict budgets yield U-C<1. With complete main clusters K=C, saturation follows. Including the Bbar error separately is necessary and is done correctly.

This is a conditional existence argument, not an assertion that those contour-certification capabilities, fair effective search, data, or strict margins have already been proved for the family. Multiple and off-line zeros no longer obstruct it structurally. Exact Re=b cases still do. A separate direct-evaluator convergence note is under review elsewhere and is not consumed as an accepted premise here.

## 7. Stipulated bookkeeping checks

The producer's tiny examples are explicitly finite point multisets, not zeros derived from analytic functions. I checked their region memberships and independently recomputed their arithmetic:

* Nonreal example: main counts4+2+10=16; the central10 includes nonreal points near the real axis. Auxiliary W=6*(110-105)+3*(110-104)=48, whereas L=4*(110-102)+2*(110-104)+3*(110-103)=65.
* Real example: main count2*4+6=14, with central6 counted once. Auxiliary W=2*4*(110-103)=56 and L=2*4*(110-102)=64.

The extra assertions about doubled full-plane or central counts demonstrate incorrect arithmetic; they are not a general parser or geometric-overlap rejection test. No winding or actual L-function conclusion is inferred from them.

## Final status

The new main-cluster and auxiliary-cluster interfaces are mathematically sound and preserve the exact selected weak strip without requiring simple critical-line zeros. They may be adopted as proposed internal certificate interfaces, subject to eventual exact declaration review and proof.

All region counts, analytic-order transports, finite unions, boundary semantics, actual enclosure proofs, Gamma bounds, saturation inequalities, and character coverage must be proved or certified internally. They cannot remain additional hypotheses of the large Goldbach root. The full root retains only the original BinaryGoldbachInput. No Lean implementation, approved frozen anchor, complete spectral family, or final Goldbach proof is supplied by this review.
