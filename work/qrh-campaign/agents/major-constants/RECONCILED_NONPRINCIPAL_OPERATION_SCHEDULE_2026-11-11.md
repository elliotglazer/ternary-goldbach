# Reconciled nonprincipal operation schedule

2026-11-11. This ledger joins the accepted m159 final shared seed with the existing combined-height large-family inventory and the reviewed whole-small-family theta inventory. It gives four matched requested-node scenarios and keeps the two small-family algorithms separate. It is a cost input, not a runtime forecast, a completed finite-RH certificate or a complete priced proof budget.

No spectral, theta, Hurwitz, prime or elementary-function values were computed. No inventory generator, Lean build or evaluator was run. The companion script reads frozen count receipts, checks their hashes and reconstructs the changed finite arithmetic counts. Earlier frozen artifacts remain unchanged.

## 1. Disjoint family and scenario boundaries

The large branch contains125400 admissible primitive nonprincipal conductors c>10000, with odd c<=132900 or4|c<=265800,4333246843 primitive labels and7133015232 unit-residue inputs per full height layer. The small branch contains7499 conductors c<=10000 and18477108 primitive labels. Both use the same reviewed combined odd/even height profile. They are disjoint; together they have132899 conductors and4351723951 primitive labels. Principal conductor1 is excluded and remains a separate required computation.

Scenario keys e=0,167,320,640 add that many5/64-grid nodes to each conductor's rounded main target. They do not assert that a Turing guard succeeds. Large shared-seed prefix lengths are84200,84367,84520,84840. Their final-band lengths are20199,20366,20519,20839, after the unchanged64001 earlier nodes. The final global heights are420995/64,210915/32,422595/64,424195/64, all below7000.

Small conductors have their own much larger per-conductor prefixes; they do not inherit the large shared-seed global length. The theta receipt includes the exact grid ceiling and the same e in every row. It retains both character parities and inverse-character channels. No small-conductor channel is removed by the large-branch seed change.

Only cardinalities in identical units are added. Total requested primitive outputs across the disjoint branches are:

| Extra nodes | Large outputs | Small outputs, either theta | Combined requested outputs |
|---:|---:|---:|---:|
|0|36290898519503|1775431871117|38066330390620|
|167|37014550742284|1778517548153|38793068290437|
|320|37677537509263|1781344545677|39458882054940|
|640|39064176499023|1787257220237|40851433719260|

These are requested values, not certified strict signs. The ledger has no arithmetic grand-total field.

## 2. Replace only the fifth large seed band

The predecessor is combined_retuned_seed_20261111.json, which already combines current heights with the V7000 retune. Its first four bands remain byte-for-byte equivalent in counts:

| V | D | N | Heights | Orders and corrections |
|---:|---:|---:|---:|---|
|500|512|220|6401|P27, right endpoint P20, m64|
|1000|1024|387|6400|P27, right endpoint P20, m64|
|2000|2048|720|12800|P27, right endpoint P20, m64|
|5000|4096|1720|38400|P27, right endpoint P20, m64|

The fifth band changes from D8192,N2387,m64,P27 with a P20 endpoint to D_source4096,N1500,m159,P28 at every source endpoint. Its output normalization remains8192, with P20 at fine anchors of denominator16384. The accepted m159 proof supplies the actual finite EM remainder below2^-116; the joint proof supplies source error below.107 eta, delivered numerical coefficient error below.557 eta, and total isolated-alpha error below.16*2^-82. The separate analytic translation bias remains separate from the coefficient's numerical eta radius.

At D=4096,P=28,m=159 and H final heights, set K=P(D+1)=114716. The replacement counts per height are:

| Category | Formula | Count |
|---|---|---:|
|Source coefficient slots|K|114716|
|Head reciprocal scales|1500*27*(D+1)|165928500|
|Head additions|1500*K|172074000|
|Bernoulli scales|159*K|18239844|
|Bernoulli additions|159*K|18239844|
|E recurrence stages|(28+318-2)*(D+1)|1409368|
|Translation updates|3D*350|4300800|
|Final power-of-two scales|20*(4D+1)|327700|
|Final rounding gates|20*(4D+1)|327700|
|Shared R stages|27|27|
|Coarse endpoint instances|D+1|4097|

The E sequence ends at index344. The new gamma setup has159 constants through Bernoulli index318,95 more than m64. The D4096 lambda table has28 entries and adds one entry beyond the earlier P27 table. These are setup requirements, not unpriced constants imported from a stronger numerical oracle.

For every old category the script verifies

    new total = predecessor total - predecessor fifth band + replacement fifth band.

It adds the final scaling and rounding categories, which were zero in the earlier four bands. It renames the old P27-specific field names to source_coefficients and source_translation_updates; their meaning now includes both P27 and P28 bands. The complete new five-band totals are:

