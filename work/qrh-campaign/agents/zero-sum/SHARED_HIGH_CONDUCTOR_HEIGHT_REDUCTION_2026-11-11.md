# Smaller shared finite heights at large conductors

2026-11-11. Research-level conditional implication with exact rational scalar checks. No spectral evaluation, zero scan, Lean build, new declaration, dependency change or frozen-file edit. The real-part bound remains beta<=111/200. The separately proposed high-conductor real-part relaxation is **not** adopted here.

A parity-aware height reduction fits every retained major and base-gap budget. The finite certificate requirement is unchanged for c<=100000. For the remaining active conductors it can be replaced by

\[
 H_{\rm new}(c)=\begin{cases}
  50000000/c,&c>100000\text{ odd},\\
  99000000/c,&c>100000,\ 4\mid c.
 \end{cases}                                                   \tag{1}
\]

All heights are exact rational numbers and are inclusive. High odd conductors lose half their previous required height; high even conductors lose one percent. This is a sufficient finite-spectrum profile, not a supplied spectral certificate or a runtime forecast.

## 1. What changes and what is retained

Let Hold(c)=min(Hp_old(c),100000000/c), with the old plus/star cutoffs from the reviewed common-height note. For c>100000, Hp_old>=1200 while 100000000/c<1000, so Hold=100000000/c exactly. Also Hs_old=1000 throughout this affected range. Thus the new plus and star low cutoffs are both Hnew for affected conductors. For smaller conductors retain their respective old common-profile plus/star cutoffs, and retain the shared height Hold.

Use the finite strip [.445,.555] only through these new cutoffs. Every zero above them is estimated using the global reflected [1/8,7/8] strip and the actual Mellin tail. No finite-strip assertion is used in the removed band. The old count/Gram/fourth-moment envelopes still bound the smaller low carriers: they are positive upper estimates in terms of counts and kernels. This does not assert monotonicity of a signed zero sum when terms are deleted.

The following original finite-low bounds remain available:

* sqrt(Aplus_low)<.00007, sqrt(Astar_low)<.00049;
* N_low<.001, sqrt(Ep_low)<.0002;
* integrated low-plus energy <.002 and low-star energy <10000;
* the **direct** same-modulus mixed bound Cross_low<1e-9, hence sqrt(Cross_low)<.000032.

The last bound is stronger than the deliberately loose factor-25 allowance used in the common-height note. It is already proved on paper and independently reviewed in RESUME_FAMILY_MIXED Section 2: actual plus L2 times an independently established star Linfinity estimate gives Cmix<6.794e36, followed by `(xy)^(-.89)` at x0*y0=49*10^50. The new postprocessor rechecks the resulting power inequality exactly. Both character indices and all Gauss weights remain present; this is not an L2-to-fourth-moment inference. Reapplying the same positive formula with old count proxies is hereditary to the new low sets.

## 2. Tail applicability and the small-height count range

Retain Dc=1200000/qt(c), with qt(c)=2c for odd c and c otherwise. For affected conductors, Hnew is at least330. The source Gaussian tail needs

\[
 H-200\ge\max(50,10\pi D_c).
\]

For odd c<=150000 and even c<=300000, respectively, the exact sufficient checks using pi<22/7 are

\[
 50000000-200(150000)>10(22/7)600000,
\quad
 99000000-200(300000)>10(22/7)1200000.                    \tag{2}
\]

Both hold. The first also shows the odd minimum H>333, and the even minimum is330, so H-200>=130>50. Every conductor cell in the script separately checks the stronger two-corner condition with its minimum H and maximum D; (2) alone is not substituted for that cell check.

The old common-height report stated H>=1000/3. The new minimum330 is slightly smaller, so the count justification is made explicit. The source has

\[
 Z3g(B,H)=\log(B(H)/.355)/\log(10/3),\qquad
 c3g(\kappa,H)=4.4\kappa/(H\log(10/3)).
\]

