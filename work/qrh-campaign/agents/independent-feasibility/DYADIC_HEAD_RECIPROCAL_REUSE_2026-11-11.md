# Shared dyadic reciprocals in the joint seed head

2026-11-11. Paper proof, exact error bounds and operation-size accounting only. No reciprocal table, elementary or spectral values, prime computations, builds or new Lean declarations were produced. Frozen predecessors are unchanged.

A certified downward reciprocal with130 fractional bits can replace every exact1/x factor in the selected final-band head while preserving its strict .107eta seed and .557eta output allowances. Its perturbation accumulates over at most27 head-power steps, not over the height prefix. However, this is not automatically an arithmetic saving: x has a denominator4096 and a numerator of at most23 bits. Checking the old exact rounded division can use a short denominator multiplication, whereas the new factor has up to130 bits. A producer-only reciprocal hint with an exact rounding correction preserves that narrower verification option.

## 1. Actual target and repeated operand

Keep V7000, D4096, N1500, m159 and P28. At a=j/D, 0<=j<=D, set z=1+a and s=1/2+it. The finite head in the reviewed continued-Hurwitz EM identity is

    D_k(a)=sum(n=0..1499) B_x*x^(-k),
    x=n+z, B_x=x^(-s), 0<=k<28,
    head_k=R_k*D_k, R_k=(-1)^k(s)_k/(D^k*k!).

All functions, normalization, endpoint corrections and the actual EM remainder stay unchanged. Only the algorithm for the finite head terms changes. It starts with the same low-precision EM copy of the certified B_x state. Fine height states and their complex step recurrence are untouched.

The scaled precision paper already accounts for exact rational1/x multiplication followed by a rounding gate. The fixed-step reuse paper optimizes repeated complex phase-step products and explicitly excludes these head scales. The present proposal concerns that excluded head work, not another claim of phase-step savings.

Write x=A/D. The head union is A=D,...,(N+1)D, with all integer A present. Thus1<=x<=1501, A<=6148096<2^23. There are ND+1=6144001 distinct head arguments. The larger6148097 final argument set includes EM endpoints up to1502; those extra4096 points need no head-reciprocal cache in this proposal. Repeated integer endpoints among the coarse-anchor heads produce1499 duplicate occurrences, which must map to the same exact A.

## 2. Reciprocal certificate and rounding

Set q=130. For each head argument define the integer v and dyadic r by

    v=floor(D*2^q/A), r=v/2^q.

The checker need not perform that division. It can verify

    A*v <= D*2^q < A*(v+1), A>=D>0.                  (1)

One product A*v, an addition of A and ordered comparisons suffice. These inequalities prove0<=r<=1/x<=1 and0<=1/x-r<eps, eps=2^-130. The x=1 entry is exactly r=1 and can be a shared identity. Incorrect floor witnesses fail(1); no empirical reciprocal accuracy is assumed.

From the same initial Bhat_x, compute

    what_0=Bhat_x,
    what_(k+1)=Round_u(r*what_k), u=2^-122.

Round each coordinate to the common u grid so the complete complex rounding error is at most u. Exact additions of these dyadic terms remain exact, with sufficient integer capacity. The product may be formed exactly before this final rounding; a truncated-product implementation would need its own rounding proof.

The certified r is reused unchanged at every required height and head order for that x. Its target depends only on the rational x. There is no claim that an approximate reciprocal receives a new independent random error on each use.

## 3. Complete perturbation bound

Let w_k=B_x*x^(-k). Because |B_x|=x^-1/2<=1 and x>=1, |w_k|<=1. The one-step error satisfies

    |what_(k+1)-w_(k+1)|
      <=r*|what_k-w_k|+|r-1/x|*|w_k|+u
      <=|what_k-w_k|+eps+u.

Starting from |Bhat_x-B_x|<=delta=2^-118 gives

    e_k<=delta+k*(u+eps), 0<=k<=27.                 (2)

The downward choice is useful: r<=1 avoids any product of factors1+eps. Equation(2) is deterministic and remains valid when all reciprocal errors have the same sign. Reusing the table over H heights does not insert an H factor, because each height restarts the head from its own certified B_x copy. Feeding a head term back into the fine height state is not permitted.

