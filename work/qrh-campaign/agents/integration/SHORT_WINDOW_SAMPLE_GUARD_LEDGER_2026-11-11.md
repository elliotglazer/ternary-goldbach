# Matched sample-guard ledger for the 83-term window

2026-11-11. Saved-metadata and paper research only. This immutable successor preserves the m256 artifacts. No conductor generation, factoring, unit or query enumeration, roots, function values, transforms, builds or declarations were performed.

The independently reviewed candidate h=159/500,m=41 permits a conditional +41 positive-prefix guard schedule. On the same P20 evaluation, source-production and original-transform assumptions as the +256 baseline, it removes 215 guard heights per conductor and 215 shared final-band source heights. This is a matched operation-count reduction, not a total-cost or runtime winner. The new h-dependent kernels, arithmetic error and actual sign success remain separate.

## 1. Mathematical inputs and exact coverage

The shorter-window author is `audit/SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md`, SHA `32ED0BD63C247134910FAE3BE124880EF7548422368230B59EF0F52E39FFB96E`. Its independent review is `major-constants/REVIEW_SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md`, SHA `61FA9D6594264FBA3EF26AA60157CDB22C5FFD66EB52AEE0DB16C19267E5A730`. For the actual endpoint-normalized Y, primitive nonprincipal c<=265800 and 0<=t0<=7000, it proves the total analytic tail is less than

    (927193523/1000000000)*2^-46 < 2^-46.

Only this analytic component can be substituted for the old allowance. Sample and finite-arithmetic errors are not included in it. This ledger consumes the reviewed result and the selected exact receipt row; it does not rerun the analytic parameter search.

Keep J as sample count, e in {0,167,320,640}, L=J+e and N_last=L-1. Targets remain the **old** closed interval [0,N_last*Delta], Delta=5/64. For k=floor(t/Delta), 0<=k<=N_last and theta=t/Delta-k belongs to [0,1). Therefore the exact retained indices k-41,...,k+41 lie in [-41,N_last+41]. Supply positive indices 0,...,N_last+41 and negative indices -41,...,-1. New positive indices are precisely L,...,L+40: 41 samples.

At the closed top endpoint k=N_last, so +41 suffices. Just below it k<=N_last-1; at zero k=0. The source paper's conservative distance bound 42*Delta does not require a 42nd positive grid guard. The exact negative extent is 41*Delta=205/64. Zero remains its own sample, and the target interval is not recursively enlarged to the new guard endpoint.

This is a full-prefix dependency superset. For a concrete target set, use the union of its exact windows; no such query set is known here. The 41-node guard set is a subset of the old 256-node set for each unchanged target interval. Existing auxiliary/Turing nodes e define the old target region and are not credited as free guards. A different target region or overlap claim needs an explicit new set difference.

## 2. Inverse-character negative adapter

The reviewed m256 coverage note proves that the saved primitive index restrictions are invariant under componentwise inversion. Both characters in an inverse pair use the same conductor and positive-height prefix. The minimum saved J is 5659, so positive indices 1,...,41 already lie in every prefix. This is a dependency statement, not evidence that completed Y samples are present.

With the exact compatible canonical root phases,

    Y_chi(-u)=kappa_chi*exp(-pi*u/2)*Y_(chi inverse)(u),
    kappa_chi in {+1,-1}.

The phase sign requires its exact binding; it cannot be selected from an uncertain phase box. If the positive inverse sample has center yhat and radius r, the attenuation center ehat has radius rho, and the product rounding error is eta, a valid negative radius is

    (|ehat|+rho)*r + |yhat|*rho + eta.

This includes the cross term once. The optional full materialization has **41 shared attenuation scalar enclosures** and **177663120563 real scalar transports**. Compared with m256 this removes 215 scalar enclosures and 931648071245 transports. Inverse-label/phase bindings are reusable per label with their proof/cache costs retained. No extra character transform is needed for these negative samples; absent positive Y completion is still required. Central multiplicities, two-channel count conventions and root-phase construction remain unchanged.

