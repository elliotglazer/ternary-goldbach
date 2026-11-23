# Compute-first choice of finite spectral proof

2026-11-11. Research advice, not an independent review of the coordinator's work. No Lean/Lake command, spectral evaluation, production scan, source edit or change to a frozen artifact was made for this report. The comparisons below concern future constructions, except where a published computation or completed campaign artifact is explicitly identified.

The best-supported next investment is a shared, proof-producing batched arithmetic implementation and a controlled comparison against the original critical-line/Turing method. Removing the name `PlattGRH` is not itself a computational improvement. Keep the QRH route available, but do not commit to its larger analytic formalization merely because its finite assertion is weaker. Analytic elimination of the family has the largest potential reduction and the least established feasibility.

## Exact targets and present evidence

The current source `TernaryGoldbach/Statement.lean:59` defines `PlattGRH` for primitive characters, odd conductors through 300000 to height `1e8/q`, and even conductors through 400000 to height `max(1e8/q,200+7.5e7/q)`. The conclusion is exact critical-line membership for zeros with real part strictly between zero and one, including the stated height boundary. A proof of this proposition can discharge the current `Fact` without changing its consumers. If a smaller finite domain suffices for the actual consumers, that is a separately justified statement reduction, not something to assume when comparing costs.

The selected QRH alternative has 150000 conductor indices and 5,543,640,188 primitive-character labels, including the principal row. It retains genuine global QRH and finite strips at the following heights. Put `qt=2c` for odd conductors and `qt=c` otherwise, and

    Hold(c)=min(ceil(200+max(1000,844800000/(7*qt))),100000000/c).

The active conductors are odd `c<=150000` or four-divisible `c<=300000`. For `c<=100000`, the finite upper real-part bound is `.555` through `Hold(c)`. For larger odd conductors it is `.56` through `50000000/c`; for larger four-divisible conductors it is `.56` through `99000000/c`. Reflection supplies the corresponding lower bound with actual multiplicities and inverse-character bookkeeping.

The principal row still requires the shared strip through 60343058 and the selected RH head through 1500, its count 1069 and reciprocal-moment bound. The extra narrow principal strip through one million was removed from the selected analysis. This is a genuine dependency reduction; it does not supply the remaining finite data.

The reviewed metadata gives `Vnew/Vold` between `.846079629950` and `.846079629951`, where `V=sum_c a(c)H(c)`. This is a 15.392037% reduction relative to the preceding QRH strip profile, not relative to original Platt verification. It is neither a runtime ratio nor a zero count. All character labels remain. The literal finite-U formula at one top center still has 7,467,072,337,142 shared residue-head terms before jet orders and corrections. That is the cost of one specified formula, not a lower bound for efficient algorithms.

The most relevant published baseline is Platt's 2013 manuscript. It reports approximately 400000 core-hours, 29,565,923,837 primitive-character functions and about `3.8e13` isolated zeros, excluding Turing auxiliary zeros. Its conductor/height domain is broader than the current selected family. Its algorithms combine character transforms, shared Hurwitz tables, Fourier evaluation and interpolation; Lemma 4.1 transforms a supplied residue table in `O(phi(q) log q)` work and `O(phi(q))` space. After successive upsampling, about `.0003%` of functions needed further treatment. These historical timings are not timings of formal checking or predictions for current hardware. [Platt, §§4–7, arXiv v1](https://arxiv.org/pdf/1305.3087).

