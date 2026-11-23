# Supplied-root production, CRT and payload costs

2026-11-11. Paper and exact integer size accounting only. No candidate, modular-power, primality, CRT, analytic-function or benchmark evaluation was performed. The new scalar receipt evaluates integer capacities and exponent schedules, not roots. Previous reports are unchanged.

## Decision-relevant result

Retaining the root during a deliberately scheduled native candidate test avoids a second exponentiation after success. It does not eliminate the original search or test. For a full q-factor batch, a balanced CRT construction costs q-1 modular inversions at increasing widths; those inverses can be shared by every root/inverse coordinate. The accepted checker need not verify the producer's CRT derivation.

The root payload stays near 11.22 bytes per rung even as q grows from 8 to 64. Batching chiefly changes arithmetic size and CRT work, not root bytes. At B=10^16 in the fixed geometry of the portfolio report, q=32 gives a 2.44375 TB Proth-root format or a 4.7625 TB common smooth-root format, compared with 0.2 TB for compact single-base offsets. Separate smooth-factor roots reduce checking arithmetic from 184--188 to 70--72 modular products per batch, but raise the corresponding format to 27.2 TB. These are exact capacities of specified raw fields, excluding headers and proof objects, not measurements or forecasts of compressed data.

The practical comparison must therefore include generation, CRT, I/O, parsing/elaboration, kernel arithmetic and memory. No universal fastest format follows from these counts.

## Retain the successful local root

For Proth p=k*2^45+1, the native test checks a^(k*2^44)=-1 modulo p. A leading-one left-to-right binary schedule first computes x=a^k and then performs 44 squares. Retain x before those squares. This has exactly the same square/multiply count as that binary schedule on the full exponent, because its final 44 binary digits are zero. It requires a spare bounded residue and copying/ownership discipline, not a second exponentiation.

This is a proposed producer refactoring. Actual LadderHints.lean:30--34 calls Nat.powMod on the full exponent and returns only a Bool; the present interface does not export x. Do not claim that an opaque library call automatically retains the desired value. A right-to-left or windowed exponentiation may use a different schedule, so its timing must be compared after the producer change. The untrusted producer may change freely provided the independently checked root condition is unchanged.

For the smooth portfolio, schedule x=a^k first, then y=x^m and the fixed complement tree from the accepted portfolio report. Keep x and, on success, the local inverse v of the product of its ten odd-factor leaf-minus-one values. A test already computing that inverse can retain it. A gcd-only test must additionally obtain a Bezout coefficient; do not price this as free merely because both algorithms use Euclid. Rejected bases/candidates still consume all work done before rejection. A successful candidate does not imply the first attempted base succeeds.

For direct q=1 supplied-root records, retained x is already the final X. For common smooth-root records, retained local v is already the final inverse when q=1. No CRT is needed in that case.

## Actual bit-width envelope

All consumed candidates satisfy 1<p<=N=10^27 and are odd. For a node containing s factors use

    b(s)=bitlength(N^s).

This is a verified uniform upper bound, not the observed width of an unknown product. An actual implementation should use the actual product's width when known. The exact cap is slightly sharper than 90s:

| q | Product/root bit cap b(q) | Bytes per one padded root field | Raw square bit cap 2b(q) |
|---:|---:|---:|---:|
|1|90|12|180|
|8|718|90|1436|
|16|1436|180|2872|
|32|2871|359|5742|
|64|5741|718|11482|

The powers N^s here are size metadata. No putative candidate or residue was evaluated. Ordinary 64-bit/128-bit native-primality timings do not describe these 90-bit leaves or the much wider product operations.

## Product and CRT trees, with widths attached

For q a power of two, level j combines s=2^j factors in q/s nodes. Its child modulus width is w=b(s/2), and its parent width is z=b(s). The exact schedule is:

1. Form the parent modulus C=A*B. This is one multiplication of two at-most-w-bit operands, with a pre-reduction product of at most 2w bits and a sharper final bound z.
2. Compute and retain alpha=A^(-1) modulo B, after checking gcd(A,B)=1. This is one modular inversion at at-most-w-bit modulus size, plus any needed A modulo B reduction. An inversion is not counted as one multiplication or assigned a time.
3. For each coordinate with child residues u<A and v<B, compute t=((v-u) mod B)*alpha mod B and X=u+A*t. The signed difference has at most w+1 bits; the modular product has at most 2w bits before reduction; the lift product A*t has at most 2w bits; the resulting X is automatically in [0,AB).

There are q-1 product-tree multiplications, q-1 CRT inversions, and, per coordinate, q-1 modular products plus q-1 lift products and additions. Remainder operations, subtraction, conversion and inverse production are additional operations, not hidden inside a claim about multiplication counts. Each level's widths and node counts are in the receipt.

