# Independent review of mixed-radix precision bounds

2026-11-11. PASS for the conditional paper error bounds and the complete finite integer comparison. No correction is required to `zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md`, SHA256 `4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4`.

The same fractional precision suffices relative to the author's specified conservative whole-axis Bluestein bound. This is not an empirical minimum, a comparison against an optimized error analysis, or a total word-width/runtime guarantee. The complex absolute-error gate contract, root and kernel certificates, actual inputs and analytic error budgets remain requirements. No transform, root, character, L-value or zero was evaluated; no build was run. The only execution independently reconstructed finite integer metadata.

## Exact scale and local contract

The exact target is the positive unnormalized transform D_n. Its mathematical normalization T_n=D_n/n has sup-operator norm at most one. This normalization is used to compare errors, not to insert a numerical division by n into the circuit. The accepted CT permutations and positive cross factors remain unchanged, and the only algorithmic normalization in Bluestein is division by its padded convolution length P.

All bounds assume M>=0, exact stored input bounded by M, root approximation error at most u in complex norm, and absolute complex error at most u for each rounded addition or product on its actual stored operands. A coordinate rounding error of u does not automatically meet the complex error requirement. An implementation must allocate coordinate errors, certify roots and account for its real-arithmetic formula. A fixed relative mantissa precision does not meet this absolute contract without magnitude bounds.

The radix-two recurrence follows by writing a rounded butterfly as a sum of two old errors, root error times the ideal intermediate, root error times an old error, and product/addition rounding. Dividing stage-j errors by 2^j gives

    f_(j+1) <= (1+u/2) f_j + uM/2 + 2u/2^(j+1).

Under 2ku<=1, the amplification product is at most two. The inhomogeneous sum is at most kuM/2+2u. Thus C=2k+4 is safely loose. At n=1, the exact identity transform has C=0. The direct small-prime leaf charges r-1 root errors, r-1 product roundings and r-1 addition roundings per nonzero row; its normalized C=2 follows. The zero-frequency row is no worse.

## CT cross terms

For n=rm with the m child first, its unnormalized error is at most m C_m u(M+1). Cross multiplication by a root approximation gives normalized error at most

    u(M+1)d,  d=C_m(1+u)+1.

This retains the root-error times child-error product. The stored input to the r child has magnitude at most mM+m u(M+1)d. Its intrinsic error divided by rm is therefore at most

    C_r u(M+1)(1+ud).

The exact normalized r transform passes the existing normalized input error with norm at most one. Adding both contributions yields

    u(M+1)[C_m+C_r+1+u(C_m+C_r d)].

Since u<=1 gives d<=2C_m+1, the denominator constraint u[C_m+C_r(2C_m+1)]<=1 proves C_CT=C_m+C_r+2. Taking the maximum with both child denominators makes recursive use valid. No r or m factor is omitted: the cancellation occurs only after the corresponding unnormalized error is divided by the full length rm. The order of children matters to the stated denominator and is preserved by the metadata.

## Bluestein and the nonunit cached kernel

The exact chirped data transform has norm at most nM; the exact padded kernel transform has norm at most m=2n-1. The transformed kernel is not a unit root. Its uncertainty cannot be dropped because it is cached.

For the data chirp, the input perturbation is at most u(M+1), and the stored magnitude plus one is at most 2(M+1). Combining exact FFT input transport with its intrinsic rounding bound proves e_F<=P(1+2R)u(M+1), hence the author's looser P A u(M+1) with A=1+3R. For kernel input perturbation u and stored magnitude at most 1+u<=2, the same calculation gives e_K<=P A u.

The complete point-product error is

    nM e_K + m e_F + e_F e_K + u.

When PAu<=1, its cross term is at most PAu(M+1). With n+m+1=3n, this proves e_C<=(3nPA+1)u(M+1)=Q u(M+1). The separate Qu<=1 condition then bounds the stored point-product magnitude plus one by (nm+2)(M+1).

The normalized inverse FFT has exact operator norm at most one, so it carries e_C without an extra P. Its intrinsic contribution is R u times the stored input magnitude plus one. Allowing one further u for division rounding gives

    e_inverse <= [Q+R(nm+2)+1]u(M+1).

The selected exact convolution outputs have magnitude at most nM. Final chirp error is at most (1+u)e_inverse+unM+u. After dividing by n only in the error statement, one valid coefficient is

    6PA + 2R(m+2/n) + (n+5)/n.

For n>=2, the stated C_Blue=6PA+2R(2n+1)+8 dominates this. Its safety denominator includes 2k, PA and Q, so every small-u assumption used above is covered.

A cached transformed kernel may be reused indefinitely with the same verified error bound. That does not reduce the error charged at each use. A lower-precision cache must retain its actual larger e_K, or be rebuilt and verified. Likewise a supplied kernel box must be linked to the exact signed chirps and exact transform, not merely to a plausible vector. These obligations remain explicit in the supplement.

