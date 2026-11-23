# Actual reflected low-row energy: bounded source audit

Date: 2026-11-11. This is a source and paper audit, with no Lean build, declaration change, analytic evaluation or scan.

## Verdict and previous coverage

The inspected finite assembly of `SevenEighths.InverseReflectedPhase.low_original_completed_energy`, `Reflection/LowOriginalEnergy.lean:18`, preserves the actual completed rows, tuple coefficients and powerful-part weight. I found no missing multiplicity, loss of uniformity, uncharged finite cardinality or use of a default divergent sum in this assembly. This is a **conditional local-source PASS**, not validation of every reflected analytic input.

The previous endpoint report, `QRH_LOW_PROBE_ENDPOINT_ANALYTIC_AUDIT_2026-11-11.md`, SHA-256 `C6514DD1CEE85B24417B7E48D857D0E870CBB9F7DFB08264E764567E05E07C95`, explicitly left this theorem open. Its independent review is `prime-estimates/REVIEW_QRH_LOW_PROBE_ENDPOINT_ANALYTIC_AUDIT_2026-11-11.md`, SHA-256 `2D511E85336700716448B15AF2DFE89EC285EF1AD61484E0CA25DFCF4002F28A`. Searches of existing audit and obligations reports found no prior closure of this exact producer. The present audit advances through its puncture, residual-fiber, inactive-slot, source-label and dyadic assembly. It also checks the actual parameter specialization at the entry to the lower global reflected estimate. It does not repeat the detector Gaussian or Gram analysis.

All source paths below are relative to `C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/`. The hash table pins the read source and expressly named lower interfaces. A whole-file pin is not a claim to have audited every declaration in that file.

## 1. Actual target and quantifiers

Write \(N(I)=\operatorname{absNorm}(I)\). Fix a nonzero ideal \(Q\), squarefree ideal \(F\), nonzero Eisenstein element \(m\), and a smooth complex function \(W\) supported in \([\mathrm{lo},\mathrm{hi}]\) with \(\mathrm{lo}>0\). The source assumes the good ramified element and \(2\) divide \(m\), that \(Q(72)\mid(m)\), and that every fixed bad prime divides \((m)F\). These are actual ideal/element divisibilities, not numerical norm inequalities.

For fixed \(C_k>0\), \(0<\eta\le1\), and slot cap \(r_{\max}\), the theorem chooses \(n,C,Z_0\), with \(C>0\) and \(Z_0>1\), before all subsequent data. The data include the slot type of cardinality at most \(r_{\max}\), finite parent ideals, finite prime lists, scale parameters, coefficient character, unit, twist height and weights. Required scale conditions are

\[
Z\ge Z_0,\quad 0\le d\le1/6,\quad
0\le\ell_0\le1/6-d+\eta,\quad |\mathrm{shift}|\le\eta,
\qquad N(I)\le C_kZ^{5/6-2d},\ I\ne0.
\]

The lists are pairwise disjoint and consist of maximal prime ideals avoiding the good ramified element and residue characteristic two. Their norm caps satisfy \(H_i\ge1\), \(N(P)\le H_i\), and \(\prod_iH_i\le Z^{\ell_0}\). The multiplicative map \(\Psi\) is bounded by one on every element and actually factors modulo \(Q\). The weights satisfy \(|w_i(P)|\le1\).

With \(W_\theta=\texttt{normTwistedSource}\ W\ \theta\), \(X=Z^{1+\ell_0+\mathrm{shift}}>0\), and the source's actual `rowTwist`, define the row value by the finite tuple sum

\[
R_I=\sum_{p\in\prod_i\mathcal L_i}\Bigl(\prod_i w_i(p_i)\Bigr)
\operatorname{markedCompletedT}\bigl(\operatorname{rowTwist}(\Psi,m,\operatorname{gen}F,u\operatorname{gen}I),W_\theta,X,
A\mapsto\prod_i1_{p_i\mid A}\bigr).
\]

The conclusion is exactly
\[
\sum_{I\in\mathrm{parents}}|R_I|^2
\le C(1+|\theta|)^n Z^{5/6-2d+507\eta}.
\]
It is an energy bound for these actual rows. It is not a pointwise estimate for an arbitrary replacement coefficient array. Constants may depend on the fixed smoothing, period/mask data, \(C_k,\eta,r_{\max}\); they do not depend on the later lists, parent set, \(Z,d,\ell_0,\mathrm{shift},\Psi,u,\theta,w\).

