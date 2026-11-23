# Review of the original guard provenance clarification

2026-11-11. PASS for the narrow mandatory clarification, with no further correction requested. Consume the frozen preflight369F2897 and companion7A0C5017 together. This review qualifies the matching overstatement in my earlier preflight review4F1C347C. It does not clear an unpinned writer or authorize execution by itself.

The companion is `moebius/COMBINED_PRICE_BASE_GUARD_PROVENANCE_CLARIFICATION_2026-11-11.md`, SHA256 `7A0C501723B0DC96F5D59877BAA44692117E62DF8C97D550D3E6086847EC67CC`. I read it completely, verified its hash and checked the exact source distinction in the successful assignment writerF67CF569. No inventory was parsed, no fold or writer was run, and no frozen artifact was changed.

## The corrected dependency

The combined node tuple contains mixed, sharp and tight C/D values. It has no original baseline C/D fields. Therefore those nodes reconstruct S_mix, S_sharp and S_tight along the saved ordered axes, but cannot alone reconstruct S_base or D_local_old.

At lines190–198 of `major-constants/combined_conductor_precision_assignment_20261111.py`, the earlier axis table supplies old_C, old_D, new_C and new_D. Line275 forms S_base from old_C and D_local_old as the maximum of1 and both old_D/new_D over the actual axes. That earlier axis file is outside the price pass's twelve-input allowlist. It must not be added silently, and the mixed D must not replace the potentially larger original maximum.

The corrected price gate requires equality of S_base and D_local_old with every corresponding accepted sharper row. The exact row ID, conductor, phi, primitive count, other shared fields and ordered manifest axes remain bound. It also reconstructs all three current sums from the available node coefficients and checks max(1,D_mix(axis))<=D_local_old. This is a useful consistency inequality, not a new definition of D_local_old.

The assignment evidence supplies the original computation. `major-constants/REVIEW_SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md`, SHA256 `F213CB6BC227DFE0C5A25DD92B3DE6405165E7281678EA9224596EE7704FCF39`, independently reconstructed the baseline axis pairs and every legacy/sharper row. Its hash matches. The combined review8745235D also reconstructed the original axis information under its larger approved input set and compared every compact row. Those accepted results are explicit inherited premises in the proposed price pass.

Every sharper stored slack and every omitted combined slack must still be recomputed. The predecessor at p100 must use rho99=1. Both original safety/peak guards remain, and p80 has no predecessor test. No aggregate match substitutes for the every-row binding. No mathematical guard, selector condition, input count or cache condition is removed.

## Correction to my prior review

My frozen `REVIEW_COMBINED_PRECISION_PRICE_PREFLIGHT_2026-11-11.md`, SHA256 `4F1C347CF6D1AAECD631E21CE7D6F5228446DF239D49D59FD443D8F4F1B24A98`, stated that axis sums and old D were reconstructed from saved ordered-node fields. That sentence was too strong for the specified input schema. Replace its meaning with the corrected dependency above: three current sums are reconstructed; S_base and D_local_old are inherited through exact accepted-row equality; all relevant slacks are recomputed. This companion review is mandatory when consuming that earlier approval.

The original approval's other conditions remain. The twelve input pins, resource caps, one40-weight propagation, exact sample unions, full P20/grid100 source, V_width16384, full caches, arithmetic-unit distinctions and inherited historical phase scope are unchanged. No new source file becomes a data feed. This is a provenance repair before execution, not acceptance of a price result or a hidden expansion of the allowlist.

Root acceptance of the companion and clearance of the exact final writer bytes remain necessary. A later author/result review must disclose this pre-run source correction. No run history is altered or inferred by this note.
