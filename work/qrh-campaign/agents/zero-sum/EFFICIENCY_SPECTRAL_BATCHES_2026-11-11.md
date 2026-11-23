# Efficient spectral batches for the reduced original-RH domain

2026-11-11. Paper derivation and small integer/Fraction checks only. No L-value, character value, zero, prime, transform, spectral scan or build was evaluated. The proposed checker and all production certificates remain unimplemented. This report does not adopt a new final premise.

The recommended architecture is a shared low-precision point-value pass, followed by separately certified repairs for unresolved character/time outputs, and a per-conjugation-orbit completeness check. Preserve character sharing even when height batching is not economical. Do not require the degree, tolerance or precision of a tiny Taylor-panel experiment at every production sample. A literal cost calculation below shows that finite-EM height FFTs can add substantial work at large conductors, even though they are useful at small conductors and high heights.

## 1. Domain and acceptance target

Use the proposed smaller original-RH consumer domain from the root comparison:

- Odd conductor \(c\le150000\), height \(H(c)=10^8/c\).
- Even conductor \(c\le300000\), height \(H(c)=\max(10^8/c,200+7.5\cdot10^7/c)\).
- Conductor one remains the separate principal certificate through \(10^8\).

The conclusion is **exactly** \(\Re\rho=1/2\) for every nontrivial zero through the inclusive height, with actual multiplicity. The \(.555/.56\) QRH-strip profiles are not substituted. The proposed restriction still needs its complete consumer refactor and sufficiency proof; it cannot instantiate the broader existing `PlattGRH` Fact.

The nonempty manifest has 150000 conductors and 5543640188 primitive labels, including the principal label. It omits empty primitive rows \(c\equiv2\pmod4\) only through a proved primitive-conductor classification. The previously reviewed CRT coordinate bijection, primitive filter, parity and inverse-label maps remain required. Counts alone do not identify actual source characters.

All further formulas here concern \(c>1\), primitive nonprincipal characters, except where an evaluator explicitly allows imprimitive nonprincipal outputs. Do not instantiate their source pole cancellation or nonprincipal Turing theorem at \(c=1\).

## 2. Use point values for the common sign pass

The reviewed finite-U adapter computes the actual continued L-function from positive integer bases. For unit residues \(1\le a<c\), let
\[
B_a=N+a/c,\quad X_a=cN+a,\quad X_1=cN+1,\quad d_a=\log(X_a/X_1).
\]
The entire finite residue expression is
\[
U_a(s)=\sum_{\nu<N}(c\nu+a)^{-s}+\frac{X_a^{-s}}2
+\sum_{m=1}^{M} b_m c^{2m-1}(s)_{2m-1}X_a^{1-s-2m}
+P_a(s),\qquad b_m=\frac{B_{2m}}{(2m)!},
\]
\[
P_a(s)=-\frac{d_a}{c}X_1^{1-s}\operatorname{exprel}((1-s)d_a),
\qquad L_{\rm fin,\chi}(s)=\sum_{a\in(\mathbb Z/c\mathbb Z)^\times}\chi(a)U_a(s).
\]
The common pole cancels in the nonprincipal character sum, including at \(s=1\) by analytic continuation. There is no remaining external \(c^{-s}\), and no \((s-1)L\) multiplier. The source's individual totalized Hurwitz convention at one is not identified with an ordinary finite part.

For a sign at \(1/2+it\), only the value, or normalized jet order zero, is needed. Thus the common batch may take **K=1**. It has no finite-function Taylor remainder. The EM remainder, time residual, pole-moment truncation and all finite arithmetic still have to be paid. Higher jets are an optional local service for unresolved requests, not a requirement for every easy sign. A point-value record is never accepted as a whole-panel record.

