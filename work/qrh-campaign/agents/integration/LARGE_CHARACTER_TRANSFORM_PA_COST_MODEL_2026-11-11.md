# A typed ordinary-PA cost model for the large character transform

2026-11-11. Paper arithmetic design and exact calculations from frozen receipts. No geometry, conductor or unit scan, function/root/transform value, build, declaration or source edit was performed. This is a candidate implementation and cost model requiring independent review. It does not select a new transform or certify a sign.

The current main ledger contains **1004103686197888 complex products**, 2079886046397995 complex additions/subtractions and 88576420247296 complex dyadic divisions. These are now mapped to the same byte-schoolbook PA multiplication template used for narrowed Horner, with explicit addition, rounding, signed, range, representation and cache terms. The saved circuit permits an exact type split: 915527265950592 root/chirp products and 88576420247296 cached-kernel products. Their stagewise operand widths are not retained. The model therefore uses exact type counts and a conservative common-width design, without pretending to know the missing width distribution.

The main consequence is a concrete comparison target. Under the illustrative transform-arithmetic allocation below, the conservative three-real-product templates cost6735 unsigned product events for root gates and7791 for kernel gates. The narrowed fixed-profile Horner product subtotal, divided by the number of transform gates, is only `39338950405258803/62756480387368`, between626 and627. This makes transform operand/precision pricing consequential. It is not a lower bound on actual transform cost: global peak padding is deliberately loose, and no event-to-time ratio is inferred.

## 1. Consumed circuit, arithmetic contract and input bridge

The accepted fixed three-product refinement `087A3DF1...`, independent review, mixed precision proof `4AD43D7D...` and peak proof `5327CD06...` are the mathematical inputs. The circuit is the existing positive, unnormalized product-group transform, including CT, direct leaves, radix-two stages and Bluestein. Original-order primitive-output pruning retains a dependency-closed part of that same circuit. No reordering, additional output pruning or replacement transform is proposed.

Every runtime multiplier is fixed independently of the current data line: a root/chirp or a cached Bluestein kernel coefficient. The latter is uncertain and nonunit; its enclosure is not replaced by a unit-root hypothesis. Root generation and kernel construction remain prerequisite work.

Use a common coordinate grid `h=2^-p`. Coefficient centers and transform inputs must be on it, or be exactly aligned with checked bounded shifts. The three-product algebra computes exact integer intermediates and rounds only the final real and imaginary coordinates. All common-grid complex additions/subtractions can be exact: their output is already on the grid. This supplies error zero, hence satisfies the old absolute addition-error allowance u. It does not introduce a new numerical circuit approximation. Permutations, signs and quarter turns are exact too, with their binding/sign proofs charged.

A concrete sufficient input-magnitude bridge is available without evaluating inputs. The reviewed stored-degree bounds give the consumed Hurwitz polynomial center norm below8192, including any accepted shorter prefix/profile. If the raw residue transform also includes the finite head `alpha^-s`, its true norm is `alpha^-1/2<=sqrt(c)<633`. Require its center radius at most1, form the sum exactly on the common grid, and obtain stored input magnitude M with `M+1<8192+633+1+1<2^14`. Its actual much tighter error E0 remains a separate input requirement. A norm bound of1 is used here only to bound magnitude; it is not sufficient to certify a sign. If the head is instead assembled in another normalization, retain that producer and its costs rather than silently use this combined-input bridge.

The final Horner grid100 embeds exactly into any p>=100 by a left shift. Its coefficient/source uncertainty does not decrease upon embedding. Any narrower or floating input encoding needs its own exact alignment proof. Head generation, input conversion, conductor multiplication and Hardy/phase normalization are outside the character-transform operation counts and remain separately charged.

## 2. Fractional precision is a parameter, not a hidden existing choice

No current large-family ledger fixes a universal p. For stored input centers bounded by M and `V0=M+1`, the accepted intrinsic transform error, after conductor scaling, is at most

    2*(phi(c)/sqrt(c))*S(c)*u*V0 <=1266*S(c)*V0*u.

Input analytic/numerical uncertainty is separately transported by the exact transform. It must not be recharged through every stage, or omitted because this intrinsic error is small. The factor633 is the inherited conservative bound. Kernel uncertainty and root uncertainty are already included in the intrinsic proof under its hypotheses.

