# Large-branch interpolation sample guards

2026-11-11. Conditional dependency and operation ledger from saved structural metadata. No conductor generation, factoring, unit-residue or query enumeration, analytic values, transforms, builds or declarations. The window theorem in `audit/LARGE_BRANCH_WINDOW_INTERPOLATION_ROUTE_2026-11-11.md` is a separate, pending source-review dependency. This note does not approve that theorem or certify a sign.

For its fixed h=1, m=256, Delta=5/64 instance, every target in an existing closed positive prefix can be supplied by extending that prefix by exactly 256 positive nodes and constructing the required negative samples from inverse-character positive samples. The saved metadata does not say either set of completed samples has been produced. The new counts below charge the extension as a full conservative superset, independently for each of the four existing extra-node scenarios.

## 1. Exact dependency set, including endpoints

For a saved conductor row, **J is a sample count**, not a last index. In scenario e in {0,167,320,640}, put L=J+e and N_last=L-1. The old positive sample indices are 0,...,N_last. This note covers precisely the closed target interval

    0 <= t <= N_last*Delta.

For k=floor(t/Delta), monotonicity of floor gives 0<=k<=N_last, and theta=t/Delta-k lies in [0,1). The specified 513-term window k-256,...,k+256 is consequently contained in

    {-256,...,-1} union {0,...,N_last+256}.

The new positive indices are L,...,L+255: exactly 256. At the closed right endpoint theta=0 and k=N_last, the upper retained index is N_last+256. Just below that endpoint, k<=N_last-1; no extra node is needed. At zero, k=0 and all indices -256,...,-1 are covered. Thus there is neither an off-grid gap nor a hidden 257th positive guard. We conservatively retain all terms even when an exact sinc factor vanishes at a grid target. Extending the target region to include the new guard endpoint would require another guard extension and is not claimed here.

The actual dependency union for a finite query set is the union of those windows and can be smaller. No query set or sign outcomes are known here. The full-prefix ledger is an upper schedule, not a minimal queried-union count.

The smallest saved J is 5659, so indices 1,...,256 already belong to every old positive prefix, even for e=0. Inverse labels have the same conductor, height and parity. Componentwise inversion sends index k to -k modulo its cyclic-axis length n. A primitive restriction q|n, k mod q nonzero is invariant under this map. Full axes are invariant as well. Consequently the saved primitive output set contains the inverse labels needed for the negative adapter. This is a proof about the existing index convention, not a new enumeration of characters or a claim that the corresponding numerical outputs exist. A production decoder must bind the componentwise inverse map and canonical phases to the exact stored labels.

## 2. Negative samples require an enclosure adapter

Use the actual endpoint-normalized real Y from the window paper, not an elementary sign proxy. Remove its exp(pi*t/4) factor to obtain the completed real H. Conjugation of L and Gamma and inversion of the conductor phase give, with the actual compatible root phases,

    H_chi(-u) = kappa_chi H_(chi inverse)(u),
    Y_chi(-u) = kappa_chi exp(-pi*u/2) Y_(chi inverse)(u),
    kappa_chi in {+1,-1}.

The phase condition is exact: epsilon_chi*epsilon_inverse=kappa_chi under the fixed normalization. It must be established from the canonical phase construction; uncertain phase boxes cannot decide this sign. If a different convention is used, its exact phase adapter must replace this formula. Neither plain conjugation of the stored real Y nor copying the same character's positive ordinate is valid.

For j=1,...,256 let u=j*Delta and E_j=exp(-pi*u/2), so 0<E_j<=1 and u<=20. If |Y_inverse(u)-yhat|<=r, |E_j-ehat|<=rho, and the rounded product has error eta, then the center kappa*round(ehat*yhat) has radius

    (|ehat|+rho)*r + |yhat|*rho + eta.

This includes the cross term once. Sign application is exact only after its discrete phase identity is proved; it still has representation/binding cost. A coarse upper envelope E_j<=1 can be used in the radius, but does not construct its center or a sufficiently accurate enclosure.

The optional complete negative-prefix schedule therefore has 256 shared scalar enclosures, at most one inverse/phase binding per primitive label, and 256*4333246843 = **1109311191808 real scalar transports**. It needs no new character transforms, provided the required positive inverse Y samples are already constructed. Their old raw L outputs do not by themselves supply Y completion. Existing first-256 Y completion, if absent, remains charged separately. Zero is retained as its own sample and is not doubled. Real characters are included without inventing an exact central multiplicity. Both positive channels for nonreal inverse pairs remain in the source/count contract.

