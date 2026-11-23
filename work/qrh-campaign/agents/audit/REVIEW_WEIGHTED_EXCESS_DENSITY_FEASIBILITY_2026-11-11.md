# Independent review of the weighted-excess density comparison

2026-11-11. **PASS for the stated, bounded research conclusion.** The two inspected printed majorants do not establish `K<=6` by the proposed density integral. This is neither a lower bound on actual K nor an impossibility result for other estimates. No spectral evaluation, Lean build, theorem adoption, or change to the selected uniform `.555` strategy occurred.

## Frozen inputs and independent evidence

All SHA256 values were verified against the current bytes.

| Input | SHA256 |
|---|---|
| `major-constants/WEIGHTED_EXCESS_DENSITY_FEASIBILITY_2026-11-11.md` | `37505FDC4F83F99727FE636654E4803E3EB1EBF7C1B35FBF4E8C627097A72C90` |
| `major-constants/weighted_excess_density_feasibility_20261111.py` | `B9EC0EED1269680FFC50E2522204863EA09D68B11B277C191477123D5C65BACA` |
| Its JSON | `DA8CD2CE342D8E29C3CE5A64EACB68FFEDF5F327D3CC7823B248B9C6E582C43A` |
| Local Ramaré primary PDF | `FFDC82E6B6E635B04160FA6BAAC18AC6FD095CE4D80093DE94585237BC6EC7FB` |
| Its rendered p. 2 | `33270058EC0E0617E9E5F93EEE320AD758C59235F5321AEED7525D5D7C257101` |
| Independent `audit/review_weighted_excess_density_20261111.py` | `FB16541D5BCAFEFDC620548481D2DA8034FE7F85E2267E4415514E9FD488C139` |
| Independent JSON | `1BB8C3BFA4D4AC04E25E7150961C2ACDAFB6039BCC0D65B090EF35A7E6F581B5` |

The independent script exited 0. It imports no author code, uses decimal scale `10^50` and integer root brackets rather than the author's binary scale, verifies both sides of each necessary-count floor, and reproduces the exact comparison constants. It also checks the conductor-set size, height extrema, and the synthetic conductor's primality. The 3,695,775,113 primitive-label census remains a reused previously reviewed input, not a new census in this review. The author's optional Decimal diagnostics were inspected but not independently numerically replayed; they are unnecessary for this verdict.

## Exact family, layer cake, and endpoints

The accepted weighted-excess implication and review are unchanged: producer `5039FA2B…F67FF2`, review `D4F0619A…C0B948`. This task reviews a possible way of supplying its missing K bound.

For the 75,000 active conductors above 100,000, the minimum defining Hcert is indeed `10^8/c`. The odd-conductor old height is at least 1200; for multiples of four its displayed nonconstant term already exceeds `10^8/c`. Thus the exact inclusive height lies in `[1000/3,1000)`. No integer rounding is needed to enlarge or truncate the actual carrier.

Extend `k` by zero below b when discussing every zero. On `[b,a]`, it is the maximum of two increasing smooth functions vanishing at b, hence increasing, continuous and absolutely continuous. For each actual occurrence,

`integral_[b,a] 1_(s<beta) dk(s) = k(max(b,beta))`,

where global QRH supplies `beta<=a`. This explicitly includes `beta=a` and gives zero for `beta<=b`. Finite summation proves the stated identity. The report's phrase “for a zero ... k(beta)” is read with this zero extension; it introduces no missing charge at the left endpoint. Replacing strict by weak density comparisons affects finitely many integration points and no mass. The maximum's derivative is its active branch almost everywhere; at a positive-measure tie set the derivatives agree almost everywhere.

Every primitive label and every actual analytic multiplicity is retained, with positive, negative and zero ordinates. Character inversion/conjugation does not halve this count. The arithmetic Gauss weights used to derive the earlier consumer implication are not extra weights in K. Conversely, a density theorem with positive weights at least one can dominate this unweighted K carrier. The proof of the stronger two-kernel sufficient test correctly uses a termwise bound and finite summation, not an invalid inference about Stieltjes measures.

