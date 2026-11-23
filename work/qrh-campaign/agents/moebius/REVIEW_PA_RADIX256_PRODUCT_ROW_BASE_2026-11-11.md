# Review of the PA rectangular-product row and bases

2026-11-11. PASS for the paper algebra, explicit signatures and conditional arithmetic-core counts, with no correction requested. The terminal macro closes the original product equality; no uncounted final extraction is needed. Its final source/output binding premises remain additional proof obligations, so this is not acceptance of a complete 202-event multiplier or an implemented PA library.

The review used source reading, formal polynomial dictionaries, syntax trees and exact integer metadata only. No author generator was imported or executed. No numerical product instance, byte enumeration, emitted proof/declaration, build or function evaluation was performed. Earlier frozen artifacts remain unchanged. The proposed literal-zero product-cell specialization is outside this review.

## 1. Frozen packet

Author paths are under `work/qrh-campaign/agents/prime-estimates/`.

|Artifact|SHA256|
|---|---|
|PA_RADIX256_PRODUCT_ROW_BASE_2026-11-11.md|71D3F4BF6558618A84E652B1E041BBA26BA095679562ED951DFEA138DC9F5CAC|
|radix256_product_row_syntax_20261111.py|776BAEB7AE70115601404BB86207D9499D64246E11EACCBABDC7981BE178A176|
|radix256_product_row_syntax_20261111.json|3C3372F84D1AA46997E98DC7C101C75DE13F6BA9A2B0710ADAA6EA5C0BE8430B|

The consumed cell packet is 3670294B3CAE9C9459344571FEFAF80BB4D36FCD60EADE47AFEDB03E020EC74E, its mandatory closed-fact clarification is F0705C64C524D9AC3051C51507DA9BCF0FD368796C0EE63A43518AB1C035F9D2, and the independent cell review is DDA93BA814D78B2339E37C2588BC3DF8D0747BC5AF660BD51BAA9327569452EA. The row packet preserves their equality-only cell conclusion and separately charged ranges.

Own `moebius/review_radix256_row_base_20261111.py` has SHA256 `7E8BF8FE93294927BAE538896E6B350F20AB70C1CE2C852F6CC91F59103CCBAE`; its JSON has SHA256 `AD65CE8048D0143656FBAAC617F776486B7FD4F94D39053509EFDF81FD373555`. It passes 55 checks, binding the three author artifacts and six upstream inputs. It independently checks the formal row identities, four expanded syntax/count rows and the shape-count formula. It does not check a generated arithmetic proof.

## 2. The invariant and its actual range proof

The invariant is fully expanded and consistently associated:

    I(x,Y,l,P,A) = (l+P*A=x*Y) AND (A<x AND (l<P AND 0<P)).

This is a paper abbreviation, not an assumed predicate with hidden axioms. Passing the complete proposition from one update to the next lets the generic update's own proof extract and reassemble the components. The caller does not need an extra projection macro merely to recover A<x.

The row equation is `(x*y+A)+0=beta*B+d`. From the equality in I and this equation, the exact identity is

    (l+P*d)+(P*beta)*B = x*(Y+P*y).

The independent symbolic check reconstructs it by multiplying the row equation by P and using distributivity, associativity and commuting P with x. It uses no division or actual product evaluation. Substitution of the three intermediate bindings gives the new invariant equality; substitution of the two terminal bindings gives `x*Ytotal=Z` directly.

The intermediate update proves the ranges it exports. Since A<x and y<beta,

    A+x*y < x+x*y = x*(y+1) <= x*beta.

The row equation and d>=0 give `beta*B<=A+x*y`. Positive beta then permits strict multiplicative cancellation and proves B<x. Likewise l<P and d<beta give

    l+P*d < P+P*d = P*(d+1) <= P*beta.

The ln/Pn bindings therefore give ln<Pn. Positivity of P and beta gives positivity of Pn. There is no reliance on an internal, unexported carry bound from the preceding cell theorem.

The terminal update correctly omits unused outgoing range conclusions. It uses the stronger final output binding `(l+P*d)+(P*beta)*B=Z` instead. That binding is not a theorem supplied by the cell equation alone, and its construction cannot be omitted from a complete cost. The multiplier binding is equally necessary: an equation about a newly formed symbolic prefix is not automatically about the supplied multiplier numeral.

