# Independent review of global-inverse scaling limits

2026-11-11. **PASS for the stated implementation-level counts and analytic limitations.** No substantive correction is required. Two elementary endpoint qualifications to the displayed conditional rules are recorded below. The note correctly does not turn the tested implementation's costs into lower bounds for optimized inverse-certificate algorithms.

## Pinned inputs and exact checks

Reviewed `../zero-sum/GLOBAL_INVERSE_SCALING_LIMITS_2026-11-11.md`, SHA256 `DDAA08056E5159790D4E7C58BBF7F028538E1C885CF5E8A1E8D0CA0EF4C6C141`.

The independent exact scalar program is `review_global_inverse_scaling_20261111.py`, SHA256 `504410F450A4D4260D553987A4234E1C2FA29D08DD18C96EE738345689717DB3`. Its receipt has SHA256 `F4273318544BD32E766BD45E596B0D9F5D2E0F4475CF2F110E9976366EFDAB8F`.

The program checks the frozen prototype and workload-document hashes, reproduces both selected-height rows and the pilot specialization, and recomputes the family coefficient-slot and illustrative byte totals from the previously accepted sums. It performs no family enumeration, L evaluation, fit, contour calculation or build. The original workload sums are reused as pinned evidence, not silently recertified by this scalar check.

I also read the exact source `TernaryGoldbach/Explicit/LGrowth.lean:179`, including its namespace and ambient assumptions. The declaration is `TernaryGoldbach.Explicit.norm_LFunction_le`, for a Dirichlet character at a nonzero natural modulus, with hypotheses chi != 1 and 0 < Re(s). Its conclusion is exactly `||L(s,chi)|| <= (q+1)||s||/Re(s)`. There is no primitivity requirement in that signature. Every active primitive character at c>1 is nonprincipal, so the note may use the theorem. This is source-signature review, not a newly compiled axiom audit.

## Literal count formulas

For integer T, the specified inclusive pole grid j=-16T,...,16T contains P=32T+1 poles. Including the constant coefficient gives P+1=32T+2 complex coefficient slots per character.

The training grid has32T samples on each vertical side and24 on each horizontal side, totaling64T+48. Its validation grid has twice the density and totals128T+96. The dense training matrix therefore has `(64T+48)(32T+2)` complex entries. Its right-hand side has `(64T+48)n` entries and the fitted output has `(32T+2)n`. These are literal allocated-array dimensions; the statement about full column rank requiring at least P+1 independent rows is correct and does not establish conditioning.

The complete contour mesh has64T panels on each vertical side and47 on each horizontal side, hence J=128T+94. The rational jet loop performs n(d+1)PJ coefficient products. This exactly reproduces the pilot values P385, J1630, training816, validation1632, and24,474,450 coefficient products at n3,d12. With fixed n,d and fixed spacings, the dense matrix dimension and this accumulated jet work grow quadratically in T. No claim about the cost of every possible rational evaluator follows.

For the selected reference heights, exact evaluation gives:

| c | Hp(c) | Hcert(c) | T0=floor(Hcert)+1 |
| --- | ---: | ---: | ---: |
|4|30,171,629|25,000,000|25,000,001|
|5|12,068,772|12,068,772|12,068,773|

The modulus parity in qt(c) is correct. Both large table rows reproduce exactly, including their dense matrix-entry and rational-jet product totals. T0 is a workload reference strictly above Hcert, not a zero-free height obtained merely by taking a floor.

From the accepted sums, the coefficient-slot total is exactly

`32*5392479925954 + 2*5543640187 = 172570444910902`.

Sixteen bytes per slot gives exactly2,761,127,118,574,432 bytes. The note appropriately labels that as an illustrative floating-center encoding. It is neither a rigorous-rational storage specification nor a lower bound against compression. This is an aggregate coefficient-data total, not a requirement to hold every conductor's data in RAM simultaneously. Streaming conductors or regenerating data can change peak memory without changing this literal aggregate count.

## Missing inverse-norm and slack bounds

The actual certificate requires a global holomorphic candidate with residual strictly below1 on the full closed boundary. The weak target beta<=111/200 permits a zero on that very boundary, in which case such a candidate cannot pass. Even strict zero exclusion gives only existence of a positive minimum for a fixed finite compact family; it does not provide a useful numerical minimum or a uniform precision/complexity estimate.

The elementary example f_epsilon(s)=s-(111/200-epsilon) correctly demonstrates the missing information. At the boundary point a=111/200, a residual bound |1-f_epsilon B|<=eta<1 implies |B(a)|>=(1-eta)/epsilon. For poles on Re=1/2, triangle inequality gives |B(a)|<=|b0|+(200/11)sum|w|. Thus a coefficient norm must become unbounded as epsilon tends to zero if the residual slack is fixed.

