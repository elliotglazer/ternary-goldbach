# Existing nonprincipal L-function bound for the conductor-101 outer disk

2026-11-11. Source inspection and exact paper specialization only. No new Lean theorem, Lean build, numerical L-value certificate, or transitive axiom audit is claimed. The usable bound was sent to the active evaluator worker immediately.

## Direct existing theorem and exact numerical bound

The pinned target source already supplies the required growth theorem in `TernaryGoldbach/Explicit/LGrowth.lean:179`:

    {q : Nat} [NeZero q]
    {chi : DirichletCharacter Complex q}
    chi != 1 -> 0 < Re(s) ->
    norm(chi.LFunction(s)) <= (q+1)*norm(s)/Re(s).

The actual declaration is `TernaryGoldbach.Explicit.norm_LFunction_le`. It requires nonprincipality and a positive modulus, but **not primitivity, GRH, a finite zero assertion, or s!=1**.

For q=101, z0=111/200+1000*I and every s in the closed disk of radius1/2 about z0,

    Re(s) >= 111/200-1/2 = 11/200 > 0,
    norm(s) <= norm(z0)+1/2
            <= 1000+111/200+1/2 = 200211/200.

Consequently the following integer is a valid uniform outer bound for every actual nonprincipal character modulo101:

    M = 102*(200211/200)/(11/200) = 1856502.

This is a bound for the **uncompleted L-function itself**. It is not automatically a bound for a completed L-function or for `(s-1)*L(s,chi)`. No claim of nonvanishing follows from an upper bound.

More generally, for a>R>=0 and real T, the same source theorem gives the disk bound

    (q+1)*(abs(T)+abs(a)+R)/(a-R)

on `closedBall(a+I*T,R)`. The enclosing disk may contain s=1 when the character is nonprincipal; the theorem and analyticity still apply.

## Actual function, convergence and continuation

Mathlib's `DirichletCharacter.LFunction` is the continued function, defined at `NumberTheory/LSeries/DirichletContinuation.lean:60` through `ZMod.LFunction`. The latter, at `LSeries/ZMod.lean:85`, is

    q^(-s) * sum_(j : ZMod q) chi(j)*hurwitzZeta(toAddCircle(j),s).

`DirichletCharacter.LFunction_eq_LSeries:74` identifies it with the ordinary LSeries only for Re(s)>1. `differentiable_LFunction:97` proves it is entire when chi!=1. At s=1, the underlying `ZMod.differentiableAt_LFunction` proof cancels the common Hurwitz pole using the exact sum of the character over the modulus being zero. Thus the statement includes the source's actual value at the removable singularity, not an unchecked limiting convention.

The target `LGrowth.lean` provides the complete positive-half-plane argument:

| Lines | Existing result and role |
|---|---|
| 24–47 | Complete-period character sums vanish, including shifted periods. |
| 49–57 | `norm_sum_range_le`: the partial sum over `range n` has norm<=q. |
| 60–71 | `psum` sums over `Icc 1 n`; `norm_psum_le` bounds it by q+1. |
| 83–104 | `Iint` and `integrableOn_integrand` establish the Abel integral on Re(s)>0. |
| 106–154 | Local dominated differentiation proves that s*Iint is analytic on that half-plane. |
| 156–176 | `LFunction_eq_mul_Iint` identifies actual continued L with the integral. |
| 179–197 | Integration of `(q+1)*t^(-Re(s)-1)` gives the stated norm bound. |

The identity is

    chi.LFunction(s) = s * integral_(1,infinity)
      psum(chi,floor(t))*t^(-(s+1)) dt.

The proof first uses Mathlib `LSeries_eq_mul_integral` on Re(s)>1, where LSeriesSummable is available. It then applies the identity theorem on the connected open half-plane Re(s)>0. The integral is absolutely convergent there because psum is bounded. This is not a claim that Mathlib's unordered naive LSeries converges at Re(s)=.305 or .055. Using `LFunction_eq_LSeries` at those samples would violate its hypothesis.

All parameter and integral domains match the requested application. Positive real integration variables make the complex-power norm exactly `t^(-(Re(s)+1))`; no imaginary-height exponential factor is missing. Nonprincipality is a genuine obligation for the concrete experimental character, not a consequence of labeling its table “nonprincipal.” For q=101 the modulus positivity premise is elementary. This growth theorem does not need its primality or primitive-character status.

## Domain hazards for the Cauchy experiment

At center real part.555, the radius1/4 sampling circle reaches real part.305=61/200. The radius1/2 outer disk reaches.055=11/200. A coefficient or Euler–Maclaurin remainder proved only for sigma>=.555 cannot be reused unchanged on either region.

The source M above directly supports a discrete Cauchy model whose sample balls enclose the **actual** L-function on the sampling circle. Sample evaluation errors must be valid for sigma>=.305, or for a proved lower bound at each actual sample. The outer Cauchy bound is valid over the entire closed disk at sigma>=.055.

If the model instead Taylor-expands a finite Euler–Maclaurin approximation g, a bound for actual L is not by itself a bound for g. One must either derive a direct outer bound for g or add an approximation error valid on the entire outer disk to M. This separates coefficient-domain soundness from the growth estimate and prevents silently applying an inner-domain remainder on the outer disk.

## Optional q improvement, not needed for the experiment

For modulus101, Mathlib `DirichletCharacter.map_zero'` (`Basic.lean:216`) gives chi(0)=0 because101!=1. Therefore psum(chi,n) equals the range(n+1) sum, whose existing bound is101. Repeating only the final integral estimate would give101*norm(s)/Re(s), and the disk integer1838301. This is a straightforward paper corollary, **not** the currently exported `norm_LFunction_le` statement. The already-source-backed1856502 bound avoids needing that extra lemma and is sufficient for the current experiment.

## Pins and proof status

Target source pin: `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Mathlib pin: `56a005855ea17e0b0958f73ec801ae140b0a1679`, read from the previously verified local cache.

| Source | SHA256 |
|---|---|
| `Explicit/LGrowth.lean` | `5e6bd327045a95842498dd35da4d4ca476d7df37275ea612cd4fa46d2273c341` |
| Mathlib `NumberTheory/LSeries/DirichletContinuation.lean` | `ecf79f2a64ef2e7215729ebb2e7d5adaa03468b18bbda0040680aa925d4673f1` |
| Mathlib `NumberTheory/LSeries/ZMod.lean` | `d756abe5cb941f1210dc7ddddc90f68f120148bb6a45ac4e6c4282c3070fbc17d` |

The target theorem's stated type and inspected proof have no PlattGRH binder. This read-only inspection is not a fresh compiled transitive-axiom certificate. The remaining application work is to construct and identify the actual nonprincipal character, prove the evaluator's identity and sample enclosures on the correct domain, consume the source theorem, and formally verify the Cauchy model if it is used in the final proof. No new analytic growth theorem is needed for this disk.
