The source argument in `ZetaLowZeroFree.lean` extends to an unconditional low-zero bound. The new draft is `ZetaLowUnconditional.lean`, with `zetaF_ne_zero_of_half_le_re_of_abs_im_lt` and `abs_im_ge_of_nontrivial_zero`.

For s=sigma+it, the identity zetaF(s)=(s+1)/2-s(s-1)(s+1)J(s) and |J(s)|<=1/(8(sigma+1)) imply |s||s-1|>=4(sigma+1) if zetaF(s)=0 and sigma>0. Cancellation is valid because Re(s+1)>0. The arithmetic-geometric mean inequality gives |s||s-1|<=sigma^2-sigma+1/2+t^2. On 1/2<=sigma<=1, (sigma-1/2)(sigma-9/2)<=0, so these inequalities force t^2>=23/4. This contradicts |t|<2.39 because 2.39^2=5.7121<5.75.

For 0<sigma<1/2, the existing xiF functional equation sends a zeta zero to 1-s. The reflected point has real part between 1/2 and 1 and the same absolute imaginary part. The proof uses xiF_eq_zero_iff in both directions, so it concerns the actual Riemann zeta function. The pole at one is excluded by the critical-strip inequalities.

Both proof bodies are present without a placeholder or a QRH/RH hypothesis. Compilation is pending the shared import build, and the independent auditor has been asked to inspect the draft. This result would discharge the low-height auxiliary currently supplied by abs_im_ge_of_zeroH. It alone does not bound the real parts of zeros between heights 2.39 and 1e8.
