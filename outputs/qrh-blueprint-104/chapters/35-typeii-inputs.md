# Remaining Type I/II inputs without Platt

Research audit of `PointwiseBound.theorem_3_1_1` at source commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Source paths below are relative to `work/ternary-goldbach/TernaryGoldbach`. No Lean compilation, proof implementation, or source modification was performed.

The inspected first/second-choice proof reduces to ten conditional producer interfaces: seven Lambda/prime estimates, one logarithmic Möbius estimate, one T2 estimate, and one global totient estimate. This is a source-level replacement boundary, not a claim that ten logically independent new theorems are necessary. Some interfaces can be recovered from the same stronger prime estimate, and the Möbius interfaces share a common profile route.

The combined existing blueprints name all ten. A shorter checklist in `../moebius/BASE_GAP_TYPEII.md`, section 6, omits the prime log-square producer. That omission matters because the producer controls the main Type II term. It is already listed explicitly in `../prime-estimates/BLUEPRINT_PRIME_ESTIMATES.md`, section 5. None of the ten full-domain replacement interfaces is currently discharged by a complete unconditional paper proof in those chapters. Several finite subranges and conversion steps are available.

## 1. Root and the two choices

`MinorArcs/PointwiseBound.lean:65 theorem_3_1_1` inherits the module-level `Fact PlattGRH`. Its other binders are

```text
{α x δ : Real} {a : Int} {q : Nat}
hx : 2.16e20 ≤ x
h  : Approx2 α x δ a q ((3/4)*x^(2/3)).
```

It sets delta0=max(2,abs(delta)/4) and proves both the small-q and large-q bounds. The split is q<=x^(1/3)/6 versus q>x^(1/3)/6. Its proof sets T=x^(1/3), obtaining T>=6e6, and calls the following two declarations.

- `FirstChoiceFinal.lean:33 theorem_3_1_1_first`, with T>=6e6, the corresponding Approx2 at x=T^3, and q<=T/6. It combines `Assembly.norm_S_le_parts` with `typeI1_first`, `typeI2_first`, and `typeII_first`, then performs explicit arithmetic.
- `SecondFinal.lean:58 theorem_3_1_1_second`, with the same T and approximation and q>T/6. A new rational approximation is divided by `second_case_split` into two second-choice cases and a first-choice bridge. The first two use `typeI_second` and `typeII_second`. The bridge is `SecondBridge.bridge_le:212`, which calls `theorem_3_1_1_first` again and bounds its terms.

The decomposition `Assembly.norm_S_le_parts:65`, rational approximation, case split, and elementary parameter inequalities do not themselves consume Platt. The conditional numerical theorem must still be rebuilt from the actual arithmetic inputs below.

## 2. Complete producer boundary

Every row below currently has a `Fact PlattGRH` binder, local or inherited. Real cutoffs use floor exactly as in the source. In the table, sums without another specification run over 1<=n<=floor(y) or floor(x).

| ID | Producer declaration | Exact contract | Immediate consuming branch |
|---|---|---|---|
| P1 | `Prelim/LambdaMu.lean:337 sum_vonMangoldt_lt` | y>0 implies sum Lambda(n)<1.03883*y | `TypeI2Proof:753`; `TypeI2Large:44` |
| P2 | `Prelim/LambdaMu.lean:535 sum_vonMangoldt_div_le_log` | x>=1 implies sum Lambda(n)/n<=log x | `GcdSums:155`, `TypeI2Proof:258,752`, `TypeI2Large:82` |
| P3 | `Prelim/LambdaMu.lean:1170 log_sub_le_sum_vonMangoldt_div` | x>=1 implies log x-log(3/sqrt 2)<=sum Lambda(n)/n | `TypeI2Large:87` |
| P4 | `Prelim/LambdaMu.lean:1375 sum_vonMangoldt_le_a14` | y>=2.5e7 implies sum Lambda(n)<=1.0064*y | `TypeI2Large:71,331`; `TypeI2Sum:389` |
| P5 | `Prelim/LambdaMu.lean:1362 sum_vonMangoldt_mul_lt_a17` | y>=2.5e7 implies sum n*Lambda(n)<1.022*y^2/2 | `TypeI2Large:322`; `TypeI2Sum:380` |
| P6 | `Prelim/LambdaMu.lean:761 sum_vonMangoldt_nonprime_lt` | y>0 implies sum (if n.Prime then 0 else Lambda(n))<1.4262*sqrt y | `TypeIIReduction:388`, in `norm_IIsum_le:332` |
| P7 | `Prelim/LambdaMu.lean:1884 sum_log_sq_primes_le` | y>=2e6 implies sum over prime floor(y/2)<p<=floor(y) of log(p)^2 <=y*log y/2 | `TypeIITotal:35 logSqSum_le_half`, also used from `TypeIITotalGen` |
| M1 | `Prelim/LiouvilleBound.lean:680 abs_sum_moebius_div_coprime_le_log` | q>=1 and q<x imply abs(sum [coprime(n,q)]*mu(n)/n)<=2.8*(q/phi(q))/log(x/q) | `TypeITotal:44 abs_muSum_one_le`, hence `muBound` and Type I |
| M2 | `MinorArcs/T2Bound.lean:23 T2_le'` | S>=16 implies T2(S)<=.37273 | `TypeIIS1:345 T2_le`, `:348 H2_ge`, `:400 S1_bound` |
| R1 | `Prelim/MertensProduct.lean:2258 div_totient_lt` | q>=1, r>=3, q<=r imply q/phi(q)<exp(gamma)*log(log r)+2.50637/log(log r) | `FirstChoiceTypeII:153`, `SecondTypeIIa:172`, `SecondTypeIIb:216`, `SecondBridge:58` |

