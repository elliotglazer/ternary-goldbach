# Independent review of next-hit carry headers

2026-11-11. PASS at paper, source-contract and exact metadata scope. No further author correction is required. This accepts the exact carry invariant and the specified conditional arithmetic comparison. It does not certify a source bitmap, a working ordinary-rule compiler, stock checker capacity or a net runtime saving.

The reviewed author packet is `prime-estimates/SOURCE_NEXT_HIT_CARRY_2026-11-11.md`, SHA256 `4A44E6866C2FCC40A5D0B78F342C5F1B7E49BA77F3749C0E172CB3FF6488062B`; scalar source `source_next_hit_carry_metadata_20261111.py`, `348781327FEBDC120869A79A18EFE10E882BD43B1B6004CC01EEE3620B6136B3`; receipt `43127729EB0CB7E9722A909587D2A136209D20D77F45AF2CEB449C1EDB47FDC0`. I read the entire final note and scalar source without executing the author's code. Existing word-stream artifacts remain unchanged.

## Exhaustion and state identity

For an odd prime p, write `j_p=(p^2-1)/2`. The necessary invariant is that n is the *least* member of `{j_p+kp:k>=0}` at or above the current b. Merely proving congruence or n>=b is inadequate. Initialization n=j_p proves the invariant at zero, with the complete base list and exact prime-square metadata retained.

If n>=e, the interval `[b,e)` has no hit and the same n is least at or above e. A preactivation pointer can be much larger than e+p; the upper bound e+p is not imposed on this empty branch. If n<e, the checked equality n'=n+Hp with H>=1 and e<=n'<e+p proves that exactly H consecutive hits belong to the chunk. In particular n'-p<e and the next hit is excluded. The strict upper inequality prevents skipping a hit exactly at e.

The boundary n=e is empty in the current chunk and available at the next chunk start. Likewise j_p=b is immediately included, while j_p=e is deferred. The final postcondition at J proves exhaustion below J without introducing a source bit at J. Short final chunks use the same argument. The accepted first/H/last header is exactly the predecessor word-stream interface, so no sparse mark, dense mask, merge input, duplicate OR or final source check disappears.

The elementwise relation between the complete prime list and the immutable pointer list is essential. Each step consumes the actual paired heads and produces the exact successor tail. Exact length/order and the equality b_next=e rule out omitted primes, reordered state and gaps between chunks. The next chunk must consume the proved outgoing list, not a producer's replacement array. A native pointer or hash is not a source fact. The author's p=3, false-initial-n=7 example correctly shows that locally passing transitions alone can omit the required index4.

Top source bits may still be a subset of survivors. Recursive base production still requires exact complement and complete extraction. Prime2 and the bit for1 retain their separate treatments. Carrying state does not relax any of these obligations.

## Widths and the matched arithmetic comparison

The active count satisfies H<=ceil(T/3)=87382<2^17. With prime widths17/18/19 and pointer widths33/35/37, full Hp products need34/35/36 bits and raw successor sums35/36/38 bits. The acceptance comparisons are performed at the raw width, before narrowing to the proved pointer bound. The subsequent accepted Hp<2^20 bound cannot justify a premature 20-bit multiplication.

I independently reconstructed the Boolean circuit costs from partial-product ANDs and full-width additions. The active sparse costs are4961/5142/5342 gates; the optional dense adapter adds678. Its initial phase is `(n-b) mod64 mod p`, relative to the first word, so the remaining division has six-bit operands. The separately cached `64 mod p` setup needs the stated seven-bit division. Empty pairs retain231/245/259 comparison gates plus structural work.

The fresh comparator correctly uses quotient witnesses rather than charging four mandatory divisions. Its two certificate branches are explicit: immediate emptiness proves j_p>=e; otherwise the first-hit witness proves n=r+qp and a<=n<a+p with a=max(b,j_p), followed by the common empty/active test. There is no extra uncharged preliminary branch comparison. The fresh-first subcircuit costs5821/6471/7155 gates under the specified padded model.

During preflight I requested an explicit packing-order clarification, now present in the frozen author note. The fresh comparator must prove that the high bits of raw r+qp vanish and bind it to its g-bit representation *before* using the narrow endpoint comparisons. This is separately charged outside F. The abstract example g=8,p=13,q=27 gives raw357 and low bits101; narrow checks alone would accept a false first hit. The final note rejects that behavior. Thus F is a named arithmetic subtotal, not the complete first-witness proof price.

For the canonical matched schedules, preactivation empty pairs I avoid F, while active pairs A and gap-empty pairs G pay it. Consequently the stated arithmetic differential `(A+G)F` is correct. On full T-bit chunks, each prime contributes `Q-floor(j_p/T)` to A+G. This is an exact future count on the complete prime list, not a count supplied by the all-odd upper bound. No actual prime list or saving is inferred here.

## Costs that remain

The QP state reads, successor nodes and invariant applications include empty pairs. Word-stream merge-node administration also remains, including empty merges. One may share an unchanged suffix only after proving that equality and pricing the chosen implementation. Explicit interchunk snapshots cost the displayed `5P(Q-1)` bytes; those are one layout's payloads, not mandatory lower bounds or proof-memory estimates.

The differential must include initialization, raw-to-packed proofs, term construction, field encoding, checked chunk links and any proof replay/import. The same sparse/dense leaf policy and complete downstream objects must be used before cancelling common work. Discovery of H is untrusted generation work, not a free theorem consequence. Ordinary PA encodings, library proofs, compiler correctness, exact source/coverage binding and stock heap/store fit remain explicit implementation requirements. No conclusion is drawn by subtracting the predecessor's loose header upper bound.

## Independent exact evidence

The owned `review_source_next_hit_carry_20261111.py` reads the pinned author receipt and predecessor pins, but imports no producer. Its SHA256 is `C1D9035AA5080D8F274E0DED8EAF8CC9942C47178630306C30017E26AC7C45DD`; the JSON has SHA256 `A9ECF59B012D0FDFEBC3BE76D140D4CD5E0B8B974CBD9484C95AB723FCAC7F4A`. It records 22111 checks, including 5417 abstract progression transitions, 132 rejected wrong counts, 415 gap-empty cases, 4936 preactivation-empty cases and 33 exact-endpoint cases. Each carried pointer is compared against an independent closed-form least-progression expression. Tests also retain the false initial pointer and wrapped fresh-witness counterexamples. Scalar rows, raw/state capacities and snapshot arithmetic match.

These are generic integer/protocol checks, not prime tests or source-sieve runs. No analytic value, build or Lean declaration was produced. The review accepts a conditional construction and cost model, not successful real compression or end-to-end adoption.
