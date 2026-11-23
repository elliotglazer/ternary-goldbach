# Rounded initial differences with exact dyadic traversal

2026-11-11. New conditional circuit and exact scalar metadata. No actual coefficients, polynomial values, transforms, primes or analytic functions were evaluated. No builds, source edits or changes to frozen predecessors were made. This candidate needs independent review and a priced implementation before schedule adoption.

The circuit computes the twenty exact initial forward differences of the same b100 polynomial as the accepted optional grid adapter, then rounds each difference once to a finer common dyadic grid. It traverses the whole numerator bucket by exact additions on that grid. Each unit output needs only a dyadic final conversion. The wide divisions are paid twenty times per bucket rather than at every unit output. Their operands can be wider than the old final-division operands; that cost is retained below.

## 1. Exact object and scope

Let P_100(h)=sum_{j=0}^{19}z'_j h^j, z'_j=n_j/2^100, be the explicitly source-bound, optionally requantized coefficient polynomial. The coefficient adapter proves |z'_j-z_j|<u, u=2^-100, for the ORIGINAL delivered centers z_j, and its quantitative source margins give |z'_j|<C=2^16. Direct original-center conversion and its actual cache identity remain required. There is no claim that the original arrays were already on this grid.

Use F=2D_out with D_out in {512,1024,2048,4096,8192}; final sourceD4096 still delivers D_out8192. Fix a nonempty ties-down anchor bucket with first numerator a0, length L and anchor k. Write

    v=2c, q0=F*a0-k*c,
    f(t)=P_100((q0+Ft)/v),  t an integer.

The physical numerators are a0,...,a0+L-1, all in the same bucket, with |(q0+Ft)/v|<=1/4 there. They include nonunits. Consume either the old guard c>20F or the separately reviewed extension c>10F. The source family has c<=265800 and F>=1024, so L<=ceil(c/F)<=260. No unit distribution assumption is used. The result below applies to every nonempty bucket with L<=260, including one-point endpoint buckets.

Let d_j=Delta^j f(0), 0<=j<=19. These are forward differences, not normalized derivatives. The accepted Newton initializer gives exact integer numerators I_j with

    d_j=I_j/(2^100 v^19).

Its partial-degree/raw-product bounds and counts remain in force. Alternatively another exact normalized initializer may be used only with its own identity, width and cost proof. This note does not replace exact initialization by numerical sampling of f or of the analytic function.

## 2. One-time rounding and exact state invariant

Define the integer

    S(L)=sum_{k=0}^{min(19,L-1)} binom(L-1,k),
    p=102+bitlength(S(L)).                             (1)

S(L)>=1, so p>=103 and S(L)<2^(p-102). For each j round both coordinates of d_j to grid2^-p using nearest rounding with ties up. Write the result d'_j=d_j+e_j. The coordinate errors are at most2^(-p-1); hence |e_j|<2^-p in complex norm. This is twenty complex rounds, not one round of the whole state vector.

Store M_j=2^p d'_j as signed complex integer pairs. At each numerator advance update M_j<-M_j+M_(j+1) for j=0,...,18 in ASCENDING order; M_19 stays fixed. This order reads the old upper entry. No rounding occurs during traversal. The invariant after n advances is

    2^-p M_j(n)=sum_{k=0}^{19-j}binom(n,k)d'_(j+k),
    Delta^j f(n)=sum_{k=0}^{19-j}binom(n,k)d_(j+k).     (2)

The first identity follows by induction using Pascal's identity, including n=0 and vanishing binomial coefficients for k>n. The second is the Newton finite-polynomial identity, or the same recurrence with exact initial states. Therefore

    E_j(n)=2^-p M_j(n)-Delta^j f(n)
          =sum_{k=0}^{19-j}binom(n,k)e_(j+k).           (3)

For all 0<=n<=L-1 and every live order j, nonnegative binomial coefficients and their monotonicity in n give

    |E_j(n)| <2^-p sum_{k=0}^{min(n,19-j)}binom(n,k)
             <=2^-p S(L)<2^-102=u/4.                 (4)

Thus the error control holds for every state used by the circuit, not merely its exported order-zero value. The errors need not be independent or have different signs. A fixed guard length L_max may replace L in (1) if L<=L_max is proved, but it can increase widths and must be priced accordingly.