This is a new critical-line point specialization of the general EM formula, rather than an unchecked invocation of the earlier uniform scalar theorem whose centers start at \(.555\). For \(|t|\le V\), put \(N=\lceil V\rceil+2M+4\) and \(X=c(N+1)\). Then every factor of \((s)_{2M}\) has modulus less than \(N\), \(B_a>N\), and \(\sigma+2M-1=2M-1/2>0\). The character-summed remainder is bounded by
\[
E_M=\frac{4X}{36^M(2M-1/2)}.
\tag{1}
\]
Here the exact remainder has \((4/c)X_a^{1/2}\); replacing \(X_a^{1/2}\) by \(X\) and summing uses \(\varphi(c)/c\le1\). The conductor factor is retained. Increasing \(M\) with this \(N\) makes (1) tend to zero; its rational test selects \(M\) for the requested error. Auxiliary work heights are included in \(V\), with no original-height cap assumed there.

There is also a stable way to evaluate the varying Bernoulli corrections at a point:
\[
c^{2m-1}(s)_{2m-1}X_a^{1-s-2m}
=X_a^{-s}\prod_{j=0}^{2m-2}\frac{s+j}{B_a}.
\tag{2}
\]
Every ratio in (2) has modulus less than one with the above choice of \(N\). This avoids first constructing huge rising factorials and conductor powers and then cancelling them numerically. It is an exact rearrangement of every correction, not permission to omit them. Sequential products for all \(m\le M\) take \(O(M)\) gates per residue/height, with explicit propagated errors. The Bernoulli rational constants and endpoint phase still need checked enclosures/arithmetic.

For order zero of the pole correction use the reviewed integral-moment formula
\[
\phi_0(z)=\int_0^1e^{zu}\,du,
\quad\left|\phi_0(z)-\sum_{m<Q}\frac{z^m}{m!(m+1)}\right|
\le\frac{\max(1,e^{\Re z})|z|^Q}{Q!(Q+1)}.
\]
At \(s=1/2+it\), \(d_a<1/N\) implies \(|z|=|(1-s)d_a|<1\). Summing the errors of the actual prefactors gives a sufficient bound
\[
E_P\le\frac{3\sqrt X}{NQ!(Q+1)}.
\tag{3}
\]
This uses \(e^{d_a/2}<3\) and \(\varphi(c)/c\le1\). Exact \(d_1=0\) can be recognized arithmetically. Arithmetic/log errors are separate from (3).

The Hardy sign proxy from the reviewed normalization packet is particularly useful here. Fix the source phase \(\epsilon_\chi\) once per character, with \(|\epsilon_\chi|=1\) and \(\epsilon_\chi^2W_\chi=1\). Its elementary real phase \(\phi_{0,a,c}(t)\) gives
\[
P_\chi(t)=\Re\{\epsilon_\chi e^{i\phi_{0,a,c}(t)}L(1/2+it,\chi)\}
=H_\chi(t)\cos\delta(t),\quad \cos\delta\ge17/18>0.
\tag{4}
\]
Thus a strict interval sign for (4) is sufficient; neither Gamma magnitude nor arbitrarily accurate log-Gamma is needed at each sign node. The phase is shared by all characters of a fixed conductor and parity at that height. Root phases are character-specific and can be cached. Their arithmetic tolerances must scale against a certified L magnitude. The positive factor in (4) is a theorem, not a fixed additive error floor. Count integrals still use the correct canonical Gamma phase; (4) does not replace that phase in a Turing formula.

## 3. Preserve the two exact transform interfaces

