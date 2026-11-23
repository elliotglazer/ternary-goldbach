# Exact power-of-two normalization of residue differences

2026-11-11. New conditional integer-arithmetic design. No coefficient, polynomial, elementary, prime, zero or transform values, builds, source edits or frozen mutations. Exact formal-polynomial identities and conductor-class metadata only. Independent review and any cost adoption remain separate.

There are two useful exact reductions. A cell-dependent common factor removes 19t bits from the completed numerator, denominator and every difference. An order-dependent factor then reduces stored differences further, while traversal uses shifted additions. Neither operation rounds a coefficient or changes the polynomial. The final output does not receive the second reduction because order zero has no order-dependent factor. Old Horner receives the same fraction cancellations at its actual target, so comparing against an unreduced Horner denominator would be unfair.

## 1. Exact cell cancellation

Retain the reviewed full-state c>10F domain, degree d=19, coefficient bound C=2^16, ties-down anchor k, actual output denominator F=2Dout=2^f, and exact common coefficient grid z_j=n_j/2^b. All nonunit positions still advance the state. Write

    c=2^s w, w odd, v=2c, q(a)=Fa-kc,
    I(a)=sum_j n_j q(a)^j v^(19-j), Q=2^b v^19.

Define the exact common power of two of v,F,kc by

    t=min(f,s+1,s+nu2(k)),
    t=min(f,s) for odd k,   t=min(f,s+1) for even k.

At k=0 use the second formula, or nu2(0)=infinity. Then

    v'=v/2^t, F'=F/2^t=2^delta, delta=f-t,
    q'(a)=q(a)/2^t,
    I'(a)=sum_j n_j q'(a)^j v'^(19-j), Q'=2^b v'^19,
    I=2^(19t)I', Q=2^(19t)Q', I/Q=I'/Q'.                 (1)

All divisions here are exact integer identities. They follow from the checked conductor decomposition and anchor parity. Every completed difference has the same factor because finite differences are integer linear combinations. The cells, targets, coefficient array and tie rule are unchanged.

One may generate the reduced circuit directly. Prescales are now n_j v'^(19-j), not a blanket division of each old prescale by2^(19t). During Newton initialization the old partial polynomial of degree i equals2^(it) times the reduced partial polynomial. Only at degree19 is that common factor2^(19t). This degree distinction is required for state and cache bindings.

The cancellation is stronger than conductor-only min(f,s) by one bit when s<f and k is even, including half the anchor parities for odd conductors. It is weaker than removing all powers of two in v in other cases. For example, when s<f and k is odd, q/2^s is odd, while v/2^s is even. A formal input with only the top coefficient numerator equal to1 has an odd reduced polynomial numerator at such a point. Coefficient-independent cancellation of the remaining denominator power is therefore invalid.

This t is the largest power common to the linear-form data v,F,kc. Actual coefficient divisibility can permit further reductions, but it needs explicit additional evidence. It is not inferred from a norm bound or from the fact that the denominator has a power-of-two factor.

## 2. Normalize each difference order

For delta>=0 define

    lambda_j=j*delta+nu2(j!), lambda_0=0,
    E_j(a)=Delta^j I'(a)/2^lambda_j.                    (2)

These are integers. One proof expands monomials and uses that Delta^j t^h at zero is j! times an integer. A constructive proof follows from the normalized Newton recurrence below and then the exact advance identity. No concrete division is required at every update.

For the reduced partial Newton polynomial

    J_i(t0)=sum_(ell=0)^i n_(19-i+ell) v'^(i-ell)
                           (q0'+F' t0)^ell,

start with E0=n19. Set the new top first, update interior indices downward, then E0:

    new E_i=oddpart(i)*old E_(i-1),
    new E_j=(q0'+jF')old E_j+oddpart(j)*old E_(j-1),
    new E_0=q0' old E_0+n_(19-i)v'^i.                    (3)

Indeed lambda_j-lambda_(j-1)=delta+nu2(j), so dividing jF' by that power gives oddpart(j). Induction proves that every stage is exactly the ordinary Newton difference divided by its order factor. At the completed degree19, (2) follows for the initial state.

Traversal uses ascending j=0 through18:

    E_j(a+1)=E_j(a)+2^(delta+nu2(j+1))*E_(j+1)(a).       (4)