For changed conductors H<1000. The actual Dirichlet BP polynomial gives

\[
 \log(BP(c,H)/.355)
 <8+9(13)+13+8+10(8)+2=228<400.
\]

Here log1400<8, log(c+1)<13, log(H+22)<8, log(1.25(H+11))<8 and -log(.355)<2 follow from rational powers of 2.7<e; log(10/3)>1 follows from e<3. The script checks all needed rational comparisons. Therefore Z3g<400 remains valid at330. Since kappa<=12, c3g<52.8/H<53/H. The unchanged conductors retain the prior BP/BPz2 proof. These are bounds on the actual finite carrier with multiplicities, not point counts or spacing assumptions.

## 3. Actual plus-tail bound and finite arithmetic

Use the same actual Fourier representation and two frequency bands as the reviewed common-height proof. The total |ghat| mass is <3.5, and the portion 100<|2pi xi|<=200 has mass <.00625. The latter follows from the source second-derivative energy <=368 and the weighted Plancherel/Cauchy bound; its formal bridge has the same status as in the accepted predecessor.

Define the source functions

\[
 EB(t)=.892t e^{-.1598t},\qquad
 EA(t,D)=.588(t/(\pi D))^2e^{-.1065(t/(\pi D))^2},
\]

with EA(t,0)=0. Set G(D)=3+D/2.7,

\[
 GB(H)=2400+954/H,\qquad
 GA(H,D)=800G(D)+(106/H)G(D)^2.
\]

The count-tail windows are based at the **actual H**, while the Gaussian factors use H-100 and H-200. The shifted-floor argument in EtaPlusMellin applies separately to each band. A normalized per-primitive-character high-tail bound at x0=49*10^25 is

\[
 t(c)={1\over2125}\bigl[
 3.5\{EB(H-100)GB(H)+EA(H-100,D_c)GA(H,D_c)\}
 +.00625\{EB(H-200)GB(H)+EA(H-200,D_c)GA(H,D_c)\}\bigr]. \tag{3}
\]

Both signs, all multiplicities and arbitrarily high outer rectangles are covered by the source geometric window sum. The low part includes equality |gamma|=H; the high part is strict. The existing finite-to-good-height limit join therefore applies without an infinite signed-series rearrangement.

The new script covers all affected conductors by 2415 parity-specific cells, each of absolute span at most100. A cell [lo,hi] uses D(lo) and H(hi). EB decreases past50, and u^2 exp(-.1065u^2) decreases past u=10. GA increases with D and decreases with H. Hence the two-corner substitution enlarges (3). Pi is replaced by22/7 in EA, again enlarging it. Capping t at2000 in EB or u at40 in EA enlarges the respective decreasing envelope.

Exponential upper bounds are reciprocals of positive rational Taylor lower sums: if z=k+r with integer k>=0 and 0<=r<1, use

\[
 e^{-z}\le\left(\sum_{j=0}^{20}1/j!\right)^{-k}
                 \left(\sum_{j=0}^{16}r^j/j!\right)^{-1}.
\]

The resulting t(c) is rounded upward to denominator10^20 and stored for every cell. These are elementary scalar bounds, not evaluations of an L-function, transform, or actual zero.

## 4. Gauss-weighted aggregates and deliberate overcount

For active ambient modulus q, a primitive conductor c contributes exactly when c divides q, q/c is squarefree, and gcd(c,q/c)=1. Its squared Gauss norm is c, and there are a(c) actual primitive labels. Put

\[
 T_q^{\rm new}=\sum_{\substack{c>100000\\c\text{ eligible at }q}}
                   {c a(c)\over\phi(q)}t(c)^2,
\quad
 S_q^{\rm old}=\sum_{c\text{ eligible at }q}
 {c a(c)\over\phi(q)}(49\cdot102000)N_{s,\rm old}(c)Y,
\]

