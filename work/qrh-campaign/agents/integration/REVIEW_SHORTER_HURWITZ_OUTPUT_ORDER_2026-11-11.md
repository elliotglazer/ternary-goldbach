# Independent review: shorter Hurwitz output orders

2026-11-11. **PASS at the stated conditional paper and exact-metadata scope.** No mathematical correction is required to `prime-estimates/SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md`, SHA256 `0EAED4F960DFC4F590564A9B8A86E9C22BB621FCE362CCAB7A13D2D3976A1D2A`. This accepts the new isolated alpha error contract below `2^-82`, not the earlier achieved final-band fraction `.16*2^-82`, a complete numerical sign chain, or a cost saving.

I read the frozen report and its scalar script, reconstructed the analytic inequalities, and independently checked its receipt without importing or executing the author script. My checker uses integer kth roots after clearing strict rational inequalities, rather than the author's binary search on height indices. No function, coefficient, prime, zero, transform or Mellin values were evaluated. No build, declaration or frozen-source change occurred.

## 1. Actual Taylor target and source normalization

The retained source is the continued function `f(alpha)=zeta(s,1+alpha)`, `s=1/2+it`; its coefficients are `(-1)^k(s)_k zeta(s+k,1+b)/k!`. The reduced Platt report, lines19–41, obtains this derivative identity by continuation and applies real-parameter Taylor's theorem. It does not differentiate the critical-line Dirichlet series termwise.

For `2<=K<=20`, the Kth derivative has real part `K+1/2>1`. On every actual real segment, the shifted base is at least1, so its zeta factor is bounded by `1+1/(K-1/2)<2`. The rising factors are bounded by `(|t|+K)^K`. Taylor's integral remainder therefore gives

    |R_K| < 2 (|t|+K)^K |alpha-b|^K / K!.

The selected fine mesh has denominator `2D_out`; exact nearest-anchor geometry gives `|alpha-b|<=1/(4D_out)`, including ties and clipped endpoint cells. The final band's output normalization is8192, although its source normalization is4096. The unit-character sum followed by `c^-s` has error amplification at most `phi(c)/sqrt(c)<633`. Thus the proposed bound

    T_K(t,D_out)=1266*((|t|+K)/(4D_out))^K/K!

is valid. The finite head, conductor phase, positive transform convention and inverse normalized-transform scale remain separate. Both signs of t and t=0 are covered. This is a real-alpha, point-height statement, not a complex-panel bound. Restricted minimality is only among K=2,...,20 using this sufficient envelope.

## 2. Prefix projection does not delete the source error

The differentiated source-shift remainder at order k is bounded by `M_P |b-a|^(P-k)/(k!(P-k)!)`, where `M_P=2(|t|+P)^P`. Multiplying by target displacement to power k and summing over k<K only decreases a sum of nonnegative terms. The full binomial bound at `|b-a|+|alpha-b|` is consequently still valid.

For the first four bands this retains P27, combined displacement `3/(4D)`, and

    S_first=1266*(15/16)^27/27!,
    N_first=2532*2^-100+633*330*2^-110+1688*2^-100.

For the final band it retains P28, actual source shifts0,1/4,1/2,-1/4, the `2^-k` output scale, and target displacement at most1/8 in source coordinates. Hence

    S_final=1266*(5*7028/(8*4096))^28/28!,
    N_final=(844+1688)*2^-100.

The source and numerical constants agree with the scaled-seed sections5–6 and joint-quarter-mesh section3. All real segments remain inside[0,1]. The m159 successor changes neither this output normalization nor these error interfaces.

The numerical prefix projection is also justified: the first-four positive evaluation weights obey `sum_(k<K)4^-k binom(j,k)2^(-(j-k)) <=(3/4)^j`. The final output's numerical eta radius already contains its shift arithmetic. It must not be charged again as350 fresh errors. Analytic shift bias is still separate from that numerical coefficient radius. Higher source coefficients still contribute to lower translated coefficients: the source P27/P28 arrays and complete330/350-update shifts are retained, as is existing20-slot delivery.

Ordinary shorter Horner has K-1 rounded products and K-1 rounded additions, giving error below `2u_H sum_(j=0)^(K-2)4^-j<8u_H/3`; multiplying by633 gives1688u_H. There is no extra first multiplication of the highest coefficient. A prefix of an already proved product-only profile retains its positive weighted error bound, but its stage encodings and cost must be instantiated again.

## 3. Independent exact thresholds and endpoint coverage

Write the remaining allowance as `R=2^-82-S-N=a/b>0`. On `t_j=5j/64`, strict admission is equivalent to

    1266*b*(5j+64K)^K < a*(256D)^K*K!.

I compute `C=floor((a*(256D)^K*K!-1)/(1266*b))`, take its exact integer Kth root z, and obtain the largest index `floor((z-64K)/5)`, clipped to the tested domain. Integer endpoint inequalities prove each root. This independently reproduces all95 author thresholds, their exact last/next ratios, all95 band-top tests and all23 selected ranges. For every range, all smaller K fail at its left endpoint and its selected K passes at the right endpoint; monotonicity in nonnegative t fills the interval.

The band-top minimum lengths are **19,19,19,20,19**. They mean degrees18,18,18,19,18. All five displayed outward rational upper ratios agree with the exact fractions.

