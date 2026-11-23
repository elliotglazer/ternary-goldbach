# Review of conductor-local transform precision

2026-11-11. PASS at the conditional mathematical and saved-schema design scope. No correction to the frozen author is required. The cache-contract qualification below is part of this verdict.

Author: `major-constants/CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md`, SHA256 `1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A`. Paths in this review are relative to `work/qrh-campaign/agents`, except the explicitly named blueprint source.

I read the complete frozen paper and the relevant error, magnitude, normalization, cost and guard-domain sources. All eleven dependencies in its source table match their pins. I inspected the saved-schema writer and the error-coefficient producer as source, without importing either. This review does not parse or fold the conductor or axis inventories, produce a precision distribution, or approve a production precision. It supplies no actual roots, inputs, transforms, signs, zeros, proof emission or build result.

## Mathematical reconstruction

The mixed precision supplement, sections 1–5, assigns C and D to the full ordered transform plan, with absolute complex root and arithmetic error u. The source producer `zero-sum/mixed_radix_precision_metadata_20261111.py:88–107` implements the same identity, radix, direct, Bluestein and ordered CT recurrences. In particular CT uses C_m+C_r+2 and the cross-term safety C_m+C_r(2C_m+1), with m evaluated first. The author preserves that order. Primitive-output pruning does not reduce the axis length in the norm or error bound.

For a conductor c, each occurrence of an outer axis contributes to S_mixed(c), including repeated axis lengths. The author separately retains S_old(c) and both baseline and mixed safety denominators. This avoids incorrectly replacing the accepted dyadic safety comparison by a pointwise real-denominator inequality. The CT maxima cover descendant safety conditions. Descendant C values are bounded by their root-axis C, and the accepted mixed-to-baseline comparison therefore supplies C_node*u<=1/2 from S_old(c)*u<=1/2. The internal radix stages of a Bluestein leaf are covered by its own D and C bounds. These are the premises needed by the older augmented peak proof and the normalized postchirp bound; local D alone would not suffice.

For stored input centers with M+1<=2^14, the normalized tensor error is bounded by

    (M+1) [product_i (1+C_i*u)-1] <= 2 S_mixed(c) (M+1) u.

The exact transform is unnormalized. Restoring phi(c) and applying the exact conductor factor gives

    epsilon_c(p) = 2 phi(c) S_mixed(c) 2^14 2^-p / sqrt(c).

This explains both the factor 2 and the division by sqrt(c). There is no replacement of phi(c) by the primitive-character count. Approximation of the conductor factor and uncertainty of the input centers remain separate downstream terms. In particular, the full alpha allowance is not charged again through this intrinsic coefficient.

The rounded normalized-cache proof retains the old Bluestein C,D. It includes the error of constructing the old kernel and of rounding its scaled value onto grid p. Consequently the same CT and tensor recurrence applies to the new centers. This review does not select its optional sharper C_new or infer an error coefficient from narrower integer widths.

## Exact selector and complete radius

Let S_g=202305920. Cancelling the common positive factor 2^14 in epsilon_c(p)<=1266*S_g*2^14*2^-108, multiplying by the positive sqrt(c), and squaring nonnegative sides gives exactly

    (2 phi(c) S_mixed(c))^2 * 2^(2(108-p))
       <= c*(1266*S_g)^2.

No square-root approximation is needed. For p in 100 through 108 the left side decreases by a factor four at each step. The least passing p is minimal only for this fixed sufficient test and the retained guards. It is not an optimum for actual error or total cost. The S=0 case is harmless and permits p100 under the other interfaces.

The fallback p108 exists on valid saved rows. The accepted global sum bound gives S_mixed(c)<=S_g, while phi(c)<=c and c<=265800 imply 2 phi(c)/sqrt(c)<=2 sqrt(c)<1266. Both global safety limits are already below 2^100. The claimed simple threshold is also correct: 256*790257=202305792<S_g, whereas 256*790258>S_g. This is a sufficient p100 class description, not a count of qualifying conductors.

I independently expanded the full error composition from `blueprint/LOWER_TRANSFORM_PRECISION_ALLOCATION_2026-11-11.md`. Its fixed part is

    T +135*(2^-82+4*2^-63)
      +10*2^-54+93*2^-55+2^-51,
    T=(927193523/10^9)*2^-46.

Adding 135 epsilon_c(p) preserves all completion, inverse-channel, sample/kernel and accumulation terms. The selector bounds this by the exact global-p108 expression, whose ratio to 2^-45 is

    2804840254168152529 / 4294967296000000000
      <653052762/10^9<691/1024.