At a required unit numerator, round 2^-p M_0(n) to grid100 with complex error less than u. Do not feed that rounded output back into the state. With P denoting the original delivered-center polynomial, the actual in-cell error is

    |output-P(h)|
      < (4/3)u + (1/4)u + u = (31/12)u < (8/3)u.      (5)

The terms are respectively coefficient conversion, initial-state error propagated by exact additions, and final conversion. All inherited source/EM, numerical-coefficient, analytic-shift and target-Taylor terms remain separate. With the existing absolute character/conductor amplification633, this circuit contributes less than(6541/4)u=1635.25u, leaving211u/4 under the old1688u cap. Arbitrary mixtures with other accepted evaluators may retain the old1688u allowance; they cannot silently claim the stronger all-circuit value. Different evaluators need not return identical centers or signs.

## 3. Live-state and raw-addition widths

At a physical point n and any support offset ell<=19, keep the original anchor and polynomial. Under c>10F,

    |(q0+F(n+ell))/v|<1/4+19/20=6/5.

Under c>20F it is below3/4. These extra points are finite-polynomial support only, including when they leave the bucket. No analytic accuracy is asserted there.

The exact rational geometric sums give

    G10=sum_{i=0}^{19}(6/5)^i<192,
    G20=sum_{i=0}^{19}(3/4)^i<4-1/512.

The alternating-binomial formula yields |Delta^j f(n)|<2^j C G_guard. Together with (4), the quantitative gaps imply

    c>10F: |2^-p M_j(n)|<2^43 for every j;
    c>20F: |2^-p M_j(n)|<2^37 for every j.             (6)

For example the first exact bound is at most192*2^16*2^19=(3/4)2^43, leaving much more than u/4. The old-guard geometric gap likewise exceeds one even at the largest order. A mere strict bound2^43 without such a gap would not justify retaining it after adding rounding error.

Thus signed stored-state capacities, including a sign bit, are p+44 for the ten-guard tier and p+38 for the old tier. Before invoking the next-state invariant, a raw sum of two states fits p+45 or p+39 respectively. At an intermediate ascending update, each modified lower state already equals its next-n value while the upper entries retain their current-n values; both belong to the same proven physical range. No advance past n=L-1 is needed. Capacity applies to the actual signed integer operands and sums, not only a reduced rational encoding.

The maximum p is197 at L260, with

    S(260)=32305056352236018054956299912,
    bitlength(S(260))=95.

Consequently the largest ten-guard live/add capacities are241/242 signed bits, and the old-guard ones235/236. Both replace the roughly500-bit traversal states only AFTER the exact initialization and its conversion have completed.

## 4. Initialization conversion is still wide

Let Q0=v^19. To round d_j=I_j/(2^100 Q0) to grid p, use the exact rational

    X_j/Q0,  X_j=I_j*2^(p-100).

For a supplied integer M_j(0), set R_j=X_j-M_j(0)Q0 and check

    -Q0<=2R_j<Q0.                                    (7)

This is precisely nearest rounding with ties up, including negative values. The shift, signed product, subtraction, denominator power identity, inequalities and source-object binding require ordinary proofs. There are forty coordinate witnesses for the twenty complex rounds. They cannot be charged at the old per-unit final-round width.

Since Q0<2^362, sufficient raw capacities are:

|Object|c>20F signed bits|c>10F signed bits|
|---|---:|---:|
|Old exact I_j and Newton raw temporaries on b100|500|506|
|Shifted X_j or product M_j(0)Q0|p+400|p+406|
|Raw difference R_j before acceptance|p+401|p+407|
|Doubled raw difference for comparison|p+402|p+408|

The input scaling follows from |I_j|<2^37*2^100 Q0 or2^43*2^100 Q0. The product uses the rounded-state bound in (6); the raw subtraction then adds one bit and doubling another. At p197 the ten-guard comparison can reach605 signed bits. Final accepted R_j is small, but that fact is not used before proving (7). Denominator reduction or a more economical quotient witness may improve these widths only through a separate proved schedule.

At unit outputs the divisor is instead the POWER OF TWO 2^(p-100). One can prove the final grid100 round by signed Euclidean splitting M_0=q*2^(p-100)+r, 0<=r<2^(p-100), and increment q when2r>=2^(p-100). The product by that divisor is an exact shift. This removes the arbitrary v^19 witness product per unit; it does not make sign handling, quotient/remainder interpretation, bit extraction, tie comparison, output binding or storage free. A conservative p+46 signed scratch capacity suffices for this construction in the ten-guard tier, p+40 in the old tier. The sharper in-cell value bound can reduce the final quotient width, but no such reduction is needed or priced here.

