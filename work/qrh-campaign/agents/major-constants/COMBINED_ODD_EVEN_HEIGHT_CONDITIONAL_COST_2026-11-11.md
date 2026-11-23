# Conditional cost of the combined odd/even profile

2026-11-11. Exact integer/rational metadata only. This combines the frozen odd and even height formulas for counting purposes. It does not prove the combined analytic assembly, certify RH, evaluate any functions or alter frozen artifacts. Both component source proofs have passed independent review; the complete consumer join remains separate.

The combined main general-complex-product count is between .988148 and .988149 of the four-band H4 count, and between .895780 and .895781 of the current Tplus count. The shared P27 head-addition count is between .947550 and .947551 of H4, or .631466 and .631467 of current Tplus. These are category-specific operation ratios, not end-to-end runtime savings.

## Same family, circuits and seed parameters

The odd formula is ODD_PLUS_SHARED_RH_HEIGHT_2026-11-11.md, SHA256 C4EE2B2F674F6376D987C778FC7886A03A93BC81E61C0BC56D0B1C25E2E4A14D. The even formula is moebius/EVEN_GAUSS_PLUS_HEIGHT_PROFILE_2026-11-11.md, SHA256 D3408AA27763D7E3C475E7B27DB124FDE9C16EDC916CEE061563B31D9A2DD88B. This inventory uses only the c>10000 branch, where they are

    odd:   ceil(200+max(240,19.2*3.1416*531600/c)),
    4|c:   ceil(200+max(255,19.1*3.1416*1063200/c)).

The script explicitly takes the maximum with the separate base-gap and star heights and checks that neither increases these heights. It then applies the second ceiling J=ceil(64H/5)+1, with nodes5j/64 for0<=j<J. Every parameter is exact rational. The endpoint grid overshoot remains present.

The unchanged family has125400 large conductors,4333246843 primitive labels and7133015232 residue inputs per common height. The small branch7499 conductors/18477108 labels and the principal branch are excluded from all compared totals. No cost reduction for those branches is credited even though some small-conductor heights change analytically.

The two baselines are the reviewed four-band H4 metadata8258CC9F and the earlier current Tplus metadata. Neither baseline is the original Platt height schedule. The script reproduces both baselines exactly, including all four selected-P27 scenarios, before emitting the new counts. Fixed original-order primitive-output pruning, radix2/CT/direct/Blue choices, error widths and five old seed bands are unchanged.

## Main and auxiliary conductor work

The extensions d=167,320,640 add exactly d common coarse nodes per conductor, giving lengths835/64,25,50 after its main grid endpoint. No extension is asserted to guarantee a successful Turing closure. If the count is instead based at the integer H, the grid overshoot must also be included.

| Schedule | Conductor-height nodes | Residue inputs | Primitive outputs |
|---|---:|---:|---:|
|Combined main|1522865397|59962061953248|36290898519503|
|Combined +167|1543807197|61153275496992|37014550742284|
|Combined +320|1562993397|62244626827488|37677537509263|
|Combined +640|1603121397|64527191701728|39064176499023|

| Schedule | General products G | Complex additions A | G / same-d H4 | G / same-d current Tplus |
|---|---:|---:|---|---|
|Main|1004103686197888|2079886046397995|[.988148,.988149]|[.895780,.895781]|
|+167|1024618166379118|2122384498321844|[.988383,.988384]|[.897653,.897654]|
|+320|1043412869778688|2161320205773035|[.988589,.988590]|[.899311,.899312]|
|+640|1082722053359488|2242754365148075|[.988999,.989000]|[.902611,.902612]|

The receipt retains quarter turns, negations and dyadic scales separately. Each scenario also has19 literal P20 Horner stages per residue input. Its transform-plus-contraction real counts use exactly the preceding formulas:4G+2H real products and2A+2G+2H additions for four-product complex multiplication;3G+2H products with2A+3G+2H or2A+5G+2H additions for the two distinct three-product implementations. Their extra setup/width conditions remain unchanged.