## 3. Source and loop boundaries

The immediate source is `work/mm0-efficient/toolchain-sources/examples__peano.mm1`, hash `13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079`, with its `.mm0` signature hash `463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052`. The inspected conjunction introduction/projection bodies at 488–496 support the exact state association. Equality and arithmetic laws at 2034–2153 support the bases and row identity; natural monotonicity/strict transitivity at 2191–2283, `ltmul1/2` at 2385–2392 and `mulpos` at 2409 support the exported ranges. The optional `pow0/powS2` bodies at 4999–5003 support an explicit power-position representation if one is chosen. No quotient/remainder theorem is silently consumed by the equation-based version.

These are immediate source ingredients for a new paper derivation. No new formal theorem body or complete source axiom-closure extraction was checked. The fixed radix uses natural b0/d1 definitions, not the hex coercion axioms.

The inner base `((0*y+0)+c)=c` is sound for every natural carry. It does not return a byte bound. At each row, its terminal tail is the final carry c_m, which need not be zero. Supplied cell equations are then combined from the highest digit down to the lowest; the lowest incoming carry is zero. This agrees with a producer discovering carries from low to high and causes no circular proof dependency.

The positive path explicitly requires x>0 and m,n>=1. There are m cell applications in every row, n inner bases, n-1 ordinary updates, one terminal update and one initial outer state. In particular n=1 still has its terminal update. Leading zero digits may remain in the supplied nonempty representation. The x=0 and empty multiplier cases have separate zero-product identities and require actual x/Ytotal/Z bindings; the positive invariant is not applied where A=x=0 would make A<x false.

The source/decomposition obligations are preserved. A<x and x<beta^m imply existence of an m-byte padded A, but do not certify a supplied list. Every digit, order, padding, carry range and repeated x expression must be bound to the actual objects. The intermediate Yn/ln/Pn equalities and the terminal Ytotal/Z equalities are consumed proofs, not assignments or native arithmetic results. They may require normalized-numeral or concatenation proofs with substantial cost. The reviewed cell's internal proof of k<beta is still not an exported fact, and d<beta remains separate.

## 4. Exact macro and command counts

The independent syntax reconstruction agrees in every row:

|Macro|Expression arguments|Premises|Unshared header including END|Cached call|Fresh call|
|---|---:|---:|---:|---:|---:|
|Inner base|2|0|10|4|12|
|Initial outer state|1|1|26|4|24|
|Intermediate update|11|7|120|20|40|
|Terminal update|10|4|80|16|20|

The I proposition is expanded in these counts. Beta has eight b0 heads and the d1 head; the fixed zero/one terms retain their definition heads. The cached call rule is a+h+2. The fresh rule is a+h+size(conclusion)+1 with all leaves and premises saved and no new conclusion sharing. These are legal proposed schedules, not emitted MMB counts. Exact expression identity, premise/header construction, unification execution, generic proof bodies and source binding remain part of the accepted command model E57FCF24.

For the positive nonempty core,

    4mn table uses + mn cell lifts + n inner bases
       + (n-1) intermediate updates + terminal + initial
       = 5mn+2n+1.

Thus two per-row roles and one initial role are now specified. The terminal is a replacement, not an omitted extra operation. With D restricted to newly applied closed zero-argument/zero-premise facts, the connected-DAG bookkeeping is

    V=mn+2n+1+D,
    H=9mn+7n-2,
    R=16mn+15n+1+D,
    H+R+C+2=25mn+22n+1+D+C.

The first three formulas follow by summing the actual signatures, including the initial positive-input premise and the different terminal signature. For m=13,n=3 the macro subtotal is 202, while the command expression is 1042+D+C. These are different quantities. New parameterized binding/range/decoder proofs add their full argument, premise and term-child counts. Closed ground binding facts can enter D only after their own ordinary proofs are checked; moving those proofs into setup does not remove their work.

The packet therefore closes the conditional paper interface for the original two-row-roles-plus-base convention. It leaves the range and serialization producers, PA tables, actual generic theorem proofs, exact expression-DAG schedule, storage limits and complete target binding open. This scoped acceptance supplies neither a complete multiplier cost nor a runtime or end-to-end formal-proof conclusion.
