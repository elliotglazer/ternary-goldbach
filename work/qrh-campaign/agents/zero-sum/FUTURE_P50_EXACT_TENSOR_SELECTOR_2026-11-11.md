# Future p50 selector with the exact tensor denominator

2026-11-11. Conditional paper candidate, submitted for independent review. This removes the declared p80 floor for a possible future scheme by using the finite range50,...,108 and an exact rational tensor allowance. It changes no current assignment, price pass, source or producer. No precision assignments, conductors, angles, roots, coefficients or values were enumerated. No inventories, builds, declarations or proof emission were used. Pending smaller-magnitude proposals, including692, are not consumed.

## 1. Explicit parameter and source contract

Fix the same admitted nonprincipal conductor c>0, full ordered character-transform plan and actual input/sample labels. Let phi=phi(c). The chosen local implementation supplies nonnegative normalized error coefficients C_i with

    S=sum_i C_i <= S_g=202305920 < 2^28.

Repeated axes count repeatedly. A sharper coefficient may be used only when its independently proved local implementation and cache contracts apply. No new leaf improvement is inferred here. The exact transform stays positive and unnormalized, with full group size phi, even if only primitive outputs are retained.

Use one common rational augmented bound V satisfying

    1<=V<=16384,    max_a |z'_a|+1<=V,

for the actual regridded vector at every candidate precision being compared. This is a supplied proof premise. It is not a new assertion of a small magnitude constant. The old actual raw-input margin below8826 already gives the valid example V=8828 throughout p>=50, since after one regrid the augmented norm is below8827+2^-50<8828. Any smaller V must be separately proved on the same full candidate domain. A bound known only for p>=80 is not silently extended.

Retain original source/grid100 polynomial and head production, exact assembly before one input conversion, all source errors and their actual-function identity. The full source and sample-height domains do not change. The exact conductor factor has magnitude1/sqrt(c) on the critical line; its numerical approximation remains separately charged.

Set T=2^p, u=1/T and require p in50,...,108. Keep the old guards

    T>=D_local_old(c),     T>=2*S_base(c).

The inherited global bounds29961461170177<2^45 and2*424706204<2^30 both lie below2^50. Thus the declared range does not violate those bounds for the already admitted family. They remain acceptance premises, including mixed and baseline local safety and the old semantic peak guard. They do not certify new cache contents or a new family.

## 2. Exact tensor and input allowance

For the actual unnormalized tensor computation, let N_i be the full preceding-axis product and e_i the intrinsic error after division by N_i in the proof. Exact normalized partial transforms are contractions. The local theorem gives

    e_(i+1)<=e_i+C_(i+1)*u*(V+e_i).

Consequently the normalized intrinsic error is at most

    V*(product_i(1+C_i*u)-1) <= V*S*u/(1-S*u).

The second inequality is the reviewed finite-product proof for nonnegative terms. Here S*u<=S_g/2^50<2^-22<1, so its denominator is strictly positive. There is no division by S and the S=0 case is included.

For p<100 the single input converter contributes complex error at most u per assembled residue input. For p>=100 exact embedding contributes zero. Write rho=1[p<100]. The exact character operator transports this input error once, separately from intrinsic error. Restoring phi and the exact conductor magnitude gives the sufficient combined allowance

    E(c,p;V) = phi/sqrt(c)*u*(rho+V*S/(1-S*u))
             = phi/sqrt(c)*(rho/T+V*S/(T-S)).          (1)

The regrid term is not multiplied by S or V. It is not added again as a separate J increment if (1) is used. The already conductor-scaled alpha budget is unchanged and charged once. A global B72 from the p100 proof would be unjustified here. Formula(1) keeps the exact denominator instead.

For S=0, the intrinsic transform contribution is exactly zero. The input regrid contribution can still be positive below100. Above or at100 both terms vanish. No special division or exceptional selector formula is needed.

## 3. Rational selector, monotonicity and fallback

Keep the OLD intrinsic target

    C_g=1266*S_g*16384=4196258524692480,
    E108=C_g*2^-108.

If V=a/b with positive integers a,b, put

    W = rho*b*(T-S)+a*S*T.

