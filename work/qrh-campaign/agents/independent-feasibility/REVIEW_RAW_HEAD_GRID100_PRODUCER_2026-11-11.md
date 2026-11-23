# Independent review of the raw-head grid100 producer

2026-11-11. PASS at bounded paper/source and fixed-scalar scope, without correction. This review binds `integration/RAW_HEAD_GRID100_PRODUCER_AUDIT_2026-11-11.md`, SHA256 `FBBB538E0FC72865A9B4815A048992644AA0563AFC2DEA970FB9C3B4F7596EEE`, its selected v2 script `19883CD951723E35D0CAF28DBEFDFBE3D727C4C186862038BAD58FFAE3E8E129`, and receipt `503719183AA0A5A580C11E54ED6E394EF9093A11379B1CE462C65E1A907B3911`.

I read the complete frozen author and selected script, checked all17 prerequisite pins, and independently reconstructed the error and width bounds. My separate checker imports no author code and passed56 fixed source/rational checks on its first run. It evaluates no logarithm, root, cis, head, transform, prime or zero, and performs no conductor or query inventory. No build, declaration, proof emission or frozen edit occurred.

## Actual source and normalization

The complete-error contract96063365 section2 fixes the raw vector as the shifted Hurwitz polynomial plus `(a/c)^(-s)`, followed by the positive unnormalized character transform and the external factor `c^(-s)`. The shared EM source1E1D5099 sections2-3 instead forms powers at `x=n+1+alpha>=1`. Those internal head terms do not produce the separate raw head at `0<a/c<1`.

I checked the historical C++ consumer at343-351,697-740 and803-810. It binds an external q-it table, forms the positive conductor phase times sqrt(c), then the negative numerator phase divided by sqrt(a), before adding the shifted polynomial. This supports the claimed schedule boundary but is not certified numerical evidence.

For the new integer-power definition, ordinary positive-real logarithm identities give

    c*conj(B_c(t))*B_a(t)
      =sqrt(c/a)*cis(t log(c)-t log(a))
      =(a/c)^(-1/2-it).

Thus neither an extra conductor factor nor a sign reversal is missing. The downstream factor remains `c^(-s)`. The integer pool includes every needed numerator and conductor in the declared domain. Starting all states at zero is a deliberately conservative producer schedule, not a count of a minimal requested set.

The grid is exactly `t=j*5/64`. The domain through7000 needs89600 steps, below the proved90000. Negative grid points may conjugate these head states, but the completed negative-character channel still needs its separate phase/damping adapter. Non-grid repairs are outside this recurrence. These restrictions are explicit in the author.

## Elementary setup and propagated error

The old elementary leaf0541F20C was limited to3389. The author does not silently enlarge it. It proves the new range reduction with `k<=18`, `1<=y<2`, and pays19 copies of the atanh approximation error, including the shared unfinalized log2 cache. I independently bounded the actual45-term tail by

    2*3^(-91)/(91*(1-1/9)) <2^-135.

Together with the existing finite Horner error `7*2^-137/4` and final real round, this is below the displayed `(949/2048)*2^-128`. The exact phase has magnitude below2. Consequently the small-step cis construction needs no approximate-pi reduction or period witness.

The normalized exponential Horner circuit retains72 rounded affine updates and exact terminal1. I checked its73-term tail directly using `2*4^73/73!<2^-124`, and bounded the error propagation by81 without evaluating exp(4). The total log-phase, analytic-tail, inner-round and final-grid122 errors are below `2^-120`. Coordinate-nearest rounding supplies the stated Euclidean error bounds because its norm error is strictly smaller than one coordinate grid unit.

The inverse-root witness is valid also at x=1 and exact dyadic roots. Its strict upper inequality uses m+1, so equality on the lower side causes no endpoint defect. It supplies a real grid98 center, embedded exactly into grid120. A producer must still find m and prove both inequalities.

For the persistent state, the correct recurrence is

    e_(j+1)<=(1+eps)*e_j+eps+u,
    eps=u=2^-120.

Both terms involving the uncertain step are retained. A finite geometric majorant gives the independently checked bound

    [2^-98+2*90000*2^-120]/[1-90000*2^-120] <2^-96.

