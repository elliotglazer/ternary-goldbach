# Seeded Gaussian retained energy and source remainder: bounded source audit

Date: 2026-11-11. Author: independent-feasibility. Status: source/paper reconstruction, awaiting independent review. No Lean build, declaration, source edit, analytic evaluation, or spectral scan was performed. This is not a validation of the global QRH provider.

The inspected estimates have the stated normalization and parameter losses. The retained estimate is a reduction from actual live child energies, not an unconditional production of those energies. The remainder is an exact localization followed by three separately normalized estimates. Its diagonal and exceptional terms retain the inverse seed norm; the discarded tail does not. No mathematical defect was found in the bounded bodies described below. The lower analytic and arithmetic calls listed in section 8 remain explicit boundaries.

## 1. Exact targets and coverage distinction

The targets are `Moments/SecondFrozenLiveSource.original_nonexceptional_energy:34` and `Moments/SecondSourceRemainder.original_source_remainder:71`, under `work/openai-math/lean/OAI/NumberTheory/DirichletL/`. The source-byte manifest below is authoritative for this audit.

The prior child-admission report C8FDBA5516B0A0FD675DDFA3CE4ABB001E6113400C4D9FD3FC94E926FF76DBD4, independently reviewed at 5D3EAD2F3C9EE1CD05962AA2E1ED7EF8A45979451C65C3B4012A62142AEE33D0, establishes live/dead cases and geometric/conductor gates. It does not establish the child-energy premises consumed here. Parent `ZeroAt`/`PositiveAt`, width and loss assumptions are not erased by this audit.

The earlier `Inversion/InitialRetainedWindow` report concerns another retained expression. It cannot be substituted for either target. The earlier global-tail report concerns `InitialHighFrequencyTailRapid`; only its actual lower radial lattice-tail theorem is reused here, after checking the Moments-specific coefficients, reference scale, and normalization.

There is an exact reused analytic join at `Cauchy.whole_kernel_row_estimate:99`: it calls `Smooth.whole_product_pair_separation:117`, previously audited in 12DB7738EB0BA0DA10E64424785C6C6B62277976CC05FECC21F9CF2E86C93A6E and independently reviewed at 34369ACB02CDA010DC918B5E96F9D9B2090E0E7E845D882BBBA2F92AF20543DB. The common density, positive scale, finite seminorm control and shared support box are inherited with their original restrictions. The radial proof is not repeated.

The earlier first-allocation budget has the same support/count-squared mechanism as a call below, but is not literally `CommonLiveFrozen.actual_common_source_pointwise`. The latter body was read separately here.

## 2. Objects and quantifier order

Write (V=\mathrm{volume}(s)>0), (H=\mathrm{sourceRadius}(s)), (N(I)=\mathrm{absNorm}(I)), and (P(s)=\mathrm{profileCost}(s)\). The source is the actual finite profile coefficient, grouped by ideal product; it may be complex and may cancel. The retained blocks contain actual supported correlations, dyadic windows, and `wholeKernel`, not an abstract replacement energy. `partEnergy false` is the nonexceptional part; `partEnergy true` is the exceptional part.

In `SecondFrozenLiveSource`, fixed `lo,hi,W,J1,J2,B,L,Cr,delta,epsilon` with (B,L\ge0), (Cr,\delta,\epsilon>0) determine the constant and eventual threshold. They precede the varying input, source height, seed and all retained blocks. The seed must be nonzero and squarefree. The plain windows vanish at zero, (0\le H\le Z^B), and the frequency radius is at most (Cr Z^L). The auxiliary character family is chosen from the actual common-label data before the later (Q,m,K_{phys},T_{sec},\xi,E_1,E_2). It is not chosen separately to fit a favorable block or an energy bound.

The retained premises quantify over all live labels, common subsets, nonzero physical blocks, supported right divisors, ray characters and real heights. For each actual first allocation with nonzero frozen coefficient, they quantify over all its active second children. Both (E_i\) are nonnegative. The premises bound `childEnergy` with its actual canonical radial data by