| Extra nodes | Head scales | Head additions | Bernoulli scales, and separately additions | E stages | Translation updates |
|---:|---:|---:|---:|---:|---:|
|0|10962363526720|11379239858080|702585728572|58056920314|150671324160|
|167|10990073586220|11407976216080|705631782520|58292284770|151389557760|
|320|11015460646720|11434303538080|708422478652|58507918074|152047580160|
|640|11068557766720|11489367218080|714259228732|58958915834|153423836160|

| Extra nodes | Source coefficients | Fine-state updates | State-to-EM copies | New final scales, and separately rounds |
|---:|---:|---:|---:|---:|
|0|7538384728|417035985639|417043034856|6619212300|
|167|7557542300|418062717838|418069767055|6673938200|
|320|7575093848|419003376679|419010425896|6724076300|
|640|7611802968|420970767719|420977816936|6828940300|

The first two numerical columns of different tables are not exchangeable operation units. A reciprocal real-times-complex scale, an E complex stage, a dyadic translation update and a final rounding witness have different arithmetic and proof costs. Endpoint assemblies, complex rational divisions and exact factor construction are required per source slot; the slot count records their number of instances but does not fully expand their cost.

Compared with the retuned baseline in the main scenario, head scales decrease from17881101889363 to10962363526720. However, Bernoulli scales increase from620117493760 to702585728572, E stages increase from54908986960 to58056920314, translations increase from118404633600 to150671324160, and6619212300 final scales plus the same number of rounds are added. This ledger does not turn that vector comparison into a runtime claim.

## 3. Argument lifetime and shared setup

The preceding D4096/N1720 band has7049217 distinct arguments. The final D4096/N1500 band retains6148097 of them and retires901120 after their last earlier-band use. It introduces no arguments. Every retained state is updated once to the first final height. Hence final updates equal6148097H, not6148097H minus the union or a new-initialization count.

Over the entire five-band prefix, initial B certificates, step-cis certificates and step-grid conversions each total7049217. The script checks

    fine-state updates + initial B count = argument-height pairs

for all four scenarios. All final P20 output-delivery counts remain exactly equal to the predecessor. Only source production changes.

The complete log grid also stops at7049217 points. Its inherited D4096 block partition has960 anchors and148013397 degree21 nonanchor Horner stages. No log block is added at the final transition. The elementary precision and no-feedback contracts are the accepted joint contracts; this bookkeeping creates no new relative-error or fixed-machine-width claim.

For the old raw two-array convention of72 bytes per argument, the whole union is507543624 bytes and the final active subset442662984 bytes. These figures omit metadata, proof data, transient arithmetic, worker replication and other arrays, and are not peak-memory estimates.

Large transform setup is unchanged and copied separately:6004 kernels,337702368 kernel entries,140276846 chirp entries, and an upper1116142487 CT-root entries. Kernel forward work is2244782056 general complex products,5502647200 additions and168845180 quarter turns. This is setup, not a per-height addition to each transform row. Actual root certification and correct shared-cache access remain required.

## 4. Large transforms and residue contractions stay fixed

The script checks exact equality with both predecessor receipts for all five transform categories and verifies P20_Horner_stages=19*residue_inputs. It does not replace the fixed-order pruned circuit with another circuit.

| Extra nodes | General complex products | Complex additions/subtractions | P20 residue Horner stages |
|---:|---:|---:|---:|
|0|1004103686197888|2079886046397995|1139279177111712|
|167|1024618166379118|2122384498321844|1161912234442848|
|320|1043412869778688|2161320205773035|1182647909722272|
|640|1082722053359488|2242754365148075|1226016642332832|

| Extra nodes | Quarter turns | Negations | Dyadic scales |
|---:|---:|---:|---:|
|0|92117812144056|19872754128|88576420247296|
|167|93986171544503|20269359088|90374781940928|
|320|95697902013176|20632715728|92022382774016|
|640|99277991882296|21392677328|95468345300736|

These remain typed counts. For example, a Horner stage contains its own multiplication/addition schedule and is not added to the G column as an identical primitive. Exceptional precision, phase normalization and later sign/interpolation work are not covered merely by listing these transforms.

## 5. Whole-small-family schedules remain alternatives

The small branch is copied from the explicitly named final theta receipt, not its earlier draft. Every row retains its exact parameter and precision ranges, odd/even-conductor subtotals, all Gaussian and setup calls, characteristic-transform work, time-transform work and requested outputs. The script checks that parity subtotals sum to every retained total.

The theta64 and theta128 schedules are alternative evaluations of the same requested values. They are not added to one another or to the large operation counts. A Gaussian unit gate includes a product, rounds and contraction; a small-family butterfly includes a fixed-twiddle product and two additions. Neither is the same accounting unit as a large G gate or head scale.

| Extra nodes | theta | Gaussian unit gates, upper | Main character butterflies | Time butterflies |
|---:|---:|---:|---:|---:|
|0|64|12023410796974|178774519697023|129247714213888|
|0|128|8542028172242|128941391789290|89858217607168|
|167|64|12027215953654|179195845161919|129557981560832|
|167|128|8544378416074|129070168525694|89954059550720|
|320|64|12031916441322|179641646009607|129870543716352|
|320|128|8545945245298|129211063280950|90062828601344|
|640|64|12039974420182|180588493431667|130490037698560|
|640|128|8549750401978|129487303527630|90276181311488|

