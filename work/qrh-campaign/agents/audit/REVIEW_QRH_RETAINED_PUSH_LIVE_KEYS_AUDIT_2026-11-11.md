# Independent review: retained push and live keys

2026-11-11. **PASS for the bounded conditional mathematical source audit.** No correction is requested in the frozen author report. This does not validate the entire QRH provider, prove the four child moment inputs, or establish compiled proof/axiom closure. No build, Lean invocation, analytic evaluation or canonical source change was made.

Author: [QRH_RETAINED_PUSH_LIVE_KEYS_AUDIT_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/zero-sum/QRH_RETAINED_PUSH_LIVE_KEYS_AUDIT_2026-11-11.md), SHA-256 **F119DA8C851BDDE45D41D72D372E1BF9BA281FECAB913BF1A66274A7D5E30C35**. All 24 author source hashes match. Eight additional files used in the independent trace are pinned in [the source receipt](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/qrh_retained_push_live_keys_source_pin_review_20261111.json), SHA-256 **20D0B9D69031DD2351763578289EF74D2FBE7246D962E6120472F66299AC7819**. File hashes identify bytes, not review of every declaration. Provider revision remains 4eaee87548250b2682affda7d05d947c05554bae.

## 1. Exact claims and uniformity

The targets are [first_retained_actual_second_energy](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/FirstActualSecondEnergy.lean:46), [first_global_retained_push_uniform](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/FirstOriginalProfileUniform.lean:85), and [original_live_joint_small_power](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/FirstLiveCountBudget.lean:117).

The first chooses \(K_\epsilon>0\) after epsilon>0 and before the actual index type, prime family, cube, common set, two twists, labels, source coefficients, scales, height, selector and window. The global theorem uses the same choice before both index types and all outer data. Their conclusion is an energy transfer to the actual canonical second energy, not a numerical bound on that second energy. The full prime-generator, residue-characteristic, primary-congruence, label-squarefreeness, label-nonzero and positive-scale hypotheses remain in place.

The live-key constant is chosen after only b, Lcap and epsilon. It is uniform in the coefficient function, cutoff, mark, upper-supported W, Schwartz function, admissible scales and real twist parameter. Unlike the preceding energy transfer, this count does not require squarefree labels. It requires their nonvanishing. I found no hidden transfer of squarefreeness between the two claims.

## 2. Actual weights and paid fiber multiplicity

[FirstFamilyEnergy](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/FirstFamilyEnergy.lean:23) is a sum with weight \(\|w(x)\|\), not \(\|w(x)\|^2\). Hence the retained push is linear in the bound Gamma. [FirstCanonicalEnergy](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/FirstCanonicalEnergy.lean:17) retains the original coefficient, actual cube outer factor and actual base factor; the latter two have norm at most one. Cross-ray and selector weights remain visible in the target energy.

The retained source remembers each pair (f,h). Its union across f is disjoint, and the within-label map is injective. Its subsequent physical map is generally many-to-one:
\[
(f,h)\longmapsto h\,\mathrm{idealGenerator}(f)^2 e.
\]
For each nonzero image y, the projection of its fiber to f is injective: the equation forces the multiplying factor nonzero, so cancellation recovers h. Each f divides (y), and squarefreeness restricts it to the squarefree divisors of (y). This is the actual argument in [SquarefreeDivisors](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Arithmetic/SquarefreeDivisors.lean:140); it does not claim global injectivity.

The finite-prime split in that file proves the number of those divisors is at most \(C_\epsilon N(y)^\epsilon\), with the constant chosen before y. The retained cutoff supplies y!=0 and \(N(y)\le Y\), using the actual dilation multiplier, not an assumption that it is a unit. [The finite weighted pushforward](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Mellin/ReflectedKernel.lean:488) therefore yields
\[
\sum_x\|w_x\|\,\|P(y_x)\|^2
\le \Gamma C_\epsilon Y^\epsilon\sum_y\|P(y)\|^2.
\]
Empty sources and fibers cause no additional condition. No label-cardinality or unit-multiplicity factor is missing.

## 3. Actual row identity and second energy

[FirstCommonChild](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/FirstCommonChild.lean:72) keeps the exact old-label identity: the row is evaluated at \(h\,g_f^2e\), its height is -t, its window is \(u\mapsto\omega(\exp u)\), and its column logarithm uses \(\mathrm{primeProductNorm}(D)X\). The support-ray and before-dilation factors are bounded by one. The positive X hypothesis is needed for the exp/log conversion.

