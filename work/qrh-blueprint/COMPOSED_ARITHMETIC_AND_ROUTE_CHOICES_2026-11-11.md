# Composing the arithmetic improvements without mixing proof routes

2026-11-11. This records conditional operation-model results and compatible research choices. It is not a runtime estimate, a selected final implementation or a complete formal proof.

## Direct versus product-modulus checking in the MM0 model

The reviewed ordinary-PA arithmetic study supplies complete modular-square templates, including the quotient-times-modulus product and remainder bound. The byte-radix model with adaptive Karatsuba has costs 1297, 44049 and 422483 template events at 90, 718 and 2871 bits. These are proposed table/lemma application counts, not measured MM0 instructions. Numeral representation, substitutions, table setup, imports and producer work remain unpriced.

Compose those costs with the actual 44-square Proth certificate. For candidate moduli bounded by 10^27, the latter two widths suffice for products of eight and 32 candidates. The following comparison prices only the modular chains.

| Candidates in one product modulus | Modulus bits | Template subtotal for the chain | Subtotal divided by candidate count |
|---:|---:|---:|---:|
| 1 | 90 | 57068 | 57068 |
| 8 | 718 | 1938156 | 242269.5 |
| 32 | 2871 | 18589252 | 580914.125 |

Thus the eight- and 32-candidate product formats cost about 4.25 and 10.18 times the direct chains in this specific arithmetic subtotal, even after permitting Karatsuba. Product construction and CRT production are not included. Nor are any dispatch/import savings included. This strengthens the case for direct roots as the ordinary-PA comparison baseline; it does not prove a universal timing result for MM0 or Lean.

Arithmetic batching and proof packing are separate decisions. A proof pack can certify many direct 90-bit roots, reuse its digit facts and generic lemmas, and export one compact coverage conclusion. It need not multiply the candidate moduli together to amortize theorem/import overhead. No new instruction, arithmetic oracle or trusted pack-success flag is required by that architecture.

## Pricing the reviewed smooth-factor circuits consistently

At 90 bits the same model charges 1297 per modular square and 1565 per general modular product. Applying those prices gives the following arithmetic subtotals. Additions/subtractions in the last column are additional to those already inside the modular templates, and still need their complete modular normalization proofs.

| Certificate circuit | Wide witness coordinates | Modular arithmetic subtotal | Separate additions/subtractions |
|---|---:|---:|---:|
| Proth direct root | 1 | 57068 | 0 |
| Earlier m160 four roots plus inverse | 5 | 132456 | 10 |
| New m160 four roots plus inverse | 5 | 109785 | 14 |
| New m160 atomic cyclotomic roots | 11 | 77231 | 52 |

The five-coordinate improvement saves 22671 template events in the modular portion and adds four additions/subtractions at unchanged field count. The eleven-coordinate option trades less modular work for more root data and producer work. These rows are chosen explicit circuits, not an optimization over every weighted schedule. The Proth and smooth-factor rows also admit different prime candidates, so a per-success cost comparison cannot price their failed searches or their ability to fill every required gap.

The final cost for any row must include the actual accepted chain, all failed candidate/root searches, fallback factoring, root generation, source factor facts, residue decoding, gaps and terminal reach. This note supplies no successful-chain upper bound or empirical fallback rate.

## Keep the analytic routes distinct

The current conservative comparison uses the original analytic proof, with the reduced original finite-RH family and the separately reviewed threshold N=989*10^24. Its nonprincipal domain is odd c<=150000 and four-divisible c<=300000 with the original height profile; the principal chain remains separate. Those consumer refactors and all finite certificates still need formal proofs.

The mixed-radix character circuit is compatible with that domain. Its reviewed counts replace the whole-axis Bluestein circuit on the same coarse outputs. The product ratio .621939–.621940 and addition ratio .550472–.550473 apply only to that arithmetic stage. Shared Hurwitz seeds, interpolation, repairs, complete counts, roots/precision, data movement and proof assembly remain. They cannot all be multiplied by either ratio.

The earlier R=100000, N=10^36 cutoff experiment belongs to the QRH branch with finite .555 strips, the global 7/8 provider and its selected .65 energy input. It is not evidence that reducing the original-RH cutoff must raise its threshold to 10^36. It is also not an available improvement to combine with the conservative baseline while dropping its QRH assumptions. A new original-route study is checking R=140000 near the existing threshold; its result is pending and receives no saving here.

The ladder-free prime-gap alternative is another complete branch choice. Its reviewed Q=47 point needs principal RH through 1.88e12 and binary coverage through 2e16, plus its new Logan analysis. It replaces the explicit ladder only after those facts are proved. Its principal spectral cost must be added before comparing it with the direct-root plan.

## Foundation and evidence boundaries

The MM0 operation model is ordinary PA arithmetic. A complete MM0 Goldbach proof also needs the analytic derivation in an appropriate explicit foundation and a proved arithmetic interpretation. The reviewed architecture note identifies these obligations; it establishes no completed PA translation of the analysis. The installed Lean declaration exporter can supply proof/dependency syntax, but does not itself generate ordinary-MM0 typing and conversion proofs.

The coordinator read the complete square/Karatsuba and grouped-cyclotomic author/review pairs, and the mixed-radix author/review pair. Their bounded mathematical results are accepted for planning, not promoted to kernel-checked statements. The composition script `compose_certificate_costs_20261111.py` checks the hashes of the arithmetic and grouped schedule receipts and computes only integer/fraction subtotals. Its receipt SHA256 is `B9CF2B0A9D0CB7D483ED3F7E1700944AB6E11A75F42E561C78B63D471E556549`. Independent review of this new composition remains pending.

No Lean/MM0 build, numerical certificate, prime search or analytic value was produced.

DRAFT_ANCHORS: 0 created
UNREGISTERED_SORRIES: 0 introduced
DRAFT_IMPORT_VIOLATIONS: 0 introduced
SEALED_THIS_TURN: 0
