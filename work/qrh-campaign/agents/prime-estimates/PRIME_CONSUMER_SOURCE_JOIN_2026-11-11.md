# A shorter source join for the P4 von Mangoldt bound

2026-11-11. Research proof-obligation note; no Lean declarations, builds, evaluator runs, new prime data, or frozen-file edits. All repository references below are under `work/ternary-goldbach/TernaryGoldbach`, at commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

**New conclusion:** P4 can use a coarse derived low-zero moment **W35<436**, instead of the accurate W35<24 required by the selected common psi envelope. The existing reviewed smoothing allocation then gives `|psiR(x)-x|<.006281*x` on `[5e9,exp(35)]`, which is sufficient for P4's unchanged coefficient 1.0064. This removes the quantitative head-moment certificate from this one consumer's path. It does not remove the narrow principal strip, the shared .555 certificate, the global provider, or the accurate moment needed elsewhere in the selected strategy.

This is a complete paper implication from the explicitly identified spectral and finite-prime obligations. Those obligations and several analytic adapters remain unproved in Lean. No consumer conclusion is introduced as a hypothesis.

## 1. Actual consumer and source boundary

`Prelim/LambdaMu.lean:1375`, `TernaryGoldbach.Prelim.sum_vonMangoldt_le_a14`, currently takes `Fact PlattGRH` and proves, for real y>=2.5e7,

`sum_{n in Icc 1 (floor y)} Lambda(n) <= 1.0064*y`.

Its existing proof gets the integer bound from `psi_bounds`; that route is conditional. The replacement should instead prove the integer bound for every N>=25000000, then keep the existing final floor argument. Direct consumers are `MinorArcs/TypeI2Large.lean:71,331` and `MinorArcs/TypeI2Sum.lean:389`. Their subset-sum steps use nonnegativity of Lambda and need no altered coefficient or threshold.

The exact source bridges already exist:

* `LambdaMu.psiN` at line 53 is the Icc sum; `psiN_eq` at line 61 splits it into thetaN plus nonprime prime powers.
* `Prelim/ThetaExplicit.psi_eq_Icc:126` identifies Helfgott.psi with that same sum.
* `ThetaExplicit.psiR_nat:42` identifies the real wrapper at a natural argument with Helfgott.psi. `Explicit/PsiSandwich.lean:82` defines the wrapper using the natural floor.
* `Nat.le_floor` and `Nat.floor_le`, already used in P4's proof, give N>=25000000 and N<=y. Thus an integer coefficient bound transfers directly. There is **no extra unit loss or .011 real-envelope conversion** in this consumer join.

The source file's individual `variable [Fact ...] in` binders do not make its unconditional identities conditional. Nevertheless the final exported P4 type and transitive axioms must be checked after implementation; importing a source file is not an audit of a theorem's hidden binders.

## 2. Spectral inputs still to certify

Use only the following location statements, with true zero multiplicities in every sum:

1. Genuine global 7/8 nonvanishing, together with reflection, gives `[1/8,7/8]` for nontrivial zeta zeros. The actual provider is the 7/8 export in `OAI/NumberTheory/DirichletL/Nonvanishing.lean`, pinned to `4eaee87548250b2682affda7d05d947c05554bae`; 23/24 is not substituted.
2. The selected shared c=1 certificate gives `[89/200,111/200]` through closed height H=60343058.
3. The selected additional principal certificate gives `[.4968,.5032]` through closed height T=1000000. This includes the certified head and the remaining outer strip. No positive-ordinate assertion may silently exclude real zeros.

P4 does not need the numerical inputs `Q1500<1.668`, `N(1500)=1069`, or their resulting W35<24 as separate consumer estimates. A method proving the complete head location may of course use a zero count internally. The accurate moment remains required by the common `.01/log x` envelope and its other consumers.

## 3. Unconditional low-height exclusion and translated count