For Proth, one coordinate is enough: the common root X. For common smooth-root acceptance there are two: X and an aggregate inverse V. The same alpha values serve both. Indeed the global odd-factor polynomial evaluated at X reduces to the local polynomial evaluated at each x_i. CRT-lifting the retained local inverses therefore produces V with the required global inverse property. This avoids computing a new extended gcd at the full product width, although the checker still checks the actual global inverse multiplication.

For r separately supplied root groups and one aggregate inverse there are r+1 coordinates. In particular eleven factor-specific roots require twelve coordinates. The q-1 CRT inversions are shared, but the coordinate-specific modular products and lift products are multiplied by twelve. It is incorrect to charge the common-root CRT once and reuse that price for all twelve coordinates.

An optional top-down remainder tree verifies X modulo every leaf. It uses two divisions per internal node: parent residue of at most b(s) bits by a child modulus of at most b(s/2) bits, for 2(q-1) divisions per coordinate. Such a check can detect producer implementation errors, but it is not required by the final common-root theorem and should not be inserted into checker cost without a reason. A producer may instead run the same final modular condition that the consumer will check.

No CRT construction appears in the acceptance premise. The checker binds M to its actual candidate product, checks all factor bounds and coverage labels, and checks the supplied global powers/unit identity. A malformed CRT output simply fails those checks. This separation removes a large proof trace but does not remove producer computation or payload.

## Noninvertible and repeated inputs

An ordinary CRT combine fails when gcd(A,B)>1. Do not silently replace the product by an lcm and then consume it as the original M. Distinct successful prime candidates give coprime moduli, but the generator must not assume its untested candidates are primes. A nontrivial gcd can reject/reselect candidates or expose a factor for diagnostics. Deduplication must retain a checked map from every requested occurrence to the retained candidate and still prove every interval/gap obligation.

For repeated factors, local roots modulo p alone do not automatically produce a root modulo p^e. Either deduplicate, prove compatible prime-power lifting, or reject that production path. The actual product-root acceptance remains sound even with repetitions if its stronger congruences pass. The fixed disjoint windows in the portfolio report exclude repeated successful candidates, while a more general batching interface must state its rule explicitly.

CRT coefficients can be reused for several coordinates or retries on the same chosen moduli. A changed candidate changes the product path and relevant inverses; the old CRT tree cannot simply be reused. A bounded producer should distinguish retained-candidate failures from a completely new batch and count those costs separately.

## Raw-field formats at the proposed cutoffs

This table uses the already stated fixed windows S=B/2,D=B/2-2 and K=N/S. It is not an adaptive-chain rung count. For each rung encode t=k_max-k in its selected F lattice, with k_max=floor((iS-1)/F). The field bounds are checked on decoding. The maximum offsets need 4,5,7,8,9 bits respectively for the five B rows, both for Proth and for the smooth portfolio. Full batches have q roots' worth of product capacity, but only one X field per batch.

The smooth format additionally reserves a three-bit lane tag per rung. Stable filtering of an original-order tag stream can reconstruct same-F groups without separately listing every position. A bounded macroblock and deterministic batch split must still be specified and proved; group reordering cannot drop a required slot. A mixed general-prime branch needs its own certificate payload, absent from the table.

For full q=32 batches, the following are exact sums of raw allocated fields in decimal TB, where 1 TB=10^12 bytes:

| B | K | Compact one-base positions | Proth X+positions | Smooth X+V+positions+lane tags | Eleven factor roots+V+positions+tags |
|---:|---:|---:|---:|---:|---:|
|10^15|2*10^12|1|23.4375|46.625|271|
|2*10^15|10^12|.625|11.84375|23.4375|135.625|
|5*10^15|4*10^11|.35|4.8375|9.475|54.35|
|10^16|2*10^11|.2|2.44375|4.7625|27.2|
|2*10^16|10^11|.1125|1.234375|2.39375|13.6125|

The adjacent JSON gives every q in {1,8,16,32,64}. A single root field costs 12 bytes per rung at q=1, 11.25 at q=8 or 16, and 11.21875 at q=32 or 64. Thus raising q from 32 to 64 saves no bytes under these caps, while increasing the operand widths and changing CRT work.

All rows assume complete batches and the indicated branch for every rung. For mixed lanes use the actual batch sizes n and sum ceil(b(n)/8) per coordinate. At worst one coordinate uses 12K bytes when every batch is a singleton. For example, at B=10^16 the smooth total rises from 4.7625 TB to at most 5.075 TB under this field accounting; the eleven-root total rises from 27.2 TB to 29.075 TB. Framing, lengths, hashes, parsing limits, source imports, expanded proof objects and general-prime certificates are extra. No entropy/compression assumption or observed byte volume is implied.

