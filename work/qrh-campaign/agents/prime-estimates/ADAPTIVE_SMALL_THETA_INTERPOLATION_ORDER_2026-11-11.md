# Smaller admitted interpolation stencils for the selected tilts

2026-11-11. Exact rational kernels and scalar/conductor metadata only. No analytic function values, transforms, spectral data, prime candidates or builds were produced. Frozen predecessors are unchanged.

The selected small-conductor schedule admits centered interpolation stencils with 182--260 samples instead of 340. The order is selected separately for each integer tilt and odd/even conductor cohort. All seven exact Lebesgue norms are below four at every selected order. Therefore the previously accepted sample and total-error budgets remain valid. In the main full-range independent-stencil schedule, real weighted terms decrease from 4,225,483,877,741,420 to 2,439,308,097,734,074. This is a schedule comparison, not an estimate of elapsed time or a claim that every such query is needed.

The tradeoff is additional shared kernel setup: 61,880 exact rational weights across 40 orders, compared with 2,380 at the single order 340. No successful signs, complete zero counts or runtime optimum follow from the smaller stencils.

## 1. Exact object and retained domain

Retain the corrected minimal-theta schedule, including its rounded bucket operations. It has 7,499 active nonprincipal conductors c<=10,000, 18,477,108 primitive labels, four closed-grid scenarios e in {0,167,320,640}, and a separately admitted integer tilt theta in [64,128] for every conductor/scenario. The extensions e remain planning scenarios, not assertions of successful Turing closure.

Here “odd/even cohort” refers to the conductor c, not to the character parity. Both character parities at a given conductor use the same order, but retain their own coefficient arrays and fixed root phases. The principal conductor is not included.

For each row, Delta=5/64, tau=2^-80, V=m_grid*Delta, period P=N*Delta, omega=2pi/P, and

`J=ceil(25N/192)`, `epsilon=tau/(4*3^theta)`.

Use the actual stored coefficient centers A_j of that row and the exact real finite polynomial

`T(t)=omega*(A_0+2 Re sum_(j=1)^J A_j exp(i*j*omega*t))`.

A_0 is real and the negative coefficients are exact conjugates. The samples being interpolated must enclose this T, with these centers and this omega. Enclosures of F_b or Y cannot be relabeled as samples of T. Changing theta generally changes A_j; equal FFT lengths do not permit reuse of another tilt's values.

The accepted interpolation applicability argument gives

`|F_b(t)-T(t)|<3epsilon/4`, for all real t in [0,V],

where b=pi/4-theta/V. This bound includes the rounded buckets, coefficient arithmetic, omitted frequencies and time periodization. It is used once at the target, not at every stencil point.

Put Wbar=40,000,000/theta for odd c and 80,000,000/theta for even c, B=2Wbar^2+1 and M=44B. The same source argument gives |A_j|<=B and, for every integer r>=0 and every real t,

`|T^(r)(t)| <= M*Omega^r`, where `Omega=J*omega`.

This derivative estimate is global for the finite polynomial even though its approximation to F_b is used only on [0,V].

## 2. A tighter uniform bandwidth bound

The exact selected-length reconstruction verifies N>=2^18 for all 29,996 rows. Because ceil(x)<x+1,

`Omega*Delta/2 = pi*J/N < (22/7)*(25/192+1/N)`

`<= q_star := (22/7)*(25/192+2^-18) = 160919/393216`.

Thus q_star<605/1344<1/2. This uses only pi<22/7 and the actual frequency-index formula. It does not approximate a computed frequency or assume the original coarse Omega bound is sharp. A per-row N-dependent bound could be smaller still; this proposal deliberately uses one uniform q_star, so its order table depends only on theta and conductor cohort.

For each of the 130 such pairs, choose the smallest positive even integer r=2m satisfying

`M*q_star^r < epsilon/16`.                                      (1)

The exact checker verifies (1) and failure at r-2. Since 0<q_star<1, this proves minimality among positive even orders for this sufficient bound. It does not prove optimal interpolation order for the actual function or for a sharper remainder theorem.

| theta | Odd-conductor order | Even-conductor order | Orders using old q=605/1344, odd/even |
|---:|---:|---:|---:|
|64|182|182|202 / 204|
|80|200|202|224 / 226|
|96|220|222|246 / 248|
|112|240|240|268 / 270|
|128|258|260|290 / 290|

The final column is a scalar remainder-only comparison. The adopted stencils and kernel-norm checks in this packet use q_star and orders 182--260. The receipt contains all 130 rows, including M, epsilon, the chosen order and its exact remainder/epsilon ratio.

## 3. Interpolation proof and every required kernel

