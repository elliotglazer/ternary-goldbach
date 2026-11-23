# Fixed, Gauss and four-product gates at saved normalized widths

2026-11-11. Bounded symbolic and saved-metadata research, submitted for independent review. No numerical gate, coefficient, transform, sign, proof or build was produced. No precision or production method is selected.

The fixed-coefficient identity has the smallest declared byte-event core at every saved product-width class for p106 and p108. Gauss does not improve those lower-precision cores. At p112, cached Gauss improves the kernel classes only; keeping fixed multiplication for roots gives a small conditional runtime-core reduction. Cache, binding and actual proof costs can change the complete comparison.

## 1. Same exact operands and final rounding

Write the stored complex mantissas as a+ib and c+id. The data coordinates share one grid and the coefficient coordinates another; in this application both are on gridp, so every real product is on grid2p. The three schedules are:

    four:    (ac-bd, ad+bc);
    fixed:   t=c(a+b), u=b(c+d), v=a(d-c), then(t-u,t+v);
    Gauss:   u=ac, v=bd, w=(a+b)(c+d), then(u-v,(w-u)-v).

Every presum, product and indicated addition/subtraction is exact. Only the two final coordinates are rounded onto the original output grid with its same deterministic rule, including ties and canonical zero handling. Cached c+d and d-c must be exact sums of the same stored c,d. Independently rounded analytic sums are outside this schedule.

Formal expansion gives identical exact real and imaginary results. With adequate intermediate capacity, the final rounded mantissas are therefore identical at a fixed p. Applying this local identity inductively along the unchanged transform DAG preserves the full rounded centers, provided the same input, root, kernel and coefficient-cache objects are used and the event-to-class bindings are proved. This is stronger than the mere radius comparison available when p changes. It supplies no existing successful sign by itself; no numerical center or sign was computed here.

The exact identities and unequal-width cautions are reviewed in `prime-estimates/EFFICIENCY_COMPLEX_KARATSUBA_2026-11-11.md`, SHA256 `86D8A9435A9962CFF95194642E590D65C76B334E5AD24377959006E7AB17BEFF`, and `audit/REVIEW_EFFICIENCY_COMPLEX_KARATSUBA_2026-11-11.md`, `27FADB7F3BD0B49D6A29B1183F04BCAB507FAC2F5C173B3ED8EA230C413424B7`. Only their exact complex identities and capacity arguments are used. No Karatsuba, chunked-product, named-digit, zero-carry or wider-radix successor replaces the original byte template here.

## 2. Separate real and imaginary Gauss capacities

Let |a|,|b|<2^A and |c|,|d|<2^B. These are total magnitude capacities, not just fractional precision. Presums require A+1 or B+1 bits. Ordinary products require A+B; fixed products require A+B+1 and its output additions A+B+2.

Gauss's u,v require A+B and w requires A+B+2. Its real subtraction requires A+B+1. The specified sequential imaginary path has bounds below5*2^(A+B) after the first subtraction and below6*2^(A+B) after the second, so both use A+B+3. This conservative path capacity is retained even though the final mathematical expression admits cancellation. No actual operand-width or cancellation measurement is inferred from metadata.

Use the same byte models

    Add(t)=2*ceil(t/8)+1,
    Mul(s,t)=5mn+2min(m,n)+1,
    m=ceil(s/8), n=ceil(t/8).

The fixed gate's product/exact-add/round-add components are

    Mul(A+1,B)+2Mul(A,B+1),
    Add(A+1)+2Add(A+B+2),
    4Add(A+B+4).

The four-product gate's components are

    4Mul(A,B),
    2Add(A+B+1),
    4Add(A+B+3).

Gauss with its coefficient sum computed inline has components

    2Mul(A,B)+Mul(A+1,B+1),
    Add(A+1)+Add(B+1)+Add(A+B+1)+2Add(A+B+3),
    2Add(A+B+3)+2Add(A+B+5).

The last line prices two round-witness additions for each coordinate at its own raw-result capacity plus the original two guard bits. Cached Gauss removes only the runtime Add(B+1), and pays one exact c+d cache sum per actual coefficient/lifetime. Fixed requires two coefficient sums; four requires none. Every signed/range/encoding/shift witness and cache/source binding remains additional to these unsigned arithmetic templates.

