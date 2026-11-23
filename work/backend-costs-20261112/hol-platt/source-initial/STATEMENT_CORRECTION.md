# Explicit natural-grid statement correction

Initial01's helper si_grid_factor was intended to describe natural grids. Typed saved-goal inspection in griddiag02 showed that the unannotated base 2 had selected integer exponentiation, even though the exponent binders were natural. That helper cannot supply the natural-grid factorization required by the actual source program.

Before initial02, its base was explicitly annotated (2:num) in the source statement and its one expected audit quotation. This is an explicit type correction, not a proof-body-only change. The other six theorem statements and audit expectations are unchanged. The helper now describes exactly the natural-number grids used by source_pair_value. No condition or conclusion in the final initializer contract changed. The initial source, audit and diagnostics are preserved under history/initial01 and griddiag02_run.
