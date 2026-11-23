# Minor-arc replacement interfaces

Research-only source map, 2026-11-10. Target source is `work/ternary-goldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Paths below are relative to `TernaryGoldbach/`. No compiler was launched and no Lean source or build artifact was changed for this task. Claims of unconditionality below concern the inspected source interfaces and proof dependencies. They still require final kernel and transitive axiom audits.

## Results needed by MinorTotal

The two requested inputs are traced in detail, with the neighboring off-arc branch recorded below. Removing the energy and basegap dependencies does not remove the separate Platt dependencies of `I0_ge`, `norm_sq_sum_a₂_le`, `norm_S_etaStar_le_ghat`, or `thm_13_2_1_repaired`. The last has a local Fact binder in `MinorArcs/Thm1321.lean:146` and calls `LargeSieveProof.cor_12_2_5` at line 378, which also has a local Fact binder and calls `prop_12_2_4`.

| Consumer | Exact needed result | Current route |
|---|---|---|
| `MinorArcs/MinorTotal.lean:216 T_le` | For real `x ≥ 4.9e26`, `∑' n, ‖a₁ x n‖² ≤ sig x * x` | `PartIICited.prop_7_1_5 → MajorArcs.prop_7_1_5' → prop_9_5_1` |
| `MinorArcs/MinorTotal.lean:394 hv₀`, inside `minor_total` | Outside `majorArcs 8 150000 x`, `‖S etaStar x α‖ ≤ (x/κ)*ghatY (x/κ) 150000` | Off the larger arcs, Platt-dependent `norm_S_etaStar_le_ghat`. In the gap, Platt-dependent `BaseGap2.norm_S_etaStar_le_gap` and the elementary `ghatY_r0_ge` |

Here `κ = 49`, `r₀ = 150000`,
`a₁ x n = if n.Prime ∧ √x < n then ((Λ n * etaPlus (n/x) : ℝ) : ℂ) else 0`,
and
`sig x = (0.640208 + 366.91/√x)*log x - 0.021095`.

The declarations in `PartIICited.lean` inherit the file-level `variable [Fact TernaryGoldbach.PlattGRH]` at line 6. The other relevant Fact binders are local `variable ... in` commands immediately before their named theorem.

## Weighted etaPlus energy

### Exact binder chain

1. `MinorTotal.lean:216 T_le {x : ℝ} (hx : 4.9e26 ≤ x)` has a local Platt Fact binder at line 215. Its only conditional imported result is `prop_7_1_5 hx`.
2. `PartIICited.lean:55 prop_7_1_5 {x : ℝ} (hx : 4.9e26 ≤ x)` has the inherited Fact binder and delegates directly to `MajorArcs.prop_7_1_5' hx`.
3. `MajorArcs/Prop715.lean:356 prop_7_1_5'` has the local Fact binder at line 353. Its exact conclusion is
   ```lean
   ∃ E₂ : ℝ, |E₂| ≤ 2e-6 + 366.91 / √x ∧
     ∑' n : ℕ, Λ n * Real.log n * etaPlus (n / x) ^ 2 =
       0.640206 * x * Real.log x - 0.021095 * x +
       E₂ * x * Real.log x
   ```
   The direct Platt use is line 365, `platt_odd (q := 1) odd_one ... 1 isPrimitive_one_level_one`, weakened to height 500 by `.mono`.
4. `Prop715.lean:299 prop_9_5_1 {x} (hx : 4.9e26 ≤ x) (hG : GRHUpTo (1 : DirichletCharacter ℂ 1) 500)` has no Fact binder. It proves
   `|S - x*I| ≤ 1e-8*(x*log x)`,
   where `S = ∑' n, Λ n*log n*etaPlus(n/x)^2` and
   `I = ∫ t in Ioi 0, etaPlus t^2*log(x*t)`.
   Its explicit GRH argument is a real remaining mathematical hypothesis.
