# Complex multiplication with ordinary-PA Karatsuba templates

2026-11-11. Exact symbolic and integer metadata research only. No complex values, transforms, analytic functions, arithmetic tables, proofs or benchmarks were generated. No build ran. This supplements the reviewed complex identities and their addition-width erratum; none of those frozen bytes changes.

## Scope and finding

Combining three-real-product identities with Karatsuba requires pricing different operand widths, not replacing every multiplication with the same cost. The fixed-coefficient identity has three products enlarged on one side. Gauss has two original-size products and one product enlarged on both sides. Their different costs can outweigh the fixed identity's saving in additions.

The tables below are **unsigned arithmetic-template skeletons**, with separately missing signed, encoding, cache and rounding proof costs. They use total mantissa bit bounds, not fractional precision. They are not a spectral workload estimate or a runtime comparison. In particular a fixed twiddle often has fewer integer-magnitude bits than its input; equal-width rows are sensitivity cases, not permission to double the full stored input width when bounding a real product.

## 1. Exact gates and widths

Let a,b be signed mantissas on one certified common grid, with |a|,|b|<2^P, and c,d on another common grid with |c|,|d|<2^Q. Product grids then agree. P and Q include every integer and fractional bit needed after alignment. A fractional precision p by itself is not P or Q. Huge exponent-gap alignment is not authorized by this model; use the existing bounded-alignment or rounded-pre-sum contract when needed.

The four-product gate is (ac-bd,ad+bc). The fixed-coefficient gate is

    t=c(a+b), u=b(c+d), v=a(d-c), output=(t-u,t+v).

Gauss uses u=ac,v=bd,w=(a+b)(c+d), output=(u-v,w-u-v). Exact expansion proves all three equal. With exact pre-sums and only final rounding, they have the same exact center and the same input/coefficient uncertainty. Equality of final rounded bits additionally requires the same output grid, rule and adequate capacity.

Safe magnitudes for the actual arithmetic path are:

* original products: magnitude below 2^(P+Q), hence at most P+Q bits;
* fixed products: at most P+Q+1 bits; fixed output additions: capacity P+Q+2 bits;
* Gauss large product: at most P+Q+2 bits; its intermediate and final imaginary subtractions: capacity P+Q+3 bits;
* four-product output additions and Gauss real output: capacity P+Q+1 bits.

Here “capacity N bits” bounds the unsigned magnitude by 2^N; sign is separate. The Gauss subtraction path can pass through absolute bounds 5*2^(P+Q) and 6*2^(P+Q), even though the final mathematical imaginary part has a smaller bound. Do not assume that cancellation has already happened when selecting its temporary capacity.

These replace the withdrawn input-width addition totals in the original JSON. Cached c+d,d-c are exact sums of the same stored c,d, not independently normalized analytic approximations. If they are rounded, the original error terms |b|*eta_C and |a|*eta_D remain, and the widths and costs must be recomputed for that implementation.

## 2. Product templates: padded and unequal schedules

For radix beta=2^b let M(a,b)=5ab+2min(a,b)+1 be the earlier rectangular schoolbook skeleton and A(n)=2n+1 the unsigned addition proxy. Avoid confusing the radix parameter with the second argument of M. All lengths below are positive; zero values can use a padded zero digit.

The reviewed square/Karatsuba note supplies the *general-product* recurrence

    G(n)=M(n,n), n<=3;
    G(n)=min(M(n,n),G(h)+G(n-h)+G(h+1)+H(n)), n>=4;
    h=ceil(n/2), H(n)=12h+8n+21.

The third child has h+1 digits. It cannot be replaced by h. These are ordinary real-mantissa products; the modular Q(n) template and the cheaper dedicated-square template are not applicable merely because the complex multiplier is fixed.

For lengths a>=b>=1, there are four sufficient product schedules:

