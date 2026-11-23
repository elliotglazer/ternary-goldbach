# Use the proved membership equality

Map13 evaluated the full finite predicate and proved the permutation and both distinctness theorems. Its membership consequence failed because the final SIMP_TAC did not use the immediately preceding proved equality between membership in unit_map and expected_units.

The successor changes that one tactic to ASM_SIMP_TAC with the same restricted bool_ss and explicit rewrite list. This consumes the established equality without reintroducing literal-list expansion. No theorem statement or definition changes. Map13 source, logs and saved proof state remain under history/map13_membership_rewrite.

Successor SHA256: `17116b0fa4230b0819426ecf8fe01c91d8a709170660faac6cc4c588f48ab65a`.