The official FLINT documentation also describes batched principal-zeta evaluation and sign/Turing isolation. This supports using batched algorithms as the baseline rather than multiplying the cost of independent Euler–Maclaurin calls. It does not provide a formally checked full Dirichlet-family implementation. [FLINT algorithm documentation](https://flintlib.org/doc/algorithms/special-functions/zeta-zeros.html).

## Comparison under equal trust requirements

| Route | Generation and stored certificates | Standard-axioms checking and engineering | Mathematical uncertainty |
|---|---|---|---|
| A. Prove the original finite critical-line assertion | Generate enough certified signs/intervals and total counts to establish completeness, with explicit handling of central zeros, difficult clusters and closed height endpoints. Share character and height transforms. Raw samples and all discovery history need not be retained. | Prove the numerical evaluator, error bounds, phase normalization, Turing/count identity, character enumeration and block assembly. Native interval success alone is insufficient. Existing source consumers require fewer mathematical changes. | The finite result and scalable computational methods are published. Formalization and proof-checking costs remain unmeasured. Simple sign saturation may require fallback near close or multiple zeros. |
| B. Global QRH plus selected finite strips | A strip certificate can allow clusters without isolating every critical-line zero. Whole boundaries may avoid interior crossbars. However complex evaluation, contour winding, small boundary margins, pole cancellation and auxiliary heights may offset the smaller domain. No full selected-family production implementation has established the cost. | Needs a sound finite evaluator/completeness checker as in A, plus the global QRH source chain and changed Goldbach analytic consumers. Recent bounded source audits do not establish a compiled, closed global provider or its transitive axioms. | Finite strips are weaker and may admit easier certificates, but the net gain is unproved. Both global analysis and complete finite data remain required. |
| C. Eliminate or aggregate the finite family | A successful weighted analytic theorem could remove most generated data. A conductor-product certificate could replace per-character zero identities by aggregate counts. Neither description alone reduces the work of evaluating the relevant functions. | Must prove an explicit bound for the actual major/mixed/pointwise consumers, including tails and exceptions. A product checker needs continuation, nonvanishing/count semantics and true multiplicity. It may still share the same arithmetic infrastructure. | Highest uncertainty. Available tested density bounds do not close the current weighted budget. No complete analytic replacement or efficient product evaluator has been produced. |

These choices are not exclusive. A critical-line certificate proves a stronger finite fact and can discharge B's strip input on the covered domain. B's consumer analysis can reduce the domain submitted to an A-style evaluator. Conversely, difficult critical-line clusters can be handled by a strip/argument-principle fallback when the final target requires only a strip. The algorithm should follow the cheapest sufficient certificate, with its implication to the exact final theorem proved explicitly.

Turing auxiliary heights must be included in any cost comparison. The reviewed finite-U specialization assumes `c*T<=1e8`. It cannot automatically be applied at `T+h`. At the selected even endpoint `c=300000`, the nominal auxiliary headroom is only `10/3`; some unchanged conductors have none. General-height evaluators are possible, but their work must be counted. Likewise, positive-height sharing requires the correct character/conjugation identities rather than dropping half the zeros informally.

## What aggregate replacement currently buys

The existing conductor-product proposal uses `F_c=product_(primitive chi mod c) L(s,chi)`. Counting its zeros with multiplicity can suffice for some weighted family bounds without assigning each zero to a character. Reducing the number of named objects to conductor products does not reduce their total analytic degree. Naively evaluating each product still evaluates its factors. The divisor-sum expression for its logarithmic derivative in `Re(s)>1` is useful, but an efficient rigorous continuation to the needed rectangles remains open.

The earlier weighted-excess target `K<=6` is a sufficient replacement for a particular older high-conductor profile, not a proved estimate or an automatically valid substitution into today's profile. Its exact finite Stieltjes identity turns a cumulative zero-density bound into a checkable numerical requirement. The tested comparison expressions exceed the target by enormous factors. For example, Thorner–Zaman Corollary 6.1 gives `10^88(10^421 Q^127)^(1-s)`, exceeding `10^220` throughout the relevant interval at `Q=300000`. Ramaré's stated range requires `T>=Q`, so a global application has `T=300000`; its positive additive term alone exceeds `3.7e15`. These are failures of those upper bounds, not lower bounds on actual zeros. [Thorner–Zaman, v4, Corollary 6.1](https://arxiv.org/pdf/2208.11123v4); [Ramaré, Theorem 1.1](https://ramare-olivier.github.io/Maths/DensityEstimate-34.pdf).

Some published density proofs also use finite verifications. Such inputs must be exposed before calling the replacement computation-free. A useful new theorem would exploit the short hyperbolic conductor-height region and the actual smoothing weights, rather than an oversized enclosing rectangle. It must retain exceptional zeros. An aggregate major-arc second moment does not by itself prove the mixed fourth-moment requirement or the pointwise base-gap estimate.

## Proof size is a separate optimization problem

Account separately for generation work, stored certificate bytes, logical verification work, peak memory and formal engineering. For a fixed arithmetic DAG, a useful symbolic model is

    generation = discovery + certified evaluations + certificate construction;
    checking = sum over checked nodes of arithmetic cost at that node's bit size;
    storage = shared constants + retained witnesses + block manifests.

None is determined by the number of zeros alone. A small reflective proof term can require expensive kernel reduction. A compressed stream can avoid writing expanded proof steps without eliminating checking work. Shared constants, elementary enclosures, transform stages and block theorems should be checked once through an explicit dependency structure. Do not assume global kernel memoization or that hashes prove arithmetic. Sharding needs exact statements and coverage manifests; accepting every shard must imply the original conductor/height theorem without a giant list of independent declarations retained in memory.

The completed small EM batch illustrates the distinction. Its saved batch receipt is much larger than the consumed finite-g coefficients and images. Proving those final enclosures directly can omit certification of the discovery FFT, but then proves the actual-image theorem, not correctness of the saved batch internals. Direct checking may lose the asymptotic advantage of batching. An efficient production checker should instead be able to certify the batched computation through a proved transform theorem, without recomputing every transform by a quadratic direct sum.

Dyadic rounding gates and shared factorial/Bernoulli denominators avoid treating every summand as an unrelated rational denominator. The accepted inner-rounding proposal bounds specified pre-gate denominators below 2100 bits; it is not a bound on all numerators, cross-products, proof terms or runtime. No Lean/MM0 ratio follows. A verified specialized arithmetic checker is a separate implementation and soundness task, even if it preserves the same axioms.

## Three bounded questions with decisive tests

1. **Which certificate shape is cheaper for the exact target?** Specify complete blocks covering principal, small real/nonreal, noncyclic unit-group, high odd and high four-divisible cases. Include difficult clusters, zero height, a closed top boundary and all auxiliary-height work. Compare batched A-style signs/counts with B-style strip boundaries using the same certified arithmetic and hardware. Require complete certificates and measured generation, checked bit operations, bytes and memory, not isolated point timing. A route passes this feasibility test only if every selected block closes its exact theorem within a declared resource budget, including fallbacks. Any family-wide extrapolation must state its coverage and unresolved worst cases. No such experiment is authorized or performed here.

2. **Can formal checking preserve the batching advantage?** Complete the smallest source-bound j7 actual-g/panel certificate as a correctness preflight, then one whole batched block with shared elementary witnesses and a checked transform. Require standard-axioms acceptance of the exact outputs and reject altered indices, scales, rounding witnesses and endpoints. Count unique operations and maximum bit sizes. If the only workable checker independently recomputes all direct sums, do not claim FFT verification savings. The j7 slice alone is not evidence that full-family costs are acceptable; retain the full small-batch target of 128 coefficients and 17 images before scaling. This investment benefits both A and B.

3. **Can a consumer-weighted theorem actually remove conductors?** Freeze a proposed subset to omit and derive its full contribution to the current major, mixed fourth-moment and pointwise budgets, uniformly in the unbounded x range. Re-derive any older `K<=6` criterion before using it with the current profile. The go/no-go calculation is the exact resulting budget including low conductors, exceptions and tails; a density bound that exceeds it is rejected before implementation. A conductor-product alternative must also demonstrate a rigorously bounded evaluation construction whose work improves on factorwise evaluation; merely reducing the count of named products is not a pass. Failure of these tests favors A/B, not another unsupported aggregate claim.

Prioritize questions 1 and 2 for near-term feasibility, with a bounded parallel mathematical investigation of question 3. Further foundational QRH audits should follow an identified proof dependency or a demonstrated computational benefit, rather than substitute for this comparison.

All three spectral routes leave the finite Goldbach reduction to be accounted for. The present source separately assumes `BinaryGoldbachInput` through `4e18`. If the final objective permits that input, keep it explicit. If the objective is the full theorem from standard axioms alone, its certificate and checking cost are an additional shared obligation; no spectral choice removes it automatically.

## Source snapshot

Paths below are relative to the workspace. These files were read and SHA256 checked; they remain unchanged. The source snapshot bounds this advice and does not assert that all dependencies of these reports were independently re-audited here.

| File | SHA256 |
|---|---|
| `work/ternary-goldbach/TernaryGoldbach/Statement.lean` | `3F61837D2C3A0DDE3A1997F05AF21C20C7FE6EE13E29891125495F6947596BF8` |
| `work/qrh-blueprint/SELECTED_HIGH_CONDUCTOR_PROFILE_2026-11-11.md` | `D0F77CCCFCE45DBFE5C863643236107ECBBE4D363103A70BB06CE57213A42CB7` |
| `work/qrh-blueprint/SELECTED_PRINCIPAL_ROUTE_2026-11-11.md` | `F5276E1C93B959BFC4D86A58BEFAA4666E320454CDC9B2CC2804EEEBE354FEBB` |
| `work/qrh-campaign/agents/prime-estimates/SELECTED_PROFILE_PRODUCTION_FRONTIER_2026-11-11.md` | `E633476F456ECF58135F944EC07AEDC50AB6B20058148AD1A018FD1AD69D2A46` |
| `work/qrh-campaign/agents/major-constants/WEIGHTED_EXCESS_DENSITY_FEASIBILITY_2026-11-11.md` | `37505FDC4F83F99727FE636654E4803E3EB1EBF7C1B35FBF4E8C627097A72C90` |
| `work/qrh-campaign/agents/zero-sum/RESUME_WEIGHTED_CERTIFICATE_2026-11-11.md` | `A3AB3E32FE0353385DF100BB07AF406DB2D0CEE3DA097258005E6E8914CF8377` |
| `work/qrh-campaign/agents/independent-feasibility/FINITE_EM_RATIONAL_PROOF_COST_DESIGN_2026-11-11.md` | `19DB61735647D0267954692733C2CF045B977D540A4CF55B5DBDB1145EE82CB8` |

The current checkpoint was consulted for status. No full-family certificate, end-to-end formal cost measurement or global-provider validation is inferred from its accepted bounded audits.
