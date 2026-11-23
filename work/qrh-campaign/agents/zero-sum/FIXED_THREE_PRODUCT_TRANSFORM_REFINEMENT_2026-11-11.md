# Refining the character transform to three real products

2026-11-11. Paper proof only. No root, coefficient, transform, function value or spectral test was evaluated. No build, Lean declaration or frozen-file change was made.

The fixed-coefficient three-product circuit can satisfy the already reviewed complex-gate error contract at the same fractional grid. Compute its signed integer internals exactly, derive cached sums from the same stored coefficient centers, and round only the two final coordinates. This preserves the existing transform output-error proof, including its nonunit Bluestein kernel errors. It requires wider exact temporaries and explicit cache setup; it does not prove that an implementation is faster or that a previous rounded output box contains a new center.

## 1. Scope of the refinement

The current R132900 budget uses the fixed-original-order primitive-output circuit, with G=1849018578634950 general complex products and A=3808420069398260 complex additions/subtractions above conductor10000. This report changes the real implementation of those abstract complex products. It does not change the axis order, retained indices, CT permutations, transform sign, normalization, or input enclosures.

The accepted precision proof assumes a positive dyadic u, coefficient enclosures at their stated errors, and absolute complex arithmetic error at most u at each rounded complex addition/product. It then proves CT/direct/radix-two/Bluestein error bounds and the final unnormalized output bound

    v * [E0 + 2u S (B+E0+1)],                              (1)

where v=phi(c), B bounds true input magnitudes, E0 bounds their initial center error, S is the sum of axis error coefficients, and all local safety inequalities and Su<=1/2 hold. Equation(1) is not an independently chosen new tolerance. The existing coefficient, cache and rounding hypotheses must still hold.

All runtime G gates in this specified transform multiply by a coefficient fixed independently of the current input. These are roots/chirps and the cached Bluestein kernel coefficients. The latter are uncertain and nonunit, but still fixed for all input lines using the same length, convention and precision. If a future algorithm makes both operands data-dependent, the fixed-cache cost classification must change; the algebraic identity itself remains valid.

## 2. Exact integer gate and its final rounding

Choose a common grid h=2^-p<=u, p>=0. Inputs and coefficient centers must already be on this grid, or be exactly aligned to it under an explicit bounded-width contract. Write

    z0=h(A+iB),    w0=h(C+iD),

with signed integers A,B,C,D. During coefficient setup store the exact signed integers

    Cplus=C+D,    Dminus=D-C.

For every product compute exactly

    S=A+B,
    T=C*S,    U=B*Cplus,    V=A*Dminus,
    Nr=T-U,   Ni=T+V.                                      (2)

Distributivity gives Nr=AC-BD and Ni=AD+BC. Hence h^2(Nr+iNi)=z0*w0. The additions and all three products in (2) are exact integer operations; there is no discarded internal low part or hidden floating rounding.

Round each h^2 Nr and h^2 Ni to the common h grid. For example an output integer Q must satisfy

    2*abs(Nr-Q*2^p) <= 2^p,                               (3)

and the analogous inequality for Ni. A specified deterministic tie rule completes nearest rounding, including negative integers. Each coordinate error is at most h/2, so the complex error is at most sqrt(2)h/2<=3h/4<=u. An exact-integer implementation of a complex addition followed by this same coordinate rounding also has complex error at most u.

This proves the abstract gate hypothesis required by (1). It does not require a finer output grid for the three-product identity. Exact intermediate numerators have grid h^2, rather than h; their extra bits are retained until (3).

There are two different transfer claims. Against a reference which also forms the exact center product and applies the same final grid and tie rule, (2) gives identical rounded bits. Induction over the unchanged finite circuit then gives identical retained outputs. Against a reference which rounded its four real products separately, bit equality is not asserted. Both implementations may satisfy the same abstract complex error contract, and therefore both satisfy (1); an immutable old output box still needs actual containment or a separately proved comparison.

## 3. Uncertain coefficients and exact cached sums

Let actual values satisfy |z-z0|<=ez and |w-w0|<=ew. Independently of how the exact center product is computed,

    |zw-z0*w0| <= |w0|ez + |z0|ew + ez*ew.                 (4)

Add the final complex arithmetic error at most u. In the transform proof these operand errors are already propagated at the appropriate stages; they must not be added a second time to (1).

