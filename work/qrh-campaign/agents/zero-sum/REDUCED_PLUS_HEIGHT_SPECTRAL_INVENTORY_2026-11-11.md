# Conditional spectral inventory at the reduced plus heights

2026-11-11. Exact integer/rational schedule metadata only. This report prices the same fixed-original-order, primitive-output-pruned character circuit as the reviewed R132900 inventory. It does not evaluate characters, roots, L-functions, zeros or primes, and performs no build. The proposed analytic height replacement and its union with other consumers remain separate proof/review inputs; no actual finite-RH certificate is supplied.

At the proposed heights, the large-branch main circuit uses 0.606227 to 0.606228 of the old main general-complex-product count. With 640 additional coarse nodes per conductor, that ratio is 0.648746 to 0.648747. These are exact operation-count ratios for the same circuit conventions, not runtime or total-proof-cost predictions. The shared seed height prefix shrinks, but the largest seed band and its 27,754,497 rational arguments remain.

## 1. Exact height and grid conventions

The frozen plus author specifies, for R=132900,

    Dc=1063200/qt(c), where qt(c)=2c for odd c and c for even c,
    u=19.89 for even c>60000, and 23.3 otherwise,
    Tplus(c)=ceil(200+max(260,u*3.1416*Dc)).             (1)

Every decimal in (1) is an exact rational; 3.1416=3927/1250. First take the integer ceiling in (1). Only then form the coarse grid

    J(c)=ceil(64*Tplus(c)/5)+1,
    t_j=5j/64, j=0,...,J(c)-1.                         (2)

The final node may exceed Tplus by at most1/16. It is not legitimate to replace (2) with a single ceiling of the unrounded rational in (1). The exact script follows these two ceilings.

The present branch has c>10000, odd c<=132900 or 4|c<=265800. It contains125400 conductors,4333246843 primitive labels and7133015232 unit-residue inputs per common height. All required primitive labels are retained, with the same inverse-character coverage. The smaller7499 conductors and18477108 primitive labels are excluded from the operation totals here; the principal RH-through1e8 requirement is also excluded.

The old comparison is exactly the frozen R132900 grid with Hold=1e8/c for odd c or c<=125000, and Hold=200+75e6/c otherwise. Its J is ceil(64Hold/5)+1 without first replacing Hold by an integer. The script reconstructs every old large total and asserts equality with the frozen receipt before comparing new counts.

## 2. One certificate union, not three spectra

The candidate base height is ceil(27e6/c) for odd c and ceil(54e6/c) for 4|c. The candidate star height is ceil(max(300,704Dc/343)). The script checks both are at most Tplus for all125400 conductors in this branch. The general formula comparisons are supplied by the separate analytic reports; those reports also cover the smaller conductors.

Conditional on the height proofs and actual RH through Tplus, one shared spectrum covers these three consumers. No base or star spectrum is added to the counts. The star .5075/.62 sufficient profile is weaker than RH, so an actual RH certificate covers its real-part requirements too. This union statement would require reconsideration if the proposed plus certificate were replaced by a weaker real-part assertion.

## 3. Main and auxiliary character-circuit counts

For each conductor, let v(c)=phi(c), n(c) be its primitive count, and C(c) the five-category cost vector of the reviewed fixed-order pruned circuit. Then

    residue inputs = sum_c J(c)v(c),
    primitive outputs = sum_c J(c)n(c),
    circuit cost = sum_c J(c)C(c).

An extra d coarse nodes at every conductor add exactly d times the corresponding one-height sum. These are seed/contraction/character-transform grid nodes, not densely interpolated sign-test points. Interpolation, strict-sign proof, Turing closure, failed discovery and exceptional precision repairs remain outside these totals.