Let \(v=\varphi(c)\), \(n\) be the primitive count, and \(s_j=1/2+i(t_0+j\Delta)\), \(0\le j<J\), on an exact rational grid. Let \(L\ge4J\) be a power of two and \(r\) the residual expansion length. For each positive base \(n_0=c\nu+a\), certify its full integer bin \(q_{n_0}\), residue \(k_{n_0}=q_{n_0}\bmod L\), and real residual
\[
\left|\frac{L\Delta\log n_0}{2\pi}-q_{n_0}\right|\le5/8,
\qquad r_{n_0}=J(\Delta\log n_0-2\pi q_{n_0}/L),\quad |r_{n_0}|<1.
\]
For K=1 the moment arrays are
\[
A_{a,m,k}=\sum_{\nu:k_{n_0}=k} n_0^{-s_0}\frac{(-ir_{n_0})^m}{m!},\qquad 0\le m<r.
\]
With the normalized **positive** unit-group and time transforms, the main output is
\[
vL\sum_{m<r}(j/J)^m(P_G P_L A_m)_{\chi,-j\bmod L}.
\tag{5}
\]
The character label is positive; the time label is negative. The unit group is the manifest's product of cyclic factors, including both two-primary coordinates. A cyclic length-v transform is not generally that group transform. Both actual corrections and their errors are added for every residue and height, then transformed against the actual characters. They do not disappear into the fixed time bins.

The additional analytic head residual is at most
\[
E_R\le W_0/r!,\qquad
W_0=\sum_{a,\nu<N}(c\nu+a)^{-1/2}<2\sqrt{cN}.
\tag{6}
\]
This is a deterministic triangle bound, with no random cancellation.

A separate Gaussian/theta backend may share coefficients across characters and times using the reviewed joint Fourier plan. Its character scale is v; its time scale is \(\omega L\) after a normalized inverse DFT. Its root numbers, inverse-character reciprocal coefficients, frequency/time aliases and theta tails remain part of that backend. **The scales vL and \(\omega L\) are not interchangeable.** The modular bucket pilots are fixed examples, not a global production coefficient engine. Price that engine explicitly if choosing it instead of finite EM.

## 4. Error ledger and adaptive precision

For (5), let \(e_{a,m,k}\) bound input moment error and \(\alpha_{m,\chi,j}\) bound the normalized tensor arithmetic error against the exact transform of the serialized centers. Let \(\beta_{\chi,j}\) include final contraction/scaling rounding. A valid main numerical radius is
\[
E_{\rm main,\chi,j}\le
\sum_{m<r}(j/J)^m\left(\sum_{a,k}e_{a,m,k}+vL\alpha_{m,\chi,j}\right)+\beta_{\chi,j}.
\tag{7}
\]
Add (1), (3), (6), complete correction arithmetic and the proxy phase/root errors before accepting a sign. Coordinate rectangles require a proved conversion to norm radii. Shared errors are correlated; (7) does not assume independence. The arithmetic bound is relative to the exact center transform, so the input radius is not charged again through every FFT stage.

For an all-radix-two tensor with \(m=\log_2(vL)\), exact input magnitudes at most \(B=2^b\), normalize inputs by B. The root precision note proves output error at most \((2+3m)2^{-p}\) for normalized transforms when input, twiddle and completed-output rounding errors each meet the prescribed \(2^{-p}\) rule and \(m2^{-p}/2\le1/2\). Multiplying by vLB and summing residual modes gives the sufficient bound
\[
vLB(2+3m)R_j2^{-p},\qquad R_j=\sum_{k<r}(j/J)^k\le\min(r,J).
\tag{8}
\]
A conservative precision for a transform-only allocation \(2^{-s}\) is
\[
p\ge s+\lceil\log_2(vLB(2+3m)r)\rceil.
\tag{9}
\]
At \(vL=2^{29}\), \(r=24\), \(s=60\), (9) gives p=101,111,121 for b=0,10,20. These are sufficient fractional-bit counts after normalization, not measured requirements or complete output precisions. Arithmetic and analytic budgets outside this transform remain unpaid by this example. Actual non-power-of-two axes need their checked Bluestein/Rader/direct circuit and its own scaling/error bound. The radix-two formula cannot simply be asserted for them.

An effective adaptive policy is:

