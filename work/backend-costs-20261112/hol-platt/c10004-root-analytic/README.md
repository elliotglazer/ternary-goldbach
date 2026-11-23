# Positive cosine bins for c = 10004

Let C_i be entry i−1 of the zero-based integer list RootBins.centers. The exported HOL4 theorem C10004RootIntervals.all_center_intervals proves, for every natural i from 1 to 29,

    (2 C_i − 1) / 2^82  <  cos(i π / 60)  <  (2 C_i + 1) / 2^82.

Thus C_i is the unique nearest integer to 2^81 cos(i π / 60). The formal conclusion is the pair of strict inequalities. Here grid is the exact real numeral 4835703278458516698824704.

| Theory | Main result | Successful run |
| --- | --- | --- |
| C10004RootAnalytic | Sine identity for the second-kind Chebyshev recurrence and all 59 interior cosine roots | root05 |
| C10004RootOrder | Exact classification of all positive real roots and identification of any descending enumeration of 29 roots in (0,1) | order03 |
| C10004RootBridge | Continuity, the strict sign-change interval theorem, and the integer-to-real recurrence invariant for RootBins.run | bridge02 |
| C10004RootIntervals | Converts RootBins.checked_centers into strict rational bounds on the indexed cosines | bins02 |

The recurrence invariant at k = 0 and n = 58 gives the integer endpoint evaluation as grid^59 times U_59 evaluated at that endpoint. Positivity preserves the product sign. The intermediate value theorem gives a root inside each open bin. The certified ordering of the centers orders those witnesses. Strict decrease of cosine and the fact that an increasing self-map of {1,…,29} is the identity fix every witness index.

# Actual table coordinates and complex error

C10004RootRows.actual_coordinates applies whenever (n,r) belongs to RootRows.rows and k<n. Both stored integer coordinates lie strictly within half an integer of the exact cosine and sine multiplied by scale = 2^81. The positive sine sign is part of the theorem. The nine row lengths 2, 3, 5, 10, 15, 20, 30, 40, and 60 sum to 185 entries. The proof reads RootRows.checked_rows, connects EL k r to expected n k, and applies the four quadrant cases and a 90-step shift in the 120-step wave. The boundary coordinates at angles 0 and π/2 use their exact values.

C10004RootNorm.actual_complex_error divides each stored coordinate by scale and proves a strict error less than 1/scale in complexTheory.modu relative to (cos(2πk/n), sin(2πk/n)). The pair_error lemma applies the Euclidean norm to the two strict coordinate bounds.

To repeat the exports using the existing local WSL setup, invoke run_wsl.sh, run_order.sh, run_bridge.sh, run_bins.sh, run_rows.sh and run_norm.sh in that order, each with arguments theory and a fresh label. Invoke the last three scripts with audit and fresh labels to reload their conclusions. Run each command in a private mount namespace as in the other hol-platt builds. The dependency theories must already be installed in the sibling directories.

The fresh audits compare the exact conclusions, check for empty theorem hypotheses, accept only the disk-theorem tag, and check ancestral axioms against the four standard HOL axioms. The interval audit also checks the bin endpoints and denominator, and the row and norm audits check the scaling and nearest-coordinate definition.
