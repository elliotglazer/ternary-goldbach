# Review of the shared elementary theta circuit

2026-11-11. **PASS for the conditional paper circuit and exact metadata. No correction requested.** The correct author hash is `A8AC4A3B594C8671476FCC92C67A45DCF42EFF0060F522023F929BA440835A4B`; the alternative spelling in the assignment was a transcription error, not changed author bytes.

Author: `integration/SMALL_CONDUCTOR_SHARED_ELEMENTARY_CIRCUIT_2026-11-11.md`. I read the complete note and its metadata program, compared its interfaces to the previously reviewed small-conductor backend and mixed-radix error contract, and independently reconstructed all 15 metadata rows. No author generator was imported or executed. No elementary function, root number, character, theta value, transform or spectral datum was evaluated. No build or frozen-file edit occurred.

## Radial construction and Gaussian input

The old analytic inputs remain unchanged: x_j=j*2pi/P, j<=ceil(PX/6), and x_j<2(X+1). Thus A_j=exp(x_j/2)<B=3^(X+1), with r=exp(pi/P)<2. For the rounded recurrence, the error satisfies

    E_(j+1)<=(r+dr)E_j+(r^j+1)dr.

Iteration gives E_j<=2j dr(r+dr)^(j-1). The product bound (1+dr)^J<=2 and r^(j-1)<=B then give E_j<=4jBdr<=sigma. It is essential here that the rounding error is dr, not the much larger sigma. The stored states lie between 3/4 and M=B+1.

The pi input and real exponential for the radial seed are explicitly separate from the outer Gaussian exponential. Pi error dr/16 and intrinsic exp error dr/2 suffice. On the small enclosing interval P>=6 bounds the relevant exponential by 2, so the argument perturbation is safely below the remaining dr/2. This conclusion does not use a computed exponential value.

Squaring the radial state gives errors E2<=(2M+1)sigma and E4<=(6M^3+3M^2+1)sigma; the optional cubic state has E3<=(3M^2+M+1)sigma. These follow by subtracting exact products, with the already rounded square T retained in the cubic calculation. The stored magnitude bounds 2M^2, 2M^4 and 2M^3 are valid. Since X>=1, M>=10; the displayed reductions to 15M^4 sigma and 7M^3 sigma have ample algebraic room.

For the cutoff, Ahat-sigma is positive and at most A. The reciprocal difference is at most 4sigma. Rounding n0/(Ahat-sigma) upward and truncating at n0 therefore retains the exact lower bound n0/A and an upper excess less than 2, because 4n0 sigma<=1/4. The j=0 choice n0 avoids an unnecessary rounding case. This is the same sufficient cutoff contract as the parent; no exact comparison with a transcendental integer is needed.

The exact Gaussian argument is z=(pi/c)cis(2b)A^4. Its real part exceeds 3/W. The stated arithmetic bound makes |zhat-z|<D<=1/W, so the joining segment stays strictly in the right half-plane. Along it, |exp(-z)|<=1, and the exponential is Lipschitz with constant one. Thus the argument error D<=delta/16 plus intrinsic outer-exp error delta/16 gives raw q error <=delta/8. The two-round contraction then gives a center in the unit disk with error <=5delta/8<delta. This closes the parent's recurrence premise without assuming approximate modulus one is exact.

The outer argument may still have a large imaginary part. Exact range reduction, its pi precision, series work and raw operand widths remain costs of the exponential certificate; the count of one such certificate is not a constant-cost arithmetic operation.

## Prefactors and actual root phases

For k=a+1/2, exp(kx) is A for a=0 and A^3 for a=1. The cached K_chi has exact norm at most 2. Combining its sigma error, the radial-power errors and the final complex-times-real product gives precisely the author's common prefactor error bound. It is strictly below epref. The later multiplication with the character contraction remains at the separate parent tolerance; no multiplication is counted as paying two unrelated error contracts.

The conductor roots certify c*h_c^2=1 and c*v_c^4=1 with positive roots. Independent endpoint power inequalities can bound these actual roots to kappa0; assigning the same error to intermediate square-root calls alone would not suffice, and the author explicitly excludes that shortcut. Because the exact roots are at most one and kappa0 is small, a telescoping product estimate below 64kappa0 covers the finite Q_a and Z0 construction, including their angle perturbations and final rounding. The formula for kappa0 makes this less than sigma/16.