Order19 remains fixed. This identity both preserves integrality and reconstructs the original finite differences. Its shifted operand can be wider than the stored higher-order state. Shifts, signed alignment, copies and their ordinary proofs are charged operations, even though no general multiplication is required. The final output is still E0/Q'=I'/Q'.

The inherited source and rounding error are unchanged. All calculations are exact integers on the same polynomial, and the actual-function comparison remains restricted to |h|<=1/4 at original unit targets. The c>10F support extension concerns polynomial values only. Optional b100 coefficient requantization remains a separately proved adapter; this note does not derive its grid from norm accuracy.

## 3. Widths include initialization and shifted operands

Let ell=bitlength(v'^19). Equation (1) removes exactly19t bits from bitlength(v^19). The accepted support bound gives, for every live physical a,

    |E_j(a)| <256 C 2^(j-lambda_j) Q'.                  (5)

The partial-degree version replaces Q' by2^b v'^i. For an interior Newton update the sum of the two unadded magnitude bounds is

    256 C 2^b v'^i * (1/4+3j/40)*2^(j-lambda_j).        (6)

The new top and E0 have their separately bounded products. Thus the final-state identity is not being used to excuse a large unbounded intermediate. Since nu2(j!)=j-popcount(j), the finite range0<=j<=19 supplies explicit bounds. In (4), the shifted higher state has bound twice the right side of (5) for the lower order. The raw addition consequently has a factor at most three, not merely the higher state's narrower storage bound.

The following uniform exponents e mean magnitude below2^e Q', with C=2^16. They include every partial initialization degree and all live supports.

|Normalization|delta|Stored state e|Newton raw temporary e|Traversal raw temporary e|
|---|---:|---:|---:|---:|
|Powers of two only|0|28|29|30|
|Powers of two only|at least1|24|24|26|
|Full factorial, section4|0|25|24|27|
|Full factorial, section4|at least1|24|24|26|

A sufficient signed capacity for each column is b+ell+e+1. Per-order implementations can use (5)-(6) instead of the maximum. In particular the first route uses max(j-lambda_j)=4 at delta0 and0 at delta>=1. The corresponding Newton raw coefficient is below32 or1 in units256 C Q'. The finite exact receipt checks each j and degree; no coefficient values enter these bounds.

For comparison, the unreduced c>10F bounds were e43 for stored/Newton state and e44 for traversal, with ell=bitlength(v^19). Uniform cell cancellation and order normalization are separate gains. They do not remove the need for wide exact prescales or final signed rounding.

Examples from the main band's actual structural classes at b100, using each class's maximum conductor, are:

|Band1 class|Anchor parity|t|Stored/Newton/traversal signed capacities|
|---|---|---:|---|
|Odd c, maximum132899|odd|0|468 /468 /470|
|Odd c, maximum132899|even|1|449 /449 /451|
|nu2(c)=2, maximum265796|odd|2|449 /449 /451|
|nu2(c)=2, maximum265796|even|3|430 /430 /432|
|nu2(c)=10, maximum265216|either|10|301 /302 /303|

These are sufficient capacities, not measured operand sizes. b122 adds22 bits. Input decoding and any coefficient conversion have their actual potentially finer widths. For a specific c and cell, the metadata in (1)-(6) must bind the representation before a narrower capacity is used.

## 4. Exact full-factorial competitor

Root suggested the additional normalization

    Z_j=Delta^j I'/(F'^j j!).

It is integral by the same Newton induction. Its initialization has top Z_i=old Z_(i-1), interior

    new Z_j=(q0'+jF')old Z_j+old Z_(j-1),

and the same E0 formula. Traversal instead uses

    Z_j(a+1)=Z_j(a)+(j+1)F' Z_(j+1)(a).                 (7)

The same exact output and polynomial result. Width bounds follow by replacing2^lambda_j in (5)-(6) with F'^j j!. The finite maxima give the table above.

This competitor removes the190 initializer small scales. It has190 general products and190 additions, with19 explicit new-top copies and all lower-state reads. The power-of-two initializer retains190 oddpart(j) scales. The specified binary expansion still adds167 additions and357 shifted-operand occurrences, giving357 initializer additions. Removing powers of two changes shift positions, not popcount(j).

