# Selected P27 seed work on the reduced height prefix

2026-11-11. Exact small metadata supplement. No function, character, zero, prime or transform values were evaluated and no build was run. The preceding reduced-plus-height inventory remains frozen, including its P24 alternative. This supplement uses the current selected P27-to-P20 scaled-seed scheme and the accepted high-precision height recurrence.

The old selected P27 totals are reproduced exactly before substituting the shorter global prefix. All initial log/amplitude/base/step setup remains: the highest band is still used and the rational argument union does not shrink. Only height-dependent work is reduced. Neither auxiliary sign success nor an end-to-end runtime reduction is asserted.

## 1. Exact per-band ledger

For one band, let H be its number of common height nodes, D its old coarse alpha denominator, and N its old EM head length. At every height, D coarse anchors require27 coefficients and the endpoint alpha=1 requires only20. Thus K=27D+20 independent source coefficients are needed. The selected source circuit gives:

| Category | Exact band count |
|---|---:|
|Independent P27 source coefficient slots|H K|
|Head reciprocal real-times-complex scales|H N(26D+19)|
|Head complex accumulator additions|H N K|
|Contracting complex E recurrence stages|H(153D+146)|
|Bernoulli weighted terms|64 H K|
|Bernoulli accumulator additions|64 H K|
|P27-to-P20 midpoint-shift updates|330 H D|
|Final P20 fine-anchor coefficient deliveries|20 H(2D+1)|
|Shared height R recurrence stages|26 H|

The E counts are P+2m-2 with m=64:153 at each P27 anchor and146 at the endpoint P20 anchor. All64 signed Bernoulli corrections are retained. Their exact rational constants are shared setup, not64 new special-function calls per coefficient. The shift count330 is the reviewed pruned Pascal schedule to retain20 outputs from27 inputs; the original D normalization is retained at the midpoint. Final fine-anchor deliveries are outputs, not an additional independent EM computation.

Head postmultiplication, endpoint component assembly, final coefficient rounding/export, rational factors and their proof witnesses remain additional work proportional to these anchor/coefficient counts. The table does not assign them zero cost or identify all listed operations with equal-time instructions.

The unchanged (V,D,N) bands are (500,512,220), (1000,1024,387), (2000,2048,720), (5000,4096,1720), and (10000,8192,3387). Their old height counts are6401,6400,12800,38400,63988. New main counts replace only the last by38144; +640 replaces it by38784. The prior inventory gives +167 and +320, which the receipt also includes.

## 2. Baseline reconciliation and new totals

Every old total below matches the selected root/shared-EM cost exactly. The arithmetic script asserts these identities, including the old recurrence receipt. This prevents comparing P24's old slots with P27's new slots.

| Category | Old selected P27 | New main P27 | New main +640 nodes |
|---|---:|---:|---:|
|Source coefficient slots|19375637796|13658841620|13800412180|
|Head reciprocal scales|53776084584136|35130458950228|35592198634708|
|Head accumulator additions|55844475188704|36481686540592|36961186027312|
|E recurrence stages|109799461818|77403439250|78205693330|
|Bernoulli weighted terms|1240040818944|874165863680|883226379520|
|Bernoulli accumulator additions|1240040818944|874165863680|883226379520|
|P27-to-P20 midpoint updates|236782064640|166916428800|168646579200|
|P20 fine-anchor deliveries|28703416100|20234337300|20444065300|
|Shared R recurrence stages|3327714|2655770|2672410|
|Coarse anchor instances|717649397|505909505|511153025|

The residue P20 contraction and character FFT costs are deliberately not included here: they depend on each conductor's requested heights rather than only the global seed prefix, and were counted in the preceding inventory. This table is shared work, charged once across conductors.

## 3. High-precision height recurrence, initialization and conversions

At each height the base arguments are x=1+j/D for 0<=j<=(N+1)D, including endpoints. Their number is X=(N+1)D+1. The five sets are nested because D divides the next D and N increases. If I new arguments are introduced at a band's first height, then that band has H X-I recurrence updates and I initializations. Existing arguments are updated at the first height of the new band; only new arguments are initialized there.

