# Minor arcs, Möbius induction, and the finite bridge

Research blueprint, 2026-11-10. Source pin: `calr3/ternary-goldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`, branch `cde-moebius`.

All source paths below are relative to `C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach`. This document and its experiments are in `work/qrh-campaign/agents/moebius`. No source was changed and no Lean compilation was run during this blueprint round.

The useful replacement target is substantially simpler than the existing Möbius profile: prove `|sum_{n≤x} μ(n)/n| log x ≤ 0.03` for `11815 ≤ x < 100000001`, and `≤ 0.10` thereafter. The first interval already has unconditional source proofs. The second is a genuinely missing analytic result. An exact external replay shows that this target permits a weaker internal G2 integral estimate while preserving the original public Type II constant, the minor-arc numerical certificates, the large-case threshold `10^27`, and the binary input `4*10^18`.

## 1. Status language and scope

- **Existing source proof:** a declaration and proof in the pinned source. This is source review, not a claim that this campaign freshly compiled its transitive closure. Its stated `Fact PlattGRH` assumptions remain significant.
- **Source-reviewed draft:** a scratch proof or precise source edit whose mathematics and declarations have been reviewed, but which has not completed Lean elaboration and axiom inspection.
- **Exact external arithmetic:** Python integers and `Fraction` arithmetic, with original outputs reproduced as a control. This is stronger than floating-point evidence but is not a Lean certificate.
- **Numerical diagnostic:** floating arithmetic used to choose targets, not proof.
- **Open estimate:** no proof presently available in this campaign. It must not be exported as a hypothesis in the final theorem.

The following are separate obligations: Möbius cancellation, prime/totient large-sieve estimates, smoothed prime energy, the small-denominator character bound used in the base gap, and the major-arc lower bound. Removing the first does not remove the others. See the companion prime-estimates and major-character chapters.

## 2. Fixed final interfaces and the finite cases

`Statement.lean:30–40` defines `TernaryGoldbachUpTo`, `TernaryGoldbachFrom`, and `statement_of_upTo_of_from`. `Statement.lean:64` fixes `BinaryGoldbachInput := BinaryGoldbachUpTo (4*10^18)`. Preserve this definition exactly.

`Helfgott/Main.lean:68` proves the existing conditional `ternaryGoldbachFrom : TernaryGoldbachFrom (10^27)`. Its analytic scale is `xOf N ≥ 4.9e26` (`Helfgott/Inputs.lean:57`). The main lower bound is `1.049*x^2/κ`, the minor upper bound `1.0376*x^2/κ`, and `κ=49`. Their difference is `0.0114*x^2/κ`. `nonprime_input` and `final_inequality_crude` subtract at most `6.7e6*N^(3/2)*log N` and establish positivity at `N≥10^27`.

The finite side already avoids Platt:

- `Helfgott/SmallCases.lean:21`, `ternaryGoldbachUpTo_1e27`, assumes only `Fact BinaryGoldbachInput`.
- For odd `5<n≤4*10^18+3`, write `n=3+(n-3)` and apply that exact binary input.
- Otherwise use `i=(n-5)/3927138875067072512`, where `3927138875067072512=111616*2^45`.
- `Ladder/Main.lean:19`, `Ladder.ladder_prime`, supplies a prime in `[(111616*i-2047)*2^45+1,111616*i*2^45+1]` for every `1≤i≤254638308`.
- This gives `n-4*10^18≤p≤n-4`; the even difference `n-p` lies in the original binary range.
- `Ladder/Spec.lean`, `Ladder/Check.lean`, `Ladder/Data.lean`, and its data submodules certify the Proth prime witnesses through `runsOK_all` and `prime_of_runsOK`. The congruence is `3^((c-1)/2)=-1 mod c`. The ladder is a source proof, not an additional assumed finite computation.

Consequently, moving the analytic threshold upward would create an actual unproved gap. A new ladder or stronger binary assertion must not silently replace this branch. The proposed work retains `10^27`; no new ternary or binary finite-coverage assumption is permitted.

## 3. Möbius producer and consumer map

Write `M(u)=sum_{n≤u} μ(n)` and `m(x)=sum_{n≤x} μ(n)/n`.

The current producer chain is:

`SmallMu + SchoenfeldM.M_low`
→ `MoebiusSch.m_mid`
→ `SchoenfeldJ.rho_le + SchoenfeldGen.cell_sound`
→ `SchoenfeldCells* / MoebiusSchData.m_cells`
→ `SchoenfeldTail.M_tail + MoebiusSch.m_tail`
→ `MoebiusProfile.moebius_log_le`.

The two important consumer chains are:

1. `MoebiusProfile.abs_m_le_014` → `LiouvilleBound.abs_ls_large` → `abs_ls_mul_log_le` → `abs_lqs_mul_log_le` → `abs_mqs_le` / `abs_sum_moebius_div_coprime_le_log` → `MinorArcs/TypeITotal.lean` and the first/second Type I choices.
2. `MoebiusProfile.moebius_log_le` → `G2Tail.tail_term_le` → `sum_tail_le` → `sum_mm_le_Vt` → `integral_mm_le` → `tail_le_sum` → `tail_integral_le` → `T2Bound.T2_le'` → `TypeIIS1.T2_le` → Type II bounds.

The current profile in `Prelim/MoebiusProfile.lean:26–29` is:

| x interval, left endpoint included | bound for `|m(x)| log x` |
|---|---:|
| `[11815,100000001)` | .03 |
| `[100000001,9001713129)` | .092 |
| `[9001713129,1525381771989686)` | .09 |
| `[1525381771989686,747499893696668303884288)` | .08 |
| `[747499893696668303884288,Tcells)` | .035 |
| `[Tcells,infinity)` | .075 |

`Tcells = 5273264915796702340408371151172679619749656857014800716447501879607296`, with `160.54≤log Tcells≤160.55`.

`moebius_log_le` currently has `Fact PlattGRH`. Its proof obtains all cell data before splitting into small and large cases. Thus one cannot infer the small range is conditional merely from that wrapper: `m_small_real` and `Sch.m_mid` themselves already prove it without Platt. The direct replacement should expose their unconditional combination before the larger induction is addressed.

`Prelim/MoebiusBound.lean:30`, `abs_sum_moebius_div_le`, requires `x≥1e10` and concludes `.55/(log x-.7521)`. Its current proof uses the stronger `.09/log x`. The proposed `.10/log x` also implies its unchanged conclusion; it does not require reproducing `.09`.

## 4. Exact downstream tolerance and proposed relaxed profile

### Liouville / Type I

`Prelim/LiouvilleBound.lean:239–356` splits at `sqrt(z/11815)`. Replacing the coefficient `.14` by `c` in its large range leaves the final expression

`c*(1.64495+(2/9)*1.0117) + 1.414214*5.6*.04`.

For `.14` this is approximately `.5785520471111112`. The existing public conclusion is `.99`. The diagnostic limiting coefficient is approximately `.3600524470300898`; choosing rational `.36` leaves a strict margin. Therefore `.10` is comfortably sufficient. There is no need to weaken `.99`.

Keep these consumer declarations unchanged:

- `abs_ls_mul_log_le` (line 360), `z>1`, bound `.99` for the logarithm-weighted Liouville sum.
- `abs_lqs_mul_log_le` (line 431), `q≥1`, `q<x`, bound `.99*(q/φ(q))/log(x/q)`.
- `abs_sum_moebius_div_coprime_le_log` (line 680), `q≥1`, `q<x`, bound `2.8*(q/φ(q))/log(x/q)`.

The coefficient `2.8` enters `MinorArcs/TypeITotal.lean:26` in `muBound`, then `FirstChoiceTypeI1` and `FirstChoiceTypeI2`. Its proof also uses the finite `SmallCGrid` for the range 2.8 to 80 and the analytic range above 80. Keep those certificates and their endpoint conventions.

### G2 / Type II

`MinorArcs/G2Tail.lean:1213`, `tail_integral_le`, currently proves `integral_[1e4,S] |g2(y)|/y ≤ .0082` for `S≥1e4`. The direct caller is `T2Bound.lean:23`, `T2_le'`. For `S<1e4`, `T2Small.T2_le_small` already proves the final bound independently. For `S≥1e4`, the last arithmetic step is

