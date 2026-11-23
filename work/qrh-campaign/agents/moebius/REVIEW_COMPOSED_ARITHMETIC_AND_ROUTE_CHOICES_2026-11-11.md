# Independent review of arithmetic composition and route choices

2026-11-11. Verdict: PASS at conditional operation-model and research-route scope, with the explicit conductor qualification below. There is no arithmetic correction. No measured time, full-cost dominance, successful spectral/prime certificate or completed Lean/MM0 proof follows from this review.

Reviewed frozen inputs under `work/qrh-blueprint`:

| File | SHA256 |
|---|---|
| `COMPOSED_ARITHMETIC_AND_ROUTE_CHOICES_2026-11-11.md` | `B2742C6884FE982B526F50F49D23A42B08E4F0BD6084F6BEE76C91F7C2545A25` |
| `compose_certificate_costs_20261111.py` | `DE394B1624E35B05A456284C16DC993AF4EAF55735FBEB11F8C1E0FC8AEBEECA` |
| `compose_certificate_costs_20261111.json` | `B9CF2B0A9D0CB7D483ED3F7E1700944AB6E11A75F42E561C78B63D471E556549` |

I read the complete author note and composition script, the square/Karatsuba and grouped-cyclotomic author packets, their independent reviews, the original-RH consumer-domain analysis, the lower-threshold and QRH cutoff reports, and the relevant mixed-radix and finite-RH frontier reviews. I did not execute the composition script or any candidate evaluator. Independent work was confined to exact integer recurrence, width and subtotal checks, file reads and hashes. Only this new review file was written for this task.

## 1. Actual width and arithmetic domains

For k candidates each strictly below 10^27, their product M satisfies M<10^(27k). Exact integer comparisons give

    10^27 < 2^90,
    10^216 < 2^718,
    10^864 < 2^2871.

Thus the proposed byte-radix lengths are 12,90 and359 digits. The tighter 718/2871 bounds use p<10^27; the weaker phrase "90-bit candidates" alone would only justify 720/2880 bits. The author supplies the stronger domain. The lower target threshold 989*10^24 is smaller still, so these conservative widths remain valid there.

For a canonical residue x<M, the actual quotient in x^2=qM+r obeys q<M. The modular template charges the square, the generally nonsquare qM product, the recombination equality, and the strict remainder bound. The composition does not omit qM. A batch uses the source power-of-two criterion separately on every candidate, not a primality claim about the product M. Each candidate satisfies the strict source bound because 10^27<2^90<(2^45+1)^2. The root congruence modulo M descends to each factor. Product binding, individual oddness/size and root range checks remain outside the 44 modular-square subtotal.

These are costs of the specified padded width templates. A comparison of such upper-width schedules is not a theorem that every actual eight-candidate batch costs more than every possible direct implementation. Actual bit sizes, alternative circuits and all excluded work can change the comparison.

## 2. Independent reconstruction of the subtotals

I rebuilt the integer dynamic recurrence from the reviewed formulas, rather than reading its result as a cost oracle. For n digits the base product cost is 5n^2+2n+1, and the base square cost is its minimum with 5n(n-1)/2+12n+3. With h=ceil(n/2), g=floor(n/2), adaptive recursion above n=3 compares the base against

    G(h)+G(g)+G(h+1)+12h+8n+21,
    C(h)+C(g)+C(h+1)+10h+8n+18.

The h+1 carry-grown child is retained. The modular square is C(n)+G(n)+6n+3, and the modular general product is 2G(n)+6n+3. The independently obtained values are:

| Bits | Digits | G | C | Modular square | Modular product |
|---:|---:|---:|---:|---:|---:|
|90|12|745|477|1297|1565|
|718|90|26453|17053|44049|53449|
|2871|359|253512|166814|422483|509181|

Multiplication by 44 gives 57068,1938156 and18589252. Their exact batch-to-direct ratios are 1,44049/10376 and422483/41504. These support the author's approximately 4.25 and10.18 values. The per-candidate fractions 484539/2 and4647313/8 also match the receipt.

At the 90-bit prices, the four stated circuits give:

    44*1297 = 57068,
    43*1297+49*1565 = 132456,
    40*1297+37*1565 = 109785,
    33*1297+22*1565 = 77231.

The five-coordinate improvement is exactly 22671 template events, with four additional standalone additions/subtractions. The old four-root schedule includes its ten aggregate-unit products. The new four-root schedule includes its eight aggregate-unit products and both cyclotomic sums; no separate Fermat power is incorrectly retained or omitted. The atomic row includes its prime-power prepowers and has eleven roots, no inverse. The two four-root rows have four roots and one inverse. The same coordinate count does not mean the producer constructs identical fields or spends identical work.

The chosen new four-root vector is the explicit equal-weight schedule (40,37,14), not a proven optimum at square/product prices1297/1565. The report correctly calls these chosen circuits. No new weighted-optimality claim is accepted. The receipt's two source hashes match the frozen arithmetic and grouped-cyclotomic receipts.

