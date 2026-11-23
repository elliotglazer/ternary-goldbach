# Review of the joint final-seed cost comparison

2026-11-11. PASS at conditional cost-algebra and integer-metadata scope, without correction. The reviewed author note is `zero-sum/JOINT_FINAL_SEED_CONDITIONAL_COST_COMPARISON_2026-11-11.md`, SHA256 `369DD6AB04FC68ACB675BBFB24518E2CD025C0D8416D07A99A5BC747F7E86249`.

This verdict concerns the frozen m256 joint construction. A later m224 refinement is a separate proposal and is not substituted into any row here. No elementary, L-function, prime, zero or transform values were evaluated. No build, new Lean declaration, producer import, or frozen-file modification occurred.

## Construction and scope

I read the complete cost note and its script, the joint mathematical author and independent review, and my earlier three-way cost note. The joint mathematical prerequisite is `major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md`, SHA256 `AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F`, with independent review `audit/REVIEW_JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md`, SHA256 `2F057C0F2507452AC959587E13FD1AE8F9117FC75CBC3BA1C6364E8C5BF0064A`. That review supplies the joint error argument; this cost review does not repeat its analytic estimates or infer the conjunction from separate savings percentages.

All four constructions produce the same fine P20 output at denominator16384 and normalization8192. B and C use D8192/P27 with twenty orders only at the right endpoint. Q and J use D4096/P28 with all twenty-eight orders at every coarse endpoint, including the right endpoint needed for negative-quarter translation. J uses N1500 and m256. The four earlier bands are common.

## Independent counts and lifetimes

I reconstructed the operation rows from these parameters, rather than importing the producer. For a D4096 row, source slots are 28(D+1), head scales N*27(D+1), head additions N*28(D+1), and each gamma category m*28(D+1). E stages number (28+2m-2)(D+1). The three signed shifts use 3D*350 updates. Each of the twenty output orders at all16385 fine anchors receives its stated normalization and final round.

At J these give 165928500 head scales, 172074000 head additions, 29367296 gamma scales and separately as many gamma additions, 2204186 E stages, 114716 source slots, 4097 anchors, 27 R stages, 4300800 translation updates, and 327700 normalization scales and separately rounds. Its per-height argument and EM-copy count is 1501*4096+1=6148097. All match the frozen row.

The prior complete argument union is 1721*4096+1=7049217. The final J set is a subset, retiring901120 arguments and introducing none. Therefore every retained state updates across the first final-band boundary, and J's final update count is 6148097H. Subtracting the union or the retired count would be wrong. The author subtracts neither.

I checked all four H values, 20199,20366,20519,20839. With the common64001 earlier heights they give total84200,84367,84520,84840. The largest ordinate424195/64 remains below7000. These are conditional auxiliary-prefix scenarios, not evidence that any particular prefix closes a sign/count test.

J's retained log recipe has 960 anchors and 21*(7049217-960)=148013397 nonanchor Horner stages. Those logs are needed before the final transition; zero new final log blocks does not erase their setup cost. C's deliberately larger log grid still has296046954 stages despite its smaller actual state union. Q's and B's different anchor layouts retain their own costs. No false anchor-set containment is used.

## Signs in the three comparisons

With the author's category prices, the common identity is

    C_i-C_J = H*(L_i-L_J+(X_i-X_J)*(s+c)) + F_iJ,
    F_iJ = S_i-S_J-(I_i-I_J)*s.

The sign before the introduced-state difference is negative: initialization replaces that first recurrence update. The EM copy still occurs, so its difference is H*(X_i-X_J), without the initialization subtraction. I independently checked these coefficients for every prefix and all three comparisons.

For Q versus J, the only changed listed non-state categories are 98119053 fewer head scales and101753092 fewer head additions against22025472 additional gamma scales, the same number of gamma additions, and1573248 additional E stages. J also removes3633152 state updates/copies per final height, before the setup adjustment. Translation, normalization, source-slot, anchor and R counts are equal. This reproduces the displayed Q/J inequality exactly.

For B/J and C/J, moving the negative row differences to the left produces exactly the displayed extra translation, normalization and R charges. B/J also retains J's added gamma/E work. C/J instead has savings in both correction categories. Each inequality therefore gives a necessary and sufficient comparison within its stated common-price model, not a runtime conclusion.

The optional setup differences also match independently:

    F_BJ =12513280*(i-s)+262778019*l+41*z-Gamma-Lambda+Delta_BJ,
    F_QJ = 2732032*(i-s)+ 57371790*l+42*z-Gamma       +Delta_QJ,
    F_CJ = 6148096*(i-s)+148033557*l-   z      -Lambda+Delta_CJ.

The introduced-argument differences equal the union differences because the preceding union is common. The extra gamma setup is present in C and J, and the extra D4096 lambda entry in Q and J. Thus all signs, including the negative single-anchor term in F_CJ, are correct. Gamma prices the complete additional certified construction through Bernoulli index512, not merely192 unit-cost additions. Delta correctly retains unpriced binding, traffic and representation work.

## Limits retained

Common fractional-error targets do not imply equal total operand widths or equal gate prices. J changes the correction depth and the magnitude/distribution of intermediate expressions. The note explicitly requires route-specific sums when the common-price model does not apply. Residual source-slot and anchor prices must exclude work already counted elsewhere.

State retirement is a logical lifetime fact, not a measured peak-memory saving. Stored-center bounds do not bound raw rational denominators, multiplication temporaries or proof objects. Actual leaf certificates, spectral values, signs, completeness, and ordinary Lean/MM0 acceptance remain open. This review establishes no fastest choice and credits no m224 successor.

## Evidence

Owned `review_joint_final_seed_cost_20261111.py`, SHA256 `9FD86B4CB18B2B09AD3F1132B140F6B8370D8DDFF01978E41DC6DD71BB6E9B76`, passed372 independent exact checks. Its receipt `review_joint_final_seed_cost_20261111.json` has SHA256 `C77F6F4E1C5A8B63A632ABDC35119A659AAF2BB6E283A8D4148B4295A6A4C598`. It records all reconstructed rows, setup differences and nine checked input pins.

Besides the author and prerequisite notes above, those pins include the author cost script `D3205492D6BB3268389CF77018883FE933B3DB4F5FE043D3E23B4C6FF809BD51`, cost receipt `30EF060C3A13338B6336F208012475A48B5B6B511D92CB58499AE9358D07CECD`, joint mathematical receipt `F1686B1C1A3183082D9126F4FE680BE6DB42A88D31F82071B752759EE3DE9BD4`, prior three-way note `DEB728C9991A4B906B49D65651CD8E6C994CF814C0091809A3CB7138A157D1B2`, its receipt `7E8ABFDC0F2A212B975738DE94D17448F8A6C9EA597D3203A01933A4FB8882E9`, and its independent review `168F3FE5497E9923DE193324E470EA5F37337A724525C35589E19BD5328EA5F9`. Paths in this review are relative to `work/qrh-campaign/agents`.