The subsequent core expansion keeps the source punctures, side-dependent sign of the physical row and all core coefficients. Weighted Cauchy in [IntegratedTransfer](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/CubicSieve/IntegratedTransfer.lean:151) uses the core mass \(32\cdot512\). This factor remains explicit; the separate cross-ray coefficients and selectors are not removed. The lower mass calculation bounds coreRayCoefficient by the product of crossCoeff and gCoeff norms and then uses their respective 512 and 32 bounds.

The physical enlargement is justified for arbitrary row P: [RowMajorants](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/CubicSieve/RowMajorants.lean:207) proves exact finite support of
\[
\mathrm{rowMajorant}(\|z\|^2/Y)\|P(z)\|^2
\]
in the lattice ball with parameter ceil(2Y). The majorant is one on the retained region and has nonnegative real part. Thus its immediate physical tsum is summable for Y>0, without any regularity assumption on P.

The second-Poisson identity is a separate dependency. It identifies the real fresh second expression with this nonnegative physical energy; it does not make each complex dual summand positive. Its dual expression retains the prefactor \(Y/\|n\|\), the Möbius factor divided by \(\|e\|^2\), and the actual radial Fourier argument. No dual zero mode or tail is discarded by this transfer. The foundational masked-pair Poisson theorem and its convergence/normalization are not re-proved here.

## 4. Global sum and occupied-key count

[FirstGlobalPush](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/FirstGlobalPush.lean:13) uses a dependent-pair source. Distinct outer indices remain distinct even if their local data agree. Expanding the finite sigma sum and applying the uniform local estimate leaves the complete sum of second energies on the right. It needs neither an extra outer-cardinality factor nor an unproved merging of source terms.

The live keys in [FirstOriginalProfileLivePartition](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/Descent/FirstOriginalProfileLivePartition.lean:15) are different: they are an image of nonzero actual source/common-index pairs into six source norm indices plus two additional dyadic indices. The exact cell partition retains every source pair within its unique cell. Only then is the number of occupied cells bounded by an eight-coordinate box. This is not a bound on the number of source pairs.

For a nonzero source summand, the actual profile contains two nonzero W factors. Their arguments are products of four numbers at least one. The upper-support implication for W bounds each relevant factor by L, without assuming W is positive or bounded away from zero. Actual cube support and divisor relations give the six caps
\[
(L,L,L,LB^2,B^2,Y)
\]
and the two additional caps L and B^2. The frequency cap uses norm divisibility and nonzero multiplier; the cube support bound follows from its radical dividing the cube product. Thus the common cap is \(R=\max(Y,L,LB^2,B^2)\). Twisting cannot create a nonzero value where W is zero.

With \(L=bZ^r\), \(B=Z^{\ell+\eta}\), \(Y=Z^{2F+15\eta+\tau}\), the source assumptions imply
\[
1\le R\le \max(1,b)Z^{3L_{\rm cap}+16}.
\]
No lower bound on r or ell is added. The lower bound for R follows from Y>=1. Natural-floor monotonicity bounds each occupied coordinate by floor(log2 R). Setting
\[
c=1+\frac{\log\max(1,b)+3L_{\rm cap}+16}{\log2}
\]
then gives an admissible uniform constant through
\[
(\lfloor\log_2R\rfloor+1)^8
\le c^8(1+\log Z)^8
\le c^8(1+8/\epsilon)^8Z^\epsilon.
\]
The final step applies the elementary logarithm bound at epsilon/8. It counts only occupied keys after the exact partition.

## 5. Remaining boundary

The finite fiber estimate, linear coefficient loss, actual support transport, compact physical majorant, dependent-pair sum, exact live partition and logarithmic count have been reconstructed. No missing multiplicity, uncharged cardinality, height-dependent constant or unsupported limit passage was found.

The author's lower boundary remains appropriate: the foundational old-label identity in KernelEnergy, the underlying core/Gauss/cube decomposition used by ChildTransfer, the finite ray-mass bounds, and masked_pair_second_poisson with its Fourier/Poisson foundations. The bounded readings above verify their use and some intervening algebra; they do not certify every foundational proof below them. The four child moments, later tails, terminal induction, finite spectral evidence and full global-provider validation remain separate tasks.

The selected strategy and exact final statements are unchanged. This review introduces no final premise and makes no new Lean-proof or computational closure claim.

