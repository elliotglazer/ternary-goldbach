# Variable FD and Horner costs on the same twelve cells

2026-11-11. Exact rational and frozen integer-metadata research only. No new conductor or unit enumeration, coefficient/function/prime values, transforms, builds, source edits or frozen-artifact changes. The comparison retains the twelve cells of C41D1BA7, independently reviewed at8560547A.

Both competitors improve after reducing output degree and precision. Among these fixed arithmetic schedules, the length130 fixture retains a projected rounded-FD core reserve of89268 events, previously77322. The length260 fixture still has a smaller Horner core. These statements concern specified product/adder templates, not runtime, an aggregate policy, or a winner after all remaining costs.

## 1. Bind geometry and candidate domains

The original receipt5388F1D0 supplies c,F,k, clipped endpoints, L,U, source coefficient class and width domain for each cell. They are copied unchanged. The source-band binding is explicit:

|F|D_out|Admission case|Absolute-height cap|
|---:|---:|---|---:|
|1024|512|Band1|500|
|4096|2048|Band3|2000|
|8192|4096|Band4|5000|
|16384|8192|Final declared domain|7000|

The final fixture uses the declared7000 contract, not the cheaper actual-request restriction. All source generation, source grids, twenty-slot delivery, EM corrections and finite translations remain unchanged. The old receipt already checks that each fixture occurs within the selected height profile. No new family membership or successful sign test is inferred.

FD candidates are exactly the admitted entries from the reviewed variable packet79F8EA3F/F77403A3: K18..20, b93..100, d0..2 with their uniform-in-L alpha test. Horner candidates are exactly the admitted entries from AEAB2BDC/84B06243, in its three fixed shapes, K10..20 and b0 90..100. The alpha predicates are not weakened to fit a cell. They retain target Taylor remainder, analytic finite-shift bias, numerical source error and character amplification633, within2^-82. This is not an arbitrary-grid search.

## 2. Reuse unit metadata without scanning units

The old uniform100 Horner schedule contains every target's reduced-denominator and numerator-capacity information in its typed shifts. For each unit and every one of nineteen stages and two coordinates, the block ends with

    [db+1,1], [db,1], [input_bits+r_bits,0],

and has an optional leading odd-core-restoration shift. These are the two range-witness doublings and the unaligned numerator reference, not numerical operands. Recover tp=bitlength(2c)-db and D=(2c)/2^tp. Recover r_bits by subtracting the already pinned input capacity. The optional leading term must equal the old quotient capacity plus oddpart(D)'s bit length, with shift nu2(D).

The decoder verifies the complete old sequence, including its end, against these identities. It checks that all38 blocks for a target agree and preserves the order and multiplicity of targets with identical descriptors. The recovered descriptors contain D, r_bits and tp. They suffice for the chosen arithmetic templates; they do not recover actual residue or coefficient values. No gcd or interval scan is performed. The old certificate's source/target identities remain required at implementation time.

Per-target reductions are applied equally to Horner and exact-FD diagnostics. Horner also cancels the proved power of two from its degree-grid alignment. This avoids repricing one method with full denominators while giving cancellation only to its competitor.

## 3. Fresh FD object, all-cell normalization and errors

For each admitted K,b,d use n=K-1, m=min(K,L),

    S=sum_(j<m)binom(L-1,j), p=b+bitlength(S)+d,
    e_b=(3/4)2^-b, e_p=(3/4)2^-p, beta=(3/4)S2^-p.

The coefficient bounds are c_j=Z_j+e_b for the ORIGINAL stored centers. Partial degree i uses c_(n-i),...,c_n. The initializer has n prescales, denominator v^n and the actual new top coefficient z_(K-1). The positive stagewise envelopes are recomputed from those exact rational bounds. There is no reuse of a degree19 envelope with an omitted stage or renamed grid.

For short cells the retained all-cell envelope is

    E_(i,j)=2^j sum_(ell=j)^i c_(n-i+ell)4^-ell.

For L11..20 use the reviewed finite Stirling kernel with sigma1/20; for L>=21 use sigma1/40. The old exact length proof gives c>F(L-1), so both strict guards hold. General/secondary raw terms retain their separate old-partial envelopes. Insertion uses the newly inserted coefficient bound.