There is no direct application of a finite-RH theorem at the first/second-choice root. The Fact dependence reaches those roots through these producer boundaries. Below P1–P7 the present implementation uses finite tables plus the conditional psi/theta contracts; below M1 and M2 it uses the conditional Möbius profile; below R1 it uses conditional Mertens-product bounds. Those lower proofs may be replaced together or the displayed interfaces may be proved directly.

This boundary deliberately excludes the separate `LargeSieveProof.cor_12_2_5` integrated-arc estimate. It is required later by `minor_total`, but it is not the large-sieve result used to prove `theorem_3_1_1`. The S2 large-sieve branch here uses `Prelim.LargeSieveMV`, `Prelim.SumMuSqPhi`, and `MinorArcs.TypeII` results without Platt. Conflating these two large-sieve branches would add the wrong proof obligation to this root.

## 3. Where the producers enter

### First choice

```text
theorem_3_1_1_first
  typeI1_first                 FirstChoiceTypeI1:227
    typeI1_le                 TypeITotal:99
      abs_muSum_one_le         M1 plus the unconditional bound by 1
      abs_muSum_log_le         M1 plus an unconditional weighted identity
  typeI2_first                 FirstChoiceTypeI2c:16
    typeI2_le_small / typeI2_le_large
      P1, P2, P3, P4, P5       TypeI2Proof / TypeI2Large / TypeI2Sum
      M1                       same muBound route
  typeII_first                 FirstChoiceTypeII:329
    typeII_637 / typeII_640    TypeIITotal / TypeIITotalGen
      S1_bound                 M2
      logSqSum_le_half          P7
      norm_typeII_le           P6, through norm_IIsum_le
      S2 large-sieve bounds     existing unconditioned branch
    typeII_rest_le             R1
```

The S1 estimate is

`S1(x,U,W) <= (x/W)*H2(x/(W*U)) + 1.27*zeta(3/2)^3*x^(3/2)/(W^(3/2)*U)`.

Its only conditional numerical input is M2 through H2_ge. The squarefree-counting lemma 5.1.1, the identities reducing S1 to T2, the zeta(3/2) bounds and finite H2 kernel estimates remain reusable.

The prime-square moment P7 enters the S2 majorant before the square-root/product estimate. It is not merely a discarded lower-order error. P6 yields the explicit `1.4262^2*W` term under the other square root, eventually contributing to the 3.2*x^(5/6) remainder.

### Second choice and bridge

```text
theorem_3_1_1_second
  typeI_second                 SecondTypeI2:521
    typeI1_second              SecondTypeI1:314 -> typeI1_le
    typeI2_second              SecondTypeI2:490 -> same Type I2 producers
  typeII_second                SecondFinal:41
    typeII_a1 / typeII_a2 / typeII_b
      same generic Type II estimates -> M2, P6, P7
      div_totient_le_large     SecondTypeIIa:169 -> R1
      div_totient_le_F0        SecondTypeIIb:213 -> R1
  bridge_le                    SecondBridge:212
    theorem_3_1_1_first
    its totient comparison     SecondBridge:58 -> R1
```

First-choice Type II uses R1 at r=T with q<=T. The second-choice large-q auxiliary uses r=q for q>=1e6. Other second-choice/bridge auxiliaries use q<=T/6 and a radius comparable to T. These ranges grow without bound with x. The finite q<=300000 totient argument developed for the base gap cannot supply R1 here.

### Inputs that are already unconditioned

The logarithm-weighted Möbius estimate

`Prelim/MoebiusLog.lean:172 abs_sum_moebius_div_log_coprime_le`

assumes x>0, q>=1 and bounds

`abs(sum [coprime(n,q)]*mu(n)/n*log(x/n)) <=q/phi(q)+2.67`.

