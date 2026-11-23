# Intermediate widths for the mixed-radix character circuit

2026-11-11. Paper bounds and integer metadata only. No roots, transforms, prime candidates, L-functions or zeros were evaluated. No build or previous-artifact edit was made.

The accepted precision contract also permits a common conservative peak-width allocation: the mixed circuit requires no extra integer bit over the whole-axis Bluestein baseline. This statement includes the cached nonunit kernel and the inverse FFT before division. It compares the explicit bounds below, not actual values or separately optimized per-stage allocations. Consequently it supplies a width-aware circuit comparison, not a runtime forecast.

## 1. Contract and the augmented magnitude

Use the positive, unnormalized transforms and the exact selected schedule from `zero-sum/MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md`. Use the root, gate, cache and error assumptions of `zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md`, SHA256 `4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4`, independently reviewed at `audit/REVIEW_MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md`, SHA256 `1268986720865E47569FC5E568546194C0A61EDC9AE80CDD78502CDC77385537`.

In particular every approximate unit coefficient has norm error at most u, and every rounded complex addition/product has absolute complex error at most u. An implementation must establish that contract from its coordinate rounding. Fix a common dyadic u satisfying the accepted baseline's dyadically rounded safety constraints and S_old*u<=1/2. The accepted metadata implies the mixed safety constraints and S_mixed<=S_old. Here S is the sum of the axis error coefficients C. All descendants then have C*u<=1/2, and all their local safety conditions hold. For the nontrivial axes in this inventory, S_old>=6, so u<=1/12<1/3. No additional fractional precision condition is introduced.

Let B>=0 bound the exact stored input centers and put V=B+1. If B instead bounds true values with input radius E0, replace it throughout by B+E0. Track an incoming bound |z|+1<=aV with a>=1. The accepted semantic error estimate gives the augmented output bound

    |computed D_n(z)|+1 <= n*(1+C_n*u)*aV <= (3/2)*n*aV.       (1)

Indeed nL+nC_n*u*(L+1)+1 <= n(1+C_n*u)(L+1). This bounds the output, not every internal value. We prove a separate coefficient K_n such that every stored internal center has norm plus one at most K_n*aV. Coefficients and cached setup values are included. For n=1 set K_1=1.

## 2. Peak recurrences

For a radix-two transform n=2^k, the stage recurrence in the accepted supplement gives

    L_next+1 <= (2+u)*(L+1).

Since 2ku<=1, finite binomial expansion bounded by a geometric series gives (1+u/2)^k<=2. Thus K_rad(n)=2n is sufficient. Each exact root product before rounding also satisfies this envelope. For a direct r-point leaf, including its partial sums,

    |partial|+1 <= r(1+u)L+2(r-1)u+1 <= r(1+u)(L+1),

where the last inequality follows from (r-2)u<=r-1. Hence K_direct(r)=2r suffices.

At a CT node n=rm the length-m children are evaluated first. By (1), their augmented outputs are bounded by m(1+C_m*u)aV. An approximate cross twiddle and its rounding replace L+1 by at most (1+u)(L+1). Because u<=1/3 and C_m*u<=1/2, the second children therefore receive augmented input at most 2m*aV. This proves

    K_CT(n;r,m) = max(K_m, 2m*K_r).                            (2)

The second term also covers the cross-twiddle value itself. The bound uses the small semantic output (1) between children; propagating the first child's peak as its output would be unnecessarily expensive.

For Bluestein set P=nextPowerOfTwo(2n-1), m=2n-1, k=log2(P), and A=1+3(2k+4), as in the accepted error proof. The safety conditions imply PAu<=1. The data FFT has norm at most (n+PAu)aV<=(n+1)aV. The stored kernel FFT has norm at most m+PAu<=2n. Thus the rounded point product has augmented norm at most

    Z*aV, where Z=2n(n+1)+2.

All k inverse stages, before division by P, have augmented norm at most 2PZ*aV. The forward data FFT peak is at most 2P(1+u)aV and the cached kernel construction peak is at most 2P(2+u); both fit this larger envelope. After division, even allowing rounding u, the augmented bound is at most (2Z+2)aV. The final chirp gives at most (1+u)(2Z+2)aV<=2PZ*aV, since P>=4 and Z>=14. Therefore

    K_Blue(n)=2PZ=4P(n^2+n+1).                               (3)

This proof does not treat the kernel FFT as a unit coefficient, infer a small inverse peak from the final transform, or discard its construction error. It bounds the specified FFT setup, not the arithmetic used to construct root enclosures themselves.

## 3. Why the comparison holds

The baseline has K_old(n)=2n for powers of two and (3) otherwise. Both schedules are identical at powers of two; retained Bluestein leaves are identical. Direct leaves are smaller than (3).

For a split n=rm, r,m>=2, let P_t=nextPowerOfTwo(2t-1). Then P_m<=P_n and 2P_r<=P_n. The latter follows by doubling the dyadic ceiling for 2r-1 and using n>=2r. All child peak bounds are at most K_Blue of their lengths. Hence

    K_m <= 4P_n(n^2+n+1),
    2m*K_r <= 4P_n*m(r^2+r+1) <= 4P_n(n^2+n+1).