Gaussian seed fractional precision is302 versus404 bits. In the main scenario the character gate/root ranges are279–313 versus381–415 bits, and time-gate/root ranges238–241 versus338–340 bits. These exclude the integer part and raw intermediate products. The complete per-scenario ranges are retained. A lower butterfly count therefore does not decide which theta is cheaper.

The per-conductor root/cache baseline remains the selected row. The optional global finest-precision cache is stored as an alternative that would replace the corresponding baseline setup entries, not be added to them. No shared large/small root cache is assumed without exact matching roots, circuits, tolerances and proof-context reuse.

The theta receipt also contains point_EM_* diagnostic counts. They are moved into an explicit not_selected_point_EM_comparator object and removed from the theta totals and parity subtotals. That comparator lacks an admitted arbitrary-height shared EM seed construction at the largest small height; it must not be silently included as additional work or accepted as a complete competing evaluator.

## 6. Required work still outside the priced schedule

The JSON retains explicit required rows with nonzero-status wording, not numerical zeros:

* Principal c=1 certification, under its separate full demand.
* Large Hardy/character normalization, conductor and root-phase data, and remaining postprocessing.
* Per-source EM endpoint assembly, exact rational factors/divisions and their proof expansion.
* Elementary certificate generation/checking and exact Bernoulli construction; existing calls and grids are only partially expanded.
* Actual strict signs, interpolation, precision repair and continuous coverage.
* Turing/completeness, including central and closed endpoints, count/gamma integrals and verified closure.
* Failed or adaptive work, retries, larger guards and independent replay.
* Ordinary Lean/MM0 proof representation, arithmetic widths, serialization, transpose, storage, transport and authenticated cache use.
* Finite binary Goldbach coverage at the selected B, including source tables, anchors, exceptions and endpoints.
* The actual ternary prime ladder, all primality proofs, gaps and terminal link.
* Analytic libraries and final source-faithful standard-axiom theorem assembly.

The whole-small-family parameter admission is no longer omitted as an unknown family, but its successful numerical/proof execution remains uncompleted. No fixed e proves completeness. This is consequently a reconciled partial operation schedule for the full nonprincipal family, with complete visibility of the remaining rows, not a fully priced end-to-end proof.

## 7. Reproducibility and frozen dependencies

reconciled_nonprincipal_schedule_20261111.py constructs the new JSON from frozen inputs without importing their generators. Its129 exact checks cover12 input hashes, scenario matching, all replacement identities, lifetime equations, unchanged transforms/Horner counts, identical output delivery, and the small parity sums. The script and JSON are frozen beside this note. Their hashes are supplied with the handoff.

| Input | SHA256 |
|---|---|
|work/qrh-blueprint/combined_retuned_seed_20261111.json|5924631261D494F377D647DBB3FA4BDB39796BDF5B2F979499A1D56144A86CAC|
|audit/REVIEW_COMBINED_PROFILE_RETUNED_SEED_LEDGER_2026-11-11.md|E2F06FEEA3E132A80BBD5245F37998815713070674A389B6665C985418015190|
|work/qrh-blueprint/JOINT_SEED_159_CORRECTIONS_2026-11-11.md|E6F0F3B277828EA451E05F3608478F760C83F02FEE1B70A899FA40434781CBE9|
|work/qrh-blueprint/joint_seed_m159_20261111.json|EF16593CF667377CD68CA9D3C37343E3364ECA06CABACCC9B8465931E2D83D45|
|audit/REVIEW_JOINT_SEED_159_CORRECTIONS_2026-11-11.md|09DEF5ABB358A807936270B07E61FFEE624EF0F04C3E17AC47A1179D944E2E82|
|major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md|AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F|
|major-constants/joint_quarter_mesh_head_tradeoff_20261111.json|F1686B1C1A3183082D9126F4FE680BE6DB42A88D31F82071B752759EE3DE9BD4|
|audit/REVIEW_JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md|2F057C0F2507452AC959587E13FD1AE8F9117FC75CBC3BA1C6364E8C5BF0064A|
|major-constants/combined_odd_even_height_inventory_20261111.json|BCBAA29AE9A963A46170C5B7B355C0399EE6A622EDBE355ECD24BFE92042C2EE|
|prime-estimates/WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md|74CE66BE4E051AEC1222AB67DF66F124DB1A1774498E6FBE52BDF59EDD9BC9BE|
|prime-estimates/small_family_theta_inventory_final_20261111.json|26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69|
|audit/REVIEW_WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md|34FB45C1CEBFF34A49C7C450BF1C78223593AB188EFEFC7C3EE7FE7658CB0AFE|

Abbreviated agent paths in the table are under work/qrh-campaign/agents. New independent reconciliation review is still required; the component reviews do not replace it.
