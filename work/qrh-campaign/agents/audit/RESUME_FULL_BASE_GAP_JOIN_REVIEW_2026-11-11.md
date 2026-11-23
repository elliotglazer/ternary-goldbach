# Independent full basegap join review

Research audit, 2026-11-11. Source pin `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build, canonical source edit or new spectral computation.

## Join verdict: PASS, conditional

The three reviewed interval joins cover every permitted source twist for the remaining reduced denominators1,2,3. Together with the reviewed finite-family result for every q>=4, they give complete **conditional paper coverage** of all150000 reduced denominators, all y>=10^25 and all u in [1200000/49,1200000]. The actual source upper endpoint is open; proving the stronger closed upper bound introduces no gap.

| Reduced q | Finite-family interval | Raw high-twist interval | Overlap width |
|---:|---|---|---:|
| 1 | [1200000/49,486477] | [190000,1200000] | 296477 |
| 2 | [1200000/49,972954] | [300000,1200000] | 672954 |
| 3 | [1200000/49,1068377] | [300000,1200000] | 768377 |

There is no endpoint, scale or denominator hole. For q2,3 the high branch requires q/phi(q)<=2, which holds exactly:2/phi(2)=2 and3/phi(3)=3/2. This is the reduced-denominator ratio in the already specialized source first-choice formula; the Type I ratio2q/phi(2q) is not identified with it. The latter distinction matters atq3.

The original modulus is m=q for odd m and m=2q for even m. Both branches use the same reduced denominator of2alpha and the same u=q|Delta|, with Delta=2delta, y=x/49. The finite branch expands characters at the original m; the raw branch uses Approx2 at reduced q. Their common conclusion is the actual pointwise bound |S_etaStar(alpha,49y)|/y<=ghatY(y,150000). There is no factor49 mismatch in the join. The strengthened parity-preserving gap extraction remains a formal adapter, as identified in both underlying reviews.

## Evidence and division of review

I read the frozen `RESUME_Q1_FINITE_REVIEW_2026-11-11.md` and `RESUME_SMALL_Q_HIGH_REVIEW_2026-11-11.md` and the producer's small-q note for exact domains, parity, hypotheses and all-scale claims. Those independent source reviews include their full scalar replays and the high-branch monotonicity arguments. The finite-family branch is the one I independently source-reviewed and replayed in `RESUME_BASE_GAP_FAMILY_REVIEW_2026-11-11.md`.

For this join I replayed the root script with its write redirected into `audit/base_gap_full_join-independent.json`. It exited0 and reproduced the entire producer JSON exactly; its log is beside it. All11 artifact/review pins checked by the script matched. I additionally performed an exact interval sweep for each exceptional denominator, directly counted the small totients, and checked that [4,150000] plus the three exceptional denominators equals [1,150000]. The accepted high certificates have128 scale cells forq1 and32 cells for the ratio-cap2 branch, with every exact gap positive. This is a join audit, not a new independent implementation of their analytic proofs.

| Frozen root artifact | SHA256 |
|---|---|
| base_gap_full_join_2026_11_11.py | 3941DFC7CB738FFCDF595D1646AB354875FAB782C35964C083B4A7B422599CDD |
| base_gap_full_join_2026_11_11.json | A7796EE4F010DF0B412818D353A733F285527888B7434CE3F355A7F02AFDBE59 |

The root JSON preserves the complete underlying artifact pins. Its prior-family review pin is unchanged, and its high-branch review pins bind the source/math verdicts being joined.

## Proof dependencies that must remain visible

The selected finite-family branch uses the **original uniform finite beta<=111/200 through Hp(c)** for every Gauss-active primitive character, genuine global seven-eighths QRH above the dynamic cutoff, reflection with conjugate characters, true multiplicities, actual etaU convolution/interpolation, its explicit formula and good-height limit, off-line Jensen counts, exact Gauss induction and remainder transport. The finite assertion is unproved. Neither the alternative weighted major-moment certificate nor the proposed smaller-height profile is automatically sufficient for this pointwise branch.

The high-twist branches retain the original first-choice Type I/II producer estimates, including prime moments, Mobius/Liouville and totient inputs. Their scalar certificates do not remove those source Fact PlattGRH dependencies. The shared envelope E and elementary repairs are proposed producer proofs; E and the remaining adapters still require proof. The unchanged ghat lower allowance and the consumer adapter into MinorTotal also need their Lean implementations.

The conjunction of these hypotheses yields a complete basegap research implication, not an unconditional basegap theorem. It does not by itself prove off-larger-arcs estimates, smoothed minor energy, the quotient sieve, final major/minor integration, or Goldbach. The prior78642 denominator count described a different, purely Type I/II conditional classification. Calling the new150000 count unconditional, or claiming zero remaining analytic obligations from zero remaining uncovered denominators, would be false.

No new root premise is accepted: the finite spectral assertion and every producer are obligations to discharge before the final theorem can retain only BinaryGoldbachInput. No new axiom, sorry, canonical import or sealed theorem was introduced here.

## Expanded package review

Pending the coordinator's next packaging freeze. The completed join audit above is independent of any still-changing chapter inventory. The earlier88-chapter checkpoint retains its own separately pinned verdict and is not retroactively treated as containing this result.
