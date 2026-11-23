# Finite totient route: independent source review

Reviewed against target commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. This is a research review, not a Lean validation. No compiler was launched and no Lean source or build artifact was changed. File hashes and an independent integer calculation are recorded in `GLOBAL_TOTIENT_FINITE_EVIDENCE.json` beside this report.

## Verdict

The finite claim in `agents/independent-feasibility/GLOBAL_TOTIENT_ROUTE.md` is mathematically sound. For every natural `q` with `1 ≤ q ≤ 2^1000` and every real `r` with `3 ≤ r` and `q ≤ r`, the existing exchange argument and finite Mertens-product certificate suffice to prove

`q / φ(q) < exp(γ) log(log r) + 2.50637 / log(log r)`.

There is **no upper bound on r**. The finite certificate bounds the largest prime in the comparison primorial, not every prime factor of q and not r. The proposed restriction on q is an explicit domain restriction; it is not a new unproved analytic hypothesis.

An additional 303-prime product certificate is unnecessary. The existing `MertProd.inv_2000` already provides both the required Mertens inequality through 2000 and a lower bound on the logarithm of that primorial. Thus the mathematical finite certificate can stop after the first two `MertProd` walk blocks. Its Euler-constant input still uses `RamPf.inv_20000`; the claim is not that only two finite computations occur in the entire dependency tree.

## Finite cutoff, checked independently

Write `P = q.primeFactors`, `k = P.card`, and, for `k ≥ 4`, `x = Nat.nth Nat.Prime (k - 1)`. The source `Prelim.exch` supplies

1. `q/φ(q) ≤ ∏_{i<k} p_i/(p_i-1)`, after `div_totient_eq_prod`;
2. `∏_{i<k} p_i ≤ ∏_{p∈P} p ≤ q`, with the final inequality from `Nat.prod_primeFactors_dvd q` and `q ≥ 1`.

If `x ≥ 2000`, every prime at most 2000 lies among those first k primes. Positivity of the remaining integer factors gives

`∏_{p≤2000, prime} p ≤ ∏_{i<k} p_i ≤ q ≤ 2^1000`.

This contradicts the finite lower bound below. Consequently `x < 2000`, and in particular `x ≤ 2000`. Since `k ≥ 4`, source arithmetic gives `x ≥ 7`, so the certificate's `5 ≤ x` premise holds.

Independent trial division over integers 2 through 2000 found 303 primes, last prime 1999. Their product has bit length 2799, hence is greater than `2^1000`. This confirms the proposed numerical claim, but that Python calculation is not offered as a Lean proof.

### Reuse an existing certificate instead

`SmallMertensProd.lean:609`, `MertProd.inv_2000`, is an invariant at 2000. Definition `Inv` at line 304 has the third conjunct

`s.Tlo ≤ 10^30 * th 2000`.

Here `s.Tlo = 1939839200302529137722656397952172`, so the existing invariant implies `th 2000 > 1000`. By its definition, `th 2000` is the sum of `log p` over primes in `Icc 1 2000`. Using `Real.log_prod` and prime positivity identifies it with the logarithm of the positive primorial. On the other hand,

`log ((2 : ℝ)^1000) = 1000 * log 2 < 1000`.

Strict monotonicity of log proves the required primorial bound; cast it back to naturals if following the source integer-product proof. This needs only elementary log facts and exact arithmetic after projecting `inv_2000.2.2.1`.

The final conjunct of the same invariant is `∀ x, 5 ≤ x → x ≤ 2000 → x.Prime → Claim x`. Projecting `inv_2000.2.2.2.2.2.2.2.2` therefore supplies the desired product inequality at x. `Claim` is defined at line 262. The exported `mertens_product_kernel` at line 710 performs exactly this projection from `inv_100000`; the smaller projection preserves its mathematical statement on the restricted range.

## Exact source interfaces to reuse

All locations are under `work/ternary-goldbach/TernaryGoldbach/Prelim`.

| Declaration | Location | Role and assumptions |
|---|---|---|
| `Prelim.div_totient_eq_prod` | `MertensProduct.lean:2129` | Product identity; only `1 ≤ q`. |
| `Prelim.frac_anti` | `MertensProduct.lean:2148` | Exchange-factor monotonicity; `2 ≤ b ≤ a`. |
| `Prelim.exch` | `MertensProduct.lean:2156` | Two comparison inequalities for a finite set of primes. |
| `Prelim.image_nth` | `MertensProduct.lean:2203` | First k primes equal primes through the kth prime; `1 ≤ k`. |
| `Prelim.exp_gamma_ge` | `MertensProduct.lean:2230` | `1.625 ≤ exp γ`; Mathlib Euler-constant bound and quadratic Taylor bound. |
| `Prelim.bigF_gt` | `MertensProduct.lean:2236` | `3.75 < exp γ loglog r + 2.50637/loglog r`; only `3 ≤ r`. |
| `MertProd.inv_2000` | `SmallMertensProd.lean:609` | Both finite product inequality and primorial-size certificate. No extra premises. |
| `MertProd.mertens_product_kernel` | `SmallMertensProd.lean:710` | Alternative ready-made product theorem for prime `5 ≤ x ≤ 10^5`; no `Fact PlattGRH`. |