Then (1) is at most E108 exactly when

    phi^2 * W^2 * 2^(2*(108-p))
       <= c*C_g^2*b^2*(T-S)^2.                       (2)

To derive this, put rho/T+(a/b)*S/(T-S) over its positive common denominator b*T*(T-S), cancel T from2^108, and multiply by sqrt(c). Both sides are nonnegative, so squaring is reversible. T-S>0 and c>0 are essential premises. Integer V is the special case b=1. This is a rational/integer test with no square-root evaluation and no division by S.

For fixed c, S and a common proved V, the function rho/T is nonincreasing as p increases, including its drop to zero at100. The second term V*S/(T-S) is nonincreasing for T>S. Hence E is nonincreasing. The old guards are also upward closed. This proves monotonicity of the sufficient scalar acceptance predicate, not of actual signs, cache availability or numerical center values. Changing V or the local implementation across p would require its own comparison.

At p108, rho=0 and S/T<1/2, so

    E(c,108;V) <= 2*(phi/sqrt(c))*S*V*2^-108
                <=1266*S_g*16384*2^-108=E108,

using the inherited phi/sqrt(c)<=633 and V<=16384. Thus p108 remains a fallback whenever all the same source, representation and cache contracts hold. Failure at a lower candidate precision proves only failure of this sufficient selector.

The declared range has59 precision labels. A future symbolic eligibility mask can use bit p-50, positions0 through58, with five unused high bits if stored in64 bits. This is only an encoding specification. Ordinary range/bit semantics and a checked binding to (2) are still required. No mask, least precision, frequency or assignment is computed here.

## 4. Grid100 input converter through d50

For50<=p<100 let d=100-p in1,...,50. For a source coordinate n*2^-100, use the same witness

    n+2^(d-1)=Q*2^d+t,      0<=t<2^d.                 (3)

It proves -2^d<=2(n-Q*2^d)<2^d, hence nearest rounding with ties toward positive infinity, including negative inputs and zero. Each coordinate error is at most u/2; its two-coordinate Euclidean norm is at most sqrt(2)*u/2<u. No coordinate/full-complex confusion is introduced.

The independent source and output ranges remain |n|<2^114 and |Q|<2^(p+14). The actual raw-input margin proves completeness of that candidate-output range: |Q|<8826*2^p+1/2<2^(p+14). It must still be checked for the supplied witness before using it in raw arithmetic. Since p+d=100, |Q*2^d|<2^114. For every d<=50, both raw sides of (3) have absolute value below2^115. Thus the previous capacities remain

    source115 signed bits,
    destination p+15 signed bits,
    each raw witness addition116 signed bits.

The chosen schedule still uses two signed witness additions per coordinate, hence four per complex input. Their unsigned byte-adder core remains4*A(115)=124 under the existing15-byte template. This is not a complete command or checker price. The unsigned remainder now needs up to50 bits, or seven bytes with a two-bit partial high byte at d50. Its exact range proof, shift/fold, signed wrappers, equality, source transport, storage and producer splitting remain charged and can have different costs than at d20. A byte allocation alone does not prove the partial-byte bound. The ordinary signed split handles the extended bounded gap; it is not a native division oracle.

A direct residual variant still needs116 signed raw bits before acceptance and117 if it explicitly doubles the unrestricted raw residual. Accepted small residuals cannot justify earlier narrowing. Exact shifts are not generic multiplication witnesses, but their bindings are not free.

At p100 use the identity; at100<p<=108 use exact left shift by p-100. These have rho=0 and their own shift/copy/grid proof costs. Do not instantiate (3) with d0 and a negative half-power. A canonical odd-mantissa export requires exact normalization of the current grid pair with the corresponding exponent update.

## 5. H110 unit-root projection through gap60

The accepted unit-root theorem assumes an exact specified unit rho and high center (A+iB)*2^-110 with complex-norm error at most2^-110. For p50..108, k=110-p lies in2,...,60. Direct coordinate-nearest projection therefore has total error

    <(2^-k+3/4)*2^-p <= 2^-p,

and projected norm below1+2^-p. The high proof must certify the complex norm, not two unconverted coordinate radii. Direct projection from the high object remains mandatory for this recipe; successive projections or commuting projection with conjugation/negation at ties are not assumed.

