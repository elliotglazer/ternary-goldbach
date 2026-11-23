# Prospective pricing for mean186 and runtime692

2026-11-11. Paper design only, not an execution preflight. No new inventory was read, parsed or folded; no assignment, values, proofs or builds were produced. The intended successor assignment has no accepted output packet yet. Exact output/contract hashes, resource limits, independent review and coordinator authorization remain necessary before any later price pass. Current combined40 outputs remain unchanged.

The purpose is to avoid an intermediate692-only assignment and avoid repeating a full saved-context pass merely to obtain a preliminary cost bound. A small conditional bound and an eventual exact minimal-assignment price are different deliverables. Neither should be presented as the other.

## Mathematical and comparator inputs

The mean/tight companion `independent-feasibility/MEAN_INPUT_TIGHT_CONSTANT_TENSOR_COMPANION_2026-11-11.md`, hash `4A7EB4A925A84F70F882A2AC4A1D44B5EB6132B5C6066C12FB4DC4159EF1CDED`, is reviewed by integration at `A4B204E9EADBB29F51BA56CCC2FBCD417E1AF90254605E9877524970DC2C5021`. It distinguishes error mean186 from pointwise runtime bound692. It requires the actual full-P20 grid94/min65 evaluator, full alpha proof and exact grid100 export, the finite head and nonnegative per-input error sums, exact assembly and one input regrid. It does not price any of those producers or justify using186 as an operand bound.

The frozen major-constants `MEAN186_EXACT_TENSOR_ASSIGNMENT_PREFLIGHT_2026-11-11.md`, SHA256 `D804D1A6CEBBDB812A35132CC05A79B9FA8A6B3D510CCF49A9ACCFCC588F1A64`, still awaiting its independent preflight review at this writing, proposes the exact selector

    phi/sqrt(c) * [rho/2^p + 186*S_t/(2^p-S_t)] <= Cg*2^-108,
    rho=1[p<100], Cg=4196258524692480,

with both old guards and p>=50. Its proposed five-bit proof supplies a sufficient q=p_old-5 for every accepted combined row, where80<=p_old<=105. It bounds the intrinsic term by `(31744/46347)*E_old < 3*E108/4`, and the input regrid by `633*2^-75 < E108/4`. Therefore q lies75..100 and satisfies the unchanged complete allowance. This draft proof must be consumed through the eventual frozen reviewed assignment design; it is not an executed minimal selector here.

The current comparator is `moebius/COMBINED_CONDUCTOR_PRECISION_PRICES_2026-11-11.md`, hash `C5A2B6B7A7E7688C566D62495A2FD99D68604B9FB8B1C8CC1BD10AC58D0AD41C`, with saved2099-class output `51844D5768117F3AA21E9FC8C84FD918D92008E9C51DB41AE742B565FF6F4A2B` and receipt `17930450145D8507AE4883D923C76E9F3A0FE3C6ABAD28F4BD700AB5ABFCDA7F`. Independent reconstruction is in progress at this design's preparation. No reuse below becomes an accepted numerical comparison before that gate passes.

## 1. What a saved ceil-log class tells us

For one exact positive data-envelope factor f, the current class stores d=ceil(log2 f), not f. Current data capacity is

    a_old=p_old+14+d,

because the old width bound is exactly2^14. New exact capacity at chosen precision p is

    a_new=p+ceil(log2(692*f)).

The definition of d gives `2^(d-1)<f<=2^d`. Since512<692<1024, the new exponent is **either d+9 or d+10**. More precisely,

    ceil(log2(692*f))=d+9  iff  f<=2^d*(128/173);
    otherwise it is d+10.

The weak inequality handles the exact power-of-two boundary. This formula needs no logarithm evaluation: rational cross multiplication tests it. The saved d alone cannot decide the branch. Consequently replacing every exponent by d+9 would be unsound. Using d+10 is a sufficient upper capacity, not an exact inventory result.

Root and normalized-kernel coefficient capacities remain respectively p+1 and p, with their separately required exact cached sums. Mean186 changes none of them. All presums, raw products, final sums and nearest-round witnesses must be repriced from the chosen data/coefficient capacities using the same original byte templates. A data-bit subtraction does not by itself price all those derived operands.

## 2. A cheap sufficient comparison without another context pass

For the fixed sufficient policy q=p_old-5,

    a_q <= a_old-9,
    b_q = b_old-5.

The nine-bit data reduction is five precision bits plus the conservative four-bit magnitude reduction. All actual pointwise capacities remain sufficient under the new source proof. The original M/A templates are monotone in each nonnegative operand capacity. Thus a separately authorized small fold over the already accepted2099 classes can compute a **runtime-core upper bound** for this q policy by using `(a_old-9,b_old-5)` and recomputing every addition/round-witness width. Existing40 weights are sufficient because q is a deterministic function of their p_old label. No conductor or requested-context traversal is needed for that bound.

