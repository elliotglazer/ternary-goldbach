# Review of the large character transform PA cost model

2026-11-11. PASS at conditional arithmetic-design and saved-metadata scope. No correction requested. The packet gives a matched product/addition model with explicit remaining prices. It establishes neither an actual spectral precision nor a complete cost winner.

The author is `integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md`, SHA256 `DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C`. Its script is `B9D4D1333FC83ECC70D6C82CB96159B4E0A98EB29C4453AF66B632C6295D6589`, and its receipt is `B13699002FCB232B67FD9F973C8E2497D8984A14179C7D7ABCA6D306890CFFB5`. Paths in this review are relative to `work/qrh-campaign/agents`.

## Independent work

I read the complete frozen report and script, the fixed-three-product contract and its review, the mixed-radix precision supplement, the intermediate-width proof, and the saved-multiplicity evidence map. I checked the defining full/pruned Bluestein, direct and CT count branches in the pinned inventory source. I compared the signed Horner formulas with the previously reviewed schedule and the saved prefix magnitude fields. No inventory generator or author program was imported or executed.

The independent script `independent-feasibility/review_large_transform_pa_cost_20261111.py`, SHA256 `16150D9505ABC09D396A34CBDB87606A5E6A4765E05C3F57AF7B95FCF9B41F0B`, performs 3749 exact checks. Its receipt is `independent-feasibility/review_large_transform_pa_cost_20261111.json`, SHA256 `CB7C215BA5EEAF2BA658BA3BA53E761564A9C0EDD60A2348E413A669DD3BCFB3`. It checks all input pins, all three candidate precision rows, both product implementations and coefficient types, all four scenario joins, and all 66 Horner prefixes comprising 924 saved stages. Integer dyadic-boundary checks supplement the algebraic rounding argument. These are metadata and witness-identity checks, not evaluated transform coefficients.

The reused mathematical contracts remain fixed at three-product `087A3DF1B2DD49C5C0BB38E00DA9CD9830E41807C6F07A8BBB34502CFF65355D`, precision `4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4`, and intermediate width `5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A`. The signed Horner schedule is `531DD23307CED3ED958198C750393D933287809B9E42EF738888370AA4DE4474`, with independent review `40AE12EEFE142B932820F6462E6DE7CE127679A0CE220010148C698E984BBFF1`. The independent receipt retains the other exact source and data pins.

## Precision and width hypotheses

The intrinsic arithmetic comparison can be applied to the exact transform of the stored input centers. Their separate analytic error then passes through the exact linear transform. This justifies using V0=M+1 in the intrinsic estimate without suppressing the separately transported input error E0. The input bridge M+1<2^14 is conditional on the stated stored polynomial bound, finite-head normalization and radius at most one. That radius only supports the magnitude bound; it is not a useful sign certificate by itself.

For epsilon_T=2^-s, the sufficient selector requires

    2^p >= max(D_safe, 2*S_old, 1266*S_mixed*2^(14+s)).

With the saved maxima it gives exactly p=112,134,152 for s=60,82,100. These are minima of these three conservative inequalities only. In particular the p134 row does not establish that a total 2^-82 sign tolerance holds. Alpha truncation, input/source errors, finite-head generation, conductor scaling and phase/interpolation still consume their separate budgets. Exact embedding of the grid100 output into these grids introduces no new error and improves none of the old errors.

The inherited common peak yields data magnitude bits a=p+68. Root centers have b=p+1. A padded Bluestein kernel has exact norm at most 2n-1 and setup error below one at the displayed precisions. For its n>=2 leaf, the even power-of-two P>=2n-1 satisfies P>=2n, so the maximum P=2^18 gives b=p+18. The nonunit kernel therefore receives its own coefficient width and uncertainty. The inverse FFT before its division remains covered by the inherited peak theorem.

Generic three-product outputs need a+b+2 magnitude bits; four-product outputs need a+b+1. Sign allocations and dyadic-witness additions are extra. The sharper semantic raw result bound does not permit free trimming of the padded schoolbook operands. Common peak widths are a safe specified allocation, not the actual width of each gate. Arbitrary floating exponent gaps are outside this bounded common-grid argument.

## Center algebra and ordinary rounding

