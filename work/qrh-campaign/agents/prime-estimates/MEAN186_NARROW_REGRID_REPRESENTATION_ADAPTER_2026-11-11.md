# Narrow representation adapter for the mean186 input converter

2026-11-11. Conditional paper adapter, submitted for independent review. This refines the conservative converter capacity contract without changing its actual source, rounding function, output center or error. It does not change a frozen assignment, cache, selector or price artifact. No inventory, assignment reconstruction, numerical value, fold, build, declaration or proof object was produced.

## Source contract and proposed refinement

The mean186 assignment preflight D804D1A6 retains the input contract from EM692 preflight01BC1696. Its source is the exact grid100 sum of the admitted full-P20 fixed-shape b94/min65 polynomial and a separately certified actual grid100 finite-head center. The actual assembled complex norm is below690. Source alpha/head/representation errors, exact export, height and unit identities, and the nonnegative radius sums required by mean186 remain premises.

The retained converter permits p in [50,108]. Below100 it checks, separately for each signed coordinate n,

    n+2^(d-1)=q*2^d+t,  0<=t<2^d,  d=100-p.       (1)

At100 it keeps n; above100 it uses n*2^(p-100) exactly. Its allocated capacities are signed source115, destination p+15 and raw116. These are sufficient representation capacities, not required lower bounds on the number of bits or a different arithmetic function.

The proposed adapter consumes this semantic contract and the reviewed converter-capacity lemma99FC177B/review9FDA531D. It permits signed source111, destination p+11 and raw112 on the rounded branch, subject to the checks below. It must be recorded as a new implementation/representation adapter with its own version and reviewed pin. The old contract and its explicit 'no narrower converter adopted' flag remain unchanged. A future price artifact must name the adapter rather than overwrite or silently reinterpret that flag.

## Unique accepted rounding witness