where `Y=5.625e-23>y0^(-.89)` and `Ns_old=ceil(400*(2Hs_old/3.48+2))`. The script reconstructs the primitive counts and independently checks sum_eligible c*a(c)=phi(q)^2 at every ambient modulus. Inversion preserves these counts and support. No factor 1/sqrt(c) is inserted.

The fresh affected-conductor bounds are

| Aggregate | Exact rational upper bound | Decimal summary |
|---|---|---:|
| sum_q 2Dq Tq_new | 10338958863784669627/10^20 | .103389588638 |
| sum_q Tq_new Sq_old | 836674143147024781473/(8*10^27) | 1.045842678934e-7 |
| sum_q mu(q)^2/phi(q)^2 * min(381.22,2Dq*1.2534^2)*Tq_new | 87753955642097904833/(25*10^30) | 3.510158225684e-12 |

The last displayed denominator is `25000000000000000000000000000000` in the receipt. It equals 25*10^30. All finite-sum rounding is upward. The mixed aggregate is the actual same-q two-character high-plus/low-star energy bound, not the product of unrelated sums.

For unchanged conductors retain the prior **whole-family** bounds .025, 2.5e-8, and1e-20, respectively. Adding those whole bounds to the fresh affected-conductor bounds deliberately counts the old affected tails twice in the upper envelope. This is harmless: all terms are nonnegative, and it avoids subtracting rounded prior cells. It yields reusable total high-tail bounds

\[
 N_T<.129,\qquad I_T<1.30\cdot10^{-7},\qquad
 A_T<3.511\cdot10^{-12}.                               \tag{4}
\]

The exact totals are in the receipt, before this final rounding. The largest fresh primitive tail is <7.57e-6; the unchanged old bound is smaller. The factor x^(-1/8) in (3) makes these endpoint envelopes valid for every x>=x0. The star Gram exponent similarly decreases with y>=y0. No monotonicity of the actual oscillating sums is assumed.

## 5. Star, vertical and complete major budget

For changed conductors Hs=Hnew>=330 and d=Dc/49<=12/49. There is no frequency shift for etaU. Its positive mixture mass <2 gives

\[
 {2\over1333}\left[
 EB(330)(2400+954/330)
 +EA(330,12/49)\{800(3.1)+(106/330)(3.1)^2\}\right]
 <1.33\cdot10^{-20}<10^{-18}.                           \tag{5}
\]

The script checks (5) anew; the old1000/3 endpoint is not reused. The vertical-line estimates and possible zero-at-zero term do not depend on where the nontrivial low/high cutoff is made. The actual smoothing/twist ranges are unchanged. Thus the existing complete non-high-plus errors remain

`d0=2e-15` for plus and `dstar=2e-12` for star.

With NT and IT the exact total bounds preceding (4), all remaining mixed perturbations have norm at most

\[
 E=d0\,55000+dstar\,25+dstar\sqrt{300000N_T}
       +d0\,dstar\,180000000000
 <5.526\cdot10^{-10}.                                  \tag{6}
\]

The four terms bound, respectively, plus residual times low star, star residual times low plus, star residual times high plus, and both residuals. They retain the two-character product space and need no prior J bound. Using the direct finite low bound from Section1 gives

\[
 \mathrm{Cross}_{\rm coprime}
 <(.000032+\sqrt{I_T}+E)^2<1.537\cdot10^{-7}.
\]

The final exact postprocessor also checks

| Quantity | Certified upper summary | Required cap |
|---|---:|---:|
| Aplus | 5.166094e-9 | 5e-7 |
| Astar | 2.4127744e-7 | 2.5e-7 |
| N | .152346 | 1.23 |
| Ep | 4.00040001e-8 | 1e-4 |
| Astar+Cross | 3.949248e-7 | 9.5e-7 |

Specifically Aplus uses `(.00007+sqrt(AT)+2e-9)^2`; N uses `(.032+sqrt(NT)+2e-9)^2`; Astar and Ep retain their old formulas. The c=1 cutoffs and tails are unchanged, so the principal weighted lower-J estimate remains `(2.94-.00020001-1e-9)^2>8.6296`. Upper J<=10 follows through the same reviewed Ep/N bridge. The existing coprime-to-full removal and final major/minor/nonprime constants are unchanged.