Unlike the older twelve-cell schedule, the new short-cell initializer may be normalized. The variable-degree theorem proves directly that j!F'^j divides the jth difference of the integer partial polynomial, after cancelling a common2^t from q0,F,v. Thus the normalized order-j state is integral after division by2^lambda_j, lambda_j=j*nu2(F')+nu2(j!). This is finite algebra at any degree; it needs no c/F guard. The short-cell raw inequalities still use only retained physical supports: |h0+jF/v|<=1/4 and jF/v<=1/2. Dividing those independently proved raw bounds by the positive normalization factor is valid. This supplies the composition that the old short-cell schedule deliberately left open.

Every rounded live state uses E_(n,j)+beta, and each raw traversal sum uses E_(n,j)+E_(n,j+1)+2beta. Initial conversions use E_(n,j)+e_p. Final rounded output uses E_(n,0)+beta+e_b. The old u100/4 promise appears nowhere in the new capacities.

The normalized initial conversion is exactly

    E_integer,j *2^(p-b+lambda_j)/v'^n.

Cancel only a proved common power of two. The shifted input, quotient times the reduced denominator, residual and doubled residual remain wide temporaries. All m complex conversions are charged. The rounded traversal uses common-grid integer additions without intermediate rounding. It includes nonunits and prunes an order only after its last dependency. Unit outputs have dyadic final conversions with denominator2^(p-b), followed by exact grid100 re-encoding.

The saved exact-FD alternative is a diagnostic using the SAME admitted K,b candidate and beta-enlarged final bound. It changes the traversal and final quotient schedule but is not an independently optimized exact-FD alpha frontier. Exact FD could admit other grids after a separate study; no such advantage is silently credited here.

## 4. Matched ordinary-arithmetic schedules

The same declared byte templates as the reviewed twelve-cell predecessor are used:

    M(a,b)=5 ceil(a/8)ceil(b/8)+2 min(ceil(a/8),ceil(b/8))+1,
    A(w)=2ceil(w/8)+1,

with zero-capable operands padded to at least one magnitude bit. Every product is oriented with the shorter byte operand as the row dimension. These are fixed padded schedules. They are not estimates of a machine multiplication instruction.

The nearest-round witness proves P=qD, P+R=X, 2R+D=W, W+g+1=2D with W,g nonnegative. The core charges the product and three magnitude adders. It separately records odd-core restoration, alignment and doubling shifts, signed wrappers, and the dyadic replacement of a product by a shift. Range and source/binding proofs, witness discovery and representation work remain additional prices. A small accepted residual is not used to bound its raw subtraction before acceptance.

The receipt retains multiplicity maps keyed by actual operand capacities for products, adders and shifts, plus the old signed-wrapper count. This is a compact representation of the typed schedule, not a new arithmetic optimization. FD components separate cold geometry powers, initialization, initial rounds, rounded advances, dyadic finals and grid100 exports. The exact-FD diagnostic has separate advances and final quotients. Prescale products use the actual inserted coefficient and v'^i; general products use the previous partial state; binary secondary terms retain every shifted operand.

For each admitted Horner candidate, fresh coefficient and accumulator bounds are reconstructed from Z_j and the actual degree grids. The new highest coefficient is copied. Each lower stage counts numerator multiplication, nearest-witness multiplication and residual/range adders, then exact coefficient addition. Its M and L capacities are checked against the joint-Horner receipt. Repricing then uses the decoded actual denominator and numerator capacity, including fair target/alignment cancellation. This changes the old global-factor subtotal while retaining the same sufficient alpha proof.

Final grid100 exports are charged on BOTH sides as two coordinate shifts per unit, with distance100-b or100-b0, plus the required external binding/range/representation cost. The shift has no numerical error and does not recover grid100 accuracy. All displayed selected outputs need114 signed bits after re-encoding. Source conversions and cache identities are not hidden inside the template core.

## 5. Bounded comparison

For each cell, minimize ONLY the product-plus-magnitude-adder core among the already admitted candidates. Ties are broken lexically as recorded by the script. The minima need not minimize a complete price functional, since precision, source conversions, shifts, sign proofs and storage differ.