The height floor is a real proof obligation, not a use of RH. `Explicit/ZetaLowZeroFree.norm_Jzeta_le:58` and `zetaF_eq_J:224` assume only Re(s)>0. At a zero in the right half of the strip, their norm identity implies

`4*(sigma+1) <= |s|*|s-1| <= sigma^2-sigma+1/2+t^2`.

For 1/2<=sigma<=1 this forces t^2>=23/4>(2.39)^2. `Explicit/Xi.xiF_one_sub` and `xiF_eq_zero_iff` reflect the other half, with open-strip hypotheses supplied separately at both points. Consequently every nontrivial zero has |gamma|>=2.39. This also excludes gamma=0; it is not inferred from conjugating positive ordinates.

The complete scratch proof is `zero-sum/ZetaLowUnconditional.lean`, declaration `TernaryGoldbach.Explicit.abs_im_ge_of_nontrivial_zero`. Its only premises are zeta(s)=0 and 0<Re(s)<1. It has an independent source/paper audit but is not treated here as compiled. Do not call the source's different `abs_im_ge_of_zeroH`, which explicitly takes RHBelow.

The second ingredient is the reviewed unconditional translated mass estimate, for every finite selected set of actual zeros and their analytic orders:

`sum m*(2-beta)/((2-beta)^2+(gamma-c)^2) <= 3 + log(1+|c|/2)/2`.

It has a paper proof but is **not an existing finished source theorem**. Its route is `Explicit/XiPartial.xi_partial_approx:776` at 2+ic, positivity of omitted summands, then an arbitrarily small approximation error. The real digamma-series bound and the Euler-series log-derivative estimate give the displayed right side. `Complex.digamma_def`, `digamma_one`, and `digamma_apply_add_nat` are present in pinned Mathlib, but the needed real series/interchange estimate still needs a proof; recurrence alone is not that estimate.

The multiplicity join is explicit. `Explicit/WeilBridge.lean:38` gives `analyticOrderAt_xiF_eq`; line 56 gives `divB_eq_of_analyticOrderAt_eq`; line 87 gives `multRectD_eq_mult`. The latter requires its destination height at least 1. `xi_partial_approx` exposes only T>0, although its proof chooses k>=23 and a good T above k. Either expose that stronger output from the same proof or use the divisor equality directly with the two actual memberships. Do not replace multiplicity by the weaker `1<=mult` in the approximation's membership clause.

For any length-three ordinate bin relevant below H, its center has |c|<=H+3, so the previously reviewed elementary estimate gives the mass bound <12. Under the global reflected strip, a=2-beta lies in `[9/8,15/8]`. On |gamma-c|<=3/2,

`a/(a^2+(gamma-c)^2) >= 8/25`.

Indeed `a-(8/25)*(a^2+9/4)` is concave and nonnegative at both endpoints. Thus the bin's total multiplicity is <37.5, safely <=38. Neither this mass lemma nor this count inserts PlattGRH. They do require the stated analytic proofs and the genuine reflected global strip.

## 4. New coarse moment and uniform smoothing bound

For each sign partition ordinates by `3k<=|gamma|<3(k+1)`. Restrict the finite carrier to |gamma|<=T. The k=0 terms use |rho|>=|gamma|>=2.39; k>=1 terms use |rho|>=3k. The last possible index is floor(1000000/3)=333333, including the top endpoint. Each sign-bin has mass at most38. Hence

`sum_{|gamma|<=T} m/|rho| <= 76/2.39 + (76/3)*H_333333 < 387`.

Pinned Mathlib `NumberTheory/Harmonic/Bounds.lean:21,34` provides `harmonic_eq_sum_Icc` and `harmonic_le_one_add_log`, with rational-to-real casts as in that file. Since log333333<13, H_333333<14. The resulting rational bound is `7600/239+1064/3=277096/717<387`. The logarithm inequality follows, for example, from exp(1)>2.7 and the exact integer comparison 2.7^13>333333; it requires no zero data.