`T2(S) ≤ 1.4423050431/4 + 9.2185538/10000 + (5/4)*G`
`       = .361498116155 + 1.25*G`.

Hence the exact maximum allowed G in that step is `.008985507076`. Use `.0089`, retaining `T2_le' : T2(S)≤.37273` for every `S≥16`. The resulting expression is `.372623116155`, strictly below `.37273`.

The sufficient Möbius squared-tail bound is

`sum_[j≥11815] m(j)^2*log(1+1/j) ≤ .000591`.

With the proposed profile `.03` before `100000001` and `.10` thereafter, the telescoping/logarithm argument of `G2Tail` gives

`1.00001*(.0009/log 11815 + .0091/log 100000001)`
`≤ 1.00001*(.0009/9.377 + .0091/18.42) ≤ .000591`.

The low-profile theorem uses real x, so the integer/real transition and the shared endpoint `100000001` must be handled exactly as in `mprof_eq_profq`. No unproved estimate below 11815 is introduced; the existing finite part is retained.

### Exact replay artifacts and missing certification

`g2_exact_replay.py` uses integer and Fraction arithmetic, reproducing the original three control values from `G2TailNum` and `T2Kernel`:

- `cP = 814940993196246650988643`;
- original `Macc = 76543490188064834013184551386427677464246145966465219367994725`;
- original `tv_one = (549755813888,1483286220167)`.

With `tailV=591000000000000000000`, it obtains:

- `Macc = 83880895988858868494442540089180897636298467585444092347657730`;
- `tv_one = (549755813888,1483444053877)`;
- final bound `8884671087630412081042571269947465763629846758544409234765773 / 10^63`, approximately `.008884671087630412`, strictly less than `.0089` by exact comparison.

This supports a precise implementation task: parameterize or locally duplicate only the affected G2 tail certificate, prove its checker equality in Lean, and derive a new weaker internal integral lemma. Do not change the old `.0082` assertion into a false claim. Feed the new `.0089` lemma into the unchanged `T2_le'`. `G2RelaxedNumeric.lean` contains uncompiled rational arithmetic drafts; neither it nor the Python replay proves the missing Möbius profile.

## 5. Finite prime estimates: useful proof extraction with no new certificates

The most immediate unconditional source repair is the full existing range of `Prelim/EOneRanges.psi_le_two` (line 155):

`12≤n` and `n<1e9` imply `|psiN n-n|≤2*sqrt n`.

This can be derived from already present unconditional finite source results:

1. `SmallTab.small_table` in `SmallPsiTableMain` gives `|psiN n-n|≤sqrt n` for `12≤n<1e6`.
2. `Small.psi_lt_small_700` gives the coefficient `1.03883` for `1≤n≤700`. For `701≤n<1e6`, the preceding sqrt bound and `1/sqrt(701)<.03883` give `psiN n≤1.03883*n`.
3. `Prelim/LambdaMu.nonprime_mid` (line 678) concerns `1e6≤N<1e12`. Its proof calls global psi theorems only at arguments below `1e6`: sqrt N and roots of exponents 1/3, 1/4. Replace these calls with the finite result from item 2 and the finite two-sided result from item 1. The elementary `nonprime_sum_le4` (line 589) is already unconditional.
4. Combine with `SmallNP.nonprime_small_kernel` for the low range to obtain the same finite `nonprime_small` (line 750), avoiding the global prime-power theorem.
5. `SieveTab.sieve_table3` in `PsiSieveMain.lean:28160` proves `theta(t)≤t+.1*sqrt t` and `t-theta(t)≤2*sqrt t` on `1e6≤t<1e9`. Add the finite prime-power bound for the upper side. The resulting upper error is smaller than `2*sqrt t`; the lower side follows from psi≥theta.

Do not use the older `sieve_table` endpoint `5e7` as the final extent of the supplied data. `sieve_table3` reaches strictly below `1e9`. The source includes 282 sieve data modules, with sieve-prime cutoffs 7100, 14142, and 31622 in the three stages.

The source-reviewed scratch files `FinitePsiCore.lean` and `FiniteBoundary.lean` contain this extraction. `FiniteBoundary.lean` also targets `Sch.bTerm_le_finite`. They remain **uncompiled**. A cast issue at `700<n` was proactively repaired by deriving `701≤n` with `omega` before `exact_mod_cast`; other elaboration issues may remain.