All combined main grids are prefixes of both baselines. Candidate+d also remains a prefix of each baseline+d. It need not fit a baseline's unextended main grid: for +167,+320,+640, the counts exceeding H4 main are88193,109037,121093; the counts exceeding current Tplus main are16002,39520,51450. These rows still need their own contractions, transforms and certificates.

## Global prefix and selected P27 costs

The maximum main certificate height is6578, uniquely at c=10004; J=84200. H4 had85902 global nodes and current Tplus102145. The exact combined global prefixes are:

| Extension | Global nodes | Last height |
|---:|---:|---:|
|0|84200|420995/64|
|167|84367|210915/32|
|320|84520|422595/64|
|640|84840|424195/64|

The largest listed height is6628.046875, below7000. This is only a required-domain observation. **No V7000 retune is counted here.** Every row keeps the old final band(V10000,D8192,N3387), and the largest rational argument remains3389. The first four bands retain6401,6400,12800,38400 nodes. Final-band counts become20199,20366,20519,20839; all endpoints retain the previous band-ownership convention.

The selected P27 ledger has K=27D+20, head scales H*N*(26D+19), head additions H*N*K, E stages H*(153D+146),64H*K Bernoulli terms/additions,330H*D midpoint updates and20H*(2D+1) final P20 deliveries. It is charged once on the shared prefix, not once per conductor.

| Category | Main | +167 | +320 | +640 |
|---|---:|---:|---:|---:|
|P27 source coefficients|9689335840|9726276908|9760121120|9830906400|
|Head reciprocal scales|22183711078363|22304196277282|22414580920603|22645450762843|
|Head additions|23036970463732|23162089861048|23276720207092|23516469950452|
|E recurrence stages|54908986960|55118325134|55310114000|55711241040|
|Bernoulli terms (and additions)|620117493760|622481722112|624647751680|629178009600|
|Midpoint updates|118404633600|118856094720|119269708800|120134784000|
|Final P20 deliveries|14353760800|14408486700|14458624800|14563488800|
|Height/argument pairs|853470708456|858105709455|862352147496|871233586536|
|Fine-state updates|853442953959|858077954958|862324392999|871205832039|

Every height/argument pair also requires its state-to-EM conversion. The rounded copy is not fed back into the fine recurrence. Other assembly, export and arithmetic witnesses remain additional costs. Exact same-extension ratios against both baselines are in the receipt for every category.

## Setup and qualifications

All scenarios still reach the fifth band and its nested argument set. Thus27754497 initial B certificates, step-cis certificates and step-grid conversions remain. The582822471 nonanchor log stages, unchanged anchor work, base/step precision,64 Bernoulli constants and dense state capacity remain. A shorter prefix does not automatically permit fewer bits or fewer initial arguments.

Transform setup is also identical:12496 top axis lengths,32942 active nodes,6004 Blue kernels,337702368 kernel entries,140276846 chirp entries, maximum padding262144 and CT table upper1116142487. Kernel generation still has2244782056 G and5502647200 A. Additional setup at the same precision is zero; retained setup is not zero.

The profile's proof must still join the odd/even error bounds with the selected star and base-gap consumers. This metadata calculation asserts no actual spectral values, sign success, unique counts or complete finite-RH certificate. Principal/small branches, analytic formalization, interpolation, sign checks, Turing closure, failures/repairs, serialization, Lean/MM0 verification, binary coverage and any separately proposed final-band retune remain outside these subtotals.

The new combined_odd_even_height_inventory_20261111.py/JSON pins both component reports and the reviewed H4 script/receipt. It executes only the pinned integer metadata prefix and the exact selected-P27 ledger, then reconstructs the two baselines and enumerates the same conductors. It refuses receipt overwrite. No old frozen file was changed. This new conditional inventory requires independent review.