`Descent/Completion.lean:15,36,44` defines the nested ideal sum and proves product-index summability from `completedT_finite_support` for compactly supported smoothing and \(X>0\). The actual twisted smoothing retains the given support, as used in `LowCompletedFiber`. Thus the target is not made small by Lean's totalized `tsum`. The lower completed-reflection identity is still an explicit dependency, discussed below.

## 2. Puncture is an exact zero identity

`LowPunctureLists.lean:13,31` removes precisely the listed primes \(P\) containing \(m\). For a removed tuple, its mark vanishes unless \(P\mid I J^3\). If that divisibility holds, primality gives \(P\mid I\) or \(P\mid J\). In the first case the actual masked column weight is zero; in the second the actual cube weight is zero. `PuncturedMarks.lean:11` proves every summand zero, and hence the entire completed term is zero. This argument does not interchange a conditional series.

`sum_puncture_lists` then reindexes the surviving tuple subtype without changing its weights. For a surviving maximal prime, \(m\notin P\) and \(Q(72)\mid(m)\) give \(\operatorname{IsCoprime}(Q(72),P)\), by `LowPunctureLists.lean:23`. All list, cap, disjointness and weight bounds restrict to the surviving lists. Therefore `LowOriginalEnergy` reduces to `low_completed_rows_energy` with exactly the same constant and exponent. There is no assertion that an arbitrary deleted prime contributes a small error.

## 3. Residual fibers and the actual reflected source

Set \(M=(m)F\). For each nonzero parent,
\[
I=A(I)T(I)K(I),\qquad
A(I)=\operatorname{rowPowerfulPart}I,\quad
T(I)=\operatorname{rowMaskPart}(I,M),\quad
K(I)=\operatorname{rowResidualPart}(I,M).
\]
Within a fixed \((A,T)\) fiber, \(K\mapsto ATK\) reconstructs the original ideal. `Eisenstein/ReflectionFibers.lean:379,394` and `Reflection/RowReindex.lean:33,43` establish injectivity and exact finite energy reindexing. Passing to the image of residual ideals loses no repeated original rows. The fixed bad-prime assumption gives admissibility of the residual ideals; nonzero parent hypotheses justify the norm divisions and reconstruction cancellation.

`LowCompletedFiber.lean:16` takes \(Q_0=Q(72)\), \(c=9\operatorname{gen}(Q)72\), and the actual finite Fourier geometry modulo \((c)\). Every geometric denominator divides \(c\); the controlled arithmetic level is \(9c\). The coefficient
\(a_h(K)=\texttt{fixedThetaRowCoeff}\ c\ (\texttt{residualOriginalData.fixedFactor}\ \Psi\ Q)\ h\)
has norm at most one. This uses the actual coefficient bound `GaussSum/ResidualEquivalence.lean:574`, not an assumption that all Fourier coefficients are exactly one.

`CompletedFiberSource.lean:50` gives, on each residual row, the exact identity
\[
R_{ATK}=\vartheta^{-1}\sum_h a_h(K)
\sum_{A_0\subseteq\mathrm{pool}} b_{A_0}
\sum_{T_0\subseteq\mathrm{slots}}V_{h,A_0,T_0}(K).
\]
Here \(\vartheta\) is the actual `thetaDerivativeScalar`, and \(V\) is `originalInactivePhysical`, whose definition retains all inactive and active supported slot choices, inverse ideal-norm factors, reflected exponents and `mixedReflectedValue`. The notation \(A_0,T_0\) denotes subsets, not the ideal factors \(A,T\). `OriginalWeights.lean:12,25` gives \(|b_{A_0}|\le1\) from its actual product of either \(1-N(P)^{-1}\) or zero. All finite Fourier/subset labels remain in the identity.

I checked the reconstruction substitutions in `CompletedFiberSource` and the finite change of supported choices in `OriginalActiveReflection.lean:26`. They consume `actual_marked_slot_split_reflection` and `originalSplitControlled_physical`; this audit does not claim to reprove those lower theta/reflection identities. The inverse derivative scalar is retained in the final constant as \((|\vartheta^{-1}|^2+1)\), rather than silently normalized to one.