`Prelim/SchoenfeldGen.bTerm_le` (line 437) has the exact range `12≤Y<1e9`. Preserve it. Although the current generator chooses `Y≤1e6`, adding that stronger premise would only prove a specialized helper and would not replace the original API. The finite extraction above supports the full range. This removes the boundary-term use of Platt, but it does not prove `rho_le` at arguments ≥1e9 and does not complete the cell induction.

## 6. The missing Schoenfeld bridge and plausible research routes

### What the existing induction actually requires

`Prelim/SchoenfeldJ.lean:24–34` defines

`epsv(v)=1/log(v)^3 + 4.92e-7 + 1.4262/sqrt(v)`

and the additive envelope

`rb(v)=2*sqrt(v)`
`  + 1_[v≥1e9]*35.5*sqrt(v)`
`  + 1_[v≥32000000001]*72*sqrt(v)`
`  + 1_[v≥1e12]*v*epsv(v)`.

`rho_le` proves `|psiN(v)-v|≤rb(v)`. At each v one source estimate suffices, so the deliberately additive envelope has slack. The low branch will become unconditional by section 5. The branch from `1e9` through `32000000000` currently calls `psi_two_sided` with coefficient≤35.5; the next branch below `1e12` uses coefficient≤72. Above `1e12` it uses `theta_explicit` and the global prime-power coefficient1.4262. These are genuine missing producer inputs after removing Platt.

`eps_piece` and `eps_last` are reusable summation devices. On `V≤D/m<W`, an error envelope `D*eps(V)` produces the term `D*eps(V)*(κ0*log(W/V)+.588)`; the last interval gives `D*eps(V)*(κ0*log(D/V)+1.166)`, where `κ0≈.607927101855` is the squarefree density constant, distinct from the final circle-method κ=49. `SchoenfeldGen` exposes `Mrange`, `kChk/kVal`, `jVal`, `epsq`, `eChk/eVal`, `N_le_X` (line575), and `cell_sound` (line613). These allow the analytic envelope to be replaced while retaining the finite rational checking architecture.

The current cells begin at `X0=1e8`. `SchoenfeldM.M_low` (line22) is unconditional: `|M(n)|≤.571*sqrt(n)` for `100≤n≤100001092`. Existing initial constants include `C0≤626` and `Ssum(X0)≤11519`. `MoebiusSch.m_le_S` bounds m by `( |M(floor x)| + log x + Ssum(floor x) )/x`, with `Ssum=sum |M(n)|/n`. Its cell expression `mqv` is `2*eta + max((ub+S-eta*(s-1))/s,(ub+S-eta*(s-1))/b)`. Thus a candidate cell family must control accumulated S as well as pointwise M.

### Route A: retain the identity, relax the m profile, regenerate cells

This is the most source-compatible route. Supply an unconditional/QRH-derived relative psi envelope e(v), using the finite bound up to `1e9`, interval-specific analytic estimates above it, and an eventual fixed-power bound. Prove the analogue of `rho_le`, then recompute `jVal/eVal` and cell choices against the target `.10/log x`, rather than reproducing `.092/.09/.08/.035` individually.

The generator `scripts/gen_schoenfeld_cells.py` already computes `epsq/eVal/Xq/make_cell` with rational arithmetic. Research experiments must use an owned copy: the original generator writes source data. A candidate numerical success consists of every induction cell check, every m-profile check, every Ssum propagation check, and a compatible final tail. A candidate numerical failure is informative about that envelope, not a proof that QRH cannot work.

For a proved bound `|psi(x)-x|≤C*x^(7/8)*log(x)^2`, set `e(x)=C*x^(-1/8)*log(x)^2`; it is decreasing for `log x≥16`. This fits `eps_piece` and `eps_last` after their monotonicity inputs are generalized. However C and the exact range must be proved. A qualitative nonvanishing statement alone supplies neither.

### Route B: simplify the infinite tail after a finite bridge

`SchoenfeldTailAux.sum_Lambda_div_Ioc` (line37) currently requires Platt and states

`sum_[a<k≤b] Lambda(k)/k ≤ log b-log(a+1)+log(3/sqrt 2)` for `1≤a≤b`.

