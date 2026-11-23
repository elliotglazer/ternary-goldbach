# Efficient prime certificates with an upfront checker investment

The recommended general-purpose subsystem is **partial-factor Pocklington with a shared checked small-prime table**, a deduplicated certificate DAG for remaining large factors, and native Montgomery modular arithmetic. Full Pratt certificates remain a simple fallback. Prefer smooth anchors when they are cheap to find; do not require them solely to save a fraction of a microsecond in validation.

This task produced a working native validator and measured complete certificate validation, including binary parsing and DAG checks. It did **not** prove the C implementation correct or add a verified instruction to MM0. The measurements below describe the algorithmic execution target for the proposed new checker. They are not stock-MMB verification rates. The earlier 55 ms Lean result is not a lower bound on this architecture.

## Measured comparison

The input is the existing eight-pool fixture of 4,096 anchor occurrences, containing 4,055 distinct primes near 2e18 and 4e18. The full shared Pratt graph contains 17,649 prime nodes. Each timed run reparses the binary certificate and checks all required nodes and roots. Five runs of twenty complete replays were measured with Linux `CLOCK_PROCESS_CPUTIME_ID`, under Docker Desktop's WSL environment on the same Ryzen 9 8945HS host. File reading precedes the timer; parsing, allocation, bounds checks, arithmetic, factor lookup, and root validation are inside it.

| Certificate strategy | Validated nodes per batch | CPU microseconds per distinct anchor | Montgomery products per anchor | Bytes per anchor |
|---|---:|---:|---:|---:|
| Full shared Pratt | 17,649 | 5.293 | 512.39 | 273.03 |
| Partial Pocklington, recursive graph | 16,386 | 2.842 | 276.02 | 157.71 |
| Partial Pocklington, checked small-prime cache | 7,345 | **1.672** | 189.08 | **75.10** |
| Smooth anchors only, checked cache | 1,572 | 1.163 | 139.65 | 49.63 |
| Cached partial Pocklington, supplied inverse witnesses | 7,345 | **1.323** | 189.08 | 94.49 |
| Smooth anchors with inverse witnesses | 1,572 | 0.985 | 139.65 | 64.40 |

The inverse variant was already running when the report was requested and is included as a completed optional comparison. It replaces a gcd by one checked modular inverse multiplication. It adds eight certificate bytes per selected factor. It is a reasonable speed/size tradeoff, not a required change to the recommended architecture.

The cached partial-Pocklington runs ranged from 1.485 to 1.781 microseconds per anchor. Inverse-witness runs ranged from 1.294 to 1.355. Those spreads are repeatability observations on one small in-memory cohort, not campaign confidence intervals.

The cache was **not an unproved prime oracle**: each process first validated full Pratt certificates for all 10,304 small primes needed by this fixture. That setup took approximately 8 ms and is reported separately. The current cache uses a sorted array and binary searches; it is not the entire 537 MB source bitmap. A future bitmap-backed lookup has different locality and must be measured separately.

The final C binary and an independent Python-integer validator accepted all six positive cases and rejected fifteen malformed cases. The rejected cases include a corrupted header, truncation, trailing bytes, an unknown root, base one, zero exponent, self-reference, composite factor, wrong remainder, insufficient factored part, excessive counts, invalid cache, and incorrect inverse witnesses. These tests are evidence about this prototype, not a formal correctness proof.

Raw evidence is in `native-prime/results.json`, `native-prime/cases.json`, and `native-prime/reference-results.json`. The source, binary, input and build-command hashes are recorded there. The current input fixture SHA-256 is `e1abf0b7a80c5dcbe872ffa38e444e2023d2e3e3338a8504e9f543dc1f53e0a5`.

## Exact mathematical acceptance rule

For a node claiming that n is prime, accept n=2 directly. Otherwise require:

1. `2 < n <= 4e18`, with n odd.
2. Distinct, strictly increasing primes q_i, already certified, and positive exponents e_i.
3. `F = product(q_i^e_i)`, `n-1 = F*R`, `R >= 1`, and `F^2 > n`.
4. A common base `2 <= a < n` with `a^(n-1) = 1 mod n`.
5. For each selected q_i, `gcd(a^((n-1)/q_i)-1,n)=1`.

