# Direct Newton initialization for the residue polynomial

2026-11-11. Conditional exact-arithmetic successor to the frozen occupancy reference. This note proves a cheaper counted initialization, including raw temporary bounds. It does not change the selected spectral family, output polynomial, coefficient uncertainty, final rounding, or any frozen artifact. No analytic values, prime candidates, transforms, builds or Lean declarations were produced. Counts below are proposed arithmetic/proof-template operations, not verifier instructions or timing.

For degree19 the initializer has190 general narrow-integer times complex-integer products,190 small-integer scales and190 complex additions. A specified binary implementation of the small scales costs167 further complex additions and357 shifted-operand occurrences. Thus initialization has357 additions instead of the20-evaluation/difference-triangle reference's570, and190 instead of380 general products. Nineteen coefficient prescales remain. Geometry setup, shifts, signed arithmetic, representation and proof binding remain charged. This does not establish an aggregate saving or admit more conductors.

## 1. Exact object and domain

Consume the screened all-bucket alternative in section8 of integration/EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2_2026-11-11.md, SHA256 `691A9B744FCCE7C7A8F0D8F18F08F70A68C758D2FFFF1C5E826F138E1257D025`. Its first sections describe a different, pruned long-block alternative; the present cost substitution targets section8's full-state circuit.

Let G=2Dout be the actual delivered fine-grid denominator, v=2c, d=19, and impose the checked guard c>20G. Use the occupancy's ties-down anchor

    k=floor((2G*a+c-1)/(2c)),
    (2k-1)c < 2G*a <= (2k+1)c.

For a fixed cell and height let a0 be its first physical numerator, q0=G*a0-k*c, and z_j=n_j/2^b its actual stored coefficient centers, where n_j is a signed complex integer pair, b>=0 is an admitted common grid, and |z_j|<=C. The current conservative C is2^16. The actual output polynomial is

    P(h)=sum_(j=0)^d z_j h^j,
    h(a0+t)=(q0+G*t)/v,
    f(t)=sum_(j=0)^d C_j(q0+G*t)^j,
    C_j=n_j*v^(d-j),  Q=2^b*v^d.

Thus f(t)/Q=P(h(a0+t)) exactly. The selected coefficients, cell ID, conductor, height and common grid must be bound to the same source object. Final-band sourceD4096 does not change its delivered Dout8192 or G16384. A polynomial-only setup point need not be an admitted Hurwitz evaluation point.

The frozen occupancy report is LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md, SHA `99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1`; its independent review is moebius/REVIEW_LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md, SHA `C6096D0C677E09F850065EDD2103B0348E28392D482CCEE568136B387768C86E`. Its R,B,A counts describe units, all nonempty numerator buckets, and advances including nonunits. They are not unit-run counts. The old necessary screen phi(c)>20B_c implies c>20G and hence supplies this guard, but that screen is not a cost theorem.

## 2. Binomial-basis Horner identity

Use the rational polynomials binom(t,j), with binom(t,0)=1. Their elementary identities are

    t*binom(t,j)=j*binom(t,j)+(j+1)*binom(t,j+1),
    Delta binom(t,j)=binom(t,j-1)  (j>=1),
    Delta binom(t,0)=0.

The first follows by cancelling j! in the falling-factorial products, or as a polynomial identity after clearing that positive integer. The second is Pascal's identity. Consequently if f(t)=sum_j D_j binom(t,j), then Delta^j f(0)=D_j: after j differences, binom(0,k) is1 only at k=0. No division by j! occurs in the circuit. These are forward differences, not normalized derivatives.

Initialize D0=n_d. At stage i=1,...,d the existing state represents the degree i-1 partial Horner polynomial. First set the new top, then update downward:

    D_i = i*G*D_(i-1)                         [read old top]
    for j=i-1,...,1 descending:
        D_j = (q0+j*G)*D_j + j*G*D_(j-1)
    D_0 = q0*D_0 + C_(d-i).

