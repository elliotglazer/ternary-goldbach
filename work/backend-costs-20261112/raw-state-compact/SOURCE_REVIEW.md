# Independent source review of the compact integer-sign packet

13 November 2026. PASS at source/design scope, conditional on successful generic-theory and driver builds. No semantic correction required. No HOL process, generator, evaluator or benchmark was run by this reviewer. All thirteen current files named in predecessor_inputs.sha256 match their pins. This review creates no accepted theorem object.

## Sign relation and information retained

RawCompactSigns defines sign codes 0/1/2 for negative/zero/positive integers. A pair is encoded as real_code + 3*imag_code, hence a digit in 0..8. raw_sign_pack places the first time index in the least-significant base-nine digit. raw_sign_mask_rel recursively demands exactly the same digit and a tail relation ending at zero. The proposed induction theorem identifies that relation with equality to the packer; the meaning and digit-bound theorems state the two ingredients needed to interpret the digits.

For a fixed row length, this is an exact sign encoding: reduction modulo9 recovers the first digit, natural division by9 recovers the tail, and division/modulo3 split the two codes. It is not an encoding of integer magnitudes or full array equality. The packet correctly retains row lengths externally. Arbitrary trailing zero digits are indistinguishable if lengths are omitted; code0 means negative, not a missing coordinate. The README explicitly identifies this limit.

NONE propagates to NONE; the summary relation rejects mismatched SOME/NONE cases. For successful output, LIST_REL preserves row count and row order. The proposed raw_compact_correct conclusion refers to the actual raw_pipeline expression, not an arbitrary successful sign list. The concrete wrapper requires SOME four numeral masks, verifies its public input term, and binds the generic relation to that concrete result.

The generic proof bodies are plausible ordinary HOL proofs using case splits and list induction; no axiom, oracle shortcut or admitted theorem is introduced. This is a source reading, not a claim that every tactic or automatic CV translation will succeed. In particular, recursive CV translation remains a build gate, as illustrated by the separate dependent-block work.

## Actual input and full computation

The preparation code reads the pinned fixture, verifies its schema, eight-base order, state/step grids and last index, and emits the eight literal initial/step pairs. It performs no recurrence, head or sign-mask computation and does not embed the old large result. The inherited raw_pipeline retains its fixed base/denominator/depth guards, all8x129 production, shape/coordinate bounds, and four head rows. Packing is applied only after that computation.

The source binding is to those exact integer literals. Neither this binding nor the compact theorem closes the analytic source enclosure, phase, L-function or real-sign bridge. The README correctly makes no such claim. The eight raw traces contain2064 integer coordinates; the compact result represents1032 signs in the four final129-pair head rows, not every intermediate trace sign.

## Independent old-result validation

The primary compact computation and public relation are completed before loading HandoffFused. The later validation checks exact equality of the old theorem's LHS with the public raw_pipeline input. It maps raw_compact_of over the old RHS with checked evaluation, combines that with AP_TERM/TRANS, and compares the resulting full proposition with the expanded compact theorem. Thus it validates the new sign result against the exact old result without using the old result as the primary computation's input.

The logical HandoffFusedTheory.sig/sml paths follow the already successful readback03 convention: HOL's filesystem mapping resolves the logical theory path to .hol/objs. The manifest pins the actual exported files and the runner checks the current data against the archived handoff10 data. This is not an unpinned arbitrary theorem substituted after the primary run.

## Controls and cost interpretation

The controls demand rejection only for cases which the compact contract must distinguish: wrong base list, denominator, depth, and a different first mask. Sign-code and signed-rounding-tie checks are explicit. The predecessor's altered-magnitude controls are not falsely claimed to discriminate after compression: different magnitudes can legitimately have identical signs.

The runtime separately labels literal construction/definition/translation, representation, conversion preparation, numerical computation, decode, hypothesis closure, public binding and semantic binding. Old-theorem load, mask evaluation and equality validation follow the primary marker and have their own timings. summarize_compact cuts its primary phase sum at that marker and labels omitted phases; it does not present that sum as total first-acceptance cost. Whole prepare/generic/build/run time files remain necessary for cold lifecycle accounting, along with export and any future readback. New packing cost is inside the computation and cannot be ignored when comparing decode savings.

The runner uses exclusive output creation, pinned predecessor checks before and after, bounded existing resource settings, separate terminal checks and later summary validation. Its primary marker alone is insufficient acceptance; the matched-old-result and final markers plus all control checks remain required. This source review does not authorize an unbounded retry or any change to the pinned predecessor.

No predicted runtime reduction or end-to-end forecast change is supported by this unrun packet. A successful run would compare representations for the stated integer-sign contract only.

## Frozen source pins

| File | SHA256 |
|---|---|
| RawCompactSignsScript.sml | 1B26201077B2FEDB21712482F73531D02C40DAACEE2983820D97393D2577140D |
| prepare_compact.py | 589AADEE7BC4659CD08011EAE20053FF3EA8276D5C09D2A1D19C31959AE5F6EE |
| run_compact.sh | 60121A7487A0910D68786EC737D205B7C0F4C15BC06D1B63DA4FE76FE07B2A80 |
| summarize_compact.py | CF1D3CBDED76C7CA18CC43F82C86C764AAF8FFF94ECE6FB4F3A5056B22D8E0E3 |
| README.md | F2147D17E18BD64DC06B8658840285477FFBE1F14BA777705D953AFB01D11F50 |
| predecessor_inputs.sha256 | D795B1D3CBE84D2DCA4742E262A0F4FF04DD55BE69B5637A4262432E3AF592B7 |
| Holmakefile | 54FD6F8D93D99FB8D04E11AA408F8EE4B8BF9B66AF6E438238A95B0996E5F631 |

The previously saved packet is unchanged. Only this review was written.
