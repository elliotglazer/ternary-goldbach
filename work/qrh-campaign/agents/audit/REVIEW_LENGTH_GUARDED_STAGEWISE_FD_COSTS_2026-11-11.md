# Review of length-guarded stagewise FD costs

2026-11-11. PASS at the stated conditional mathematical and arithmetic-template scope. No correction requested. This review does not establish an aggregate saving, a method winner, an implemented checker or a spectral certificate.

The frozen author is `major-constants/LENGTH_GUARDED_STAGEWISE_FD_COSTS_2026-11-11.md`, SHA256 `C41D1BA7E981F3317CECD08E0AAFB5B326E34368DFC7A567AE87A4CE32E0299A`. Its script is `length_guard_fd_costs_20261111.py`, SHA256 `D1D3DC304F17B1FC9314BAF789FD6E2F16001F7DC893176CC271C9D107AA972A`, and receipt SHA256 is `5388F1D02DBA2A7BD4F921DAAE55AA4BEEAFC3217E6DC0C7F65DFBECC8A2CA50`. I read the complete note and script without importing or executing the author script.

## Exact guard and source attachment

The source `moebius/platt-reuse-sources/int-l-func5.11.cpp:705–735`, SHA256 `3D9B2B23B35129899048C23806AA42A4F2B08BE10304611AC9E1C913300FE852`, visits coprime numerators and rounds the lattice coordinate upward only when its fractional part exceeds one half. This identifies the intended ties-down convention. It does not certify the historical floating-point decisions. The new exact integer rule supplies that separate obligation.

For `k=floor((2Fa+c-1)/(2c))`, integrality gives

    (2k-1)c+1 <= 2Fa <= (2k+1)c.

Subtract the lower inequality for the first numerator from the upper inequality for the last. For L consecutive numerators this gives `2F(L-1)<=2c-1`, hence `F(L-1)<c`. Clipping the interval to `1<=a<c` preserves this implication. Thus L at least 11 proves the strict 10F guard, and L at least 21 proves the strict 20F guard. Equality c=10F or c=20F cannot introduce an extra endpoint through a tie.

A length counts all consecutive physical numerators, not only units. It proves the guard but does not supply unit count U, conductor normalization, anchor parity or cache identity. The author's twelve cells retain those fields. Their even conductors and displayed source-band grid indices lie in the claimed reviewed height domains. This is an existence check for the representative source-band examples, not a new full-family inventory.

## Exact and rounded states

The inherited stagewise review `F8A063A5A1D523D6B804014D8E45245BFCAB686F1C66802423949942AB3136BA` binds actual stored coefficient bounds and direct coordinate-nearest b100 conversion. The current composition preserves that input. It does not replace it with an unproved enclosure of true fine-anchor jets.

For short cells, retaining orders j below `m=min(20,L)` makes every supporting point in-cell. The annihilated-tail bound excludes powers below j. For the longer guarded cells, the sharp finite-polynomial difference bound can support the full initial differences even when an initialization point is outside the cell. This evaluates and bounds the same finite polynomial, not Hurwitz data at an unapproved point. All nineteen degree stages and all twenty coefficient conversions remain.

The long-cell normalized recurrence divides the order-j integer by the proved `2^lambda_j`; its secondary factor is the odd part of j. I checked the common normalization directly as the power of two in `gcd(F,kc,2c)`, independently of the author's parity shortcut. The short-cell schedule deliberately remains unnormalized. The all-cell magnitude theorem is not silently promoted to a new normalized recurrence.

Let `S=sum_{j<m} binom(L-1,j)` and `p=102+bitlength(S)`. Then `S*2^-p<2^-102=u/4`. This controls all retained live orders after exact ascending additions. Accordingly, a stored rounded order uses `E_j+u/4`, and its raw addition uses `E_j+E_(j+1)+u/2`. The receipt includes that error before assigning widths. The initial rounded integer bound also includes its own nearest-round error. The coefficient change, state error and final rounding sum to less than `4u/3+u/4+u=31u/12<8u/3`. Final rounding does not feed back into traversal.

The normalized-to-dyadic initialization is a genuine wide quotient with numerator `E_integer,j*2^(p-100+lambda_j)` and denominator `v'^19`. Only their proved common power of two is cancelled. No wide conversion is replaced by a narrow state addition. At unit outputs, the extra target cancellation is justified separately and is also granted to Horner. The order-zero output contract and inherited mixed-character error allowance remain unchanged.

## Arithmetic accounting

I reconstructed all seven FD ledgers and all three fixed Horner ledgers for each of the twelve cells. The independent check compares every core total, product count, adder count, signed-wrapper occurrence and ordered shift/reference pair.

Initialization counts the old partial-state product, each new coefficient prescale and binary secondary sums separately. Top-order copies are represented by shift-zero/reference terms. Traversal includes nonunit positions and prunes only orders with no remaining dependency. Cold powers are nineteen declared products; treating the first multiplication by one more cheaply would be a different schedule.

The nearest witness `P=qD`, `P+R=X`, `2R+D=W`, `W+g+1=2D`, with nonnegative W and g, proves `-D<=2R<D`. It handles signed ties without a hidden native division oracle. Its core charges one product and three magnitude adders. Factoring D into an odd part and a power of two retains the restoring shift and residual equations. Dyadic output products become explicit shifts. The listed raw capacities cover the product and residual scratch before the smaller final residual is established.

Horner retains nineteen stages, both products at each stage, three nearest-witness adders and its exact coefficient addition. It receives the same target and grid-alignment cancellations. Direct degree-grid coefficients require their own conversion cache; they are not free re-roundings of the uniform b100 object.

All displayed cores match. For example, the L130 rounded core is 500984 versus the specified optimized-Horner core 578306, while L260 gives 753864 versus 653154. Neither comparison is a full-cost result. Actual shift/reference prices, signed/range/representation proofs, source conversion widths, geometry, quotient discovery for generation, storage and library work remain additional. A cache can replace a cold setup only with the same checked object and lifetime. A robust comparison of bounds needs a new upper bound below the comparator's lower bound, as the author states.

## Independent evidence and limits

The reviewer script `audit/review_length_guarded_fd_schedule_20261111.py` has SHA256 `E4ABFBDC2FEE600D3F407F8B080C1C57CFB4C67A9BEDBC2F304151CCBEDB0E00`. Its new exclusive receipt has SHA256 `0A6F3F0F6C620F8F9055AA0720FDEB8F7097177D7DEE16003A37688EE14ABA65`.

It passed 726047 exact checks. These include the twelve complete typed schedule comparisons and a separate bounded geometry test with c from 2 through 129 and F from 1 through 32, covering 64704 nonempty cells and 3686 exact ties. Guarded coefficient kernels were rebuilt using alternating finite monomial sums rather than the author's Stirling recursion. The all-cell kernels were rebuilt from the annihilated tails. All eight embedded source pins and the four direct review pins match.

This was integer/rational metadata and source research only. There were no actual coefficient, function or transform values, prime tests, family production scans, author-program imports, Lean changes or builds. The report admits the stated length policy and conditional schedules. It leaves final arithmetic records, source bindings, actual cost prices, coverage and spectral evidence open.