The inverse-witness variant replaces condition 5 by a supplied `0 < v_i < n` and

    (a^((n-1)/q_i)-1) * v_i = 1 mod n.

The common base is an efficient sufficient condition. General Pocklington permits different bases for different factors; such a fallback can be added without weakening the conclusion. No factorization of R is required, and no assumption that F and R are coprime is needed for the stated full-exponent test.

To see why the criterion suffices, take a prime divisor r of n. The order of a modulo r divides n-1. Condition 5 says it does not divide `(n-1)/q_i`, so its q_i-adic valuation is the full valuation in n-1 and hence at least e_i. Therefore F divides that order and divides r-1. Every prime divisor of n is at least F+1, which exceeds sqrt(n); a composite n would have a prime divisor at most sqrt(n), a contradiction. This is a PA-finitary argument. The computational-certificate approach is established in [Grégoire, Théry and Werner, *A Computational Approach to Pocklington Certificates in Type Theory*](https://www-sop.inria.fr/members/Benjamin.Gregoire/Publi/pock.pdf); the present implementation still needs its own formal proof.

The exact checker theorem to establish is:

    TableSound(T) and CheckDAG(T, bytes) = Accepted(roots)
      imply every p in roots satisfies
      p >= 2 and every positive divisor of p is 1 or p.

`TableSound` means that every positive table entry denotes an actual prime. It must be proved once by a certified sieve or checked certificates. It cannot be replaced by a hash, a successful probable-prime test, or an unverified native table build. The theorem includes parsing, every bound, the DAG order, arithmetic overflow conditions, and the exact root list.

## How the native arithmetic avoids an instruction-sized proof trace

For one node, compute `a^(2^j)` in Montgomery representation once and reuse the squaring ladder for all exponents. The measured cached strategy performs only 4.235 exponent selections per anchor after sharing; smooth anchors need 2.847. Failed base searches and rejected producer candidates are absent from the certificate.

Let R=2^64 and let n be odd with n<2^62. With `n'=-n^-1 mod R`, Montgomery multiplication computes

    t = x*y,
    m = (t mod R)*n' mod R,
    u = (t+m*n)/R,

then conditionally subtracts n. The implementation uses unsigned 64-bit limbs and a 128-bit intermediate. Since x,y<n<2^62, `t+m*n < 2^127`, so this intermediate does not overflow. The returned value is below n and represents `x*y/R mod n`. Six Newton steps compute the inverse modulo 2^64; bounded doubling computes the Montgomery constants without a 128-bit division routine. These claims are explicit verification obligations for the new native checker.

The inverse-witness path checks the unit condition while still in Montgomery form. If x is `a^e*R mod n`, subtract the representation of 1 to obtain `(a^e-1)*R`; multiplying that by the ordinary witness v gives an ordinary residue that must equal 1. This avoids both Euclid's algorithm and a separate conversion.

The C implementation is roughly two hundred lines of bounded parser and arithmetic code. It currently relies on Clang's native unsigned-word semantics, the compiler, and machine execution. A PA theorem about the abstract checker alone does not certify this executable. For the recommended new-checker contract, either formally verify that implementation path or explicitly include the audited implementation in the trusted checker boundary. Do not claim the existing MM0 compiler has already discharged that obligation. Under the separate **stock MMB contract**, concrete arithmetic must still be exported as ordinary MM0 proofs; the measured native rate supplies no arbitrary multiplier or automatic forecast for that export.

## Partial factors, small-table reuse, and smooth anchors

The generator orders known prime powers by descending size and stops when their product exceeds sqrt(n). This is a simple heuristic. It need not minimize total DAG cost: a slightly larger factor set already present in the cache can be cheaper than one enormous factor with a long certificate chain. A production implementation should minimize estimated *additional* checked work against the current cache. Full Pratt is the fallback when partial-factor search is inconvenient.

The shared source table extends through

    B = 2^33 + 2^20 = 8,590,983,168.

This exceeds sqrt(4e18). Thus n-1 can have at most one prime factor exceeding B. For an anchor whose entire n-1 factorization lies below B, every factor-primality obligation is just a sound table lookup. The native fixture has **1,572 such anchors among 4,055 distinct anchors, 38.77%**. To exceed sqrt(n), their selected factor counts are 295 with one factor, 1,227 with two, 46 with three, and four with four: mean 1.847.

This observed frequency is not a theorem about every future block or a guarantee that a fixed interval contains enough smooth anchors. Existing coverage experiments used ordinary prime pools; replacing them with smooth-anchor pools requires new coverage checks and may alter the retained-mask count.

Smooth-only certificates save about 0.5 microseconds per anchor relative to the ordinary cached gcd strategy. Screening for smooth anchors may require about 2.58 times as many candidates at the observed frequency. The existing native producer spent 0.84375 CPU seconds producing all 4,096 full-factor certificates, approximately 206 microseconds per already-found anchor occurrence. It did not include finding the anchor prime pools. That producer cost is much larger than the validation saving. Therefore smooth-only selection is primarily a certificate-simplicity and cache advantage unless a cheap producer strategy demonstrates a total-time win.

## Resource and campaign implications

For 238,418,579,456 anchors, direct linear extrapolation of the measured cached-Pocklington validator is **0.0126 core-years**, about 4.6 core-days. Its inverse variant is about 0.0100 core-years. Full shared Pratt is about 0.0400 core-years. These are conditional native-checking totals only. They exclude proof-tool construction, implementation verification, candidate search, factorization, disk I/O, coverage checking, and final theorem composition.

The old producer's 206-microsecond average would itself extrapolate to about 1.56 core-years for already-found anchors, subject to different sharing and factorization tails at scale. It is a useful production anchor, not a guarantee. Partial factorization may reduce it; smooth-only screening can increase it. No additional empirical MM0 slowdown factor has been applied.

The cached gcd certificates average **75.10 bytes per distinct anchor**, including graph sharing and root references, or about **17.91 TB** at campaign scale. The inverse variant uses 94.49 bytes, about 22.53 TB. Smooth gcd certificates use 49.63 bytes, about 11.83 TB. These are compact certificates, not expanded stock-MMB proof objects. Deduplication savings depend on shard size and cache policy.

The prototype bounds each input to 16 MB, 100,000 nodes and 100,000 roots, and each node to at most 64 factors. Exponents are stored in one byte and restricted to integers 1 through 62. Numerals are bounded by 4e18. Factor products are checked before multiplication; node values must strictly increase, and factor references must denote earlier checked primes or checked cache entries. Every advertised root must be found. Truncation and trailing data are rejected. The bounded loops and integer ranges bound runtime even on malformed inputs; a production service should additionally enforce wall/CPU budgets and fail closed on exhaustion.

Keep the full source prime bitmap shared and immutable, around 537 MB before formal metadata. A current 4,055-root shard needs only 7,345 non-table prime nodes in the cached mode. Stream shard certificates and retain only the bounded current large-factor DAG; do not retain all 2.38e11 roots in memory. Cache eviction may discard already-proved facts but must never manufacture them. The abstract checker invariant, and the implementation of that invariant across shards, belong in the formal soundness interface.

## Artifacts and remaining work

`native-prime/prepare.py` derives the six certificate cases from the pinned fixture. `validate.c` checks them; `run.py` builds it using the existing read-only Clang/musl toolchain, performs all measurements, and rejects malformed certificates. `reference_check.py` independently checks the same inputs with Python integers. No dependency library was modified.

Before using the rates as an accepted-proof forecast, prove the mathematical checker theorem, formalize the word-arithmetic and parser refinement, resolve the native-checker trust contract, and measure the real shared-table access pattern. This is now a concrete implementation/proof interface with measured arithmetic cost; it is not a completed MM0 proof subsystem.