Keeping the older loose finite mixed norm .0005 would instead produce Astar+Cross about9.8084081e-7 and fail that sufficient budget. The aggregate receipt deliberately retains this failure. The second, separately pinned postprocessor uses the already-reviewed genuine direct bound and succeeds. No zero set, candidate height, or computed tail was changed to conceal that failure.

## 6. Base-gap coverage at the unchanged dynamic cutoff

Keep every actual base-gap cutoff

\[
 H_b(q,U)=\max(250,\lceil242U/(7q)\rceil),\qquad U\le1200000.
\]

The base-gap character expansion is at original modulus m=q or2q. Every supported primitive c divides m. For odd c, qt(c)=2c<=2q implies c<=q; for even c, c<=2q. Therefore

\[
 cH_b\le\max(250c,290400000/7+c)\quad(c\text{ odd}),
\]
\[
 cH_b\le\max(250c,580800000/7+c)\quad(c\text{ even}).
\]

At the largest allowed c these are strictly below50m and99m respectively:

`250*150000<50m`, `290400000/7+150000<50m`,
`250*300000<99m`, `580800000/7+300000<99m`.

Thus every base-gap low carrier, including its closed endpoint and all nonzero Gauss support, remains below Hnew. Smaller c retain the original height proof. The etaU13/8 low bound, base-twist3e-14 tail/vertical/zero0 allowance, exact Gauss-weight transfer and q=1,2,3 exceptional-prefix joins are all unchanged. In particular no base-gap high-tail estimate is re-used at a smaller dynamic H: that H is not changed at all.

Principal psi is also unchanged because c=1 is untouched. All real-axis and inclusive-height conventions remain those of the reviewed finite-carrier and shared-strip assembly. This proposal changes only the amount of finite spectrum required at c>100000.

## 7. How far this tail recipe can go

For a numerator-only profile K_even/c the outer band still requires, at c=300000,

\[
 K_{\rm even}\ge60000000+12000000\pi,
\]

about97.70m. For odd c=150000 it requires

\[
 K_{\rm odd}\ge30000000+6000000\pi,
\]

about48.85m. These are exact applicability barriers for this full-band source Gaussian inequality with shift200, not lower bounds on the true sufficient finite height. The proposed99m/50m numerators lie safely above them and every interval cell checks its own condition. A substantially smaller profile needs a different treatment of the remaining Fourier band or another tail inequality; simply decreasing K in this recipe is not justified.

The affected 75000 conductors carry3,695,775,113 primitive characters. Their count-weighted height sum drops from approximately2.463857858925e12 to1.634350291196e12, an upper ratio below.66333. Each displayed sum is directed-rounded per term at10^-6, with total error<.075. This is an arithmetic height proxy, not a zero count, number of evaluator operations, certificate size, or runtime saving.

## 8. Reproducibility and preserved failures

All new scripts are in this directory and use only integers, Fractions, elementary positive Taylor sums, integer square roots and finite arithmetic sieves. Decimal displays are explicitly excluded from acceptance.

The first development script used exact rational sums for the optional height proxy. It reached serialization but failed because the numerator/denominator exceeded Python's4300-digit string limit. That version is preserved as `shared_high_conductor_height_reduction_20261111_v1_failed.py`; it produced no accepted receipt. The completed version uses directed rounded proxy sums. Its scientific tail aggregation is unchanged and completed in about19.15 seconds on this run. Timing is telemetry for scalar arithmetic, not a controlled speed comparison or spectral-production forecast.

Run the aggregate script, then the separate budget postprocessor. The aggregate's status intentionally remains `FAIL_SUFFICIENT_SCALAR_BUDGET` for its coarse-low comparison; successful final acceptance additionally requires the postprocessor status `PASS_EXACT_SCALAR_REDUCED_HEIGHT_FIXED_BETA_0_555`. Exit status alone is not the combined mathematical verdict.

