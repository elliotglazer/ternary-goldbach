# Independent review of mean-input transform error

2026-11-11. PASS at conditional paper/source scope, without a mathematical correction. This review binds `independent-feasibility/MEAN_INPUT_TRANSFORM_ERROR_RESEARCH_2026-11-11.md`, SHA256 `160E25353C24850DCA6D167AA5D85D54579FED642BAB3A1E55CC6AD0358C2AF6`.

The paper proves a stronger input-norm statement for the legacy mixed-radix C/D coefficients. It does not merely substitute a mean for a maximum in the earlier theorem. The local proofs and the outer tensor proof retain the actual input supports. The optional uniform augmented mean below186 follows under the named full-P20 and nonnegative-radius-sum premises. Final-band-only176 is separate.

This verdict selects no precision and approves no new selector, assignment, metadata fold or price. Later tight C constants are not imported. Stored and raw arithmetic widths retain the separate pointwise bounds. Actual producer data, gates, cache contents and successful signs/counts remain required.

## 1. Statement and exact circuit

The reviewed local statement is, for exact stored centers x of length n,

    max_k |Dhat_n(x)_k-D_n(x)_k|/n <= C_n*u*(M(x)+1),
    M(x)=sum_j |x_j|/n.

D_n is the positive unnormalized DFT. Division by n appears in the proof, not as a newly inserted gate. The arithmetic assumptions distinguish root/chirp enclosure error from absolute operation error on stored operands. A rectangular error representation must supply the stated complex-norm bound. Unit coefficients, exact signs and permutations may be charged conservatively; none can be used with an unproved label or sign.

The source CT identity uses j=a+r*b and k=v+m*u, with length-m transforms first. The finite identity jk/(rm)=bv/m+au/r+av/(rm)+bu establishes the required cross twiddle and output permutation. The proof respects this order. Negative radix transforms in the convolution satisfy the same norm estimates. Pruned outputs inherit the theorem only for a dependency-closed restriction of that full circuit. The mean denominator remains the full input length and, at the outer level, phi(c).

Input uncertainty remains separate. The exact output changes by at most the sum of individual input radii; the proof does not multiply that uncertainty by the arithmetic C coefficients. The added1 pays absolute gate errors even for zero input.

## 2. Radix and direct-leaf reconstruction

For a radix butterfly, the two preceding outputs depend on disjoint supports of the same size m. Keep their individual means M_L and M_R. Their errors sum to at most 2m*c*u*(M+1), with M=(M_L+M_R)/2. Multiplying the right stored output by an approximate unit adds both u*m*M_R and u times its existing error. One product round and one output-add round contribute2u. Dividing by2m gives precisely the paper's

    c*u*(M+1) + u*M_R/2 + c*u^2*(M_R+1)/2 + u/m.

Since M_R/2<=M and (M_R+1)/2<=M+1, this is at most u*(M+1)*[(1+u)c+1+1/m]. The same argument covers both butterfly signs and concentrated input mass. It would be invalid to bound every child mean by the global mean; the paper does not do that.

With j the level, c_j=(1+u)c_(j-1)+1+2^(1-j). Under2ku<=1, the finite-binomial/geometric comparison gives (1+u)^k<=2. The sum of the inhomogeneous coefficients is below k+2, so c_k<=2k+4. Thus the legacy radix pair remains valid. Length1 is exact and needs no mean-dependent exception.

For a direct leaf, the root contribution to a single row is at most u*sum|x_j|. At most r-1 product rounds and r-1 additions remain. Division by r gives u*M+2u, bounded by2u*(M+1). This proves C=2,D=1, including zero and concentrated inputs. It does not assume values of individual Fourier coefficients.

## 3. Ordered CT and actual fibers

For the r input rows of length m, let M_a be each row mean. Their average is the full input mean. For a fixed first frequency, exact child magnitude is at most m*M_a, and its error is bounded by m*C_m*u*(M_a+1). After its cross twiddle the error is at most

    m*u*d*(M_a+1),    d=C_m*(1+u)+1.

This includes the root error on the ideal value, the root/error cross term, and the absolute product round. The mean plus1 of the actual second-child input is consequently at most

    m*(M+1)*(1+u*d).

The exact length-r transform transports the first error by summation. Its own arithmetic theorem applies to this actual stored input mean. After division by rm the resulting coefficient is

    d+C_r*(1+u*d)
      = C_m+C_r+1+u*(C_m+C_r*d).

The checker verifies this as a formal polynomial, including the u^2 term. Because d<=2C_m+1, the legacy safety term C_m+C_r*(2C_m+1) pays the excess above C_m+C_r+1. The exported C_m+C_r+2 and old child-safety maximum are sufficient. No runtime multiplicity is substituted into this error recurrence, and no child role is dropped.