For t=(k+xi)Delta, 0<=xi<=1, use the r=2m nodes (k+j)Delta with j=-m+1,...,m. The real Lagrange remainder is bounded by

`M*(Omega*Delta)^(2m)/(2m)! * product_j |xi-j|`.

As in the accepted fixed-order proof, with u=xi(1-xi) in [0,1/4], the product is

`u*product_(j=1)^(m-1)(j*(j+1)+u)`

`<= [(2m)!/(4^m*m!)]^2`.

Each factor is increasing in u. Dividing by (2m)! and using binomial(2m,m)<=4^m proves a remainder at most M*(Omega*Delta/2)^(2m), hence strictly below epsilon/16 by (1). This holds at the endpoints as well as inside each grid cell.

For xi=ell/8, ell=1,...,7, the exact weight is

`l_j(xi)= product_(h=-m+1)^m (xi-h) / [(xi-j)*(-1)^(m-j)*(j+m-1)!*(m-j)!]`.

None of these seven xi is an integer, so the displayed denominator is nonzero. The formula is the ordinary Lagrange basis; it proves the interpolation identity generally. Constant, linear and quadratic reproduction in the script are additional consistency checks, not a substitute for that identity.

Every even r from 182 through 260 is used by the selected family. The script constructs the exact weights at all 40 orders and all seven offsets, sums their absolute values as rationals, and verifies each norm is strictly below four. No monotonicity in order is assumed. Maximum upward thousandth bounds over the complete finite set are:

| Offset | Lebesgue norm upper bound |
|---|---:|
|1/8,7/8|1.643|
|1/4,3/4|2.162|
|3/8,5/8|2.499|
|1/2|2.616|

The receipt retains all 280 exact norms and weight-list digests; the script reconstructs the lists from the formula. The digests are reproducibility aids, not proof of rational identities. A checker must accept the actual kernel identities and bounds or compute them through a proved exact procedure.

The setup pool has `7*sum_(r=182,184,...,260) r = 61,880` rational weights. Opposite offsets admit reflected arrays, but this report charges all seven arrays. Rounded versions at different tolerances require appropriate certificates or a shared sufficiently accurate representation. Their generation, checking, memory and transport are not free.

## 4. Complete arithmetic, target and boundary conditions

Retain the preceding adapter's tighter T-sample allowance epsilon/64 at all N indices. This divides each selected row's old time-root/gate, omega and final time-output rounding allocations by 16. Four extra fractional bits relative to that row's sufficient baseline still suffice. No additional Gaussian or character-transform precision is introduced by the new order. All earlier rounded bucket operations remain charged.

The norm bound below four makes sample uncertainty contribute less than epsilon/16. For a concrete rounded-kernel implementation, choose a real absolute tolerance

`v <= epsilon/[16*r*(M+3)]`.

Quantize each weight with error at most v, round each of the r real products with error at most v, round the r-1 sequential additions likewise, and allow one final rounding with error at most v. Since sample centers have modulus below M+1, the kernel and evaluation error is at most

`r*(M+1)*v + (r+r-1+1)*v = r*(M+3)*v <= epsilon/16`.

This formula includes weight uncertainty separately from product and addition roundoff. The setup quantization is not counted as a fresh per-query operation. A different accumulation scheme is allowed only with its own proved error and operation count.

At each target, the complete error is consequently

`3epsilon/4 + epsilon/16 + epsilon/16 + epsilon/16 = 15epsilon/16 < epsilon`.

These terms are, respectively, the target's analytic/coefficient comparison, the interpolation remainder, propagated sample error, and kernel/evaluation arithmetic. No term assumes independent errors. The sampled polynomial and coefficient array must remain the same throughout.

Stencil indices are reduced modulo N for lookup. This wraps only T, whose period is P. The proof uses the unwrapped real nodes and their equal wrapped polynomial values. It does not assert that F_b or Y is periodic, and does not import negative-height Y samples. Every final target remains in the closed interval [0,V]; the lower and upper endpoints are existing coarse samples. The exact checks verify N>r and m_grid+1<=N at every row. No extra analytic halo or low-height asymptotic lemma is needed.

For a strict sign, the positive identity Y(t)=exp(theta*t/V)F_b(t) suffices without evaluating that scale. For an actual Y enclosure, retain the adapter's separately certified target-dependent scale, coarse-scale tightening, offset factors and final multiplication budget. The canonical root phase and Turing normalization are unchanged. A radius not excluding zero remains inconclusive; smaller stencils do not create a sign guarantee.

## 5. Full-range independent-stencil counts