Thus the proposal preserves the stronger current complete p108 ceiling. It does not merely preserve an obsolete isolated transform allowance. The earlier intermediate sample bound 2^-51 is not reused. The ordered magnitude arguments bounding the stored transform, L and positive/adapted Y centers continue to hold because epsilon_c(p) never exceeds the same p108 allowance.

## Inputs, guards and widths

The proposal uses one p(c) for all characters and retained heights of that conductor. This includes the positive inverse-character samples used to form negative samples. Each interpolation uses one conductor's samples, so the existing uniform radius proof applies without a mixed-precision interpolation theorem.

Grid100 input centers embed exactly at every allowed p. Their source error does not shrink. The actual head, assembly, completion and interpolation producers retain their own tolerances. The source magnitude bridge M+1<=2^14 is mandatory, rather than inferred from a final L or Y bound.

The newly reviewed short-guard domain source is consistent with this statement: its maximum 26525/4 is below 7000, and it separately admits K18/94 and K19/93 there. This is new domain evidence, not inheritance of the older actual-height K18 cap. The full P20 route also remains available. No guard samples or guarded cost association were produced here.

Fractional p is not total operand width. The normalized context proof still requires exact n, P, stage and incoming augmented factors. Old rounded exponents cannot be inverted to reconstruct them. Root and normalized-kernel capacities remain distinct, and the presums, raw products and rounding witnesses retain their additional bits. The exact-scaled cache on grid p+log2(P) is a different representation and is not priced as the rounded grid-p cache.

## Cache and schema conditions

The author's cache identity must include the exact enclosure/proof contract as well as its listed plan, normalization, p, rounding and lifetime fields. In the selected proposal this contract is fixed by u=2^-p and the accepted kernel construction/scaling bounds. The author confirmed that interpretation. A weaker-radius cache cannot share the key merely because its center grid and plan match. This qualification does not change the frozen selector or setup formulas.

For one canonical cold-cache schedule with one lifetime per key, each selected (leaf n,p) needs P(n) complex entries, P(n) complex scaling rounds, and 2P(n) exact REAL sums C+D and D-C. It does not need two complex sums per entry. Kernel FFTs remain full, including when runtime outputs are pruned. The ninefold length/entry bounds are upper bounds for this declared schedule; additional lifetimes, signs or variants must be charged if actually introduced. Root-angle sharing is not proved by these kernel counts.

Reusing a finer cache requires an explicit exact-grid or rounding adapter and its widths/error proof. No free p108-to-p100 reuse follows. Cold replacement and switching after old setup is sunk have different bills. Source values, coefficient proofs, cached-sum binding, storage and local proof reconstruction remain paid. Runtime width savings alone establish no net saving.

The proposed source fields agree with the writer at `integration/transform_structural_inventory_20261111.py:283–292`. The saved axis coefficient fields agree with the producer at lines 104–107. This is a source/schema check, not validation of a new join. A future pass must match the canonical plan hash, preserve axis multiplicity and order, and verify all row/safety/slack bindings. The cap 9*37117=334053 plan/precision states is below one million. Repeated traversal must use that state key; a naive walk per conductor is not the bounded algorithm described. The old scenarios remain alternatives, and `guards_included=false` remains required until a separately pinned guard join is performed. A price fold is a distinct later pass with the full comparator reconstructed first.

## Evidence and bounded verdict

The independent script `review_conductor_local_precision_20261111.py`, SHA256 `205EAAE7B4461012038F1166603879D04DF9DD0F3043D1BD2A66E5A1F0A3715A`, made 45 exact checks of fixed scalar identities, bounds and source hashes. Its exclusive receipt `review_conductor_local_precision_20261111.json` has SHA256 `5FC52325EE512961DAA17B3F6227471CDDA75568CE2CF5B50EA2CFBABEAA9B3C`. It parses only the author's source-pin table. It neither parses an inventory nor imports an author program. The initial generic Python launcher was unavailable; the completed checks used the installed interpreter directly. No partial receipt was produced by the failed launch.

Two additionally consulted sources are `independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md`, SHA256 `412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7`, and the error-coefficient producer, SHA256 `3750A9C8FD77163C878694959158762D183F1425E4F85F983230A841BAEBDC42`. The receipt records the eleven author dependency pins in full.

The paper contract and bounded schema proposal pass. Actual p distributions, cache duplication, guarded normalized widths, complete backend prices, source/root/cache generation, new strict signs and count completeness remain open. This verdict does not establish a saving or authorize a production fold, numerical run, or formal theorem closure.