\[
E_i\,\mathrm{childEnvelope}\,\max(1,r^{-1})^{1/6}(1+|v|)^{2J_i},
\qquad r=d_0d_1/(d_2d_3)>0.
\]

Admission does not supply this inequality. A dead frozen coefficient is harmless, but no positivity of the signed coefficient or absence of cancellation is assumed to identify a live one.

For the remainder, the fixed support boxes, Schwartz function, positive losses (\epsilon,\delta,\theta,\xi\), nonnegative (B), and arbitrary real requested `saving` determine (J,S_{profile},S_\Phi,C_{exc},C_{diag},C_{tail}). The profile seminorm set contains ((0,0)). Only afterward is (Q\ne0,\top), (Q\le(72)), supplied; its constant (K_c>0) and eventual threshold may depend on (Q). The report makes no uniform-in-(Q) threshold claim. Additional input caps are (N\eta,N R_0,H,V,T_{sec},R\le Z^B), with the exact nonnegativity/positivity hypotheses in source, and (V^2/K_{phys}\le T_{sec}). In particular (K_{phys}>0) and (T_{sec}>0).

The exceptional saving requires **four separate inequalities** (Z^r\le X_1,X_2,Y_1,Y_2). A lower bound on their product is not a substitute.

## 3. Retained bilinear energy bridge

The inspected chain is `SecondFrozenLiveSource` -> `SecondFrozenRatioCost` -> `SecondFrozenChosen` -> `SecondFrozenPhysical` -> `SecondFrozenSupported` -> `SecondSupportedChildren`.

`CommonLiveHeight.actual_height_envelope:20` first applies `CommonLiveFrozen.actual_common_source_pointwise` to `withHeight s tau v`. The latter uses `RadialPointwiseUniform.actual_uniform_divisor` at loss \(\delta/2\), and the squared allocation count at another \(\delta/2\). Nonzero coefficients get `frozen_normalized_cost`; zero ones vanish. Its conclusion is normalized source energy at most

\[
C Z^\delta P(s)E/[N(C)N(L)].
\]

Unnormalizing by the positive raw volume gives the exact height envelope. It is linear in (E), not quadratic. The underlying `actual_uniform_divisor` is still a lower energy theorem, not proved by this algebra.

`SecondSupportedChildren:71` restricts the Möbius divisor to (N(L)\le H/N(D)\). For a larger divisor, the entire right source coefficient is zero: a live coefficient at (D I), together with (L\mid I), would contradict the source norm cap. This is an exact dead-divisor argument, not an omitted tail. On the live divisors the two square-root window budgets multiply to a single (1/N(L)). The finite harmonic mass `MobiusHarmonicMass.full_mass_subpower` costs (Z^\delta). The unused left bound on dead divisors is filled by the absolute source envelope; the right factor is zero.

`SecondSquarefreeBlock:26` supplies coarse energies on nonsquarefree divisors only to meet the lower theorem's full domain, then deletes them exactly because their Möbius coefficient is zero. It does not ask the child-energy hypothesis on nonsquarefree inputs.

The genuine retained bilinear step is explicit:

* `SecondNonexceptional:16` uses the actual scaled-row identity, a finite ray/divisor sum, and a factor (256). The left and reflected right `keep` predicates are transported using the stated (Q\le(72)), good-lambda and evenness assumptions. The right ray is inverted and its row argument is negated; these are not silently identified with the left predicate.
* `RestrictedEnergy:82` bounds the two finite row energies by their nonnegative restricted weighted energies, takes square roots, and applies the common-density Cauchy estimate with exponent (J_1+J_2).
* `Cauchy:11–137` interchanges only finite sums with explicitly integrable terms, bounds each row phase in norm by one, and integrates the product of the two square-root row energies against the **same** density. Thus separate densities are not substituted in a mixed estimate.
* `RestrictedWindow:39–133` proves the log-window energy estimate from the true height-shifted energies. For each finite row set it inserts the square root of the nonnegative lattice weight, applies finite weighted integral energy, and then takes the supremum of finite nonnegative sums. It has genuine summability and column integrability inputs. The shift is (t+2\pi(w-\vartheta)); the scaling phase in (\log X) has norm one. The all-real-height premise is necessary.
* `SecondMaskedWindow:60` identifies the actual divisor/moving/ray coefficient with that source coefficient. `SecondRadicalBlock` handles the conjugated window with the negative frequency. It does not infer a pointwise height bound from an integrated one.

