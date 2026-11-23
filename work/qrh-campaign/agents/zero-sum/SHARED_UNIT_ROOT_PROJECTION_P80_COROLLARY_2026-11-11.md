# Shared unit-root projection on grids p80 through p108

2026-11-11. Conditional producer corollary, submitted for independent review. This extends only the precision range of the reviewed H110 unit-root/chirp adapter. It admits no subgrid100 transform, input regridding, changed stability allocation, new leaf theorem or production schedule. All predecessor files remain unchanged. No root, angle, coefficient, conductor or demand set was enumerated or evaluated; no declaration, proof object or build was produced.

## Corollary and proof

Retain an exact specified complex unit rho and a certified grid equality

    rho_H=(A+iB)*2^-110,     |rho_H-rho| <= 2^-110,

with signed integers A,B. The error is a complex-norm bound, including high-center creation error. Two coordinate radii each equal to 2^-110 are not this premise without a norm conversion.

For each requested integer p in 80,...,108, project each high coordinate directly to the nearest grid2^-p point, with ties toward positive infinity. Put k=110-p, so 2<=k<=30. Coordinate rounding changes the complex center by at most sqrt(2)/2 times 2^-p, strictly less than 3/4 times 2^-p. Thus

    |rho_p-rho| < (2^-k+3/4)*2^-p <= 2^-p,
    |rho_p| < 1+2^-p.

This is the already reviewed H>=p+2 theorem. The exact p=H reuse branch remains available under its original non-strict bound, but is not one of these 29 low-grid demands. A one-bit gap is not admitted. Every low center comes directly from the high center; successive projections are not substituted.

The exact positive-DFT/CT/chirp identities, including difference-kernel signs, remain part of the source binding. Sharing requires an actual proved equality of the specified complex units. Ties-positive projection is not odd, so conjugation or negation does not automatically commute with it. A separately bound isometric output recipe remains possible under the old proof. Gauss root numbers, Hardy/Gamma/completion phases and their canonical choices remain outside this catalogue. The nonunit cached Bluestein kernel has a separate producer and error theorem.

## Integer witnesses and capacities

For one high coordinate A and d=2^k, the floor route checks

    A=q*d+r,  0<=r<d,  M=q+[2r>=d].

The equivalent residual route checks R=A-Md and -d<=2R<d. These are exact signed equalities and inequalities; native division, a machine overflow or a small asserted residual is not evidence. Since d is even, the latter interval can equivalently be checked as -d/2<=R<d/2, without doubling the raw residual.

The high coordinate satisfies |A|<=2^110+1. Rounding implies |M|<=2^p+2^-k+1/2<2^p+1, so integrality gives |M|<=2^p. Check this candidate range before using it to bound raw arithmetic. Equality is allowed. The following sufficient capacities use magnitude bits plus an explicit sign bit.

| Quantity | Capacity for all 29 grids |
|---|---|
| High coordinate | 111 magnitude, 112 signed |
| Projected coordinate M | p+1 magnitude, p+2 signed |
| Md | At most 2^110 in absolute value |
| Raw A-Md | 112 magnitude, 113 signed |
| Raw 2(A-Md), if formed before narrowing | 113 magnitude, 114 signed |
| Floor quotient q | p+1 magnitude, p+2 signed |
| Floor product-plus-remainder raw absolute bound | Below 2^111, 111 magnitude / 112 signed suffice |
| Unsigned r and 2r | k and k+1 magnitude bits, at most 30 and 31 |
| Accepted signed R | k+1 signed bits, at most 31 |
| Accepted signed 2R | k+2 signed bits, at most 32 |
| Exact low sums C+D and D-C | p+2 magnitude, p+3 signed |

Indeed the generic raw residual bound is 2^111+1, and its double is bounded by 2^112+2. The floor route has |q|<=2^p+1 and

    |qd|+r <= 2^110+2^(k+1)-1 < 2^111.

