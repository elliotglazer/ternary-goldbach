# Finite Stirling bounds for all difference states

2026-11-11. Pure finite-polynomial algebra with exact rational certificates. No polynomial coefficient array, polynomial sample, analytic function, transform, prime or spectral value was evaluated. No integrals, derivatives or builds are used. This is a separate successor bound; all frozen circuit/error reports remain unchanged.

**Result.** If deg P<=19, every complex coefficient has norm at most C>=0, |h|<=1/4 and |s|<=1/20, then every order0..19 satisfies

    norm(Delta_s^j P(h)) <= C*B_j <=4C/3,

with twenty explicit rational B_j<4/3. The last inequality is strict when C>0; at C=0 the polynomial and all differences are zero. The same envelopes control normalized partial Newton polynomials. Separate positive bounds control every raw Newton product and insertion sum, and every raw traversal addition. None relies on cancellation to narrow a temporary.

Under the existing rounded-initial-difference circuit's error contract, these inequalities reduce the maximum stored and raw-add signed capacity to215 bits at p197. Initial conversion comparisons have a sufficient579-bit maximum instead of605. This changes sufficient width inputs, not the circuit, error budget, operation count or selected occupancy. Independent review and complete pricing are still required.

## 1. The exact finite identity

For real h,s and P(x)=sum_(k=0)^19 a_k x^k with a_k in C, define Delta_s P(x)=P(x+s)-P(x). Zero-pad a lower-degree polynomial. Let S(m,j) be the nonnegative integer Stirling numbers specified by

    S(0,0)=1; S(m,0)=0 for m>0;
    S(m,j)=j*S(m-1,j)+S(m-1,j-1),

with out-of-range entries zero. The falling-factorial identity x^m=sum_j S(m,j)(x)_j follows by induction using x(x)_j=(x)_(j+1)+j(x)_j. Pascal's identity gives Delta_1(x)_j=j(x)_(j-1). Evaluating the jth difference at zero therefore gives

    Delta_1^j x^m at0 = j!*S(m,j).

Expand (h+s*t)^k by the finite binomial theorem and apply that identity coefficientwise. For every k,j,

    Delta_s^j x^k at h
      =sum_(m=j)^k binom(k,m) h^(k-m) s^m j!*S(m,j).       (1)

The empty sum is zero. This also proves all orders above the actual degree vanish. At j=0 the conventions recover h^k, and at s=0 every positive-order difference is zero. There is no division by s, no nonzero-step premise and no appeal to an infinite series or differentiation theorem.

Apply the triangle inequality, norm(a_k)<=C, |h|<=1/4 and |s|<=1/20 to(1). Since the remaining coefficients are nonnegative,

    B_j=sum_(k=j)^19 sum_(m=j)^k
          binom(k,m) 4^(-(k-m)) 20^(-m) j!*S(m,j),
    norm(Delta_s^j P(h))<=C*B_j.                           (2)

This is uniform on the CLOSED base and step ranges, with either sign of s. Actual application uses positive s=F/(2c). Supporting points h+l*s may lie outside the base interval; they are evaluations of the finite polynomial only. Equation(1) bounds the difference directly and does not assert analytic approximation at those supporting points.

## 2. Twenty exact upper certificates

Put D=20^19=5242880000000000000000000. Every B_j=E_j/D, where the integer expression

    E_j=sum_(k=j)^19 sum_(m=j)^k
          binom(k,m) 5^(k-m) 20^(19-k) j!*S(m,j)            (3)

has no rational divisions. The following E_j are retained exactly; all twenty satisfy3E_j<4D.

|j|E_j|
|---:|---:|
|0|6990506666660308837890625|
|1|499321904507108416390591|
|2|76818748956838460281116|
|3|19204610204391814857006|
|4|6982766419435924802400|
|5|3486387094666704763200|
|6|2298343442095855126080|
|7|1906338780625973092560|
|8|1841449792023265737600|
|9|1880494446010017398400|
|10|1858768528318196544000|
|11|1665964476457581484800|
|12|1294001144962251264000|
|13|842200158080945664000|
|14|445863083304038400000|
|15|185894774828066304000|
|16|58518971960537088000|
|17|13041990925996032000|
|18|1831078879838208000|
|19|121645100408832000|