## 4. Bluestein, sparse padding and cache uncertainty

Let M be the mean of the n original stored inputs, m=2n-1 and P the padded power-of-two length. Exact prechirped data have norm-sum nM. Their error sum is at most n*u*(M+1), while the other P-n inputs are exact zeros. The actual padded mean is therefore at most (n/P)*[(1+u)M+u]. Applying the new radix theorem gives

    e_F <= P*R*u*((n/P)*[(1+u)M+u]+1)+n*u*(M+1)
        <= P*(1+2R)*u*(M+1) <= P*A*u*(M+1),
    A=1+3R.

The +1 and factor P cannot be removed by padding, since absolute rounding remains in the transform. They are both retained. For the m unit kernel entries, the actual padded mean is at most (m/P)*(1+u); its root-error sum is at most m*u. This gives e_K<=P*A*u without treating the transformed kernel as a unit coefficient.

The normalized rounded kernel has error at most (A+1)u from K/P. The old guard P(A+1)<Q=3nPA+1 proves its norm below1. The point-product error keeps both operand errors and their product:

    nM*(A+1)u +(m/P)*e_F + e_F*(A+1)u + u
      <= (3nA+n+2)*u*(M+1).

The term PAu<=1 controls the cross term. At this stage a valid pointwise majorant is used to bound the frequency-input mean by Z_s*(M+1), where Z_s=nm/P+2. The proof makes no claim of observed Fourier cancellation.

The inverse is unnormalized. Its propagated point error and its own arithmetic error give

    e_I <= P*(q+R*Z_s)*u*(M+1),    q=3nA+n+2.

That outer P remains essential. The selected ideal convolution output has magnitude at most nM. The final chirp therefore yields the displayed auxiliary C_new bound, and the exact algebraic gap

    C_old-C_new = R*(9P/2+n-10)-6 >=74

allows export of the LEGACY C_old,D_old pair. My independent check expands the postchirp gap after multiplication by n. The general inequality follows from2n<=P<4n, n>=2, R>=8 and the retained old safety guards; fixed fixtures are only checks of this algebra.

The original inverse-divide circuit is separately valid with the same newly proved forward-data/kernel estimates, point error Q*u*(M+1), and stored inverse-input mean bounded by (nm+2)*(M+1). Its internal division by P and optional round remain charged. Exact-cache/coarse-runtime has a smaller cache error and is also covered. These are distinct computed centers, not an asserted identity of rounded outputs.

Cache setup/enclosure evidence remains mandatory at every precision and every use. Reuse does not divide the enclosure radius by the number of uses. The paper proves only the legacy interface needed here; later tighter leaf and global coefficients still require their own mean-input proof.

## 5. Outer tensor induction

After processed axes of total length v_0, fix the untouched coordinates. Let M_F be the original input mean over that fiber. For each processed output label, the induction maintains both

    |ideal partial output| <= v_0*M_F,
    |partial arithmetic error| <= v_0*E*(M_F+1).

When the next axis joins r such fibers, their means average to the parent fiber mean. The actual stored next-line mean plus1 is at most v_0*(M_F+1)*(1+E). Exact error transport and the local mean theorem then give

    E_next=E+C_i*u*(1+E).

This is the required stronger invariant. A bound using the global mean for every intermediate line would fail, and is not needed. At the end E=product(1+C_i*u)-1<=2S*u under S*u<=1/2. S includes repeated outer axes. The zero-S case is exact, and an empty tensor also has zero intrinsic error.

Restoring the full group length and exact critical-line conductor magnitude gives2*phi(c)*S*u*(M_all+1)/sqrt(c). Input/source uncertainty and a single admitted regrid remain separately transported by the exact operator. This proof exports the factor2 legacy theorem. It does not compose the newer exact-tensor selector or any tighter S by implication.

## 6. Optional source mean below186

The complete finite-EM source03680 and its independent review1E9D prove actual full-P20 polynomial-center magnitudes below65,85,113,173,163 in the five bands. This review consumes those accepted bounds, not a new EM evaluation. The uniform Pstar is173 and the final-only Pstar is163. The matched full-P20 evaluator, source domain, approximation admission and exact grid100 export remain premises. Shorter output or another evaluator cannot be substituted without its own join.

For the finite head at representative1<=a<c, the exact modulus is sqrt(c/a). Extending the positive sum to all1<=a<=c and applying the decreasing integral estimate gives a sum at most2c-sqrt(c)<2c. Restriction to units costs no equidistribution hypothesis. Dividing by phi(c) bounds the mean head by2c/phi(c).