5. `Prop715.lean:230 err_phi1_le` and `:255 err_phi2_le` take `hx : 4.9e26 ≤ x` and
   ```lean
   hRH : ∀ ρ : ℂ, riemannZeta ρ = 0 →
     0 < ρ.re → ρ.re < 1 → |ρ.im| ≤ 500 → ρ.re = 1 / 2
   ```
   They conclude respectively
   `‖SsumG 1 phi1 x - mellin phi1 1*x‖ ≤ 2.7e-9*x` and
   `‖SsumG 1 phi2 x - mellin phi2 1*x‖ ≤ 4.1e-9*x`.
6. These call `Explicit/EtaPlusSqBound.lean:277 norm_SsumG_phi1_le` and `:294 norm_SsumG_phi2_le`, each with `x ≥ 1` and the same explicit RH500 argument. Both call `norm_SsumG_zeta_le_gen`. Their smoothing, Plancherel, Mellin tail and vertical-line inputs are source-proved without a Platt Fact. Replacing RH by a strip bound requires replacing the low-zero estimate in the general formula, rather than passing QRH to these unchanged binders.

### Unconditional reusable components

- `Prop715.lean:23–228` gives the log estimates and numerical bounds `ZLz500_le`, `Z3z500_le`, `Z3z0_le`, `E1z500_le`, `E2z500_le`, `VgL400_le`, `err_rel`. No Platt binder or call is present in this range.
- `prop_9_5_1` contains exact algebraic identities `hA`, `hI` and `key`, splitting with `log n = log x + log(n/x)`. These identities do not consume RH.
- The same proof obtains `hs1` and `hs2` from unconditional `Explicit.summable_SsumG` applied to `goodSmoothing_phi1` and `goodSmoothing_phi2`.
- `MajorArcs/EtaPlusSqLog.lean:877 integral_etaPlus_sq_log_eq` assumes only `0 < x`.
- `EtaPlusSqLog.lean:889 integral_etaPlus_sq_log` assumes only `1 ≤ x` and gives
  `|I - (0.640206*log x - 0.021095)| ≤ 1.95e-6*log x + 5.3e-7`.
  It uses its earlier etaO numerical and integrability results, not Platt.
- `MinorTotal.lean:99 summable_a₁`, `:107 primeSupported_a₁` and the pointwise comparison inside `T_le` are unconditional. For prime terms the comparison is equality via `vonMangoldt_apply_prime`; all other terms are bounded by nonnegativity.

### Smaller replacement target

The direct target is the existing statement of `T_le` without its Fact binder. One useful intermediate target is simply

`S ≤ ((0.640208 + 366.91/√x)*log x - 0.021095)*x`

together with explicit summability of its summand. The original existential `E₂` equality and lower error estimate are unnecessary.

Summability must not be omitted because Lean's `tsum` is zero for nonsummable functions. The current `T_le` proves it indirectly by showing its equality's right side is positive. A replacement should derive it directly from `hs1`, `hs2` and the same pointwise log identity, converting the complex sum back to the real sum. Then `Summable.tsum_le_tsum` proves the prime-restricted bound.

Using the existing integral estimate, it is sufficient to prove the one-sided residual inequality

`S - x*I ≤ x*((5e-8 + 366.91/√x)*log x - 5.3e-7)`.

This is exact algebra, since `0.640208 - 0.640206 - 1.95e-6 = 5e-8`. It allows a larger residual than the present `2.7e-9*log x + 4.1e-9` bound. A still more direct sieve or prime-sum proof of the restricted `a₁` energy would avoid the auxiliary phi2 formula entirely, but no such proof is claimed here.

### Summability and positivity at every energy consumer

There are exactly two uses of `T_le` in the source, both inside `MinorTotal.minor_total`, at lines 415 and 433. The first supplies `hT`, and line 416 proves `0 ≤ T` independently with `tsum_nonneg`. The second derives `0 ≤ sig x` from `hT`, nonnegativity of T, and `x > 0`. No strict `0 < T` hypothesis is needed. The base term at line 445 multiplies `hT` by `cL 150000 / Dx x ≥ 0`; the interior terms at line 480 multiply it by `log((n+1)/n)/Dx x ≥ 0`; the endpoint at line 489 multiplies it by `1-cL(r₂-1)/Dx x ≥ 0`. These checks cover every use of the energy upper bound in that proof.