Descending order preserves each old lower entry until it is read. The new top must be assigned before those updates. The multiplication identity proves that this is multiplication by q0+G*t followed by insertion of C_(d-i). After stage i it represents

    J_i(t)=sum_(ell=0)^i n_(d-i+ell)*v^(i-ell)*(q0+G*t)^ell.

At i=d, J_d=f. Every state is therefore exactly Delta^j J_i(0), and the completed state equals the20-node forward-difference initialization identically for every signed coefficient array. It is not a numerical comparison at sampled coefficients.

After initialization the inherited traversal still updates D_j <- D_j+D_(j+1) in ASCENDING order, j=0,...,18, at every numerator advance. Initialization and traversal have opposite in-place directions. Order19 remains fixed. All nonunit advances and final conversions for consumed units remain required.

## 3. Exact counts, including the small multipliers

At stage i there are i general products: the i-1 interior factors q0+jG and the D0 factor q0. There are i small scales jG: interior j1,...,i-1 plus the new top i. There are i additions: i-1 interior additions plus insertion into D0. Sum i1..19=190. These are complex-coordinate operations: each scale is two signed integer scales, each addition is two signed integer additions.

The19 prescales C_j=n_j*v^(19-j), j<19, are separate wide products by powers of2c. They are not included among the190 narrow-factor products. Powers v^0,...,v^19 can share a proved geometry cache across heights and cells of one conductor; the coefficient prescales depend on the actual coefficient array and cannot share across different heights/conductors. Using that cache still requires binding and access work.

For a fully specified small-scale implementation, form jG*D from the binary set bits of j, shift each D by log2G plus that bit index, and add these signed values. For j1..19 the factor j occurs20-j times. Thus

    small additions = sum_j (20-j)(popcount(j)-1) =167,
    shifted operand occurrences = sum_j (20-j)popcount(j) =357.

No shift is declared free. This count includes copying/using the j=1 shifted value but does not equate such a use with a particular proof opcode. The terms for one small scale all have the same sign in each coordinate; intermediate absolute values are at most the final absolute value, including zero and negative inputs. Alternative addition chains or scale caching require their own schedule.

Setup includes the19 values jG (j1..19), the19 general factors q0+jG (j0..18), and q0 itself. General factors can be formed by18 repeated additions of G after q0 is available; jG can use shifts/small-integer encoding. These geometry factors can be shared across heights for the same actual cell start, but their construction, signed representation, cache binding and retrieval must be priced. Counting only products would omit this work.

For the full-state bucket of length L, initialization plus advances has

    190 general products,
    357 +19(L-1) =19L+338 complex additions,
    357 shifted-operand occurrences,
    19 coefficient prescales and U final conversions.

The frozen reference has380 general products and19L+551 additions/subtractions, with the same prescale/output obligations. The new counts are not substituted into the pruned long-block formula without a separate domain and width audit.

## 4. Partial-polynomial invariant bounds raw temporaries

Final-state equality alone would not bound intermediate initialization products. The partial J_i above supplies the missing invariant.

Since |q0|<=c/2=v/4 and c>20G, for every integer t in[0,19],

    |q0+G*t|/v < 1/4+19/40=29/40<3/4.

The geometric series therefore gives, coordinatewise and also in complex norm,

    |J_i(t)| <4*C*2^b*v^i,
    |Delta^j J_i(0)| <4*C*2^(b+j)*v^i    (0<=j<=i).

The second follows from the alternating binomial expression and sum binom(j,l)=2^j; all supporting l lie in[0,19]. The i=0 bound also holds. This is a bound on finite polynomial arithmetic, not on the analytic approximation at off-cell points.

At the degree i update, an interior j satisfies |q0+jG|<3v/4 and jG<v/2. Applied to the previous degree i-1 state, the two unadded raw products satisfy

    |(q0+jG)D_j| <3*C*2^(b+j)*v^i,
    |jG*D_(j-1)| <C*2^(b+j)*v^i.

