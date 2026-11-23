# rounddep01 direct-ancestor repair

Root's rounddep01 theory build stopped at the ML reference to `rounded_butterfly_one_correct`: the transitive theory was loaded but not opened as a direct ancestor. The repair adds `RoundSpecialization` to the `Ancestors` line. No definition, theorem statement, proof body, CV registration, fixture, driver or runner changes.

The previous source and binding are preserved byte-for-byte in `history/rounddep01_direct_ancestor`. The source-binding entry for this theory alone is updated. The generator already hashes this file at preparation time, so it needs no source change and no driver regeneration.

Other imported theorem values were checked: `block_layer_def`, `block_run_def`, `block_accept_def` and `block_accept_sound` belong to the direct `DependentBlock` ancestor. The remaining theorem/definition values are declared earlier in this file. The driver opens `RoundDependentTheory` and `DependentBlockTheory` directly. No analogous transitive theorem-value reference was found.

No build or evaluation was run by the author. The old failed build receipts are retained. Successful compilation of the repaired theory remains for root.

Repaired source SHA256: `FD8A98AD0FB0E3E75BD5BC40757210BC551136E98EA362C8375368FEE31C19AE`.