## 4. Actual dyadic cell specialization and tuple multiplicity

The analytic entry retained by this audit is `LowGlobalBudget.lean:14`, `original_low_global_full_budget`. Its actual row is `literalWholeRow`; its bound includes
\[
C(1+|\theta|)^n Z^{5/6-2d+200\eta+\pi_0+\kappa+\rho L_{\rm pool}-O/2}.
\]
The symbol \(\pi_0\) here is the source's loss parameter, not the circle constant. All coprimality, residue-characteristic, scale, smoothing and controlled-completion hypotheses remain required.

`LowMemberBudget.lean:15` transports this bound to actual member tuples. The map \(p\mapsto\prod_i p_i\) is injective on the allowed tuples. Indeed, a prime in slot \(i\) dividing an equal product must equal a prime in some slot \(j\); pairwise disjoint lists force \(i=j\). `Descent/SlotProducts.lean:14` proves this argument. `FixedTuples.lean:20,25` supplies the restricted injection and supported-choice equivalence. `ActiveProducts` and `TupleMembers.lean:67` use this injection in the exact finite sum, so a coefficient at a product is the coefficient of its unique tuple, not a sum whose norm was incorrectly bounded by one. Noncoprime row/tuple pairs remain explicit zero branches.

`LowMemberGeometry.lean:15` first takes a finite common degree, constant and threshold over the fixed Fourier geometry. The common degree is a sum of degrees, the constant is the sum plus one, and the threshold is a sum of absolute thresholds plus two. They precede all dynamic row, tuple and height data. Controlled completions are selected before \(\theta\) and the bounded row/tuple weights.

In `LowFixedMember.lean:18` the specialization is
\[
\epsilon=\frac{\eta}{200(1+\eta)},\quad \rho=\eta/8,\quad
\kappa=\eta,\quad\delta=\eta/2,\quad
L_{\rm scale}=57,\quad L_{\rm pool}=L_{\rm cap}=8,\quad
\mathrm{saving}=2,\quad\pi_0=2\eta.
\]
`LowCaps.lean:12,52` derives the actual caps and verifies
\[
\epsilon\bigl(8+8+2(\eta/2+57+\eta)\bigr)+\eta/2\le2\eta.
\]
The scale \(57\) is not a missing normalization. `SourceScaleCaps.lean:11,39` expands the inverse raw scale as
\[
27\,\operatorname{sourceCuspScale}(s)^2N((c_0))^2
N(\textstyle\prod G_i)^2 Q_K^2Q_P^2X^{-1}.
\]
With each variable capped by \(Z^8\), this is a fixed coefficient times \(Z^{56}\). Enlarging the threshold absorbs the fixed coefficient into \(Z\), giving \(Z^{57}\), uniformly over the fixed finite geometry.

Here \(O=\log_ZN(A)\), so \(0\le O\le2\), and \(Z^{-O/2}=N(A)^{-1/2}\). The parameter substitution yields a loss \(204\eta\); the public cell bound relaxes it to \(504\eta\). The unused \(300\eta\) is safe slack. The tail-comparison premise is satisfied since
\(5/6-2d-O/2\ge-1/2>-2\).

`LowDyads.lean:14` applies this actual cell estimate only to nonempty row/tuple dyads, choosing an original parent witnessing the residual row. Empty dyads have exact zero energy. `DyadCompletionEnergy.lean:40` selects all completions before height and weights and charges the finite dyadic factor
\[
(D(H_{\rm row})+1)(D(H_{\rm slot})+1)^2.
\]
`DyadBudget.lean:15` absorbs it into \(C_bZ^\eta\): both positive ranges are at most \(Z^8\), and three logarithmic factors are bounded with exponent \(\eta/[3(8+1)]\). Thus `LowChoiceEnergy.lean:15` obtains \(505\eta\), still with \(-O/2\). No dyadic maximum is substituted for an uncounted sum.

## 5. Inactive choices and the source-label budget

For fixed inactive choices \(b\), `LowInactiveEnergy.lean:14` restricts the rows to `inactiveRowSet`. This records both row/tuple coprimality and avoidance of the frozen pool. It then invokes the active-choice estimate on that subset. `InactiveRows.lean:17,31` extends the resulting function by zero and proves equality of its finite energy with the restricted energy.

