# Small-theta off-grid arithmetic schedules

2026-11-11. Paper and exact metadata only. No transform, prime, zero, L-function or analytic value was evaluated. No source or frozen predecessor was changed. This is an arithmetic alternative to the independently reviewed interpolation adapter, not a new analytic admission or a successful sign certificate.

## 1. Result and exact input

The same finite polynomial admits three useful schedules: sparse 340-term interpolation, one length-N FFT per requested fractional-offset class, or one length-8N zero-padded FFT. The second schedule can stream classes with length-N workspace. With all seven new classes, it replaces 12N butterflies in the padded schedule by 7J coefficient-phase products and their setup. This is an operation comparison, not a runtime inequality: precisions, root construction, storage and query distribution still matter.

Use the actual stored centers and conventions of integration's `SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT`, sections 3–5:

    T(t) = omega * sum_{j=-J}^J A_j exp(i*j*omega*t),
    A_-j = conjugate(A_j), A_0 real,
    Delta = 5/64, omega = 2*pi/(N*Delta),
    J = ceil(25*N/192) < N/2.

For the admitted tilts theta in {64,128}, let eps=2^-82/3^theta. The inherited, uniform comparison is |F_b(t)-T(t)|<3eps/4 for 0<=t<=V. All coefficient uncertainty is already charged there; the present FFT inputs are the exact stored rational centers. They satisfy |A_j|<=B=3125000000001<2^42. The polynomial satisfies |T|<=M=44B=137500000000044<2^48 on the entire real line.

The existing full-family N range lies inside [2^18,2^31]. The arithmetic bounds below apply whenever these algebraic size conditions hold. Applying them to newly selected intermediate tilts additionally requires their own analytic admission; the frozen predecessor names only 64 and 128. No such extension is assumed here.

## 2. Exact refined-grid identities

Let d=2^h with 1<=d<=8. For a padded transform of length n=dN, place A_j in slot j for 0<=j<=J, and A_-j in slot n-j for 1<=j<=J; set all remaining entries to exact zero. For the positive-sign normalized DFT,

    z_k = (1/n) sum_r b_r exp(2*pi*i*r*k/n),
    omega*n*z_k = T(k*Delta/d).

Appending zeros to the old length-N array is wrong: its negative-frequency slot N-j must move to dN-j. The phase difference at a noncoarse point is generally nonintegral. The receipt checks this failure and the correct phase congruences using rational exponents, without evaluating exponentials.

For a polyphase schedule, fix an offset ell in {0,...,d-1}, and multiply each SIGNED frequency by

    b_j^(ell)=A_j exp(2*pi*i*j*ell/(dN)).

Store positive j in slot j and negative j in slot N-j. The normalized length-N transform satisfies

    omega*N*z_k^(ell) = T((k+ell/d)*Delta).

Compute only the J positive phase products, and create their negative partners by exact conjugation. This preserves a real target. In particular the phase at the stored negative slot is based on -j, not N-j. Offset zero uses the original coefficient array.

Both identities are finite distributive identities. Only T has period N*Delta. No periodicity of F_b or Y is asserted. A requested target must remain in [0,V]; the FFT's other polynomial values require no extension of the analytic interval.

## 3. A complete fresh FFT rounding allocation

This deliberately conservative allocation makes the alternatives comparable without importing a longer-FFT precision claim. It is not an assertion that an existing rounded array satisfies it.

For a complex Euclidean error budget u, certify every used twiddle or coefficient phase to error <=u. In every normalized radix-two butterfly compute the product, then each output:

    t = round_u(w_hat*v_hat),
    y_plus = round_u((u_hat+t)/2),
    y_minus = round_u((u_hat-t)/2).

Each named rounding has complex norm error <=u; division by two is exact before rounding. The exact transform is normalized at every stage, so all exact nodes have norm <=B. If all previous errors are <=e, then

    e_next <= (1+u/2)e + (B/2+2)u.

For depth k and u<=1/(2k), the geometric amplification is below two, giving

    e_k <= 2e_0 + k(B+4)u.                                      (1)

Indeed (1+u/2)^k <= sum_{j>=0}(ku/2)^j <=4/3<2. Padded inputs have e_0=0. Polyphase inputs have e_0<=(B+1)u, from the phase error times B and one product rounding. Exact conjugation adds no error.

