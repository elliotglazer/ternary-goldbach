# Review of variable-degree rounded initial differences

2026-11-11. PASS at the bounded paper/source and exact-metadata scope. No correction requested. The result is a family of sufficient evaluation contracts for K18..20, b93..100, d0..2 and L1..260. It is not an implemented arithmetic certificate, a priced winner or a preserved numerical sign chain.

The frozen author `major-constants/VARIABLE_DEGREE_GRID_ROUNDED_DIFFERENCES_2026-11-11.md` has SHA256 `79F8EA3F6F8BE2AA0EC61E335BB068EA2690A3AA84CBB4BBF39D6878FC4F1B55`. The script `variable_degree_rounded_fd_20261111.py` has SHA256 `E967C5E2FF96D907239A24C8A8D6A4205F1A89FA462A00B54E406C16B666457F`; its receipt has SHA256 `82C2BDAC4E313A18A90799957DDA04E2BB96FBB9FE2B62208D4714E9FED1B143`. I read the complete frozen note and script, without importing or running the author program.

## Finite polynomial and source join

This changes the evaluated polynomial to the first K entries of the ORIGINAL delivered finite translated coefficient vector, after direct coordinate-nearest conversion to b bits. It does not truncate the source seed or assert that delivered coefficients are exact fine-anchor derivatives.

I checked the source join against the shorter-order author `0EAED4F960DFC4F590564A9B8A86E9C22BB621FCE362CCAB7A13D2D3976A1D2A` and its independent review `B15D0C3B15B8005A6B3DC3CFE1A1CDE157448B83904950487CD124F87647536E`, and the matched Horner contract `AEAB2BDCF2D767546A7F410CC463D17DFB6C4639BFFC94D771574C134DA36E63` with review `84B062431F1A7C49C2191E8C4576A6CC6B870A431A5BB3E7BBDDF59150F437D7`.

The genuine length-K Taylor remainder comes from the continued Hurwitz derivative identity and absolute convergence of the Kth derivative at real part K+1/2. The real segment stays within alpha in [0,1]. It gives `1266*((|t|+K)/(4D_out))^K/K!` after the retained character amplification bound 633. The final output D is 8192 even though its source D is 4096. Both signs of height and spatial ties are covered.

The differentiated finite-translation bias and the numerical source errors remain distinct. Prefix projection removes only nonnegative weighted error terms. Thus the old fixed shift biases remain valid, as do numerical terms `2532*2^-100+633*330*2^-110` in the first four bands and `844*2^-100` in the final band. The old evaluation term `1688*2^-100` is replaced once, not charged twice. P27/P28 source orders, EM work, full finite translations and twenty-slot source delivery remain unchanged.

The new alpha conclusion is strictly below `2^-82`. It does not retain the old stronger final fraction `.16*2^-82`, old center values or previously successful sign tests. The actual final height `424195/64` is a restricted requested domain; it does not replace the declared 7000 domain elsewhere.

## Exact recurrence and all-live error

With n=K-1, the correct partial coefficient indices are `n-i+ell`, and the exact final denominator is `2^b*v^n`. The author's initializer and recurrence use these objects throughout. The new top coefficient is z_n, not z_19.

For the optional power normalization, expanding the integer partial polynomial in r shows that its r^ell coefficient contains F'^ell. Applying the jth difference at zero contributes `j! S(ell,j)` and vanishes for ell below j. Consequently `j! F'^j` divides each relevant difference. Division by `2^lambda_j`, where `lambda_j=j*nu2(F')+nu2(j!)`, is justified at every stage. The secondary recurrence factor becomes the odd part of j. This is a finite divisibility proof; a separate support bound is still required for capacities.

Let `m=min(K,L)` and let delta_j be the initial complex rounding errors. Exact ascending updates give

    error_j(r) = sum_{k=0}^{min(r,n-j)} binom(r,k)*delta_(j+k).

At a retained state, j+r is at most L-1. Therefore every required initial index j+k is below both K and L, hence below m. The pruned high states are never read. Ascending order uses the old next-order value at each addition.

Two coordinate half-ulps have complex norm at most `sqrt(2)/2` ulp, strictly below `3/4` ulp. Write `S=sum_{j<m}binom(L-1,j)` and `p=b+bitlength(S)+d`. Each live row sum is at most S, so the new common state bound is

    beta_L = (3/4)*S*2^-p < (3/4)*2^(-b-d).

This is not the old `u100/4` promise. At b93,d0 it can approach `96*u100`. Stored magnitudes must include beta_L and raw two-state sums must include twice beta_L. The frozen report states both requirements explicitly and does not transplant the old widths.

Direct coefficient conversion contributes less than `(1-4^-K)*2^-b`; initial-state propagation contributes less than beta_L; final output rounding contributes less than `(3/4)*2^-b`. The resulting expression is exactly the author's equation (4). Its brackets are below 5/2, 17/8 and 31/16 for d0, d1 and d2. No independence of rounding errors is used. Final rounded outputs do not enter traversal.

## Capacity, operation and export obligations

The stagewise envelopes must be rebuilt using `c_j=Z_j+(3/4)*2^-b` and the actual tail `c_(n-i)..c_n`. The all-cell bound removes powers below the difference order. Guarded kernels keep their own strict c/F hypotheses. The old partial state, raw general product, secondary product and coefficient insertion remain separate. The author's formulas correctly scale exact normalized states by `2^b*v'^i/2^lambda_j` and rounded states by `2^p` after adding their new error.

Initial conversion is a wide nearest quotient with numerator `E_(n,j)*2^(p-b+lambda_j)` and denominator `v'^n`. Its shifted numerator, quotient product and signed residual temporaries remain obligations. Only a proved common power of two may be cancelled. The final dyadic conversion is cheaper in kind but still needs splitting, tie, sign and range proofs.

I independently enumerated the initialization stages and retained updates. The general product count is `m*(2n-m+1)/2`, including m=n+1. Binary secondary scales preserve their popcounts under the admitted power normalization. Initializer additions, shifted operands, n prescales, m initial rounds and traversal counts match every saved row. Traversal visits nonunits; only U unit outputs receive final rounds. Source delivery remains twenty slots. A separately converted prefix costs K direct conversions, while a retained full conversion cache costs twenty.

For b at most 100, exporting M/2^b as `M*2^(100-b)/2^100` is exact. It changes representation, not accuracy. Its two coordinate shifts and binding proofs remain charged. Direct original-center conversion, conversion via an existing b100 object and nonuniform degree-grid conversion are different cache contracts. The note does not identify them without proof.

## Independent exact evidence

My script `audit/review_variable_degree_rounded_fd_20261111.py` has SHA256 `A3D4204356EF99D2189C43E72D75A168724DA85AE03750FAD56CE7E35252B9C9`. Its exclusive receipt has SHA256 `35BC6033B76DF8D30C21289320D8A1C3939989CB83726EFCA2019FB3A628933B`.

All 161286 checks pass. The checker builds Pascal rows iteratively, reconstructs all 780 length/count rows, bounds every live terminal row, enumerates the operation counts and reconstructs all 432 complete rational alpha candidates and 54 summaries. It independently matches all seven displayed outward alpha bounds and maximum p values. The finite worst ratios occur at L19, L20 and L21 for K18, K19 and K20 respectively. Their use is restricted to the enumerated L1..260 domain.

All three direct artifact pins and all eight prerequisite pins match. This review used source reads and exact integer/rational metadata only. There were no function, coefficient, transform or prime values, builds, Lean changes or author-program execution. The accepted family still requires actual input records, instantiated capacities, complete prices, source/label bindings, downstream radii and fresh sign/completeness checks before any production use.
