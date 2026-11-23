# Original guard provenance in the combined price pass

2026-11-11. Mandatory narrow clarification to the unchanged frozen price preflight `COMBINED_PRECISION_PRICE_PREFLIGHT_2026-11-11.md`, SHA256 `369F28970D508C5179524F9B5D5019E587BA87B39F2959515029A198F4EF379C`. This corrects one source-reconstruction statement before price execution. It adds no input, enumeration, arithmetic-price rule or execution authorization.

Preflight section3 says to reconstruct axis sums and `D_local_old` from the saved combined node fields. The three current sums `S_mix`, `S_sharp` and `S_tight` can be reconstructed there. The original `S_base` and `D_local_old` cannot: combined node rows contain mixed, sharp and tight C/D, but omit the earlier original-axis C/D.

The assignment writer `major-constants/combined_conductor_precision_assignment_20261111.py`, frozen `F67CF569467ED444A0BB8ED0F576166F4B289B8E5710CB769F08D3F22AF78408`, makes the distinction explicit. Its axis adapter at lines190–198 binds original `old_C`, `old_D` and mixed `new_C`, `new_D`; line275 constructs `S_base=sum old_C` and `D_local_old=max(1,old_D,new_D)` across the actual axes. The assignment independently reconstructed these values using its larger input allowlist. The price pass deliberately does not read that original-axis file.

The corrected price acceptance is:

1. Join every one of the125400 compact combined rows by exact row ID, conductor, phi and primitive count to the pinned sharper row and manifest.
2. Require exact every-row equality of `S_base` and `D_local_old` to the independently accepted sharper fields. Also match all other shared row fields. This is an inherited input premise, not a fresh derivation of the old C/D recurrence.
3. Reconstruct `S_mix`, `S_sharp` and `S_tight` from their actual saved combined node coefficients along the ordered axes, preserving repeated axes.
4. Require `max(1,D_mix(axis))<=D_local_old`. This checks consistency with the available mixed bound without replacing the earlier maximum by that potentially smaller quantity.
5. Recompute the sharper stored budget/guard/predecessor slacks and all four omitted combined checks from the retained fields. The combined predecessor selector must recompute its rho indicator at p-1, particularly when p=100. No original safety or semantic peak guard is dropped.

The inherited sharper row file is `integration/sharper_conductor_precision_rows_20261111.json`, SHA256 `8FD72DC7FD9EACCCF986BE92502AE13491F974744C9E6A6E32BD63ADC27ED085`. Its independent assignment review is `major-constants/REVIEW_SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md`, `F213CB6BC227DFE0C5A25DD92B3DE6405165E7281678EA9224596EE7704FCF39`. The combined author/review are respectively `EBA33B23C531312243495B9B0321597FC26D8AEBA8E1CF24626457474EA3A997` and `8745235D810A1F06E8661961A05EF93C8DB24574121700DF6D924AE6EC2615C4`. They establish the exact original-axis reconstruction being inherited.

All twelve price inputs, every precision and context cap, the single40-weight propagation, V_width16384, source P20, input regrid and full cache schedules remain unchanged. A price report must explicitly attribute the original S_base/D_local_old computation to the accepted assignment evidence. The proposed writer must bind this companion and its independent review; execution additionally requires coordinator acceptance and clearance of the exact standalone source. No price fold or numerical evaluation has occurred during this clarification.
