# Global allowance for mixed residue evaluators

2026-11-11. Mandatory scope clarification to `RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md`, SHA `9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4`. Its frozen bytes and exact scalar receipt remain unchanged. No values, builds or source edits.

The displayed first-four and final-band formulas containing **1477u_H** in section3 apply when every residue covered by that character-sum estimate uses the new b100 requantization plus exact finite-difference/final-round adapter. Those formulas are not the global allowance of an arbitrary mixed schedule.

For a mixed schedule let E be the actual residues using that adapter and H the disjoint remaining residues using original-center Horner. Write w_a>=0 for the absolute source character/conductor weights; their sum is at most633 under the inherited bound. The evaluation part satisfies

    error < (7/3)u_H sum_(a in E) w_a
            +(8/3)u_H sum_(a in H) w_a
          <=1688u_H.

The strict inequalities can be weakened to non-strict inequalities without changing the inherited strict final alpha bounds. A sharper global saving requires the actual subset-weighted bound; it is not inferred from the existence of one converted cell. If H is empty the bound1477u_H follows. If E is empty the original1688u_H bound applies.

Therefore every mixed schedule described in the grid note preserves the **old** complete alpha bounds: below2^-82 in the first four bands and below `.16*2^-82` in the final band. Its source/EM, coefficient, analytic shift and target Taylor errors are unchanged. The adapter does not require or claim the stronger all-adapter formula for a schedule that retains original Horner fallbacks.

The scalar receipt's `first_alpha_fraction` and `final_alpha_fraction` rows describe the all-adapter alternative. Its `old_first_alpha_fraction` and `old_final_alpha_fraction` supply the retained caps for mixed evaluation. No numeric record or script is changed. The b122 extra-slack alternative in section4 is unaffected.

The concrete b100 grid, per-cell conversion cost, all integer widths, cache bindings and final quotient rules remain as stated. This clarification changes no proposed arithmetic and establishes no actual coefficient, sign or cost result.
