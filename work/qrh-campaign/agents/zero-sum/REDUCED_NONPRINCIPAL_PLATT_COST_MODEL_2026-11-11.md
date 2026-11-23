# Reduced nonprincipal family: shared evaluator and checker costs

2026-11-11. Paper derivation, primary-source inspection and integer/rational metadata only. No L-values, zeros, character values, transforms, analytic numerical evaluations or builds were run. This report does not certify RH, select a production precision, or estimate runtime.

The useful change from the earlier finite-EM tensor example is to share the Hurwitz lattice across conductors at each exact height. That removes repeated long residue sums. For small conductors, where there are few other conductors at the required heights, the theta/time-transform route has a different sharing pattern. Character transforms, interpolation, hard outputs and completeness remain substantial in both schedules.

## 1. Domain and primary algorithm boundary

Use the proposed reduced original-RH domain: odd c<=150000 through 10^8/c; 4|c<=300000 through max(10^8/c,200+75000000/c). Conductor one is separate and excluded below. The exact nonprincipal manifest has 149999 conductors, 5543640187 primitive labels and 9118941848 unit residues in total. Empty primitive levels c=2 mod4 require the proved conductor classification. The consumer refactor is still a mathematical/formal obligation; these data do not imply the broader old `PlattGRH` proposition.

Platt's primary algorithm has two regimes. The large-conductor method shares a Hurwitz-alpha lattice at fixed height and applies a unit-group DFT. The small-conductor method transforms a tilted theta series in time. The reported switch was around10000 and the initial height spacing was5/64, followed by interpolation and direct repairs. These are historical choices, not universal admissibility or optimality claims. [Platt, sections4–7](https://arxiv.org/pdf/1305.3087).