I separately reconstructed the maximum main height from the combined profile. Both formulas decrease with conductor, so it suffices to use the minimal odd conductor10001 and minimal four-divisible conductor10004, without a conductor scan. Their maximum is6578 at10004. The second ceiling gives last grid index84199. The four extensions give:

|Extra nodes|Global nodes|Last height|
|---:|---:|---:|
|0|84200|420995/64|
|167|84367|210915/32|
|320|84520|422595/64|
|640|84840|424195/64|

The final band starts at index64001. It uses K17 through68945 and K18 from68946 through84839 in the largest scenario. K18 remains admitted through89533; the declared band cap7000 is index89600 and requires K19. The actual selected endpoints therefore do not inherit the looser band-top K19 unnecessarily. Each conductor clips the common selector to its own prefix. No extension is asserted to guarantee a successful Turing closure. Off-grid heights require direct admission or an admitted upper grid endpoint.

## 4. What the wider alpha radius does and does not preserve

The original reduced Platt allocation is explicitly `E_alpha<2^-82` at lines55–59, with other errors separate. The selected P27 decision likewise says that its consumer requests this exported radius rather than the producer's tighter fraction. The quarter-mesh source equation(5), lines78–80, proves the same allocation and separately records the achieved fraction below.16. The joint and m159 packets preserve that stronger achieved bound for their original P20 evaluation. The new K19 envelope at V7000 is greater than.16 of the budget, although below1; it is not legitimate to retain the old fractional conclusion.

I searched campaign/blueprint Markdown and arithmetic scripts for the `.16*2^-82`, `4/25`, and alpha-budget uses and inspected the selected downstream interfaces. There are genuine preservation claims using.16 in the joint/m159 reports, the coefficient-grid clarification, the b100 Horner report and their scalar checks, and coordinator decisions. They remain true for their frozen P20 circuits. They are not automatic theorems about this shortened polynomial. The new packet supersedes their alpha conclusion only where the caller explicitly adopts the weaker `2^-82` interface; it does not mutate those reports or their existing receipts.

The actual downstream route inspected is:

1. Reduced Platt lines55–59 attach alpha and numerical input radii to the actual `L(1/2+it,chi)` identity, finite head, conductor factor and transform normalization. Its section6 propagates actual coarse Y sample radii through the interpolation weights, adds kernel/arithmetic/tail errors, and forbids substituting a sign proxy as interpolation data.
2. The fixed three-product transform report sections1–3 keeps the input-error parameter E0, true-input magnitude B and root/gate errors explicit. A new source center/radius must be bound to those inputs; an old serialized input box is not automatically reused. Conservative positive coefficient-magnitude bounds can be re-established for a prefix, without claiming equality of old and new centers.
3. `R132900_POST_TRANSFORM_CERTIFICATE_COST`, lines13 and21–27, requires complete source enclosures and accepts a sign only when its real enclosure lies strictly on one side of zero. The selected-sign supplement sections1 and3 requires the same function/phase and propagates the actual sample errors. Turing lower counts consume those proved signs and exact interval endpoints, not an alpha-error decimal.

No inspected sign or count acceptance formula allocates the old .16 slack to another error term. This is a source-level interface compatibility result, **not a certified complete selected sign chain**. The current packets do not supply numerical coarse/interpolation sign margins or a successful complete output certificate. With the shortened polynomial, all complete radii and strict sign tests must be recomputed; failed tests may require the old order, more source accuracy or another repair. Existing successful signs, interpolation precision choices, repair counts or closure inequalities are not preserved merely because the allocation `2^-82` remains true. The absence of a known .16-dependent sign consumer is not evidence of unchanged successful outputs.

## 5. Degree, cost and formalization boundaries

This changes the output polynomial degree to K-1. It is distinct from the all-cell finite-difference theorem's state-order truncation `m=min(20,L)`, which still evaluates a degree19 polynomial exactly. Its old aggregate initialization, advance, width and cache counts cannot be reinterpreted as the costs of this new output polynomial. Likewise19 Horner stages cannot simply remain the price of a K-term circuit.

The proposal deliberately retains source generation, existing full finite translations and20 delivered slots. Any later prefix source-production or degree-dependent circuit saving needs its own proof and ledger. No such saving, final runtime, analytic library implementation or kernel-validity claim is approved here.

## 6. Frozen independent evidence

Independent script: `integration/check_shorter_hurwitz_output_review_20261111.py`, SHA256 `15120574CF4C4E59E1804F1D2B7F8580CDF9D19C4F5919CDCF48E555949489DF`.

Independent receipt: `integration/shorter_hurwitz_output_review_20261111.json`, SHA256 `33B3A684718D181D3C19A7B114419EA61BC41A47D74E511C5643D30DF2393523`.

All2629 checks pass. They cover the author's three frozen files and seven prerequisite pins,95 integer-root thresholds, every exact endpoint ratio, the23 ranges, four complete scenario clips, positive prefix error inequalities and the stricter-versus-weaker final budget distinction. The receipt additionally pins the combined-height source and the downstream reports read for section4:20 artifacts in total. Its complete path/hash map is part of this review's evidence. Author script `11230A0B...` and receipt `4385975F...` were read, not run. The first independent draft's integer-root helper required an explicit zero-input branch; that review-script issue was repaired before the successful receipt was written and did not change any author threshold.