For beta<=.5032, the additional weight is at most exp(35*.0032)=exp(.112)<9/8. A direct elementary certificate uses x=14/125 and

`exp x <= 1+x + x^2/(2*(1-x/3)) < 9/8`.

The tail comparison holds termwise from the quadratic term onward because successive ratios are <=x/3. Thus the actual finite-carrier weighted moment is <`387*9/8=435.375<436`. This argument is uniform in the outer explicit-formula carrier; it does not require constructing an infinite sum of zeros or a new finite enumeration.

Now reuse the parameters and analytic estimates in the reviewed low-zero refinement: for 5e9<=x<=exp35, L=log x, K=sqrt(L+10), delta=.002/(L*sqrt(L+10)), a=+/- .002/L, y0=1000, b=log(y0/x). The same lower/upper beta endpoints give the Mellin endpoint factor <1.002. The only changed estimate is

`E_low < 1.002*436/sqrt(x) < 436.872/70700 < .00618`,

because 70700^2<5e9. All other entries of the accepted allocation remain unchanged. Their sum after multiplication by L is

`.00016 + .002001 + .000009 + .000018 + 2e-9 + 1e-12 = .002188002001`.

Since L>=22.33>22 this gives an unscaled contribution <.0001. The upper-denominator multiplier is at most1.000001. Both smoothing sides therefore satisfy

`|psiR(x)-x|/x < (.00618+.0001)*1.000001 = .00628000628 < .006281 < .0064`.

This is uniform over the full interval, not a check at sample points. Only the monotone lower bounds on L and sqrt(x) were used for the new part. The high/intermediate and vertical estimates retain the continuum proofs of the accepted refinement.

For x>=exp35 the earlier shared-strip/global-QRH argument gives `.0081/log x <= .0081/35 < .0064`. Both arguments include the meeting point exp35. Required source interfaces are `GaussSmooth.norm_intExp_le'`, `ZetaZeroSums.norm_Mg_strip_le` and the Gaussian tail machinery; `ZetaExplicit.explicit_formula_zeta_seq`; `PsiExplicit.norm_logDeriv_zeta_left`; and `PsiLarge.psi_upper_of_err` / `psi_lower_of_err`. The latter use unconditional psiR(y)<=4y. Their specialized RHBelow error producers must **not** be reused with an erased hypothesis: the finite-carrier bound and common good-height limit must be re-proved with these three zero ranges. For P4, only the upper sandwich needs exporting.

## 5. Finite join and unchanged real P4 wrapper

For natural 25000000<=N<1e9, `Prelim/PsiSieveMain.sieve_table3:28160` gives thetaN(N)<=N+.1sqrt(N). The unconditional finite nonprime repair gives NP(N)<1.4262sqrt(N). Thus

`psiN(N) < (1+1.5262/5000)*N = 1.00030524*N < 1.0004*N`.

For 1e9<=N<=5e9 use the completed 6439-window dataset, after its still-required kernel count and log/recurrence replay. At a covering right checkpoint b, the accepted contract is thetaN(b)<=(1+1/10000)b and b<=(4001/4000)N. Monotonicity of theta and sqrt(N)>30000 give

`psiN(N)/N < (1+1/10000)*(4001/4000)+1.4262/30000`

`=1.000397565 < 1.0004`.

The last checkpoint is exactly5e9, and closed covering intervals include N=1e9 and N=5e9. No extrapolation beyond the source sieve's strict cutoff is used. The finite nonprime repair is needed only below1e12: in `LambdaMu.nonprime_mid:678`, replace the call to `psi_two_sided` at sqrt_nat(N)<1e6 by `SmallTab.small_table` and `PsiTwoSided.thS_add_ppS`; replace its two `psiN_le` calls at cube/fourth-root floors by the finite bound from `Small.psi_lt_small_700` plus that table. All three arguments are strictly below1e6. The existing algebra then supplies1.4262. Calling current conditional `nonprime_mid` is not the repair.