For stored integer coordinates A,B,C,D, put T=C(A+B), U=B(C+D), V=A(D-C). Then T-U=AC-BD and T+V=AD+BC. Exact cached C+D and D-C preserve the original coefficient uncertainty and correlation. Their construction and provenance are charged once per actual cache key. A rounded cache would need the separate accepted error fallback and a new price; it is not silently included here.

For d>=1, checking

    N+2^(d-1)=Q*2^d+t, 0<=t<2^d

gives 2(N-Q*2^d)=2t-2^d, hence -2^d<=2(N-Q*2^d)<2^d. This is nearest rounding with negative ties handled by the same rule. Two signed addition equalities and a checked remainder encoding suffice; Q*2^d is a shift, not an arbitrary-divisor product. Raw capacities are allocated before using the residual equality. The separate d=0 exact branch prevents an invalid half-integer shift. Bluestein's final power-of-two division uses the same witness at its own d.

Each fixed-three-product gate has three unsigned products and seven signed-add cores: one data presum, two output sums and four coordinate-round witness additions. Four-product gates have four products and six add cores. Complex additions use two exact same-grid additions. A complex dyadic division uses four witness additions. All sign/zero cases, canonical numeral equalities, ranges, shifts and rounding lemmas remain explicit costs beyond the natural arithmetic core.

At p134 I recover root cores 7310 versus 9502, and kernel cores 8390 versus 10582, for three versus four products. The core difference 2192 is valid in this declared padded template. It is not a complete implementation saving because cache construction, representation, signed bridges and memory differ.

## Saved multiplicities and matched Horner comparison

The full Bluestein branch adds P cached-kernel products and P inverse divisions. The pruned branch keeps all P of each and removes only appropriate final chirps. Other direct, radix-two and CT branches introduce no divisions apart from child counts. Thus induction on this specific count circuit gives G_kernel=D and G_root=G-D. This is an exact recoverable statistic, not a general property of a field named dyadic_scales.

For the current main scenario, G_root=915527265950592 and G_kernel=88576420247296. The p134 three-product core is

    7310*G + 106*A + 1292*D = 7674906601984255182.

The four-product counterpart is 9875901882130025678. All four node-extension scenarios and both type envelopes match. The envelopes retained in the receipt are sensitivity cases, not alternative factual type assignments.

The Horner reconstruction includes the rM and Lv products already present in the reviewed prefix ledger. Its four natural additions per real stage are the raw residual, doubled residual plus denominator, natural upper-range guard, and coefficient addition. The raw range guard remains a three-byte operation before its equality is accepted. The first input, each output grid and the final coefficient addition use their saved bounds. This reproduces the full-degree references and all shorter prefixes. The main fixed-profile subtotal is 629423206484140848 product events plus 166532579033683776 addition events, or 795955785517824624 core events. Its full price still includes source conversion, signed bridges, quotient discovery, binding and actual cache lifetime.

The author's comparison T_core-H_core > H_rest-T_rest is the correct complete-cost condition in one declared price model. Separate product and addition weights are also allowed. Subtracting padded cores or taking their ratio does not establish which actual computation is more expensive. The current three Horner profiles are not asserted to be optimal, and the reviewed joint length/grid alternatives require their own compatible error and width joins.

## Setup, unresolved costs and scope

The saved setup and the candidate table union give 1594383871 coefficient entries and twice that many exact cache-sum constructions. This is a redundant sufficient table design, not a memory-residency claim. Kernel construction has its own forward-transform arithmetic. Roots/chirps, their enclosures, kernel errors and cache identities require proofs. Rebuilding or loading a dropped cache is not free.

The saved data supplies aggregate root/kernel counts and whole-axis error/peak tables. It does not supply current stage/type/height width multiplicities, per-P occurrence weights, a selected precision distribution or proved cache lifetimes. The requested joint export in section 8 is therefore a real remaining prerequisite for a tighter arithmetic total. Separate generation, proof-production and ordinary-checking prices are necessary. PA event cores cannot be substituted directly for Lean reductions or elapsed time, and no native arithmetic axiom is accepted by this review.

No numerical function, transform, root, sign or zero was evaluated. No Lean/MM0 build, declaration or source change was made. No frozen artifact was modified. This review accepts the conditional arithmetic and cost comparison interface, not actual spectral success, implementation completeness or end-to-end dominance.