The earlier call to `Thm1321.thm_13_2_1_repaired` at line 410 receives `primeSupported_a₁ hx0`, which includes `Summable (fun n => ‖a₁ x n‖)`. Its general coefficient sequence may be zero. Its downstream `LargeSieveProof.cor_12_2_5` also takes `PrimeSupported x a` and has no `T > 0` assumption. Thus the minimal new analytic interface can be the direct upper bound for the existing `a₁` sequence, preserving `summable_a₁` and the standard derived square summability. A lower bound on T would be an unnecessary extra obligation for this replacement. The existing positive lower major-energy theorem is a separate input through `I0_ge`.

For the proposed `T ≤ 0.65*x*log x` route, define or thread the complete majorant `sigmaNew x = 0.65*log x`, replace the corresponding `Mexpr` numerics, and derive its nonnegativity directly from `x ≥ 4.9e26` or by the same T argument. The energy theorem must refer to the actual `a₁` coefficients. If the proof instead passes through the full weighted sum S, its summability must be supplied as described above. The parent reports proposed actual-smoothing kernel bounds 172 and 566 from the Mellin worker; this map does not treat those bounds as proved or as new hypotheses of the public target.

### Numerical tolerance downstream

`MinorTotal.lean:78 Mexpr` is affine in `sig x`. For fixed admissible `r₂`, its coefficient is

```text
A(x,r₂) =
  ghatY(y,150000)*cL(150000)/Dx(x)
  + sum_{150000<n<r₂} ghatY(y,n)*log((n+1)/n)/Dx(x)
  + ghatY(y,r₂)*(1-cL(r₂-1)/Dx(x)),
y=x/49.
```

The `NumericsGoal` assumptions include `cL(r₂-1) ≤ Dx x`; together with the existing positivity facts they make this coefficient nonnegative. An increase `Δsig` costs exactly `A*Δsig` in `Mexpr`. Thus a relaxed energy theorem requires a new numerical certificate. It cannot be inserted while retaining the old `Mexpr ≤ 1.037` proof automatically.

The numerical worker subsequently completed an exact-rational source-envelope calculation in `../major-constants/MINOR_ENERGY_TOLERANCE.md`. It recommends the weaker analytic target `T(x) ≤ 0.65*x*log x`, even without the negative offset. With the offset retained, its reported cap is approximately `0.6527044168960991`; without it, approximately `0.6523618655463307`. These are research numerical certificates requiring independent review and Lean integration. They are not the present statement of `T_le`, and retaining any square-root correction consumes part of the quoted total coefficient. This offers a substantially simpler analytic target if the parent adopts the corresponding numerical update.

## etaStar base gap

### Exact final interface and geometry

`MinorArcs/BaseGap2.lean:243 norm_S_etaStar_le_gap` has a local Platt Fact binder at line 240 and otherwise exactly

```lean
{x α : ℝ} (hx : 4.9e26 ≤ x)
(h1 : α ∈ majorArcs8 r₀ (x / κ))
(h2 : α ∉ majorArcs8 r₀ x) :
‖S etaStar x α‖ ≤ 0.0121 * (x / κ)
```

Set `y=x/49 ≥ 1e25`. The unconditional `gap_point` at line 185 supplies integers `1 ≤ q ≤ 300000`, `a : ℤ`, `IsCoprime a (q:ℤ)`, and `δ=(α-a/q)*y` with

`600000/(49*q) ≤ |δ| < 1200000/q`.

The unconditional `S_etaStar_eq_expTsum` at line 229 identifies the original sum with coefficients `c n = ((Λ n*etaU(n/y):ℝ):ℂ)`.

### The two conditional edges

**Character estimate.** The proof calls `PartIICited.lean:45 cor_7_1_3`, whose inherited Fact delegates to `MajorArcs/Cor713.lean:807 cor_7_1_3'`. The latter has a local Fact binder at line 802, and its sole direct Platt use at line 827 is `platt_grh hq χ hχ`.

