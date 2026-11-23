# Explicit upper bound for the Turing zeta-log integral

2026-11-11. Research supplement, pending independent review. This supplies a paper reduction and external interval certificate for

`J = integral_(5/4)^infinity log(zeta(s)) ds < 1.184`.

The consumer is the upper horizontal-log proof being reconstructed from Trudgian/Rumely. This note does not prove that horizontal theorem, the Rademacher convexity bound, or any Lean theorem. It adds no premise to the Goldbach root. No prime enumeration, spectral scan, Lean build, or frozen-package edit was performed.

## Analytic reduction

For real s>1, the absolutely convergent positive Dirichlet series defines actual zeta, which is greater than1. Termwise differentiation twice is justified locally by summability of `(log n)^2*n^(-sigma)` for sigma>1. With probabilities `p_n=n^(-s)/zeta(s)`,

`(log zeta)''(s) = sum p_n*(log n)^2 - (sum p_n*log n)^2 >= 0`.

The last inequality is Cauchy-Schwarz, with all sums absolutely convergent. Thus f(s)=log zeta(s) is convex. On each closed real panel, f lies below the straight chord between its endpoint values. Integrating the chord gives the composite trapezoid upper bound. No derivative-error estimate or unverified numerical quadrature is needed.

For an integer B>=1, Euler-Maclaurin through the B2 correction gives

```
zeta(s) = sum_(1<=n<B) n^(-s)
          + B^(1-s)/(s-1) + (1/2)*B^(-s)
          + (s/12)*B^(-s-1) + R,
|R| <= (s/12)*B^(-s-1).
```

Indeed the remainder is, up to sign, `(s*(s+1)/2)` times the integral of the periodized polynomial `r^2-r+1/6` against `x^(-s-2)` from B to infinity. Its absolute value is at most1/6, and the remaining integral is `B^(-s-1)/(s+1)`. This is the real s>1 specialization of the campaign's explicit EM proof obligation; all terms are convergent here and there is no pole convention issue. Consequently

```
zeta(s) <= U_B(s)
 := sum_(1<=n<B) n^(-s)
    + B^(-s)*(B/(s-1)+1/2+s/(6*B)).
```

The extra s/12 covers the absolute remainder; it is not silently discarded using an unproved sign. Since log is increasing, each trapezoid endpoint may be replaced by `log U_B(s)`. The function log U_B itself need not be proved convex: convexity is used only for actual log zeta, before replacing its endpoint values.

For s>=32, monotonicity of x^(-s) gives

```
0 <= log zeta(s) <= zeta(s)-1
  <= 2^(-s) + integral_2^infinity x^(-s) dx
  = 2^(-s)*(1+2/(s-1)).
```

Therefore the omitted infinite tail is at most

`T = 2^(-32)/log(2) * (1+2/31)`.

This also proves convergence of the defining integral. Together these inequalities reduce J to finitely many elementary logarithms, exponentials and rational operations.

## Finite certificate

The script [zeta_log_integral.py](zeta_log_integral.py) uses B=64, N=2048 equal panels, left endpoint5/4, right endpoint32, and exact step123/8192. At all2049 endpoints it encloses U_B and its logarithm using160-bit Arb intervals. It sums the positive trapezoid weights and adds T.

For efficiency it initializes `n^(-5/4)=exp(-(5/4)*log n)` and advances each power by multiplication by `exp(-(123/8192)*log n)`. The interval induction preserves every endpoint enclosure. Arb arithmetic, exp and log are the only numerical primitives; the acceptance script calls no builtin zeta, Gamma, integration routine, or prime table. All final comparisons are against exact rationals, using strict interval comparison, never binary floats.

The successful receipt is [zeta_log_integral.json](zeta_log_integral.json). It records every endpoint enclosure, the script digest, and the bound

```
trapezoid = 1.18349673882237016444501044085553215952463241 ...
tail      = 0.000000000357574815931998797443586570429033153 ...
total     < 5918/5000 = 1.1836 < 148/125 = 1.184.
```

The total interval radius is below5e-44. The script returned exit0 with status `PASS_EXTERNAL_EXPLICIT_EM_TRAPEZOID`. A preliminary builtin-zeta calculation was used only to choose a bounded grid; it is absent from the certificate and its acceptance premises.

The result remains external interval evidence under the paper analytic reduction. The elementary interval checker and actual Lean EM/convexity/integration proofs remain required. An independent review should recompute with different B/panel choices, inspect the full analytic inequalities, and avoid overwriting this frozen receipt. It need not reproduce any builtin-zeta diagnostic.

## Remaining formal work

Identify real zeta with its positive Dirichlet series on s>1; prove local second-derivative summability and log convexity; specialize the explicit EM remainder; integrate convex chords over the finite partition; prove the monotone-series and exponential tail estimates; then validate all finite elementary enclosures with the selected proved interval checker. These are internal proof obligations, not added assumptions on the final theorem.