| Artifact | SHA256 |
|---|---|
| `shared_high_conductor_height_reduction_20261111.py` | `BB53DC83F67E4868CF360F4C44D978EE40655BA5C1D2D17D05D81B45CACFACCE` |
| same-stem `.json` | `4E4127E970120A5BB5441CF0AF3F419F6262F616C9FA9E715A70C1E8D91CCA1A` |
| same-stem `_cells.json` | `7E4A7D78A90E7ABFB08B5486F8DB003A01DFF11DEC4DA1ABB3AB602DFAF11AC2` |
| `shared_high_conductor_height_budget_20261111.py` | `F644E2EFAC56BA3291F65D2C71E14DF648235309A35664373738037A7C842545` |
| same-stem `.json` | `E6B14CAA53D6A30A08048773088D60B2D69ADCCC9A813698DBC0FF66AED1CBFA` |
| preserved `_v1_failed.py` | `9F4A683D2521680B5ED48EF7B886F8AB7493868C0C3E36FFC28A789F935D8D07` |

## 9. Source and predecessor pins

Lean source is read-only at `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Key source files: `Explicit/ZeroSumGen.lean` SHA9096C5D611A09FFCF5A4516BFDDC1E518B9917C52B5BC206216AF86A31A52389, count/window/E2g at77-80/121/195; `Explicit/ZeroSumBound.lean` SHAA1294627F676EC49BED1BD86407A9460DC569B77AF8CBE8D65F1F49129BF17D4, EB/EA89-105; `Explicit/EtaPlusMellin.lean` SHABA9CD4DFA03A6CB36482C52EB135C81D8BA3AD117510A96AF308B2D4FE8DD2BC, actual integral197-205 and shifted tail286-307; `MajorArcs/HHFourier2.lean` SHAB90303E4F7F4404F7587590A30982081EE026F74F307D866DF7443A9F3F38254, second-derivative energy195 and Fourier identities217-269.

Paths in the table are relative to `work/qrh-campaign/agents/`.

| Accepted input | SHA256 |
|---|---|
| `major-constants/RESUME_COMMON_HEIGHT_MAJOR_2026-11-11.md` | `79833F8D5D5856E000A96D3F5CCA9FC9E26CB3BAF637CDE089FEFDD703436BA7` |
| `independent-feasibility/REVIEW_COMMON_HEIGHT_NEW_2026-11-11.md` | `3536A5E362A7E72DB10A4DC909A972CECE2DD8E11BAA2F5B3DB1A1BDD90CAA87` |
| `major-constants/RESUME_CUTOFF_OPTIMIZATION_2026-11-11.md` | `672BC36351B4A00F01347F9B56C7BDEDEA4D470A6F2B5E35909E6DB7F28C6832` |
| `mellin/RESUME_CUTOFF_REVIEW_2026-11-11.md` | `1F284A8E7962DA9241DEAF05BDB876EAB9C6CCA0FBBBC4991D5B46F4C446200D` |
| `integration/BASE_GAP_ACTUAL_SOURCE_JOIN_2026-11-11.md` | `F0BC1D7899044C27E819743BBA4B157D51F42848B87A51D37764CDB8B3B6C9E0` |
| `zero-sum/RESUME_FAMILY_MIXED_2026-11-11.md` | `5E7FB33EDF2A65F058DC605A3054FE37DFDF14E9ACDCB8409A8211DCF1F9D09D` |
| `audit/RESUME_FAMILY_REVIEW_2026-11-11.md` | `4FFC26AF43DA337652FC86167019328BB1D788379C0C84E43C7D8722A81ACF9C` |

The analytic rules and exact scalar comparisons give a conditional smaller sufficient profile. Full finite spectral evidence, global-provider closure and Lean implementations retain their existing open status. This note neither adopts nor validates a simultaneous relaxation of beta.