This establishes the finite and integral-to-energy joins conditional on the named exact lower column representation, finite ray identities, and summability theorems. Those lower bodies are not all re-audited here.

## 4. Physical scalar cancellation and the seed saving

`SecondFrozenPhysical:37` converts normalized blocks back to physical blocks using positive `outerScalar` and `normalizer`, and divides once by (V>0). The paired core budgets supply (Z^{2\delta}), the square-root factor (\sqrt{E_1E_2}), and the denominator \(\sqrt{N(C)N(D)}\). A division by ((1+r)^{decay}) is valid since (r>0).

For the selected ratio estimate, decay is one. If both child bounds contain the same nonnegative factor (E\), then
\(\sqrt{(E_1E)(E_2E)}=E\sqrt{E_1E_2}\).
Consequently the child envelope and the (r^{-1/6}) penalty occur once, not squared.

`SecondNonexceptionalScalar:36–138` extracts an actual nonzero summand from a nonzero block. The first dyadic window gives `secondEffectiveScale < d0`. The two coefficient windows give
\(d_2\le4H/N(C)\), \(d_3\le4H/N(D)\), so
\(\sqrt{d_2d_3}\le4H/\sqrt{N(C)N(D)}\).
This uses nonzero-summand witnesses only; it is valid for signed/complex sums with cancellation.

`SecondRetainedRatioScalar:21–118` proves for (r>0), (0\le a\le1),
\[
\frac r{1+r}\max(1,r^{-1})^a\le1.
\]
For (r\le1), the power is at most (1/r); for (r>1), it is one. `scalar_cancel` cancels the common-frequency/subset normalizer exactly, leaving the effective-scale ratio. With (a=1/6), the resulting scalar is at most
\[
4\,\mathrm{fixedFactor}\,N\eta\,H/\sqrt{N(C)N(D)}.
\]
There is no extra small-(r) loss or unbounded height-dependent constant at this step.

`SecondBlockHarmonicMass:34–142` injects the actual active label/subset into the harmonic partition. It counts all source blocks, not just an arbitrary selected one. The label mass uses \(\epsilon/2\), and the source-block subpower bound uses another \(\epsilon/2\); nonnegative weights allow enlargement. Their product is
\[
\sum_{\mathrm{blocks}}[N(C)N(D)]^{-1/2}\le C Z^\epsilon/N(\mathrm{seed}).
\]
The underlying `common_harmonic_mass` and `sourceBlocks_subpower` are retained arithmetic inputs. The local-to-global finite argument and exponent allocation were inspected.

Thus the exact selected conclusion is
\[
\frac{\|\mathrm{partEnergy(false)}\|}{V}
\le \frac{C Z^{2\delta+\epsilon}P(s)N\eta H\sqrt{E_1E_2}}{N(\mathrm{seed})}
\,\mathrm{heightEnvelope}(t)^{J_1+J_2}\,
\mathrm{profileMoment}(J_1)\mathrm{profileMoment}(J_2).
\]
The family selection and constant order stated in section 2 survive this aggregation.

## 5. Exact remainder and actual diagonal

`SecondLocalization:26–86` starts from the actual second-source Poisson identity and the summable zero/retained/discarded lattice split. `SecondSourceRemainder:116–161` then applies the actual exceptional/nonexceptional retained split. Before taking any norms, it has the complex equality
\[
G-P_{nonexc}=(K_{phys}\widehat W_{rad}(0))Z_0+P_{exc}+T_{discard}.
\]
The triangle inequality and division by (V>0) occur afterward. There is no factor three, no norm inserted into the equality, and no seed saving transferred from one summand to another. The Poisson producer and original retained decomposition remain lower identity boundaries, although their application and scale substitution were read.

