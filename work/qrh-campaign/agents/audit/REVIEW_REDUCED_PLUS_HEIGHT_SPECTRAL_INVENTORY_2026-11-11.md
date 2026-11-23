# Review of the reduced-plus-height spectral inventory

2026-11-11. PASS for the conditional integer/rational schedule inventory. No correction requested. This review verifies the new height-dependent counts under the previously reviewed fixed-order circuit conventions. It does not establish spectral values, sign success, a complete certificate, runtime or a Lean theorem.

Author `zero-sum/REDUCED_PLUS_HEIGHT_SPECTRAL_INVENTORY_2026-11-11.md`: SHA256 `35083351B055958DDB61F1E38BEE8D63566552029298EEB2AC879FD5BE25F96B`.

Author script `reduced_plus_height_inventory_20261111.py`: `FEDC889D2B043EAA1AEFA6CF4824107949DC46A372384BC9F451B9B05F33AF47`.

Author receipt: `E4876ACF3F57D800118D328B56261149BC66B3A15F2272BDD370D88ECD986791`.

I read the complete note and script, the pinned old circuit definitions, and the scaled/shifted seed interfaces. I recomputed all new conductor and grid arithmetic, all five category sums, every group and auxiliary scenario, shared seed slots and unchanged setup counts. No author inventory loop was executed. The independent script reuses only the already-reviewed pinned circuit-cost definitions, after inspecting and extracting their AST prefix. Those definitions perform integer metadata arithmetic and read pinned metadata; they do not call an evaluator or write a receipt. This is not a fresh proof of every prior FFT/pruning theorem. No analytic, transform, L-function, zero or prime-candidate value was evaluated, and no build or frozen-file edit occurred.

## Heights, conductors and output coverage

The large branch is exactly c>10000 with odd c<=132900 or 4 dividing c<=265800. Independent multiplicative conductor arithmetic matches all 125400 conductors, 4333246843 primitive labels and 7133015232 unit-residue inputs per common height. The exclusion of the 7499 smaller conductors and 18477108 labels is explicit; the principal RH-through-10^8 task is also excluded.

The primitive labels are the same full inverse-stable sets used before. Odd prime-power axes omit precisely the imprimitive frequencies; the power-of-two factor retains the separate sign axis where required. No inverse-channel halving or cyclic replacement of a noncyclic unit group is introduced. As with the earlier reduced-conductor domain, a production adapter omitting conductors 2 mod 4 must retain the proof that their primitive nonprincipal family is empty.

I independently computed the height using the equivalent integer formula

    H=200+max(260,ceil(u*3.1416*1063200/qt(c))),

then applied J=ceil(64H/5)+1. The author instead first ceilings the complete rational height; these agree because 200 and 260 are integers. This comparison does not combine the analytic-height and grid ceilings. At every conductor the last node lies in [H,H+1/16], and the maximum overshoot is exactly 1/16. The bound uses integer H: it would not follow with the same constant after dropping the first ceiling.

The old comparison grid is recomputed from the original rational endpoint without an artificial preliminary integer ceiling. All old main totals agree with the pinned old receipt. Every new main grid is a prefix of that conductor's old grid.

The new main totals are:

| Quantity | Exact count |
|---|---:|
| Conductor-height nodes | 1729026050 |
| Residue inputs | 65920064426356 |
| Primitive outputs | 40474902420727 |
| General complex products G | 1120925963188476 |
| Complex additions/subtractions A | 2319745161470097 |
| Quarter turns Q | 102708998603521 |
| Negations N | 22187990916 |
| Dyadic scales S | 98879283658304 |

These use the unchanged original axis order, selected radix-two/direct/CT/Bluestein branches, full inputs and primitive-output dependency pruning. The per-conductor circuit costs have no height argument. Only the number of repeated heights changes.

## Auxiliary scenarios and the analytic union

The extra-node counts 167, 320 and 640 add exactly those multiples of the one-height conductor, residue, label and five-category sums. All scenario totals, exact ratios and outward integer-per-million brackets match the saved receipt. No single category ratio is substituted for another or for full proof cost.

The corresponding spans from the last main node are 835/64, 25 and 50. If a later completeness theorem starts at integer H instead, the main-node overshoot must be included or independently resolved. Evaluation at a node above H does not itself extend the finite-RH theorem beyond H.

