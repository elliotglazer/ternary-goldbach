# Review of the principal lower-energy corollary and reduced cutoffs

Independent research audit, 2026-11-11. Source pin: ternary-goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build, canonical edit, or finite-zero computation.

**Verdict:** the q=1 identification and lower-J corollary are mathematically correct for both the original reviewed profile and the proposed reduced profile. No mathematical defect was found in the reduced high-tail or complete mixed-perturbation calculation. The exact scalar replay passed. This approves a conditional research implication, not the unproved finite spectral certificate or its analytic/formal interfaces. The original profile remains the parent's selected route unless separately changed; the two remainder budgets must remain distinct.

## Frozen evidence

Reviewed files in `agents/major-constants`:

| File | SHA256 |
|---|---|
| `RESUME_CUTOFF_OPTIMIZATION_2026-11-11.md` | `672BC36351B4A00F01347F9B56C7BDEDEA4D470A6F2B5E35909E6DB7F28C6832` |
| `resume_cutoff_optimization_20261111.py` | `A00830E61456BDF3C0BC295384E1DD80F961EEAE97D5993B12E61B90B4055C0B` |
| `resume_cutoff_optimization_20261111.json` | `1999BFAA572A7F91F5300E176FA9AF952457F179850B89F7CFB20A356A59BE9D` |

The audit harness `resume_cutoff_review_20261111.py` has SHA256 `728C3F73595C24C72AAC5BDA39A6D56A1A2368BFACA85E6CBD629FB40CF1E862`. It redirects the author's output into this directory, replays the entire finite enumeration and rational assertions, compares its parsed JSON with the author JSON, and adds geometric-denominator, Ep/N-removal and lower-J checks. It exited 0. Its log has SHA256 `0ECE353F5BDE7EE0FC2CBDEF8899F9CCB7779B35333AE9355700BF8CE0136CDC`.

This is an instrumented replay plus source audit, not a second independent implementation of the entire conductor enumeration. Floating Riemann-von-Mangoldt values in the JSON are diagnostics only. The accepted cutoffs, counts, exponential comparisons, and budgets use integers or rational arithmetic. Positive Taylor partial sums give lower bounds for the exponentials, which is the required direction when bounding exponentially decaying errors.

## 1. Exact q=1 term of Ep

Use the actual proposed energy

\[
E_p=\sum_{q\in Q}\frac{\mu(q)^2}{\varphi(q)}
\int_{I_q}|g_q(\delta)-P(\delta)|^2\,d\delta,
\quad I_q=(-D_q,D_q),\ D_q=1200000/\widetilde q,
\]

where `g_q=expTsum(coprimePart q (cP x))(delta/x)/x` and `P(delta)=Fourier(etaPlus)(-delta)` (the source uses its complex embedding etaPC).

The source identities settle every special-case factor:

* `MinorArcs/BaseGap.lean:71`: `coprimePart q a n=if Nat.Coprime n q then a n else 0`. Thus `coprimePart 1 a=a` for every n, including n=0.
* `MinorArcs/LargeSieveWeights.lean:26` and `LargeSieveArcs.lean:34`: `qt(1)=2`, `1 in Qset 150000`, and `D1=600000`.
* `MajorArcs/SumMuPhi.lean:20`: `mPhi(1)=1`. The indicator-squarefree definition agrees with `mu(1)^2/phi(1)`.
* `MajorArcs/ArcChars.lean:33,161,171`: `S etaPlus x alpha=expTsum(cP x) alpha`, the coprime principal character sum equals expTsum, and every conductor-one character sum equals expTsum. Inversion of the principal character changes nothing.

Consequently the q=1 summand is exactly

\[
\int_{-600000}^{600000}
|S(\eta_+,x,\delta/x)/x-P(\delta)|^2\,d\delta.
\]

It has no coprime-removal error, no factor49, and no extra factor x. The source Mellin pole at s=1 produces exactly the Fourier main term with argument -delta; it is already subtracted in this residual. All Ep summands are nonnegative, so restricting this term to `[-4,4]` is legitimate. The open/closed endpoints have measure zero. The relevant integrands are continuous on finite intervals from the source summability and Fourier integrability results.

For the original profile, `sqrt(Ep)<.00020001`; for the reduced profile, `sqrt(Ep)<.0002003`. Either implies the raw local squared L2 error is below `8e-6`. This is an integrated result, not a pointwise .001 bound.

If using the older local lower-energy argument, one must still transfer this raw error to each q's coprime sum before summing q. The additional restricted-interval L2 norm is at most `sqrt(8)*1e-15`. Applying Minkowski and the previously chosen square-split parameters `.00354` and `1e-6` retains `J>8.6296`. The audit explicitly checked this with the larger safe local norm .002829. The stronger direct weighted argument below avoids this extra local adapter.

## 2. Direct weighted lower J