For example the smallest cross-product margin occurs at j0 and is4D-3E0=19073486328125>0. The receipt retains every positive margin and an independent rational-summation equality for(3). For degree i<19, dropping the nonnegative terms k>i only decreases each envelope. All210 pairs0<=j<=i<=19 are also checked explicitly as metadata. The general proof is that nonnegative truncation, not a reliance on210 sampled polynomials.

An ordinary arithmetic certificate can prove the finite S/binomial recurrences, the twenty expressions(3), and the positive integer comparisons. The Python calculation proposes those exact integers; it is not a new accepted arithmetic oracle or a Lean/MM0 proof implementation.

## 3. Partial Newton states and their raw products

Bind the existing Newton initializer for degree19, common coefficient grid2^-b, v=2c and F=2Dout. Its integer partial polynomial after stage i is

    J_i(t)=sum_(ell=0)^i n_(19-i+ell)
                     v^(i-ell)(q0+F*t)^ell.

Define P_i(x)=sum_(ell=0)^i z'_(19-i+ell)x^ell with z'_k=n_k/2^b. Then

    J_i(t)/(2^b*v^i)=P_i(h+s*t),
    h=q0/v, s=F/v.

Every P_i has degree<=19 and the SAME coefficient bound C. Thus the exact partial difference state D_j^(i)=Delta_1^j J_i(0) satisfies

    norm(D_j^(i))/(2^b*v^i) <= C*B_j.                     (4)

The conductor guard c>10F implies s<1/20, and nearest-anchor geometry gives |h|<=1/4. The old c>20F guard is included. Ties-down remains bound to the actual coefficient cache and residue manifest; no anchor re-selection is permitted in this algebraic normalization.

For an interior Newton update, normalize its two raw products by the NEW stage factor2^b*v^i. Before addition their norms are bounded separately by

    general:   C*(1/4+j/20)*B_j,
    secondary: C*(j/20)*B_(j-1).                         (5)

This follows from the old partial normalization2^b*v^(i-1) and the exact factors q0+jF and jF. The new top uses only the secondary bound with j=i. The j0 insertion has raw-product bound C*B0/4 and added-coefficient bound C, hence raw-sum bound C*(1+B0/4).

The exact integer certificates establish

    ((5+j)E_j+jE_(j-1))/(20D) <4/3,  j1..19,
    jE_(j-1)/(20D) <4/3,
    1+E0/(4D) <4/3.                                    (6)

The j19 general term is unnecessary for degree19 initialization but is harmless in this stronger table. All numerators in(5) are nonnegative, so(6) bounds EACH raw product and the sum of their absolute norms; it does not infer a narrow raw sum from cancellation in a small final state. Binary shift/add expansion of jF also stays within its secondary bound because those terms share the scalar sign for each coordinate. Coefficient prescales fit C*2^b*v^i directly.

Consequently exact partial states, products, insertion sums and small-scale partial sums all fit the4C/3 normalized envelope. Counts remain the existing190 general products,190 small scales,190 recurrence additions, or the expanded357 additions/357 shifted operands, plus19 coefficient prescales and their binding costs. No operation is removed by the magnitude lemma.

## 4. Every live traversal state and its raw addition

At a physical numerator n in the fixed anchor bucket, its base h_n=(q0+Fn)/v remains in the admitted nearest-anchor interval. Thus(2) applies to every live order Delta_s^j P(h_n), including full-state orders whose supporting points extend past the bucket. Full-state traversal uses only physical bases; no advance past the last physical numerator is needed.

The raw ascending update combines orders j and j+1 at the same current base. The exact further certificates are

    B_j+B_(j+1) <3/2,  j0..18.                           (7)

The maximum among the nineteen saved values occurs at j0 and equals14285714285216173657/10000000000000000000, strictly below3/2. Again the proof uses the sum of absolute envelopes, not cancellation or a later accepted output bound. After the addition the ordinary finite-difference invariant supplies the next state; initialization remains descending and traversal ascending.

## 5. Separate join to rounded initial differences

