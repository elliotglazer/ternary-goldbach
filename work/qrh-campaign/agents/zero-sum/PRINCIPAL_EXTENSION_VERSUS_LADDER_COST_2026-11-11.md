# Principal RH extension versus the mixed ladder

2026-11-11. Paper research and exact integer/rational metadata only. No zeta values, zeros, primes, Gamma values, FFTs, builds or production certificates were evaluated. This report prices a conditional alternative; it does not establish that any proposed height supplies the required prime gaps.

The credible alternative is a shared, windowed principal sign evaluator with local interpolation and a complete principal zero count. A direct EM value at every sign node is a poor production baseline at these heights. A separate Riemann–Siegel value at every node also loses most available sharing. None of the existing tiny EM or rational-panel budgets is a global precision requirement.

The comparison is incremental. The reduced original-analysis route already requires principal RH through H0=100000000 and the nonprincipal family. Extending the principal range replaces only the proposed finite prime-ladder work, once a prime-gap theorem and all its hypotheses are proved. It does not remove the nonprincipal major/minor-arc spectral obligations. The H0 certificate is an existing obligation, not an already checked file that this report imports.

## 1. Conditional heights and the right cost comparison

The independent prime-gap investigation has identified two candidates, still subject to its full theorem audit:

- H=3000000000000 with a binary cutoff around 20000000000000000, using a partial-RH prime-counting result together with additional explicit short-interval, zero-density and zero-free-region inputs.
- H=9000000000000 with binary cutoff around 10000000000000000, using a conservative partial-RH prime-counting route.

The first candidate is not a theorem from finite RH alone. This report leaves every such analytic condition with that investigation. It also gives sensitivity rows at 1e11, 1e12 and 1e13. No height is adopted merely because a published computation reached it.

For a fixed final binary cutoff and final analytic threshold, cancel the shared binary, nonprincipal-family and principal-H0 costs. The comparison is

    extra principal generation + checked spectral arithmetic + new analytic library
    + principal completeness/assembly + I/O
    versus mixed-ladder generation + primality checks + ladder assembly + I/O.

If binary cutoffs differ, add the actual difference in complete binary work. The gap route may leave a lower finite ladder or transition interval; it must be charged. A new density theorem is not free simply because its numerical conclusion is compact.

The root mixed-ladder frontier has 181029996372 rungs for its B=1e16 shape and 90804183483 for B=2e16. Those are literal construction sizes, not minimal possible ladders. Compare their shared modular arithmetic against the shared spectral circuit, not one generic prime proof against one independent zeta call.

## 2. Principal acceptance is different from the character-family count

Let N(T) count actual nontrivial zeros with 0<Im(rho)<=T, with analytic multiplicity. Source xi has no real zeros; this must be consumed from its proof, not inferred from sign samples. Conjugation handles negative ordinates. The source-normalized principal formula is

    N(t) = 1 + theta(t)/pi + S(t)

at nonexceptional heights, with S continued from the positive zeta value on the right. It has the principal +1 and one positive-height channel. The nonprincipal symmetric formula with two character channels and two S allowances cannot be substituted at conductor one.

There are two usable completeness interfaces.

1. An exact total count from a certified top path, using the existing principal count/argument bridge, followed by enough disjoint critical-line sign brackets. A top endpoint must have a whole zero-free horizontal connector or a proved closed-endpoint adapter. A point sample alone cannot exclude an off-line zero at that ordinate.
2. A principal Turing inequality. Suppose the canonical theorem gives absolute integral of S on [T,T+h] at most Bzeta. Set A=integral of 1+theta/pi there. If auxiliary sign brackets (u_j,v_j) are disjoint and contained in (T,T+h), then W=sum_j(T+h-v_j) is a lower bound for the integrated number of added zeros. Thus

       N(T) <= (A_upper + Bzeta_upper - W)/h.

   This follows by integrating the count identity almost everywhere and using the closed count at T. It retains zeros exactly at T; endpoint jumps have measure zero. If K is a proved lower count through T, the strict rational comparison U<K+1 gives N(T)=K.

The published principal Turing allowance in Platt's 2017 paper, Theorem 4.2, is 2.067+0.059 log(t2) for t2>t1>168*pi. Its original analytic proof or an internally proved replacement remains required. The accepted nonprincipal allowance does not automatically cover c=1. An exact top count is available as an alternative if this principal Turing producer is not formalized.

For the incremental range, K may include an independently certified N(H0) plus new disjoint brackets above H0. A bracket crossing H0 needs an explicit partition/count rule. Reusing an old count without its actual zero and source proof is invalid. Work beyond H must include whatever auxiliary height the selected completeness test uses.