Finally for N>=5e9 use section4 and `psiR_nat`, `psi_eq_Icc`. For y>=2.5e7 set N=floor(y), use the existing P4 floor inequalities, and multiply N<=y by1.0064. No real-to-integer error estimate is needed. The table and analytic branches overlap at5e9, and the two analytic ranges overlap at exp35.

## 6. Implementation order and remaining obstruction

The smallest source-directed order is: (i) unconditional height floor; (ii) translated positive mass with genuine divisor multiplicities; (iii) finite-bin moment<436; (iv) upper-only Gaussian error/limit and sandwich, with the earlier shared-strip tail; (v) finite nonprime and count/log replay; (vi) integer P4 bound and the unchanged floor wrapper. Keep analytic helpers outside LambdaMu so importing them there does not create a cycle. Existing source identities may be reused individually; no requirement to make all of ThetaExplicit or psi_bounds unconditional first.

The genuinely missing mathematics in existing Lean source is the translated mass/digamma bound, the QRH-strengthened Gaussian finite-sum/limit argument and refined vertical integral, plus the concrete finite certificate replay. They have reviewed paper derivations; this note adds the coarse-moment consumer reduction rather than claiming them implemented. The actual finite .555 family component and narrow principal strip are still missing spectral evidence, and the global provider still needs compatible build/type/axiom validation. Those are the substantive obstructions to an unconditional exported P4 theorem.

No global strategy is changed. In particular the Mobius/common-envelope route still needs the accurate W35<24 estimate; .006281*x cannot replace .01*x/log x at unbounded x. This note preserves the final10^27 theorem and original BinaryGoldbachInput.

## Read and pinned supporting packets

All paths here are relative to `work/qrh-campaign/agents/` unless stated otherwise.

| Packet | SHA256 |
| --- | --- |
| `mellin/CURRENT_CONSUMER_OBLIGATION_FRONTIER_2026-11-11.md` | `517D24E49F9F2DD8AA4E339C6EEF440070937FD94D2C9EB5ADE366A89604FF5B` |
| `mellin/RESUME_PSI_LOW_ZERO_REFINEMENT_2026-11-11.md` | `33C01406E927F8F49F329AB52B967AA14B85B64DF7928A034C3028EFEEB91F61` |
| `integration/RESUME_PSI_FROM_FINITE_STRIP_2026-11-11.md` | `D4A026F5B7190F0AA577A70A88E7BFCB79740F9CA549EE9B7AC0EF0C782B3826` |
| `integration/RESUME_PRINCIPAL_REVIEW_2026-11-11.md` | `92DC7FE1B0FED4FD7B9CEAF50E5C0E289E84D9650FA297B7CA881A957FA66E11` |
| `zero-sum/ZetaLowUnconditional.lean` | `7FA18BA1662B103599B81B36606A626FF1F0240861D369CB0A1B1464842E46AE` |
| `audit/LOW_ZERO_UNCONDITIONAL_REVIEW.md` | `1B166A60F5E3113E013FF142A8A974DDEB32E268BFF42C85154FEDC24C2C857D` |
| `prime-estimates/RESUME_PSI_LOG_RECURRENCE_LEDGER_2026-11-11.md` | `27B2C225C2A5646DCD01948E35FA12FB3D3627E2A538D4127CC2900622624B1A` |

Mathlib APIs were read from the existing cache at commit `56a005855ea17e0b0958f73ec801ae140b0a1679`, not from current online documentation. Source checks included exact P4 consumers, the finite nonprime call sites, the strict sieve cutoff, real/natural psi identities, the low-zero integral identity, the partial-fraction output type and multiplicity bridge, and the harmonic-sum theorem. No new numerical experiment was performed. Independent review of the new coarse-moment reduction remains to be obtained.