In traversal, the power-only route uses19 additions and19 shifted higher operands per advance. Binary implementation of (7) uses40 shifted operands and21 scale additions, followed by19 update additions. Thus it adds21 complex additions per advance while saving167 at initialization. Under an artificial identical-addition-price comparison alone, full-factorial has fewer additions for L<=8 and power-only has fewer for L>=9. This is not a cost selection. State widths, odd scaling proofs, copies, shift positions, initialization products, prescales and transport need their actual prices. Nor are either of these circuits substituted into a pruned long-block count without its own join.

## 5. Final rounding and a fair Horner comparator

Order normalization has lambda0=0 and creates no extra final-output cancellation. At a consumed unit, define p=min(s+1,nu2(q(a))), with p=s+1 if q=0. Direct target reduction q/2^p over v/2^p is available to both methods. For unit targets,

    p=t+1 exactly when s=f and k is odd; otherwise p=t.

In the exceptional case a is odd, q/2^s=a-kw is even and v/2^s=2w. The extra factor cannot be removed from the all-numerator state: its step F/2^s is1, and intervening even numerators do not share the divisibility. An odd-only traversal would be another algorithm. At that unit output I' and Q' may nevertheless be divided by2^19 using the target identity. This is an output-only adapter and must be charged and bound.

The original rational Horner stage must receive the same reduction. Its exact fused numerator is a coefficient term times v plus the previous center times q, after dyadic alignment. Every common factor2^p can be cancelled from both terms and the denominator. Price its reduced narrow factor and denominator, not the old unreduced v, against the new finite-difference final quotient. An unchanged polynomial does not imply equal rounded outputs between these two evaluators; each retains its own accepted error budget.

For g100 and b>=100, the reduced final-round divisor is

    D=2^(b-100)*v'^19=2^r*w^19,
    r=b-100+19(s+1-t),

