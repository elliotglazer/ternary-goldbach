# Four recommendations: completion audit

Completed 2026-11-12, continuing the 2026-11-11 campaign. The coordinator accepts the four requested deliverables at their original scope. This completes the goal to carry out recommendations (1) through (4). It does not complete a proof of ternary Goldbach, remove the canonical theorem's numerical hypotheses, or establish a practical production compute budget.

## Requirement-by-requirement result

| Requirement | Result and authoritative evidence |
|---|---|
| 1. Select the conservative Lean strategy | Complete. `LEAN_IMPLEMENTATION_DECISION_2026-11-11.md` selects the original analytic structure, restricted required finite-RH family and ordinary checked numerical/finite certificates. QRH remains optional. The restrictions must still be implemented at the production consumers. No new public frozen declaration was adopted. |
| 2. Finish the lower-precision assignment and raw-head accounting | Complete at their stated research scope. The decision accepts author/reviewer pairs 0559C6A2/C93394B2 for the mean186 assignment and FBBB538E/076A1081 for the full raw-head producer/error/cost paper. Root verified eight source/output pins. No uncomputed runtime discount or produced large-family data is claimed. |
| 3. Produce provisional end-to-end Lean/MM0 estimates | Complete. `estimates-20261111/END_TO_END_ESTIMATE.md` and its JSON provide generation/first-acceptance, finite coverage, spectral, shared-library and storage scenarios. Independent final review 9E861C35 checks the sum, phase convention and units; component reviews check the underlying conditional accounting. Costs remain assumptions for these designs, not optimal-cost forecasts or upper bounds. |
| 4a. Complete a representative finite binary Lean certificate | Complete. `BinaryPilot.binary_interval` proves all 64 even targets in the stated interval near 4 * 10^18. Actual source and anchor primality, source slicing, two tiles and final assembly are proved. Full-source build, malformed-mask rejection and independent exact-type/standard-axiom review passed. Root acceptance is `BINARY_PILOT_ACCEPTANCE_2026-11-11.md`. |
| 4b. Complete a representative positive-height spectral Lean certificate | Complete. `SpectralPilot.positive_height_chi4_certificate` proves strict real positivity and exact zero imaginary part for the actual conductor-normalized completed character L-function at s = 1/2 + i * 5/64. Actual finite powers, concrete rounded centers, finite character sum, analytic tail, Gamma factor, positive scale and exact reality are all supplied in the proof. No enclosure, tail, root-number or spectral hypothesis remains. Independent semantic review B6C709ED passed. |

## The completed spectral certificate

The character is the literal mapped `ZMod.χ₄`. The numerical path uses the eight nonzero terms among n = 1 through 16. Proved finite logarithm and exponential approximations connect each actual complex power to a grid20 center. The exact signed center is `(572952 + i * 51250) / 1048576`, with finite error at most `1/62500`. The source-derived Abel tail is at most `33/128`.

These bounds prove `Re L > 1/4` and `abs(Im L) < 1/2`. The actual rotated Gamma factor has real part at least `3/4` and imaginary absolute value at most `1/4`, and the remaining real scale is positive. The final proof retains the imaginary cross term. Primitivity, self-duality, root number one and conjugation are proved; the functional equation gives exact reality of the normalized completion.

The final theorem has no logical inputs. Its normalized completion is the actual object specified by the pilot. No comparison with another Hardy convention is silently asserted. The direct eight-term sum is a real complete numerical certificate, but does not calibrate a large CT/Bluestein transform, high-height producer, interpolation repair schedule or Turing-count certificate.

The coordinator read the final assembly, actual finite approximation/tail code, Gamma/normalization proofs, and independent reviews. Root independently reconstructed the complete source from all eleven pinned original module bodies, with only imports and file-scope wrappers changed. This reconstruction is recorded in `work/lean-pilots/audit/root_full_spectral_source_check.json`, SHA256 9EF5CE25A9D0248FF6F597978BD40E1948574BAE718F1D485F1F8E16743679FA.

The fresh combined source is `work/lean-pilots/spectral/FullSpectralPilotV2.lean`, SHA256 948342E85DE5C59BC96CD00AD494FE343514EDDBD545D9A6A7F3D26356C1BAD1. It contains every owned proof and imports only external Mathlib/project continuation dependencies. Its strict `-t0` build passed. The source has 47307 bytes and its object has 9821984 bytes. The first combined source failed because file-local open scopes leaked during concatenation; that failed source and receipt remain preserved. The successful successor restores file scopes without changing proof bodies.

