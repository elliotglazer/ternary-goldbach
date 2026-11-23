# Common root certificates for batched primality

2026-11-11. New paper-level acceptance simplification, independently checked by statement_audit and major_constants in this session. No new declaration, modular-power computation or prime search was performed. The existing source criterion was inspected earlier and its hash remains pinned below.

## Proth-type batch

Let D=2^44 and F=2^45. Let p_i be the actual integers consumed by a finite ladder batch. Require every p_i to be odd, greater than one and strictly below (F+1)^2. Construct their exact product M, require M>1, and accept a supplied natural X only after checking

    X^D mod M = M-1.

Then M divides X^D+1, hence each p_i divides X^D+1. The existing `Ladder.Spec.prime_of_dvd_pow_add_one` proves each p_i prime directly. In elementary terms, any prime divisor r of p_i is odd and X^D=-1 modulo r. X is automatically a unit modulo r and has order exactly F. Thus r>=F+1. If p_i were composite, its least prime divisor would have square at most p_i, contradicting the strict size bound.

The checker needs no proof that X arose from a small base, no exponent k_i, no offset power, no index-progression modular update and no separate gcd. It still needs actual product binding, each candidate's size/oddness, and the separate coverage/gap facts. The congruence itself carries the required order information.

This differs from the previously rejected shortcut of supplying an arbitrary V and testing V^k=-1 for odd k. Here the checker verifies the full power X^(2^44). Setting an arbitrary V=-1 cannot bypass that work.

The computation uses 44 modular squarings starting from X mod M, plus product construction, decoding and the final comparison. A nonempty q-factor batch has a product-width bound of 90q bits for the current candidates. Forty-four squarings at that width do not imply forty-four small-word operations. Direct single-factor root checks remain an alternative with narrower arithmetic.

## Production and payload

For a prime p_i=k_i*F+1, a producer can find a successful small base a_i and form x_i=a_i^k_i modulo p_i. It can then construct a common X by CRT. All those searches, exponentiations and CRT operations are production work; their derivation need not be replayed because the acceptance test above is sufficient on its own.

Distinct primes permit the ordinary squarefree CRT construction. Repeated candidate factors do not invalidate acceptance, but per-prime roots alone do not automatically construct a solution modulo their repeated product. Deduplicate within a batch, use a strictly increasing ladder, or separately construct prime-power lifts. Do not turn this producer condition into a circular primality assumption in the checker.

A reduced root X<M needs up to 90q witness bits, about 90 bits per candidate, in addition to candidate locations and framing. This is larger than the old offset-only input. The earlier short encoding around a fixed small base does not automatically remain useful: the root witness is a_i^k_i, not the common small base itself. Producer effort, payload, imports and nonlinear arithmetic can offset the saved verification operations.

## Smooth-factor extension

For a fixed known even F, choose M as the product of the same-F candidates and supply X. Check X^(F/2)=-1 modulo M. For every distinct odd prime q dividing F, check that X^(F/q)-1 is a unit modulo M. A single checked inverse for the product of these residues can certify all those unit conditions. The q=2 condition and Fermat condition follow from the negative-one test and odd M.

For every prime divisor r of M, the order of X modulo r divides F but fails to divide F/q for every prime q dividing F. It therefore contains each full prime-power valuation of F, so F divides r-1. Every consumed candidate below (F+1)^2 is prime. When q has higher valuation in F, the exponent is F/q, not F divided by the entire q-power. No factorization of the remaining k in p=kF+1 is needed.

Prime_estimates is deriving the complete exponent-tree and interval contracts for a portfolio F=m*primorial(31). This paragraph records the generic sufficient criterion; the portfolio's exact operations, factor certificates and producer availability remain separate research obligations.

## Source and selection status

Existing source: `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean`, generic criterion at line 38, SHA256 `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F`.

The common-root option is now part of the explicit-ladder comparison. It removes more verification work than the earlier common-base progression contract, at a different payload and production cost. It does not establish successful candidates, a completed generalized checker or a measured speedup. It must compete with direct roots, compact small-base traces, grouped smooth-factor roots and general-prime fallback on the same complete target.

    DRAFT_ANCHORS: 0 created
    UNREGISTERED_SORRIES: 0 introduced
    DRAFT_IMPORT_VIOLATIONS: 0 introduced
    SEALED_THIS_TURN: 0