For a chosen conductor-scaled **transform arithmetic** allowance `epsilon_T`, a sufficient p satisfies

    2^-p <= 1/D_safe,
    2*S_old*2^-p <=1,
    1266*S_mixed*V0*2^-p <=epsilon_T.

I keep the stronger baseline safety conditions used by the inherited peak proof. The saved full-family maxima are `D_safe=29961461170177`, `S_old=424706204`, `S_mixed=202305920`. They cover the present subfamily without a new scan. With `V0<=2^14`, the exact minimal integer p for THESE three sufficient inequalities is:

|Candidate epsilon_T|p|
|---|---:|
|2^-60|112|
|2^-82|134|
|2^-100|152|

These are explicit candidate allocations, not an adopted final sign budget or optimal precision. In particular epsilon_T=2^-82 is additional to the isolated alpha allocation of that size and to the finite head, scaling, phase and interpolation errors. The full sign radius must add all of them. Source input uncertainty can prevent any requested total tolerance even when this intrinsic arithmetic allocation is met.

## 3. Operand classes and raw capacities

Let a,b be **magnitude-bit** capacities: data coordinates have integer magnitudes below2^a, and coefficient coordinates below2^b. Signed encodings add their sign representation.

The inherited whole-circuit peak coefficient has ceiling logarithm54. With `V0<=2^14`, all data integer coordinates therefore fit the conservative `a=p+68` magnitude bits; p+69 is a sufficient signed allocation. This is a common peak design, not the actual width at every stage.

Approximate unit roots have norm below2 since their error u<1, giving `b_root=p+1`. For a Bluestein leaf of length n, the exact kernel FFT has norm at most2n-1 and error strictly below1 at the displayed p. The saved maximum padded length is262144=2^18. Since P is the least power of two at least2n-1, `2n<=P` for these n>=2 leaves. Thus stored kernel norm is strictly below2n<=2^18, and `b_kernel=p+18` suffices. A tighter local record may use its actual n and enclosure.

For four real products, each product fits a+b magnitude bits and the two output sums fit `r4=a+b+1`. For the fixed three-product identity, exact data and coefficient presums need a+1 and b+1 magnitude bits. The products have shapes `(a+1,b)`, `(a,b+1)`, `(a,b+1)`, and their output sums fit `r3=a+b+2`. All these widths are before cancellation.

The accepted norm-product argument separately gives a sharper semantic three-product raw signed cap `2p+14+54+5`. It can justify trimming proved high zero digits. It does not permit silently shortening the padded schoolbook inputs or skipping the proof of those zeros. The explicit templates below retain the generic rectangular raw capacities for scratch and witness construction. Consequently their kernel scratch can be wider than that semantic cap without contradicting it.

At p134:

|Quantity|Root gate|Kernel gate|
|---|---:|---:|
|Data magnitude bits a|202|202|
|Coefficient magnitude bits b|135|152|
|Three-product data presum, signed|204|204|
|Three-product coefficient presum, signed|137|154|
|Three-product generic raw output, signed|340|357|
|Three-product dyadic witness addition, signed|342|359|
|Four-product generic raw output, signed|339|356|

The common semantic three-product raw cap is341 signed bits. Both the larger safe generic scratch and the smaller proved semantic result must be distinguished from an observed value width.

## 4. Exact dyadic rounding has no general quotient product

For an integer N on grid h squared, the rounded output Q on grid h satisfies

    -2^p <=2*(N-Q*2^p)<2^p.

A deterministic ordinary-PA witness can instead supply `t` with `0<=t<2^p` and check

    N+2^(p-1)=Q*2^p+t.                         (R)

Subtracting gives the required closed-lower/open-upper interval, including negative ties toward positive infinity. The product by2^p is an exact digit concatenation/shift, **not a generic multiplication proof**. The t range comes from its checked p-bit representation. Two signed additions establish(R): construct the left sum and the right sum, then identify their common canonical numeral. A fixed PA lemma turns that equality and range into nearest rounding. The producer can obtain Q,t by bit splitting of the signed shifted input; generation is still work, but no arbitrary-divisor long division is required.