The exact interface is
```lean
{y : ℝ} (hy : 1e25 ≤ y) {q : ℕ} [NeZero q]
(hq : q ≤ 300000) (χ : DirichletCharacter ℂ q)
(hχ : χ.IsPrimitive) {δ : ℝ} (hδ : |δ| ≤ 4*300000/q) :
‖Schar χ (fun n => ((Λ n*etaU(n/y):ℝ):ℂ)) (δ/y)
  - (if q=1 then Fourier(etaU)(-δ)*y else 0)‖
≤ (1e-17 + 4.7e6/√q/√y)*y
```
Here `Fourier(etaU)` abbreviates exactly `𝓕 (fun u => (etaU u : ℂ))`.

Its lower-level `MajorArcs/Cor933.lean:490 cor_9_3_3` has no Fact binder and takes `x ≥ 4`, real `δ`, modulus `q` with `NeZero q`, primitive `χ`, `T0 ≥ max(10π|δ|,50)`, and explicit `GRHUpTo χ T0`. It concludes the same residual is at most `err933N q T0 δ x*x`. It averages `Prop932.prop_9_3_2`, whose corresponding explicit GRH binder is at lines 93–94. The numerical simplifications in Cor713 before its final theorem, including the q=1 and q≥2 cases, have no Fact binder. Their estimates do not by themselves remove the GRH argument.

BaseGap2 applies the character estimate to `ψ⁻¹.primitiveCharacter` at its conductor `d | q`, so `1 ≤ d ≤ q ≤ 300000`. The δ-domain is widened using `d ≤ q`, and the conductor-sensitive error is weakened to the uniform `E₁=1e-17+4.7e6/√y`. This discard is an available improvement point.

**Totient estimate.** A separate call to `Prelim/MertensProduct.lean:2258 div_totient_lt` has a local Fact binder at line 2255. It takes `1 ≤ q`, `3 ≤ r`, `q ≤ r` and proves
`q/φ(q) < exp(γ)*log(log r)+2.50637/log(log r)`.
The proof uses conditional `F_all` at line 2220. BaseGap2 sets `r=300000` and combines this with its unconditional `Fr_300000_le` to obtain `q/φ(q)<5.53`.
Thus removing only the character estimate's Fact still leaves a Platt dependency.

For this finite range, the global Mertens theorem is unnecessary. The unconditional `MertensProduct.div_totient_eq_prod` at line 2129 and `exch` at line 2156 give the fraction product bound and minimal prime product. Since
`2*3*5*7*11*13*17=510510>300000`,
there are at most six distinct prime divisors. Consequently
`q/φ(q) ≤ 2*3/2*5/4*7/6*11/10*13/12 = 30030/5760 < 5.214 < 5.53`.
This is a proposed finite Lean lemma, not a compiled result.

### Unconditional reusable transfer

Everything in BaseGap2 before the final Fact binder is source-proved without Platt. This includes `abs_etaU_le_const`, `abs_etaU_le_gauss`, `cube_mul_exp_le`, `sum_noncoprime_le`, `Fr_300000_le`, `fourier_const_le`, `gap_point`, and `S_etaStar_eq_expTsum`.

`MinorArcs/BaseGap.lean:93 norm_expTsum_le_of_chars` is also unconditional, with full binders

```text
{q : Nat} [NeZero q] {c : Nat -> Complex}
hc : Summable (fun n => norm(c n))
β : Real
{b : ZMod q}, hb : IsUnit b
{M : Complex} {E D : Real}
hD : tsum norm(c n - coprimePart q c n) ≤ D
hchar : for all ψ : DirichletCharacter Complex q,
  norm(Schar ψ⁻¹.primitiveCharacter c β - (if ψ=1 then M else 0)) ≤ E
```

It concludes
`‖expTsum c (b.val/q+β)‖ ≤ D + ‖M‖/φ(q) + √q*(E+D)`.
Its proof uses unconditional character expansion, Gauss-sum bounds, primitive reduction and norm estimates. Both E and D nonnegativity are derived, not extra assumptions.

In the final application,
`K=ceil(2*log y/log 2)+1`,
`D=6.2*K*log q+1 ≤ 2e-9*y`,
`E=E₁*y ≤ 1.4874e-6*y`,
`√q ≤ 548`,
and
`‖M‖/φ(q) ≤ 0.01125*y`.

The last displayed main bound uses only the δ² Fourier decay
`‖Fourier(etaU)(-δ)‖ ≤ 1.016/δ²`.
The arithmetic then gives
`0.01125+548*(1.4874e-6+2e-9)+2e-9 = 0.0120661932 < 0.0121`.

