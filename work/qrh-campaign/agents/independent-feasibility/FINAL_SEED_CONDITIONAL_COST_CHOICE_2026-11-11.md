# Choosing among three reviewed final seed bands

2026-11-11. Conditional cost guidance, not a timing forecast. The strongest first implementation candidate is the quarter-mesh route **if its dyadic translations, coefficient rescaling and output binding are cheap enough under the explicit tests below**. It has fewer arguments and fewer operations in every expensive head/correction family than either comparator. The correction-heavy route remains useful when preserving the existing output construction saves enough implementation or proof work. No route dominates every category, and the baseline remains the reference until complete prices are available.

## Common target and three choices

Use the combined odd/even +640 prefix: J=84840 total heights, with H=20839 in the last band. Its final height is `424195/64<7000`. The lower four bands are unchanged. The same calculations apply to another common final length H within the proved domain. All choices deliver the same fine mesh of denominator16384, normalization8192, final order20, numerical coefficient error contract and isolated alpha error below `2^-82`, including the separately accounted analytic shift bias.

| Label | Final-band parameters | Specific additional work |
|---|---|---|
| B, baseline | D8192, P27, N2387, m64 | Existing midpoint construction |
| Q, quarter mesh | D4096, P28, N2387, m64 | Three signed shifts per coarse interval and final coefficient rescaling |
| C, more corrections | D8192, P27, N1500, m256 | 192 extra Bernoulli corrections per coefficient and shrinking active-set bookkeeping |

Q's proof covers the earlier, longer H4 +640 prefix, so using the present shorter prefix requires no new analytic estimate. C's counts already use the combined prefix. B is evaluated at that same prefix here. This prevents crediting one alternative with a shorter height range than another. The proposed joint D4096/N1500 method is excluded: neither composing its errors nor adding its savings is justified by these separate reviews.

## Counts that determine the choice

These are per-final-height counts. Head and gamma scales have separate prices because their operands and proof obligations differ.

| Category | B | Q | C |
|---|---:|---:|---:|
| Head rational scales |508457257|264047553|319516500|
| Head additions |528013948|273827092|331806000|
| Gamma scales, and separately gamma additions |14157056|7341824|56628224|
| E complex stages |1253522|630938|4399634|
| Source coefficient slots |221204|114716|221204|
| Coarse anchors |8193|4097|8193|
| R stages |26|27|26|
| Translation updates |2703360|4300800|2703360|
| Extra normalization scales, and separately rounds |0|327700|0|
| Argument pairs / EM copies |19562497|9781249|12296193|

Source slots price only the remaining head/endpoint products, assembly, exports and their checks. They must not be charged again for operations already listed. A per-anchor charge similarly covers only work not otherwise counted. If those costs vary materially by coefficient index, use the actual sum instead of a uniform price.

All final internal heights need their seed values, not merely the last state. The following setup and lifetime distinctions therefore also enter the comparison:

| Quantity | B | Q | C |
|---|---:|---:|---:|
| Required argument union |19562497|9781249|13197313|
| New arguments at final transition |12513280|2732032|6148096|
| Log Horner stages |410791416|205385187|296046954|
| Log anchors |1001|1002|959|
| Additional exact gamma constants |0|0|192|

C's log count deliberately covers 14098433 fine-grid points, including 901120 unused points. Its smaller actual phase/state union is not substituted into that log count. Q's 1002 anchors need not be a subset of B's 1001 anchors. For each row i, final update count is `H*X_i-I_i`, where X is the per-height argument count and I is the number newly introduced. It is not `H*X_i-union_i` unless the preceding work is included too. C retires 901120 old arguments, updates its retained intersection and initializes only its new fine points.

## Explicit break-even tests

Assign nonnegative prices in one chosen unit, separately for generation, ordinary-rule verification, proof bytes or another stated objective:

`h` head scale; `a` head addition; `g` gamma scale; `b` gamma addition; `e` E stage; `o` residual source-slot work; `v` residual per-anchor work; `r` R stage; `t` translation update; `n` extra normalization scale plus round; `s` fine-state update; `c` EM-grid copy.

Let `S_i` be all setup and nonlisted implementation work for route i. It includes each required argument's amplitude/initial/step certificates and step conversion, log work, anchor certificates, exact gamma construction, lambda setup, indexing, proof bindings, traffic and any route-specific implementation cost. Its price must not duplicate the listed operations. For each comparison define

    F_ij = S_i-S_j - (I_i-I_j)*s.

The subtraction accounts for updates replaced by initialization at the final transition. With common per-category prices, the following inequalities are exact for this model. With different actual gate prices, compare the original weighted rows instead; a shared upper cap is not evidence that actual costs coincide.

**Q beats B** precisely when

    1597440*t + 327700*n + r
      < 244409704*h + 254186856*a
        + 6815232*(g+b) + 622584*e
        + 106488*o + 4096*v + 9781248*(s+c) + F_BQ/H.