Every schedule below reaches the fifth band. The introduction times of every argument are unchanged; all newly omitted heights are at the end of that band. Therefore the unique argument count and every initialization/step count remain27754497. Summing updates gives total height/argument pairs minus that count.

| Category | Old selected schedule | New main | New main +640 |
|---|---:|---:|---:|
|Initial B certificates|27754497|27754497|27754497|
|Step cis certificates|27754497|27754497|27754497|
|Step-grid conversions|27754497|27754497|27754497|
|Height/argument pairs|2068812377589|1351525157121|1369288035201|
|Fine-state complex recurrence updates|2068784623092|1351497402624|1369260280704|
|Separate state-to-EM-grid conversions|2068812377589|1351525157121|1369288035201|

The state-to-EM conversion is performed on a copy. Feeding that rounded copy back into the height recurrence is excluded. Retain the selected log error2^-144, initial base error2^-120, step/update error2^-140 and EM-grid conversion error2^-122. The existing proof bounds error over128000 updates; the new last indices102144 and102784 are smaller, so no precision retuning is needed. Fewer updates do not by themselves justify weaker primitive certificates.

The log-anchor setup still has582822471 nonanchor degree21 Horner stages, plus its unchanged anchor certificates and assembly. The old p120 initialization uses74 cis terms and the p138 step uses83 terms per general argument under their existing source bounds; any exact-zero special case would need a separately counted optimization. The dense state-and-step raw array budget remains1998323784 bytes before all other storage, alignment and proof overhead. This is not a Lean/MM0 memory prediction.

## 4. Scope of reuse and acceptance

The largest new auxiliary height is8030, within the old V10000 source domain. All N/D choices and x<=3389 stay unchanged. Hence the accepted scaled-EM, shift, elementary and height-recurrence error contracts apply to the same exact objects at this shorter prefix. This is a source-domain implication, not evidence that the objects have already been evaluated or checked.

Some individual conductor auxiliary outputs extend beyond that conductor's original grid. They still require their residue contractions, character transforms, error proofs and sign/count checks. Their required Hurwitz seeds belong to the shared global prefix, but existence of a shared seed schedule is not existence of the individual L-values or a completed spectral certificate.

All comparisons remain conditional on the reduced plus/base/star height union and actual finite-RH certificates. This supplement supplies no such data and does not alter the principal or small-conductor branches.

## Pins and reproducibility

The new script is integer arithmetic over the pinned band receipt, plus exact rational ratios. It performs no large conductor enumeration and refuses to overwrite its result. Run it with the existing interval-environment Python in a separate replay location when preserving the frozen result.

| File | SHA256 |
|---|---|
|work/qrh-blueprint/SELECTED_SCALED_SEED_ORDER_2026-11-11.md|579AAEC28BD4C1DB8FB83F3CDB1E4782160D3D35FA8AB2B8DC83BFF956ACBCD1|
|work/qrh-blueprint/SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md|8ABDD8A1F991AF9FEACE49908E5BA865EC3FD5804311CAE73AB9D80A4456D413|
|work/qrh-blueprint/scaled_height_recurrence_20261111.json|10058EA331D8FC143981F3DA1AC5BA92AEEEF03553849A2E4666CA0783462F02|
|integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md|1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E|
|zero-sum/reduced_plus_height_inventory_20261111.json|E4876ACF3F57D800118D328B56261149BC66B3A15F2272BDD370D88ECD986791|
|zero-sum/reduced_prefix_selected_p27_20261111.py|5399F8E2498E14F5CCD8516F1967F87A0DAEC969F46C6909BA4E24242BD6A23B|
|zero-sum/reduced_prefix_selected_p27_20261111.json|B8227C3C7A9F46947BB765C8D1B9A70359A3CBE4C7B96CC0A962B7E27560A38A|

Agent paths are relative to `work/qrh-campaign/agents/`; root paths are displayed in full workspace-relative form. The selected order and recurrence notes bind the previously reviewed scaled arithmetic and shift/elementary contracts.
