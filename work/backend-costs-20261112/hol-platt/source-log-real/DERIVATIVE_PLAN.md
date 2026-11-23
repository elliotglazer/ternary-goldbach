# Logarithm tail route using the existing HOL library

This is a mathematical implementation plan, not an accepted HOL theorem. The source program is the existing source_log_horner/source_log_center at z=A/B in [0,1/3]. The accepted Lean pilot is a specification reference only; no theorem is transported from Lean.

Define P_0(z)=0 and P_(N+1)(z)=P_N(z)+2*z^(2*N+1)/(2*N+1). Define R_N(z)=ln(1+z)-ln(1-z)-P_N(z). Prove by induction, using the existing lim/transc differentiation rules, that R_N'(z)=2*z^(2*N)/(1-z^2) for 0<=z<1. The induction subtracts the derivative of the next odd monomial and uses a field identity. This avoids reconstructing an infinite-series API or using the weak global derivative estimate in the direct log Maclaurin remainder.

R_N(0)=0. For 0<=z<=1/3, the mean value theorem supplies R_N(z)=z*R_N'(c) for some 0<c<z when z>0; handle z=0 separately. Nonnegativity, 1-c^2>=8/9 and c^(2*N)<=(1/3)^(2*N) give 0<=R_N(z)<=(9/4)*(1/3)^(2*N+1). At N=45 an exact rational comparison gives the required 2^-135 tail. LN_DIV identifies ln(1+z)-ln(1-z) with ln((1+z)/(1-z)) once both arguments are positive.

Relevant already-built source APIs are limTheory.MVT in limScript.sml:1229, limTheory.DIFF_SUM at 716 if using a finite-sum presentation, transcTheory.DIFF_LN at transcScript.sml:803, Diff.DIFF_CONV, and seqTheory.GP_FINITE if a geometric-sum identity is useful. The actual candidate polynomial must be connected to source_log_horner's ideal recurrence. Then prove its rounded integer error by induction from round_scaled_real_error, using z^2<=1/9. Finish source_log_center, ln(2) reuse, range reduction and the final grid conversion. Those are separate required producer obligations.

This route uses the already built real-analysis libraries. Its proof and actual source-throughput measurement remain open; no forecast credit is assigned.