**C beats B** precisely when

    42471168*(g+b) + 3146112*e
      < 188940757*h + 196207948*a
        + 7266304*(s+c) + F_BC/H.

**Q beats C** precisely when

    1597440*t + 327700*n + r
      < 55468947*h + 57978908*a
        + 49286400*(g+b) + 3768696*e
        + 106488*o + 4096*v + 2514944*(s+c) + F_CQ/H.

These tests expose the actual choices. Q's extra translation and normalization bill is identical against B and C, while its savings against C include almost fifty million gamma scales and additions per height. C avoids the extra translation/output-normalization bill, but only wins if its extra E and correction work fits inside the head and state savings. Choosing C merely because N is smaller would omit that test.

For a simple setup implementation, let `i` price a complete argument's initialization/amplitude/step package excluding logs, `l` a log Horner gate, `z` a log anchor certificate, `Gamma` the total incremental certified gamma setup through index512, and `Lambda` Q's extra lambda entry/setup. Retain all unmodeled binding/traffic differences in `Delta_ij`. Then

    F_BQ = 9781248*(i-s) + 205406229*l - z - Lambda + Delta_BQ,
    F_BC = 6365184*(i-s) + 114744462*l + 42*z - Gamma + Delta_BC,
    F_CQ = 3416064*(i-s) + 90661767*l - 43*z
             + Gamma - Lambda + Delta_CQ.

This expansion is optional, not permission to assign a uniform price to differently sized exact gamma numerators or to different anchor proofs. `Gamma` is a total setup bill, not 192 times an assumed constant-time operation. Pi and already common setup cancel only if genuinely reused. Sharing proofs or retaining intermediate values may change S and must be recorded there.

## Implementation guidance and width limits

Price Q's full output transport first. Its negative-quarter and positive shifts use dyadic scaling/addition, but their numerical rounding, coefficient normalization, all consumed output bindings and proof-term construction are mandatory. If those prices satisfy both Q inequalities, C has no remaining modeled advantage. If Q loses because transport or its proof/data order is expensive, apply the C-versus-B inequality rather than reverting automatically to B.

A small complete kernel for these categories is more informative than another uniform-operation count: compare a head rational scale, a gamma scale, an E complex stage, a full Q translation/normalization and their actual proof/data output. Include the relevant setup amortized over H and the true argument lifetimes. The most important unresolved prices are not interchangeable: a small rational head multiplier, a full complex E product and a dyadic shift have different arithmetic and ordinary-proof costs.

All three proofs retain conservative common stored-center caps and the same sufficient error exponents: base error118 bits, internal seed rounding122, fine-state and step errors140, shared log error144 and shift error110. These are not total operand widths. The D4096 R recurrence has a different error constant; C has an enlarged S sum and E depth. Exact intermediate products, denominator construction, gamma targets and signed additions still need their own width ledgers. Using equal fractional precision does not justify equal gate prices or a smaller proof term.

For Lean, ordinary kernel arithmetic and the structure of the acceptance theorem matter. For ordinary-rule MM0, digit arithmetic, reuse, unification terms, local/global state and serialized witnesses matter separately. These models do not assume native arrays reduce inside either kernel for free. No elapsed-time ratio, minimum-hour estimate or globally optimal route is claimed.

## Evidence

The new `final_seed_cost_choice_20261111.py`, SHA256 `A5A5C7E2F4B88CB2C5A939B1D168B0559874C93E3AB0E417622CDB8AA97947E8`, derives the rows and differences by exact integer arithmetic and reconciles them with the two alternative receipts. Its JSON is `7E8ABFDC0F2A212B975738DE94D17448F8A6C9EA597D3203A01933A4FB8882E9`. No analytic evaluations or builds occurred. These are the consumed paper/review pins:

| Route or prefix | Author | Independent review |
|---|---|---|
| B | 8F08560DDB2BDFEBEABA0D4D5A44FCBCC625BFD43D1027AF05BF62233863FD9B | 6D5AA23A7050AC5C54E103AFD9C33BBAF5AF84836FCB7DD05FDD50CA9853BCFF |
| Q | A0CD531E1FD20280E49B1EC0AE95E32809C7965222C40916BD4712F7F3A5EA19 | 8D50DDB6C7398D10930F8437ABE9B3E0C672F9AD1F85851D040EF1BD6D385B6A |
| C | 3B760B39986F6A80C1ADB71BCABDEFDE28947964225383AF1073E6601162DE4F | 7BB25BC96EE9C27FE03038968EFC9E9F52A4B3064D9F0986865CF68AC8E77365 |
| Combined prefix | 6143FA8444ED97084998D769E114DCAB3DC2C12DCAF9649C32CFA1989658487C | F32FABEF789BEF16B64D16040C1FE48D324F0D84DDBA1FF47F0D30DE2C3A6EAA |

Exact paths and receipt pins are retained in the new metadata. The source papers remain unchanged. This cost-choice note supplies decision inequalities; actual category prices and full formal acceptance remain open.