Certify the output scalar c_n=omega*n to absolute error <=u. Its true value is below Lambda=7(n/N)/Delta. Project the FFT center to its real part, multiply by the scalar center, and round once with real error <=u. Projection does not enlarge error because the exact output is real. If e_k<1, output error is bounded by

    [Lambda*(2(B+1)+k(B+4)) + B+2]u.                            (2)

For polyphase use n/N=1 and k=log2 N. For padding use n/N=d and k=log2 N+h. The receipt uses the worse nonzero e_0 even in the padded case. Uniformly over d<=8, k<=34, the choice u<=eps/2^68 makes (2) <eps/64 and e_k<1.

Concrete sufficient dyadic gate budgets are:

| theta | complex roots/products/output roundings u | local interpolation real gates v below |
|---|---|---|
|64|2^-252|2^-246|
|128|2^-353|2^-347|

These follow from 3^64<2^102 and 3^128<2^203. They are absolute Euclidean budgets, not binary floating-point mantissa lengths. Coordinate nearest rounding on grid u has norm error <u. Every product and sum is performed exactly between the named dyadic rounding gates. Stored FFT nodes have norm <B+1; predivision butterfly temporaries have norm <4(B+1). Thus these gates require bounded integer parts, but root/phase generation and their own internal proof costs remain additional. In particular a count of FFT butterflies is not a count of equal-cost operations across different u.

The resulting F_b error is <49eps/64. For a sign test no positive rescaling is necessary. For numerical Y use integration's separately justified exp(theta*t/V) scaling at the TARGET, including its scale approximation and product error. The scale must not be copied from a neighboring target. A standalone conservative alternative, using only |T|<=M, is scale error <=tau/[4(M+1)] and final product error <=tau/4, tau=2^-80: since the computed F_b center has magnitude <M+1 and exp(theta*t/V)<=3^theta, this gives total Y error <3tau/4. This alternative may cost more scale bits than the sharper predecessor; it is not charged as free reuse.

## 4. Sparse queries under the same comparison

The reviewed local method uses the 340 nodes -169,...,170 and seven shared rational Lagrange kernels at ell/8. Their l1 norms are below four. Its truncation is <eps/16. It requires the polynomial grid samples themselves, each to error <=eps/64; samples enclosing F_b or Y are not interchangeable with these.

One explicit arithmetic implementation quantizes each weight with absolute error <=v, rounds each of the 340 real products to error <=v, rounds the 339 sequential additions likewise, and optionally rounds the final result once. Grid centers have magnitude <M+1. The total kernel/arithmetic contribution is at most

    340(M+1)v + (340+339+1)v = 340(M+3)v.

The condition v<=eps/2^62 makes this <eps/16; the dyadic choices in the table suffice. Sample uncertainty contributes <eps/16, so the complete error remains <15eps/16 after including the analytic comparison once at the target. None of that analytic error is multiplied by the interpolation norm.

There are 2380 shared rational weights before precision-specific rounding. Their proof and construction must be included. One query costs 340 real products, 339 real additions, 680 named real roundings with the optional final round, and 340 sample accesses. A final strict sign test is extra. Exactly repeated queries can share their computed answer.

If q distinct noncoarse queries use m distinct coarse indices, m<=min(N,340q). An existing full raw FFT can supply those indices, but each required omega normalization must be performed or already present at the tighter precision. The old exported Y prefix is insufficient. Wrapping stencil indices modulo N is valid only for T. Retaining the full raw array, retaining a selected subset, replaying a transform, and recomputing missing data have different storage/work costs.

## 5. Operation and storage ledger

Write F(n)=n*log2(n)/2. This is the conservative full radix-two schedule, including butterflies that a separate pruning proof might remove. Under section 3 one butterfly has one complex product, two complex additions, two exact dyadic divisions, and three complex rounding gates. A generic complex product itself is four real products and two real additions if that implementation is chosen; no universal bit cost is assigned to it.

For a nonempty set of a requested nonzero offset classes:

| Incremental polyphase work after an adequate base transform | Count |
|---|---:|
|Length-N butterflies|a F(N)|
|Coefficient-phase complex products and their rounding|a J|
|Exact conjugate assignments|a J|
|New phase constants before cache deduplication|at most a J|
|Output scalar products/roundings|q requested outputs|
|Array initialization/read/write traffic|a complete length-N arrays plus retained outputs|

The phase constants have order dN, while the FFT twiddles have order N. A direct full twiddle table uses at most N/2 certified roots; the phase constants may share a larger table or be certified separately. Choosing one full dN/2 table bounds the total, but its construction and storage are not free. A recurrence for roots would require its own accumulated-error proof. Cached constants can be shared only with matching root, sign and precision contracts; theta128 constants can serve theta64 if retained at their tighter precision.