| Schedule | Conductor-height nodes | Residue inputs | Primitive outputs |
|---|---:|---:|---:|
|Old main|2735223455|99513098256768|66172730256514|
|New main|1729026050|65920064426356|40474902420727|
|New +167 nodes|1749967850|67111277970100|41198554643508|
|New +320 nodes|1769154050|68202629300596|41861541410487|
|New +640 nodes|1809282050|70485194174836|43248180400247|

The categories are G general complex products, A complex additions/subtractions, Q quarter turns, N negations, S dyadic scales. They retain exactly the existing radix2/CT/direct/Blue implementation choices and primitive dependency pruning. No reordered-axis optimization or new pruning is introduced.

| Schedule | G | A | Q | N | S |
|---|---:|---:|---:|---:|---:|
|Old main|1849018578634950|3808420069398260|168298416860166|36476401602|163078435471936|
|New main|1120925963188476|2319745161470097|102708998603521|22187990916|98879283658304|
|New +167|1141440443369706|2362243613393946|104577358003968|22584595876|100677645351936|
|New +320|1160235146769276|2401179320845137|106289088472641|22947952516|102325246185024|
|New +640|1199544330350076|2482613480220177|109869178341761|23707914116|105771208711744|

| Schedule | G/old G | A/old A | Residue/old residue | Output/old output |
|---|---|---|---|---|
|New main|[.606227,.606228]|[.609109,.609110]|[.662426,.662427]|[.611655,.611656]|
|New +167|[.617322,.617323]|[.620268,.620269]|[.674396,.674397]|[.622591,.622592]|
|New +320|[.627487,.627488]|[.630492,.630493]|[.685363,.685364]|[.632610,.632611]|
|New +640|[.648746,.648747]|[.651874,.651875]|[.708300,.708301]|[.653564,.653565]|

These are outward integer-part-per-million brackets. The receipt gives exact fractions and all five ratios. The difference between label/output/residue/G ratios is material; none may replace the others as a total-cost ratio.

The additional spans measured from the last main grid node are835/64,25,50 for d=167,320,640. If the count theorem is based at that grid node, these are exact auxiliary lengths. If its base remains the integer Tplus, the endpoint offset from (2) must also be charged or handled by a separate endpoint evaluation. No auxiliary length is asserted sufficient here. All sign successes, brackets, endpoint conventions and Turing inequalities still require an actual certificate.

All new main grids are prefixes of their own old grids. For +167 this remains true. For +320 and +640, respectively643 and24007 conductors exceed their own old final node. This does not create a new global seed-domain requirement, as shown next, but it prevents claiming those rows are wholly subsets of the old per-character data.

## 4. Shared seeds: a proved prefix reduction, with the same largest band

The largest new main J is102145, uniquely at c=10004, Tplus=7980. The old maximum was127989. Because every conductor uses a prefix starting at j=0, the global requested set is exactly the prefix through that largest J. Its end heights are:

| Extra nodes | Global nodes | Last height |
|---:|---:|---:|
|0|102145|7980|
|167|102312|511555/64|
|320|102465|8005|
|640|102785|8030|

Thus every requested seed height lies in the old V<=10000 domain and below the old global last index. No V10200 or modified N is imported. Retain the exact five existing band choices:

| V | D | EM N | New main nodes in band |
|---:|---:|---:|---:|
|500|512|220|6401|
|1000|1024|387|6400|
|2000|2048|720|12800|
|5000|4096|1720|38400|
|10000|8192|3387|38144|

Endpoints belong to the lower band: e.g. j=6400 is the V500 endpoint. All extra nodes lie in the final band. This exact prefix argument, rather than a conductor-count ratio, justifies reducing shared height-dependent work.

The following are alternative seed schedules, not quantities to add together. The original P24 table uses24(D+1) coefficient slots per height. The shifted-P20 option uses P27 coarse source slots27D+20 and330D midpoint-shift updates per height, with the existing endpoint reuse. Both keep the existing per-band parameters and proofs. Global height/argument pairs count ((N+1)D+1) at each height; they are not asserted equal to elementary-function calls when recurrences are used.

