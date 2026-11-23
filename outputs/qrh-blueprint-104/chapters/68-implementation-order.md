# Future implementation order: P2, P6, totient, and regionS

Research plan, 2026-11-11, against `work/ternary-goldbach` at `23b2d68ca344203d4384e0aff7affa4ec034bef9`, Lean 4.35.0 and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`. No Lean build, canonical edit, new theorem declaration, or new assumption was made. Proposed helper names/placements below are design choices, not frozen declarations. Existing research arguments remain paper results until their exact types, proof dependencies, and consumers pass validation.

The preferred order is: shared finite psi extraction; P2; its isolated consumers; P6; its isolated consumers; finite and coarse totient helpers; the separate regionS repair; then the larger pointwise-envelope propagation. P2 and P6 need no QRH provider. The totient repairs likewise use elementary arithmetic and existing finite certificates. None of these steps supplies the other prime/Mobius inputs or a major-arc residual estimate.

## 1. Shared finite psi extraction

Minimal placement is **inside `Prelim/LambdaMu.lean`, after `psiN` and its elementary identities, before the P2 proof at line 423**. This avoids a new module cycle: a helper module importing LambdaMu cannot then be imported by LambdaMu. A later source split is optional, not required for this proof repair.

Establish the following finite facts in the existing `TernaryGoldbach.Prelim` namespace, with their natural-number carriers explicit:

- For `12≤n<10^6`, `|psiN n-n|≤sqrt n`, by `SmallTab.small_table` and `PsiTwoSided.thS_add_ppS`. Do not call the conditional full-range `psi_two_sided`.
- For `n<10^6`, `psiN n≤1.03883*n`, treating zero separately, using `Small.psi_lt_small_700` for 1 through 700 and the preceding estimate for 701 onward.
- A carrier bridge between `psiN n` and Mathlib `Chebyshev.psi (n:ℝ)`, and between `thetaN n` and the existing Chebyshev theta. Check `Icc 1 n=Ioc 0 n`, natural floor casts, and the prime-filter endpoint. `ThetaExplicit.theta_eq:33` is already an unconditional theta bridge.

The finite proofs in `agents/moebius/FiniteBoundary.lean` are starting material, not checked imports. Keep the strict upper endpoint `10^6`. No existing full-range `psiN_le` declaration becomes unconditional as a consequence of these helpers.

## 2. P2: preserve the exact public theorem

The public name is **`TernaryGoldbach.Prelim.sum_vonMangoldt_div_le_log`**, `Prelim/LambdaMu.lean:535`. Its intended binder/conclusion after repair is exactly

```text
{x : ℝ} (hx : 1 ≤ x) :
  ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (Λ n : ℝ) / n ≤ Real.log x