|c|L,U|FD K,b,d,p|FD core|Horner shape,K,b0|Horner core|Horner minus FD core|
|---:|---|---|---:|---|---:|---:|
|10004|1,1|20,93,1,95|53125|fixed,20,94|8500|-44625|
|16388|2,1|20,93,1,96|66111|fixed,20,94|8548|-57563|
|20484|5,2|19,93,1,99|101012|fixed,19,94|15122|-85890|
|10244|10,4|19,93,2,105|145816|fixed,19,94|31690|-114126|
|11268|11,3|19,93,2,106|149742|fixed,19,94|23362|-126380|
|20484|20,7|19,93,2,114|207112|fixed,19,94|58604|-148508|
|21508|21,10|19,93,2,115|200520|fixed,19,94|82098|-118422|
|40964|40,14|19,93,2,133|249070|fixed,19,94|116818|-132252|
|81924|80,27|19,94,0,153|335252|fixed,19,94|229608|-105644|
|133124|130,62|19,94,0,167|436854|fixed,19,94|526122|89268|
|265800|260,70|19,94,0,186|663594|fixed,19,94|594218|-69376|
|10004, final|1,1|19,93,0,94|44512|fixed,19,93|7676|-36836|

The length130 rounded-FD core consists of4982 cold-power events,155402 initializer events,115252 initial-round events,150182 traversal events and11036 dyadic-final events. Its grid100 adapter is an additional124 shifts of a107-bit magnitude by6 bits, not zero work merely because its product/adder core is zero.

For that cell the complete typed totals are:

|Method|Real product macros|Magnitude-adder macros|Shift/reference terms|Signed wrappers|
|---|---:|---:|---:|---:|
|Rounded FD|434|5458|1244|5730|
|Joint fixed Horner|4464|8928|8184|11160|

Operand widths differ substantially. FD's largest selected live signed state is181 bits in this row; its initial conversions still have their much wider rational operands. Horner uses narrower stage-specific operands. Macro counts alone cannot establish proof cost. The old core reserve for this same cell was77322; the new one is89268 after improving both competitors. At length260 the projected deficit improves from100710 to69376 but remains a deficit under this one subtotal. The unit density differs, so the length130 observation does not extend to that row or to a family.

## 6. What a valid cost decision still needs

Let R_M denote all non-core charges for a specified method: actual shifts/references, signed and range proofs, source conversions, normalization and geometry facts, source/cache identity and lifetime, grid100 binding, storage/transport, ordinary arithmetic-library work and quotient discovery when pricing generation. For the length130 selected schedules, equal-priced template events favor FD only if

    R_FD - R_Horner < 89268.

With different product and adder event prices, use the saved separate capacity maps and recompute the reserve. Do not price a narrow Horner event and a wide FD event equally unless that is explicitly the chosen model. The corresponding inequalities for every other row use their saved ledgers. A negative projected core reserve is a failure of that sufficient comparison, not a mathematical lower bound on every FD implementation.

K direct source conversions are listed per distinct consumed coefficient object; an actually retained full twenty-slot conversion cache costs twenty. Uniform-b FD and a nonuniform Horner profile generally cannot share a converted array. Equal per-degree grids may share only with direct ORIGINAL-center identity, tie convention, source/height/anchor normalization and checked lifetime. Existing b100 cache entries cannot silently be re-rounded under the direct-conversion error proof. Every source production and twenty-slot-delivery cost stays unchanged.

The shorter-degree counts do not license dropping unrelated source work. Nonunit traversal is retained. No global histogram is weighted, no fresh geometry is scanned, no outputs or signs are produced, and no backend/runtime or end-to-end method is selected. Savings statements would require comparing complete charged schedules or a new upper bound against a valid comparator lower bound, not subtracting unrelated upper bounds.

## 7. Frozen evidence

Script same_fixture_variable_fd_horner_20261111.py SHA256 B754421B15373C754D961C722A944BA2D15AF743750CA972D83589BB69320269; receipt same stem SHA256 CE69E0E4840011EEA1043BE1511E4CECF2FB72DF0CA5DA60A3AF6E4B7032E962. All4154891 exact assertions pass. The receipt contains509 admitted FD and506 admitted Horner schedule instances over the same twelve cells, including complete component ledgers and exact alpha bindings.

Ten full pins are checked: old geometry receipt5388F1D0 and review8560547A; variable-degree author79F8EA3F/data82C2BDAC/reviewF77403A3; joint-Horner data59EBE87D/review84B06243; stored-degree dataE947C32E/review10281561; and old uniform100 metadata4F114004 used to decode the already reviewed unit-capacity records. The new normalized all-cell composition is justified in section3 rather than assumed from the old unnormalized short-cell choice. Independent review of this new comparison is required before adoption.