The attenuation values for indices 1,...,41 coincide with a subset of the old negative adapter because Delta is unchanged. This potential exact reuse does not apply to the interpolation Gaussian kernel: h changes there. No existing numerical cache is assumed.

## 3. Bounded saved-row fold

The preflight uses the same 125400 saved conductor rows, request-total vectors and five-band boundary indices as the accepted structural manifest. It permits no factoring, new circuit choice, unit enumeration, target enumeration or per-gate output. The new script verifies all original five-category/four-scenario totals and all 20 unit-band weights before calculating the extension.

For prefix-count band function B_i, the exact added weight is

    d_i(c,e)=B_i(J(c)+e+41)-B_i(J(c)+e).

Each row has nonnegative weights summing to 41. The script retains c,J,phi,primitive count, its saved-derived per-height operation vector and all 20 new band weights. It also computes the difference from each frozen m256 band vector. The fold records **2629933 exact checks**, a 12794207-byte compact row file and a 41665-byte summary, below the stated 64 MiB cap. No old writer was imported or executed. Before freeze, an inherited unpriced-text label was corrected from 513 to 83 in the script and receipt; the numeric stencil fields and all computed counts were already correct.

## 4. Matched runtime schedules

Let O_e be the full unchanged original scenario vector, and V the saved sum of per-conductor per-height vectors. Then the old and new conditional schedules are exactly

    old = O_e + 256 V,
    new = O_e + 41 V,
    old - new = 215 V.

The following table gives the extension and its reduction. It applies independently to each scenario; the four scenarios are alternatives.

|Category|New +41 extension|Reduction from +256|
|---|---:|---:|
|Conductor-height nodes|5141400|26961000|
|Residue inputs|292453624512|1533598274880|
|Primitive positive outputs requiring Y completion|177663120563|931648071245|
|General complex products G|5036489146290|26410857718350|
|Complex additions/subtractions|10433751669927|54713575830105|
|Quarter turns|458699014481|2405372880815|
|Negations|97370080|510599200|
|Dyadic scales|441513948736|2315256072640|
|Kernel products, included in G|441513948736|2315256072640|
|Root/chirp products, included in G|4594975197554|24095601645710|
|Full P20 Horner stages|5556618865728|29138367222720|

The original circuit and its root/kernel partition are unchanged. The scaled-cache Bluestein successor and alternative arithmetic prices are not silently selected. The receipt contains O_e, each extension, and all five-category matched differences, so the comparison includes the full retained baseline rather than treating either extension as a whole campaign.

Band allocations are not a uniform 41/256 rescaling of the old allocations: shorter guards can avoid crossing a boundary. Added residue inputs are:

|Extra nodes|<=500|500..1000|1000..2000|2000..5000|>5000|
|---:|---:|---:|---:|---:|---:|
|0|101875674550|164914985756|21443027046|4060427332|159509828|
|167|83947852012|181948833086|22259730538|4135724988|161483888|
|320|65147782876|199887407156|23049266158|4205848530|163319792|
|640|7653529894|255446979582|24827808206|4358010794|167296036|

The complete band vectors and their exact m256 differences are retained. All new guard residue evaluations are priced with the same full P20/19-stage baseline as the old guard ledger. No existing actual-height K18/b94 admission is extended. A declared-domain K19 row or a fresh endpoint-checked K18 row can be compared later, but would require matching evaluator assumptions on both schedules. No degree-19 FD inventory is reinterpreted here.

## 5. Shared source production and declared domain

|Extra nodes|Old global count|New global count|New last index|New last height|
|---:|---:|---:|---:|---:|
|0|84200|84241|84240|26325/4|
|167|84367|84408|84407|422035/64|
|320|84520|84561|84560|26425/4|
|640|84840|84881|84880|26525/4|

The largest is 6631.25<7000. It exceeds the previous actual final height 424195/64, even though it is smaller than the m256 guard endpoint. The declared V7000 source proof covers it, while that older actual-domain K18 proof is not automatically applicable.

