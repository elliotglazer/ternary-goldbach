# Review of the matched 83-term sample guards

2026-11-11. PASS at conditional paper-composition and saved-metadata scope. No correction remains. The m41 successor compares complete matched guard schedules against m256, keeps all four scenarios separate and charges source production independently of conductor transforms. It does not establish useful sign precision, an actual query set or a runtime winner.

The frozen author `integration/SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md` has SHA256 `3E447AE8E8EEEC847E95CFB7473879EB2B56CFC5E467863404D3ECDBB0180606`. Its script, summary and compact rows have hashes `61B98033E06FD6B982FB762EBB1DFF44CC08151AD9E70FB9B86B51EC123CFE2D`, `C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4` and `A75E4EE6EBBBD5BA82AA91377040228140596989E03667148B55900F53ADE3EA`. Paths below are relative to `work/qrh-campaign/agents`.

I read the full report and script, the shorter-window source `32ED0BD63C247134910FAE3BE124880EF7548422368230B59EF0F52E39FFB96E`, and its independent analytic review `61FA9D6594264FBA3EF26AA60157CDB22C5FFD66EB52AEE0DB16C19267E5A730`. The prior m256 ledger and my review `412F441652C40B0C3B8F031EF8260947AFB4614FA1C7F51CEACC5B5780B735C7` remain unchanged. I consume the reviewed analytic theorem rather than rerunning its parameter search or re-auditing the primary Fourier/Gamma estimates.

## Exact theorem and dependency substitution

The selected pair is exactly h=159/500,m=41, with Delta=5/64. The saved analytic row and its independent review give

    T_F+T_S < (927193523/10^9)*2^-46 < 2^-46

for the same primitive nonprincipal endpoint-normalized Y, c<=265800 and target 0<=t0<=7000. This is a substitution of the analytic-tail part only. It does not supply sample radii, numerical kernels, accumulation error or signs. In particular it is not a full 2^-82 contract.

For each manifest row J is a count. In scenario e, put L=J+e and N_last=L-1. The unchanged closed target interval is [0,N_last Delta]. Its target floor k satisfies 0<=k<=N_last, including zero, exact grid points and arbitrary off-grid points. The m41 stencil is k-41 through k+41. Hence the complete positive prefix ends at N_last+41 and the negative part ends at -41. The exact new positive indices are L through L+40, not through L+41.

The conservative real-distance estimate 42Delta in the analytic source does not require a 42nd positive grid node. At the top grid endpoint k=N_last; strictly below it k<=N_last-1. At zero k=0. These facts establish coverage without enumerating queries. An implementation must bind the exact target and floor/offset witnesses, rather than rely on an unverified floating floor. The target interval does not expand to the new guard endpoint.

For the same target interval the short positive guard [L,L+40] is a subset of the long guard [L,L+255]. The deleted interval is exactly [L+41,L+255], length215. Negative index dependencies are similarly reduced from -256..-1 to -41..-1. Auxiliary e nodes continue to define the old scenario target interval; they are not silently credited as free additional guards. The four scenarios are alternatives, not cumulative work.

## Negative samples and changed kernels

The original primitive-label set is closed under componentwise inversion, with the same conductor, parity and height profile. Every saved J exceeds256, so all positive inverse samples required by either adapter are already part of the original schedule. Their numerical completion is not thereby proved available.

The unchanged exact identity is

    Y_chi(-u)=kappa_chi exp(-pi*u/2)Y_inverse(u),
    kappa_chi=epsilon_chi*epsilon_inverse in {+1,-1}.

It requires the same actual character map and compatible fixed phases as the accepted normalization. A discrete phase sign must be proved; approximate boxes without that identity are not a substitute. Negative sample error remains `(|ehat|+rho)r+|yhat|rho+eta`. This follows by splitting the exact product and charges the input/coefficient cross term once.

For m41 the maximum negative magnitude is205/64 and the optional full adapter uses41 attenuation objects and177663120563 real scalar transports. It removes215 attenuation objects and931648071245 transports relative to m256. Inverse-label/phase bindings remain per label; per-use transport and cache costs remain. Zero is its own sample and contributes no new central-count assertion. A nonreal character's positive channel cannot be replaced by its inverse at the same positive height.

The first41 attenuation values are an exact subset of the old adapter because Delta and their formula are unchanged. The interpolation kernel is not unchanged: the Gaussian now has h=159/500. Its cache key, enclosures, finite-sum arithmetic and weighted sample-error bound must be recomputed for that h. The smaller analytic tail or sample count alone does not justify copying old centers, widths, numerical margins or arithmetic tolerances.

## Independent matched metadata fold

The preflight retained the same saved125400 conductor rows and reviewed request vectors. I did not regenerate conductors, factors, axes, units, circuits, queries or numerical values. I independently formed each axis invocation count from products of retained sizes before the axis and full sizes after it. This reproduces each saved per-height five-category operation vector.