1. Generate and check a shared coarse tile. Keep every strict sign that contributes to a proposed bracket. An unresolved or exactly-zero sample is not itself required to become a sign.
2. Classify each unresolved request by its current error ledger. If only transform/proxy arithmetic is too wide, refine just that operation with the same exact input semantics. If input errors or analytic tails dominate, improve those inputs or cutoffs as well.
3. Reuse shared high-accuracy residue coefficients when available, but compute only the requested character rows. Alternatively use direct finite-U values for a few off-grid nodes. The source/function/phase identity must be identical to (4).
4. If enough rows at a common node need refinement, redo the complete character transform at higher precision. If few do, use certified row dot products. The choice is determined by actual operation/bit counts and cache availability, not a claim that one route is always cheaper.

For k hard characters at one shared residue array, direct contraction costs k v terms versus the actual full-character circuit cost \(F_G(v,p)\). The local arithmetic crossover is therefore \(kv\lessgtr F_G(v,p)\), plus input, twiddle and output costs. The familiar k near \(\log v\) estimate applies only when a proved circuit really has that operation order. It is not a conductor-independent threshold. Refining only k outputs cannot shrink an irreducible old input radius \(\sum_a e_a\); recomputing the needed coefficient array is still charged. For a Gaussian frequency cache, k hard character rows across R frequencies cost kRv contractions if done directly, before their time synthesis.

Nor does one hard character automatically require recomputing every **time** output: a requested lattice value is a certified finite dot product in the existing time coefficients; an off-grid value needs the unfolded sum, not a folded DFT value with a discarded phase. If its coefficient tails are already sufficiently small, this repairs output arithmetic locally. If they are not, the input refinement cost remains.

## 5. Literal schedule costs and a concrete warning

Use \(F_T(L,p)\), \(F_G(v,p)\) for the actual certified transform gate schedules, including their distinct normalizations. With K=1, the finite-U time-first schedule has
\[
vNr\text{ moment contributions},\quad
vrF_T(L,p)\text{ time-transform work},\quad
vJr\text{ contraction terms},\quad
JF_G(v,p)\text{ character work}.
\tag{10}
\]
It also pays vN log/base-phase construction, all bin proofs, and all vJ half/Bernoulli/pole corrections. Formula (2) permits O(vJM) scaled-product gates; the pole evaluation contributes O(vJQ) elementary series gates plus its logs/prefactors. These are not fixed unit-cost transcendental calls.

A character-first head schedule instead has rL character transforms, nr time transforms and nJr contractions; complete corrections still need their own character sums. A direct-height recurrence schedule preserves the character transform at each height but forms residue head sums using vN initial phases, vN(J-1) certified phase updates and vNJ head contributions. Long phase recurrences need accumulated rounding/step-error bounds or periodic certified restarts. They are not exact unit-modulus operations on rounded centers.

For illustration only, take J=1024, L=4096, r=24, K=1, M=18 and Q=24. Set T=floor(H(c))+1 and N=T+40. A block may end at T and use spacing 1/8. This does not certify any signs in the block. Under this main-height convention, cT<=135000000+c and X=c(N+1)<2^28 throughout the nonprincipal reduced domain. Exact checks give
\[
24!>2^{79},\quad E_M<2^{-68},\quad E_R<2^{-64},\quad E_P<2^{-67}.
\]
The three analytic errors sum to less than \(2^{-60}/8\). Finite arithmetic and the proxy remain to be budgeted. This example neither covers unspecified auxiliary heights nor forces all production outputs to tolerance \(2^{-60}\).

| Literal operation/storage category | c=262144, v=131072, N=527 | c=5, v=4, N=20000041 |
|---|---:|---:|
| Initial head bases | 69,074,944 | 80,000,164 |
| Direct-height phase updates | 70,663,667,712 | 81,840,167,772 |
| Direct-height head contributions | 70,732,742,656 | 81,920,167,936 |
| Batched moment contributions | 1,657,798,656 | 1,920,003,936 |
| Time FFT butterflies | 77,309,411,328 | 2,359,296 |
| Residual contraction terms | 3,221,225,472 | 98,304 |
| Dense v r L moment slots | 12,884,901,888 | 393,216 |
| One-mode v L slots | 536,870,912 | 16,384 |
| Contracted residue v J slots | 134,217,728 | 4,096 |