The intended minimum p_new satisfies p_new<=q after its selector has been accepted. With the same actual factor f and fixed arithmetic mode, its runtime core is no greater than this q-policy upper bound. This observation does not determine its exact per-p weights, actual byte widths or setup costs. It also does not turn q into the intended minimal assignment or transfer old centers/sign success.

For q, the old-p to new-p map is injective. Therefore each predecessor full node/kernel membership `(n,p_old)` maps bijectively to `(n,q)`; its number of keys and entries stays the same under the stated independent-per-p construction. A small separately authorized fold could reprice this fixed-policy setup from the accepted saved membership table. It must still pay construction at q, root/chirp enclosures, normalized rounds and exact sums; these are new objects under new producer contracts. No high-cache sharing or sunk-cache refund follows from a relabelled set.

The q-policy conversion count is also available symbolically from the accepted per-p input metadata. If N_p is a scenario's old residue-input count, then all p_old<105 now regrid; p_old=105 maps to exact p100 identity. Hence

    N_regrid(q)=sum_p N_p-N_105,
    N_identity(q)=N_105,
    N_exact_embedding(q)=0.

This is a schema-level identity, not a newly computed count. The all-input total is a conservative regrid ceiling if an even smaller preliminary comparison is wanted. The applicable totals differ by e scenario and must not reuse the e0 ceiling for all four alternatives.

## 3. Why the intended minimum needs a new association pass

Different conductors at the same p_old may obtain different p_new. The old histogram has already summed their contributions. It cannot split those weights, infer exact new kernel unions, or derive the new input-regrid count from an unweighted precision distribution. The q-policy setup bound is not an upper bound on arbitrary minimal-assignment setup: splitting a former precision class can introduce more distinct `(n,p_new)` keys even while every precision decreases.

Once the exact minimal assignment is frozen and independently reviewed, the preferred exact pricing task is one40-weight propagation keyed only by p_new. Use the accepted predecessor receipt for the complete old/global comparator instead of carrying old+new or three assignment vectors. Join each new compact row to its exact predecessor/source row. Reconstruct sample/band input/output counts and full cache masks under the new producer contracts.

During that one propagation, recover f from the same exact saved child factors and normalized Bluestein/radix formulas. Compute both d and `ceil(log2(692*f))` by integer/rational ceiling logic. The d projection must recover every old precision-forgotten133-class40-weight total. Retaining paired `(d,e692)` in the small result can document the exact reduction without a second traversal. Only two e692 branches exist for each old d, but finer labels and the new precision range require explicit fresh output/working-memory caps. An eventual preflight must derive those caps from the actual assignment; this design authorizes none.

This fresh traversal is structural metadata, not a recomputation of transform values. It must retain original axis order, retained-output counting versus full-prefix magnitude, every old and41-guard weight, root/kernel product distinction and all five operation categories. Exact-factor recomputation is needed for exact prices; it is not needed for the conservative d+10 upper bound in section2.

## 4. Conversion and all other bills

The narrower converter `audit/EM692_REGRID_CONVERTER_CAPACITIES_2026-11-11.md`, hash `99FC177B6F200502407802E7A8FF6E98196EBF51A932A2B68EC38B693A46EB35`, is independently reviewed at `9FDA531D3257E74A6636303755D19B3A1217D0692B335190557385C429E51F2C`. It supports116 unsigned-adder core units per complex regrid, under the same four signed-witness-addition schedule. Source coordinates need111 signed bits, raw additions112, and rounded destinations p+11; remainder length is d=100-p, potentially50. The116 term is not a complete signed or ordinary-proof price.

Using116 is an explicit reviewed converter choice, not an automatic consequence of a mean selector. The eventual assignment's input contract and price task must agree on the underlying witness and independently checked ranges. If its frozen contract requires a different conservative capacity, either price that contract or supply a reviewed representation adapter; do not silently replace it. Sign routing, partial-byte remainder ranges, shifts/powers, source/destination equality, zero convention, bindings, storage and witness generation remain. Longer d can increase those costs despite a smaller adder capacity. Exact p100 identity has no regrid fee; exact p>100, if a different admitted policy uses it, needs its own potentially wider destination representation.

For a chosen scenario/mode the comparison must retain separate terms for runtime products/additions, the116*N_regrid core and its unpriced signed roles, exact embedding/copy, complete direct-per-p kernel FFT/root/chirp setup, normalized cache rounds and new-center sums, source/head/assembly/export, proof generation/checking and lifetime/import/storage costs. Cold comparison pays complete alternative schedules. Sunk comparison refunds no old work without demonstrated live object identity. Numerical signs, repairs, Turing closure, principal/finite verification and analytic/MM0 foundations stay outside these subtotals.

The cheapest next research step is therefore optional and limited: after current result acceptance and separate authorization, obtain a conservative q-policy runtime/setup/conversion comparison from existing labelled metadata. If that bound does not settle a fully priced decision, proceed directly to the intended mean186 minimum and one exact-factor40-weight pricing pass. No intermediate692-only assignment, repeated full price pass or unpriced cache assumption is required. There is no final performance or production recommendation here.
