The draft `ZeroFreeFixedGap.lean` derives an unconditional fixed gap below height 1e8 from the target repository's own analytic lemmas. The final declaration is

```lean
theorem zeta_zero_re_le_fixed {rho : Complex}
    (hz : riemannZeta rho = 0) (h0 : 0 < rho.re) (h1 : rho.re < 1)
    (ht : abs rho.im <= 1e8) : rho.re <= 249 / 250
```

The actual Lean file uses the repository's Unicode notation. This displayed statement only records the intended type. The draft has passed independent mathematical review and is awaiting compilation. The review checked the exact Stechkin premises, reflected-pair multiplicities, all four harmonic heights, the revised digamma bound, and every rational rounding direction. It depends on the separate unconditional low-zero draft, which supplies abs(Im rho)>=2.39.

The new low-height digamma estimate starts from `re_digamma_le'`, which is valid for every positive real part. For 1<sigma<=2 and abs(t)>=2.39, it bounds one half of Re psi((sigma+it)/2) by one half of log(abs(t)) plus 0.4. The source proof's factor 1.01 is replaced by 1.18. This is valid because 0.18*(2.39)^2>1, while log(1.18)<=0.18 and log(2)<0.6932 give additive constant at most 0.3916. The existing cutoff-10 estimate is not invoked.

The proof of `vM_term_le` is then repeated with that new digamma estimate and constant 0.4. Its other reciprocal and digamma-difference inequalities only require a positive imaginary part. Their original rational expressions are retained.

Fix sigma=1.014 and kappa=(sigma-1/2)/(1.6181-1/2). Then 0.45<=kappa<=0.46. For every tau in [2.39,4e8], the following upper bounds are used.

- log(tau)<=20, certified from 4e8<=exp(20).
- 2/tau^2<=0.351.
- 11/tau^2<=1.926.
- (1-kappa)*(log(tau)/2+0.4-log(pi)/2)<=0.55*9.83.
- kappa*(0.20604+11/tau^2)/2<=0.491.
- kappa*E1<=0.592, using the existing E1<=1.2857 calculation.

Their sum is at most 6.8405, so each positive-height von Mangoldt term is at most 6.85 minus its distinguished-zero contribution Z.

Suppose a zero has beta>249/250 and 2.39<=gamma<=1e8. The existing Stechkin inequality supplies

    Z = 1/(1.014-beta) + 1/(1.014+beta-1)
        - kappa*(1/(1.6181-beta)+1/(1.6181+beta-1)).

The proof bounds the positive reciprocals below by 500/9 and 0.98. It bounds the negative reciprocal terms above by 1.618 and 0.62, whose kappa-weighted sum is at most 1.03. Thus Z>=55.5. The real von Mangoldt term at sigma is at most 500/7 by `vM_real_le`, `log2585_le` and `log_pi_ge`.

The source's nonnegative trigonometric polynomial has coefficients 18,30,17,6,1. Applying it at sigma and gamma yields

    0 <= 18*(500/7) + 54*6.85 - 30*55.5 = -657/70.

This contradiction proves the fixed gap for positive gamma. Conjugation gives the same result for negative gamma. The unconditional low-zero bound covers the remaining height range.

Every use of the original height threshold has been replaced explicitly. The lower bound log(gamma)>=18.4 and its moving sigma=1+0.31/log(gamma) are replaced by fixed sigma. The original tiny-error allowance 1e-15 is replaced by the displayed reciprocal bounds. The cutoff-10 digamma estimate is replaced by the proved low-height version. The bounded height range supplies log(j*gamma)<=20 for j=1,2,3,4. No asymptotic inequality is extrapolated to a smaller height.

At log(x)>=35000, this exponent leaves exp(-log(x)/250)<=exp(-140). It is sufficient in scale to absorb even the earlier coefficient 1e24 into the existing far-asymptotic budget. The prime-estimates worker owns the exact absorption and explicit-formula assembly. This fixed-gap result addresses that sublemma, and the original full Goldbach objective still has other estimates to discharge.