The frozen ROUNDED_INITIAL_DIFFERENCES_EXACT_TRAVERSAL packet uses b100 coefficient centers with C=2^16. It rounds each exact initial difference once to grid2^-p, where

    p=102+bitlength(sum_(k=0)^min(19,L-1) binom(L-1,k)),
    1<=L<=260,  103<=p<=197.

Its separately proved binomial-error propagation gives EVERY live order error strictly below2^-102; there are no rounds during the subsequent ascending additions. The new true-state estimate and its explicit slack give

    norm(rounded live state) <(4/3)2^16+2^-102 <2^17,
    norm(raw rounded update) <(3/2)2^16+2*2^-102 <2^17.    (8)

The second line uses(7) plus both current errors before adding; it is not a claim that two arbitrary states below2^17 can be added without a guard bit. In-place order ensures the two operands in each actual update are the old order-j and old order-(j+1) states at the same physical base. The remaining lower entries may already have been updated, but they are not these operands.

Both stored and raw-add mantissas therefore fit p+18 signed bits, including sign. The maximum is215 bits at p197, replacing the frozen ten-guard241/242 capacities for this separately proved successor. The error formula31u/12, final dyadic conversion and all actual-function/source terms remain unchanged. No sharper numerical error has been inferred from a smaller magnitude.

Initialization still starts with exact integer differences I_j/(2^100 Q0), Q0=v^19<2^362. Equations(4)–(6) imply |I_j| and all actual normalized Newton temporaries are below(4C/3)2^100 Q0<2^117 Q0. This gives480 signed bits for the exact b100 initialization, compared with the previous conservative506 ten-guard bound.

For the initial rounding witness X_j=I_j2^(p-100), the rounded initial mantissa M_j also has magnitude below2^(p+17), by the quantified slack in(8). Hence sufficient capacities are:

|Object|New signed capacity|Maximum p197|
|---|---:|---:|
|Exact b100 initialization integer and raw Newton temporary|480|480|
|Shifted X_j or M_j*Q0|p+380|577|
|Raw signed residual X_j-M_j*Q0|p+381|578|
|Doubled residual before range acceptance|p+382|579|
|Rounded stored state and actual raw traversal addition|p+18|215|

The two product operands in the residual are each bounded before subtraction; the extra residual/doubling bits do not use its accepted small value. The initial forty coordinate rounding witnesses remain necessary. Their 26-bit capacity improvement relative to the frozen ten-guard table is not the removal of a multiplication or division. Final dyadic output conversion, signs, low-bit extraction, tie handling, complete unit coverage, cache lifetime and ordinary proof costs also remain.

This join changes only proved capacity inputs. The old reports remain valid with their looser bounds, and their count/price receipts have not been silently rewritten. A new full comparison must use the narrower widths consistently and charge the finite envelope proof and its applications.

## 6. Pins and finite evidence

Read and pinned inputs:

- prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md: `55576F70A22E3B94108C80CE6255D312437085E08281EFC6FBA34E65147E22BC`.
- major-constants/RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md: `AFA91F89C51BFC62FAB135997C6ED9FC7FCEAE3FBF6062F973F65AE69ADAC054`.
- major-constants/ROUNDED_INITIAL_DIFFERENCES_EXACT_TRAVERSAL_2026-11-11.md: `FB0B0F9AF9C53150E14C1F5FFDE7A39E78DD8A6BFA09FE7769BF234EBB965E46`.

The new scalar script finite_stirling_difference_envelopes_20261111.py has SHA256 `2BC8FDEE1E1D9BD81210858CA6AA28441C4620A34A74DCAEF32D2E1E1F620403`; its JSON has SHA `6DE1E74B9593BAC00D9849D0B519C10E2C9243D2D2850A209AC89B5C71014E46`. All576 exact checks pass. The receipt retains all20 rational envelopes, their positive cross-product margins, all raw Newton/advance bounds, all210 degree/order truncation inequalities and all260 rounded precision/width rows. No polynomial samples or actual coefficients are used.

The generic finite algebra, source normalization, error join and concrete width consequences require independent review before integration. Formal library proofs and concrete ordinary-rule records remain outstanding. No spectral, sign, runtime or total-proof-cost conclusion follows from the lemma alone.