The optional statement requires H and J0 to be the actual conductor-scaled SUMS OF NONNEGATIVE head and preexisting representation radii. Each is at most2^-63. A small transformed error caused by cancellation would not suffice. The complete-error source defines these sums in section2. The stability source lists their tolerances in section3; the author's source ledger locates that source at section4. This is a locator clarification only, with no change to the proof or frozen author.

The contribution of these radii and one admitted regrid to the input mean is at most

    sqrt(c)/phi(c)*(H+J0)+rho*u
      <=1032*2^-63+2^-50<1

on c<=265800, phi(c)>=1 and p>=50. The p50 comparison is a scalar reserve, not a new converter/circuit admission. At the previously admitted converter range it follows immediately; a future lower range must separately supply the error-u adapter. Exact assembly has zero new error, and any nonzero preexisting error must be included in J0. A regrid charged here must not be charged again in that same representation sum.

It follows that the augmented mean is strictly below Pstar+2+2c/phi(c). Polynomial actual-function error is not added to this center magnitude; it remains in its alpha radius. The seven-smallest-prime product is510510>265800. Thus c has at most six distinct prime factors, and the finite totient product gives c/phi(c)<=1001/192. This uses the ordinary elementary prime-ordering and totient facts, not a new prime scan or assumed factor metadata. The uniform bound is17801/96<186 and the final-only bound16841/96<176. A conductor spanning earlier bands cannot use the final-only cap throughout.

## 7. Scope and independent evidence

The mean controls this intrinsic error estimate. It does not control individual buffer magnitudes. All root/data products, partial sums, padded FFT states, exact presums, raw products, round witnesses and setup operands retain their pointwise capacity proofs. Local D and the old global semantic peak guard are still required where those width proofs consume them. No radius acceptance can retroactively justify narrow unchecked arithmetic.

All fourteen author/source pins were independently matched. The new checker uses fixed formal polynomial identities, scalar coefficient fixtures and rational source reserves. It does not import or execute the author checker and reads no assignment or inventory. There was no evaluation of inputs, functions, coefficients, roots, transforms, primes or zeros; no build, proof emission, declaration or source edit.

The initial checker `integration/review_mean_input_transform_error_20261111.py`, SHA256 `80E5F2F41F22ABB35F5B18131D534EB87739D096D5F1199073F0CAA423EB06D5`, had an unmatched parenthesis. Python rejected it before executing any checks or creating a receipt. It remains preserved. The successor `integration/review_mean_input_transform_error_20261111_v2.py`, SHA256 `96024BE567BFDFAF6E0952540D8EB937261C58185CE56EE64BA07278F4840C0B`, changes only that syntax into named left/right formal expressions. Its first execution passed61 checks.

The exclusive5430-byte receipt `integration/review_mean_input_transform_error_20261111.json` has SHA256 `ED45EE43644FA99F3ADEA507221D77D5266A6F2564100C54ED94E9A4722DB420`. The quantified arguments above establish the theorem; the fixtures do not substitute for them.

The bounded result is a sound conditional mean-input theorem for the legacy circuit constants and a conditional full-P20 source join. It establishes no selected precision, cheaper width, numerical sign, completeness success or production saving.

## 8. Frozen input ledger

Paths are relative to `work/qrh-campaign/agents`.

- `audit/LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md`: `6F856467F0EC3B1BD4EDA6817FC71BCA3DC6DA71F32BF96F3AE85E8D034032BA`.
- `audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md`: `96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D`.
- `audit/REVIEW_MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md`: `1268986720865E47569FC5E568546194C0A61EDC9AE80CDD78502CDC77385537`.
- `audit/SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md`: `03680BE7C2518CA0065244E840DC64203D529E26BE2E867F4C31A37652009904`.
- `independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md`: `FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9`.
- `independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md`: `412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7`.
- `independent-feasibility/MEAN_INPUT_TRANSFORM_ERROR_RESEARCH_2026-11-11.md`: `160E25353C24850DCA6D167AA5D85D54579FED642BAB3A1E55CC6AD0358C2AF6`.
- `independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md`: `B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266`.
- `independent-feasibility/mean_input_transform_error_20261111.json`: `13444563FC4A24DD4508BB17285665A0FE6F26A12AD8CEABD7499ED2A533E764`.
- `independent-feasibility/mean_input_transform_error_20261111.py`: `23C2DDD5E4264FE87BDA21C9892C0F688561C5FB924035004C1284EE19ACCE93`.
- `integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md`: `09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA`.
- `prime-estimates/REVIEW_SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md`: `1E9D3CDE80AB9BD78FD250E9404BF9936AA782F92CD9D2BDCC799D6558869328`.
- `zero-sum/MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md`: `C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01`.
- `zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md`: `4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4`.
