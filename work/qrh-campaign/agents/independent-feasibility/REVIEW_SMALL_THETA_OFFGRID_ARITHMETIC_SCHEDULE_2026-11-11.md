# Review of the small-theta off-grid arithmetic schedule

2026-11-11. PASS at conditional paper and exact-metadata scope, without correction. The reviewed author is `major-constants/SMALL_THETA_OFFGRID_ARITHMETIC_SCHEDULE_2026-11-11.md`, SHA256 `8B299BFBDB936C6B85E0AEE6A3D61B0104A2D40D9E604DA98E1E8A76AAD8A0B9`.

I read the complete note, its script and receipt, and the preceding interpolation author and independent review. The new identities, normalized rounding allocation and charged schedule comparisons are sound under their stated conditions. They do not certify actual values, signs, repair counts, a Turing surplus or a runtime improvement. No transform, root, elementary or spectral value was evaluated; no build or frozen-file change occurred.

## Actual input and signed frequencies

The input is the exact stored coefficient-center array defining the finite real polynomial T. The negative coefficients are exact conjugates and A0 is real. The comparison to the actual F_b has already charged coefficient uncertainty and analytic tails, once at the target. Reintroducing that uncertainty at every butterfly or interpolated sample would describe a different bound.

The inherited full-family transforms have N a power of two in[2^18,2^31]. The radix-two counts are not claims for every arbitrary integer in that interval. Refinement d is1,2,4 or8. The algebraic identities themselves have wider scope, but the stated error depths and counts use these sizes. The physical targets remain in[0,V], and the admitted tilts remain64 and128. Newly chosen tilts would need their own analytic admission.

For a padded length dN transform, signed frequency j belongs in slot j modulo dN. Its normalized contribution at output k is A_j exp(2pi*i*j*k/(dN))/(dN). Multiplication by omega*dN gives exactly T(k*Delta/d). The negative-frequency slot is dN-j, not N-j. Using N-j after padding multiplies its contribution by exp(2pi*i*k/d), which need not be one. The author correctly excludes that naive padding.

For class ell, first replace A_j by A_j exp(2pi*i*j*ell/(dN)), using signed j, and then put it in slot j modulo N. At coarse output k, the exponent is congruent to j*(k+ell/d)/N. Thus multiplication of the normalized transform by omega*N gives T((k+ell/d)*Delta). Negative coefficients can be obtained by exact conjugation of the J positive products, with no second phase-product error. Applying the phase according to the stored slot N-j would be wrong at nonzero ell.

Only T is periodic. Wrapped stencil samples and refined-grid outputs outside the admitted physical interval do not become values of F_b or Y there. The author retains this distinction.

## Complete rounding bound

Exact nodes of the normalized radix-two network have magnitude at most B, because each butterfly is a half-sum or half-difference after a unit rotation. Suppose two input errors are at most e, the twiddle error at most u and the product rounding at most u. The product error is at most(1+u)e+B*u+u. After the half-sum and output rounding, the sharper one-step bound is

    e_next <=(1+u/2)e+(B/2+3/2)u.

The author's B/2+2 is therefore conservative. If u<=1/(2k), the amplification is below2, yielding e_k<=2e0+k(B+4)u. A padded exact-center input has e0=0. A nonzero polyphase input has e0<=(B+1)u. These are arithmetic errors in the finite T calculation; no coefficient uncertainty is missing from this step.

The exact final normalized FFT output is real. Projection to the real part cannot increase error. With scalar c=omega*n and its absolute approximation error at most u, the final multiplication error is at most

    c*e_k+(B+1)u+u,

provided e_k<1. Since c<7(n/N)/Delta, this is bounded by the displayed author expression. My independent exact recurrence calculation verifies that expression below eps/64 for both precisions and every admitted depth/refinement. In particular u=2^-252 for theta64 and2^-353 for theta128 meets u<=eps/2^68.

This gives F_b error below49eps/64. It does not imply nonzero output. The stored bound below B+1 and predivision temporary bound below4(B+1) concern complex magnitudes. Raw integer products have both operands' fractional scales and still need a separate width-aware representation. The author does not equate the listed fractional bits with a complete machine mantissa.

For numerical Y, the positive factor must be evaluated at the target. Its error tau/[4(M+1)] multiplied by the computed center contributes at most tau/4, final rounding contributes tau/4, and the F_b error contributes less than49tau/256. Their sum is below3tau/4. The same conservative scale contract also covers the local method, whose F_b contribution is below15tau/64. Sign-only output can omit this positive rescaling using the proved identity; its numerical magnitude cannot be silently relabeled as Y.