The relevant Cauchy inequality, proved in `InactiveEnergy.lean:11,26`, is
\[
\sum_K\left|\sum_b w_bf_b(K)\right|^2
\le\left(\sum_b|w_b|\right)^2 E
\quad\text{if}\quad\sum_K|f_b(K)|^2\le E.
\]
The inactive weight retains \(\prod_{i\notin T_0}N(p_i)^{-1}\). Its total norm factors into the corresponding product of finite reciprocal-norm sums. `SlotMass.lean:12,22` bounds this by
\(\prod_{i\notin T_0}256(D(H_i)+1)\).
Consequently the inactive assembly pays the square of that product, not the number of inactive tuples.

For the next finite sum let \(\mathcal B=\gamma\times(\mathcal P(\mathrm{pool})\times\mathcal P(\mathrm{slots}))\). `LowFrozenEnergy.lean:15` applies the same Cauchy inequality, now paying \(|\mathcal B|^2\), and uses \(|a_h(K)b_{A_0}|\le1\). Thus before budget absorption the cost is exactly
\[
|\vartheta^{-1}|^2|\mathcal B|^2
\left[\prod_i256(D(H_i)+1)\right]^2
C(1+|\theta|)^nZ^{5/6-2d+505\eta-O/2}.
\]
`SourceCost.lean:12,22` and `SourceBudget.lean:11` bound the two squared factors by
\[
C_bN(JM)^\epsilon(\textstyle\prod_iH_i)^\epsilon.
\]
The pool embeds into the distinct prime support of \(JM\); its squared subset count is dominated by the already charged squared six-label count, through `InactiveAggregation.lean:39`. The number of slot subsets is bounded by \(2^{r_{\max}}\). The squared harmonic product uses exponent \(\epsilon/2\) per unsquared factor, not \(\epsilon\) followed by an unpaid square.

After choosing \(Z\ge\max(2,C_k,N(M))\), \(N(J)\le Z^2\), \(N(JM)\le Z^3\), and \(\prod H_i\le Z^2\). At \(\epsilon=\eta/8\) the exponent is \(5\eta/8\le\eta\). This proves the \(506\eta-O/2\) frozen estimate. The fixed Fourier cardinality and inverse derivative scalar enter the fixed constant. These are finite calculations and do not require an infinite-pool limit.

## 6. Final powerful/mask aggregation

`LowCompletedFiber.lean:16` now supplies each representative fiber with the bound
\[
E\,N(A)^{-1/2},\qquad
E=C(1+|\theta|)^nZ^{5/6-2d+506\eta}.
\]
`CubicSieve/QuantitativePassage.lean:420` partitions the parents by the pair \((A,T)\) exactly once. `CompletedAggregation.lean:12` chooses a representative only for a nonempty fiber, and treats empty fibers by zero. It bounds the whole sum by
\[
E\,\#\{T(I)\}\sum_{A\in\{A(I)\}}N(A)^{-1/2}.
\]
Mask parts divide \(M\), and powerful parts are powerful ideals with norm bounded by the parent norm. `PowerfulBudget.lean:13` derives the half-norm sum from the powerful counting estimate: on a dyad \([R,2R]\), the count is \(O(R^{1/2+\delta})\), while the weight is at most \(R^{-1/2}\). The resulting \(O(X^\delta)\) per dyad and the dyad-count bound give \(O(X^{2\delta})\). This is why the weaker half-norm weight remains usable.

`PowerfulBudget.lean:78` combines that estimate with the ideal-divisor small-power bound. For ranges bounded by \(Z^L\), take \(\delta=\eta/[2(L+1)]\); the product exponent is \(2L\delta\le\eta\). `LowCompletedRows.lean:17` uses \(L=2\). Its threshold actually gives \(N(M)\le Z\), then weakens to \(Z^2\); parent norms are also at most \(Z^2\). It therefore pays exactly the last \(Z^\eta\), giving \(507\eta\). No outer parent cardinality or representative multiplicity is omitted.

## 7. Precise remaining boundary

The reconstruction above closes the finite assembly and its actual parameter passage, subject to the following deeper producers. They remain named inputs, not new assumptions substituted for a theorem.