Only the global shared source prefix grows by 41 final-band heights. Individual-conductor runtime guards may occupy any band, but their lower-band shared source arrays are already within the unchanged global prefixes. The current final source is D_source4096,N1500,m159,P28, with fine D_output8192 and P20 deliveries. Keeping this exact source recipe yields:

|Category|New +41 extension|Reduction from +256|
|---|---:|---:|
|Source coefficient slots|4703356|24663940|
|Head reciprocal scales|6803068500|35674627500|
|Head accumulator additions|7055034000|36995910000|
|Contracting E stages|57784088|303014120|
|Bernoulli weighted terms|747833604|3921566460|
|Bernoulli accumulator additions|747833604|3921566460|
|Translation updates|176332800|924672000|
|P20 fine coefficient deliveries|13435700|70455500|
|Final coefficient power-of-two scales|13435700|70455500|
|Final coefficient rounds|13435700|70455500|
|Shared rising-factorial steps|1107|5805|
|Coarse endpoint instances|167977|880855|
|Fine-state updates|252071977|1321840855|
|State-to-EM grid conversions|252071977|1321840855|

The final active rational arguments remain 6148097, within the same 7049217 union. No new initial B, step-cis, argument-grid or transform-dimension setup is introduced. Existing setup, endpoint assemblies, rational divisions, cache rebuilding and source proof work remain paid. The extended index stays below the inherited recurrence-length caps. Compatibility with those bounds supplies no actual source values or guard samples.

## 6. Complete-cost comparison and remaining conditions

For Q actual queries, the direct m41 finite sum uses 83 real products and 82 accumulation additions per query, versus 513 and 512. The count difference is 430Q of each. No Q is inferred from zero counts, grid outputs or conductor metadata. A different arithmetic implementation needs its own checked schedule.

The new kernel is

    exp(-(n*Delta-t0)^2/(2*(159/500)^2))
      *sinc(pi*(n-t0/Delta)).

Its enclosures, precision, generation/proof/checking cost and cache key differ from the old h1 kernel. The complete radius remains the new analytic tail plus

    e_acc + sum_83[(|Khat_n|+rK_n)*rY_n + |Yhat_n|*rK_n].

Actual source, transform, c^-s, amplitude and canonical-phase errors enter rY once. The smaller number of terms does not prove a smaller weighted sample-error sum or reuse old sign centers. Query kernels can share matching fractional offsets and precision with explicit cache binding. Strict signs, repairs, count/Turing closure and central data remain separate.

A full matched cost expression is the unchanged original/setup cost plus the runtime extension, shared source extension, positive-Y completion, negative adapter, and Q-dependent kernel/interpolation work. Only the first four operation-instance changes and the direct-stencil counts are determined here. Generation, ordinary proof construction and checking have separate width-sensitive prices. The h-dependent kernel and precision costs can change, so the count reductions do not by themselves establish a cheaper complete run. Existing actual queried unions, if later supplied, could remove further work but are not credited.

## 7. Frozen evidence

|Artifact|SHA256|
|---|---|
|`short_window_guard_ledger_20261111.py`|`61B98033E06FD6B982FB762EBB1DFF44CC08151AD9E70FB9B86B51EC123CFE2D`|
|`short_window_guard_ledger_20261111.json`|`C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4`|
|`short_window_guard_conductor_rows_20261111.json`|`A75E4EE6EBBBD5BA82AA91377040228140596989E03667148B55900F53ADE3EA`|

The receipt binds all predecessor inputs and the shorter-window independent review. The immutable m256 author8D358690 and receiptF27D196E were independently accepted in `zero-sum/REVIEW_LARGE_INTERPOLATION_SAMPLE_GUARD_LEDGER_2026-11-11.md`, SHA `412F441652C40B0C3B8F031EF8260947AFB4614FA1C7F51CEACC5B5780B735C7`. This successor awaits its own saved-row/coverage review. Neither review is a numerical execution, Lean/MM0 implementation or kernel-validity claim.