`rho_C5` (line186) uses `|psiN(v)-v|≤.00985*v/log v` for **every v≥1e12**, not merely for sufficiently large v. These feed `SchoenfeldTail.G_tail_le`, `ksum_tail`, and `numeric_tail`. The current final bounds are `|N(D)|≤.033D` above T and

`M_tail` (line756): `|M(u)|≤(.033/log u+.0395/log(u)^2)*u`.

`MoebiusSch.m_tail` then needs `Ssum(T-1)≤.0000362*T` and obtains `.075/log x`.

Holding the other tail constants fixed, the numerical diagnostic for `numeric_tail` is

`.019162008259280185 + 1.2471594028866984*C5 ≤ .033*(1-1/160.54)`.

This allows C5 only up to approximately `.010930788367150016`; simply inflating the error constant leaves little room. Instead re-optimize the tail against `.10`, including the coefficient of M, the second logarithmic term, the terminal Ssum, and T. The existing `.075` tail need not survive.

Even optimistic fixed-power psi bounds leave a long gap: `C*exp(-L/8)*L^3≤.00985` starts near L=158.548 for C=1, L=180.016 for C=10, and L=201.094 for C=100. These are numerical diagnostics, not proved constants. The supplied finite tables end at `1e9`, with log≈20.72. An eventual bound at these larger cutoffs does not fill the intervening interval. Extending a direct sieve to an exponential cutoff is not an actionable default. A quantitative intermediate analytic estimate, or a successful induction with weaker local errors, is required.

### Route C: direct reciprocal-zeta/Möbius argument

One could bypass psi and derive M or m directly from a quantitative bound for `1/zeta(s)` in a half-plane to the right of7/8. This needs more than QRH nonvanishing: explicit inverse bounds, a contour/Perron error estimate, a justified limiting sum for μ(n)/n, and numerical constants starting low enough to meet the finite bridge.

For example, if one separately proves `|M(t)|≤C*t^β` for every `t≥X`, with β<1 and `sum μ(n)/n=0`, partial summation yields `|m(x)|≤C*(1+1/(1-β))*x^(β-1)` for x≥X. For β=7/8 that is `9C*x^(-1/8)`. The concrete transition condition to `.10/log x` is `9C*log(x)*x^(-1/8)≤.10`. A proof on a line β>7/8 will have its own larger constants and crossover. This route avoids the Schoenfeld tail API but still needs complete coverage from `1e8+1` to its crossover. No such reciprocal-zeta estimate or bridge is currently proved in this campaign.

A fourth possibility is to prove the squared m tail directly, instead of a pointwise profile. G2 only needs the weighted square sum; Type I only needs the much looser uniform coefficient .36. A mean-square argument could therefore succeed when the uniform .10 bound is difficult. Its precise target is the `.000591` tail above, including all integers from11815. This is an open research route, not a supplied estimate.

## 7. Remaining minor-arc Platt paths that the Möbius result does not fix

### Large sieve and totients

`MinorArcs/LargeSieveProof.prop_12_1_2` (line295) is unconditional given an explicit Gq ratio hypothesis. It assumes prime support above sqrt x and δ0≥2; use of the stronger δ0 condition is deliberate. `LSQuot6.prop_12_2_4` (line69) is the conditional ratio producer:

- `20000*Q0≤Q`, `Q0≥1e5`, `log Q0≤.6*log Q`;
- `1≤q≤Q0`, `1≤s≤Q0/q`;
- `Gq(q,Q0/(s*q))≤(log Q0+2)/(log Q+cE)*Gq(q,Q/(s*q))`.

`LargeSieveProof.cor_12_2_5` (line378) transfers this to the integrated arc energy under `(20000*Q0)^2≤x/(2*δ0)` and `2*Q0≤(2*sqrt(x/(2*δ0)))^.6`. The prime-estimates chapter owns its Mertens product/totient inputs, including the large-q branch split at q=22000000000. The Möbius profile is not a substitute for those inputs.

### Residual coefficient energy

`EBound.E_partial` (line173) uses the **global** psi coefficient1.03883 and the **global** prime-power coefficient1.4262. Its displayed bound is