Let B=2^d with d>=1. If two integer pairs (q,t) and (q',t') satisfy (1), then

    (q-q')*B=t'-t,  -(B-1)<=t'-t<=B-1.

The only integer multiple of B in that interval is zero. Thus q=q' and t=t'. A pair exists by Euclidean division of n+B/2 by the positive integer B, with nonnegative remainder. This is a mathematical completeness proof. The checker still accepts through equality and ranges, not a trusted native division instruction.

Consequently both implementations accept the same q and t for a fixed actual n and p. The source-minus-output residual is

    n-q*B=t-B/2 in [-B/2,B/2).

This is nearest rounding with half ties toward positive infinity for positive and negative n. At an exact tie the residual is the negative endpoint. For n=0 the unique pair is q=0,t=B/2. A signed representation of negative zero must be normalized or proved to denote the same integer; it cannot create a second semantic output.

Both coordinates therefore yield exactly the same complex center on gridp. Each coordinate error is at most2^-p/2, so complex error is at most2^-p/sqrt(2)<2^-p. This is the same single input-regrid error, with rho=1 below100. It is not added again to head/source errors or multiplied by the intrinsic arithmetic constant. Equality of accepted centers follows from (1), range uniqueness and actual source binding, not from matching contract hashes.

## Narrow ranges and acceptance order

For the actual source coordinate, the norm premise gives

    |n|<690*2^100<2^110.

For the unique correct q, nearest rounding gives

    |q|<=|n|/2^d+1/2<690*2^p+1/2<2^(p+10).       (2)

The last strict inequality holds throughout p>=50. Thus the narrower destination admits every correct old witness. It uses the stronger690 premise, not merely the bit bound |n|<2^110.

A checker cannot borrow (2) for a malformed supplied q before proving (1). The narrow implementation first establishes independently

    |n|<2^110, |q|<2^(p+10), 0<=t<2^d,

and binds n to the actual source coordinate. Checked signed-magnitude decompositions can establish these ranges. An encoding with enough whole bytes does not by itself establish the exact bit bound. For d50, for example, seven remainder bytes still require the top byte to have at most two bits.

Only after those facts are available may the narrow arithmetic templates be used. They give

    |q*2^d|<2^110,
    |n+2^(d-1)|<2^110+2^49<2^111,
    |q*2^d+t|<2^110+2^50<2^111.

Thus source and shifted-q capacities are111 signed bits; destination is p+11 signed bits; raw addition results are112 signed bits. Here a signed capacity means an unsigned magnitude capacity plus a sign, not native two's-complement behavior. Opposite-sign addition witnesses are bounded by the larger operand and remain within the same safe magnitude allocation. No small residual after acceptance justifies trimming an earlier unchecked raw product or sum.

The narrow implementation then proves both signed additions, equality of their resulting interpreted integers, and the rounding consequence. The source/candidate range checks are prerequisites to this proof order. An old accepted witness can be translated into this representation because its semantic integer pair is unique and satisfies the tighter ranges. Translation may drop only proved leading zero digits and may change sign/zero encoding only by a proved equality. Conversely every narrow accepted witness satisfies the old wider bounds and equation, so it supplies the old semantic result. Neither direction requires computing another rounded center.

## Exact branches

At p100, the output numerator is exactly n. There is no remainder, no half-power formula with d=0, and no input-rounding error. At100<p<=108 the numerator is exactly n*2^(p-100), also with zero error. Its strict magnitude is below2^(p+10), so p+11 signed bits suffice. At108 this can require119 signed bits; the rounded branch's112-bit raw bound must not be applied to that exact destination.

These branches retain their actual identity/shift, range, grid and source-transport proofs. They carry rho=0 and no mandatory four-addition rounding charge. The semantic output of either branch is fixed by its equality, so capacity refinement again preserves the exact center. A future policy confined to p<=100 may omit above100 executions only after its selected range is established; the adapter itself covers the full retained domain.

## Fields and proofs required for use

A consumer must bind the following actual objects and properties. A digest identifies the frozen record; it is not a substitute for the mathematical associations.

| Contract information | Required role in the adapter |
|---|---|
| Original source/head/assembly objects, conductor, exact height, unit order and coordinate | Bind n to the same grid100 input, rather than another small integer. |
| Full-P20/grid94/min65 admission and exact grid100 export | Preserve source normalization and the separately proved alpha/error interface. |
| Actual raw norm below690 | Prove the strict source and correct-output narrow ranges. Mean186 alone is insufficient. |
| Destination p, domain50..108, exact powers and tie rule | Fix equation(1) or the exact branch and its unique output. |
| Witness q,t and their interpreted integer encodings | Prove equality across old/new representations, canonical zero and pre-acceptance ranges. |
| Error/radius and nonnegative head/representation sums | Preserve the original mean-input and complete-error premises without double charging. |
| Producer contract, proof references and lifetime | Bind reuse to actual objects and retain conversion, import, storage and reconstruction costs. |

The current mean186 preflight contains these semantic fields and explicitly keeps conservative capacities. This adapter refines only the arithmetic implementation of that already defined conversion. It does not alter S_t, the exact tensor denominator, phi/sqrt(c), the selected p, rho, the old safety/peak guards, V_error,mean=186 or V_width=692. It changes neither the source vector nor the converted vector. The complete target radius therefore remains exactly the prior conditional target. It transfers no old strict-sign result unless the same actual center and all its existing evidence are bound; no such numerical evidence is supplied here.

Kernel/root/chirp contracts and exact low-center sums remain separate. The adapter does not justify shared-high caches, different normalized kernels or changed transform arithmetic. Actual assignment output and summary hashes, when available and independently accepted, must be bound by a future consumer. No assignment data were read for this paper.

## Matched cost interface

The retained schedule uses two signed witness additions per coordinate. With the existing unsigned byte-adder core A(w)=2*ceil(w/8)+1, both111 and112 use fourteen bytes and A=29. Four roles therefore have116 unsigned core units rather than the conservative124. This is the reviewed matched schedule, not four ordinary theorem commands or a complete converter price.

Pre-acceptance ranges, signed cases, exact shifts/powers, partial-byte extraction, source/output equality, zero normalization, representation transport, proof references and witness generation remain additional. A change from the wider encoding must pay its actual conversion or establish that the producer emitted the narrow encoding directly. The range checks cannot be charged as zero because semantic completeness proves that a correct witness exists.

For any later admitted policy the rounded-input subtotal is116 times the actual weighted number of inputs with p<100. Identity and exact embedding have distinct counts and costs. This paper computes none of those counts. It neither multiplies by primitive-output labels nor refunds sunk wider proofs. The cost difference is conditional on a future artifact explicitly choosing this reviewed adapter.

## Frozen source pins

Paths are relative to work/qrh-campaign/agents. The adapter relies on the paper interfaces, not any unreviewed assignment writer or data output.

| Source | SHA256 |
|---|---|
| major-constants/MEAN186_EXACT_TENSOR_ASSIGNMENT_PREFLIGHT_2026-11-11.md | D804D1A6CEBBDB812A35132CC05A79B9FA8A6B3D510CCF49A9ACCFCC588F1A64 |
| major-constants/EM692_EXACT_TENSOR_ASSIGNMENT_PREFLIGHT_2026-11-11.md | 01BC1696B7AF781D5638968A18E551014658B86986823B2C65F7AAE15433292A |
| independent-feasibility/MEAN_INPUT_TIGHT_CONSTANT_TENSOR_COMPANION_2026-11-11.md | 4A7EB4A925A84F70F882A2AC4A1D44B5EB6132B5C6066C12FB4DC4159EF1CDED |
| integration/REVIEW_MEAN_INPUT_TIGHT_CONSTANT_TENSOR_COMPANION_2026-11-11.md | A4B204E9EADBB29F51BA56CCC2FBCD417E1AF90254605E9877524970DC2C5021 |
| audit/EM692_REGRID_CONVERTER_CAPACITIES_2026-11-11.md | 99FC177B6F200502407802E7A8FF6E98196EBF51A932A2B68EC38B693A46EB35 |
| zero-sum/REVIEW_EM692_REGRID_CONVERTER_CAPACITIES_2026-11-11.md | 9FDA531D3257E74A6636303755D19B3A1217D0692B335190557385C429E51F2C |
| prime-estimates/REVIEW_MEAN186_RUNTIME692_PROSPECTIVE_PRICE_DESIGN_2026-11-11.md | FB47DA67C19A02BA9D6F0B4FC37F00B66C623FD928B7C1E8C0908E8ECCD5F01E |

This is a proposed representation refinement awaiting independent review and explicit consumer adoption. It authorizes no assignment reconstruction or price fold.