Shared scalar certificates can be cached across all conductors and queries only with matching index, Delta, pi enclosure and precision. Cache loading/rebuilding, enclosure arithmetic and proof checking are not free. A lazy negative adapter may construct fewer entries; no such reduction is credited.

## 3. Saved-row fold and checks

The coordinator approved the preflight before execution: read the pinned structural manifest, its summary and the reconciled source receipt; fold at most 125400 saved conductor rows and their axes; no factor/plan reconstruction, units, queries or gates; at most 64 MiB of new output. The completed exclusive-write fold produced 13331137 bytes of compact conductor rows and 23926 bytes of summary, with **2629803 exact assertions**.

For each saved axis (n,q), its existing request vector supplies all five operation categories. The tensor multiplicity is the product of preceding retained axis sizes times the product of following full sizes. This recovers each conductor's per-height operation vector without generating a circuit. Before any extension is credited, the fold verifies all five original operation totals in all four scenarios, all 20 saved phi-weighted band totals, and the reconciled conductor-height, residue and primitive-output totals.

The five bands end at indices 6400,12800,25600,64000,128000. Let B_i(M) count indices of the prefix 0,...,M-1 in band i. Each conductor's exact new band weight is

    d_i(c,e)=B_i(J(c)+e+256)-B_i(J(c)+e).

All d_i are nonnegative and sum to 256. The compact export retains c, J, phi(c), primitive-label count, its five-category per-height vector and its 20 new band weights. Thus every per-conductor increment and band aggregate is reproducible from retained fields alone. No output-by-unit or query distribution is inferred.

## 4. Added runtime work

Each scenario adds the following same total. Scenarios are alternatives; this table is not paid four times for one campaign.

|Category|Added count per scenario|
|---|---:|
|Conductor-height nodes|32102400|
|Residue inputs|1826051899392|
|Primitive positive outputs requiring Y completion|1109311191808|
|General complex products G|31447346864640|
|Complex additions/subtractions|65147327500032|
|Quarter turns|2864071895296|
|Negations|607969280|
|Dyadic scales|2756770021376|
|Cached-kernel products, included in G|2756770021376|
|Root/chirp products, included in G|28690576843264|
|Full P20 residue Horner stages|34694986088448|

Kernel products equal dyadic scales for this original frozen circuit; each Bluestein node has P of each and other node types introduce neither. The scaled-kernel successor is not silently substituted. G_kernel and G_root partition G and must not be added to it again.

The per-band added residue inputs differ substantially:

|Extra nodes|<=500|500..1000|1000..2000|2000..5000|>5000|
|---:|---:|---:|---:|---:|---:|
|0|564514703544|1097723389004|137155304886|25654671390|1003830568|
|167|441822601494|1214642016504|142441357832|26129490506|1016433056|
|320|313100025730|1337816035156|147533256636|26574531838|1028050032|
|640|12309407606|1626114855096|159037538076|27537437838|1052660776|

The receipt contains all five operation categories, primitive outputs and conductor-height counts by band. In particular, individual-conductor guard work is not assigned wholesale to the final source band.

P20/19-stage evaluation is an explicit conservative baseline for these new guards. The later shorter-K and jointly narrowed-grid proofs admitted at the previous actual final height are not automatically extended. Any use of them must check the new endpoint and its full alpha error, or select another already declared-domain-admitted row. The table does not reinterpret degree-19 finite-difference totals or select arithmetic prices. Source center uncertainty, finite-head/residue corrections, c^-s scaling, completed amplitude/phase, intrinsic transform error, and actual sign margins remain separate.

Existing extra nodes e are Turing/auxiliary choices. Here they define the old target prefix; guards are added after that prefix. They are not treated as 256 free samples. If targets were instead restricted to an earlier main prefix, overlap with an auxiliary extension could be credited by a new explicit set difference; that is not this ledger.

## 5. Shared source extension and maximum height

|Extra nodes|Old global sample count|New global sample count|New last index|New last height|
|---:|---:|---:|---:|---:|
|0|84200|84456|84455|422275/64|
|167|84367|84623|84622|211555/32|
|320|84520|84776|84775|423875/64|
|640|84840|85096|85095|425475/64|