- `Reflection/LowGlobalBudget.lean:14`, `original_low_global_full_budget`, especially its input `original_low_sector_full_budget` and the lower retained/tail reflected analytic estimates. I read its interface and assembly call, but have not validated its complete sector-energy mechanism here. The current audit must not be reported as closure of that analytic estimate or the full reflected-energy foundation.
- `Reflection/OriginalSplitReflection.lean:22`, `actual_marked_slot_split_reflection`, and `Reflection/OriginalChoicePhysical.lean:45`, `originalSplitControlled_physical`, below the inspected actual residual-source adapters. Their theta derivative, reflection and physical identities require a separate bounded audit. The fact that their callers keep all factors does not prove those identities independently.
- Lower foundational ideal counting/divisor estimates used by `PowerfulBudget`, `finite_inverse_norm_sum`, the fixed finite Fourier coefficient bound, and the original compact-support completed-sum theorem. Their precise uses were checked; the foundational proofs were not recursively re-audited.

No inspected step appeals to the desired QRH conclusion, a supplied smallness hypothesis for the final row energy, or arbitrary default summability. This is a local source observation with the stated lower cuts. Target-revision elaboration and all full-provider claims remain outside this report. Independent review is separate.

## Source pins

| Source file | SHA-256 |
|---|---|
| `Reflection/LowOriginalEnergy.lean` | `F01E49A1FAC91859E1D23C6EF3DC84C9EFF39C0B5BAB19CA4CEF8A7A1B0F7E62` |
| `Reflection/LowCompletedRows.lean` | `0ED3B29EBEDF6F28860937FEC9AB1717C2CCE74F6F2663A4240BAE0B0120ED31` |
| `Reflection/LowCompletedFiber.lean` | `05AFF8BDACAB8EFD4FA1F4FB878E8FAC31D260DA8F6A6077092CD6CE5F906018` |
| `Reflection/LowFrozenEnergy.lean` | `7D36D66BBAB9B74F1FDED6D7DECA04F9D73779AECD972A6506FC61D432317673` |
| `Reflection/LowInactiveEnergy.lean` | `6DA84152A2B5BAA6EDD27207CDF6F6157E6EDF1932261C5B69795987F9DD2F8E` |
| `Reflection/LowChoiceEnergy.lean` | `DF6AECB3950330808C69B327E839501436B9A369F350639FA17A405DCE0A2D1E` |
| `Reflection/LowDyads.lean` | `49661505253B13F9CDC938CAA483CA568EA41EC3750446ACAA7B06E233B49D25` |
| `Reflection/LowFixedMember.lean` | `1355A30635F64F2363D4D5A440BE2E8533EBDECC31CCB4279715FDE9C4AC7072` |
| `Reflection/LowMemberGeometry.lean` | `32DFBA94C4C1A8E1C7199BE7BF1B2EE83C3F400AC082EDF77018B4E5DB2034F2` |
| `Reflection/LowMemberBudget.lean` | `87F259FBB3A5F93938CEAACA47BEBE1A77DCF5F31D35B33B9294C967F1BDD8FD` |
| `Reflection/LowGlobalBudget.lean` | `8C666EC8A923DAF122F24A46EDB41B6155E4EC7BE2F3397B3326249DB8ADB0DA` |
| `Reflection/LowCaps.lean` | `D55E5A7FD8203B6185B34B41059AC69C80C2C791EDB965B4D0CFDE8BD1690017` |
| `Reflection/SourceScaleCaps.lean` | `A6DC3B26E73F5E9EB86D6CAA1A31A867E1B1943048184401F8B4438124EDA497` |
| `Reflection/DyadCompletionEnergy.lean` | `97DF914A23EE772D1215BB58FD5D355FCB6CD0A905775D28DCD8CA22FFC9B627` |
| `Reflection/DyadBudget.lean` | `922456E2931CDE5C5EA6477205E14BD3F458003CA7074895FEA42E080E060007` |
| `Reflection/LowPunctureLists.lean` | `F36C01EA9CAA2E78BC8C4A314D25723C09BD27FFA05E659B29250D279125A312` |
| `Reflection/PuncturedMarks.lean` | `2BAC19BB35EC28A53887A61D33DE0C62A418FAAE3FDC3381F4967D898043DDC9` |
| `Reflection/CompletedFiberSource.lean` | `47369A49D3AE0884C2A53AB4537081E8F324FC5B15E898E0AC005928D87FF97F` |
| `Reflection/OriginalActiveReflection.lean` | `4773C7C78706354EAED7D0F9A432F356CFDB8D855EC87225C079081D5EA8FB54` |
| `Reflection/OriginalSplitReflection.lean` | `C064D8F886E743808EACDFAE986BC6173E2FE2064742DAFB42F67C3D23A6704F` |
| `Reflection/OriginalChoicePhysical.lean` | `BF76A3A68E2695A899AACA2610CE6CA35AB35E2169A09DE8FE530A14E5DEC7C0` |
| `Reflection/RowReindex.lean` | `B893AAFB53A12147581A37EBDFF28C513B737AA1B2A9E930E1DCDAF0D1B4AD65` |
| `Reflection/CompletedAggregation.lean` | `756C89822A3D3E1D4E619409F698328BBBA63F5CE4D1CA0F79F81A25DC4FB0E6` |
| `Reflection/PowerfulBudget.lean` | `59538E3C10965ABA0EF64DFFC8C5CCFB89C496FB43F608380DE7E66E5C716279` |
| `Reflection/SourceCost.lean` | `B40E2EF6742CF70C89B640463535EAC4C8552A7F8CDB90D85BC71775939D12E6` |
| `Reflection/SourceBudget.lean` | `3880A4512C497EAA8B2FCF8230A5F332948F92B751666B05FB63DAE460C240A8` |
| `Reflection/InactiveAggregation.lean` | `03AC769FC36CB60400E95F64D4B0932E7234FF3519F860792F6217AEB3C7E248` |
| `Reflection/InactiveBudget.lean` | `04F3321A65C33DDBC55EC9216E95C955AA06324AD90AAAA5D992F7422E4A3347` |
| `Reflection/InactiveRows.lean` | `224F90EC5EBDF04FCC73D0E4A8EB4A3BF0518CB63AA2C8C46657EAF71CAADF9C` |
| `Reflection/InactiveSource.lean` | `AC41169D988B69E565A85AC16883A0E8552AA738AE8E403906CD6E83775EABDE` |
| `Reflection/InactiveEnergy.lean` | `5EF5F0AF255E26FFBA62D5268AF37668C54A21A202372C387B0570EA1A70B4B8` |
| `Reflection/SlotMass.lean` | `1FEC868B8DDF51DDD6CF5837E100D32A82B420395192EFA5394104863FB129DD` |
| `Reflection/OriginalWeights.lean` | `75EC12139A43CB5A74A403E67034D09220790C2B3AB9F6BD1EB47DA64DFE72CD` |
| `Reflection/SourcePhysical.lean` | `6B4DA994A15CE97163B681030C2F7C04B7CC69573F584A700024B5CDCEEC20E1` |
| `Reflection/FixedTuples.lean` | `0EDF59DFE662CFB11570E6F14AD42BB35B4CAA2FB3B68B156D4F6BBBD425356F` |
| `Reflection/ActiveProducts.lean` | `1A643DC38EF1AB8CC55023D4EFB6A0681B56EEC7D2FF20DAED7BF604D013F03C` |
| `Reflection/TupleMembers.lean` | `919941A8A237655F39186C349F3442F7FFC6DC16B54043F903BF60535853A5EA` |
| `Descent/SlotProducts.lean` | `133AC2D3512CFFA2F43DECF399F903E506E1DA675D5DB2D1F0EDB248A2CCF0E8` |
| `Descent/Completion.lean` | `6D3490853CBAE6F716C06CF99724C65F64418E9B6171EF6A89711E801E9C3BAC` |
| `Eisenstein/ReflectionFibers.lean` | `48EFFCDC0807750C501B3E863B13E1D464FEAF453B2E367197824327A43B76BF` |
| `CubicSieve/QuantitativePassage.lean` | `216425DA1BA34782C41986FA7E1D58BEFFB064760497F36ABBE5D1C5D1B82C74` |
| `GaussSum/ResidualEquivalence.lean` | `B1783D9E7BD8B375378A0BC18ED30FE176CF92E971F2BD7D37049B0E2FA6675B` |