If `|N|<2^r` and 1<=p<=r, then `|Q|<2^(r-p+1)`. A safe magnitude capacity for both witness additions is r+2, before checking their equality. This yields two signed additions per scalar round. No small-residual assumption is used to allocate these raw additions.

Bluestein's final division by `P=2^k`, 1<=k<=18, uses exactly the same witness with d=k on a grid-p numerator. Two coordinates need four signed additions, shift/concatenation and range proofs. A generic d=0 interface instead uses the exact identity Q=N; it must not instantiate a fractional half-power in (R). If divisibility or a finer exact representation is supplied, a cheaper exact branch can be separately proved. The present common-grid design charges rounding and retains the old error allowance. Same-grid complex additions need two signed additions and no rounding witness.

## 5. Ordinary-PA template vector, including the missing nonmultiplication terms

Use the same proposed byte-schoolbook primitives as the Horner comparison:

    M(a,b)=5mn+2n+1,
      m=max(ceil(a/8),ceil(b/8)), n=min(...);
    A(w)=2ceil(w/8)+1.

M is an unsigned product's digit-table/lifting/row event core. A is one unsigned addition-with-carry core. A signed addition is reduced by a checked sign case to one such magnitude-addition equality: same-sign magnitudes add; in an opposite-sign branch the result magnitude plus the smaller magnitude equals the larger. The equality itself supports the order branch. A signed multiplication uses one unsigned product plus the sign rule. Canonical zero signs, ranges and encoding must be checked.

Define fully priced operations `SM(a,b)=M(a,b)+signed-product/representation costs` and `SA(w)=A(w)+signed-add/representation costs`. Let `DR(r,d)` include two SA(r+2), the exact Q shift, the d-bit remainder range, canonical equality/binding and the fixed nearest-round lemma. This explicitly lists every arithmetic action; it does not declare the additional terms zero or equate one template event to one executed MM0 opcode.

The typed runtime gates are

    C3(a,b,p)=SM(a+1,b)+2SM(a,b+1)
               +SA(a+1)+2SA(r3)+2DR(r3,p)+complex-identity binding;
    C4(a,b,p)=4SM(a,b)+2SA(r4)+2DR(r4,p)+complex-identity binding;
    Cadd(a)=2SA(a+1)+complex-add binding;
    Cscale(a,k)=2DR(a,k)+division identity/binding.

C3 uses cached exact C+D and D-C. Cache construction costs two SA(b+1) per distinct coefficient object, not per use. If independently rounded cached sums are chosen instead, the accepted residual-budget fallback needs its own precision, arithmetic and cache model; it is not priced here. All runtime multipliers are fixed, but their arithmetic is still a product with a data-dependent integer. A table/constant-multiplier shortcut requires its own ordinary proof and setup break-even.

The displayed **core** omits only the explicitly named wrapper/representation terms. Per three-product gate it contains three unsigned products and seven signed-addition cores: one data presum, two raw output sums and four rounding-witness additions. Four-product gates use four unsigned products and six addition cores. A complex addition contributes two cores, and a complex dyadic division contributes four. These counts include the dyadic witnesses rather than price a complex multiply as three naked products.

At p134 the padded core is:

|Gate|Product core|Exact center-add core|Round-witness add core|Total core|
|---|---:|---:|---:|---:|
|Root, three real products|6735|227|348|7310|
|Root, four real products|8980|174|348|9502|
|Kernel, three real products|7791|235|364|8390|
|Kernel, four real products|10036|182|364|10582|

Common complex-add core is106; common complex-dyadic-division core is212. Three-product core is smaller by2192 in either class here, but its cached sums, larger temporaries and extra signed-add wrapper can still affect the complete comparison. The receipt also gives p112 and p152 rows. This is a candidate PA-derived digit library; its generic lifting/sign/round lemmas and concrete proof emission remain implementation obligations, not new arithmetic axioms. The inherited peano_hex coercion axioms are not silently adopted as PA arithmetic.

## 6. Current ledger and the exact comparison inequality

For known typed gate multiplicities, a complete price is

    T = sum_root Croot(a_g,b_g,p_g)
       +sum_kernel Ckernel(a_g,b_g,p_g)
       +sum_add Cadd(a_g)+sum_scale Cscale(a_g,k_g)
       +quarter-turn/negation/permutation/binding costs
       +input alignment + roots/chirps + kernel setup
       +cache-sum setup + encoding/storage/checkpoint costs.

