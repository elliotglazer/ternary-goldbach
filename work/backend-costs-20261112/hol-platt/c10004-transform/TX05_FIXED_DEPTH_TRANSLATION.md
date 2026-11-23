# Exact staging of the fixed six-level circuit

Tx04 passed the generic arithmetic, projection, length and checked-contract proofs, and translated the scalar operations. Automatic translation then detected a cycle when a generated GENLIST body called tx_full recursively. The failed construction is preserved under history/tx04_recursive_translation.

The public tensor and local numerical diagnostics all call the existing functions at fuel six. The successor retains their definitions and all generic statements. It adds full-stage functions for depths zero through six and an omitted-output function at depth six. Each has an ordinary theorem equating it to the original function at that depth for every dimension, cache and input list. There are no new shape, numerical, analytic or successful-output assumptions. Each nonzero full stage calls only the preceding stage in its child list; the omitted stage uses the same full depth-five children as the original.

Those exact equalities are registered as CV inline rewrites. Each nonrecursive stage can then be translated in dependency order. General unbounded-fuel evaluation is not needed by the existing public circuit; its mathematical functions and universal projection/length theorems remain intact. The transformation neither replaces CT with a direct DFT nor changes a rounding operation or output selection.

The new staging proofs and translations are unbuilt until the successor passes. The diagnostics, their fixtures and the runner are unchanged.

Successor source SHA256: `4f9fe96c14463dc6bd56f2f3e80c68d2865c4acd003cf6bc9ef569264b772346`.