```

The current local `variable [Fact TernaryGoldbach.PlattGRH] in` precedes it and the integer producer `sum_vonMangoldt_div_le_log_large:423`. Remove those two local binders only after replacing their proofs. Preserve the integer producer's original domain `30≤N`; do not narrow it to the new large branch.

Use the preferred compact proof in `prime-estimates/RESUME_PRIME_NEXT_2026-11-11.md`, not its older 10^9 fallback. Its independent review is `zero-sum/RESUME_P2_REVIEW_2026-11-11.md`, bound to note SHA256 `c6d0d0c844f3a01f3c37b217b9121baced0210cd75d2ceb250a07dde2ccd04eb`. The review explicitly checks this compact variant:

1. From Mathlib's `Chebyshev.psi_le` and `Real.log_div_sqrt_antitoneOn`, prove `psiN n≤1.43*n` for `500000≤n`. The actual Chebyshev estimate is `psi(t)≤log(4)t+2sqrt(t)log(t)` on `t≥1`. This is **not** the similarly named project `Helfgott.psi_le`, whose useful linear coefficient has a different domain. Check the antitone domain at the lower endpoint and the elementary bounds `log(500000)<14`, `sqrt(500000)>700`.
2. Factor the current finite factorial/Abel argument into an internal estimate whose psi uses are only `M=floor(N/2)` and `M<n<N`. One may parameterize this internal lemma by a proved upper bound on those arguments; it must be discharged internally before exporting P2. Existing `sum_log_le:362`, `abel_Ioc:384`, and `sum_inv_le_log:403` are unconditional.
3. For `30≤N<10^6`, use the finite `1.03883` helper at every such argument and retain the current numerical conclusion.
4. For `N≥10^6`, all those arguments are at least 500000. With `C=1.43`, the exact cancellation gives `R≤C*N*log 2+2C`. Use `log 2<.694` and `log N≤N/1000+6`; the final remainder is at most `-.00658N+9.86<0`. Do not separately bound the lower block before the Abel cancellation in a way that loses it.
5. Keep the real wrapper: `N=floor x≥1`, integer P2 for `N≥30`, otherwise `mertens_small` (covers through 100), followed by `log N≤log x`. At `N=10^6` the coarse branch applies. No new finite computation, P6, global sharp P1, or zeta estimate is required.

### P2 consumer edits and limits

All callers can retain their existing applications because the public conclusion is unchanged.

| Source consumer | Consequence after P2 | Remaining premise boundary |
|---|---|---|
| `MinorArcs/GcdSums.lean:151 sum_vonMangoldt_gcd_div_le` | Remove its local Fact binder after checking its proof. Its only conditional input is P2 at line 155; remaining terms use unconditional von Mangoldt divisor identities and `totient_mul_sum_vonMangoldt_div_le`. | Preserve `{q N:ℕ}`, `1≤q`, `1≤N` and the exact gcd-weighted conclusion. `sum_vonMangoldt_gcd_div_subset_le:191` is already unconditional and need not change. |
| `MinorArcs/TypeI2Proof.lean:244 sum_vonMangoldt_gcd_le` | Remove its local Fact binder after validating P2 plus the existing gcd/image argument. | Preserve `{q:ℕ}`, `1≤q`, `{V:ℝ}`, `1≤V` and floor endpoint. |
| `TypeI2Proof.lean:752` | P2 application is now unconditional. | The very next line uses P1 `sum_vonMangoldt_lt`; the enclosing production bound stays conditional. |
| `TypeI2Large.lean:82 sum_min_floor_le` proof | P2 call repaired. | The same proof uses P1, P3, and P4. The module-level Fact cannot be removed wholesale. |
| `Prelim/SchoenfeldTailAux.lean:37 Sch.sum_Lambda_div_Ioc` | Upper endpoint call at line 39 repaired. | It also uses conditional `mertens_lower_nat` at line 41 (P3 route). Retain its Fact. |

Audit transitive callers of the two newly unconditional gcd lemmas as a next step; do not infer that every theorem in their import closures loses its other hypotheses.

## 3. P6: preserve strictness, all real cutoffs, and the coefficient

The public name is **`TernaryGoldbach.Prelim.sum_vonMangoldt_nonprime_lt`**, `Prelim/LambdaMu.lean:761`. Preserve exactly

```text
{y : ℝ} (hy : 0 < y) :
  ∑ n ∈ Finset.Icc 1 ⌊y⌋₊,
    (if n.Prime then 0 else (Λ n : ℝ)) < 1.4262 * Real.sqrt y