Use a distinct price functional for generation, proof production and ordinary checking. Generation includes elementary root certification, exact integer operations and witness extraction; proof production includes numeral DAGs, digit facts, references and serialization; checking includes their actual inferences/unification and data access. Lean can consume the same circuit and witnesses with its own integer representation, but the PA event counts do not become Lean reductions or timings. Same-rule widened/streamed MM0 implementations remain allowed; they change engineering and metadata costs, not the arithmetic inference rules.

The saved circuit does identify the aggregate type split, even though it does not save stagewise widths. In the pinned `conditional_r132900_pruning_inventory_20261111.py`, full and pruned Bluestein each add exactly P cached-kernel point products and P inverse-normalization dyadic scales. All other direct/radix-two/CT operations add no dyadic scales except those inherited from their children. Pruning retains the whole padded inverse. Induction on this circuit and linear height aggregation therefore give **G_kernel=D and G_root=G-D**. This is not the assertion that dyadic scales themselves are products; it is a one-to-one count identity for this particular implementation. Zero_sum first identified this recoverable statistic; I independently checked its defining branches. The p134 three-product padded core is

    7310(G-D)+8390D+106A+212D =7310G+106A+1292D.

Here D is the ledger's number of complex dyadic divisions. This is an exact formula for the specified padded template and existing count categories. It is not a lower bound on an implementation using local widths, nor a runtime prediction.

For the main scenario, the three-product core is

    7674906601984255182.

It excludes the named setup, sign, range, representation, sharing and binding prices. The analogous four-product core is9875901882130025678. The receipt also keeps all-root/all-kernel sensitivity envelopes, explicitly not the actual category mix. All four requested-node alternatives are retained; no Turing-success assumption enters them.

For an honest comparison with narrowed Horner write `H=H_core+H_rest` under the same units. The accepted signed Horner schedule supplies four natural addition cores per real stage: residual construction, lower-range witness, a 22-bit upper-range guard, and coefficient addition. Its signed bridges, shifts, range/binding lemmas and quotient discovery remain separately priced. Applying those formulas to every reviewed prefix stage, with the actual saved input/product/output bounds, reconstructs all six full-degree reference addition totals and all 66 prefix cases. For the reviewed constant band lengths19/19/19/20/18 the main totals are:

|Horner profile|Unsigned product core|Natural addition core|Sum H_core|
|---|---:|---:|---:|
|uniform100|726797499348500688|185035683913651872|911833183262152560|
|root_linear|658293656237169168|172060505544086496|830354161781255664|
|fixed_15442|629423206484140848|166532579033683776|795955785517824624|

These are candidate-template event totals, not complete Horner costs. In particular Horner's small denominator v needs the checked Lv product already counted in its product core; transforms' power-of-two rounds need no such general product. Other reviewed joint length/precision choices can be inserted with their own exact widths and new output-radius contract; this comparison does not declare the three displayed profiles optimal.

Let T_core be the selected typed transform core, and T_rest all its remaining terms. The transform is more expensive in this specified cost model exactly when

    T_core-H_core > H_rest-T_rest.

For the most economical of the three fixed Horner product rows, the product-only crossover per transform G is the rational fraction in the opening paragraph. Different product/addition prices can instead weight the two columns separately. No claim about complete dominance follows by deleting H_rest or comparing unrelated padded upper bounds. The main ledger has about16.745 transform product gates per residue input, so substantially smaller actual transform operands or a cheaper checked multiplication/rounding representation could materially change the balance. Obtaining the per-node width fold of the already selected circuit is a better next measurement than an unweighted G-versus-Horner-stage comparison. This note authorizes no new scan or value experiment.

## 7. Setup and sharing are part of the model

The saved setup has6004 kernels,337702368 kernel entries,140276846 chirp entries and a1116142487 upper count for CT full root-table entries. Kernel construction itself has2244782056 general complex products and5502647200 complex additions, plus168845180 quarter turns. It uses the same root-gate templates before kernel cache construction. Its original enclosure error is checked once and paid on every runtime use.