It has no Platt binder. The bound by 1 for the unweighted coprime Möbius sum is likewise existing elementary input. These should not be added as new cancellation obligations merely because their consumers share a file with M1.

The conditional `GcdSums.sum_vonMangoldt_gcd_div_le:151` adds no independent input beyond P2. Its other divisor terms are bounded using exact von Mangoldt divisor identities. The related weighted-gcd estimate is unconditioned and leaves the first moment explicit for P5 to bound later.

## 4. Blueprint coverage and actual replacement status

| Inputs | Existing coverage | What is available | What remains mathematical |
|---|---|---|---|
| P1 | Prime blueprint sections 1,2,5; Möbius blueprint section 5 | Finite extraction gives the coefficient below 1e6 from existing source; broad all-range coefficient 4 is already available. | Full coefficient 1.03883 on the unbounded range, or a complete direct replacement of its actual consumers. |
| P2 | Prime blueprint section 5 | Current conversion in LambdaMu:423 uses the coefficient 1.03883 and factorial/divisor identities, with a finite check below 30. It can be reused after P1 supplies the natural-number version. | No independent full-domain unconditional proof is presently provided. P1 would largely discharge this branch. |
| P3 | Prime blueprint sections 2,5 | Current `mertens_lower_nat` route uses explicit lower psi estimates and summation. | Global harmonic lower bound with its fixed constant, or a new sufficient Type I2 block bound. Tail-only psi control is insufficient. |
| P4,P5 | Prime blueprint section 5 and direct-consumer proposal in section 4; Möbius `BASE_GAP_TYPEII.md` section 6 | Existing finite data and Abel identities. P5's `psi_mul_of` conversion is unconditioned once its upper and lower psi premises are supplied. | Full-domain 1.0064 and 1.022 estimates, including moderate arguments. The current far-asymptotic drafts do not cover these entire domains. |
| P6 | Prime blueprint sections 1,5; Möbius finite extraction; `EBOUND_UNCONDITIONAL.md` | Existing elementary prime-power decomposition; finite repair drafts; separate paper bound 1.5*sqrt y for large y used by EBound. | Full coefficient 1.4262 for the Type II producer, or a checked propagation of a weaker coefficient through both choices. The EBound paper proof does not preserve this interface automatically. |
| P7 | Prime blueprint section 5 explicitly lists the full theorem | Existing `logsq_sieve` finite range; `logsq_real` and Abel conversions. | Moderate/large prime log-square moment. Current `logsq_r1/r2/r3/large` call conditional psi/theta bounds. No complete direct paper replacement was found. |
| M1,M2 | Möbius blueprint sections 3,4,6 | Paper conversion from profile .03 before 100000001 and .10 thereafter. Exact external G2 replay yields .008884671...<.0089 and preserves T2<=.37273. Liouville has enough slack to preserve 2.8. | The .10 profile itself, or a direct weighted-square tail plus a sufficient Type I bound. Exact replay proves a numerical implication, not the missing arithmetic estimate. |
| R1 | Prime blueprint section 6 | Unconditioned prime-factor exchange, finite product data, and E2-from-E1 conversion. | Global product/totient bound. Present `F_all` uses `F_mid` and `F_large`; the latter route has its own `E1_win_num` call to RH up to 1e8. |

The local fixed-gap psi drafts cover the far range log(x)>=20000, with the asymptotic formula from log(x)>=35000. These are relevant ingredients for P1–P7 and the profile tail, but are not full replacements for the moderate-range producers. They are source-reviewed drafts, not newly checked theorems in this audit.

The separate paper proof of the residual small-prime/nonprime energy bound EBound is useful elsewhere. Its weaker prime coefficients are absorbed by that particular weighted energy argument. It does not prove P1, P4, P5, P6, or P7 at their existing constants. Likewise, neither the proposed .65 smoothed etaPlus energy bound nor the principal major-energy argument proves these Type I/II inputs.

## 5. Omissions and handoff

No new mathematical producer is missing from the union of the prime-estimates and Möbius blueprints. The compact six-item list in `BASE_GAP_TYPEII.md` section 6 should add P7 explicitly. Its current discussion of “prime first moments” does not cover the dyadic prime log-square moment. This correction was sent to the Möbius worker.

The genuinely open work is concentrated in global/moderate prime estimates, global product/totient control, and the Möbius cancellation or square-tail input. The ten-interface table supplies an explicit consumption boundary for those workstreams. Reproving all earlier internal psi/theta statements is one sufficient approach; direct proofs of the table's consumer-facing estimates may require less.

Future Lean validation must inspect the root theorem's printed type and transitive axioms after these changes. Retaining a Fact binder on a wrapper, supplying a replacement estimate as a new global assumption, or importing a conditional proof does not complete the no-Platt theorem. No such completion is claimed here.