Every endpoint is strictly below 7000. This proves compatibility with the existing declared final seed domain, not actual sample availability. It also avoids the overly broad claim that every target up to 7000 is admitted with these same stored guards.

Only the shared global source prefix grows by 256 heights, all in its final band. The first four shared prefixes remain unchanged even though individual conductors consume additional values in those bands. The current reconciled final source is D_source=4096, N=1500, m=159, P28 at every coarse endpoint, followed by three shifts per interval to the fine grid with D_output=8192. It is not the obsolete P27/N3387 final source.

The additional shared source work, once per scenario, is:

|Category|Added count|
|---|---:|
|Source coefficient slots|29367296|
|Head reciprocal scales|42477696000|
|Head accumulator additions|44050944000|
|Contracting E stages|360798208|
|Bernoulli weighted terms|4669400064|
|Bernoulli accumulator additions|4669400064|
|Source translation updates|1101004800|
|P20 fine-anchor coefficient deliveries|83891200|
|Final coefficient power-of-two scales|83891200|
|Final coefficient rounds|83891200|
|Shared rising-factorial recurrence steps|6912|
|Coarse endpoint instances|1048832|
|Fine-state updates|1573912832|
|State-to-EM grid conversions|1573912832|

The active final rational-argument set has 6148097 entries, a subset of the existing 7049217-argument union. No new argument grid, initial B certificate or step-cis certificate is required by this extension. Their existing precision and recurrence-length proof must still cover the extended prefix; 85096 remains below the retained 128000/131072 conservative recurrence caps, and the declared V7000 source proof is retained. This is reuse of a compatible schedule, not evidence those elementary values or state caches have been generated. A discarded cache may require reconstruction.

Each new source slot still needs the endpoint assembly and rational factors in the source producer; these are not fully priced by a slot count. Transform setup dimensions and source/Bernoulli setup remain unchanged but are not erased from end-to-end costs. Both generations and proof/checker cache lifetimes must be explicit.

## 6. Completed samples and interpolation remain separate

For each new positive primitive output, the complete error contract still requires an actual Y enclosure. The alpha contribution is already character-scaled and must not be counted twice. Root/kernel errors proved inside the intrinsic transform bound are likewise not added a second time. Completion to Y pays its amplitude, canonical phase and arithmetic errors. The added positive primitive-output count is an exact count of these required instances, not a complete elementary-operation price.

For a queried target, the conditional window radius is

    T_F+T_S+e_acc
      +sum_513 [(|Khat_n|+rK_n)*rY_n + |Yhat_n|*rK_n].

The baseline has T_F<2^-46 and T_S<2^-243. It does not promise a 2^-82 total error or any successful sign. A direct implementation pays 513 real products and 512 summation additions, their rounding/range proofs, plus kernel generation/enclosures. Kernels may share the same fractional offset, Delta and h; Gaussian and sinc values, limiting sinc(0), storage and binding still need proofs. A convolution or another arithmetic schedule requires its own checked identity/error bound. The number of targets, repair attempts and actual guard union is not determined by conductor/height metadata, so no aggregate query cost is asserted.

The negative adapter, positive completion, source production, transform/evaluation work and per-query interpolation are separate components. None supplies Turing success, central multiplicities, exact closed counts or a guarantee that every grid interval brackets a zero. A future smaller-window theorem must replace the dependency set and counts explicitly; it does not mutate this m256 ledger.

## 7. Frozen artifacts and acceptance boundary

|Artifact|SHA256|
|---|---|
|`sample_guard_ledger_20261111.py`|`336F1F606E7DAFA330EDC1372B3FE02668A173DD9EB61F580D5372A944F64A7E`|
|`sample_guard_ledger_20261111.json`|`F27D196EB8C8DFCC13694AE8E5CA9B03783BBA3034AEBA740E3FEFFB13B2F1E0`|
|`sample_guard_conductor_rows_20261111.json`|`1D619640BF0917DAE96F521945D6EB54705967776B8A139A6C60F61AD21AC55F`|

All eight source/report hashes are recorded in the receipt. In particular it binds structural manifest A41D70DB, independent structural review2D5CE1CD, reconciled source receipt0E83C9AB, interpolation authorDA67CB3B, and complete-error author/review96063365/F6F38CBF. The script never imports an earlier writer and writes only these new owned outputs. Independent review of this fold and of the separate window theorem remains required before adopting the conditional schedule. No numerical or kernel-validity claim follows from these exact metadata checks.