The zero-mode estimate was inspected beyond its adapter. `SecondDiagonal:14–190` proves off-diagonal vanishing from the actual finite residue congruence: if both multiplicative-character factors are nonzero, the residue representatives are coprime to their moduli, forcing mutual divisibility of the moduli. Distinct ideals therefore give zero. Primary-generator uniqueness gives distinctness in the actual injective column indexing. The same-column correlation is bounded by its residue cardinality, and the two square-root norm normalizers cancel it, leaving at most \(\sum|c_I|^2\).

Seed-divisible ideals are injected by ideal quotient into a norm ball. The finite ideal-count input gives (128Y/N(\mathrm{seed})\); empty sets are handled separately. `SourceSecondZeroEnergy:97–182` pays finite tuple multiplicity with a divisor bound at \(\epsilon/[2(N+2)]\). Each coefficient costs (Y^{\epsilon/2}\), whose square gives (Y^\epsilon\). The normalization by raw volume therefore leaves (V^\epsilon\), not (V^{1+\epsilon}\). The subunit support case is exactly zero and is not forced into a norm-ball theorem requiring radius at least one.

With (L_+=(\prod_i hi_i)\,whi^2\) and (D=2\|p_0\|_{0,0}\|p_1\|_{0,0}\prod_i M_i\), the diagonal contribution is
\[
C_{diag}K_{phys}|\widehat W_{rad}(0)|D^2(1+L_+)^{1+\epsilon}V^\epsilon/N(\mathrm{seed}).
\]
No RH, zero exclusion, or cancellation assumption supplies this bound. The original finite ideal count, divisor estimate and character algebra remain named underlying results.

## 6. Exceptional source adapter and its open analytic producer

`SecondExceptionalFixedQChosenBlock:54` supplies actual exceptional rows and their reflected inducing conditions, bounds both expanded conductors, and derives the lower support (aV\le N(I)\), where (a=(\prod_i lo_i)wlo^2>0\). It separates the zero-block case and constructs the exceptional family only in the live case. The four individual lower scale bounds are passed unchanged.

`FiniteProfileExceptionalFixedQUniform:45` consumes `FiniteProfileExceptionalFixedQSaved.actual_saved_exceptional_block:43`. Its additional real algebra absorbs common-label weights. For (u=\log_Z N(C),v=\log_Z N(D)\ge0\),
\[
\max(r-\min(u,v),0)+(u+v)/3\ge 2\max(r,0)/3.
\]
For (r\le0) this is immediate. For (r>0), set (m=\min(u,v)\): if (m\ge r), the second term suffices; otherwise the sum is at least (r-m+2m/3\ge2r/3\). Together with \((N(C)N(D))^\theta\le Z^{2B\theta}\), this gives the stated exponent. This algebra does **not** establish the saved exceptional estimate it consumes.

`SecondExceptionalFixedQSource:61` sums blocks with the radical weight (1/N(\mathrm{commonRadical}(C,D))\), not the retained branch's square-root pair weight. Its separate radical harmonic theorem costs (Z^\delta/N(\mathrm{seed})\). `SecondExceptionalSourceCaps:14` bounds the expanded conductor by a fixed constant times (N\eta\,N R_0\,H^2R\). The five powers (Z^B\) and eventual absorption of that fixed constant into (Z\) explain (5B+1\).

The final exceptional term is precisely
\[
\frac{C_{exc}\,\mathrm{profileFactor}(S_{profile},s,p,J,Q,K_c)}{N(\mathrm{seed})}
 Z^{2\epsilon+2\delta+2(5B+1)\theta-2\max(r,0)/3}
 V^{1/3}K_{phys}^{5/6}a^{-2/3}.
\]
This audit checks its source consumption, actual support/conductor substitutions and normalization. The substantive saved/dyadic fixed-(Q) exceptional energy producer remains the nearest open analytic cut on this branch.

## 7. Discarded tail: exact reuse and the loss (5B)

The exact reused lower theorem is `Poisson/RadialFourier.paperRadialFourier_lattice_tail:544`, with its genuine norm summability at line 533. `Moments/Tail.weighted_set_lattice_tail:116` restricts by an injective subtype map and supplies a summable norm majorant; `uniform_sector_lattice_tail:156` monotonically replaces the actual positive kernel scale by its positive lower reference. Thus a totalized `tsum` at a nonsummable input is not being used as a zero tail.