For a conductor with n primitive labels and m_grid coarse intervals, ordinary eightfold refinement has exactly 7*n*m_grid new endpoints. These are the seven interior eighth-grid points of every coarse cell, including the last cell ending at V. No endpoint is omitted or double-counted.

A query at selected order r uses r real products, r-1 real additions, 2r real rounding gates under the implementation above, and r sample accesses. The final strict sign test and any requested Y rescaling are extra. Existing adequate T samples are a prerequisite, not free values.

| Extra coarse nodes | New endpoints | Adaptive real products | Fixed340 real products |
|---:|---:|---:|---:|
|0|12,427,893,758,063|2,439,308,097,734,074|4,225,483,877,741,420|
|167|12,449,493,497,315|2,444,314,618,551,050|4,232,827,789,087,100|
|320|12,469,282,479,983|2,448,675,913,538,876|4,239,556,043,194,220|
|640|12,510,671,201,903|2,457,999,714,849,406|4,253,628,208,647,020|

The main row saves exactly 1,786,175,780,007,346 real products. Its additions are 2,426,880,203,976,011 and its rounded arithmetic gates are 4,878,616,195,468,148. The receipt includes all four corresponding totals, exact ratios and order-weighted query histograms.

These are full-range costs for evaluating local stencils independently. They are not the cost of an optimal dense algorithm and are not predictions of the actual number of sign repairs. For a sparse set of requested queries, charge the selected r for each actual query and the union of its wrapped sample accesses. Repeated queries may share an answer; different stencils may share sample storage but not automatically their arithmetic. Dense polyphase or padded FFT schedules remain separate competitors.

Relative to fixed340, the setup pool grows by 59,500 exact weights. With complete per-query costs C_340(i), C_r(i) and incremental setup/storage/proof cost Delta_setup, this option is cheaper only when

`sum_(actual queries i) (C_340(i)-C_r(i)) > Delta_setup`.

The new kernel tolerance is no tighter solely due to r, since r<=260<340 at the same M and epsilon. Nonetheless costs depend on actual widths, representation, proof rules and caching. Checking 61,880 rational weights can dominate a tiny query set. Hash-only imports are not allowed, and rebuilding a discarded kernel pool must be charged. No Lean/MM0/runtime winner is inferred from the weighted-term reduction.

## 6. Reproducible evidence and limits

`adaptive_small_theta_interpolation_20261111.py` performs 122,152 exact checks. It validates seven predecessor pins; constructs the 130 minimal-even orders; checks all 280 kernel norms and basic reproduction identities; reconstructs each selected N, frequency bound and closed output range; and recomputes the four complete query/product schedules. It imports no earlier generator or numerical evaluator. Only the frozen selected-tilt metadata is consumed.

| New artifact | SHA256 |
|---|---|
|adaptive_small_theta_interpolation_20261111.py|83397BC9122A7D965E91503990AAF7DAFE6A3A8FEB4CF1508C92C2886FBF229A|
|adaptive_small_theta_interpolation_20261111.json|3E6F184E7C7D2F13915F925C6687E3970204990035487DAC8BD41D9991C283A2|

The frozen dependencies are:

| File, relative to agents | SHA256 |
|---|---|
|prime-estimates/MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md|73337A5EB2688E5B1A5196A901232A314D89F3E48B5EEFC013CA178A8FFA238A|
|prime-estimates/CLARIFICATION_MINIMAL_THETA_BUCKET_ROUNDING_2026-11-11.md|4ACF800D0F7C773FA5A2DF013BD5F1341ED3CC98C0F9D257D81A2EE63B480D41|
|prime-estimates/small_family_minimal_theta_20261111.json|25E4BF80119B05A5C0FF25BDB7AECACEBC7495B5A00097B991E11C3DBF77D422|
|audit/REVIEW_MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md|58215EA3A0D697D229AD746F6FCE340DE913165D63599DC197798E705392308B|
|integration/SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md|19E411982E0D504C52F604145D6404ACB3BEBA51B662CB7BB1CDBD5D31E83081|
|moebius/REVIEW_SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md|B815BBEEF96C0E8D1259A915E8BB0F3BEB98BBD1CFB9473B038E0B3D64F3A38F|
|integration/MINIMAL_THETA_INTERPOLATION_APPLICABILITY_2026-11-11.md|BEE442CFF66187EAEEC930441D0AE414725A198A72B394A47701DB27E1D6B8FC|

The finite remainder proof and explicit arithmetic allocation are supplied above; there is no new analytic value or unproved interpolation-tail premise hidden in the order selection. Actual source-bound coefficients, T samples, kernel acceptance, signs, completeness and ordinary proof implementation remain outstanding. Independent review of this new proposal is separate from its predecessor reviews.