`MajorArcs/EtaPlusL2.integral_fourier_etaPlus_Ioo_bounds:199` is unconditional and supplies the lower Fourier energy .6392 on every symmetric interval of radius at least4. Every q in Q has `Dq>=4`. `SumMuPhi.sum_Qset_mPhi_bounds:108` is unconditional and gives total weight at least13.597558. Hence the weighted principal main energy M satisfies

\[
M\ge .6392\cdot13.597558>2.94^2.
\]

The Hilbert space here is the finite direct sum of the `L2(Iq)` spaces with nonnegative weights mPhi(q); zero-weight moduli may simply be omitted. Reverse Minkowski gives

\[
\Big(\sum_qm_\Phi(q)\int_{I_q}|g_q|^2\Big)^{1/2}
\ge\sqrt M-\sqrt{E_p}.
\]

Exact character Parseval (`MinorArcs/Bombieri.totient_mul_sum_units`) and the principal identities in `ArcChars:161-204` show that J_coprime is this principal energy plus a nonnegative nonprincipal energy. No bound on the latter is required for a lower bound. One should use the identity directly, rather than introduce an unproved nonprincipal cap merely to invoke the two-sided `sum_units_sq_bounds` wrapper.

The actual full/coprime norm correction follows from unconditional `ArcChars.norm_S_sub_coprime_le:314`. After division by x it is at most `1e-15` pointwise for each residue. The direct-sum measure obeys

\[
\sum_q2D_q\varphi(q)\le7.2\cdot10^{11},
\]

because `phi(q)<=q<=qt(q)` and `#Q<=300000`. Its squared correction is at most `7.2e-19`, and its norm is strictly below `1e-9`. A second reverse triangle inequality gives

\[
J_{full}>(2.94-\epsilon-10^{-9})^2>8.6296,
\]

with epsilon=.00020001 for the original profile or .0002003 for the reduced profile. For the latter the exact lower rational is `8642422270240490601/10^18`.

The arc/Fourier substitution is exactly the one in `L2Major.integral_main_term:65`; the outer normalization J is x^-1 times the major-arc energy. The unconditional covering/disjointness lemmas in `LargeSieveArcs` transfer the direct-sum bound to that integral. Their domain inequalities hold at x>=4.9e26 with R=150000 and delta0=8. This does **not** invoke the existing conditional `L2Major.Jq_bounds` or `l2_major_bounds:309`; those are consumers to replace. `MinorTotal.I0_ge:274` needs the resulting lower side. No hidden Platt estimate is introduced by this lower-energy deduction.

Thus the separate 2750-cell local certificate is unnecessary within either of these finite-family branches. This does not discard its independent route or make the broad Ep estimate unconditional.

## 3. New finite domain and the subset issue

The proposed heights are

\[
H_+(c)=\lceil200+\max(300,(484/7)D_c)\rceil,
\quad H_*(c)=\lceil\max(250,(484/343)D_c)\rceil.
\]

The active primitive family is unchanged, including conductor1 and all Gauss-active high conductors. The exact induction condition `q=cr`, r squarefree and coprime to c implies `Dq<=Dc`; the relevant star twist is delta/49. Primitive conductor counts vanish when v2(c)=1, so excluding those empty families loses no characters. The integer replay verifies `Hnew<=Hold` and `Hstar_new<=Hplus_new` for every active c.

The required finite statement remains beta<=111/200 for actual nontrivial zeros through the new plus height, together with global reflected QRH on all other heights. Zeros between the new and old cutoffs are handled by the new tail; they are not assumed to obey the finite .555 bound.

A necessary interpretive clarification: the squared norm of a signed zero sum is not monotone under deleting zeros. The low-energy bounds are retained by **reapplying their uniform Gram/count estimates** to the smaller carrier, not by claiming its actual norm is at most the old actual norm. This is valid here: the absolute Gram row bounds 23000 and 102000 hold for arbitrary finite carriers with the same window counts; the pointwise triangle bounds and the factor25 fourth-moment envelopes are polynomials with nonnegative coefficients in Nplus,Nstar. Their old count ceilings are still upper bounds. The same reasoning retains the unweighted low energies `<.002` and `<10000` used in the perturbation argument. No assertion about actual signed-sum monotonicity is needed.

## 4. Source-faithful high tails

For plus set d=Dc and T=Hplus-200; for star set d=Dc/49 and T=Hstar. Then T>=22pi*d and T>=300 or250. These exceed the source requirement `max(10pi*d,50)`. `EtaPlusMellin.norm_mellin_fP_tail:286` preserves the bandlimit200 and uses the window index `floor((|gamma|-Hplus)/4.4)`. Its smoothing prefactor is `<130`. The actual etaU convolution reviewed previously gives the same Gaussian tail with prefactor2, no height shift and no s+2 shift. Its eta2 moment is bounded by2 throughout the reflected strip.

`ZeroSumGen.count_tail_windowG:121` counts **both signs and multiplicities**. Its count is `2Z3g+2c3g(k+1)`, with Z3g<400 and c3g<53/H at the actual counting height H. These bounds remain valid below1000: the BP/BPz2 upper logarithm estimates depend on an upper height bound and positive H; the coefficient c3g scales explicitly as 1/H. The new minimum250 is positive and is used in the revised geometric estimate. Zeta uses its own polynomial, and general primitive characters use BP(c), kappa11.