`SectorLocalization.actual_discarded_second_tail:471` uses the actual correlation norm bound (N(I)N(J)\). `SecondTail:15–96` sets the actual scale (K_{phys}/(N(I)N(J))\), whose lower bound is
\(k_0=e^{-2H_N}/T_{sec}\)
when the column norms are at most (e^{H_N}X\) and (X^2/K_{phys}\le T_{sec}\). Its outer normalizer is bounded by (K_{phys}\), using (N(I),N(J)\ge1\). This is a deliberately coarse bound, with no claimed seed gain.

`SupportedTailAggregate:42` uses \(|\mathrm{heightCoeff}|\le1\) and bounds the double finite sum by the **square** of the coefficient absolute mass. `SourceInputTailUniform:37–96` supplies mass at most a fixed support-box constant times `plainControl` times (V\), and the source norm cap at most (e^{H_N}V\), with fixed
\(H_N=\log\max(1,(\prod hi_i)whi^2)\).

After division by (V\), the mass-square and column-cap-square produce (V^3\). The inverse reference-kernel loss is
\[
\min(1,k_0)^{-2}\le (1+e^{2H_N})^2 Z^{2B}.
\]
Choose a natural (A\) with \((\xi/4)A\ge5B+\mathrm{saving}\). Since \(V^3\le Z^{3B}\) and \((1+Z^{\xi/4})^{-A}\le Z^{-\xi A/4}\), this yields arbitrary requested saving. The eventual cutoff threshold depends only on fixed (H_N,\xi\), not on the varying source. It follows that
\[
\|T_{discard}\|/V\le C_{tail}\,\mathrm{plainControl}^2
 S_\Phi(W)K_{phys}Z^{-\mathrm{saving}}.
\]
There is no (1/N(\mathrm{seed})\) on this term. The choice of (A\) changes the finite Schwartz seminorm set and constant; it is not a free improvement with unchanged constants.

## 8. Bounded conclusion and next proof cut

The new work checks the actual retained energy transfer, the supported/squarefree divisor logic, the physical ratio cancellation, finite harmonic aggregation, exact remainder identity consumption, diagonal mechanism, and Moments-specific tail normalization. Accepted radial separation and lattice-tail evidence is reused only at its matching source calls. These arguments neither assume finite RH nor prove that the full QRH provider is noncircular.

The remaining explicit inputs are:

1. The actual child-energy inequalities quantified in `SecondFrozenLiveSource`, including their radial and all-real-height uniformity. Live admission/Ready fields alone do not give these.
2. `RadialPointwiseUniform.actual_uniform_divisor` and the original common-source weighted decomposition beneath `CommonLiveFrozen`; the allocation count/cost algebra was checked here, not every lower analytic identity.
3. `FiniteProfileExceptionalFixedQSaved.actual_saved_exceptional_block:43`, consuming its dyadic exceptional producer. This is the most direct next substantive energy cut; the fixed-(Q) constant and the four scale lower bounds must remain visible.
4. The actual scaled-row/finite-ray identities, the plain-column Fourier representation and weighted integral theorem, the actual source Poisson identity, and original retained block decomposition. This report checks the applications and finite/reflected/summability joins, not a new complete audit of their foundations.
5. The common and radical harmonic mass theorems, source-block subpower count, divisor-small-power and finite ideal-count inputs. Their exact uses and loss allocations are checked; this is not a revalidation of every arithmetic producer.

A useful next task is the fixed-(Q) saved exceptional producer, after checking its prior coverage. It is more informative than repeating `CanonicalAmplifiedUniform` or the already checked admission wrappers. No full proof, elaboration, axiom, provider, or terminal-reach claim is made by this packet.

## 9. Source-byte manifest

The hashes below bind whole files for reproducibility; the inspected mathematical scope is the declarations and bodies stated above, not every declaration in a manifested file. Historical accepted reports are reused with their original scope. Raw hashes are SHA-256; no newline normalization is used.