## 3. Bounded reconstruction

The coordinator approved the saved125279 normalized event classes, their20 weights and133 width-class projection, plus the6004 saved kernel lengths. The event input is capped at24 MiB. The original cost receipt is89710 bytes. A separately approved107410-byte p106/108 baseline receipt is capped at128 KiB. No conductor range, unit residue, requested-output plan, gate index or operand value is reconstructed.

The input normalized event pin is `721050210472999DB469728A0426FECDADD4D82F404C6302CA2B635F3551B7B2`; original receipt `F91A9966E4905B187DA01583DD993257EA94591B483E148903216158672559C3`. Both are under `agents/independent-feasibility`. The matched lower-precision receipt is `agents/moebius/normalized_transform_precision_costs_20261111.json`, `C3AC1C06BFDCB2931FA24F8EF9AFC7E84A88FA00AF3D5500C7657CC665A219D4`. Here agents means `work/qrh-campaign/agents`.

All133 width keys and20 category dictionaries reproduce that receipt. The49 product keys comprise34 root and15 kernel width classes. Data capacity is A=p+14+saved exponent. Root coefficient capacity is B=p+1; scaled-kernel capacity is B=p. Their coefficient bounds are center bounds, distinct from augmented data norms. Other additions, quarter turns and negations retain their counts. Runtime scale counts remain zero in the accepted normalized circuit.

All32 fixed/four baseline scenarios at p106/108/112/134, including every band-component dictionary, reproduce exactly before the new alternatives are compared. The four extra-prefix choices0/167/320/640 remain alternatives. Their count/repair success is not asserted.

## 4. Results and two conditional class policies

Main runtime cores, including unchanged standalone additions, are:

|p|Fixed|Gauss inline|Gauss cached|Four|Best with full fixed-sum cache available|
|---:|---:|---:|---:|---:|---:|
|106|4302622878721057430|4394974509949034574|4365855503049295822|5497947567811350526|4302622878721057430|
|108|4369084390425909710|4462479403121942330|4433360396222203578|5583351408270750462|4369084390425909710|
|112|4752826652495743914|4842198189033791574|4811070974761657046|6066519651827047594|4750574772509920106|
|134|6124737322160821530|6237171027112756434|6202027398095830354|7881643777228454202|6124737322160821530|

The receipt retains all alternative-prefix components and exact ratios. The minimum is over one declared unit price per displayed product/addition event. It is not an ordinary-verifier command or runtime minimum. Different prices can select a different policy.

For a policy with no coefficient-sum cache, choose only between four and inline Gauss. Inline Gauss has the smaller declared core in every saved product-width class at all four p values. For a policy with the full fixed-sum cache available, choose among four, cached Gauss and fixed. Ties prefer four, then cached Gauss, then fixed; there are no hidden operand-dependent tests.

At p106/p108/p134, fixed wins all49 product classes. For p106 and p108 the rounded byte lengths of B and B+1 agree for both root and kernel coefficients. The fixed and cached-Gauss product subtotals are exactly equal. Cached Gauss then adds63232624328238392 or64276005796293868 main-scenario addition events, respectively. This negative result is retained.

At p112, only B=112 for kernels crosses a byte boundary when incremented. The15 kernel classes select cached Gauss and all34 root classes select fixed. Main-scenario kernel occurrences are88576420247296; root occurrences are915527265950592. The arithmetic reserve is8039890902776512 product events minus5788010916952704 added addition events, giving2251879985823808 net unit-priced events. This does not make a uniform all-Gauss policy better: all-Gauss cached remains more expensive in the displayed core.

These selections use capacities already assigned to each class, not the actual operands. The metadata policy is a new execution/proof schedule and still needs an exact event-to-class/implementation binding. It does not change analytic domains, axes, pruning, input uncertainty or coefficient identities.

## 5. Cache union and lifetime accounting

For each actual coefficient object, retain c+d if it is used by fixed or cached Gauss, and retain d-c only if used by fixed. Count a shared c+d once within its valid cache lifetime. If the same coefficient is used by both schedules, the union is the fixed two-sum cache, not three sums. Keys must include coefficient identity, precision and all required source/normalization bindings. Equal rounded width keys do not establish equal coefficient objects.

