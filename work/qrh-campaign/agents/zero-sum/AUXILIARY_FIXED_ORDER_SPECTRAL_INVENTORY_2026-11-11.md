# Conditional auxiliary-grid inventory at R132900

2026-11-11. Exact integer/rational metadata only. No character, root, L-value, prime or zero evaluation, transform, build or source edit occurred. The six rows are alternative schedules, not cumulative requests or evidence that any h suffices for Turing closure.

## Fixed circuit and index contract

Retain the reviewed R132900 domain with c>10000: odd c<=132900 and c divisible by 4 up to 265800. There are 125400 conductors and 4333246843 primitive labels. Use the original axis order, the same primitive-output dependency pruning and all inverse labels. No optimized-order count or negative-channel halving is substituted.

The main grid has step Delta=5/64, J(c) nodes with indices 0 through J(c)-1, and top T(c)=Delta*(J(c)-1)>=H(c). For integer h in {10,20,30,50,200,250}, add exactly dJ=64h/5 nodes at indices J(c) through J(c)+dJ-1. Thus the new top is T(c)+h. The old shared endpoint is reused, not counted twice. The new last node may be used as an endpoint of an auxiliary interval; it does not guarantee a positive weight or a strict sign there.

For the literal reviewed schedule,

    a(c)=100000000 for odd c or c<=125000,
    a(c)=200c+75000000 otherwise,
    J(c)=ceil(64a(c)/(5c))+1.

For each conductor let v(c)=phi(c), n(c) be its primitive-label count and K(c) its fixed-order pruned circuit vector. Then the added quantities are exactly

    dJ*sum_c v(c), dJ*sum_c n(c), dJ*sum_c K(c).

This is not multiplication of the height-weighted main total by a height ratio. Every conductor receives the same number of extra nodes, while main J(c) varies. The script reconstructs the per-conductor schedule from the pinned metadata definitions and checks that its J-weighted sums reproduce all five frozen main totals before producing the new rows.

The per-extra-step totals across all large conductors are:

| Category | Exact count |
|---|---:|
| Residue inputs | 7133015232 |
| Primitive outputs | 4333246843 |
| G: general complex products | 122841198690 |
| A: complex additions/subtractions | 254481748047 |
| Q: quarter turns | 11187780841 |
| N: negations | 2374880 |
| S: dyadic scales | 10768632896 |

Here N in the operation vector is not the EM cutoff N in the seed table below. These categories are circuit operations, not equal-cost instructions or timings.

## Added transform work

| h | dJ | Added residue inputs | Added primitive outputs | Added G | Added A |
|---:|---:|---:|---:|---:|---:|
|10|128|913025949696|554655595904|15723673432320|32573663750016|
|20|256|1826051899392|1109311191808|31447346864640|65147327500032|
|30|384|2739077849088|1663966787712|47171020296960|97720991250048|
|50|640|4565129748480|2773277979520|78618367161600|162868318750080|
|200|2560|18260518993920|11093111918080|314473468646400|651473275000320|
|250|3200|22825648742400|13866389897600|393091835808000|814341593750400|

| h | Added Q | Added N | Added S |
|---:|---:|---:|---:|
|10|1432035947648|303984640|1378385010688|
|20|2864071895296|607969280|2756770021376|
|30|4296107842944|911953920|4135155032064|
|50|7160179738240|1519923200|6891925053440|
|200|28640718952960|6079692800|27567700213760|
|250|35800898691200|7599616000|34459625267200|

The receipt includes main-plus-auxiliary totals and exact incremental/main ratios for each category. Its main reference is G=1849018578634950, A=3808420069398260, Q=168298416860166, N=36476401602 and S=163078435471936. It also includes added conductor-height nodes 125400*dJ. No primitive-output interpolation, phase projection or Turing work is hidden in these transform figures.

The root/chirp/Bluestein-kernel index sets do not depend on height. At the same certified coefficient precision, the existing setup is reusable and there are zero new transform setup indices. The complete existing setup record is retained in the receipt. It includes 6004 Bluestein kernels with 337702368 kernel entries, 140276846 chirp entries and maximum padded length 262144. No setup saving is claimed. If higher precision is needed, the new coefficient enclosures and kernel transform cache tier must be generated and checked separately.

The unchanged axis order preserves the dependency-subgraph argument and its generic error/peak recurrences. This does not assert that old fixed output tolerances suffice at new heights. Actual input magnitudes, radii, coefficient precisions and downstream sign budgets must satisfy those recurrences anew. The inventory counts gates independent of their eventual operand widths.

## Shared seed union and domain boundaries

The main global height union ends at index 127988, t=9999.0625. Every positive h listed here exceeds t=10000 at conductor 10001. Hence none of the added schedules is justified merely by the old V10000/J128000 statements.

For a concrete conservative sharing schedule, retain all old main seeds. At index 127989 introduce every newly required rational base and use one enlarged upper-band cutoff at all added global heights. Set V=10000+h, m=64, P=27, D=8192 and N=ceil((V+160)/3). Bases are x=1+j/D through x=N+2. Each new base gets one initial leaf and step certificate; old bases continue their fine height state. This deliberately overcomputes some seeds. It is one reproducible schedule, not a minimal union.