For both geometric ratios use `G(d)=3+d/2.7`. The source definitions are `rhoB=exp(-.1398*4.4)` and `rhoA(d)=exp(-1.93*4.4/(pi(d+1)))`. The elementary inequality `(1-exp(-a))^-1<=1+1/a`, together with

\[
1.93\cdot4.4>(22/7)2.7,
\quad1+1/(.1398\cdot4.4)<3,
\]

proves each inverse denominator is below G. The added3 is essential for rhoB near zero twist. At the counting height H, `H>=250` and `H>=69d` imply `G/H<1/39` by splitting d<=4 and d>=4. Thus each window sum is

\[
800G+(106/H)G^2<803G.
\]

There is no missing extra factor2: it is already in800 and106. This is below180 million for plus and4 million for star.

`ZeroSumBound.EA:92` is exactly `.588*u^2*exp(-.1065*u^2)`, with u=T/(pi|delta|), or0 at delta=0. It decreases for u>=22, giving `<2e-20`. The source EB is `.892*T*exp(-.1598*T)`. To sum EB, use the correlation between d and T:

\[
803G(d)<5T+2500.
\]

Then `T(5T+2500)exp(-.1598T)` decreases on T>=250, since its logarithmic derivative is at most `2/T-.1598<0`. Evaluating at300 for plus and250 for star, including their respective prefactors, gives coefficient sums `<4e-13` and `<1e-11`. The exact exponential assertions pass.

Global beta<=7/8 yields the normalized scale x^-1/8 or y^-1/8 for every high zero. The exact endpoint inequalities `x0^(1/8)>2125` and `y0^(1/8)>1333` therefore give

\[
|t_+|<3\cdot10^{-13},\qquad |t_*|<10^{-14}.
\]

These bounds are uniform in the relevant twists, all x>=x0, and every finite explicit-formula rectangle. Summing the convergent geometric envelopes permits the good-height limit. Poles, possible zero-at-zero terms, and contour contributions are not silently included among the nontrivial high zeros.

## 5. Complete perturbation budget

Retaining the separately reviewed contour/zero0 allowance `<1e-18` and primitive-to-coprime removals `1e-15` and `1e-12` gives pointwise perturbations

\[
d_+<4e-13,\qquad d_*<2e-12.
\]

The finite .555 low bounds and actual Fourier multipliers are unchanged. The exact Gauss identity `sum_psi |tau_q(psi)|^2=phi(q)^2` controls the perturbation measures. The stated norm allowances are valid: R_Aplus and R_N `<900000*dplus`, R_Astar `<600000*dstar`, and R_Ep `<3e-7`. For Ep the crude measure bound3.6e11 suffices; the audit checked `3.6e11*(4e-13)^2<(3e-7)^2`. The N cap also remains true after the enlarged correction, as an explicit extra assertion verifies.

For Cross retain the two independent character vectors. At each q, expanding their tensor product gives the terms `rplus tensor lstar`, `lplus tensor rstar`, and `rplus tensor rstar`. Minkowski in the actual q/character-pair/twist space and the known low second moments give

\[
R_{mix}\le d_+\sqrt{300000\cdot10000}
+d_*\sqrt{300000\cdot.002}
+d_+d_*\sqrt{3.24e22}.
\]

The rational bounds55000,25,180000000000 for the three square roots give

\[
R_{mix}<689067/31250000000000<3e-8.
\]

This is the **complete normalized norm perturbation**, with the high tails, contour/zero0, and primitive-to-coprime pieces all included. It is not an L2-to-L4 inference and not a same-character diagonal approximation. Together with the separately reviewed factor25 low bound `Cross_low<2.5e-7`, it implies `Cross_coprime<(.0005+3e-8)^2<7e-7`. The second-moment caps remain Aplus<5e-7, Astar<2.5e-7, N<1.23 and Ep<1e-4. Hence the allocated Astar+Cross cap9.5e-7 is unchanged.

The later coprime-to-full cubic transfer is a distinct previously reviewed step. These revised coprime caps feed it; they do not eliminate its correction. In particular the reduced profile must use mixed allowance **3e-8**, not the original profile's2e-10.

## 6. Scope of acceptance

The exact enumeration and workload proxies replay correctly. Weighted height sums and crude Jensen-count ceilings are not actual zero counts, runtime, storage estimates, or proof sizes. The comparison with original Platt heights is only on the same active family and does not establish that a finite .555 certificate is cheaper.

Both original and reduced routes remain conditional on an actual finite spectral certificate, the global7/8 provider, the actual-smoothing Gram and inversion bridges, the etaU explicit formula, and proof-producing replay of the finite arithmetic. No zeros were certified in this audit. The new lower-J deduction is a valid structural consequence of the selected Ep proof; it does not supply that proof independently. No canonical theorem is marked closed or frozen by this report.