```

Implement the independently reviewed `RESUME_PRIMES_2026-11-11.md` argument in this order:

1. Replace the conditional calls inside `nonprime_mid:678`, with its exact domain `10^6≤N<10^12`. Keep `nonprime_sum_le4:589`; all three root arguments are strictly below `10^6`. Use the shared finite helpers, the existing unconditional `log_le_div_e:671`, and the positive polynomial about `v=3.162`. Remove this theorem's local Fact. Its current docstring says `N≤10^12`; correct that documentation to the actual strict binder.
2. Remove the local Fact from `nonprime_small:751` after it uses the repaired middle theorem and `SmallNP.nonprime_small_kernel` on `1≤n≤10^6`. Preserve its exact exported domain `1≤n<10^12`.
3. Add an internal natural large-range proof for `N≥10^12`, using `nonprime_sum_le4`, `Helfgott.theta_le`, `ThetaExplicit.theta_eq` and unconditional `ThetaExplicit.pow_exp_anti:89`. The new coefficient is at most `1.412257<1.4262`. This replaces the old proof's call to **global** `psiN_le (Nat.sqrt N)`; the old `nonprime_final` alone is not a replacement for that input.
4. Retain the public floor split: floor zero, positive floor below `10^12`, and positive floor at least `10^12`. Preserve strictness before using `sqrt(floor y)≤sqrt y`. Only now remove the public local Fact binder.

The three root facts `nonprime_mid`, `nonprime_small`, and P6 must be audited individually. No P2 dependence is necessary, although implementing P2 first gives a smaller independently useful milestone.

### P6 consumer edits and limits

| Source consumer | Consequence after P6 | Remaining premise boundary |
|---|---|---|
| `MinorArcs/TypeIIReduction.lean:332 norm_IIsum_le` | Its P6 application at 388 is the conditional producer in this proof; remove the local Fact after validation. | Retain `x>0`, `2≤V`, `W>0`, all natural U/V carriers, and the unchanged `1.4262²*W` term. |
| `TypeIIReduction.lean:438 norm_typeII_le` | Remove the local Fact after the preceding theorem. | Keep `1≤U`, `2≤V`, `V≤x/U`, interval integrability of `g(W)/W`, and its pointwise bound. These are essential generic analytic hypotheses, not Platt inputs. |
| `MinorArcs/EBound.lean:220,247` | Two P6 calls repaired. | `E_partial:173` still calls P1 at line 218. Do not remove its or `E_le_14_28`'s Fact on P6 alone. The separate reviewed EBound replacement is another task. |
| `Prelim/EOneRanges.lean:167`, `SchoenfeldJ.lean:60`, `SchoenfeldTailAux.lean:164` | Existing P6 applications remain valid. | Their other theta/psi estimates are not supplied by P6. Retain conditional wrappers until those dependencies are separately repaired. |
| `LambdaMu.lean:1437`, `MertensProduct.lean:1958` via `nonprime_small` | These finite nonprime calls become unconditional. | The former also uses `psi_two_sided`; the latter's surrounding Mertens/prime range proof has other conditional inputs. No global closure follows. |

Above `norm_typeII_le`, the concrete `typeII_637/typeII_640` bounds still use the P7 squared-log prime moment and M2/T2. P2/P6 together do not remove `Fact PlattGRH` from `theorem_3_1_1`.

## 4. Totient helpers: two finite domains, one coarse global bound

Use `integration/GLOBAL_TOTIENT_FINITE_REVIEW.md` for the exact selected source path. Place new helpers either beside the elementary exchange declarations in `Prelim/MertensProduct.lean`, or in a new downstream module importing that file and `SmallMertensProd`; do not import downstream minor-arc consumers into Prelim.

First implement a restricted analogue of `div_totient_lt` for `1≤q≤2^1000`, `3≤r`, `q≤r`. **There is no upper bound on r.** Reuse unconditional `div_totient_eq_prod:2129`, `frac_anti:2148`, `exch:2156`, `image_nth:2203`, `exp_gamma_ge:2230`, and `bigF_gt:2236`. Replace the template's `F_all` call by the finite `MertProd.inv_2000` certificate and its primorial lower bound. Do not invoke the old conditional `div_totient_lt:2258` to prove its restriction.

For regionS, separately implement the analogous restriction `log q≤42000`, using `MertProd.inv_100000` and its `theta(100000)>99685` certificate. It has the same unrestricted comparison radius r. A common internal exchange lemma with an explicit finite product certificate can support both specializations; discharge that premise from the existing certificates in the exported restricted results.

Next prove the elementary global bound `(q/phi(q))^4≤16q`, hence `q/phi(q)≤2q^(1/4)`, for `q≥1`. Keep the prime-factor product and exceptional primes 2,3 explicit. This uses no prime distribution. The selected finite certificate import closure is `SmallMertensProd → RamareWalk → LogWalk → RamareHarm → Mathlib`; source review found no project Platt path, but a future `#print axioms` remains mandatory.

## 5. regionS: repair the actual call, not a broader theorem by accident

The old `MinorArcs/LSQuot3.lean:75 regionS` has general q and c′ binders plus hcc/hh. The new argument instead uses `q≥22000000000` and `1≤R<lamQ q`, available at its **sole production call**, `LSQuot6.lean:90`. These domains are not interchangeable. There is no justification to delete the old regionS Fact while claiming to have reproved its entire original contract.

Minimal implementation:

1. Extract the algebraic part of regionS into an unconditional internal consumer of the **proved** bound `X=P/phi(P)≤.4log(qR)+.86`, where `P` is the source product over `primeSetRq R q`. Retain hQ, hQ₀, hρ, hq, hs, and hR and the exact `Gq` conclusion. All product/squarefree/comparison steps after this bound are already unconditional.
2. Put the new large-q/small-R provider in a module **downstream of LSQuot5**, not in LSQuot3. `LSQuot4` imports LSQuot3, and LSQuot5 imports LSQuot4; putting a proof using `lamQ_le_k`/`large_q_hS` into LSQuot3 would create a cycle.
3. For `log q≤2000`, replay the 310 lambda checks and 2262 prime-endpoint theta checks in `REGION_S_ELEMENTARY.md`. Derive `R<20000`, `log P<22780<42000`, then use the restricted finite totient theorem at radius `exp(log q+1.039R)`. The existing `LSQuot5.large_q_hS` and `LSQuot6.hcc_large` complete the old scalar comparison. To avoid a new cycle through LSQuot6, keep the latter final application in LSQuot6 or move its elementary helper upstream.
4. For `log q≥2000`, prefer the reviewed 20-log Mertens variant: unconditional `PNTMertens.sum_mangoldt_div_log_eq:1724`, `E₂Λ.abs_le:934`, finite-product prime-power expansion, and the omitted-power tail ≤1 give the coarse product estimate. The source lambda/prime-factor bounds give `log(max(2000,log P))≤.02log q`, so `X≤.4log q≤.4log(qR)+.86`. The alternative 15-log Markov route is optional, not an additional dependency.
5. Replace only the large-q/small-R call in `LSQuot6.prop_12_2_4`; preserve `regionL`, the small-q `Phi2` branch, all other binders, and the original constants. After checking all selected dependencies, remove this wrapper's local Fact. Then validate `LargeSieveProof.cor_12_2_5` and its consumers; do not infer the whole minor-arc theorem is unconditional.