The padded schedule costs F(dN) butterflies total, at most dN/2 twiddle constants, and q requested output normalizations. If it is chosen before executing the base transform, its increment relative to a common base schedule is F(dN)-F(N). If the base transform is already executed and cannot be reused by a proved algorithm, the new transform costs F(dN), not that difference.

For a complete d-fold grid including the base class,

    F(dN) - d F(N) = dN*log2(d)/2.

At d=8 this is 12N butterflies, whereas the extra polyphase setup uses 7J products. Exact examples:

|N|J|7 F(N)|7J|F(8N)-F(N)|
|---:|---:|---:|---:|---:|
|262144|34134|16515072|238938|19660800|
|16777216|2184534|1409286144|15291738|1610612736|
|2147483648|279620267|233001975808|1957341869|258771779584|

Polyphase uses one length-N complex workspace plus the retained coefficient array and outputs, processing classes sequentially. Padding uses length-dN workspace. A full root cache, exact-product temporaries, proof records, transpose traffic and parallel copies are additional in both cases. Sparse interpolation needs m retained real grid values, but generating them may still require length-N workspace. None of these schedules removes the already required Gaussian or character-transform work.

## 6. A usable break-even rule

The correct decision uses priced operations at the stated widths, not an unweighted sum of rows. Let C_dot be the complete 340-term query cost including its accesses and rounding, C_out the selected real output normalization, C_BF the butterfly cost, and C_phase the coefficient-phase product/conjugation cost. Let S_local include kernel setup, any cost of tightening/replaying the base transform, m grid normalizations and retention. Let S_poly include phase/root setup not already shared, array traffic and any different base-transform preparation. Then, after subtracting genuinely common work, polyphase is cheaper exactly when

    q*(C_dot-C_out) > S_poly-S_local + a*(F(N)C_BF + J C_phase). (3)

For fixed a,m and fixed schedules, if C_dot>C_out the first integer q satisfying (3) is the strict floor-plus-one threshold, clipped at zero. If the denominator is nonpositive, no positive-denominator formula applies. If q changes the occupied classes or m, those quantities must be updated; query count alone does not determine a threshold. An online policy can retain local answers and switch a heavily used class, but pays the work already spent and still needs the same output/error identity.

The padded counterpart replaces the right-hand FFT/phase term with its actual new F(dN) schedule, or its justified preexecution increment. Numerical Y-scale generation is common only when both schedules use the same proved scale contract at the same targets. Sign-only output avoids that cost for both. This rule exposes when a dense route may amortize setup without asserting that actual sign queries are dense or predictable.

## 7. Evidence and remaining obligations

The companion exact script checks 3717 assertions: predecessor hashes, both dyadic precision allocations, every admitted size/depth and refinement bound, exact schedule identities, correct signed phase congruences and the naive-padding counterexample. It does not run an FFT. The real Lagrange truncation/norm proof and the F_b comparison are inherited from the reviewed integration note; the normalized butterfly proof and refined-grid identities are supplied above.

An ordinary proof implementation still needs the exact finite DFT identity, a verified chosen radix-two circuit, dyadic rounding/root certificates, source-array identities, the selected operation/storage backend, and actual endpoint values. No sign success, Turing surplus, number of repairs, or elapsed verification time follows from this report. This also does not select a new minimal tilt or revise the whole-family inventory.

Pins (paths relative to `work/qrh-campaign/agents`):

|File|SHA-256|
|---|---|
|integration/SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md|19E411982E0D504C52F604145D6404ACB3BEBA51B662CB7BB1CDBD5D31E83081|
|moebius/REVIEW_SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md|B815BBEEF96C0E8D1259A915E8BB0F3BEB98BBD1CFB9473B038E0B3D64F3A38F|
|prime-estimates/WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md|74CE66BE4E051AEC1222AB67DF66F124DB1A1774498E6FBE52BDF59EDD9BC9BE|
|prime-estimates/small_family_theta_inventory_final_20261111.json|26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69|
|major-constants/small_theta_offgrid_arithmetic_20261111.py|282B1E326DD909163F1BA93D69F9DF5A3B6B4BD22B1DA4049DEEA1B60EEFC189|
|major-constants/small_theta_offgrid_arithmetic_20261111.json|6C28F063B8FE59B7BAD84FE50CF87425F6A3635AABDA62549660CABA5E425609|