Their raw sum fits the stated4C bound. The new top iG*D_(i-1) satisfies the second bound with j=i. At j=0, |q0*D0|<C*2^b*v^i and |C_(d-i)|<=C*2^b*v^i, so even the unnormalized insertion sum fits2C*2^b*v^i. The binary small-scale partial sums obey the same secondary-product bound. Thus no extra log(c) width is needed for initialization temporaries; this conclusion uses degree-dependent normalization, not cancellation after a large product.

At c<=265800, v^19 has at most362 bits. With C=2^16, the maximum initial/live state magnitude is below2^37*Q, and an inherited full-state advance temporary is below2^38*Q. Sufficient signed capacities are b+400 and b+401 bits, respectively: at b122,522 and523. Coefficient prescales fit signed b+379 bits. The general narrow factor has |q0+jG|<3v/4<=398700, at most19 magnitude bits plus sign. These are conservative maximum widths; actual partial degrees can be smaller. The b122 case applies only if the delivered centers admit that exact common grid. No new rounding of coefficients is silently inserted.

## 5. Error, acceptance and cost conditions

The completed differences equal the reference differences exactly. The same output rational f(t)/Q therefore reaches the same final rounding rule and error bound as V2. Inherited analytic target/shift errors and numerical coefficient errors remain unchanged; exact difference arithmetic creates no extra numerical radius. Final coordinate rounding, signed quotient/remainder witnesses and the actual source-to-polynomial binding remain mandatory. There is no assertion that these centers equal the original rounded Horner outputs bit-for-bit.

For the frozen all-bucket counts B and A, a symbolic replacement cost is

    setup +19B*C_prescale +190B*C_general
      +(357B+19A)*C_add +357B*C_shift
      +R*C_final_round + traffic/proof_binding.

Use degree- and width-specific prices if available; this uniform expression is only a coarse schedule. Against the same-width reference initializer, the nominal reduction is190B general products and213B additions, offset by the newly explicit small-scale shift and factor setup costs. Against the OLD rounded Horner consumer, its19R narrow rounded stages have different widths, divisions, errors and proof costs. They must not be priced as these general integer products.

If one artificially prices general initialization scales as old Horner scales, the product-only necessary screen weakens from R>20B to R>10B. This does NOT extend admission: the independent guard c>20G remains, and the new screen alone does not imply it. No new occupancy selection, saved stage total, runtime or proof-byte reduction is claimed. The existing screened subset may be used for a future complete comparison without rerunning occupancy. Ordinary Lean/MM0 must still prove the integer and binomial identities and concrete arithmetic with their standard rules; a native recurrence or a hash does not establish them.

## 6. Bounded evidence

The companion script uses formal indeterminates n_j,q0,G,v, never coefficient values. For every degree0..19 and every partial stage it reconstructs the recurrence coefficients and compares them with the independent closed identity

    Delta^j(q0+G*t)^k at0
      =sum_(h=j)^k binom(k,h)*q0^(k-h)*G^h*j!*S(h,j),

where S are Stirling numbers of the second kind. It also checks exact degree counts, binary small-scale counts and integer widths. All1550 checks pass. This finite check supports the general induction above; it is neither kernel validation nor an analytic function evaluation.

Script: newton_residue_initialization_20261111.py, SHA256 `0252255539BCA950E3E296FE8D62CF89F3665E0D50BCF678999FAACF3D0755D6`.

Receipt: newton_residue_initialization_20261111.json, SHA256 `2DDC7485982B885DD0D122865DC662FE5983F600F7E2E8352EC75F0CC9B754BE`.

The three predecessor pins above are checked by the script. Their existing source/error and scope qualifications are preserved. This separate successor leaves the frozen occupancy reference and V2 circuit untouched.