The independent exact floor table is:

| beta threshold | Necessary count ceiling |
|---|---:|
| 3/5 | 48,641,230 |
| 7/10 | 142,316 |
| 3/4 | 8,001 |
| 4/5 | 449 |
| 17/20 | 25 |
| 7/8 | 6 |

These are necessary marginal constraints, not jointly sufficient constraints. Both ends of each independent interval give the same floor of `6/k(beta)`.

## Primary-source transcription and applicability

Thorner–Zaman's count includes primitive labels, both ordinate signs and multiplicity, with strict beta cutoff and height Q. Theorem 1.2 requires `sigma>=39/40`, so does not apply here. Corollary 6.1 permits `sigma>=0`, `Q>=3` and gives `10^88*(10^421*Q^127)^(1-sigma)`. The unstarred count must be used; the starred version omits an exceptional real zero. The paper explicitly cites finite zero results in Lemmas 2.1–2.2. **Dependency qualification:** for our `sigma<39/40`, the unstarred corollary is obtained from the total-count branch in Lemma 2.8; this review does not assert that every proof of that coarse numerical bound inherently needs the complete Platt Dirichlet computation. A fresh dependency-minimized proof would still leave the present numerical comparison enormous. [Primary source, pp. 1–3 and 21](https://arxiv.org/pdf/2208.11123v4).

Ramaré Theorem 1.1 has `T>=2000`, `T>=Q>=10`, `sigma>=.52`, weights `q/phi(q)`, and includes both ordinate signs. The corrected leading term is **`20*(56*Q^5*T^3)^(1-sigma)`**, multiplied by the displayed logarithmic power; it is not `2056*(Q^5*T^3)^(1-sigma)`. I checked the rendered formula, not just extracted text. Its separate `N1` definition excluding real zeros is not the theorem's N. The p. 4 minimal-range reduction uses finite GRH information. Choosing global `Q=T=300000` respects the theorem's domain; `T=1000` would not. Since `q/phi(q)>=1`, the weighted count bounds the required unweighted subfamily. [Primary manuscript, pp. 1–4](https://ramare-olivier.github.io/Maths/DensityEstimate-34.pdf).

This is a theorem-transcription and applicability review, not an independent reconstruction of either published density proof or a Lean axiom-closure check.

## Numerical conclusion and synthetic scope

The independent exact checks give `k(a)>.99`, the TZ comparison above `.99*10^220`, and the Ramaré additive term above `3732480000000000`. Its integrated contribution alone exceeds `3695155200000000`. The pointwise minimum of the two selected global majorants still exceeds that latter integrated bound. These are lower bounds on **comparison expressions**, never on the actual density or K. No subtraction of cumulative upper bounds for conductor annuli was used.

The hypothetical unit-constant density calculation is explicitly diagnostic. It cannot establish an obstruction to a different conductor-resolved estimate, a sharper local estimate, or a direct certificate. No exhaustive literature claim is accepted or needed here.

The synthetic spectrum has eight right-side occurrences at beta=a and their eight left reflections, at signed heights 1 through 4, for the real primitive character of prime conductor 100003. The exact script verifies the elementary conductor conditions and `8*k(a)>7.92>6`. This demonstrates the insufficiency of the extracted aggregate inequalities and symmetries alone. It is not actual L-function data. In particular, it contradicts the published finite-RH conclusions used elsewhere in those papers; the final report now states this explicitly. Therefore it cannot show that all the papers' hypotheses and auxiliary conclusions together fail to imply the desired result.

## Remaining obligation

To use the unselected weighted alternative, one still needs an actual-family proof or complete certificate of the weighted integral at most 6, or another sufficient certificate that implies it. Every omitted conductor/height/real-part region needs a proved contribution bound. The unchanged small-conductor and principal conditions, global QRH provider, all consumer joins, and Lean verification remain separate. The final large theorem acquires no K premise: K would have to be discharged internally; the full Statement retains only its original BinaryGoldbachInput.

No blocking correction remains in the frozen density packet. The source-dependency qualification above prevents overreading its opening summary as an impossibility claim about replacing published finite computations.