For every conductor/scenario I intersected four intervals with each band: the original prefix [0,L-1], short guard [L,L+40], long guard [L,L+255], and deleted interval [L+41,L+255]. In particular the deleted-band fold was computed directly, not accepted merely because two aggregate totals subtract correctly. All per-row old/new/deleted weights and both compact row files match. Original five-category scenario totals and all20 original unit-band totals also reconcile before comparison.

The matched extension/reduction totals are:

|Category|m41 extension|m256 minus m41|
|---|---:|---:|
|Conductor-height nodes|5141400|26961000|
|Residue inputs|292453624512|1533598274880|
|Primitive positive outputs|177663120563|931648071245|
|General complex products|5036489146290|26410857718350|
|Complex additions/subtractions|10433751669927|54713575830105|
|Quarter turns|458699014481|2405372880815|
|Negations|97370080|510599200|
|Dyadic scales|441513948736|2315256072640|
|Full P20 Horner stages|5556618865728|29138367222720|

The original scenario vector O_e is identical in both schedules, so the comparison is O_e+41V against O_e+256V, not an extension-only total presented as a campaign total. All20 band vectors and20 deleted-band vectors match. Although total extensions have ratio41/256, their band allocations generally do not because the shorter interval can avoid a boundary crossing.

Kernel products and root/chirp products partition G under the same frozen unnormalized circuit; kernel products equal the dyadic-scale count. Neither partition is added to G again. The normalized-cache successor is not adopted here. The matched residue baseline is full P20 with19 Horner stages per input on both sides. This does not convert the counts into a comparison of unrelated narrowed or finite-difference evaluators.

## Source work and actual height cap

The new global sample counts84241,84408,84561,84881 have last indices84240,84407,84560,84880. Their heights are26325/4,422035/64,26425/4,26525/4. Thus the maximum is6631.25, below7000, but above the former424195/64 maximum. The paper correctly refuses to reuse the narrower actual-domain K18/b94 admission without a new full alpha proof.

The shared source prefix adds41 final-band heights. This is distinct from the per-conductor guards, which occupy multiple bands. I reconstructed every source field independently from D4096,N1500,P28,m159,4097 endpoints and the three350-update shifts per interval. All nineteen new source fields and all nineteen matched differences agree. Examples are4703356 new source coefficients versus24663940 removed,57784088 new E stages versus303014120 removed, and176332800 new translation updates versus924672000 removed. Scales, accumulator additions, final scales/rounds and recurrence updates remain separately typed.

The final active argument set still has6148097 entries inside the existing7049217 union. Thus41 new heights require252071977 state updates and the same number of state-to-EM conversions. The removed215 heights account for1321840855 of each. No initial B or step certificate is subtracted as though these already-live states had just been initialized. The previously retired arguments are not reintroduced.

The declared V7000,m159 source theorem and inherited recurrence caps cover the new endpoints. Setup dimensions, argument union and source constants are unchanged, but their original production costs remain in the full bill. Rebuilding evicted caches is still work. Source compatibility is not sample availability, and source coefficient slots do not fully price endpoint divisions, factors or ordinary proof construction.

## Complete-error and cost limits

The direct m41 stencil uses83 real kernel products and82 additions per target, versus513 and512. The difference430 of each is correct for that stated direct schedule. No number Q of actual targets is inferred, and no aggregate430Q saving is credited without such a query set. A convolution or another summation circuit needs its own identity, error and price model.

The full radius remains the reviewed analytic bound plus accumulation error and the83-term weighted sample/kernel error sum. A_alpha contains its source/translation/evaluation terms once. Head, transform, conductor scaling, actual Y completion and phase errors remain in each sample radius; kernel generation and numerical uncertainty remain separate. There is no guarantee that fewer terms make the whole radius smaller or that a sign succeeds. Central zeros, strict brackets, canonical Turing integrals and closed count surplus remain independent requirements.

During preflight I identified an inherited unpriced-description string that still referred to513 terms. The author corrected it to83 before final freeze, without changing the numeric fields. The reviewed final receipt has the correct selected-stencil description and retains513 only in the explicit comparator.

The result is a conditional reduction of matched operation-instance counts. It does not choose arithmetic widths or prices, presume an existing numerical cache, certify the actual query union, prove a cheaper total run or alter the mathematical RH consumer.

## Independent evidence

Owned `zero-sum/review_short_window_guard_ledger_20261111.py` has SHA256 `3951F71AA58B247E9CFDCC956822949B3B9B8E64607332BF6163B4562923CC4C`. Its exclusive receipt has SHA256 `BD21A457122DB6A32A83541A9136A4DD467A1B764823AA813F2A626B048176CB`.

All3511300 checks pass. The receipt binds the final author artifacts, prior compact rows/review and all13 author input pins. It records independent matched scenario totals, source multiplicities and exact endpoints. The checker executed no author program or analytic parameter search and evaluated no root, character, transform, L-function, zero or prime. No builds, declarations or frozen-file changes occurred.