| Source under `DirichletL/` | SHA-256 |
|---|---|
| `Moments/SecondFrozenLiveSource.lean` | `D0C6DB00EF51418792B4C1DD2AE2DCD7BC532F36546E0DABF14F0BE7C8DA4634` |
| `Moments/SecondFrozenRatioCost.lean` | `2156A8253C266B9A51E8F3888C6084244CBCFA7DB31834E1DEE945481E8F29CE` |
| `Moments/SecondRetainedRatioScalar.lean` | `41367813BF990B21A5B23DF6ECD80F805BFE32768DCCAFB060A67516E3EE7A03` |
| `Moments/SecondNonexceptionalScalar.lean` | `C401581FDB4DC88AE9D81222C85967918A1F51DC7568DD2F7CC7987BBBC07099` |
| `Moments/SecondFrozenChosen.lean` | `A4E6087D6B3BC6341DAC51C8A3910A98A84996D017AA2CE964C53B50F1FFCC5F` |
| `Moments/SecondFrozenPhysical.lean` | `A585A372FD0FC8CA2751ACF4DA6998AB8FEA5B2779182702BACA675823FDA57A` |
| `Moments/SecondFrozenSupported.lean` | `487AF685B0EC5E3F7D71B920CF02359965A65A62CF26F04FC4A2F8958E1C9A01` |
| `Moments/SecondSupportedChildren.lean` | `A842D0CA0D40F09DD316E411B2B05AA4DA6F65E6F930ACCFBB0A44FFE4837511` |
| `Moments/SecondSquarefreeBlock.lean` | `2004B9E0ECC7B9147B78F807E63BEAB7AA2B99E24A4F9F6116E050E596060676` |
| `Moments/SecondRadicalBlock.lean` | `A6D1324FC0027D9E69C48F25E49DB43A0E8598C5B33A0ED4A7EC5CC9EE268EEC` |
| `Moments/SecondIdealBlockBound.lean` | `61529AFEE064A11D224444B339D95707040E13D75130E326125B9FB17D26F663` |
| `Moments/SecondNonexceptional.lean` | `90934083C10AFEFF9477BCF9C82B1224AFD7DC5A8742F7ED55FE89E1BC75D091` |
| `Moments/RestrictedEnergy.lean` | `6A3654048F66760728A9FD874CE4E42E74E0C00BE72845DACF031269E0FD6603` |
| `Moments/RestrictedWindow.lean` | `892EAB298AE70D7D26F8418E74335EE1937DB00D2D90DA997C664FCFD5BC1087` |
| `Moments/SecondMaskedWindow.lean` | `E47939557E2BE77A45127E6F6C7FA468859C5A237FF191AB343A674EF30A5F1C` |
| `Moments/Cauchy.lean` | `9CE4439AE957530D140D50A5CA9D99CD7BE3F54CADA3D71F1AF74D874F5113A3` |
| `Moments/Smooth.lean` | `2C1337F3B8F06D4221F45A81973D9793A59CE876CDDD36A9A443D08C115ED556` |
| `Moments/CommonLiveHeight.lean` | `717672FBCA9C3639C3FE529D79384329022ECED48981E0C05656FCA14C63A307` |
| `Moments/CommonLiveFrozen.lean` | `DEC92070315C6576EA27B0BA562DA578C104157D839D3711541CE75E7FED2BF1` |
| `Moments/SecondNonexceptionalAggregate.lean` | `D3E0F2B5007E59EBF8FDF29ADE6AE4FED71A8671449F4858BE8D7AFD4A1576C5` |
| `Moments/SecondBlockHarmonicMass.lean` | `2FE9FB27A5CFA04E5676C5EDB4DF7EDE9CC3C76EE5016E51FF9B3FD41D06954D` |
| `Moments/SecondSourceRemainder.lean` | `14822C930BA9C2E1D4FF719D4CEB2C63D59D12C97585FDA0DCA59EC4BCB7B322` |
| `Moments/SecondExceptionalUniformSource.lean` | `B567045863D51069C7577B4C04F9F24F0B13C4B1F4EF4EDBAA7AC487FF059145` |
| `Moments/SecondExceptionalSourceCaps.lean` | `90D753E5C11D52C2A69C3156367940FF4F7DDD67227A25C437AC79CD9C17F2BD` |
| `Moments/SecondExceptionalFixedQSource.lean` | `BD38BED5A14C5EA6B40E3385BC2E802CB3A297EBF52EDCCBDE8D24CDAA151ED8` |
| `Moments/SecondExceptionalFixedQChosenBlock.lean` | `355821072DC0D7924330BAB5A2AE7BFAD8C501986D22323D34182EA15EF88A8E` |
| `Moments/FiniteProfileExceptionalFixedQUniform.lean` | `6325D6DBBCC5752E39A84965AB4674F2C9646DB65E6EA9399E942FAFCC30F9FC` |
| `Moments/FiniteProfileExceptionalFixedQSaved.lean` | `D0E9255C3F88E4625E6A569E019B173BADB4DCE7E00EE90BF7C0E2B40720A648` |
| `Moments/SecondExceptionalCommonSaving.lean` | `476BD38CEF3A3029E785F630F4CAEFE8822E98325B8635AC8A7675841E94904F` |
| `Moments/SecondSourceDiagonal.lean` | `16F255C26EFCA397616D24387E71769203CAFCE848567333986149DB7329FA6E` |
| `Moments/SourceSecondZeroEnergy.lean` | `8893E7357C5558E53D182DCF88F7BAEFFDA349B641C01A5A4C0B170D43C11ED5` |
| `Moments/SecondDiagonal.lean` | `BFC98C56513FD019444D1586EB15F6A568A12AD87F3921B441EEE04D6261C4E0` |
| `Moments/SecondLocalization.lean` | `BB5185F9995AEAB4011615A6669F99D1EFF2EDC3E24EF6DC5E64E3954C7EE19F` |
| `Moments/SupportedTailAggregate.lean` | `BB698E4256B36A220A852EF005000C6AB64F2F456A3EB820D768CAC83E18E51E` |
| `Moments/SecondTail.lean` | `5D9AA910C325608CBCF7FC6780E994CFB53F9F253945A205BAC12E8D53F940FB` |
| `Moments/SourceInputTailUniform.lean` | `243051C1D8C680FDE9B4011EB0ABD4613E7F56158A5F249FADC617B95EDCD3CF` |
| `Moments/SectorLocalization.lean` | `181462EC0585529C9D72C6CBC714668C9BB5F9BA0067F4868DEF1088C7ADFC6F` |
| `Moments/Tail.lean` | `71E11CBEA045978D20A228BC48E970A528FF80D24329AAC0BBCAE17135A7C5A2` |
| `Poisson/RadialFourier.lean` (reused lower boundary) | `86D5DEB861723EBF182C8A8489EFD29320F97049F4CCB471684C827F931C8E58` |