## Composition of outer axes and finite comparison

For unnormalized outer axes, let a be the product of lengths already applied and normalize the current error by a. The next intrinsic term divides by a as well, so its additive constant 1/a is at most one. This proves the recurrence

    e_next <= (1+C_i u)e_current + C_i u(M+1),

without inserting normalization gates. Iteration gives (M+1)[product_i(1+C_i u)-1]. When S=sum_i C_i and Su<=1/2, expansion into nonnegative terms bounds this by 2Su(M+1).

For uncertain input, exact normalized transport contributes E_0 separately, and stored-center norm is at most B+E_0. The unnormalized error is consequently bounded by v[E_0+2Su(B+E_0+1)], with v=phi(c). The displayed conditions E_0<=tau/2 and u<=tau/[4S(B+E_0+1)] prove the normalized budget tau. When S=0 no arithmetic error remains and the S denominators are omitted. An unnormalized desired budget still requires tau=budget/v; later conductor or Hardy factors need their own error bounds.

I independently rebuilt the conductor factorization and schedule using stagewise radix-two counts and a parity formula for the cheap chirps. The script does not import or run the author code. It reconstructed 149999 conductors, all 13943 distinct outer axis lengths, and all 37117 active plan nodes. The canonical plan hash exactly matches both frozen receipts:

    fa64e941393518f8debe960c0b81d977e0100cc033a9028287f6d86cc2917d5b

Every saved axis row and every conductor sum satisfies C_mixed<=C_old. This is a finite statement about the complete specified axis set, not an automatic inequality for every integer length or every possible split tree.

There is exactly one increase of the raw safety denominator:

| Axis n | Old C | New C | Old denominator | New denominator |
|---:|---:|---:|---:|---:|
|598|1033004|29358|290254849|366746468|

Both denominators lie strictly between 2^28 and 2^29. Thus both require 29 fractional safety bits. For every other axis, and therefore every axis maximum used in a conductor, the dyadic safety requirement does not increase. With u=2^(-p), the condition u<=1/D is exactly p>=ceil(log2 D). Lowering S also weakens both remaining u constraints at fixed B, E_0 and tau. This proves the same-fractional-precision claim for the specified sufficient bounds.

The maximum old denominator is 29961461170177 and the maximum new denominator is 7130494795777, requiring 45 and 43 safety bits respectively. These are small-u admissibility floors only. They do not prove that 45 or 43 bits meets any actual output tolerance. The independently reconstructed example conductor sums and both maximum sums also match the receipt.

## Peak widths and remaining scope

For stored inputs bounded by L, a radix-two product has norm at most (1+u)L+u and its following addition at most (2+u)L+2u. This proves the proposed stage peak recurrence. The direct-leaf bound includes partial sums. CT must retain the maximum of each child's internal peak and the cross-twiddle peak, rather than overwrite it with a smaller final-output bound.

Bluestein must include the cached-kernel construction, the point-product bound (nL+e_F)(m+e_K)+u, and the entire unnormalized inverse FFT before division by P. Its internal peaks are not bounded by the final nL scale. The given recipe supplies finite rational bounds without knowing root values, but the receipt does not calculate a global peak-width optimum or prove equal total widths between schedules.

The signed fixed-point width expression is sufficient for stored coordinates once L_peak is actually established. Exact multiply temporaries, pre-rounding sums and rational encodings require separate sizes. Therefore equal fractional precision does not imply equal memory or multiplication costs, and the earlier operation-count saving is not yet an end-to-end timing result. No spectral outputs or sign margins are certified by this supplement.

## Frozen evidence

Paths below are relative to `work/qrh-campaign/agents`.

| Artifact | SHA256 |
|---|---|
|zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md|4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4|
|zero-sum/mixed_radix_precision_metadata_20261111.py|3750A9C8FD77163C878694959158762D183F1425E4F85F983230A841BAEBDC42|
|zero-sum/mixed_radix_precision_metadata_20261111.json|8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E|
|zero-sum/MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md|C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01|
|zero-sum/mixed_radix_character_inventory_20261111.json|2AC4DBAF9D0C41D1DFD8006AC280619DFF6C3059D7DA7FAEF6F1C477D2CE4D3F|
|independent-feasibility/REVIEW_MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md|BABEF1416D8D02864360DD523DE18F468FD0DCDD3FA5C583F6BD564C76A19AB9|
|audit/review_mixed_radix_precision_20261111.py|95C95AC546606AEAED1DCABB202FF3CA546B5618D13DCA81151582A36DDE9696|
|audit/review_mixed_radix_precision_20261111.json|5D890B1A0C55FA6941FB217D68BC8A95677641736926C927DC9F1402F636AB20|

All listed input hashes matched. The independent integer-only script exited zero. The root enclosures, absolute-error arithmetic implementation, cache linkage, actual input precision, analytic remainders, sign decisions and completeness proof remain separate obligations.