`1.94^2*(log x/2*(1.03883*sqrt x)+log x*(1.4262*sqrt x))`
`+1.4262*2.32^2*sqrt2*sqrt x*(log2/(1-sqrt2/4)^2+log x/(1-sqrt2/4))`.

`E_le_14_28` (line278) concludes E≤8e-11*x at x≥4.9e26, and `MinorTotal.norm_sq_sum_a2_le` forwards it. Finite psi extraction below1e6 does not justify these global calls. Potential repair: replace coefficients by unconditional global estimates and replay the final slack; if8e-11 changes, also replay `I0_ge` and the final minor bound. No successful replacement arithmetic for this branch is claimed here.

Available global source bounds include `Explicit/PsiSandwich.psi_le_four` for every natural N; `psiR_le` for real y≥0; Mathlib `Chebyshev.psi_le` for x≥1 with `(log4)*x+2*sqrt x*log x`; and `Helfgott/Chebyshev.theta_le` with coefficientlog4. `Helfgott/Chebyshev.psi_le` gives1.387 only at N≥1e27, which is above the initial x scale. `LambdaMu.psiN_le` with1.03883 remains conditional globally.

### The base gap and smoothed prime energy

`MinorTotal` imports three analytic facts through `PartIICited.lean`:

- `cor_7_1_3`: primitive χ of q≤300000, y≥1e25, `|δ|≤4*300000/q`; etaU character error at most `(1e-17+4.7e6/(sqrt q*sqrt y))*y`.
- `prop_7_1_5`: at x≥4.9e26, `sum Lambda(n)*log n*etaPlus(n/x)^2 = .640206*x*log x-.021095*x+E2*x*log x`, with `|E2|≤2e-6+366.91/sqrt x`.
- `l2_major_14_7`: at x≥4.9e26, major-arc etaPlus squared norm between8.6296*x and8.79*x.

`BaseGap2.norm_S_etaStar_le_gap` (line243) uses the first to show `.0121*(x/49)` on `majorArcs 8 r0 (x/49) \ majorArcs 8 r0 x`. This separate Platt use survives every Möbius/sieve repair. The needed character region extends to `|δ|=1.2e6/q`; a theorem only for small fixed δ does not automatically suffice.

`MinorTotal.T_le` (line216) needs only the upper side of the second fact, namely `sum |a1|^2≤sig(x)*x`, where `sig=(.640208+366.91/sqrt x)*log x-.021095`. Replacing the two-sided smoothed identity by this upper inequality is legitimate if proved.

`MinorTotal.I0_ge` (line277) needs the major L2 lower side8.6296*x and E≤8e-11*x; its conclusion is8.6294*x. The proposed principal-character-only lower bound in the companion L2 chapter may replace the stronger two-sided L2 producer while preserving this exact interface. It does not change the Möbius or G2 requirements.

### Final numerical assembly

`MinorTotal.NumericsGoal` (line84) asks for r2>150000, the large-sieve/growth side conditions, and `Mexpr x r2≤1.037`. `Mexpr` explicitly contains sig(x), the large-sieve denominator `log(2*sqrt(x/784))+cE`, the pointwise ghatY bounds, and the subtraction8.6294. `MinorTotal.minor_total` (line323) then gives1.0376*x^2/49.

`NumericsFinal.numerics_M` already supplies the exact original goal for every x≥4.9e26. Its cells cover successive cutoffs1.47e27,4.9e27,4.9e28,4.9e29,4.9e31,4.9e35,4.9e43,4.9e59,4.9e101; `asymp_goal` handles the rest. These cells can remain intact only if their input interfaces stay intact. Preserving T2=.37273 and Type I coefficient2.8 is the reason for the relaxed internal G2 design.

## 8. Concrete completion sequence and acceptance conditions