## Local interpolation and fresh setup

The inherited340-node real interpolation has exact weight l1 norm below4 and truncation beloweps/16. It requires samples of T to eps/64, not samples of Y or F_b with that label. Decomposing first with the exact weights gives sample contribution beloweps/16. Weight errors times sample centers contribute at most340(M+1)v. Product, addition and optional final rounding contribute680v. Their sum is340(M+3)v<eps/16 at the stated v choices. Adding the analytic comparison once at the target gives less than15eps/16.

The query count of340 real products,339 additions and680 roundings is correct for that declared implementation. Quantization of the2380 shared weights is setup, not an omitted per-query operation. Actual table proofs, data access, sufficient sample normalization and array binding remain charged separately. No claimed local-query saving removes the work required to produce or retain those samples.

## Schedule and break-even interpretation

For N=2^k, F(N)=Nk/2 counts full butterflies. A d-fold complete polyphase calculation uses dF(N), including the base class. The padded calculation uses F(dN), and their difference is dN*log2(d)/2. At d8 this is12N. Positive-frequency phase products for the seven new classes number7J. I reconstructed all three numerical table rows exactly.

The12N comparison is a preexecution matched-schedule comparison. If the base transform has already been performed, a new padded transform normally costs F(dN), not F(dN)-F(N). The author explicitly states this. Likewise an old base array at weaker precision is not automatically the adequate base transform in the incremental polyphase table.

After subtracting genuinely common work, the author's inequality

    q*(C_dot-C_out) > S_poly-S_local+a*(F(N)*C_BF+J*C_phase)

has the correct sign. It compares complete local-query cost with selected-output normalization plus class transforms and setup. A positive-denominator floor-plus-one threshold is only a scalar threshold in a fixed schedule. A feasible nonempty-class query set also has q>=a, and at most aN distinct refined-grid points before physical-domain restrictions. The number m of retained stencil samples and the class count a may change with q. These feasibility conditions must accompany any use of the threshold; no actual sign-query distribution is inferred here.

Each butterfly's one complex product, two complex additions, two exact half-scalings and three complex roundings are all present. Root/phase construction, cache identity, initialization/traffic and final requested normalizations are not treated as free. The root budgets require fresh certificates at the new accuracy or correctly reused tighter certificates. A root recurrence would need its own error proof.

Sequential polyphase classes can use length-N working arrays, while padding needs length-dN for the declared schedule. Both still need coefficient storage, caches, output retention, exact temporaries and proof state. At the largest refinement dN=2^34, the mathematical count is not evidence that a stock32-bit indexed implementation accepts the array. The paper claims neither such implementation nor a peak-memory measurement. It also claims no improvement over an already optimized historical implementation.

## Independent evidence

Owned `review_small_theta_offgrid_20261111.py`, SHA256 `24B26FB2B4CCD1DB260EC8CA84D6E2F8CCA8B1EE17369709F52259887D51AA90`, passed9843 exact checks. Its receipt `review_small_theta_offgrid_20261111.json` has SHA256 `359BECBA201C64855DF92AE276A4E61E4DEDF511B6E7A1B7466996E53A88CBD3`. I iterated the rational error recurrence independently, checked every admitted depth and refinement, reconstructed the table counts, and checked signed phase identities by integer modular congruences. None of these operations evaluates a Fourier transform or its roots.

All seven pins match: the reviewed author; author script `282B1E326DD909163F1BA93D69F9DF5A3B6B4BD22B1DA4049DEEA1B60EEFC189`; author receipt `6C28F063B8FE59B7BAD84FE50CF87425F6A3635AABDA62549660CABA5E425609`; interpolation author `19E411982E0D504C52F604145D6404ACB3BEBA51B662CB7BB1CDBD5D31E83081`; its independent review `B815BBEEF96C0E8D1259A915E8BB0F3BEB98BBD1CFB9473B038E0B3D64F3A38F`; whole-family author `74CE66BE4E051AEC1222AB67DF66F124DB1A1774498E6FBE52BDF59EDD9BC9BE`; and inventory receipt `26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69`. Exact paths are retained in the independent receipt.

The predecessor's analytic interpolation and amplitude identities are consumed at their already reviewed scope. The new normalized arithmetic proof closes a conditional schedule, not actual endpoint signs, certified zero completeness, throughput or the final standard-axioms theorem.