Only after acceptance does |R|<=2^(k-1) justify the small signed capacity. The 31-bit accepted residual must not be confused with either the unsigned doubled floor remainder or the signed doubled residual.

At byte radix, the high magnitude still fits 14 bytes; every displayed generic raw signed quantity fits 15 bytes. The floor remainder and its double fit four bytes at the new worst case. The signed bridge's Split_8(14)+3A(15)+O(1) remains a sufficient local rounding-macro template before optional canonical normalization. Its split cost includes the whole low-digit part and the final partial-byte transition for k<=30. Exact shift/fold proofs, range facts, signs, equality and source transport are still charged. This macro is not an emitted ordinary-MM0 instruction count or a serialized proof-size bound. A different residual implementation must price its actual operations; both alternatives are not simultaneously mandatory.

The common-grid low representation is (M,-p). If a consumer instead requires canonical odd mantissas, normalize the current pair with the separately checked exponent update. Exact cached sums must be sums of the selected LOW centers, on their common grid. They introduce no analytic error, but their integer additions and bindings cost work. Projecting a high sum or reusing an unrelated old sum does not establish the required equality. The exact-internal three-product proof applies only after those actual low operands and sums are bound, with its own product and temporary widths unchanged.

## Demand and cost boundary

Let I be the actual set of checked exact unit identities and P_i a nonempty subset of {80,...,108} requested for identity i. With J=sum_i |P_i|,

    |I| <= J <= 29|I|.

One persistent high object per identity and one low object per requested pair require |I| high constructions and J complex projections, hence 2J scalar certificates. A full fixed-three-product sum cache uses 2J exact real additions. Mixed Gauss/fixed cache requests use the original demand-union rule. Rebuilds, imports and separate lifetimes replace these counts by their actual multiplicities. No cardinality, sharing success or saving is known here. Reuse never divides the enclosure radius by its use count.

The original separate producer/checking/byte break-even equation remains valid with the enlarged demand set. High construction, projection, exact sums, identity transport, cache lifetime and proof representation all remain paid. A lower center differs in general from an old independently produced center, so successful signs do not transfer. Most importantly, availability of p80 root enclosures does not make grid100 source inputs exactly representable at p80, validate a lower-precision kernel, or settle any downstream magnitude or error budget.

## Fixed evidence

The exclusive script `shared_unit_root_projection_p80_20261111.py`, SHA256 `201665CE4F2AE4C75CF0FD720A109073A3687FD8E5EBC0A43C3A99544034764C`, passed 359 exact checks over the 29 precision labels and five file hashes. It enumerates precision labels only. Its 32,182-byte receipt `shared_unit_root_projection_p80_20261111.json` has SHA256 `6D945B0E72D1AA18CC1C373D2E7560CD2F956F1DF85824681C84E9F95CE755A6`. Identity counts and lifetimes are explicitly unknown.

Paths below are relative to `work/qrh-campaign/agents/`.

| Source | SHA256 |
|---|---|
| prime-estimates/SHARED_UNIT_ROOT_CHIRP_PROJECTION_2026-11-11.md | 01C4FE83F6F642D47977825696B70F308156F5E3B2532EBA75A62255A3B03EEB |
| zero-sum/REVIEW_SHARED_UNIT_ROOT_CHIRP_PROJECTION_2026-11-11.md | C1D3C4F7AE61B3A1176BC0792C7F2B27CAEAEEB5BE86080770DEC1438AA586C5 |
| prime-estimates/EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md | EBF10D893D5CF50E8B45FD6EB5A3EE54F44BB99389741961A09E299BD311ADBD |
| prime-estimates/CLARIFICATION_SIGNED_DYADIC_CURRENT_EXPONENT_2026-11-11.md | 8400322999DE07ED203F1556EEC5D8771B9E2910533BFF231C96E244C05BDF03 |
| audit/REVIEW_EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md | E3EFDD1A7DC6185E02421DDB0E50417748FB694EA663E5663AAE6416446266A7 |
