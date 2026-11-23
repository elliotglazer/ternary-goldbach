# Import the standard proved list translations

Map06 completed the generic quicksort proof and its translation. It then failed while translating ALL_DISTINCT through set membership, before evaluating finite_checks. The standard cv_std theory already provides proved MEM and ALL_DISTINCT translations; the original map theory did not import it.

The successor adds cv_std to the ancestors and pins its two prebuilt theory files in the runner dependency receipt. No definition, theorem statement, proof body or finite assertion is changed. Existing dependency files remain read-only. Map06 inputs and failure logs are preserved under history/map06_missing_cv_std.

Source SHA256: `9dfab986f83d8b7509a3f8f841228c85ed8a152d6598e0b655101bc9f8c74e67`.
Runner SHA256: `cbc16d38c5516d05244d4f4b8db1d178a6b0edb1c2fc5064d8c0f31193a574c6`.

The complete finite map result remains unaccepted until the successor constructs and audits it.