The additional positive character transform acts on the actual additive roots cis(2pi*r/c). Its output is the Gauss sum with the same explicit character labeling as the main transform. The full primitive Gauss/functional-equation semantics are inherited inputs, not conclusions of approximate arithmetic. Sum of input errors is at most eta/16. With center bound 2, the normalized error lemma gives unnormalized intrinsic error at most 6vS*u_G<eta/16. Hence total Gauss error is below eta/4. Multiplication by h_c, its error eta/(8c), the bound |tauhat|<=2c and one final rounding give W error below eta. These are all errors of the original W, not a renormalized substitute.

The four charts concern conj(W). Some signed coordinate of a unit complex number is at least 1/sqrt(2), so the gap to 1/2 permits finite interval certification; no branch equality decision is required. In a selected chart the exact real square-root coordinate is at least sqrt(3/4)>4/5. Here eta<=1/4096. Perturbing its radicand by eta/2 and allowing intrinsic square-root error eta yields real-coordinate error below 4eta/3. Its stored value remains above 3/4. The reciprocal formula for the imaginary coordinate then has error below 3eta, including its division rounding. Their sum is below the author's 7eta Euclidean allowance. The eighth-root undo and final rounding raise this to less than 10eta<sigma/16.

This is a fixed exact epsilon satisfying epsilon^2 W=1. Its stored center need not have exact unit norm. An earlier packet's epsilon may differ by a sign; the author correctly requires explicit alignment before reusing its signed values or count normalization. Nothing identifies the positive-height channels of inverse characters.

The final K=epsilon*Q multiplication is below 5sigma/16 error using exact norms 1 and 2 and the retained product cross term. It therefore supplies the sigma cache bound used in the prefactor argument.

## Roots, scale and operation accounting

The direct-root option charges the root leaves. The recurrence option instead supplies one primitive root per distinct order, checks its unit-disk contraction, and performs prefix products. With seed and gate errors u/(2m), its kth root error is at most k*u/(2m)+(k-1)*u/(2m)<u for k<=m. This is not free native root generation: the prefix gates, finer seed/angle precision and later indexed storage or regeneration remain explicit. Bluestein kernel setup remains required and its nonunit kernel uncertainty is not mistaken for root error.

The common output multiplier exp(theta*m*Delta/V) is generated from one real seed. The same radial argument gives an error at most escale/2 over the actual requested grid. Taking the real part of the approximate F does not enlarge error because exact F is real. The final real product retains the parent's tau/4 rounding allocation. All comparisons concern the same Y values and Y tolerance, with the same V and grid; a differently normalized EM output does not qualify without its full conversion cost.

The frequency-product count is J+(4+o+2n)R: J radial updates, two radial squares, two coordinates for z, o cubic products, and two coordinates for each label's prefactor. All five supplied conductor shapes have an odd channel, so the script's 5+2n specialization is valid. The final prefactor/contraction products, Gaussian unit gates, character transforms and time butterflies are unchanged core costs and remain separate. The phase setup adds one Gauss transform, per-label root/division/cache work and the listed fixed arithmetic. The loose 16+12n setup count is a bounded straight-line call allowance, not a count of scalar proof instructions; comparisons, rounding witnesses, index binding and operand widths must still be charged by the implementation.

The new construction removes the need for an inner exponential at every frequency and for a new parity phase at every label/frequency. It does not prove that a historical producer performed those redundant operations. Direct cis counts, unit-root recurrence alternatives, cutoff rational divisions, transpose storage, auxiliary/end-point repairs and all actual sign/count tests remain part of the comparison. Neither a runtime winner nor a successful value or sign has been produced.

## Independent evidence and scope

All nine input/evidence pins in the author note match. Author script: `B8DCACDC4896258C2A5E721FB67A845FCFD6099C74BA34342158F10095EBBCF3`. Author receipt: `117D2C82B8CA19CC24C3C359573598149F6B1CE6D53463B48B395B716350520E`.

Independent script `prime-estimates/review_shared_elementary_metadata_20261111.py`, SHA256 `7677B87BB4C6F0E5565D72C0F50BC6DDCB99CD7F86B2A79A58D6C588D719F30F`, reconstructs the entire 15-row dictionary using an independent bit-length calculation, then checks the new error inequalities. All 540 field comparisons/inequalities pass. Receipt SHA256: `C576C6CF9E511D2C43DC342DD1AB45FC25082C2468A4F20E505E2330C9C09BE6`.

Acceptance is for the paper composition and exact metadata only. The elementary checker, arithmetic circuits, transforms, actual values and spectral completeness remain unimplemented or unproduced by this packet. The review does not reclassify its inherited Fourier/continuation source plans as kernel-validated theorems.
