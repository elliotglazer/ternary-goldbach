# Uniform persistent-state bounds candidate

The generic finite-prefix bootstrap bounds source_error_envelope initialError delta delta n by initialError + 3*n*delta, assuming delta >= 0 and the proposed envelope at the last index is at most one. It retains the multiplicative error term and does not evaluate a large geometric power.

The raw specialization uses initial error 2^-98, step and round error 2^-120, persistent grid 2^120, step grid 2^122, and at most 90000 updates. The actual source_state error must be strictly below 2^-96. Initial and step producer accuracy and the exact analytic recurrence are explicit premises, not certified in this module. No actual source, transform, sign or count is asserted.

Three exact audit roots were captured before the first build. No statement or audit changes are permitted merely to follow proof repairs. Acceptance requires the build, reload audit, hashes and recorded-result review. No timing forecast credit follows from this generic bound.