| h | Candidate V | Candidate EM N | Maximum height | Global argument union | New arguments | Added global height/base pairs |
|---:|---:|---:|---:|---:|---:|---:|
|10|10010|3390|10009.0625|27779073|24576|3555721344|
|20|10020|3394|10019.0625|27811841|57344|7119831296|
|30|10030|3397|10029.0625|27836417|81920|10689184128|
|50|10050|3404|10049.0625|27893761|139264|17852007040|
|200|10200|3454|10199.0625|28303361|548864|72456604160|
|250|10250|3470|10249.0625|28434433|679936|90990185600|

The last row's seed counts are hypothetical index counts only: its unchanged D8192 allocation is not justified. For each row, added height updates equal the final column minus the new-argument column. Initializations and step certificates equal the new-argument column separately. The argument union is shared once across conductors, not multiplied by their count. New conductor values at old global heights may reuse existing shared seed objects but still pay their residue contraction and character transform.

At each added global height the P27/P20 endpoint scheme has 27D+20 coefficient slots and 330D midpoint-shift updates. These are separately stored in the receipt. They do not include the N-dependent head recurrences, 64 Bernoulli corrections, leaf verification, accumulation, residue Horner evaluation or arithmetic witnesses. Thus neither a seed slot nor a height/base pair is a unit-cost complete seed evaluation. The per-residue contraction count remains the residue-input column above and is not reduced by output pruning.

The h200 domain review binds V10200,N3454 and establishes the rechecked EM/scaled/elementary/recurrence implications, not values. The smaller rows obey the same monotone bounds with their own N: (V+32)/D<5/4, 3(V+27)/(4D)<15/16, (291N+433)/2^22<1/4, remainder below 2^-116 and stored seed magnitude below 2^16. Their new x range remains below 4096 and their phase range below 100000. Their maximal recurrence indices are below 130548, so the same rederived error below 11delta/16 applies. These domain implications still need implementation binding to actual new outputs.

For h250, V+32=10282 exceeds 10240, so the unchanged scaled rising-product proof does not apply. The P27 ratio exceeds 15/16 as well. Its maximal index 131188 also fails the stronger 11delta/16 recurrence bound, although the same geometric recurrence calculation still gives an error below delta. That last fact does not repair the failed scaled/shift premises. A larger D or a new error analysis would change seed sharing, contraction and setup costs and must be priced separately. This report neither silently doubles D nor claims a valid complete h250 seed backend.

Interpolation guards may extend beyond any displayed top. They are excluded from these rows unless separately checked and counted. Likewise refinement at new precisions, direct exceptional values and changes to the auxiliary grid require a new inventory.

## Coverage, omitted branches and reproduction

The 7499 nonprincipal conductors at most 10000, with 18477108 primitive labels, are excluded. Conductor one is excluded entirely. Their main or auxiliary work cannot be inferred by extending this large-branch schedule. All required large-branch positive channels are included; inverse pairing permits negative-ordinate reuse only under its proved source identity and does not halve this count.

The rows are conditional choices. They supply no K, W, canonical Gamma integral or strict surplus and do not prove that even h250 suffices. Dense node generation also supplies no strict signs. Selected auxiliary intervals may cost less than these dense schedules, but their complete dependencies and actual weighted lower counts must be checked. No spectral conclusion or runtime improvement follows from the metadata.

The new script reads the pinned parent through its AST only up to the first old row-loop initialization. It executes the reviewed integer schedule definitions, not the old output-writing inventory. It then enumerates the prescribed conductor integers, computes the fixed-order costs and checks the frozen main weighted totals. No numerical evaluator is imported. The only sieve is integer factorization metadata used to recover unit-group dimensions and circuit schedules.

Run the standard-library-only script with the existing interval-environment Python. It exited 0 with `PASS_EXACT_AUXILIARY_INVENTORY`.

| Artifact | SHA256 |
|---|---|
| zero-sum/auxiliary_fixed_order_inventory_20261111.py | 863913C5B5ABEAA7F84E758D5B20AD900E51F8EE784A97B24642690DD76A892E |
| zero-sum/auxiliary_fixed_order_inventory_20261111.json | 8BEAD899428DE523323FCA7D833ECE6F4C5443213D32D4F32B964B18B218F7F9 |
| zero-sum/conditional_r132900_pruning_inventory_20261111.py | 074E6B512F595DD174C45F3D273212FDFCF76CD6EFF6F82699F260E447CA986D |
| zero-sum/conditional_r132900_pruning_inventory_20261111.json | E94D87827C3A4D37CA34F07001F16EA7AEE8854684F8BC156C3D4AC6D96B65CF |
| major-constants/REVIEW_CONDITIONAL_R132900_SPECTRAL_PRUNING_INVENTORY_2026-11-11.md | 6B36841BB9BD406E7DE65170AAC29D00F4575970A16F4D1C78B4CAD5FD4AAEEF |
| integration/R132900_POST_TRANSFORM_CERTIFICATE_COST_2026-11-11.md | F718551E44C343FB874AAD919290D002F402760B5B6B44772B534C087AF2D054 |
| zero-sum/REVIEW_R132900_POST_TRANSFORM_CERTIFICATE_COST_2026-11-11.md | 8A69A2954AB6903557476003A21F967ECCDC93AA47AF5A63BFFEFC9B5C2253F6 |

Paths are relative to `work/qrh-campaign/agents`. All prior artifacts remain unchanged.