1. Validate the finite psi extraction and exact `bTerm_le` range; confirm no Platt or new assumption survives its elaborated type. This yields a real unconditional improvement but is not the full bridge.
2. Freeze a candidate complete psi envelope, including the interval `[1e9,eventual cutoff]`. Prove its interval transitions and endpoint cases. Prime-estimates owns the analytic producer; this chapter owns testing it in the Schoenfeld recurrence.
3. Recompute cells against `.10/log x` and certify the terminal Ssum and chosen infinite tail. Alternatively prove the direct weighted square tail and the looser Type I bound. No unexplained finite coverage may enter either route.
4. Certify the exact G2 replay in Lean and keep `T2_le'` and2.8 unchanged. Check every public theorem downstream of `MoebiusProfile`, especially the otherwise stronger `.09` wrapper, and route only the consumers that need weaker estimates.
5. Independently discharge the product/totient, global residual-energy, base-gap character, and smoothed prime-energy obligations. A clean Möbius branch is insufficient for `minor_total`.
6. Reuse `numerics_M` if its exact inputs remain; otherwise regenerate all affected finite cells and the asymptotic inequality. Verify the full scale starts at4.9e26.
7. Assemble unchanged large and finite targets. The final elaborated theorem must take only the original `BinaryGoldbachInput` and conclude the original `Statement`; no `Fact PlattGRH`, no finite-RH premise, no intermediate-profile premise, no additional finite-range premise, and no new axiom or sorry.

The strongest current positive result is the exact arithmetic feasibility of the `.10` profile and `.0089` internal G2 bound. The decisive missing step is a complete analytic bridge producing that profile (or the weaker direct squared-tail target) from the already certified low range. The finite Goldbach branch itself needs no new assumption or extension.

## 9. Additional concrete route: retain E≤8e-11*x with coarse unconditional bounds

A subsequent arithmetic check improves the status of the residual-energy branch in section 7. It supplies a plausible complete elementary proof route, though it remains unformalized.

First establish `psi(t)≤1.4*t` for real t≥1e8. The unconditional Mathlib bound `psi(t)≤log(4)*t+2*sqrt(t)*log(t)` reduces this to the monotonicity of `log(t)/sqrt(t)` for t≥exp(2). At t=1e8, use log4≤1.387, log(1e8)≤19, and sqrt(1e8)=1e4; the coefficient is at most1.3908<1.4. This is a large-argument lemma, not a claim for every t.

Next prove, for y≥4.9e26,

`sum_[n≤y, n not prime] Lambda(n) ≤ 1.5*sqrt(y)`.

Expand the prime powers into their exponent k≥2. The k=2 term is at most `psi(sqrt y)≤1.4*sqrt y`. Bound each remaining term by `psi(y^(1/k))≤4*y^(1/3)` using the global unconditional psi≤4t, and the number of exponents by `log y/log2`. This overcounts harmlessly. The resulting remaining coefficient is at most

`4*log(y)/(log2*y^(1/6))`.

It decreases on y≥exp6. At y=4.9e26, use log y≤61.5, log2≥.69, and y^(1/6)≥28000 (the last inequality is an exact integer-power comparison). This gives less than `.013`, far below `.1`. These crude rational margins avoid any reliance on an RH-quality prime-power estimate.

All large arguments needed by `EBound` meet these thresholds: the low prime contribution is a complete psi sum up to sqrt x, with sqrt x≥2.2135e13; the prime-power block endpoints are at least x≥4.9e26. It is not necessary to bound each small summand by a large-argument theorem. Modify or specialize the partial-sum lemma at x≥4.9e26, keeping its public final statement unchanged.

Replacing the two coefficients in `E_partial` by a=1.4 and b=1.5 yields the sufficient bound

`[1.94^2*(a/2+b)*61.5 + b*2.32^2*1.414214*(.693148/(1-1.414214/4)^2 + 61.5/(1-1.414214/4))] / 2.2135e13`.

The existing final proof already controls `log x/sqrt x≤61.5/2.2135e13`; the constant-over-sqrt-x term uses sqrt x≥2.2135e13. Floating evaluation is approximately `7.293387016600054e-11`, below `8e-11` by about `7.066e-12`. The displayed bound uses rational numbers only, so its strict inequality can be checked exactly in a future Lean numeric lemma. This round did not implement or compile it.

This route should preserve `E_le_14_28`, `MinorTotal.norm_sq_sum_a2_le`, and the error budget in `I0_ge` without any new analytic assumption. Remaining work is the prime-power decomposition with exact floor/exponent endpoints, the two monotonicity lemmas, the large-range specialization of `E_partial`, and kernel arithmetic. It does not address the separate smoothed main-energy or base-gap character estimates.