The old conditional `log_prod_primeSetRq_le` and general `regionS` can remain as unused historical lemmas. The new route proves precisely the needed consumer. The finite certificates are mathematical work still to implement and replay in Lean, not imported truths from Python/Arb output.

## 6. Pointwise totient propagation is a separate, larger stage

Follow `independent-feasibility/RESUME_STRATEGY_2026-11-11.md` / output chapter 52. The source-faithful changes are:

- `FirstChoiceTypeII.typeII_rest_le`: split denominator at `B=2^1000`; retain the old numerical conclusion using finite logarithmic totient below B and the power bound above B.
- Second-choice helpers `SecondTypeIIa.div_totient_le_large`, `SecondTypeIIb.div_totient_le_F0`, and the `SecondBridge` comparison: do **not** assert their old logarithmic conclusions globally from the power bound. Split `T` at `S=2^500`; above S prove the reviewed raw alternative, including every Type I/II remainder.
- Carry the common correction `H(r)=12000*log(max(r,S))²/max(r,S)^(1/4)` through `PointwiseBound`/`Prop1123b`, `GBound`, and `LinftyLevels.norm_S_etaStar_le_ghat`. The repaired level bound is old `ghatY+1.398H`, not the old bound unchanged.
- In the layer argument retain the initial, middle, and terminal correction, the source scale hypothesis `2.16e20*n≤670*y`, and `n≤y^(1/3)/6`. Bound the total correction by `1e-24`, then consume the explicit `1e-6` reserve to preserve final `1.0376`. Keep original numerical functions intact where possible, adding a comparison theorem for the raised envelope.

This changes consumers rather than proves unrestricted `Prelim.div_totient_lt`. The raw Type I/II hypotheses P1, P3, P4, P5, P7, M1 and M2 remain after P2/P6. Energy, base gap, and the separate quotient proof also remain independent. Never remove a module-level Fact merely because one use of R1 was replaced.

## 7. Future validation commands and acceptance gates

**Recorded only; not executed.** Use an implementation branch and recheck source/manifest/compiler hashes first. The existing audited driver writes only its owned artifacts and validates source/dependency receipts; it is serial. It targets the source under `work/ternary-goldbach`, so run it only after that checkout contains the reviewed implementation. No dependency update or cache deletion is part of this plan.

From the workspace root, stage gates include:

```powershell
python work/qrh-campaign/agents/integration/build_project.py TernaryGoldbach.Prelim.LambdaMu --scan-only
python work/qrh-campaign/agents/integration/build_project.py TernaryGoldbach.Prelim.LambdaMu
python work/qrh-campaign/agents/integration/build_project.py TernaryGoldbach.MinorArcs.GcdSums TernaryGoldbach.MinorArcs.TypeI2Proof TernaryGoldbach.MinorArcs.TypeIIReduction
python work/qrh-campaign/agents/integration/build_project.py TernaryGoldbach.MinorArcs.LSQuot6 TernaryGoldbach.MinorArcs.LargeSieveProof
```

Do not run the last line before all new regionS imports and finite-certificate proofs are ready. A monolithic LambdaMu build may be expensive because of its existing imports; it is a validation cost, not evidence that the mathematical repair requires those conditional theorems.

In a future dedicated audit file, use `#print` (full binders) **and** `#print axioms` for both P2 declarations, `nonprime_mid`, `nonprime_small`, P6, both gcd consumers, `norm_IIsum_le`, `norm_typeII_le`, the two restricted totient roots, and the repaired `prop_12_2_4`. Include the finite certificate roots. Recheck unchanged consumers at their actual types. A standard axiom list alone does not rule out a residual `Fact PlattGRH` parameter, because that can be an ordinary theorem premise. Reject any residual Fact on roots claimed unconditional, `sorryAx`, custom axiom, source/artifact mismatch, changed numerical endpoint, or extra analytic premise.

Later validate the revised pointwise/level/layer wrappers and their exact new correction terms separately. Only after all remaining arithmetic and major-arc leaves are implemented can the original assembly theorem be audited. This plan introduces no weaker final goal, new binary input, raised endpoint, or frozen declaration.