### Smaller replacement targets

The consumer needs only the final norm bound in the gap, or even its weaker form with coefficient `ghatY y 150000`. It needs no etaStar asymptotic equality and no uniform theorem outside this gap.

Three compatible simplifications remain available.

1. Prove the required bound only at the reduced characters, conductors and δ produced by the gap geometry. Preserve the `1/√d` dependence when useful.
2. Replace global Mertens by the finite six-prime product argument above.
3. Sharpen the Fourier main term using both a uniform Fourier bound and the existing δ²-decay. The zero-sum worker is developing that option. It can materially enlarge the admissible residual budget.

For a proposed normalized uniform residual `e(y)` and normalized main estimate `m(y,q,δ)`, the exact sufficient inequality through the current transfer is
`m + √q*e + (1+√q)*D/y ≤ 0.0121`.
An averaged character-residual estimate could avoid the uniform `√q*e` loss, but it must be proved for the actual Gauss-weighted sum. Merely introducing such an estimate as a hypothesis would not discharge the minor bound.

The current consumer uses `MinorTotal.lean:206 ghatY_r0_ge`, whose lower bound is only `0.0121 ≤ ghatY y 150000`. A larger gap constant therefore requires a new comparison or revised numerical decomposition. It is not automatically absorbed by slack elsewhere.

## Separate off-larger-arcs branch, corrected classification

An earlier version of the opening table incorrectly called `norm_S_etaStar_le_ghat` unconditional. The actual source has `variable [Fact TernaryGoldbach.PlattGRH] in` at `MinorArcs/LinftyLevels.lean:355`, immediately before the theorem at line 358. It remains a distinct replacement obligation after the basegap estimate is repaired.

Its complete explicit interface, in addition to the Fact instance, is

```text
{x n α : Real}
hx   : 0 < x
hy   : 1e25 ≤ x/κ
hn   : 670 ≤ n
hny  : n ≤ (x/κ)^(1/3)/6
hny' : 2.16e20*n ≤ 670*(x/κ)
hα   : α ∉ majorArcs 8 n (x/κ)
conclusion : norm(S etaStar x α) ≤ (x/κ)*ghatY (x/κ) n.
```

The direct dependency graph is as follows. The displayed Type I/II nodes are an explicit conditional frontier, not discharged leaves.

```text
MinorTotal.minor_total
  hv₀, off larger arcs; and hvn, every higher level
    LinftyLevels.norm_S_etaStar_le_ghat :358 [Fact]
      Prop1123b.norm_S_eta2_le_of_not_mem :107 [Fact, module :5]
        small q
          GBound.norm_S_eta2_le_gx :52 [Fact, module :4]
            PointwiseBound.theorem_3_1_1 :65 [Fact, module :4]
              FirstChoiceFinal.theorem_3_1_1_first :33 [Fact, module :4]
                FirstChoiceTypeI1.typeI1_first :227 [local Fact :223]
                FirstChoiceTypeI2c.typeI2_first :16 [Fact, module :3]
                FirstChoiceTypeII.typeII_first :329 [local Fact :325]
              SecondFinal.theorem_3_1_1_second :58 [Fact, module :7]
                SecondTypeI2.typeI_second :521 [local Fact :519]
                SecondFinal.typeII_second :41 [module Fact]
                SecondBridge.bridge_le :212 [local Fact :210]
                  FirstChoiceFinal.theorem_3_1_1_first
            Prelim.MertensProduct.div_totient_lt :2258 [local Fact :2255]
        large q
          PointwiseBound.theorem_3_1_1, second component
```

For the small-q branch, the final use of `theorem_3_1_1` projects its first component, but the present bundled theorem's proof constructs both components. A future split could avoid carrying the unused second branch into this particular call. The overall off-arcs theorem still uses the second component when the fresh approximation has large q.