This also verifies the author's looser factor2 bound. Exported heads and transform regrids must not overwrite these persistent states. Initializing at a later time would require an additional initializer and error proof.

The exact conductor multiplication has error at most `c*delta`, where `delta=2^-96`. The two shared state errors can be correlated; the triangle bound still gives

    e_head<=c*(2delta+delta^2)+2^-100<2^-75.

The final term accounts for an actual grid100 round. It is not inferred from a small numerical enclosure. The optional reuse of B_c for the external `c^(-s)` factor meets the separate `2^-84` tolerance, while the final scale multiplication remains paid.

## H, J0 and the existing input contract

The actual nonnegative per-input radii satisfy

    H=c^(-1/2)*sum e_head,a <=633*2^-75<2^-63.

Each raw head center has norm below517. The admitted full-P20 polynomial center has norm below173 with exact grid100 export, so exact common-grid assembly has norm below690 and J0=0. These are compatible with the existing mean/runtime magnitude prerequisites. This review supplies no new mean-error theorem or precision assignment.

The later input regrid is charged once through its own adapter. It is not absorbed into H, and the polynomial's source, shift and evaluation errors are not charged again. If assembly or representation changes are inexact, J0 must be restored and checked. Head enclosures and their sums must be bound to the actual vector, not merely a nominal common radius.

## Capacities and operation accounting

The author distinguishes accepted operand bounds from the unverified result of a new gate. State and step coordinates have122 and124 signed bits. The exact c multiply first uses its141-bit signed raw capacity; only after its proof and range check may the cached C coordinate use131 bits. This avoids deriving a small raw multiplication width from its desired final residual.

For recurrence, the two real-product magnitude widths sum to244 bits. Combining them needs245 magnitude bits, hence246 signed bits; the round-witness addition fits247 signed bits. For the head, the corresponding figures are251 magnitude bits per product,252 for a combined coordinate,253 signed for that coordinate, and254 signed for the witness addition. The round discards140 bits from grid240 to grid100. The source norm bound establishes representability of the output; the proposed output still needs its own range and signed equality proof.

The signed nearest witness `N+2^139=Q*2^140+r`, `0<=r<2^140`, correctly covers negative inputs and the selected tie convention. The recurrence uses the same rule with shift122. No proof of a tiny residual is used to shrink either side before its arithmetic check.

I reproduced all local unsigned macro entries: recurrence5252 product/378 addition units, conductor cache494 product units, raw head5572 product/390 addition units, and exact assembly58 addition units. These are padded arithmetic schedules under the declared byte templates. They exclude signed/range/shift, numeral, lookup, theorem, serialization and generation costs. They are not commands or timings. The64I-byte dense state/step payload is likewise only raw coordinate storage.

The cost variables I, Jstar, N_C and N_R remain separate. Conductor multiplication is once per conductor/height and actual cache lifetime, not once per residue. The source EM reciprocal/head scales are another computation and cannot pay this raw-head product. The old O(v) head placeholder must be replaced, not charged in addition to the same newly explicit category. No overlap with existing seed B objects may be deducted without identical argument, height, precision, radius and lifetime evidence. The report correctly retains that restriction.

## Evidence and remaining boundary

The independent script `review_raw_head_grid100_20261111.py` has SHA256 `E286A8B3171DA9B7410763EF377E33E87F01ECBD2E7A61F8DF4591744BE4DE6C`. Its5282-byte receipt `review_raw_head_grid100_20261111.json` has SHA256 `88A1AB6D428AD9B07B62CE1D46B5DCBBB7774C46EC3FD2F9705308E42D5FA9A6`. It records all17 source pins and56 checks. The initial author script's failed strict173+517<690 assertion is disclosed; its preserved successor checks equality, while strict center bounds prove the needed strict690 bound. I found no further correction.

This is a new conditional producer composition. The ordinary analytic lemmas, elementary certificates, arithmetic and representation libraries, actual checked states, complete query schedule and cache transport still have to be implemented and supplied. No successful sign, count, runtime, production memory bound or end-to-end closure follows. The original principal, small-family and finite-coverage obligations remain unchanged. As requested, this review ends the bounded task without another research branch.