The time-butterfly count is exactly \(vr(L/2)\log_2L\). Character transforms, corrections and elementary evaluation are additional in both schedules. These categories have different bit-operation costs, so adding them as equal-time operations would be misleading. The large-conductor example nevertheless refutes an assumption that two-axis batching removes substantial arithmetic at no memory cost. It has more time butterflies alone than direct-height head contributions. At small conductor the same architecture has a very different balance. This is a statement about this literal schedule, not a lower bound against optimized batching.

Do not materialize the full moment tensor by default. Processing residue or mode slices, contracting before storage, using smaller J, and reusing character-axis work can reduce peak storage. They change passes, cache traffic and recomputation; the checker must price the actual schedule. A sparse initial bin tensor generally becomes dense after the time transform. No sparse-FFT saving is assumed.

## 6. Native work, checked work and proof representation

For each retained tile record evaluator type, cutoffs, exact input/node identities, normalized magnitudes, precision, circuit, input radii and final outputs used by the logical certificate. Count native search separately from accepted checked work:
\[
\mathcal C_{\rm gen}=\sum_{\text{all trials}}(\text{coefficients+circuit+corrections+search}),
\qquad
\mathcal C_{\rm check}=\sum_{\text{retained proof DAG nodes}}\text{verified arithmetic}+
\text{sign/count/coverage checks}.
\]
Failed native attempts need not become arithmetic proof records, but their time is still generation cost. Conversely a successful native result is not a proved leaf. Every retained bound needs either checked exact arithmetic/circuit replay or a proved evaluator theorem applied to independently checked inputs.

Use rounded dyadic gates rather than expanding an enormous exact rational elementary expression. With normalized mantissas at p fractional bits, stored centers have O(p) bits; a complex multiply uses O(p)-bit inputs and O(2p)-bit products before checked rounding. Exact binary scales and rational indices are separately recorded. A symbolic arithmetic cost may be expressed as counts of additions times O(p), products times the chosen integer multiplication cost M(p), and divisions/rounding comparisons at their actual operand sizes. It must include coefficient generation, not only FFT butterflies. No exponential-in-N denominator growth is inherent in shared dyadic moment summation. Unrounded factorial/polynomial expressions have different sizes and cannot be priced by this gated model without a proved rounding refinement.

A deterministic checker can reconstruct gates from compact centers and the fixed schedule instead of serializing a separate theorem for each gate. This compresses proof input; it does not make the checks free. Lean kernel reduction, a proved reflective checker, an MM0 arithmetic proof and a native interval computation have different trusted boundaries and costs. No Lean/MM0 ratio follows from the operation table. Hashes identify files; they do not prove circuit equality or function semantics.

Likewise, output signs may be stored as bit streams with index-implied character/time labels, but every selected sign still needs its evaluator proof and every manifest row still needs a closure record in this protocol. This is not a universal information-theoretic lower bound. Sharding by conductor/time makes memory bounded and lets accepted coarse tiles coexist with fine repair tiles. It does not justify dropping labels or charging all shared roots/coefficient arrays anew per character.

## 7. Completeness, inverse channels and the repair limit

Per conjugation orbit choose rational T>=H(c), T>50, h>0, and work height V>=T+h. The reduced domain already has H(c)>50. The reviewed nonprincipal closed-count identity and elementary Turing theorem give
\[
C_\chi(T)\le U=\frac{\overline A-W+2\overline B}{h},
\quad A=\int_T^{T+h}\frac{2\theta_{a,c}(t)}\pi\,dt,
\quad B=42+\frac{693}{100}\log\frac{c(T+h)}{2\pi}.
\tag{11}
\]
Here \(\overline A,\overline B\) are certified upper enclosures. Auxiliary opposite-sign intervals \((u_j,v_j)\subset(T,T+h)\) give the rational lower weight \(W=\sum_j(T+h-v_j)\). Real characters use the same positive channel twice; nonreal pairs use each partner's positive channel once. They are not doubled again. Canonical S is Euler-log normalized at right infinity, not an arbitrary principal argument.

