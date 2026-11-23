# Independent audit of the four sparse counting witnesses

The four conductor-10000 channels retain the full-height lower counts and every auxiliary flip's right endpoint. The two width-50 Turing comparisons therefore retain their original strict margins. This read-only audit independently decoded all witness packets, read their selected 256-bit raw samples, compared each against the earlier grid, and recomputed every selected interpolation dot product with its archived kernel. It did not import the sparse producer or invoke HOL.

| Label | Raw samples | Stencils | Main flips | Auxiliary flips | Auxiliary weight in subticks |
|---:|---:|---:|---:|---:|---:|
| 3 | 17,883 | 27 | 15,880 | 129 | 169,791,488 |
| 6667 | 18,234 | 30 | 15,880 | 129 | 169,412,609 |
| 11 | 17,207 | 19 | 15,881 | 129 | 168,435,712 |
| 9091 | 18,001 | 27 | 15,881 | 128 | 166,895,616 |

## Why the sparse test suffices

Within each open interval, an ordered list of true strict signs gives a distinct zero between each pair of successive opposite signs by continuity. Such open brackets have disjoint interiors; if adjacent brackets share a witness, its strict sign excludes a zero there. Omitted samples need not be given any sign. Unseen additional roots can only increase the count until the independent upper bound establishes saturation.

For the auxiliary interval (T,H), a zero in an opposite-sign bracket (a,b) contributes at least H−b to the integrated lower count. One witness from each sign run preserves the number of flips. Selecting the **first** witness of every run after the initial auxiliary run preserves the original right endpoint b and therefore the exact weight. Selecting a later witness would still give a valid lower weight but might lose saturation. The independent check compared the complete auxiliary lists of right endpoints, not only their summed weights.

For the main interval (0,T), the original implementation retains a witness with large certified absolute value where possible. For label 3, the first flip's right endpoint moves from tick 49,152 to 53,248. Its total main weight moves from 2,648,889,688,320 to 2,648,750,022,912. CountReceiptScript.sml's pair_test takes only the two **main flip counts** K and the two **auxiliary weights** W. It discards both main weights and both auxiliary flip counts. Replacing these main right endpoints is sound for this implementation.

The decoder requires strictly increasing subticks, and the separate main and auxiliary scans require their witnesses strictly inside (0,T) and (T,H). The scan state resets between regions: no bracket crossing T is counted. At ticks 0, T and H the observation separately checks strict signs, and checks the nearest guard ticks 1 and T−1 agree with 0 and T respectively. Endpoint signs are excluded from the open-interval lower counts. For a future parity-based width-25 result one must also justify the parity of the actual closed count and its agreement with K, including multiplicity, the inverse-character identification and the off-line involution. The width-50 comparison here uses the stricter threshold K+1 and needs no parity-based relaxation.

For the inverse pairs (3,6667) and (11,9091), the independent exact values (K,W) are (31,760,339,204,097) and (31,762,335,331,328), where the second number of each pair is in subticks. Substituting the archived upward phase rational, two channel allowances of 18, and 640 guard steps into the integer strict test yields positive right-minus-left slack of 3,603,335,518,617,600 and 4,878,747,532,001,280. Conditional on the analytic sign transfer, continuity, and the original Turing bound and phase upper bounds, K≤N<K+1 implies N=K with multiplicities.

The union of raw samples needed by all selected coarse signs, endpoints and off-grid repair stencils exactly equals the 71,325 retained samples. Each retained off-grid point has the matching subtick offset, positive kernel denominator, correct dot sign and strict margin against the stored threshold. Demonstrating that these raw values come from the actual Gaussian transform remains a separate analytic and source-provenance obligation. A proof of all dense signs is unnecessary for the sparse mathematical implication, and the four observed selection rates establish no campaign-wide rate.

check.py records input hashes, per-channel main weight changes, all weight totals and exact pair slacks in audit.json. The read-only inputs are full-height-count, grid-sign-join and sparse-count. This directory is the only output destination.
