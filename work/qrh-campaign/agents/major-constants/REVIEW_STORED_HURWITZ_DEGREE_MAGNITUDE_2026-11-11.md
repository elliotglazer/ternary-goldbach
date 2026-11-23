# Independent review of stored Hurwitz degree magnitudes

2026-11-11. PASS at conditional source/paper and exact-envelope scope, with no correction requested. The bounds apply to the actual stored finite-polynomial centers under the pinned producer contracts. They do not assert equality to fine-anchor derivatives, authorize a larger evaluation error, or establish an operation/runtime saving.

Reviewed author: `prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md`, SHA256 `9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2`. I read the entire note, script and receipt, the relevant sections of the scaled-seed and joint-seed source papers, the complete m159 correction refinement and the selected-band ledger. No author program was imported or executed. All frozen artifacts remain unchanged.

## Actual coefficient object

The first four selected bands use coarse normalization D and P27, except the unshifted right endpoint where P20 suffices. The final band uses sourceD4096, P28 at every coarse endpoint, m159, and delivered normalization8192. The finite translation is unchanged by reducing the correction count. In the final band its actual shifts are0,1/4,1/2,-1/4 in source units, followed by2^-k. The negative quarter uses the right endpoint. These are the objects consumed by the author's formulas(2) and(3).

The proof never identifies their finite translated coefficients with the exact fine jet. It first bounds the finite translation of exact coarse jets, then adds the numerical errors between those finite coefficients and the delivered centers. The analytic translation bias remains in the later actual-function approximation. Thus it does not omit a bias merely because it proves a small magnitude for the stored polynomial.

The source domains include negative t, t=0, and a=0,1. No continuation singularity is introduced by those points: the original EM denominators and derivative identities retain their prior conditions. At the first-four rightmost endpoint no missing P27 inputs are manufactured; tau=0 uses only the twenty supplied coefficients and is covered by the same loose envelope.

## Positive-degree coarse bound and finite translation

For j>=1 the shifted Hurwitz series is absolutely convergent because Re(s+j)>=3/2. With z>=1, its absolute sum is at most1+1/(j-1/2)<=3. The decreasing-positive-function integral comparison in the note has the correct indexing: each(n+1)^(-sigma), n>=1, is bounded by the integral over[n,n+1]. Positive real bases remove any dependence on the sign of t from the norm. Degree zero is excluded from this argument.

The rising factors satisfy |s+l|<=V+l+1/2<V+32 over all required coarse orders, so3A^j/j! is valid. Combining this with binom(j,k)/j!=1/[k!(j-k)!] bounds every finite translated positive degree. The elementary rational tail bound H(x)=1+x+x^2/[2(1-x/3)] follows because the factorial terms from degree2 onward have successive ratio at most x/3. Its domain includes5/8 and7/8. I independently verified H(5/8)=569/304<2 and H(7/8)=657/272<5/2, and directly summed the relevant finite rational majorants for every delivered positive degree.

This gives the first-four ideal envelope6(5/4)^k/k! and final envelope(15/2)(7/8)^k/k!. The final factor7/8 includes the actual2^-k postscale. Using sourceD4096 without that postscale would not justify it; the author includes the factor correctly. The strict inequalities have slack from the stated A and H bounds, so equality cases in later rounded-input bounds do not undermine strict stored-center caps.

## Numerical vector errors and degree zero

For the first four bands, the scaled-seed source gives coarse-slot error below eta/4 and330 complete midpoint-update injections. Its nonnegative translation/suffix proof controls the SUM of weighted slot norms, not merely one complex evaluation that could cancel. It therefore implies individual error at most4^k W, W=4eta+330u_T. The source part4eta is conservative. Independently, each suffix is entrywise dominated by the full positive translation and each row sum is at most2^27; this gives the flat bound2^27(eta/4+330u_T)<2^-73. Taking the minimum is sound because both bound the same slot error. This avoids the invalid shortcut of assigning every first-four midpoint slot an eta radius.

For the final band, the joint source's delivered numerical radius is relative to the finite translated vector itself and already includes postscaling and its output round. The m159 source explicitly preserves the prior correction-magnitude and rounding estimates. I checked its rational remainder below2^-116, its31*159 correction-round allowance below7936, and the inherited source/output inequalities below.107eta and.557eta. Hence the author's final flat eta is valid for every delivered slot, including the endpoint and negative-quarter translation.

Degree zero is bounded by finite EM plus its remainder, then the positive-degree translation and numerical error. The first-four common constant5170 is5165 plus a conservative5 for that translation. The final constant4507+9/2 follows the final EM bound and H(7/8). Both retain R=2^-116 and the proper numerical slot radius. Neither uses the divergent degree-zero absolute series. The resulting large z0 enters only the last coefficient addition in Horner and never a subsequent product.

## Direct conversion, accumulator and width consequences

The new centers must be obtained by direct conversion from the source-bound delivered centers. A coordinate nearest round gives complex norm error strictly below(3/4)2^-b. Applying another conversion to an already requantized array would require its own double-rounding allowance and is not included automatically.

For any b_j>=70 the magnitude recurrence has exactly one conversion contribution per coefficient and one product-round contribution per stage, with no round for the initial copy or final exact addition. I independently expanded it as

    H_j=sum_{k=j}^{19}(Z_k+e_k)4^{j-k}
             +sum_{k=j}^{18}e_k4^{j-k}.

This matches every saved H_j, and T_j=H_(j+1)/4+e_j matches every product row. All twenty strict-power capacities in both classes pass, as do the stored-center powers. Converted positive-degree coefficients remain below8. The first-four positive-degree accumulators remain below16, the final ones below8, while both final degree-zero accumulators remain below8192. The degree19 sufficient powers are indeed-48 and-57. At b19=71 these imply24 and15 signed input bits respectively, including the sign bit.

These are magnitude consequences only. Arbitrary profiles with b_j>=70 do not thereby satisfy the old evaluation-error budget: that requires the separate profile proof. The accepted uniform, linear and optimized profiles can combine their own error proof with these bounds. Each stage must price its actual previous-grid input and output-grid nearest witness, with exact alignment afterward. In sufficiently high degrees the variable factor may be shorter than the geometry factor, so the best rectangular orientation can change. Raw shifted products, residuals, sign/range proofs, exact additions and conversions remain separate charges. Old generic-width subtotals and rankings cannot simply be relabeled.

## Independent evidence and boundary

The independent checker passed485 exact assertions. It verified seven full source/packet hashes, the positive-degree integral constants and A domains, the final m159 remainder/output allocation, every finite translated ideal majorant, every numerical Z envelope and every closed-form H/T capacity. It evaluates only rational bounds and integer sizes; no source coefficient, function, transform, prime, zero or spectral datum was computed, and no build ran.

Script: `major-constants/review_stored_degree_magnitude_20261111.py`, SHA256 `9B2CD7D259FF76BAB0457DFC3B209E250E1086731C3E6209BBC8A0291F2027A6`.

Receipt: same stem JSON, SHA256 `AE9763626A7572745F24E041366CD6348E4C1EE9D88A921DE23DB624F1A625A7`. Its complete pins bind scaled source251B95AE, joint sourceAA1A7464, m159E6F0F3B2, reconciled source483B6F4D, author9B777E02, author script1F0D78DF and author receiptE947C32E.

The inherited continued-Hurwitz identities, source arithmetic contracts and their eventual standard-rule implementation remain prerequisites. This review accepts the new source-bound magnitude argument and exact metadata, not generated enclosures, a formalized theorem, complete spectral coverage or a cost winner. Repricing may now consume these conditional bounds without changing the frozen author packet.