A conservative cache-entry design additionally includes one global power-of-two root table of length262144 and full direct-prime tables of sizes3+5+7+11. Negative roots/chirps are obtained by exact conjugation with checked index maps. Together with the saved CT/chirp/kernel arrays this gives at most1594383871 candidate coefficient entries, before deduplicating overlaps. Two exact sums per entry give an upper3188767742 sum constructions. This is a deliberately redundant cache design, not an assertion that every listed entry is used or must coexist in memory. Its root-generation, range/enclosure and conjugation certificates remain required; the bound is conditional on precisely these complete tables covering the selected nodes.

Each cache key binds the exact root/kernel identity and sign, length, precision, normalization, original center pair and its enclosure. C+D and D-C are exact sums of those centers. Numerical re-enclosure is not a replacement for that equality. Dropping a cache between shards can force reconstruction or proof-reference loading; both are charged. A global finest-grid table can be shared only under explicit tolerance and exact down-conversion rules. Finite head/source input bindings, all output labels and retained-index maps remain separate from arithmetic throughput.

## 8. What the saved receipts can and cannot price

The separately frozen saved-evidence map `zero-sum/TRANSFORM_SAVED_MULTIPLICITY_EVIDENCE_MAP_2026-11-11.md`, SHA256 `90A9730692DE696AD7F92A1AA5CAAE7FFAF378ED0822E78AD8F01517B325111F`, confirms the following limit after field-level inspection. Its receipt is `4E74C6C9AEA54A42B44EBFB36034AC7AD8663D3A5B0A34F83B410B24EC0E22B4`. This is supporting metadata evidence, not a substitute for the arithmetic proof above.

|Saved evidence|Recoverable information|Missing correlation|
|---|---|---|
|Reconciled/current combined-height receipts|Four aggregate G/A/D vectors, exact root/kernel split, input totals, setup and per-extra-node increments|No full conductor-height or stage table|
|Original fixed-order R132900 pruning receipt|Aggregate requested/full/whole-axis categories and a few exact examples|Recursive request sets, tensor prefix/suffix multiplicities and occurrence weights were discarded|
|Mixed-radix full inventory|Plan hash, counts, examples and aggregate setup|The actual CT plan dictionary was not serialized|
|Precision and width receipts|13943 matching whole-axis lengths with error/safety and peak factors; the common plan hash|No current stage/type/height weights or incoming augmented input bound; safety bits are not output precision|

The two whole-axis tables can be joined by n. They cannot supply a runtime-weighted width histogram or a per-P cached-kernel distribution. In particular an old unweighted conductor/axis histogram must not be applied to the current reduced-height family. A plan hash binds a reconstruction but does not contain that reconstruction.

The smallest sufficient new export would aggregate by current scenario-height multiplicity, fixed outer-axis position and prefix factor, requested primitive restriction, selected recursive node and local dimensions, root/kernel type and normalization location, incoming augmented norm envelope, precision/enclosure class and cache key. Its projections should reproduce every already frozen operation total. This can be a joint-class histogram rather than a gate log. Regenerating it from the saved source would nevertheless be new metadata work; no such reconstruction or scan was performed here. Actual adaptive precision would need an additional admissibility rule.

## 9. Evidence and next gate

Owned exact metadata script `integration/large_transform_pa_templates_20261111.py`, SHA256 `B9D4D1333FC83ECC70D6C82CB96159B4E0A98EB29C4453AF66B632C6295D6589`; receipt of the same stem SHA256 `B13699002FCB232B67FD9F973C8E2497D8984A14179C7D7ABCA6D306890CFFB5`. Its2845 checks bind the accepted reports, saved precision/peak maxima, reconciled counts and reviewed Horner comparator; check precision selectors and the formal three-product identity; reconstruct all 66 prefix addition cores; and derive all four scenario formula rows for three candidate tolerances. The receipt carries exact path/hash pins for every input. It reads saved data only and does not execute their generators. The writer refuses to overwrite its receipt.

The key new contribution is a complete typed action/witness interface and an ordinary-PA event core with explicit non-core prices. Aggregate gate types are recovered exactly; missing stage-width multiplicities and full numeral/sign/round implementations remain explicit. No common p, sign tolerance, aggregate saving, runtime winner or final spectral acceptance is adopted. Independent review is required before this paper model is used as an accepted comparison input.