The exact cache equalities Cplus=C+D and Dminus=D-C refer to the stored centers, not to unknown exact analytic coefficients. The actual sums of coefficient coordinates are uncertain. That uncertainty is entirely represented by ew in (4). No independence of coefficient coordinates or radius-zero assumption is used. Applying interval arithmetic separately to the three correlated products would generally produce wider bounds, but it is unnecessary: the checked exact identity at the centers and (4) are sufficient.

Each cache entry must bind its original center pair, coefficient identity/index, transform sign and precision, with checked exact sum equalities. The original enclosure proof remains recoverable. It is not valid to substitute an independently computed analytic approximation for Cplus or Dminus and claim exact equality to the stored center sums.

## 4. A bounded fallback for rounded cached sums

Exact sums are the default. If memory or representation policy instead stores real centers Ctilde,Dtilde with residuals

    |Ctilde-(c+d)|<=etaC,    |Dtilde-(d-c)|<=etaD,

where c,d are the original coefficient centers, and a+b is still exact, then exact internal arithmetic yields center errors bounded coordinatewise by |b|etaC and |a|etaD before final rounding. This follows directly by subtracting the exact identity. It is separate from the analytic coefficient error ew.

For a certified bound M>=max(|a|,|b|), choose

    etaC,etaD <= u/(8 max(1,M)),    h<=u.

Each coordinate's total arithmetic error is at most u/8+h/2<=5u/8. Its complex norm is at most (3/2)(5u/8)=15u/16<u. Thus the same abstract gate contract still holds. The cached residual target must cover the largest input magnitude of every cache consumer. A cache key or certificate must bind that bound; smaller local bounds cannot be reused indiscriminately.

This fallback may require additional cache precision and wider alignment, so the same-width conclusion for the exact-sum path does not transfer automatically. Rounding a data presum a+b introduces another |c| times its rounding error and needs the fuller allocation in the predecessor gate paper. No such rounding is admitted in (2).

## 5. Bluestein setup and nonunit coefficients

For a length-n Bluestein leaf with padded size P, the exact kernel has 2n-1 unit entries. The accepted proof bounds its exact transform by 2n-1 and the stored transform error by

    eK <= P A_B u,

where A_B is the accepted radix-two error coefficient combination. The stored coefficient magnitude is consequently at most 2n-1+eK, at most2n under the existing PA_B u<=1 safety condition. This is the coefficient bound in (4) and in the intermediate-width allocation. Replacing it by one would be wrong.

Kernel setup uses the radix-two transform of the certified chirps. It may itself use (2) for its fixed-root products. There is no circular cache definition: construct root/chirp enclosures first, run the finite radix-two kernel circuit with the proved gate contract, obtain its kernel enclosure, and only then form exact Cplus,Dminus for each resulting coefficient center. The existing eK proof survives unchanged. An imported kernel must provide its own valid eK; cheaper multiplication does not repair an inadequate cache enclosure.

For data-transform error eF and true data bound nM, the accepted pointwise estimate remains

    nM*eK + (2n-1)*eF + eF*eK + u.                       (5)

In particular the product of uncertainties is retained. Setup construction is charged once per distinct length/precision/convention cache entry, while its error is charged on every use. Output division by P in the inverse convolution and all final character-transform scales stay unchanged.

## 6. Intermediate sizes and real-operation costs

Suppose the signed input magnitudes |A|,|B| are below2^a and |C|,|D| below2^b. Exact data and coefficient presums require at most a+1 and b+1 magnitude bits. Each of T,U,V is below2^(a+b+1), and a safe uncancelled output-addition bound is below2^(a+b+2). A sign bit and the chosen signed representation are additional bookkeeping.

Thus the fixed identity uses one product of widths (a+1,b) and two of widths (a,b+1), followed by wide signed additions. The four-product reference uses four width-(a,b) products and width-(a+b+1) output additions. The three-product schedule saves one product, not its entire implementation cost; it increases operand/temporary widths and adds a runtime presum. When exact cancellation makes the final coordinate small, these allocated temporary capacities are still required.

The reviewed full-transform peak proof supplies a bound K(c)(B0+1) for the product of operand norms at every multiplication, including nonunit kernel products. With B0+1<=2^b0 and q=ceil(log2 K(c)), its existing safe allocations are

    stored signed width: p+b0+q+2,
    three-product presums: stored width+1,
    three-product raw product/addition width: 2p+b0+q+5.   (6)

The fixed identity's actual products are at most twice the operand-norm product and its uncancelled output sums at most four times that product, so (6), which was derived for the more general three-product case, is sufficient. This includes the raw inverse FFT before division. The same-original-order pruned circuit inherits that peak allocation as a dependency-closed subcircuit. No optimized-order width comparison is inferred.