## 3. Proof packing and omitted work

Logical packs of many direct prime proofs do not require a product modulus. A pack may instantiate sound narrow-modulus lemmas for each indexed candidate, retain shared digit/factor facts, and combine the exact candidate and coverage conclusions. That architecture still owes the indexed conjunction/coverage proof and its encoding/import costs; a hash or external success flag cannot replace it. The author makes no such substitution.

The accepted subtotal omits representation and substitution costs, ordinary-PA table and lifting-lemma proofs, split/concatenation work, standalone additions and normalization, candidate bounds and factor/product binding, search failures, factoring, root construction, CRT, payload, source/factor-cache provenance, gap/terminal tests, imports and final assembly. Dispatch savings might favor packs or batches and are also absent. Those omissions prevent a total-cost or timing conclusion in either direction.

The arithmetic study is an ordinary-PA proof-template proposal. Its events are specified table/fixed-lemma applications, not measured MM0 instructions. The actual analytic development still needs an explicit compatible foundation and arithmetic interpretation. A Lean dependency/export tool is not itself an ordinary-MM0 typing and conversion proof producer. This qualification is retained by the author and remains essential.

## 4. Distinct analytic routes and transform qualification

The reduced original-RH route requires the critical line, not merely a finite .555 strip. Its odd primitive conductors satisfy c<=150000. Its four-divisible conductors satisfy c<=300000, with height 10^8/c through125000 and 200+75000000/c above125000. The principal requirement is RH through10^8. The original consumer-domain packet reconstructs this smaller family only after the relevant consumer and parity refactors; the unchanged broad public Platt proposition cannot simply be replaced by it. The composition correctly leaves these formal refactors and finite certificates open.

The lower threshold 989*10^24 is a separate source-scope adaptation retaining the original x>=4.9e26 and y>=10^25 estimates. It does not import the QRH branch's weaker spectral premise. The R=100000,N>=10^36 experiment expressly uses the .555 finite family, global7/8 provider and .65 energy input. It therefore does not establish an original-RH threshold penalty or an improvement that can be transplanted while dropping those inputs. The pending original-route R=140000 investigation receives no numerical credit here.

The mixed-radix comparison preserves the positive unnormalized character transform, its outputs and actual source domain. The specific product ratio [.621939,.621940] and addition ratio [.550472,.550473] are for the inventory's **c>10000 branch**. This is the explicit qualification to the author's shorthand sentence. They are not full-family spectral cost ratios and must not scale the small-conductor branch, Hurwitz seeds, interpolation, repair, precision, zero counts or assembly. The separately reviewed original-family restriction and the mixed-radix arithmetic change can be composed only at their matching domains and cost categories.

The Q=47 ladder-free competitor gives H=4*10^10*47=1.88*10^12 and B=2*10^16. Its ordinary-theta estimate uses the fresh Logan argument, complete principal RH, and its head/count inputs. The reviewed Bertrand patch removes an explicit low-range prime list; it does not prove RH, the Logan identities or binary Goldbach. Its range through10^27 covers the smaller comparison threshold, but its added principal spectral and analytic proof cost must still be charged. No global RH or deleted nonprincipal obligation is inferred.

## Evidence anchors and verdict scope

The principal consulted anchors are:

| Packet | SHA256 |
|---|---|
| Arithmetic receipt | `D2E5F35DB7D75C44F8DDD9405D60D78D475A123676CAC036D0CF0F6FFA47D073` |
| Arithmetic independent review | `767753AB7CE59C69922363DCF239C55B2D81C716194D62D977EE4CFE9F75A7B1` |
| Grouped cyclotomic receipt | `FC21AE178DD49F9923244B3D2CA6547CB31797AE695F8D4F683C8A78519E7585` |
| Grouped cyclotomic independent review | `B8258763BD6134358FAB9ED5DFDEF56F99861F671E258B7291376213106BAB64` |
| Original-RH consumer domain | `AC14194BAB999170E7444DD0EDAA0285A3758942681AB44E4E2047CF8A87D48C` |
| Lower analytic threshold | `99D06335D5F8AF1D9AB0916A84BB60AE2ECF060B5FDF04C0134AB9BCB860F786` |
| QRH cutoff/threshold experiment | `CD4DC585BEB2536E22DB93D03A0819395F38449F61494E5E3DDE2E209A653DC6` |
| Mixed-radix author | `C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01` |
| Mixed-radix independent review | `BABEF1416D8D02864360DD523DE18F468FD0DCDD3FA5C583F6BD564C76A19AB9` |
| Fresh finite-RH frontier | `0305EF19674FF97D13C2FA3F897E1106B5B0C4618287C9002842B87233F617DF` |

This review accepts the exact composition of the named templates and the distinction between research routes. It does not reprove every lower analytic result in those packets, certify any spectral statement, implement any arithmetic template, or authorize a numerical run. The conductor qualification above must accompany any reuse of the transform ratios.