Ordinary sign brackets certify at least one zero each. Saturation rules out all missing multiplicity and off-line zeros, but production need not terminate under finite RH alone. Multiple zeros, small extrema and unresolved sample hits can prevent sign discovery. Precision refinement does not replace missing multiplicity evidence. No critical-line simplicity assumption is introduced.

## 3. What the primary implementations contribute

[Platt 2017, sections 3–4 and appendices A–C](https://research-information.bris.ac.uk/ws/files/78836669/platt_zeta_submitted.pdf) gives the windowed Fourier method, truncation/alias bounds, Turing completion and rigorous local interpolation. The function is real on the critical line. Its principal-pole term must be retained. Parameters include a window, frequency cutoffs and Taylor order. The paper's fixed experiment parameters are historical examples, not a proof that they work at 1e13.

[Platt–Trudgian 2021, section 2](https://arxiv.org/pdf/2004.09765) reports interval verification through 3000175332800 using sign changes and completeness. It avoided high-precision isolation when a sign change sufficed. The reported roughly .01 sampling and rare refinements are observations from that implementation, not certified hard-case frequencies for a new checker. Its 7.5 million core-hours are historical native-generation evidence, not a Lean/MM0 forecast. The published RH result is not being imported as our spectral proof.

The [version-pinned FLINT implementation](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/platt_multieval.c) exposes the arithmetic schedule. It constructs K rows at N window nodes, computes their transforms, performs K padded length-2N convolutions, and uses a final inverse transform. It encloses the principal-pole term and every alias/truncation contribution. Its signs, frequency reversal, factorials, division by A and final multiplication by A are part of the contract. This is primary algorithm evidence, not a trusted proof oracle.

The [interpolation implementation](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/platt_ws_interpolation.c) separates finite weighted sample sums from interpolation error bounds. Its direct-value helper calls builtin zeta/Gamma, so a proof-producing repair must replace that helper with a proved evaluator. Calling the wrapper cannot bypass these obligations. No implementation from these sources was run here.

## 4. Normalization and a sign-specific saving

Write R(t)=exp(pi*t/4)*pi^(-it/2)*Gamma(1/4+it/2)*zeta(1/2+it). It is real. The source entire xiF is

    xiF(1/2+it) = -(t*t+1/4)*pi^(-1/4)*exp(-pi*t/4)*R(t).

All displayed factors outside R are known real nonzero factors. This pins the function and the sign reversal to the actual source, without counting Gamma poles or zeta's pole as nontrivial zeros.

For window center t0 and width h, the Fourier backend evaluates

    f(u)=R(t0+u)*exp(-u*u/(2*h*h)).

For sign acceptance, retain f directly. Dividing out its positive Gaussian is unnecessary and amplifies absolute errors near the window edges. Use only a central core, overlap adjacent windows, and keep the actual positive factor in the node semantics. Different windows can certify signs of the same R-node without sharing identical numerical centers.

Interpolation must still operate on its declared function. If it uses unwindowed R values or a differently centered Gaussian, multiply each input enclosure by the exact positive conversion factor and propagate its error. One cannot feed arbitrary windowed values into an unwindowed sinc formula. Keeping central cores bounds this conversion, but smaller cores increase the number of windows.

A generic interpolation check has

    error <= sum_j |weight_j| * input_radius_j
             + weight/arithmetic error + alias tail + omitted-sample tail.

The weights include sinc and any Gaussian ratios. The function is not exactly bandlimited; the alias term cannot be omitted. Existing fixed-error approximations cannot guarantee arbitrary refinement. If a difficult interval is dominated by input or analytic tails, refine those terms rather than only increasing the interpolation arithmetic precision.

## 5. Actual operation categories

Use N=AB for a power-of-two base window length, K retained Taylor rows, J positive Dirichlet coefficients, and U<=B usable height width. These letters follow this section only. A literal implementation of the pinned circuit has:

    J base log/root/phase coefficients and O(J*K) bin-moment operations;
    N Gamma/exponential base nodes and O(N*K) polynomial-weight operations;
    K length-N forward FFTs;
    3K length-2N transforms for the padded convolutions;
    2N*K pointwise products;
    one length-N inverse FFT;
    all alias, Dirichlet/Taylor, principal-pole and rounding checks.

The radix-two butterfly total is

    (K+1)*(N/2)*log2(N) + 3*K*N*log2(2N).

For N=32768,K=44 this is 80265216 butterflies, 2883584 convolution pointwise products and 32768 Gamma base nodes per window, before binning, error calculations, upsampling and repairs. Two dense K*N tables alone contain 2883584 complex slots. This is a literal algebraic example, not an accepted parameter set at any new height. Streaming or fused transforms can change it and require their own schedule.

Over windows i, the accountable work is the sum of these terms at J_i,K_i,N_i,p_i, plus interpolation repairs, overlaps and completeness. Reusing a log/bin table across centers is valid; the phase exp(-i*t0*log(j*sqrt(pi))) changes with t0. Checked recurrences or refreshed phases must pay their accumulated error. K/J cannot remain fixed merely because a historical program fixed them on a smaller range.

The Dirichlet-tail source provides an explicit condition of the form

    C(sigma,t0,h,0)*exp((2*sigma-1)^2/(8*h*h))
      *pi^((1-2*sigma)/4)*J^(1-sigma)/(sigma-1) <= allocated_error,

for its permitted odd sigma>=3. See the [pinned B1 routine](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/platt_lemma_B1.c) and its cited lemma. J must be chosen with the actual C bound and the other errors, not a bare sqrt(t0) estimate. The [B2 routine](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/platt_lemma_B2.c) supplies the Taylor tail, multiplied by 2*sqrt(J)-1. These coupled bounds and the four alias tails are the parameter-selection obligation. They have not been newly certified here at the candidate heights.

This is why the architecture can share high-height input work without a numerical total-cost claim. Fixed-width windows with J growing like sqrt(t0) can still produce a height-integrated coefficient count of order H^(3/2)/U. Growing window/core sizes can change that balance but also changes gamma nodes, memory, tails and repairs. The primary algorithm motivates such optimization; it does not provide a free fixed-cost value oracle.

## 6. Exact metadata and poor fallback baselines

The companion uses only Fraction, integers and integer square roots. Machin's alternating series and a range-reduced atanh series give rational enclosures of

    F(H)=H/(2*pi)*(log(H/(2*pi))-1)+7/8.

The following differences are rounded outward to millions. They are leading-term proxies, NOT actual zero counts, count bounds or sign success predictions.

| H | F(H)-F(1e8), in millions | Additional intervals at spacing 1/8 | One-bit payload for that grid, bytes |
|---:|---:|---:|---:|
| 1e11 | [357700,357701] | 799200000000 | 99900000000 |
| 1e12 | [3945703,3945704] | 7999200000000 | 999900000000 |
| 3e12 | [12362155,12362156] | 23999200000000 | 2999900000000 |
| 9e12 | [38660607,38660608] | 71999200000000 | 8999900000000 |
| 1e13 | [43123944,43123945] | 79999200000000 | 9999900000000 |

The one-bit payload is only a hypothetical regular sign stream. It excludes unresolved-node tags, repairs, values, proofs, auxiliary nodes and all metadata. Streaming can avoid storing that stream durably. At spacing 1/100 the interval count is 12.5 times larger. Neither spacing is proved sufficient.

Within a sign-bracket certificate, each missing simple zero needs a bracket and completeness evidence. The leading-term rows show the scale that such a protocol should expect, but this is not an information-theoretic lower bound for every possible RH proof. It does not prove that spectral checks cost more than ladder primality checks.

For the literal direct-EM head length ceil(t)+40 on the 1/8 grid, D=H-H0 gives exactly

    8*(D*(H0+40)+D*(D+1)/2)

head contributions. This exceeds 3.59e25 at 3e12 and 3.23e26 at 9e12. These counts do not certify that M=18 or another fixed remainder order works there; they expose the linear-in-height input schedule.

For an independent classical RS main sum at each grid point, summing floor(sqrt(t/(2*pi))) terms gives the following conservative bounds, excluding every correction and special-function operation:

| H | Lower count, using only final half-height | Upper count, using full-grid endpoint length |
|---:|---:|---:|
| 3e12 | 5863224000000000000 | 16583183208800000000 |
| 9e12 | 30466224000000000000 | 86170586538400000000 |

The lower count uses exactly 4H grid points above H/2 and a rational lower bound on their common RS length. It is a bound for this literal per-point algorithm only. Main-sum sharing, FFTs and interpolation are precisely what this comparison favors. Neither EM nor RS here is a lower bound against a batched analytic evaluator.

## 7. Precision, checked arithmetic and repairs

There is no reason to require the old 300-bit zero-isolation precision or the rational pilot's 512/1024-bit allocations for every production sign. There is also no justified universal low precision before sign margins and full tail bounds are known.

A phase t*log(n) needs log error below phase_error/|t|. Thus even before FFT accumulation, log leaves need roughly log2(H) guard bits beyond the desired phase accuracy. The exact metadata gives 42 bits at 3e12 and 44 at 9e12. Constants and sum sensitivity add further bits. Range reduction must be proved with the full integer phase index; a small floating phase residue is not a certificate.

Use scaled mantissas and explicit binary exponents. Gamma decay and exp(pi*t/4) cancel analytically in R, but a fixed absolute dyadic grid applied to the separate tiny Gamma value would be inappropriate. Stable scaled-Gamma/log-Gamma evaluation and its remainder/branch proof are part of the production cost. Large exponents need only logarithmic encoding length; this does not by itself control cancellation or mantissa precision.

For a normalized radix-two stage, the prior roundoff recurrence can price p bits with its actual input magnitude and stage count. The final Fourier scale here is 1/B for the unnormalized positive sum, equivalently A times a normalized inverse transform. It is neither the family's vL scale nor an unexplained unit scale. Gamma-grid, binning, convolution, interpolation and final arithmetic errors all enter the sign radius.

Accept coarse strict signs once. For a few unresolved intervals, try local interpolation with checked tails, then a finer subwindow or a direct rigorously bounded evaluator. Do not globally increase p solely because one interval is difficult. If many outputs fail from the same shared input tail, a local output-only refinement cannot fix them. Keep failed native attempts in generation accounting, while retaining only the successful dependency DAG for checking.

All elementary and Fourier arithmetic must be checked by the selected Lean/MM0 acceptance mechanism. A compact deterministic replay can avoid per-gate serialization but still pays arithmetic. Published interval code, a native successful sign and a file hash are not kernel proofs. The costs of analytic formalization, evaluator construction, witness generation, checker replay, proof emission and I/O must remain separate. No measured ratio between Lean and MM0 follows here.

## 8. Decision supported by this report

The principal-gap route is a serious alternative, but it is not yet a demonstrated cost win. It trades tens to hundreds of billions of ladder rungs for a principal spectral extension whose sign protocol has a leading-term scale of roughly 12 or 39 trillion zeros at the two concrete heights, together with new analytic theorem dependencies. These objects have very different shared arithmetic costs.

The next comparison should use a complete small principal window through coefficient generation, aliases, signs, repairs and a completeness check, against a complete mixed ladder block in the same proof backend. It should not use high-precision zero-isolation output as a requirement, nor price a bare native FFT against a fully checked prime proof. No such experiment is authorized or performed by this report.

The most useful new formal work, if the gap theorem survives audit, is a principal windowed Fourier/checker adapter with positive-window sign semantics, full error scaling and variable-precision interpolation. The reduced nonprincipal certificate design remains shared with the baseline.

## Reproduction and provenance

The scalar script and JSON are named principal_extension_cost_scalars_20261111 in this directory. A first draft kept unnecessarily large rational denominators in the scalar log calculation and was stopped; the retained script rounds the pi enclosure outward before taking logs. A hand-entered butterfly assertion was corrected to the displayed exact sum before the successful run. These were metadata calculations, not function evaluations. No timing is used as evidence.

Local source pins follow. Web references are primary paper/implementation URLs and were inspected read-only. This report does not claim to have independently proved every published remainder theorem.
| File | SHA256 |
|---|---|
| `work/qrh-blueprint/HYBRID_LADDER_COST_FRONTIER_2026-11-11.md` | `AB81BBFF4BA1CC729579A365C4C3D4C4677B78164239A3AC148BE29AFFE290CB` |
| `work/qrh-blueprint/SPECTRAL_BASELINE_COST_COMPARISON_2026-11-11.md` | `0DD28598568EC61FC8B589017680AA9A3AE350608ADA32FD94D9869B9C06B9A5` |
| `work/qrh-blueprint/END_TO_END_EFFICIENCY_MODEL_2026-11-11.md` | `5FAB539A0F4BF7480594F00936021730E80E987D9E01EB787A072DD122BA1D12` |
| `work/qrh-campaign/agents/zero-sum/EFFICIENCY_SPECTRAL_BATCHES_2026-11-11.md` | `6E3C821EEE536FB2E278629A26955C414BF82FCADA60888E86F8A33306C75E41` |
| `work/qrh-campaign/agents/mellin/PRINCIPAL_COMPLETENESS_ROUTE_2026-11-11.md` | `AC1FA5C0308D24C9CB19FEBF6A2C231B42C6E25113E534D4C23FE62E4CE2D92C` |
| `work/qrh-campaign/agents/moebius/PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md` | `0A2F4766FCB77668C5461E8A63B97327EF2E6F595E66F805544A7EFA49A4A028` |
| `work/qrh-campaign/agents/zero-sum/PRODUCTION_SPECTRAL_EVALUATOR_2026-11-11.md` | `8494E089BB937B0595DEC607EEE0D49B4F549134A9371230D3A74A67C74DAF9A` |
| `work/qrh-campaign/agents/zero-sum/principal_extension_cost_scalars_20261111.py` | `8C240A02B74F94A83FF14B41250A21CF68460BF0C97BE1BD312C72F390B48529` |
| `work/qrh-campaign/agents/zero-sum/principal_extension_cost_scalars_20261111.json` | `70E55E2F34A7DD8010C11235C0A53103383D6E322B08F07F0FE36397C3B8268E` |