For +167 all per-character grids remain old prefixes. For +320, 643 conductors exceed their own old endpoint; for +640 the count is 24007. The note correctly distinguishes those facts from the global seed-domain containment. The larger scenarios cannot be described as subsets of all old per-character data.

At every large conductor I separately checked that the displayed candidate base-gap and star heights are at most Tplus. That verifies an integer inequality, not either analytic candidate. The plus source implication has its separate accepted review. Adoption of the full union still needs the base-gap/star implications and actual RH certificates. RH is stronger than the stated star strip condition, so a genuine shared RH certificate to Tplus can satisfy it; maximum height alone would not suffice after weakening the spectral property. No additional independent spectra should be charged when one genuinely shared certificate supplies all three requirements.

## Shared seeds and precision

The unique largest new main grid is at c=10004, with H=7980 and J=102145. Its prefixes include every globally requested main height. The auxiliary largest final heights are 511555/64, 8005 and 8030, respectively. Every one is inside the existing V=10000 seed band and below the old largest global index. This proves domain containment for the existing point-height seed formulas, not for arbitrary complex panels.

I independently assigned every global index to its first valid band, including endpoints in the lower band. The new main band counts are 6401, 6400, 12800, 38400 and 38144 for V=500,1000,2000,5000,10000. All additional nodes are in the last band. The existing D and N values remain 512/220, 1024/387, 2048/720, 4096/1720 and 8192/3387.

The two slot schedules are alternatives. Original P24 costs 24(D+1) slots per height. Shifted P20 with P27 source coefficients costs 27D+20: each of the D left endpoints needs 27 coefficients, while the final right endpoint needs only 20. Its exact pruned translation has sum_(k=1..26) min(20,k)=330 updates per midpoint, hence 330D per height. It would be incorrect to price this method with P24 source slots, or add both alternative slot tables together.

All five shared-prefix tables, including the old baseline, match independently. In particular:

| Schedule | P27 source slots | Shift updates | Height/argument pairs |
|---|---:|---:|---:|
| New main | 13658841620 | 166916428800 | 1351525157121 |
| New +640 | 13800412180 | 168646579200 | 1369288035201 |

The argument count per height is (N+1)D+1. The largest band is still needed, and the nested rational-argument union remains (3389-1)*8192+1=27754497. Initialization is therefore not reduced by the height ratio. P27's shifted-tail and scaled-coefficient error contracts remain separate mathematical inputs; the inventory does not claim old raw coefficient boxes contain the new scaled enclosures or that fewer bits suffice.

## Unchanged setup and remaining costs

I recomputed the unchanged axis dependency set and setup metadata: 12496 top lengths, 32942 active nodes, 6004 Blue kernels, 337702368 padded kernel entries, 140276846 chirp entries and maximum padded length 262144. The conservative full CT root-table count remains 1116142487. The kernel-forward counts remain G=2244782056 and A=5502647200, with the other categories also checked. There is no height-dependent deletion of these setup objects in this schedule.

Restricting a fixed prescribed-error schedule to fewer heights preserves its existing uniform bound. It does not demonstrate lower precision, cheaper seed initialization or measured speed. Interpolation, sign discovery and verification, Turing closure, difficult-value precision escalation, serialization and ordinary proof-system verification remain explicit costs outside these five transform categories. The report correctly makes no end-to-end timing or completeness claim.

## Reproduction and scope boundary

Independent script `audit/review_reduced_plus_inventory_20261111.py`: SHA256 `15E858DD59D55D68CD5AF4C6C687A7C70FFD609C18A0EF128081C9E5A3BB0931`.

Independent receipt: SHA256 `993A9E017DCF3F87A34BB9DCAA4F57BF044F82875B003814433FF9BA600366EB`.

The receipt records ten verified artifact hashes, all 125400 conductor checks, the exact main totals, auxiliary prefix failures and five shared seed-prefix checks. The ten pins include the author triple, old inventory script/receipt, plus-height source note, conditional star/base-gap source notes, and both seed-interface notes. Hash agreement with those analytic notes is not their mathematical acceptance.

The accepted conclusion here is the exact conditional inventory under the specified circuit and precision conventions. Actual finite spectral evidence and source-bound formal acceptance remain open. No final theorem premise or mathematical target is changed by this review.