Coverage reports consulted (their own frozen scope is not enlarged):

- `integration/QRH_RETAINED_WINDOW_ANALYTIC_AUDIT_2026-11-11.md` — `994D7AE2F9A63CD1151268E8735D93C7A6E70F505C96714AB442FB77C4FFC58B`.
- `integration/QRH_GLOBAL_TAIL_ANALYTIC_AUDIT_2026-11-11.md` — `F3DAB6983C136728A4AE0A9467C44397A41F7CA4F476FDB3C16BAA5F5464B0EE`.
- `independent-feasibility/QRH_WHOLE_PRODUCT_PAIR_SEPARATION_AUDIT_2026-11-11.md` — `12DB7738EB0BA0DA10E64424785C6C6B62277976CC05FECC21F9CF2E86C93A6E`.
- `independent-feasibility/QRH_LIVE_ALLOCATION_COMMON_ENERGY_AUDIT_2026-11-11.md` — `67B64EAE035944821BEA870E7B62972464B2E233DBF2BBF6569A17F9162A5C54`.
- `independent-feasibility/QRH_LIVE_CHILD_ADMISSION_AUDIT_2026-11-11.md` — `C8FDBA5516B0A0FD675DDFA3CE4ABB001E6113400C4D9FD3FC94E926FF76DBD4`.