For the last inequality, the difference is r^2*m*(m-1)+1-m>=0. This proves K_mixed(n)<=K_old(n) by induction whenever a composite split is selected. The proof does not rely on a favorable measured transform value or on a particular prime factor distribution.

For an outer product-group transform, let v_before be the product of preceding axis lengths in the unchanged coordinate order. Repeated application of (1) gives incoming augmented norm bounded by

    v_before * product_previous(1+C_i*u) * V <= 2*v_before*V.

Define the whole-conductor coefficient K(c)=max(1, max_axes 2*v_before*K_axis). The comparison is preserved for every conductor. The factor two is also charged to the first axis for a simple common rule. A tighter first-axis rule is possible but unnecessary here.

## 4. Exact metadata result

The new script rebuilds the integer factor schedule and matches canonical plan hash `fa64e941393518f8debe960c0b81d977e0100cc033a9028287f6d86cc2917d5b`. It checks all 13,943 actual axis lengths, 37,117 active nodes and 149,999 conductor layouts from the frozen R150000 inventory. It does not silently substitute the proposed R138000 or R140000 domain. Any subfamily inherits these bounds.

Every axis and conductor satisfies K_mixed<=K_old. The 16 power-of-two axis lengths have equal bounds; the other axis bounds save 3 to 36 ceiling-log2 bits. These are differences between deliberately conservative envelopes, not measured memory savings.

| Conductor | ceil(log2 K(c)), old | ceil(log2 K(c)), mixed |
|---:|---:|---:|
|10007|45|42|
|100003|55|52|
|150000|43|19|
|262144|19|19|
|300000|44|20|

The largest old coefficient is 94362403055075328 at conductor149993, with ceiling logarithm57. The largest mixed coefficient is 11775570184503296 at conductor149867, with ceiling logarithm54. Their conductors differ; the pointwise comparison was checked separately at every conductor. All coefficient rows and bit-saving histograms are retained.

## 5. Stored centers, exact products and cost

Choose an integer b>=0 with V<=2^b, and put q=ceil(log2 K(c)). Store every coordinate on the common grid 2^-p. A conservative signed width for stored center numerators is

    w_store = p+b+q+2.                                      (4)

This requires explicit fixed-point alignment. Arbitrary floating exponents with large gaps are not covered by (4). Root and cached-kernel centers use the same fractional grid; their certified enclosure generation remains separate work.

At every multiplication in this circuit the product of the two complex operand norms is itself bounded by K(c)V. For root products this follows from the corresponding stage envelope; for the nonunit Bluestein product it follows from (n+1)*2n*aV and its ancestor scaling. Thus exact schoolbook real products and their final real/imaginary combinations have a safe numerator width

    w_product = 2p+b+q+2.                                   (5)

One can instead use the looser generic 2*w_store rule, but the circuit supplies the sharper product-magnitude bound (5). Keeping p fractional bits after multiplication is not exact; the rounding gate and its error certificate must still be checked. Exact inverse division by P, or rounding back to the grid, also needs its specified shift/rounding proof.

For a three-real-product identity evaluated exactly before the same final complex rounding, each real presum has absolute value at most twice its operand norm. Its largest product is at most four times the complex norm product, and the two subsequent subtractions are bounded by six times that product. Safe widths are w_store+1 for presums and 2p+b+q+5 for product/subtraction temporaries. These extra bits are not optional. If the three products or subtractions are rounded separately, their independent error analysis must establish the accepted complex-gate contract; the identity alone does not do so.

Both schedules therefore admit the same p and no larger mixed values in (4), (5), or the stated three-product widths. This closes the extra-integer-bit question for a uniform conservative allocation. It does not prove that each mixed gate is narrower than a corresponding baseline gate: the circuits have different gates, and a baseline may use sharper per-stage bounds.

For Lean and ordinary-rule MM0 the useful model is a sum of actual integer-operation costs, such as sum_g Mul(w_left(g),w_right(g)), with addition, rounding, range proofs and coefficient verification charged separately. Applying a shared maximum width to all gates is a valid upper-cost design. Pairing the old operation-count saving with that design introduces no uncharged width inflation. Comparing two upper bounds is not a lower bound on actual runtime improvement. A tighter decision must preserve per-stage widths and rectangular products, representation conversions, root/cache construction, proof-DAG sharing, proof serialization and storage traffic. Neither native-array kernel reduction nor arithmetic acceleration outside the standard proof rules is assumed.

## 6. Frozen artifacts and limits

`mixed_radix_width_metadata_20261111.py` SHA256 `CA571F8B74849F3F70EE2DA8867D1AD212B8D3140B2D7CE3E448001B3836DE24`.

`mixed_radix_width_metadata_20261111.json` SHA256 `364B00C1BA63A06CC5B1C3E0CC777280151BB05E0E5B56063231596B0249B48F`.

The script imports only Python standard-library integer/metadata facilities and writes a new receipt exclusively. It verifies the four upstream pins recorded in that receipt. Its completed result is `PASS_INTEGER_PEAK_WIDTH_COMPARISON`. It proves no roots, sign margins or zero counts and changes none of the source, analytic, interpolation or Turing obligations. The peak recurrences are the paper proof supplied here; the integer run specializes them to the frozen schedule.