The main lower count K comprises disjoint critical-line sign brackets and an independently justified central contribution. Require the exact strict inequality \(U<K+1\). Multiplicity, all real zeros and zeros exactly at T belong to the closed count. Open main brackets omit a boundary zero, so successful saturation excludes any unaccounted boundary zero. This avoids a separately sampled top path only after the closed-count/a.e. theorem has been proved. Main endpoints shared between adjacent tiles need compatible exact node/function/phase labels; brackets must remain disjoint. Separate arithmetic tiles need no contour-image seam equality.

The phase integral in (11) is common to characters of a given conductor/parity when T,h agree, and the allowance is common to the conductor. These are valuable shared proof nodes. Individual sign lists, central evidence and integer saturation remain distinct. If h or T changes for a hard orbit, its auxiliary data and integral must change too. A small allowance 2B/h does not by itself make saturation pass; missing auxiliary zeros and unresolved main zeros remain real costs.

This route proves original finite RH only on acceptance. It does not assume simple zeros to justify the checker. However ordinary sign-bracket production is not guaranteed to terminate even if finite RH is true: even multiplicities, unresolved exact sample hits, very close zeros, or inadequate auxiliary weight can obstruct it. Precision must be arbitrarily refinable in both arithmetic and analytic tails, and sample placement may change. A direct hard-output evaluator repairs a value enclosure, not a missing multiplicity proof.

For the original-RH target, a \(.555\) zero-free rectangle is **not** a valid fallback. A symmetry-invariant local rectangle with exactly one zero can force that zero onto the critical line, since horizontal reflection would otherwise give a second zero; the actual source symmetry and count must be proved. A count greater than one in a narrow box does not force all its zeros onto the line. Multiple critical zeros need suitable exact divisor/multiplicity evidence or another sound RH-specific method. Conductor one retains its own pole/xi, count and sign adapters. All these obligations must remain in an end-to-end cost comparison.

## 8. Consequential next step

The efficient checker interface should first support variable precision, point-value K=1 tiles, shared parity phase/count nodes, and mixed shared/direct certificates keyed to the same exact character. It should retain both a time-FFT schedule and a direct-height recurrence schedule, selecting by a checked workload description rather than forcing the large-conductor case through a dense moment tensor. The Gaussian/modular alternative needs its full coefficient-generation and tail costs in the same accounting.

The first obstacle to a credible total cost is no longer a mandatory 512/1024-bit pilot allocation. It is the absence of production distributions for sign margins, required residual/EM cutoffs, repairs, close-zero brackets and successful Turing deficits, together with unimplemented arithmetic proof backends. The formulas above expose those parameters without assigning them invented averages. A future authorized experiment should compare complete accepted sign/count packets and their checked operation sizes, not only native FFT throughput or easy value samples.

## Reproducible scalar checks and pins

`efficiency_spectral_batches_scalars_20261111.py` uses only integers, Fractions and factorials. It verifies six analytic scalar comparisons, the two literal workload rows and three precision choices. It imports no evaluator. Its receipt makes no timing or spectral claim. The first attempt to invoke the Windows `python` alias did not start; the retained script ran using the existing interval-environment interpreter. No new environment or dependency was created.

The following table records the exact files read or produced for this report. Prior reports' historical height profiles remain historical; only the root original-RH profile in section 1 is used here. Paper/source reviews are not Lean proofs.