1. Direct M(a,b).
2. Pad the short factor with proved leading zeros and use G(a).
3. Split the longer factor into r=ceil(a/b) blocks of b digits and use r*(G(b)+A(2b)). The prior carry invariant carry<short_factor proves the next carry bound; the last carry is emitted. This is conservative even for an incomplete last block.
4. If a>=4 and b>h=ceil(a/2), split both at beta^h. Both low factors have h digits; the high factors have a-h and b-h digits; both sums need h+1 digits. Use

       R(h,h)+R(a-h,b-h)+R(h+1,h+1)+H(a).

Here R is the minimum over these available schedules, with swapped arguments sorted first. Every recursive child in item 4 has maximum length less than a. If b<=h, that branch is not used: there is no invented positive-length high factor. Items 2 and 3 use the already bounded G, so they do not create self-recursion.

The unequal branch follows exactly the positive Karatsuba proof: for x=x0+beta^h*x1 and y=y0+beta^h*y1, check z0=x0*y0, z2=x1*y1, zs=(x0+x1)(y0+y1), then supplied m>=0 with m+z0+z2=zs. Ordinary PA cancellation gives m=x0*y1+x1*y0. Recombine z0+beta^h*m+beta^(2h)*z2. H(a) is still a sufficient arithmetic overhead because the shorter high factor only reduces the prior maximal-width bounds. Leading-zero, split and numeral-representation proofs remain in the excluded overhead, as in the reviewed recurrence.

The model's minimum selects a concrete sufficient skeleton; it is not a proof that this is the best multiplication algorithm or that searching/proving its representation is free.

## 3. General unequal complex-cost interface

Define nP=ceil(P/b), nQ=ceil(Q/b), sP=ceil((P+1)/b), sQ=ceil((Q+1)/b), and

    o4=ceil((P+Q+1)/b), of=ceil((P+Q+2)/b), og=ceil((P+Q+3)/b).

For any chosen sufficient product schedule R, the complete displayed arithmetic skeletons are

    F4 = 4R(nP,nQ) + 2A(o4),
    Ff = R(sP,nQ) + 2R(nP,sQ) + A(sP) + 2A(of),
    Fg = 2R(nP,nQ) + R(sP,sQ) + A(sP)+A(sQ)+A(o4)+2A(og).

Ff excludes its one-time exact cache setup S=2A(sQ), and adds no uncharged runtime coefficient sum. Fg includes both input pre-sums. F4 includes both product-width output additions. All signed-comparison/subtraction, sign/zero cases, representation, cache binding, final rounding and radius calculations remain additional terms. Different signs can give different proofs; A is not an already implemented signed-add theorem.

These formulas are the interface to the separate spectral width analysis. That analysis must supply P,Q for each gate or safe groups of gates, including actual scale and magnitude. For example a fractional precision p and a magnitude bound do not imply equal P=Q for a cached unit coefficient and a large intermediate. The exact product capacity is P+Q plus the stated guard bits. No new spectral counts or intermediate-width certificate is asserted here.

## 4. Equal-width sensitivity results

The companion script checks P=Q in {128,192,256,512,1024} at radices 2^4,2^8,2^10,2^12,2^16. It records all 25 cases with schoolbook, padded G and unequal R schedules, including every output width and selected product branch. There are 518 additional metadata comparisons against the available schoolbook and padded bounds. No mantissa value is evaluated.

At byte radix, the unequal-schedule results are:

| P=Q | F4 | Ff runtime | Ff+setup for one use | Fg |
|---:|---:|---:|---:|---:|
| 128 | 5386 | 4348 | 4418 | 4377 |
| 192 | 11074 | 9072 | 9174 | 8840 |
| 256 | 18562 | 14855 | 14989 | 14601 |
| 512 | 60482 | 47008 | 47270 | 46556 |
| 1024 | 190350 | 145796 | 146314 | 144974 |

The near-equal product stays schoolbook at 128 bits and uses the unequal split at the other four byte-radix points. For comparison, blindly padded fixed one-use costs are 4679,9360,15235,47516,146560. Retaining the shorter high factor is a modest but real skeleton improvement; it is not an assumed equal-price multiplication.