The symmetry remark is also valid. For sufficiently small positive epsilon, the polynomial

`(s-(a-epsilon))*(s-(1-a+epsilon))`

is invariant under s -> 1-s, has both zeros strictly to the left of a, has bounded growth on a fixed rectangle, and takes the value `epsilon*(11/100-epsilon)` at a. Its inverse magnitude has the same obstruction. Neither example is asserted to be a Dirichlet L-function; they show what zero exclusion plus upper growth alone fails to imply. They do not rule out stronger estimates using additional arithmetic structure.

A fixed finite simple-pole space has no approximation guarantee merely because the pilot fit succeeded. Higher arithmetic precision does not change that approximation space. Pole refinement, changed basis, repeated poles, different domains, or structured fitting would need their own approximation and numerical analyses. The distinction between candidate norm, matrix conditioning, and approximation slack is correct.

## Conditional Taylor, derivative and precision rules

Let Delta=11/200. The bounds

`|B| <= |b0|+W/Delta`, `|B'| <= W/Delta^2`,

and

`TaylorTail_d <= W*(rho/Delta)^(d+1)/(Delta-rho)`

follow directly from the simple-fraction representation for0<=rho<Delta. They are sufficient estimates, not optimal-degree statements. The displayed rule obtained by dividing by W needs **W>0**. If W=0, the candidate is constant and its rational Taylor tail is zero, so this division should simply be bypassed. This harmless endpoint case is the first qualification to the frozen text.

The source-backed growth budget M is valid. Every point in the radius1/4 neighborhood of the rectangle has Re(s)>=61/200 and |s|<=T+5/2<T+3 for T>=0. The exact source theorem gives the stated M, and Cauchy's derivative estimate at radius1/4 gives |L'|<=4M on the rectangle. The product rule then gives `|r'|<=4M beta0+M beta1`. This supports a conditional panel-size rule with separate allowances for variation and numerical error. It does not establish the unknown W or positive slack mu.

The residual error formula includes the cross term and correctly explains why large inverse values require smaller absolute L errors. If each candidate coefficient has absolute error at most2^(-p), the proposed bound `(P+1)max(1,Delta^(-1))2^(-p)` is valid. Here p describes an **absolute-error target**; it is not automatically a machine mantissa-bit count when coefficient magnitudes vary. The relative-error version depends on |b0|+W/Delta, as stated.

For n primitive channels, Parseval and Cauchy–Schwarz give a group l1 bound sqrt(n)*eta from the uniform scalar bound eta. The moment bound n*eta^(2k) is also correct. The logarithmic rule for k needs **0<eta<1**; eta=0 is already the exact-zero-residual case and needs no logarithm. This is the second harmless endpoint qualification. At eta>=1 the displayed rule cannot supply a strict moment bound below1.

## Fixed-M evaluator growth

With M20, Re(s)>=sigma0>0, |s|<=T+3, and shifted endpoints at least N>0, the40 rising factors are each at mostT+42. Summing the EM error over v unit residues and multiplying by c^(-sigma0) yields exactly the displayed sufficient bound

`4v c^(-sigma0)(T+42)^40 / [6^40(sigma0+39)N^(sigma0+39)]`.

The exponent on N and the resulting40/(sigma0+39) growth exponent are correct. The bound cannot stay small with N64,M20 and unbounded T. This does not prove that the actual remainder has that magnitude or impose a lower bound on every evaluator. Increasing M, using a different tail estimate, or changing evaluator are distinct choices requiring analysis. The finite exprel truncation also loses a uniform justification when its argument grows, as the note explains.

The suggested Gaussian/shared evaluators address the L-evaluation term, not automatically the global pole dictionary or repeated rational accumulation. Conversely a structured rational evaluator does not itself prove a high-height L enclosure. The note keeps these costs separate.

## Verdict and limits

The conclusion is appropriately restricted: the literal dense global prototype has enormous explicit costs at the selected heights, while the general inverse-certificate approach has not been proved impossible or costly by those counts. Missing quantitative control of W, residual slack, fitting stability, and evaluator precision prevents a justified end-to-end production estimate.

The closing suggestion of separate bounded-height inverse domains is a different architecture, not a result supplied by this note. Its assembly, seam conditions and local complexity require separate work; this review does not duplicate that task. No runtime extrapolation, full-family certificate, new spectral assertion, or Lean implementation is accepted here. Author-frozen files were not changed.
