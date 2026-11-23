# Adaptive certificates and the current cost comparison

2026-11-11. This reconciles research designs, not formal proofs or measured runtimes. The objective remains minimum expected end-to-end cost for a complete standard-axiom proof in Lean and an appropriately founded MM0 proof. QRH is optional. Binary coverage, spectral certificates, analytic libraries and assembly must all be discharged.

## Decisions supported by the inspected evidence

The adaptive chain, smooth-factor acceptance and grouped-order acceptance are accepted at paper scope. Each has an independent review, read by the coordinator. The coordinator also read the production/payload report, the supplied-root Lean source plan and the actual existing primality and repeated-squaring proofs in `Ladder/Spec.lean:38–118`. The new reconciliation script verified 30 listed source/support pins across eight reports and records their current hashes. It does not validate any prime, certificate or Lean theorem.

The primary explicit-ladder comparison should include direct supplied roots. Whole-product batching remains an option to price, rather than a default presumed faster. Adaptive chain geometry replaces the conservative fixed-window stride only when a new complete chain, decoder and coverage proof are supplied. Smooth-factor certificates remain a fallback option whose value depends on actual failed-search and factorization costs.

The source plan's fixed-window decoder is not yet the adaptive checker. A follow-up now specifies authenticated incoming/outgoing shard endpoints, mixed-factor decoding, exact positional partitions and final coverage. This mismatch is an implementation obligation, not an error in the underlying primality argument.

## Accepted mathematical reductions

For even B at least 4, the prime 3 and a strictly increasing certified chain with gaps at most B-2 cover every odd integer through the final prime plus B. Each prime p supplies the interval of odd integers from p+4 to p+B using the separately proved binary theorem through B. The final prime must actually reach the target; a successful search rate is not a substitute.

For Proth-order certificates, put F=2^45. For an exact product M of odd candidates with 1<p<(F+1)^2, a supplied X<M that reaches M-1 after 44 modular squarings proves all candidates prime. The source criterion already proves the required least-prime-factor argument. Acceptance needs neither reconstruction of X from a small base, progression powers, nor an extra gcd test. Exact product binding, ranges and chain coverage remain mandatory.

The direct case M=p uses the same 44-square argument and avoids producer CRT and wide product arithmetic. With n equal-width factors and a hypothetical modular-square cost proportional to w^alpha, the whole-product/direct square-work ratio is n^(alpha-1). This excludes construction, dispatch, serialization and reductions outside that cost function. It is not a runtime law. Root payload is of roughly the same maximum total width in both formats.

For smooth F, distinct full prime-power orders may be certified by separate supplied roots. Their least common multiple forces every prime factor of a candidate to be at least F+1. The strict square bound proves primality. Grouping prime powers reduces the number of root coordinates but can increase exponent work. For m=160 in the reviewed portfolio, one, four and ten roots cost respectively 184, 92 and 70 counted modular operations, including the aggregate unit test. These are equal-weight schedule counts at the same modulus width, not timings or an exhaustive circuit optimum. Every option also supplies one aggregate inverse. Producer partitions can differ from verifier partitions, but combining retained components costs work.

## Counts at the accepted lower analytic threshold

Earlier adaptive tables used N=10^27. The receipt now also uses N=989*10^24 and T=N-1, the separately reviewed lower analytic threshold. The table counts necessary new primes after 3. It does not assert the existence of a chain attaining these counts.

| Binary cutoff B | Necessary new primes, any format | Necessary new primes, only F=2^45 |
|---:|---:|---:|
| 10^15 | 989000000000 | 1003895379523 |
| 2*10^15 | 494500000000 | 501947689761 |
| 5*10^15 | 197800000000 | 197951201596 |
| 10^16 | 98900000000 | 98975600798 |
| 2*10^16 | 49450000000 | 49487800399 |
| 4*10^18 | 247250000 | 247251821 |