The schoolbook F4 values for those rows are 5386,11914,21002,82954,329738. Thus the comparison improves the four-product baseline too. It would be unfair to compare a Karatsuba three-product path only against schoolbook four-product arithmetic.

All displayed three-product one-use skeletons beat their own four-product skeletons in the 25 sensitivity cases, before the excluded terms. This does not prove that their actual PA proof streams or Lean computations are cheaper. Gauss beats the cached fixed runtime skeleton in four of the five byte rows, despite using two more runtime additions: its two original-size products matter. At 128 bits the fixed runtime saving against Gauss is only 29 proxy events, so its setup of 70 requires at least three uses for a strict skeleton saving. At the other four byte points there is no such fixed-versus-Gauss asymptotic saving under this model.

## 5. Cache amortization and omitted costs

For H uses of one fixed coefficient, the displayed fixed cost is S+H*Ff, versus H*F4 or H*Fg. With Delta=F4-Ff>0, the skeleton break-even is H*Delta>S, equivalently floor(S/Delta)+1 uses for strict improvement. The script also records the analogous Gauss comparison and marks it absent when Fg-Ff<=0. In all 25 displayed cases setup is already amortized against F4 after one use.

For an actual proof cost, write D4,Df,Dg for per-use excluded costs and Dsetup for setup/binding. The condition becomes

    H*(F4-Ff) > S + Dsetup + H*(Df-D4).

Use the same cost unit throughout; memory bytes are a separate resource, not automatically proof events. Two extra cached signed magnitudes have at most Q+1 bits each, plus sign, exponent and indexing metadata. Their derivation from c,d, storage, lookup and reuse at the right precision all need checked bindings. Their setup error may be zero only for the exact common-grid operation. Changing the coefficient enclosure or required cache precision may require a new entry and new S.

At workload level, sum the unequal formulas over actual gates and distinct cache entries. A single global complex-product count times one equal-width row discards the precision/magnitude distribution and is not a sound cost estimate. Existing quarter-turn, sign-flip and zero/one simplifications should remain separate; they should not be charged as generic products just to increase the apparent saving.

The full center computation can round only at its two outputs, with the already reviewed absolute error allowance. A per-gate rounded implementation is another case and must pay the original error propagation; this table does not grant extra precision for free. No sign, nonvanishing or accepted output-box conclusion follows from this arithmetic comparison.

## Evidence and remaining implementation boundary

* Complex identity/error note: `EFFICIENCY_COMPLEX_THREE_PRODUCT_2026-11-11.md`, SHA256 83D8C2953A4AEE557786904C09CED8433972876AA0B6698EBA8BF2C3B5F39EF4.
* Width correction: `ERRATUM_COMPLEX_ADD_WIDTHS_2026-11-11.md`, SHA256 AD8DC7692F68A44BF0D10BB6E348DD0D8A3368FF76FC5A94BBF07BFD76030362.
* Independent combined review: `independent-feasibility/REVIEW_EFFICIENCY_COMPLEX_THREE_PRODUCT_2026-11-11.md`, SHA256 684D012748AD53D492A46B643CEF78550D5CF7359AFFECEB7048E9B5118F39DE.
* Product recurrence: `EFFICIENCY_MM0_SQUARE_KARATSUBA_2026-11-11.md`, SHA256 4ADB3C676ABA3A82128A8F27CBB91221B414689F94CDC5D60BA0FA75A8421FFA; independent review SHA256 767753AB7CE59C69922363DCF239C55B2D81C716194D62D977EE4CFE9F75A7B1.

The underlying pinned PA sources and their addition, cancellation, distributivity and digit-multiplication interfaces are those recorded in the reviewed recurrence. This supplement adds a sufficient unequal split and composes existing skeletons; it does not assert that a signed dyadic implementation, proof expander, reused cache or Lean numeral reduction has been built. A matched test must prove those bridges and count actual theorem applications, encodings, unification and memory before claiming a winner.
