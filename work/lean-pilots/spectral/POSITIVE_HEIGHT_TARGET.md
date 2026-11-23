# Positive-height spectral pilot target

This remains the intended representative pilot. The separate central result is a milestone only.

Let `chi4 = ZMod.χ₄.ringHomComp (Int.castRingHom ℂ)` and
`s0 = (1 / 2 : ℂ) + Complex.I * (5 / 64)`.
The source-facing target is the conjunction

```lean
0 < (((4 : ℂ) ^ (s0 / 2)) * chi4.completedLFunction s0).re ∧
  (((4 : ℂ) ^ (s0 / 2)) * chi4.completedLFunction s0).im = 0
```

There is no input enclosure hypothesis. The finite sample is the first positive coarse grid point.
Mathlib's completion omits the conductor factor. Multiplication by `4^(s/2)` supplies the
symmetric completion. A later comparison to any different Hardy convention must prove its
positive scaling and root-phase convention explicitly.

Required proof chain:

1. The actual analytic continuation is Mathlib `DirichletCharacter.LFunction`, and its completion
   is `DirichletCharacter.completedLFunction`. Cached project `Explicit/LGrowth` proves
   `LFunction_eq_mul_Iint` for nonprincipal characters and `0 < s.re`, without spectral assumptions.
2. Prove a finite Abel decomposition at a positive integer N, including its boundary term:
   `L(s)=sum_(1<=n<=N) chi(n)*n^(-s) - psum(chi,N)*N^(-s)
          + s*integral_(N,infinity) psum(chi,floor t)*t^(-s-1)`.
   For N divisible by4 the boundary term vanishes. The special chi4 partial-sum bound is1,
   giving norm tail at most `|s|/s.re * N^(-s.re)`.
3. Certify every finite power using finite elementary approximations and rational rounding
   witnesses, then transport those errors through the actual finite positive character sum.
4. Certify the Gamma/conductor factor in the completion. The existing Gamma integral and
   generic Gamma bounds are not a finite numerical Gamma-box producer. This bridge is open.
5. Prove chi4 primitive, self-dual and root number1, then completion conjugation/functional
   equation yields zero imaginary part. Combine the proved finite numerical enclosure with
   a strict rational lower bound for its real part.

No current file claims steps2–5 complete. No arbitrary arithmetic DAG, assumed L enclosure,
central positivity shortcut, or imported finite-RH assumption discharges them.

Owned implementation starts in `CentralChi4.lean` for the exact character and partial sums.
`run_lean.py` runs only direct installed Lean against immutable cached dependencies. Exploratory
probe failures and import-loading times are not successful pilot timings.
