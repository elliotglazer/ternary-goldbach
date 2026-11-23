# rounddep02 repair

Root's complete .hol/logs/RoundDependentTheory shows all mathematical proofs saved, followed by failure of cv_trans on round_block_layer_def: the automatic induction tactic did not discharge the recursive pattern-matching precondition. Source is unchanged through round_block_accept_sound.

The successor uses cv_trans_pre for layer and run, with unconditional generated-predicate proofs over the coefficient/input lists and depth. Both are cv_pre theorems. The acceptance wrapper remains plain cv_trans because cv_repLib.cv_rep_for rewrites cv_pre_thms before assembling the caller's precondition. No scalar domain predicate or vacuous stand-in is created. Original positivity, correctness and soundness claims are untouched, as are driver bytes and all fixture data.

Reference implementation: original DependentBlockScript.sml layer/run inductions. Reference translation mechanism: cv_transLib.make_ind_thm and cv_repLib.cv_rep_for's pre_simp_conv. The generated recursive predicate may exist even though its domain is universal; totality alone did not let the default automatic tactic prove it.

No build or evaluation by this author. Parent must compile and inspect any diagnostic before adopting the update.

Source SHA256: `E72B4A1A5E4E0A82E0AC854FB87B576E80E3A1B4545FF7D146338DDBB89F733C`.
