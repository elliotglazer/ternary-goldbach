# Cost of extending the large-conductor height ranges

The additional 640 sampled heights cost an estimated **36,836 core-hours** on the large-conductor path. The priced work across the two conductor families then totals **702,374–702,903 core-hours**. At the historical comparison point of 400,000 core-hours, the remaining allowance for a twofold ratio is 97,097–97,626 core-hours. The narrow range comes from two implementation scenarios. The uncertainty in the total verification cost is substantially larger.

| Extra height indices per conductor | Additional large-conductor cost in core-hours | Partial campaign cost in core-hours |
| ---: | ---: | ---: |
| 0 | 0 | 665,293–665,823 |
| 167 | 9,370 | 674,727–675,256 |
| 320 | 18,117 | 683,533–684,062 |
| 640 | 36,836 | 702,374–702,903 |

For 640 indices, the long transforms add 16,779 core-hours, the short transforms add 1,161, the source arithmetic adds 13,028, preparing its inputs adds 5,790, and generating and checking the coefficient tables adds 78. The 640 indices span 50 units of imaginary height. Most of the additional work falls inside the original height bands because the terminal heights depend on the conductor.

[price_axes.py](price_axes.py) reweights the original samples by conductor and transform shape. It counts the rounded short-axis packets for each band. [price_source.py](price_source.py) recomputes the counts of live entries, padding, calls, and shared loads for the original four-by-four schedule. Both use timings from the original stock HOL4 runs. [axes.json](axes.json) and [guard.json](guard.json) contain the results and input hashes. The partial campaign total includes the existing four-channel estimate for sparse sign and interpolation data. Remaining costs include the principal character, proof of the input seeds, the small-conductor upstream extension, and the cost of repairing difficult cases across the full family.

The extended final band ends at index 84,880. With grid size 16,384, the rational Taylor and rounding estimate uses less than 0.323 of the allocated residue error there. The existing grouped coefficient remainder uses less than 0.444 of its error allocation with seed degree 48. The first bound applies to the stated coefficient-input accuracies. Both calculations are distinct from proving that every table satisfies those accuracies. [source_bounds.py](source_bounds.py) and [bounds.json](bounds.json) give the exact-rational calculation and the endpoint checks. The analytic ingredients include the derivative of the Hurwitz zeta function in its second argument and its Euler summation formula. [NIST DLMF derivative](https://dlmf.nist.gov/25.11.E17), [NIST DLMF summation formula](https://dlmf.nist.gov/25.11.E5)
## Alternative grid transitions

[adaptive.py](adaptive.py) tests the same five grids and the existing seed degrees against the rational error allowances at later height transitions. The resulting five starting indices are 0, 7,385, 15,137, 25,857 and 64,985. They cover the same residue evaluations through index 84,880.

The number of complex coefficient seeds falls from 2,490,699,328 to 2,449,295,424. At the original per-grid HOL4 rates the source subtotal falls from 247,901 to 236,975 core-hours. That would save 10,926 core-hours and lower the partial campaign estimate to 691,448–691,977. [Exact counts and cost calculation](adaptive.json)

Two matched stock HOL4 replays used identical conductor residues and eight consecutive heights on each grid. At height index 7,041, the coarser grid took 0.495 CPU-seconds for 32,336 outputs and the finer grid took 0.546 seconds. Subtracting the empty-call controls gave 0.469 and 0.466 seconds respectively. At index 60,001, the two grids took 0.0268 and 0.0687 seconds for 328 outputs. Only milliseconds remained in either case after subtracting the empty controls at that height. Each comparison covered one coarse cell and the intersecting pieces of three fine cells. The end cells were clipped, so the test gives the central arithmetic and call overhead for this geometry. Other cells, height bands and larger shared batches still influence the campaign saving. [Fixtures](ab_inputs.json), [stock HOL4 log](gridab01.log)
## Including the small-conductor guard and final extraction

The revised small-conductor product, split, character and Gaussian schedules add another 716–728 core-hours at 640 guard indices. That brings the selected fixed-grid subtotal to 703,090–703,631 hours before final transform extraction.

The three-stream extraction pilot measures the additional stock HOL4 time after subtracting the ordinary splits on the same operands. Scaling its eight real masks to the 36,088,118 guarded physical tiles adds 105,742 hours. Scaling by the 1,787,257,220,237 live samples adds 123,045 hours. These give partial scenarios of approximately 809,000 and 827,000 hours. The stock replay used repeated 64-position operand blocks with the real masks. The full nonperiodic underlying products were independently checked natively. Two-stream arithmetic, principal-character work, global repairs, raw seed proofs and proof transport can all change the eventual total. [Calculation and assumptions](consumer_scenario.json), [matched replay](../small-time-selected-consumer/integrated-summary.json)
## Recombining into two output streams

A second matched stock HOL4 pilot combines the three packed products into their real and imaginary parts before extracting the retained values. Reusing the quotient from the split took 41.968 CPU-seconds beyond the original three splits across the eight tiles. The equivalent increment for extracting all three streams was 84.387 seconds. Each pilot uses the same real masks and repeated 64-position input blocks. Full nonperiodic inputs were checked separately by the native implementation.

At the guarded population sizes, this gives 52,588 extra core-hours by physical tile count or 61,194 by live sample count. The priced fixed-grid subtotal becomes **755,679–764,825 core-hours**. That leaves 35,175–44,321 hours before the 800,000-hour comparison point. This calculation retains the original four-channel price for the sparse observations. Costs for the principal character, global repairs, seed proofs, and proof transport remain open. [Matched timings](../small-time-selected-consumer/two-price.json), [calculation](consumer_scenario.json)