## 5. Exact cost interface

For a bucket of length L with U required unit outputs, retain the exact Newton initialization unchanged:190 general products,357 additions,357 shifted operands,19 coefficient prescales, plus geometry and source binding. This is still a wide-integer initialization. The new circuit then adds20 complex wide rational-to-dyadic conversions with the widths in section4. It makes19(L-1) exact narrow complex additions and U final dyadic conversions. No per-advance round is present.

Against the same-polynomial exact full-state FD circuit, write C_W for its per-unit arbitrary-denominator final conversion, C_D(p) for the new final dyadic conversion, C_I(p,c) for one initial wide conversion, and C_A^wide,C_A^p for the two traversal-add costs. A sufficient positive replacement reserve is

    U*(C_W-C_D(p))
      +19(L-1)*(C_A^wide-C_A^p)
      -20*C_I(p,c)-Delta_setup >0.                    (8)

All quantities refer to a chosen generation/proof/checking objective and actual operand representations. Delta_setup includes precision selection and binomial-bound proof, any additional cache or format conversion, temporary coexistence of wide and narrow states, data movement and output binding differences. Common exact initialization and coefficient conversion cancel only when they truly use the same polynomial, source array and cache lifetime. A different normalized initializer needs its own complete charge.

Equation (8) makes no assumption that wide conversion is one opcode or that all additions have equal prices. Buckets with few units or short length can lose: twenty initialization conversions must still be paid. The schedule initializes all twenty orders even when L<20 and initializes nonempty zero-unit buckets unless a separately proved pruning rule avoids them. Nonunit advances remain. The previous price-frontier receipt does not automatically count or adopt this new alternative.

|L|p|Ten-guard live/add signed bits|Maximum initialization comparison signed bits|
|---:|---:|---:|---:|
|1|103|147/148|511|
|10|112|156/157|520|
|20|122|166/167|530|
|40|141|185/186|549|
|80|163|207/208|571|
|130|177|221/222|585|
|260|197|241/242|605|

These are parameter examples, not claims about counts of such buckets or produced coefficient data. A height/bucket/source/guard/p key must identify each rounded state. Later reconstruction or eviction is not free. Reusing it at a different height, polynomial, conductor or anchor is invalid without the exact required identity.

## 6. Evidence and remaining work

The general proof is (2)--(7). The companion checker independently propagates the all-one initial error weights by ascending additions for every L1..260 and verifies the binomial formula for every live order. It also checks the geometric slack, every precision/error inequality, width formulas, source pins and selected examples. It performed10937 exact assertions, with no coefficient, polynomial or spectral evaluations. It does not implement an ordinary-rule conversion or certify actual output signs.

The remaining adoption obligations are concrete source-bound b100 arrays, all exact initialization and conversion witnesses, exhaustive unit-output coverage, ordinary-rule arithmetic/library implementation, and the priced comparison (8). Neither polynomial-only support nor the uniform error bound supplies actual spectral/completeness data.

Pins relative to work/qrh-campaign/agents:

|Artifact|SHA-256|
|---|---|
|prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md|55576F70A22E3B94108C80CE6255D312437085E08281EFC6FBA34E65147E22BC|
|moebius/REVIEW_NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md|995BADD0DDBA1F915A768DC34AAEE70BD9E356EE73A665594A6871ECAC83E234|
|major-constants/RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md|AFA91F89C51BFC62FAB135997C6ED9FC7FCEAE3FBF6062F973F65AE69ADAC054|
|independent-feasibility/REVIEW_RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md|0FC1801726CE19F28E0B512C3B24FA8D88B1531E3360E8566A1A799A8F955711|
|integration/RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md|9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4|
|integration/CLARIFICATION_RESIDUE_GRID_MIXED_EVALUATORS_2026-11-11.md|B620E1C26D8F4D1B9F0434CEBB7C121127EA2AD34F6807969CA21A724F468815|
|audit/REVIEW_RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md|793AD4410778F45B39040F246B361E8877876ABA11083A2C9492288B2492B16D|
|major-constants/rounded_initial_differences_20261111.py|78481504C24A2DD6C19854D12EC04BEB52E86B5A4158CFD0A03A06FD6175D159|
|major-constants/rounded_initial_differences_20261111.json|51A09104F2F5C29FA84B5E39312984E4E0433764ED933A3F7BDA064830FDD6A2|