The high coordinates satisfy |A|<=2^110+1. The projected integer M satisfies |M|<=2^p, so its capacity is p+1 magnitude/p+2 signed bits. For d_root=2^k, a residual certificate uses R=A-M*d_root and -d_root<=2R<d_root. High and generic raw capacities remain112 signed for A,113 for R and114 for an explicitly doubled raw R. In the floor route,

    |q*d_root|+r <= 2^110+2^(k+1)-1 < 2^111

still holds at k60. Its unsigned remainder needs at most60 bits and its double61; both fit eight bytes. AFTER acceptance the signed R capacity is at most61 bits and signed2R at most62. Those accepted bounds cannot replace the generic raw capacities. The14-byte high magnitude and15-byte raw proof templates therefore remain sufficient, with the longer split/remainder work explicitly paid.

Exact low coefficient sums retain p+2 magnitude/p+3 signed capacities and must be formed from the actual chosen LOW centers. Original exact DFT/CT/chirp signs and identities remain bound. Gauss root numbers, canonical Hardy/Gamma/completion phases and nonunit transformed kernels are not admitted by this unit lemma. The exact p=H reuse branch remains separate and is outside the selected range. Actual identity counts, precision demand and lifetimes are unknown; if such a demand set is later supplied, its pair count J only has the symbolic bound |I|<=J<=59|I|.

## 6. Hidden-floor and downstream checks

The inspected local radix, direct, CT, original/normalized Bluestein and augmented-peak proofs are quantified in u and their stated safety inequalities. They do not require the numerals80 or100. Normalized cached coefficients still require the actual construction error, scaling round, exact sums and semantic guard; p-specific objects must be supplied. The input representation restriction at100 is precisely what (3) replaces. The earlier p80 floor was a declared candidate range, not a conclusion of those inequalities.

No other producer tolerance is automatically changed to p. Source/grid100 head production, alpha error, conductor scaling, completion, inverse-character negative samples, interpolation kernels and accumulation retain their own requirements and grids. If (2) passes, replace the old combined transform allowance by E and retain

    rL <= E+2^-82+4*2^-63,
    R <= R_fixed+135*E <= R_fixed+135*E108.

The right-hand radius in units of2^-45 remains exactly

    2804840254168152529/4294967296000000000
       <653052762/10^9<691/1024.

The same bound E<=E108 supports the ordered downstream stored-magnitude arguments. It does not prove actual sign or Turing success. Runtime capacities must be recomputed from the admitted common V and exact local factors with their unchanged pre-acceptance arithmetic additions. No bit-histogram subtraction, unproved smaller-V import or cache relabeling is authorized.

## 7. Fixed evidence and pins

Exclusive script `future_p50_exact_tensor_selector_20261111.py`, SHA256 `6E7B3593AA50756DC3DD70EF17E8D7B92091423D49A0D0EE7147F0186935618F`, passed39 fixed checks. It checks twelve source pins, endpoint capacities, global safety, the formal cleared numerator and the unchanged complete radius. It does not loop over candidate precisions or read any assignment/inventory. Its3841-byte receipt `future_p50_exact_tensor_selector_20261111.json` has SHA256 `4EA4510B7552F07E3B38ACEF9A18B5689ACDE47F1CB6DB702960FE6621C94982`. The quantified arguments above, not finite fixtures, justify the full range.

The complete hashes and relative paths are recorded in that receipt. Principal consumed sources are the mixed precision proof4AD43D7D, normalized context interface412A9676, subgrid source B7E78161/review8431B9FF, exact tensor proof DB2E3B9F/review EC2FD856, shared unit-root proof01C4FE83/review C1D3C4F7, regrid cost interface E2457D3C/review56B27935, signed-exponent clarification84003229 and old complete allocation EEBC987D. Each was checked at its frozen bytes. Pending692 and any newer EM simplification are excluded.

This is a future conditional mathematical interface. New ordinary proofs, p-specific source/cache bindings, actual retained samples and successful sign/count certificates remain necessary. No current pass, assignment, pricing or implementation is changed.