The public implementation snapshot used here is `djplatt/code` commit `1f19fcbefa33d2fe5949ddbcd4d3df75deca6819`. Its large-conductor consumer reads a precomputed lattice and caches Bluestein kernel transforms. It also exploits parity. It is not authenticated as the exact historical executable or a checked proof backend. [Pinned source](https://raw.githubusercontent.com/djplatt/code/1f19fcbefa33d2fe5949ddbcd4d3df75deca6819/l-func/int-l-func5.11.cpp).

The operation inventory below uses a deliberately explicit full unit-group circuit. It does not assume the source's additional parity optimization. The earlier report `EFFICIENCY_SPECTRAL_BATCHES_2026-11-11.md` supplies adaptive precision and completeness contracts; its illustrative dense finite-EM time tensor is not imposed on this different architecture.

## 2. A complete large-conductor point interface

Let s=1/2+it, alpha=a/c, with a a unit residue. Define the shifted function

    Z_M(s,alpha)=zeta(s,M+alpha),
    zeta(s,alpha)=sum_(0<=n<M)(n+alpha)^(-s)+Z_M(s,alpha).

This is the continued Hurwitz identity. Taking M>=1 separates the singular behavior as alpha approaches0. For a grid anchor alpha0 in[0,1], a real displacement d=alpha-alpha0 and length P>=1, store the normalized alpha coefficients

    C_k(s,alpha0)=(-1)^k (s)_k zeta(s+k,M+alpha0)/k!,  0<=k<P.

They are actual function coefficients, with independently checked seed balls. Their identity follows first in the absolutely convergent half-plane, then by analytic continuation; one must not differentiate a conditionally convergent critical-line Dirichlet series.

The residue output is the finite head plus sum_k C_k d^k. Transforming against actual character values gives

    L(s,chi)=c^(-s) sum_(a unit) chi(a) zeta(s,a/c).

The external c^(-s), the positive character transform convention and its factor v=phi(c) for a normalized implementation must all be preserved. For M=1 the finite-head term after scaling is exactly a^(-s), so the large alpha^(-s) and c^(-s) factors need not be constructed and cancelled numerically. The common Hurwitz pole cancels for nonprincipal characters. This point schedule never evaluates s=1; any extension to that point must use the reviewed entire common-pole-difference adapter, not a totalized individual Hurwitz value.

Here is a new sufficient interpolation bound, independent of success of a sign test. Real-parameter Taylor's integral remainder and the absolutely convergent P-th derivative give, when the segment stays in alpha>=0 and M>=1,

    |R_P| <= |d|^P |(s)_P|/P!
               [M^(-P-1/2)+M^(1/2-P)/(P-1/2)].                 (1)

Indeed zeta(s+P,M+alpha) is bounded by its first term plus the decreasing integral at real part P+1/2. The bound holds throughout the real segment, including an anchor at0, because the shifted base is at least M. For |t|<=V, |s+j|<=V+j+1, so |(s)_P|<=(V+P)^P. This also justifies the Taylor remainder at the critical line without a tail-ratio guess.

With M=1, nearest alpha mesh of denominator D, P=24 and the following height bands, (1) is less than 2(2/3)^24/24! per residue:

| Height upper bound V | D | P |
|---:|---:|---:|
|500|512|24|
|1000|1024|24|
|2000|2048|24|
|5000|4096|24|
|10000|8192|24|

Each row has (V+24)/(2D)<2/3. At a boundary tie either nearest anchor is valid; certify the exact rational displacement rather than a floating lookup. For c<=400000, v/sqrt(c)<=sqrt(c)<633. Thus the actual character-summed interpolation error is

    E_alpha < 1266(2/3)^24/24! < 2^-82.                       (2)

The exact scalar checks use 24!>2^79, (2/3)^24<2^-14 and1266<2^11. Equation(2) is only the alpha truncation allocation. Seed, finite-head, conductor-phase and transform errors are separate. No claim is made that these D/P values match the historical precision or certify any output.

For seed radii e_(k,r), a residue evaluation has radius at least sum_k |d|^k e_(k,r), plus its Horner/finite-head arithmetic. After multiplying by c^(-s), a valid shared input-error contribution is c^(-1/2) times the sum of the residue radii. For a normalized group transform with center error e_G, add v c^(-1/2)e_G and final scaling error. Relative accuracy cannot be inferred from these absolute bounds. The Hardy sign proxy/root-phase error must be charged against an enclosed L magnitude.

Seed construction is not free. If a chosen EM producer uses N_seed and M_seed at a height, a direct schedule for all (D+1)P seeds has order (D+1)P(N_seed+M_seed) arithmetic contributions, plus elementary leaves and analytic remainders. A shared jet/transport schedule can change that count only with its error proof. Denote the actual checked seed cost by C_lat(t,D,P,p). It is paid once per shared exact height/precision, not once per conductor. Every correction and remainder of that producer remains required.

## 3. Height cohorts and exact character circuits

Let G_c be the manifest's product of cyclic unit groups of orders m_i, v=product m_i, and n the primitive count. The constructive CRT ordering is essential: a cyclic length-v transform is generally wrong, notably at powers of two. For an explicit axis circuit define

    B_G(c)=sum_i (v/m_i) b(m_i),
    P_G(c)=sum_i (v/m_i) p(m_i).

For a power of two m, b(m)=(m/2)log2(m), p(m)=0. For other m choose l=nextPowerOfTwo(2m-1), use cached Bluestein chirps, and set b(m)=l log2(l), p(m)=l+2m. These count two radix-two transforms per input, convolution products, and two chirp multiplications; the chirp-kernel transform is a separate reusable setup. Butterfly twiddle multiplication is inside the butterfly category. Do not count b and p as equal-time operations. This is one correct candidate circuit inventory, not a lower bound or an audit of the entire historical implementation.

The resulting per-height large-conductor schedule is

    C_lat(t) + sum_(c active at t) [P v coefficient contributions
                     + B_G(c) butterflies + P_G(c) extra products
                     + O(v) head/scaling + O(n) output/phase work].       (3)

The root-number Gauss transform is once per conductor/precision, not once per height. Likewise cache character indexing, chirps, twiddles and exact bin locations where their inputs agree. Nonprimitive outputs may be discarded after the transform; replacing v by n inside the full transform cost requires a separately proved pruned circuit.

At the illustrative switch c>10000 the reduced cohorts are:

| Actual height t | Conductors still needing data | Unit residues | Primitive labels |
|---:|---:|---:|---:|
|0 or450|142500|9093611126|5525163079|
|500|130000|7700461046|4960553663|
|1000|67500|2507708382|1829387966|
|2000|30000|607945976|443510739|
|5000|7500|75996340|55444200|
|10000|0|0|0|

This is why a universal high-height lattice ceases to amortize well. It also explains a genuine large-conductor saving: low-height seed work can be reused over many different moduli, a sharing dimension absent from a separately generated finite-U head for each conductor. Exact height alignment is required. Interpolated nearby heights are not cache hits without another theorem.

## 4. Concrete inventory beyond height volume

The companion uses the nominal positive grid j*(5/64), with J_c=ceil(64H(c)/5)+1 nodes. Its last node is at or beyond H(c). This is the coarse Hurwitz/character-FFT seed grid only, not the ordinarily refined sign-test grid. It is bookkeeping for candidate values, not a certificate that every zero is found. Auxiliary Turing intervals and interpolation guard nodes are excluded and must be added later.

For c>10000 it gives:

| Operation or data category | Reduced domain | Broad declared domain |
|---|---:|---:|
|Primitive labels|5525163079|18049675497|
|Nominal primitive output slots|75730502011007|146444950690741|
|Residue-height inputs|114223068442718|210868915879682|
|Character butterflies B_G summed over grid|5723455868055742|11157579114856464|
|Extra character products P_G|976028467193580|1853446833767412|
|P=24 alpha contributions|2741353642625232|5060853981112368|

The reduced/declared ratios differ by category: primitive labels .306108–.306109; nominal outputs .517126–.517127; residue work .541678–.541679; butterflies .512965–.512966. These refine a height-volume comparison for this literal circuit, without estimating runtime. The broad domain is the project's old declaration, not the larger historical all-conductor computation.

The shared height grid has127989 nodes for either large-conductor domain. The adaptive D/P bands above contain17223585528 seed-coefficient slots in aggregate. At one height at most8193*24=196632 seeds are needed. Neither number is their arithmetic generation cost, and the aggregate is not simultaneous RAM. Stream heights and conductor shards; retain only the values/interpolation neighborhoods and proofs needed downstream.

A naive per-conductor/per-height EM head with N_c=ceil(H(c))+40 would have193004109809799594 head terms in the reduced large range. That is70.404674–70.404675 times the P24 alpha-contribution count. The alpha route also pays its shared seed construction, short head, transforms and all errors. This comparison exposes avoidable repeated summation; it is not a70-fold runtime prediction or a claim that the naive EM parameters are validated.

A direct sum over residues separately for every primitive character would have5381879857695405748 terms. The group circuit replaces these with the butterfly/product counts above. The raw direct-term/butterfly ratio is940.319971–940.319972, but the operation costs and setup differ. This is an algorithmic saving already available in the primary construction, not a new domain restriction.

Conductor arithmetic matters. At c=262144, v=131072, n=65536 and unit axes[2,65536], the circuit needs1114112 butterflies and no Bluestein products per height. At c=100003, v=100002, n=100001 and one axis100002, it needs4718592 butterflies plus462148 products. At c=300000, v=80000, n=16000 and axes[2,8,2,2500], the counts are3607872 and422144. A fixed cost per primitive label misses these differences. Mixed-radix improvements may reduce the explicit Bluestein baseline; they need their own circuit and error accounting.

## 5. Small conductors and time sharing

For 3<=c<=10000, the reduced domain has7499 conductors and18477108 primitive labels, but its nominal positive grid still has4729100914759 outputs. The isolated Hurwitz lattice at very large t has few consumers. Preserve the accepted critical-line theta identity instead:

    F_chi(t)=epsilon_chi exp(b t)c^(it/2) completedLFunction_chi(1/2+it),
    hatF_chi(x)=2 epsilon_chi c^(-(2a+1)/4) exp((a+1/2)(x+ib))
                 sum_(m>=1) m^a chi(m)exp(-pi m^2 exp(2(x+ib))/c).

Here b is real with |b|<pi/4. The source completion convention, both parities and root phase are those of the accepted Gaussian report. Negative-frequency coefficients use the actual theta functional equation and Gauss/inverse-character factor. They are not obtained by dropping that factor. Positive-radius buckets can be shared by both parities and all characters.

For R retained nonnegative frequencies, cutoffs M_j, two possible parity channels and time length L, one shared schedule has

    sum_j M_j elementary theta terms,
    at most 2R group transforms,
    n time transforms of length L,
    O(nR) phase/folding and O(nL) output work.                         (4)

Only existing parity channels are computed. Primitive filtering before the time transforms is valid. The character scale is v for a normalized positive transform; the final normalized time inverse has factor omega*L, omega=2pi/B. The finite-EM tensor's factor vL is not interchangeable with this one. Retain zero frequency and the unpaired Nyquist endpoint correctly.

A useful conditional size observation follows directly from the Gaussian tail. With d=pi*cos(2b)*exp(2x)/c, the omitted theta terms are bounded by the first omitted term divided by1-r, where r=((M+2)/(M+1))^a exp(-d(2M+3))<1. It follows by bounding successive positive term ratios. If cos(2b) is chosen comparable to1/V and a fixed error logarithm is denoted ell, the central cutoff has sufficient scale sqrt(cV*ell); at x>0 it falls roughly as exp(-x), with prefactors also charged. In the main reduced domain cH(c)<=135000000. This limits the central truncation scale but does not bound the number of frequencies or time outputs.

For frequency spacing omega, summing a cutoff of form C exp(-j omega) costs at most C/(1-exp(-omega)), plus ceiling/endpoint contributions. Thus (4) can share the expensive coefficient terms instead of multiplying them by n. R,L,ell and b still need a complete two-alias/series-tail parameter certificate through the actual auxiliary work height V. No such new global parameter choice is certified here. The reviewed modular-bucket alternative may replace direct sums at difficult coefficients, but its branch/transport proof and actual term counts must remain in C_coefficient.

Select the conductor switch by comparing (3) and (4) with actual precision and auxiliary ranges. The historical10000 is a reasonable inventory boundary, not an optimization theorem. Near the switch, limited time interpolation of shared point samples can be cheaper than an entire dense residue-by-time tensor. It must include the interpolation tail and the actual tilted function's normalization.

## 6. Adaptive output checks and completeness

### Coarse values, ordinary interpolation and exceptional repairs

The75,730,502,011,007 large-conductor slots count coarse primitive values, not character FFTs at every interpolated node. Refining every consecutive coarse interval by factor8 would give605,805,339,946,503 distinct nominal nodes, of which530,074,837,935,496 are new interpolated nodes. This union formula is8*sum(n J)-7*sum(n). It excludes all guard and auxiliary nodes. None of those new nodes requires a new character transform merely because its height differs from the seed grid.

The primary paper reports routine8-fold interpolation, then32/128/512 when needed. Its approximately.0003% remaining-functions statistic occurs after that sequence. It is not the proportion unresolved on the5/64 seed grid, and no such repair rate is assumed here. The complete cost model has separate sets of character segments reaching each refinement level. [Platt, section7](https://arxiv.org/pdf/1305.3087).

For a concrete finite interpolation schedule let Delta=5/64, retain coarse samples Y_chi(n)=Lambda_chi(n Delta) of the actual real, exponentially scaled completed function used in the interpolation theorem, and use a Gaussian window width h_I. At target t=(k+theta)Delta, theta=ell/u, define the real kernel

    K_(d,theta)=exp(-((d-theta)Delta)^2/(2h_I^2))
                  sin(pi(d-theta))/(pi(d-theta)),

with its removable value1 at d=theta. The finite damped-sinc candidate is sum_(|d|<=m) Y_chi(k+d)K_(d,theta). The section6 Fourier-tail and omitted-sample bounds, or a separately proved equivalent, are required for its error. This equation defines a finite candidate, not exact band-limited interpolation. The selected m,h_I and height/conductor domain must make both errors small enough. The same kernel is reusable across all characters/conductors with identical Delta,h_I,theta; its analytic error bounds can vary with conductor and target range.

If coarse sample radii are e_(k+d), kernel radii f_d and the respective serialized centers have magnitudes y_d and k_d, a valid input/arithmetic allocation includes

    sum_d [k_d e_(k+d) + y_d f_d + e_(k+d) f_d]
       + finite accumulation rounding + both analytic interpolation tails.

No independence of errors is assumed. A coarser shared bound may replace this sum, but cannot remove it. Reusing the elementary sign proxy alone as Y is invalid without a new interpolation theorem for that proxy. The accepted phase-error sign equivalence does not identify its amplitude or Fourier tails with Lambda. For this schedule, the two parity-dependent Gamma/exponential factors can be checked once per height and reused across conductors, followed by the actual conductor/root phases. They remain proof inputs even though their number is much smaller than the number of characters.

Direct finite interpolation costs(2m+1) products per new target, with shared kernels. For a block of M coarse indices, polyphase convolution can instead compute each offset theta at once. Choose a padding length P_I>=M+2m, retain only interior outputs, and cache each kernel transform. Per character this costs one forward length-P_I transform, one inverse and P_I point products for each of the u-1 new offsets. A radix-two schedule has u*(P_I/2)log2(P_I) butterflies plus(u-1)P_I products. Kernel-transform costs are shared, and guard samples prevent false circular wrap. This is a finite algebraic acceleration of the same damped-sinc sums; the same analytic tails and output scaling remain. It is not a fresh Hurwitz/character FFT at each refined height.

For exceptional refinement let S_u be the actual unresolved character segments after the prior level. Charge interpolation on S_u only, with a reusable forward sample transform where grids/guards agree. New off-grid EM values are a separate category; they are needed only when interpolation/input errors or unresolved geometry require them. If a segment's higher-precision coarse values are regenerated, charge that work explicitly. The primary paper's repair percentage cannot substitute for the unknown sizes of S_u. Near the real axis, a theorem with a sufficiently-large-height hypothesis cannot be applied automatically: use a proved small-height interpolation variant or direct values. Negative guard samples require the actual inverse-character/phase adapter, not copying the same character's positive samples.

Native search can use dense interpolation, while proof acceptance checks only the selected strict signs and auxiliary weights. Given R requested signs for one character segment, direct interpolation needs R(2m+1) products; complete polyphase replay has the preceding transform cost. Choose the cheaper checked circuit with all shared coarse values and error proofs retained. There is no need to verify discarded untrusted search outputs, but native generation still pays for them. Conversely selected signs cannot be accepted merely because a search FFT suggested them.

The common point pass should use the precision justified by its current error ledger. Keep strict signs that work. For unresolved outputs, refine a shared residue array only when its uncertainty dominates; otherwise redo a requested row contraction or phase at higher precision. At a given node k direct character rows cost kv terms, versus B_G/P_G for a full transform. The crossover varies with the actual group circuit. A hard input array cannot be repaired merely by performing its transform more accurately.

Time interpolation and off-grid direct evaluation are local services. Every accepted repair must identify the same actual character and fixed root phase. Unknown signs and failed searches do not become proof claims. Their native cost is nevertheless part of generation. Historical repair percentages are not assumed for this campaign.

Inverse-character reuse avoids computing negative ordinates anew when all positive character rows have been produced. It does not generally halve the positive rows: a nonreal pair needs both positive channels to cover both signs of its zeros. Real-axis zeros need explicit treatment. The exact integer manifest has121577 real primitive labels, giving2771880882 conjugation orbits, but those counts alone do not prove the source conjugation identity or central nonvanishing.

For each orbit, retain actual multiplicities, closed target height, Turing auxiliary signs/weights, the canonical gamma phase integral, and integer saturation. Phase integrals and allowance bounds are shared for equal conductor/parity/endpoints; sign lists and saturation are character-specific. The elementary Hardy sign proxy can reduce point-phase work, but does not replace the canonical phase in the count identity. A failed Turing interval may require moving or extending auxiliary data. That cost is absent from the nominal inventory.

The sign/count acceptance theorem is sound without assuming RH or simplicity; it proves the stated finite RH only on success. A universal runtime or termination bound does not follow, even if RH is true, because ordinary sign brackets cannot account for arbitrary multiple critical zeros. Nor can a .555 strip exclusion replace the original-RH conclusion. These are completeness limits, not arithmetic errors that a faster FFT fixes.

## 7. Checked arithmetic and the next decision

Generation cost sums every attempted seed, transform, interpolation and repair. Proof checking sums the retained arithmetic DAG, including seed enclosures, elementary leaves, analytic bounds, scaled transforms and manifest/coverage/count checks. Hashes and native interval output do not prove these identities. The historical native timing gives no Lean/MM0 multiplier.

If p-bit normalized dyadic gates are used, additions and products cost their actual O(p) and M(p) integer operations, with binary exponents and rounding comparisons separately charged. Intermediate magnitudes and cancellation determine guard bits. Serializing a compact schedule instead of every gate changes proof input size, not the number of checks. A shared seed theorem may be invoked by many conductors without proving it repeatedly; the conductor-specific alpha contractions and transforms still run.

The first cost-critical implementation decision is now the common-height Hurwitz seed producer and its streamed character-transform checker, not a full family scan. A future separately authorized bounded test should contain a shared height lattice, several conductors with different unit-group shapes, genuine error budgets, direct hard-output repairs and a complete small count packet. It should report native generation and checked arithmetic separately. Before that, the remaining paper work is a globally admissible seed/interpolation/auxiliary parameter selector, not a guess at historical throughput.

## Reproducibility and retained dependencies

`nonprincipal_platt_schedule_metadata_20261111.py` constructs a smallest-factor table only to enumerate integer conductor metadata. It computes local primitive counts, actual unit-group axis orders, real-label counts, exact rational heights, nominal sample counts and the chosen circuit inventory. It performs no character or analytic-function evaluation. It checks the isolated alpha-tail inequalities in(2). Its JSON includes all conductor regimes, both domains, cohort sizes, examples and ratio enclosures. Auxiliary heights, successful signs and complete output precision remain explicitly outside its PASS status.

Source-level mathematical interfaces reused here are the frozen `FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md` (53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54), `FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md` (5FED76F0F59A6422977D968DD7F2018FEDAE0A175DE1ECD43D956EFDEDF44F41), `../major-constants/JOINT_CHARACTER_FOURIER_BATCH_PLAN_2026-11-11.md` (3D41376E00A58D5EBC8403151807694163F0E59923869DCAAAB08F51A6A3625D), and the error/completeness interfaces listed in `EFFICIENCY_SPECTRAL_BATCHES_2026-11-11.md`. These are paper/source reports, not imported spectral evidence or Lean proofs. The current reduced-domain consumer obligations are recorded in `../audit/EFFICIENCY_REDUCED_RH_REFACTOR_2026-11-11.md`.