`Prelim.div_totient_lt` at `MertensProduct.lean:2258` is the proof template, **not a permissible call** for the unconditional restricted theorem. It is explicitly under `variable [Fact TernaryGoldbach.PlattGRH] in` at line 2255. Likewise `F_all` at line 2220 has that binder at line 2219. In the template, the sole analytic bridge to replace is the call to `F_all`: prove `x < 2000` and use the finite certificate instead.

For `k ≤ 3`, the template's product is at most `2 * (3/2) * (5/4) = 3.75`, and `bigF_gt` finishes for every `r ≥ 3`.

For `k ≥ 4`, retain the source steps unchanged mathematically: identify `θ(x)` with the logarithm of the comparison primorial; prove `θ(x) ≤ log r` from its product bound; prove `θ(x) ≥ log 210 ≥ 4`; and use monotonicity of `G t + 2.50637/t` for `t ≥ 1.386`, where `G = exp γ ≥ 1.625`. In particular the monotonicity argument is on this safe interval, not a false assertion of monotonicity on all positive t.

## Transitive finite-certificate dependency review

The complete project import chain of `SmallMertensProd` is

`SmallMertensProd → RamareWalk → LogWalk → RamareHarm → Mathlib`.

The four project files contain no `PlattGRH`, `axiom`, `sorry`, `admit`, or `native_decide` token after removing comments. Neither `Statement` nor any project prime-estimate module is in this import chain. There is therefore no route in this project closure for an implicit Platt assumption to enter the finite kernel.

The relevant proof path is explicit:

- `MertProd.inv_2000` uses `walkP_spec` (485), `inv_1000` (608), and `wk_2` (507). The preceding invariant uses `Inv_one` (500) and `wk_1` (506). The two walk equalities are proved by `decide +kernel`.
- `walkP_spec` uses invariant preservation `Inv_step`; its prime branch uses the checked finite arithmetic and `chk_claim` (331), with primality established by `isP_iff` (119). The logarithmic correction is justified by `q_bounds` (168), not assumed from floating-point output.
- `chk_claim` uses the lower exponential constant `Glo_le` (49). This uses an exact degree-21 Taylor lower sum and `gamma_bounds` (37).
- `gamma_bounds` uses `RamPf.harm_bounds` (`RamareHarm.lean:128`), the finite harmonic/log bounds in `RamPf.inv_20000` (`RamareWalk.lean:247`), and an elementary identification of the finite harmonic sum. `inv_20000` follows the walk certificates through `wk_22`, with `walkW_spec` at 186; these equalities also use `decide +kernel`.
- `RamPf.harm_bounds` derives its estimates by telescoping elementary logarithm inequalities and the Mathlib limit of the Euler–Mascheroni sequence. `LogWalk.incr_bounds` (62) uses the artanh expansion and a geometric tail.

The unchanged elementary `MertensProduct` declarations listed above also have no Platt binder or call to a conditional prime estimate. This file has many other conditional declarations; their presence in an imported environment does not by itself put their assumptions into the dependencies of an unrelated theorem. Conversely, one must not infer the full file is unconditional from these selected declarations.

### Axiom boundary and later validation gate

This source review establishes a Platt-free project proof path and exposes all project certificate inputs. It does **not** compute the kernel's transitive axiom set. The expected acceptable root set is the usual logical axioms (`propext`, `Classical.choice`, `Quot.sound`, as actually needed), but exact equality to that set has not been verified here. Imported Mathlib declarations and tactic-produced terms still require the normal kernel audit.

When compilation is authorized, validate the exact new restricted theorem's type and `#print axioms`, then inspect the corresponding outputs for `MertProd.inv_2000`, `MertProd.mertens_product_kernel`, `MertProd.gamma_bounds`, and `RamPf.inv_20000`. Reject any residual Platt binder, `sorryAx`, unexpected axiom, or compiled-source mismatch. No success is claimed in this report before those checks.

## Integration consequence

The finite half does not need the conditional `F_mid`, `F_large`, or any new Rosser–Schoenfeld theorem. It is compatible with the separate remote-tail plan in `GLOBAL_TOTIENT_TAIL.md`; that plan must still justify its own tail envelope and every consumer of the changed envelope. The finite result alone does not establish the unrestricted source `div_totient_lt` or finish the no-Platt Type I/II theorem.

At the declaration-dependency level, two MertProd blocks suffice. At the current file-build level, importing `SmallMertensProd` still compiles its whole file and importing `MertensProduct` still brings its current imports. A future source-preserving extraction could reduce that build cost, but no such extraction was made or validated in this research task.