The existing rounded R has |Rhat_k|<=5 and error<=8u. Relative to the same exact finite head, replacing the original term recurrence adds at most5N*k*eps to its established error. Therefore the uniform extra source error is bounded by

    E_extra=5*N*P*eps=210000*2^-130
           =(13125/67108864)*eta, eta=2^-100.        (3)

Use the reviewed m159 remainder R_EM=(312/635)*(7009/9006)^318. The full new seed bound is

    E_new=10507*delta+278753*u+R_EM+E_extra
          <.107eta<eta/4.                           (4)

No endpoint or Bernoulli term has been removed from(4). The exact check also gives

    2*E_new+351*2^-110 <.557eta<eta.                 (5)

Thus the original three signed translations, source-to-output normalization, numerical fine-coefficient radius, analytic shift bias and final isolated-alpha bound below.16*2^-82 remain available. The numerical radius still refers to the finite shifted polynomial; the analytic translation bias is not absorbed into it. The same stored-magnitude argument remains valid because2^28*(E_new+350*2^-110)<1.

These bounds are sufficient, not precision minima. The choice q130 leaves room within the already accepted strict allocations; it does not change delta, u or the output contract. Exact centers may change, so new arithmetic witnesses are required.

## 4. Widths and the short-denominator baseline

From(2), every head term has magnitude below2. On the u grid, each signed coordinate integer U has |U|<2^123. The x=1 reciprocal is handled exactly. For all other x, the reciprocal numerator v has at most130 bits; uniformly it has at least120 bits because1501<2048 and the floor does not cross2^119.

An exact nonunit dyadic product U*v fits253 magnitude bits, followed by a130-bit right shift and a proved rounding decision. Sign and tie handling remain necessary. The common head sum has magnitude below3000, so134 magnitude bits suffice on its122-fractional-bit grid. Later R/head, endpoint and translation intermediates retain their own established width requirements.

The reciprocal certificate uses A of at most23 bits and v of at most130 bits. A malformed bounded input may produce a153-bit product before rejection. Valid products satisfy A*v<2^142; the separately handled unity case has equality. Its setup generator divides the143-bit integer2^142 by A. These are exact width bounds, not statements that division or table construction is free.

For comparison, the existing exact operation is

    Round_u((U/2^122)*(D/A)) = V/2^122.

A nearest-coordinate certificate can verify

    2*|A*V-D*U|<=A,                                (6)

with the specified tie rule if an exact deterministic rounded value is required. The resulting complex error is below u. Since1/x<=1 and U is integral, a nearest V obeys |V|<=|U|. Verification can therefore use a23-by123-bit multiplication A*V, a12-bit shift D*U, subtraction and comparisons. It need not prove a generic division of two full-width122-bit numbers or construct an enormous rational denominator. Common factors of A and4096 can reduce the operands further.

As a deliberately limited radix256 schoolbook comparison, the dyadic product uses16-by17 digit pairs, or272 digit multiplications. The core product in(6) uses3-by16, or48. A reciprocal certificate core product uses3-by17, or51. These are only product subcounts, not complete proof-event or runtime counts. They omit carries, signs, bounds, decomposition, rounding, proof application and I/O. Fixed-multiplier tables, rectangular multiplication or certified truncated products can change them. Still, this exposes why replacing a rational operation by a multiplication is not itself evidence of a saving in ordinary-rule MM0.

Lean may compare a kernel-evaluated small-denominator division, a proof-producing form of(6), or the dyadic product/shift checker. Ordinary MM0 can use its own best digit proofs for the same identities. Neither system is credited with free native arrays or an unproved arithmetic oracle.

## 5. Setup, reuse and exact cost test

Ignoring x=1 identically in both methods, there are G=6144000 distinct cached reciprocals. There are

    U_head=27*(1500*4097-1)=165928473

nonunit complex head scales per final height, each with two real coordinate products. For H20839, the real product count is6915566897694. The other three prefixes are retained in the receipt. These counts include all duplicate head occurrences; table sharing removes repeated setup, not the required head values or additions.