The final exact-type/axiom probe against the fresh combined object also passed. Its five queried closures contain exactly `propext`, `Classical.choice` and `Quot.sound`. The independent modular exact-type probe separately substitutes the literal character into the statement and applies the theorem without premises. A strict-trust negative control changed a rounded input to zero and was rejected with an unsolved `False` goal. No theorem is inferred from that failed control.

## Complete-build measurements and limits

| Pilot/workflow | Wall seconds | Process CPU seconds | Scope |
|---|---:|---:|---|
| Complete binary source | 87.796652 | 126.031250 | All owned primality and coverage proofs, strict imports and object output |
| Binary import-only comparator | 12.872155 | 12.718750 | Same external imports, no owned construction |
| Complete spectral source | 51.733959 | 63.031250 | All eleven owned proof bodies, strict imports and object output |
| Spectral import-only comparator | 38.279340 | 37.937500 | Matching external imports, no owned construction |

The spectral build's peak working set was 3625549824 bytes; sampled peak private memory was 8722370560 bytes. No binary peak-memory trace was collected. These are actual individual measurements on the shared host. Differences from the import comparators are not separately measured kernel-only or proof-generation times. No dependency rebuild, heartbeat relaxation, custom axiom or native decision acceptance was used.

The spectral numerical prototype uses exact rational polynomial intermediates followed by final dyadic enclosures. Its proof representation differs from the proposed fixed-grid production circuit. Neither its build time nor its bytes per sample may be extrapolated directly to the full spectral family. Likewise, the small binary pilot's cold prime closure is not a steady production cost per target.

The provisional estimates remain large: first-acceptance scenarios are about 1.40e9 / 6.77e10 / 1.04e13 core-hours for the modeled Lean design, and 2.49e9 / 3.27e10 / 8.97e12 for the modeled ordinary PA MM0 design. These are not language capability comparisons. The pilot work validates complete local proof paths and exposes representation costs; it does not validate the model's workload-transfer rates or make a full production run feasible.

## Final audit sources

- Spectral final report: `work/lean-pilots/spectral/REPORT.md`, 06E423C98CADCB94A372872E8D1CF9D9B7F142F007350C9A08F058D82B064A08; `pilot_receipt.json`, 673500D6324DDB8047C2CFAB5B489A18D6FB5109E3F541A1AEE0850147CC54A3.
- Binary semantic review: `work/qrh-campaign/agents/audit/REVIEW_BINARY_LEAN_PILOT_SEMANTICS_2026-11-11.md`, 189FCB113A859B16919E6BF3E1AA394B890649833E6F9B619475021C437E3162.
- Spectral semantic review: `work/qrh-campaign/agents/audit/REVIEW_POSITIVE_HEIGHT_SPECTRAL_PILOT_SEMANTICS_2026-11-11.md`, B6C709EDA23CA78F58CCFCC4A230189CA3AEAADE2DCC91174A36418C61AF3F23.
- Spectral exact-type probe receipt: `work/lean-pilots/audit/positive_height_export_probe_receipt.json`, BABB0916686CAE2D9F14187A8442AADC70DD9E5808D2F7697AAD438EAB5F0414.
- Finite input/tail review: `work/lean-pilots/audit/spectral-inputs/REVIEW_2026-11-11.md`, B5FE164DFC0758F3B8B867AA99E1F1AFBDD86D6C80670DCAC4FFBE1A6E9851D3.
- Gamma/completion review: `work/lean-pilots/audit/spectral-completion/GAMMA_COMPLETION_SOURCE_AUDIT.md`, D905B0120422E5B3BA2212CE06DDE97CB8108E9BF7CCC3DE2AB55C68778549A4.
- Estimate synthesis: `work/qrh-blueprint/estimates-20261111/END_TO_END_ESTIMATE.md`, FF797585713B632A310451898DC68906057E48FEE733B177FF9125A9EFEDEDD7; independent review 9E861C3511B8D14FC673319DC2E4C6F6AF24C9A0269E63B5184E45F0FAB0ED30.

Earlier frozen target/estimate documents that describe the spectral pilot as incomplete record their publication-time state. This completion audit supersedes those status sentences only; their numerical assumptions and scope limitations remain unchanged. The canonical ternary-Goldbach proof still has unresolved production inputs and is not claimed complete.

DRAFT_ANCHORS: none created; repository-wide state not audited.
UNREGISTERED_SORRIES: none in either accepted pilot closure; repository-wide state not audited.
DRAFT_IMPORT_VIOLATIONS: none in either accepted pilot closure; repository-wide state not audited.
SEALED_THIS_TURN: 0; these are complete internal pilots, not newly adopted public frozen anchors.