For bounded common grids, no unbounded exponent alignment occurs. Arbitrary separately scaled floating dyadics with large exponent gaps are outside this contract. They require a new alignment bound, the rounded-presum fallback, or a different gate.

With G fixed-coefficient complex products and A complex additions, the runtime center arithmetic becomes

    3G real products,    2A+3G real additions/subtractions,

plus two exact setup additions per distinct coefficient cache entry and final rounding checks. Horner's real-times-complex products remain separate. The current budget's 3G+2H and 2A+3G+2H formulas therefore have a valid implementation refinement under this contract.

Let F be the number of distinct cached coefficient centers actually used at one precision and convention. Storing the two extra sums adds at most2F signed numbers, each one magnitude bit wider than its corresponding coordinate allocation. Exact negation/conjugation symmetries may reduce F only with a checked index map. This report claims no such reduction. Root setup, kernel transforms, original coefficient enclosures and cache provenance remain charged separately; F is not G. A memory-saving representation using c,Cplus,Dminus must still recover d=(Cplus+Dminus)/2 exactly and preserve its original enclosure.

The prior addition-width erratum applies: output additions operate at raw-product widths, not input widths. Ordinary-rule MM0 must check signed integer arithmetic, magnitude products, carrying, comparisons and (3). Lean must validate the same mathematical operations through its chosen representation. No unchecked native multiplication, faithful export, or constant-time arithmetic premise is introduced. These costs are additional to the symbolic product/addition inventory.

## 7. Whole-circuit acceptance and remaining implementation work

A concrete implementation can instantiate this paper refinement by supplying:

1. The fixed original finite circuit/index schedule and retained-output map.
2. Common-grid input and coefficient centers, with their original enclosures and all local/global safety inequalities.
3. Exact cache-sum certificates, or the explicitly budgeted residual certificates of section4.
4. Adequate signed temporary capacities and exact integer operation checks for (2).
5. Final coordinate rounding checks (3), including the declared tie rule, at every changed gate.
6. Existing kernel setup, transform normalization, downstream output-error and any required immutable-box containment checks.

Induction over the circuit supplies the accepted abstract gate contract at every node, so the prior direct/radix-two/CT/Bluestein proofs and (1) apply. This closes the paper implementation-refinement gap for the fixed-coefficient row in the operation budget. It does not supply the missing coefficients, roots, transformed values, signs, Turing bounds or finite-RH evidence, nor does it establish a runtime improvement.

## 8. Source and report pins

The following frozen artifacts were read for this refinement. Paths except the first are relative to `work/qrh-campaign/agents`.

| Artifact | SHA256 |
|---|---|
| work/qrh-blueprint/CURRENT_SPECTRAL_OPERATION_BUDGET_2026-11-11.md | D0D428B355F2DBD025DBE2BD6C4D1DC846B63892A81506445EC242571A8C1C7F |
| prime-estimates/EFFICIENCY_COMPLEX_THREE_PRODUCT_2026-11-11.md | 83D8C2953A4AEE557786904C09CED8433972876AA0B6698EBA8BF2C3B5F39EF4 |
| prime-estimates/ERRATUM_COMPLEX_ADD_WIDTHS_2026-11-11.md | AD8DC7692F68A44BF0D10BB6E348DD0D8A3368FF76FC5A94BBF07BFD76030362 |
| independent-feasibility/REVIEW_EFFICIENCY_COMPLEX_THREE_PRODUCT_2026-11-11.md | 684D012748AD53D492A46B643CEF78550D5CF7359AFFECEB7048E9B5118F39DE |
| zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md | 4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4 |
| audit/REVIEW_MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md | 1268986720865E47569FC5E568546194C0A61EDC9AE80CDD78502CDC77385537 |
| independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md | 5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A |
| major-constants/REVIEW_MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md | A1D0815D5B186F0E07CCCFDD4EE3035D5E74D780CC4364ED49866AC30B56EF2F |
| zero-sum/CONDITIONAL_R132900_SPECTRAL_PRUNING_INVENTORY_2026-11-11.md | 7AA9BF4D456CE25685D69427966DC7F61D0914DD091A95B74F9C242B95CADB27 |

The predecessor gate paper pins the source complex-product coordinate definitions and signed-dyadic rounding plan. The new implication here is the explicit common-grid gate refinement and its composition with the already stated transform hypotheses, not a new special-function theorem. No numerical check is needed for the distributive identities or rational inequalities used above.