For a six-base compact format, add three bits per rung to its position field, unless another proved tag encoding is used. The current historical source packs eleven offset bits per rung; at the same K this is 11K/8 bytes, but its actual old windows and rung count differ. Comparing old eleven-bit input against new root files without matching coverage geometry would be misleading.

## Factor-specific roots: less checking, more production and bytes

For each q^e exactly dividing F, supply x_q. Set y_q=x_q^(q^(e-1)); require y_q^q=1 and that y_q-1 is a unit. For q=2 use y_2=-1 instead of the last power/unit test. Aggregate the ten odd-q unit conditions into one inverse. Every prime divisor r of a consumed candidate then has each q^e dividing r-1, so F divides r-1. The same strict square bound proves primality.

Using leading-one binary powers for q^(e-1) followed by q, the six fixed F choices cost:

| m | Squares | Other power products | Aggregate-unit products | Total |
|---:|---:|---:|---:|---:|
|160|38|22|10|70|
|162|38|23|10|71|
|165|37|25|10|72|
|168|37|24|10|71|
|175|37|25|10|72|
|180|38|23|10|71|

These are operations at the actual product modulus width. They compare with 128 squares and 56--60 other products for the one-common-root complement tree, including its unit check. They do not prove a timing ratio. In exchange, this format carries eleven roots plus one inverse and runs twelve CRT coordinate constructions.

One producer route starts from a successful common F-order root x and derives x_q=x^(F/q^e), using a complement tree on the eleven full prime powers. That is extra producer arithmetic, even though the common x may already be retained. Another finds independent factor-specific roots a_q^((p-1)/q^e), with explicit modular tests. It may avoid the requirement that a single chosen small base succeeds for every q, but has more exponentiation/search state. No success-frequency or fastest-production claim is made. Grouping prime-power factors into an intermediate number of root witnesses is a separate optimization being studied by major_constants; the r+1-coordinate accounting above applies to it.

## Matched break-even test, without performing it

For the same complete candidate set and coverage, record three layers separately:

1. Producer work: filtering, failed candidates/bases, successful local tests, retained roots/inverses, all CRT levels and retries. Keep operation widths and actual batch/lane sizes.
2. Representation work: exact bytes, parsing, proof construction, imported constants and retained memory. Packed integer field sizes do not predict Lean object or proof DAG size.
3. Acceptance work: product binding, bounds/coverage, modular arithmetic and kernel/proof checking under equal trust. A native modular test, Lean kernel reduction, an ordinary MM0 arithmetic proof and a newly verified computation extension are different acceptance paths.

The root format wins end-to-end only if its saved acceptance work exceeds its added generation, CRT, I/O and representation work. Root retention can remove duplicate exponentiation, and a common product-root test can remove per-rung exponentiation from the checker, but neither erases the root bytes or original successful/failed search. Compare q=1 first, since it removes CRT completely and uses narrow arithmetic. Then compare q=8,16,32,64 with actual product sizes; large q is not justified by the negligible byte change alone.

Logical storage can be counted without claiming resident memory. If all product-tree values are kept, the receipt sums q*b(1)+sum_j(q/2^j)b(2^j) bits, and separately sums the CRT inverse-value widths. A coordinate tree has a similar value-volume bound. A streaming implementation may discard lower levels; a proof-producing implementation may retain much more. These are value-bit capacities, not an RSS estimate or a bound on reduction sharing in Lean/MM0.

## Source and receipt pins

- LadderHints.lean, actual current Bool producer: 3AA4E7D3357E5D544288249ED13616B3D9F9151C21D1DAE82AEFD7355C53505D.
- work/qrh-blueprint/COMMON_ROOT_PRIMALITY_CERTIFICATE_2026-11-11.md: 8D4E43987A576E7B18D849E94CB613A4F16C6E15B65DFE4204D1905C3D5FDF95.
- SMOOTH_FACTOR_LADDER_PORTFOLIO_2026-11-11.md: 5C49B39D44D432A71F7A5F45E924F6C76E9E173666DB6301EF0469F1AAD5F59A.
- Independent portfolio review: audit/REVIEW_SMOOTH_FACTOR_LADDER_PORTFOLIO_2026-11-11.md, A51F4408037C3A49A0B59D3144113D8B01D186915444CD7A215ED98443CBBA1E.
- supplied_root_payload_sizes_20261111.py: B7FC92CB751B1F884F84877981FDAA33F5EAC10CEF714DAD023E3224266739FC.
- supplied_root_payload_sizes_20261111.json: D871072D7A8B8675D6EEE45C9E5068F358CFE6DEF7138670E9F4F27ABD7E5F7E.

The scalar script exited zero. No root generation, candidate test, CRT execution or benchmark was run.