The histogram does not identify the exact root/chirp coefficient union or actual cache hits. Those remain named quantities. The saved full kernel set supplies a valid fixed superset of6004 lengths and337702368 entries. One exact sum of every scaled-kernel entry costs:

|p|One-sum add core|Two-sum add core|Common scaled-kernel round core|
|---:|---:|---:|---:|
|106|9793368672|19586737344|44564363392|
|108|9793368672|19586737344|44575881344|
|112|10468773408|20937546816|47118457984|
|134|11819582880|23639165760|54173640064|

These are per declared cache construction/checking lifetime, not proof costs for the underlying coefficient values. A root/chirp sum costs Add(p+2) per actual entry under its B=p+1 bound, but its union cardinality is not invented from the event histogram. Original kernel FFT/root/chirp generation and certification remain required and are unchanged by an identity substitution at a fixed p.

Retaining the existing full two-sum fixed cache is a sufficient shared-cache policy for the adaptive comparison. It adds no new coefficient sum and claims no setup refund. It still pays the existing cache construction, storage, loading and exact-object proof bindings. This gives a concrete conditional p112 mixed policy without knowing a smaller optimized union.

For a cold p112 implementation one may instead keep the same root cache and construct only c+d for every entry in the full saved kernel cache, since every runtime kernel class selects Gauss. Relative to constructing both kernel sums, this declared superset saves10468773408 addition-core events per lifetime. It is not an exact minimal-union count. If both sums have already been built, that arithmetic cost is sunk and cannot be refunded. Changing p still requires separately compatible coefficient/cache objects; center equality in this note applies only at fixed p.

## 6. Complete decision inequalities and remaining work

Let P_j,A_j be the displayed runtime product/addition components for policy j. Let S_j be its actual coefficient-cache union cost over all lifetimes, and U_j the remaining generation/proof/representation/binding/resource costs. With common declared event prices alpha and beta, compare

    C_j=alpha*P_j+beta*A_j+S_j+U_j.

Use separate functionals for generation, ordinary checking, bytes and memory. If product or addition prices depend on widths, apply that functional to the saved class-price rows rather than the unit-price minimum. Signed operations, range proofs, final rounding, source numerals, theorem imports and full analytic foundations are not removed.

For the p112 main mixed policy retaining the full fixed cache, S_mixed=S_fixed is permitted. Improvement then requires

    alpha*8039890902776512
      > beta*5788010916952704 + (U_mixed-U_fixed).

For the cold one-sum full kernel-cache variant, add beta*10468773408 to the left for each matched newly built lifetime. Actual setup proof/storage differences still belong in U. No benefit is asserted from a difference of upper bounds or from counting an existing cache twice.

At p106/p108 the equal product-core observation does not prove that fixed is universally cheapest. A Gauss implementation could reduce complete setup or proof overhead, but would have to pay the displayed additional runtime additions and all differential costs. No such gain is supplied here. Other associations, sharper cancellation bounds, different product algorithms and new precision choices are outside this bounded comparison.

## 7. Frozen evidence

Owned `normalized_complex_gate_choices_20261111.py` has SHA256 `9D54D235C8D1BBD8D8B9AAD4B16A3A4C1D041BB4A31E3385ED0F910A6BC35A95`; its221777-byte receipt has SHA256 `7D0983C2133F014CE367E60D5F8B6E0827A62CCBC0ECA1605725E2BB711AB1AF`. It passed3104175 checks including the final256 KiB cap; the receipt records3104174 before that last check. It checks the formal polynomial identities symbolically, uses no operand values and imports no earlier writer. The source/width proof and complete-cost interpretation are submitted for independent review.

The lower-p eligibility remains the separate reviewed allocation chain; this note does not reprove it or select either candidate. No old sign is transferred across a precision change. Same-p center preservation is conditional on the exact arithmetic and matching cache schedule proved above. All predecessor files remain unchanged, and no declaration, proof emission, build, numerical function/prime/zero evaluation or new inventory was performed.