| Schedule | P24 slots | P27 source slots | P27 shift updates | Height/argument pairs |
|---|---:|---:|---:|---:|
|Old main|17223585528|19375637796|236782064640|2068812377589|
|New main|12141828120|13658841620|166916428800|1351525157121|
|New +167|12174665664|13695782688|167367889920|1356160158120|
|New +320|12204750360|13729626900|167781504000|1360406596161|
|New +640|12267672600|13800412180|168646579200|1369288035201|

The largest band is still present, so the nested rational x-grid union is still27,754,497 points, x=1+j/8192 through x=3389. Its initial log/amplitude/step caches do not shrink under this unchanged schedule. Lowering N or deleting selected x arguments would require a separate source and dependency argument; neither is credited. Height recurrence work can stop at the shorter prefix, but all initialization, proof checks and any required retained coefficients remain charged.

## 5. Setup and precision remain separate costs

The conductor set and axis circuits are unchanged. Retain all12496 top axis lengths,32942 active nodes and6004 Blue kernels of the old pruned setup. This includes337702368 kernel entries,140276846 chirp entries, maximum padded length262144, and the1116142487 upper count for full CT root-table entries. Kernel construction costs2244782056 G and5502647200 A before any height loop. No setup saving is claimed.

At the same prescribed input bound, coefficient accuracy and arithmetic grid, original-order pruning still transfers the existing conservative error and peak bounds. Restricting heights does not authorize fewer bits. The newer three-real-product implementation may refine each G gate under its separate exact-internal/final-rounding contract; this report continues to count G, not an invented fixed cost in real or limb multiplication. New precision tiers require separately certified caches and separately charged setup.

Actual seed generation, coefficient error proofs, sign discovery, interpolation, selected-sign checks, Turing counts, output serialization and proof-system verification are not hidden inside these five counts. This is a conditional comparison of arithmetic schedules, not a hardware benchmark or an end-to-end forecast.

## 6. Reproduction and pins

The new script reads the pinned R132900 metadata definitions up to, but not including, their inventory loop using an AST prefix. It reconstructs the old totals, then applies the exact new rational height formula. It does not import an analytic evaluator. It writes only its separately named receipt and refuses to overwrite it.

Run `work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/zero-sum/reduced_plus_height_inventory_20261111.py` in a separate replay location if preserving the saved receipt. No timing is used as performance evidence.

| Artifact | SHA256 |
|---|---|
|major-constants/PLUS_FINITE_RH_HEIGHT_REDUCTION_2026-11-11.md|3F91F39B485607833A5FADD061BEC7602B1DCC02C77B8FB82CA10B6C076FA6A0|
|zero-sum/conditional_r132900_pruning_inventory_20261111.py|074E6B512F595DD174C45F3D273212FDFCF76CD6EFF6F82699F260E447CA986D|
|zero-sum/conditional_r132900_pruning_inventory_20261111.json|E94D87827C3A4D37CA34F07001F16EA7AEE8854684F8BC156C3D4AC6D96B65CF|
|zero-sum/WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md|E1D58C8EC2EDB7FD8F3BF77F1D3833F3E400200D14AD30B396F59FA8CB5EE794|
|independent-feasibility/BASE_GAP_REDUCED_FINITE_RH_HEIGHT_2026-11-11.md|776CD34413ECC389D10CE510913C694C6D6C34E8555FFE0D66702582B3A23898|
|prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md|251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231|
|integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md|861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895|
|zero-sum/reduced_plus_height_inventory_20261111.py|FEDC889D2B043EAA1AEFA6CF4824107949DC46A372384BC9F451B9B05F33AF47|
|zero-sum/reduced_plus_height_inventory_20261111.json|E4876ACF3F57D800118D328B56261149BC66B3A15F2272BDD370D88ECD986791|

Paths are relative to `work/qrh-campaign/agents/`. Analytic adoption and actual spectral evidence are deliberately outside this metadata verdict.