A packed130-bit numerator for every nonunit reciprocal uses99840000 raw bytes. This excludes indexes, proofs, headers, alignment and live arithmetic. The remainder need not be stored: the two inequalities in(1) can reuse A*v. A direct indexed array is only one possible representation. A bounded argument tile can generate or load its reciprocals, certify them, and reuse them across its height tile. Rebuilding at every tile repeats setup and must replace G by the actual number of certifications. Global proof reuse requires retained checked statements; a cache hash does not supply them.

Let C_div be the complete per-coordinate price for the best admitted baseline rounding check or computation, and C_dyad the complete new product/round/lookup price. Let C_setup price a certified reciprocal, and Delta include net proof changes, cache/transport, indexing, theorem context and storage costs. With one certification per argument, a sufficient and exact common-price comparison is

    2*H*U_head*(C_div-C_dyad) > G*C_setup+Delta.      (7)

Use separate versions of(7) for native production, ordinary proof construction and ordinary verification. Route-dependent prices require actual sums. Negative left-hand side cannot be rescued by amortizing positive setup. The high reuse count alone does not decide this inequality.

The cache may share the previous band's argument grid, but this report changes only the selected final band. It claims no free earlier reciprocal certificates. It also does not redo the distinct fixed-complex-phase table optimization. Processing consecutive heights for one head argument affects seed accumulator order, output bindings and memory; those costs remain in Delta.

## 6. A producer-hint alternative that preserves narrow checking

There is a useful hybrid if the native producer benefits from reciprocal multiplication but the verifier prefers(6). Generate a tentative integer V0 by nearest rounding of U*v/2^130. Then correct it, if necessary, using the exact short denominator A.

Indeed |U|<2^123 and eps=2^-130 give

    |U*v/2^130-U*D/A|<1/128.

Consequently |V0-U*D/A|<1/2+1/128<1. A nearest integer to the exact target differs from V0 by at most one. Compute A*V0-D*U, compare it with the half-denominator thresholds, and change V0 by at most1 with the prescribed tie rule. Updating the product by plus or minus A requires no second full multiplication.

The final certificate is just(6) for the corrected V. It need not mention the reciprocal, its certificate or its production method. Thus the accepted numerical operation is exactly the original rounded rational factor and incurs no additional head error. An untrusted bad hint cannot make an incorrect V pass(6); the one-correction guarantee assumes the stated reciprocal accuracy only for producer efficiency.

This hybrid is a distinct implementation option. Its generator pays the approximate product plus an exact correction test and reciprocal setup. That may still exceed a direct short-denominator division. It preserves the option of a smaller ordinary checking proof and avoids forcing a large reciprocal table into the trusted proof state. Compare complete native costs before choosing it.

## 7. Conclusion and evidence

The fully certified dyadic-table replacement is mathematically feasible at q130 with the selected m159 target and unchanged output allowances. No claimed saving follows until(7) is priced. The short-denominator verification identity is a concrete obstacle to assuming a checker improvement. The producer-hint/correction option separates any native benefit from the ordinary-proof choice and should be the first alternative compared if the existing verifier already uses(6).

Owned `dyadic_head_reciprocal_bounds_20261111.py`, SHA256 `BCB29B2F2254051A9F22532C9576CFD59528AD5040D45454020A7AAA2FED568F`, passed75 exact checks of the complete scalar allocations, widths, union/occurrence counts and four prefixes. The receipt `dyadic_head_reciprocal_bounds_20261111.json` has SHA256 `513ABDAC87D274FB518B7E65B156199B832E52187BDE20BEA6824569F09E3D0A`. It contains no computed reciprocal table, head term or elementary value.

The five frozen inputs and their hashes are retained in the receipt: scaled seed precision `251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231`; fixed-step reuse `F578D50723A09A1580D6ACFBA4F6AEB93371AF81B7929121A9F402E0ED5A38D0`; joint mathematical source `AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F`; m159 source `E6F0F3B277828EA451E05F3608478F760C83F02FEE1B70A899FA40434781CBE9`; and its independent review `09DEF5ABB358A807936270B07E61FFEE624EF0F04C3E17AC47A1179D944E2E82`. This is a new paper proposal awaiting independent review, not implemented spectral evidence or a runtime forecast.