The all-format bound is max(0,ceil((T-B-3)/(B-2))). For the same-F bound, H=floor((B-2)/F), the first index is at most floor(B/F), and the final index is at least ceil((T-B-1)/F). Each subsequent transition advances by at most H. The receipt checks the exact endpoint inequalities and derives the resulting count. Lowering B greatly increases the required ladder work, even before unsuccessful searches. Thus a smaller binary cutoff alone is not an efficiency conclusion.

## Lean and MM0 arithmetic boundaries

The Lean plan computes bounded modular recursions and proves their generic soundness with symbolic powers. Concrete public conclusions mention prime/coverage facts, not an instantiated X^(2^44). This avoids accidentally asking definitional equality to normalize an enormous ordinary power. The existing source explicitly warns about this failure mode.

A supplied literal M, checked against one product fold, can avoid relying on unverified kernel sharing of an expression computing the product. It adds up to 90 bits per candidate in the current geometry, in addition to the root field. This is a proposed predictable reduction boundary, not proof that a literal M is always needed or fastest. Direct one-candidate records need no redundant product witness. Bounded records and packs avoid repeated shifts through a huge concatenated numeral; their traversal and imports still cost work.

The MM0 comparison uses ordinary PA arithmetic inference, with multiplication and quotient/remainder proofs. Reusable closed digit facts and square-table alternatives are under research. No arithmetic oracle or unproved digit lookup is included. A checker widened or streamed while preserving the same inference rules is legitimate implementation engineering; it should receive the same conventional implementation-trust treatment as Lean's kernel. Analytic-library translation and final assembly remain separate costs.

No new implementation or benchmark accompanies these plans. In particular, 44 squares cannot be converted into a fixed fraction of an old total runtime, and fewer roots cannot be converted into lower total production cost.

## Spectral comparison and current priorities

The reduced original finite-RH family remains the conservative analytic comparison. The new nonprincipal report prices a shared Hurwitz lattice, actual unit-group transforms, time interpolation and local repairs separately. Its roughly 0.513 butterfly-count ratio compares one explicit circuit on the reduced and old declared domains. It is neither a complete-cost ratio nor a kernel certificate. Independent review is now checking the report and its omitted auxiliary/count work.

Selected strict signs may be cheaper to certify than replaying every dense search output. This still requires the retained shared coarse samples, all interpolation error bounds and complete zero counts. A separate task is deriving that crossover. The native search bill remains in the end-to-end cost.

The ladder-free finite-RH prime-gap family remains a competitor. Its reviewed Q=47 point uses principal RH through 1.88e12 and binary coverage through 2e16, with substantial new analytic proof work. Its larger principal verification may cost more than the ladder it removes. It is not selected as cheapest.

Reducing the major-arc cutoff further has a severe threshold tradeoff in the current conservative bounds. The constants worker's provisional R=100000 candidate needs an analytic threshold around 10^36. That would multiply fixed-B ladder length by about 10^9 relative to the present threshold. The candidate is not yet accepted; it should not be described as a saving merely because it removes conductors.

The next cost decisions are the joint binary cutoff/block size, complete direct-root versus batch cost, ordinary-PA arithmetic representation, and sparse spectral acceptance. A final estimate must price actual successful data, failed generation attempts, proof production, checking, imports and libraries. There is still no defensible universal Lean/MM0 speed ratio.

## Evidence and scope

The companion `reconcile_adaptive_certificates_20261111.py` reads frozen reports, checks their listed table/bullet pins and derives exact integer endpoint counts. Its receipt is `reconcile_adaptive_certificates_20261111.json`, SHA256 `35384483D2C48066E238D543C2142E72E598C724D84B3F08A6437FA6CDAEF782`. The receipt binds the eight report hashes, including all three independent reviews. All prior frozen files remain unchanged.

The previous goal turn made progress through completed research packets and the common-root acceptance. This continuation adds coordinator reconciliation, the lower-threshold count receipt, and revalidated bounded assignments to all seven available workers. It does not complete the objective.

DRAFT_ANCHORS: 0 created
UNREGISTERED_SORRIES: 0 introduced
DRAFT_IMPORT_VIOLATIONS: 0 introduced
SEALED_THIS_TURN: 0