| File | SHA256 |
|---|---|
| `work/qrh-blueprint/SPECTRAL_BASELINE_COST_COMPARISON_2026-11-11.md` | `0DD28598568EC61FC8B589017680AA9A3AE350608ADA32FD94D9869B9C06B9A5` |
| `work/qrh-blueprint/SPECTRAL_PRECISION_RESEARCH_2026-11-11.md` | `1C374964A90F977A94DE8FFD4D019F735C164D1318CB0C9243CB8812B9CADC90` |
| `work/qrh-campaign/agents/integration/UNIT_GROUP_CHARACTER_TRANSFORM_PLAN_2026-11-11.md` | `DFA02789B3025A997F98E0500B001B3C5A7D983C400EEDC8F7B6DD4ADDAE4866` |
| `work/qrh-campaign/agents/zero-sum/FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md` | `17D6A2E7478E3C03D8B9406C01A5AD93D4277E33B09009B6550D02357DE54BEC` |
| `work/qrh-campaign/agents/major-constants/JOINT_CHARACTER_FOURIER_BATCH_PLAN_2026-11-11.md` | `3D41376E00A58D5EBC8403151807694163F0E59923869DCAAAB08F51A6A3625D` |
| `work/qrh-campaign/agents/major-constants/FAMILY_BATCH_WORKLOAD_MODEL_2026-11-11.md` | `3A5444AB295112E86DF0740DB8F4533EC37510A66E41EB0DF0340D16CF82A4E1` |
| `work/qrh-campaign/agents/moebius/FAMILY_FINITE_FFT_PROOF_PLAN_2026-11-11.md` | `6E303D60C855E2CAD444EBC4EB3B1A3BD192D9BEAFAE0448F3F6D63CD9CDAC2E` |
| `work/qrh-campaign/agents/prime-estimates/FINITE_U_AUXILIARY_EXTENSION_2026-11-11.md` | `F96610CCC7D7F1B094DB3B9D3D287858AD7C0C38D819AB9B39AFA89946A6B855` |
| `work/qrh-campaign/agents/prime-estimates/FINITE_U_HARDY_NORMALIZATION_2026-11-11.md` | `06C9D3BF785BB183339D8EC64BE0B5AAD05331184C35356F575A8C126ADB724E` |
| `work/qrh-campaign/agents/zero-sum/REVIEW_FINITE_U_HARDY_NORMALIZATION_2026-11-11.md` | `96AE06D3F4D1701B13E0CFD529C0E53A0E9647A3B079DD19D03E66C734064EC1` |
| `work/qrh-campaign/agents/zero-sum/FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md` | `740840E7576E988AF4C8F8053030BE59EB4EA18DE8C7E0D6B391BF7C9B1C5DEF` |
| `work/qrh-campaign/agents/zero-sum/FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md` | `6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4` |
| `work/qrh-campaign/agents/integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md` | `72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C` |
| `work/qrh-campaign/agents/integration/TURING_AUXILIARY_MARGIN_DESIGN_2026-11-11.md` | `36AFA1DF2A38D56A0677816038B08821B6CD5919118CEADB7616717047209943` |
| `work/qrh-campaign/agents/zero-sum/FAMILY_CERTIFICATION_TERMINATION_LIMITS_2026-11-11.md` | `8E98E114689E3468F16088D82EF7568967A5015431A34C072CD101873CBF31FC` |
| `work/qrh-campaign/agents/zero-sum/POLE_DIFFERENCE_JET_ENCLOSURE_PLAN_2026-11-11.md` | `3F73AF600725DDB51ED622577BF374251B38C408D0D52D4EA06CFCF1BDD60011` |
| `work/qrh-campaign/agents/zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md` | `53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54` |
| `work/qrh-campaign/agents/zero-sum/efficiency_spectral_batches_scalars_20261111.py` | `B11464CF3100089EF5BD5478FDE553052AB11E965D9467CE880D82A15F58E1AD` |
| `work/qrh-campaign/agents/zero-sum/efficiency_spectral_batches_scalars_20261111.json` | `58BB919C76A3498E57A94376173E49F457BE0AFBFF66401EB93D1D585D4E758D` |
