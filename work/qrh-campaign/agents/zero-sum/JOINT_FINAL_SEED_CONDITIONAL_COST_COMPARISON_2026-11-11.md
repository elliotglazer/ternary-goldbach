# A fourth row in the final seed cost comparison

2026-11-11. Conditional cost comparison after independent joint mathematical review. No values, builds or performance measurements. The three-way author report and all previous receipts remain unchanged.

The joint construction `major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md`, SHA256 `AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F`, now has independent PASS at `audit/REVIEW_JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md`, SHA256 `2F057C0F2507452AC959587E13FD1AE8F9117FC75CBC3BA1C6364E8C5BF0064A`. It is therefore a legitimate fourth mathematical alternative. Its separate joint error proof is essential; this comparison does not infer it by combining two independent savings percentages.

Use B,Q,C as in `independent-feasibility/FINAL_SEED_CONDITIONAL_COST_CHOICE_2026-11-11.md`, SHA256 `DEB728C9991A4B906B49D65651CD8E6C994CF814C0091809A3CB7138A157D1B2`. The new label J denotes the joint D4096/P28/N1500/m256 construction, not a height count. All four rows deliver the same fine P20 interface, normalization8192 and grid denominator16384. Compare the same H final heights; the +640 example has H20839 and total84840. The metadata also records H20199,20366,20519. No auxiliary success is assumed.

## Joint row and transition

| Per final height | J |
|---|---:|
| Head rational scales |165928500|
| Head additions |172074000|
| Gamma scales, and separately gamma additions |29367296|
| E complex stages |2204186|
| Source slots |114716|
| Coarse anchors |4097|
| R stages |27|
| Translation updates |4300800|
| Extra normalization scales, and separately rounds |327700|
| Argument pairs / EM copies |6148097|

J's final arguments are a subset of the preceding D4096 grid. Its total required argument union is7049217, with no new arguments at the final transition and901120 retired states. Every retained state updates at the first final height, so J has exactly6148097H final fine-state updates. It cannot subtract its whole union from that count. Its existing log construction has960 anchors and148013397 Horner stages, all required before the final transition. No final log block is added.

J needs the same extra lambda entry as Q and the same192 extra gamma constants as C. Actual certified construction through Bernoulli index512 remains charged. Endpoint assembly, denominators, coefficient exports, data bindings and exact intermediate widths remain required.

## Three new break-even inequalities

Retain the nonnegative common category prices h,a,g,b,e,o,v,r,t,n,s,c of the reviewed three-way note. In particular n prices one extra scale plus its final round, while g and b price gamma multiplication and addition separately. S_i denotes all nonlisted setup and implementation cost with no double counting. Define

`F_iJ = S_i-S_J-(I_i-I_J)s`, with `I_J=0`.

As in the reviewed identity, `C_i-C_J=H[L_i-L_J+(X_i-X_J)(s+c)]+F_iJ`. Thus J costs less than B precisely when

```
15210240(g+b)+950664e+1597440t+327700n+r
 <342528757h+355939948a+106488o+4096v
   +13414400(s+c)+F_BJ/H.
```

J costs less than Q precisely when

```
22025472(g+b)+1573248e
 <98119053h+101753092a+3633152(s+c)+F_QJ/H.
```

J costs less than C precisely when

```
1597440t+327700n+r
 <153588000h+159732000a+27260928(g+b)+2195448e
   +106488o+4096v+6148096(s+c)+F_CJ/H.
```

These comparisons show the remaining choices directly. Relative to Q, J removes head and state work but adds gamma and E work; translation and normalization counts are identical. Relative to C, J removes work in all displayed head and correction categories but retains the extra quarter-mesh translation and normalization bill. Neither observation proves a runtime ordering.

Under the same optional simple setup pricing as the three-way note, let i price an argument's non-log initialization/amplitude/step package, l a log Horner gate, z an anchor certificate, Gamma the whole extra gamma setup, and Lambda the extra D4096 lambda setup. Then

```
F_BJ =12513280(i-s)+262778019l+41z-Gamma-Lambda+Delta_BJ,
F_QJ = 2732032(i-s)+ 57371790l+42z-Gamma       +Delta_QJ,
F_CJ = 6148096(i-s)+148033557l- z      -Lambda+Delta_CJ.
```

The differences in unions equal the differences in introduced arguments because every row has the same previous7049217-point union. This explains the `(i-s)` terms. Their interpretation is saved setup minus the updates that initialization had replaced, not free first-state computation. Delta retains unmodeled proof bindings, traffic, schedule and representation costs. A possible negative `(i-s)` or negative total F is allowed by the algebra. The logarithm recipes use different anchor layouts, so there is no assumption that one anchor certificate set contains another.

## What should be priced next

The Q-versus-J test is the narrowest new choice: it trades about98 million head scales and102 million head additions per final height against about22 million gamma scales and additions and1.57 million E stages. It also removes3.63 million state updates/copies per height, with a smaller setup union. Price those actual operation families and their ordinary proof costs before selecting either route.

The joint review supplies sufficient normalized error bounds, not equal gate costs. Gamma factors, E depth, endpoint denominators and retained source slots have different operand distributions. If their costs depend on route, order, height or representation, replace every common-price product above by the corresponding actual sum. A common upper bound on costs is insufficient to order two implementations. Native generation, independent checking, serialized proof size and development effort must remain separate objectives.

Stored-center bounds and fractional precision do not bound all exact intermediates or make setup free. No timing winner, optimality, successful enclosure, zero certificate or end-to-end speed ratio is asserted. The earlier four bands, final residue/character transforms and sign/completeness obligations are unchanged.

## Exact evidence

The new `zero-sum/joint_final_seed_cost_comparison_20261111.py` derives J from the actual retained-order counts, checks it against the reviewed joint receipt, and forms the three signed differences. It checks all four common prefixes and introduces no analytic evaluation. Its same-stem JSON records69 successful checks, all four rows, lifetime totals, differences and exact input hashes.

The script SHA256 is `D3205492D6BB3268389CF77018883FE933B3DB4F5FE043D3E23B4C6FF809BD51`; the receipt SHA256 is `30EF060C3A13338B6336F208012475A48B5B6B511D92CB58499AE9358D07CECD`.

The preceding independent three-way review is `zero-sum/REVIEW_FINAL_SEED_CONDITIONAL_COST_CHOICE_2026-11-11.md`, SHA256 `168F3FE5497E9923DE193324E470EA5F37337A724525C35589E19BD5328EA5F9`. The joint analytic review is reused here at its stated paper scope; this note is a cost extension, not a second analytic review of the joint construction. Paths in this note are relative to `work/qrh-campaign/agents/`.