`typeI1_first` calls `typeI1_le` and the Möbius bounds used in its numerical simplification. `typeI2_first` calls `typeI2_le_small` or `typeI2_le_large`, plus its parameter bounds. `typeII_first` calls the conditional general Type II estimates, including `TypeIITotalGen.typeII_640:504`; that file has a module-level Fact at line 3 and also exposes conditional `typeII_gen:313`. The second-choice theorem combines `typeI_second`, `typeII_second`, and the first-choice bridge. These are the existing Type I/II and prime/Möbius-estimate replacement workstreams, rather than consequences of the new etaStar gap bound.

The additional `div_totient_lt` call in `GBound` is made at variable `r=max(1,|δ|/8)*q`, with `3 ≤ r` and `q ≤ r`. There is no uniform `q ≤ 300000` bound here: the approximation scale grows with x. The finite six-prime replacement proposed for BaseGap2 therefore does not discharge this global totient edge. A replacement of the global totient estimate, or an altered off-arcs majorant with replayed numerics, is needed.

The unconditioned analytic transport should be kept separate from this pointwise input. `LinftyLevels.norm_S_etaStar_le_of_pointwise_Ici` occurs before the local Fact binder. `Prop1123b.norm_S_etaStar_le_of_pointwise:35` explicitly uses `omit [Fact TernaryGoldbach.PlattGRH] in` at line 32. Their integrability, convolution, and elementary envelope arguments can be reused, but they do not prove the missing pointwise Type I/II estimates.

## Recheck of the other unconditional source claims

The following binder scopes were re-read after correcting the off-arcs classification. This is a source audit, not a substitute for `#print axioms` after compilation.

| Claim in this map | Rechecked source evidence |
|---|---|
| `Prop715` numerical lemmas, algebraic identities and integral conversions | Its only Platt variable command is the local one at line 353 before `prop_7_1_5'`. The two error lemmas still explicitly require RH500 as recorded above. |
| `Cor713` numerical simplifications | Its only Platt variable command is the local one at line 802. The final theorem at 807 remains conditional. |
| `EtaPlusSqBound` smoothing/Plancherel/Mellin bounds | No Platt variable command in that file. Final `norm_SsumG_phi1_le` and `norm_SsumG_phi2_le` explicitly require RH500, so neither is being claimed as an unconditional prime-sum estimate. |
| `goodSmoothing_phi1`, `goodSmoothing_phi2`, `summable_SsumG` | `Explicit/EtaPlusSq.lean:382,396,415`, no Platt variable command. |
| `integral_etaPlus_sq_log` | `MajorArcs/EtaPlusSqLog.lean:889`, no Platt variable command. |
| `summable_a₁`, `primeSupported_a₁`, `ghatY_r0_ge` | `MinorTotal.lean:99,107,206`, outside its local Fact-bound declarations. `Helfgott/Decay.lean:247 summable_etaPlus` has no Platt variable command. |
| BaseGap2 lemmas before its final theorem | Its only Platt variable command is local at line 240. `Fr_300000_le` only bounds the explicit expression `Fr`; its use to bound q/totient is the separate conditional theorem. `SecondNumerics.lean:81 exp_gamma_le_sharp` has no Platt variable command. |
| `norm_expTsum_le_of_chars` | `MinorArcs/BaseGap.lean:93`, no Platt variable command in the file. |
| `norm_fourier_etaU_le` | `MinorArcs/EtaU.lean:52`, no Platt variable command in the file. |
| `div_totient_eq_prod`, `frac_anti`, `exch` | `Prelim/MertensProduct.lean:2129,2148,2156`; every Platt variable command in that file is local with `in`, and none binds these declarations. The local command at 2219 binds `F_all`; the one at 2255 binds `div_totient_lt`. |

No other incorrect unconditional label was found in this recheck. The source-level limitation remains explicit: complete transitive axiom validation has not been run.

## Validation and handoff

The exact upstream public interfaces, the two direct Platt supply points, the separate totient dependency, and the two consumer inequalities are mapped above. Independent kernel checks must later print types and transitive axioms for the replacement energy, finite totient, gap, and final minor-total declarations. In particular, importing a module containing conditional declarations does not itself introduce their Fact arguments, while calling the conditional wrappers does.

Findings were sent to the energy worker `mellin_strip`, gap worker `zero_sum`, and numerical-budget worker `major_constants`. No result in this chapter is a new checked Lean proof.