or the corresponding output-only p version. Acceptance for a signed output integer m is the exact residual test

    -D <=2(I'-mD)<D.                                    (8)

Even when I' has no further proven divisibility, the multiplication in (8) may be proved as m*w^19 followed by an exact shift2^r. This reduces a product operand but does not divide I', discard its low bits, or shrink the residual's input operands. Signed half-tie behavior must still match (8). The same odd-core optimization is available to direct multiplication and fixed-digit-table checking.

The existing full-Q table report remains unchanged. A new odd-core table can key on the exact w^19, radix and theorem identity, potentially sharing across cells and conductors with the same odd core if all bindings are proved. Full reduced-denominator tables instead distinguish the relevant t/b values. At most five t values occur across f10 through14 for one conductor, often only two; actual selected lifetimes, imports, storage and rebuilding remain to be counted. No fixed-Q event saving is automatically inherited by the new comparator.

## 6. Metadata-only classes, with actual height clipping

The retained large family is odd10000<c<=132900 or4|c with10000<c<=265800. For each of F=1024,2048,4096,8192,16384 the receipt groups conductors by s=nu2(c) and anchor parity. It uses exact floor counts of odd multiples, not prime tests or unit enumeration. Each class records t,delta, maximum reduced denominator bits and the width bounds above.

Only conductors satisfying c>10F and reaching that band's first height are counted. The height input is the frozen combined odd/even packet, lines11–12, and the matching occupancy packet, line27, with

    H(c)=ceil(200+max(floor_term,A/c)),
    A=(3927/1250)*(96/5)*531600 for odd c,
    A=(3927/1250)*(191/10)*1063200 for even c,
    floor_term=240 or255,
    last_index=ceil(64H/5)+extra.

For first band index l, the required integer height is floor(5(l-extra-1)/64)+1. If it exceeds the height floor, the exact upper conductor cutoff is ceil(A/(required_height-201))-1. Equality is handled by this strict cutoff. Within a conductor interval (a,b], the exact count with valuation s is

    floor(b/2^s)-floor(b/2^(s+1))
      -floor(a/2^s)+floor(a/2^(s+1)).

The resulting conductor-band counts are:

|Extra nodes|Band1|Band2|Band3|Bands4 and5|
|---:|---:|---:|---:|---:|
|0|125220|91246|9696|0|
|167|125220|96464|10051|0|
|320|125220|100938|10546|0|
|640|125220|115221|11922|0|

These are eligibility counts, not selected replacements, height-weighted workloads, primitive labels, useful unit buckets or saved operations. The even height floor explains the larger band2 population in the+640 scenario. All scenarios remain planning alternatives. The narrower product-only phi(c)>10B_c screen and a complete priced choice are not evaluated here. A cell without unit outputs does not create a saving merely because its state has a short encoding.

## 7. Ordinary-rule interface and decision rule

A concrete certificate must bind the conductor decomposition, F, tie-down anchor, q and reduced q', v', F', the source centers and common grid, coefficient prescales, chosen order normalization, exact state/update equalities, all numerator advances and unit exports, and the final signed round. The normalized initialization constructs integral states directly, so there is no repeated runtime division by j! or2^lambda_j. Ordinary proofs of those invariants and all concrete arithmetic are still required. A native array, shift instruction, digest or small final residual is not the proof.

Use separate objectives for generation, proof construction and ordinary checking. Let I_two and I_fac price the complete two initializers at their actual widths, and T_two,i and T_fac,i price each actual advance, including shifted operands and signed copies. The full-factorial route beats the power-only route precisely when

    I_two-I_fac > sum_i(T_fac,i-T_two,i)+other_fac-other_two,

with shared setup cancelled only when identical proofs/data are reused. For either route versus Horner, compare its complete reduced initialization, advances, output rounds and bindings with all19 reduced rounded Horner stages at each unit. No inequality between these costs follows from a product or bit count alone. Width-sensitive prices can now use the explicit per-order formulas instead of the older maximum-size state.

The concrete improvement is exact smaller numerator/state representations with no new analytic error and a complete alternative recurrence. It does not establish a runtime winner or global savings. Generation may still prefer a different basis or direct bignum arithmetic from the ordinary proof circuit. Proof size, operand sharing, cache lifetime and transport remain separate costs.

## 8. Frozen exact evidence

Owned `residue_power_two_normalization_20261111.py`, SHA256 `4AFA4EC5A7FEE7751EFAA491C57604DA7B21C07CF0A8D3D120FD118D990B01D8`, and JSON `residue_power_two_normalization_final_20261111.json`, SHA256 `0AE9F335B08532673C20230B71B2D9868A770A641782302B202DC7104E48D682`, pass9568 exact checks. Every coefficient, q' and v' is a formal indeterminate in the Newton checks. All partial degrees and orders for delta0 through14 agree with both scaled recurrences. The script also checks raw width factors, shift exponents, small valuation fixtures, exact floor class counts and height endpoints, and the limited addition crossover. It imports no author program and evaluates no actual polynomial or analytic function.

The preliminary receipt `residue_power_two_normalization_20261111.json`, SHA256 `33BBAA6CE73D91751B4CE7C27CC090094002810AFF9FB9ECF1137ECEB6319F81`, is preserved but withdrawn: my draft transcribed the even slope incorrectly. The accepted occupancy note and its counts were already correct. The separately pinned clarification below corrects my mistaken attribution; it is not an erratum to that source. The final receipt replaces only this new draft's metadata and also binds the direct combined-height source. No state identity or width proof changed.

The eight checked input pins, relative to `work/qrh-campaign/agents`, are:

|File|SHA256|
|---|---|
|major-constants/COMBINED_ODD_EVEN_HEIGHT_CONDITIONAL_COST_2026-11-11.md|6143FA8444ED97084998D769E114DCAB3DC2C12DCAF9649C32CFA1989658487C|
|independent-feasibility/CLARIFICATION_OCCUPANCY_EVEN_HEIGHT_SCALE_2026-11-11.md|33B70DABD780D347D183196D7A40D8D0958B264C6D1165EAF515DE366CE24384|
|major-constants/RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md|AFA91F89C51BFC62FAB135997C6ED9FC7FCEAE3FBF6062F973F65AE69ADAC054|
|independent-feasibility/REVIEW_RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md|0FC1801726CE19F28E0B512C3B24FA8D88B1531E3360E8566A1A799A8F955711|
|prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md|55576F70A22E3B94108C80CE6255D312437085E08281EFC6FBA34E65147E22BC|
|moebius/REVIEW_NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md|995BADD0DDBA1F915A768DC34AAEE70BD9E356EE73A665594A6871ECAC83E234|
|prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md|99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1|
|zero-sum/FINAL_ROUND_DENOMINATOR_DIGIT_REUSE_2026-11-11.md|E5622749AB1A5A9D91743586B17DCE8C3E10C87237E2F48168CD47D7064385BF|

The representation adapter and fixed-Q table's own review/status gates remain explicit inputs when those optional routes are selected. This report changes no chosen spectral input, source error, frozen circuit, family inventory or cost ledger.
