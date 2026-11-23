# Independent review of the adaptive mixed-root checker design

2026-11-11. Verdict: **PASS as a paper/source design.** No correction is required to `integration/LEAN_ADAPTIVE_MIXED_ROOT_CHECKER_SUPPLEMENT_2026-11-11.md`, SHA256 `5CB52190195B1AAE4610CE5AA377A29E89CDBACDAE1A3B048C5920D2CA1C231C`. This does not establish an implemented checker, closed pack acceptance, kernel theorem, completed chain or performance result.

I read the complete supplement and its original supplied-root architecture, compared the accepted adaptive geometry, and reread the actual generic criterion and modular loop. All five input hashes in the supplement match the files. The relevant source pins are `Ladder/Check.lean` at `A7993B4D1E8A70112403B85B15CF586B4DA84B962A04416531BDE9F35817A42D` and `Ladder/Spec.lean` at `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F`, under `work/ternary-goldbach/TernaryGoldbach/`. No Lean changes, builds, candidate evaluations or arithmetic experiments were performed.

## Incoming primality is an internal implication

The generic shard theorem may assume Prime(pin). Its conclusion must include Prime(pout), either from the last certified transition or from pin when the shard is empty. Assembly starts with the existing proof that 3 is prime, then passes each outgoing proof to the next theorem after exact endpoint equality. Thus Prime(pin) is discharged, not promoted to a new root hypothesis. The intended Cgeom=10^27 also proves the initial range guard 1<3<Cgeom. An arbitrary small geometry cap may reject this starting shard; it cannot manufacture coverage.

The convention that each shard checks its own first transition is decisive. Equality pout_left=pin_right binds the right shard's first gap to the actual preceding prime. There is no unverified gap between two disjoint lists of newly certified primes. Empty shards are identity implications and do not advance the terminal reach. Parameter equality must include B, Cgeom and the numerical meaning and soundness of every selected method/dictionary entry, as the note requires.

Induction gives an increasing odd prime chain from 3 with gaps at most B-2. Its prime intervals [p+4,p+B] then cover the odd integers through the final endpoint plus B. The last reach comparison supplies T, including the intended T=10^27-1. This uses the existing binary theorem through B and leaves the original final-root premises unchanged. The unconditional large-range proof is not replaced by a new spectral or shard assumption.

## Exact decoding and position binding

For positive even F, the proposed q/l bounds are the exact integer rearrangement of p<kF+1<=p+B-2. The guards l<=u and d<=u-l imply d<=u before natural subtraction. With p>1, l>=1, so an accepted deficit cannot produce the spurious k=0 candidate. An F switch uses the actual predecessor and the general decoder.

The division-free recurrence is valid only after establishing p=kF+1 for that same F. A method tag or a remembered k from a different run does not establish this invariant. The note explicitly requires it and rejects H=0 before calculating an H-1 bit width. A zero-width block represents actual zero deficits. Every smaller-width representation still checks the semantic deficit bound and exact field exhaustion.

Location and primality tags may differ because the generic order criterion does not need the location's lattice equation. Each selected primality method must prove the actual reconstructed integer prime under its own full guards. A Boolean method supplied by the caller without a soundness theorem is not acceptable evidence.

For grouped checking, exact equality between each candidate-table entry and the location fold prevents substitution of a different prime. Disjoint group masks whose union is all positions ensure every new integer receives a proof exactly once. Increasing local indices and exhaustion reject extra, duplicate and missing assignments. The primality groups may visit nonadjacent positions, but the coverage fold cannot be reordered. A general-prime certificate still has to close its factor-prime dependencies and certify that same candidate.

## Direct singleton and product groups

For q=1, use the actual candidate p as modulus. Its strict lower bound makes the modulus greater than one. The supplied root's reducedness and checked 44-square chain are inherited from the method contract. There is no product witness, CRT construction or group-partition mask to charge for this direct fold. The root numeral, location data, method fields and their checks remain payload and work.

For a product group, its literal M must equal the product of the candidates at its assigned positions. Its checked minus-one root congruence descends to each factor. `Spec.lean:38–57` gives exactly the requisite oddness, size and divisibility criterion. Different F methods require their own certified factor/order adapter; they cannot inherit the old fixed-window theorem. The new note retains these separate obligations.

The 90-bit bound is justified by the intended geometry cap, not by the generic Proth square bound alone. Redundant grouped candidate literals and M cost additional bits. Conversely, omitting them and reconstructing candidates does not prove free kernel sharing. In particular a computed deficit candidate used as the q=1 modulus can incur repeated reduction work depending on the eventual term representation. Bounded data and source-level variables make this a controlled implementation question, not a measured saving. The design makes no contrary timing claim.

## Ordinary-power and proof-status boundary

`Check.lean:35–38` implements repeated modular squaring, and `Spec.lean:105–118` proves its symbolic modular-power relation. The proposed generic soundness theorem can use that relation with bound variables, apply the generic prime criterion, and export only primality and chain properties. A concrete pack then proves a bounded Boolean acceptance statement and applies the exported theorem. It need not create a concrete ordinary X^(2^44) equality or divisibility goal.

This architecture is mathematically sufficient to avoid demanding that enormous normalization. An actual implementation still needs a term/source audit showing that its executable checker, theorem types and concrete applications follow it. An irreducibility annotation or opaque unproved residue would not establish the claimed computation. The note does not treat either as a solution.

The missing implementations remain the guarded decoders and invariants, concrete method checkers, exact partition/table binding, shard induction and composition, closed acceptance proofs, final coverage and compatible kernel/axiom validation. Balanced assembly reduces depth but does not delete those checks or import costs. No batch size, fallback rate or runtime winner follows from this paper design.
