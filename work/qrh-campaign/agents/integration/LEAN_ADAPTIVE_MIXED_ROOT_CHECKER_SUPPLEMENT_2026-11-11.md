# Adaptive mixed-chain extension of the supplied-root checker

2026-11-11. Paper/source supplement only; no checker, declaration, build, prime evaluation or certificate was produced. This replaces the fixed-window **proposed interface** in the earlier architecture when selecting the adaptive ladder. It does not change that frozen report or the existing fixed-window Lean theorem.

## 1. The consumed object is an ordered prime chain

Fix even B>=4, odd T>=7, and an exact geometry cap Cgeom. The intended small-range specialization is T=10^27-1 and Cgeom=10^27. Start at the proved prime p0=3. Every record reconstructs an actual odd pnext and checks

    1 < pnext < Cgeom,
    p < pnext <= p+B-2.

It must additionally establish Prime(pnext) by its selected certificate method. An order-F method checks pnext<(F+1)^2, so its combined bound is 1<pnext<min(Cgeom,(F+1)^2). General-prime fallback instead checks the exact domain required by its own soundness theorem as well as Cgeom. There is no global F, stride S, fixed window number, minimum progress, or assumed search success.

The terminal check is plast+B>=T. Each prime p covers odd integers in [p+4,p+B] under the separately supplied binary theorem through B. The next first odd integer is at most p+B+2, so the checked gap leaves no odd hole. Starting at3 covers [7,B+3]; induction reaches T. If B+3>=T, the empty transition list is legitimate. An empty productive primality batch never supplies a missing transition. This is the accepted adaptive paper contract; a new Lean coverage adapter is still required. The final root and the original binary-input contract do not change.

## 2. Two exact location tags, independent of primality tags

An **explicit-next** record contains pnext and the chosen primality-method tag. It undergoes all checks above. This supports arbitrary-prime fallback and direct supplied roots equally; “explicit” is not evidence of primality.

A **lattice-deficit** record contains a checked positive even F from the allowed dictionary and a deficit d. From the actual predecessor p compute

    u = floor((p+B-3)/F),    l = floor((p-1)/F)+1.

First require l<=u and d<=u-l. Then k=u-d and pnext=kF+1. These guards precede natural subtraction. They give exactly p<pnext<=p+B-2. Still check the actual candidate bounds and oddness at the common output interface. Invalid tags, zero F, exhausted fields and extra fields reject; a hash does not establish the dictionary's numerical values or factor facts.

If a run is known to remain on the same F and p=kF+1, set H=floor((B-2)/F). Then k_next=k+H-d with d<H. Check H>0 before any H-1 width calculation. This removes per-step division for that run. A switch of F must use the general predecessor-based decoder, not the previous run's k recurrence. A zero-bit deficit block explicitly asserts all its deficits are zero; a narrower chosen width is valid only if every decoded deficit satisfies its bound. No distribution or existence assertion is implicit.

Separate location tags from primality tags. A candidate located on one lattice may be certified by another sound method if that method's full guards pass. For simplicity an initial implementation can require equality of the lattice F and order-method F, but that restriction is an implementation choice, not a coverage theorem requirement.

## 3. Primality grouping cannot reorder coverage

The lowest-complexity baseline checks each record directly: q=1, modulus equal to its actual pnext. The Proth order tag uses44 modular squares; smooth-F and general fallback have their own proved checkers. No CRT or separate product witness is needed for q=1. The ordered fold immediately continues with the checked pnext.

For grouped checking, first bind a bounded ordered candidate table to the complete location fold. Partition its local positions among nonempty arithmetic groups. Each group carries distinct increasing local indices, a single primality-method/F tag, and its own witness. Require disjoint group masks and that their union is exactly all local positions; reject extra, duplicate and unassigned indices. Require every group input to equal the actual candidate at that position. This is an exact finite partition check, not a claim about a sorted multiset or a digest.

For a Proth group, bind M to the exact product of its assigned candidates and perform the44-square supplied-root check. For a smooth-F group, use its exact certified factor dictionary, complete exponent tree and aggregate-unit witness. Different F values use different groups and different product moduli; the entire shard need not be homogeneous. General fallbacks may remain singleton groups with their closed factor-prime DAG. A method identifier must select a concrete Boolean checker with a generic soundness proof, not a caller-supplied Boolean oracle.

A homogeneous group may contain nonadjacent chain positions. Its primality implication is independent of those positions' spacing, because supplied-root acceptance has no k progression. The coverage fold nevertheless retains every intervening record in its original order. Strict increase makes candidates distinct; ordinary CRT production is then available if successful roots have actually been found. CRT construction is untrusted producer work, not an acceptance premise. Groups can be restricted to one bounded pack; no cross-shard regrouping is needed for this design.

Avoid disguising repeated decoding as sharing. The direct q=1 fold needs no candidate table. A conservative grouped design stores bounded candidate literals redundantly, checks them against the location fold, and uses those literals in products. This adds up to90 bits per candidate in the current geometry. A compact alternative omits them and reconstructs bounded tables, but its reduction/recomputation cost must be counted until measured. As in the earlier note, a supplied literal M checked against the product avoids assuming a reducible product expression is cached. For q=1 use p itself as M and omit this redundant product field. No supplied terminal residue replaces a checked chain of modular operations.

## 4. Bounded shards with authenticated incoming endpoints

A shard summary fixes B,Cgeom, dictionary/method version, incoming pin, outgoing pout and its exact transition count. The checker requires odd pin and 1<pin<Cgeom. The generic theorem says: **given Prime(pin)**, acceptance proves an increasing odd prime chain from pin to pout, all new candidates within the bound, and every transition gap at most B-2. The incoming prime cannot be an unchecked assertion in a file: globally it is3 or the exact outgoing value with prime proof from the preceding shard. A shard's incoming endpoint need not satisfy the next record's method-specific F bound: it already has its own prime proof.

Each shard includes its first transition pin→p1 in its checked fold. Therefore adjacent summaries compose by exact equality pout_left=pin_right; no extra unverified cross-shard gap is left over. This convention avoids the ambiguity of shards containing only disjoint lists of new primes. Require parameter equality too. Empty shards, if allowed, are explicit identity transitions with pout=pin and count0; they cannot advance final reach. Sum exact counts and check actual record exhaustion. The last shard is its actual short length, not padded data.

Use bounded records and bounded local masks; do not concatenate the global chain into one Nat or shift through an unbounded suffix. A balanced tree of adjacent summary applications reduces assembly depth. Its public proposition can express chain existence without exposing all witness data, while retaining actual endpoints and parameters. This does not eliminate checking shard proofs, loading their interfaces, or storing the final dependency chain. Independently generated shards still need compatible certified anchors; the theorem does not prove a segment can be filled.

The no-enormous-power boundary remains unchanged. Generic method soundness hides symbolic ordinary powers; closed packs reflect only bounded Boolean computations and apply the generic summary theorem. Grouping, decoding and final assembly introduce no concrete X^(2^44) goal.

## 5. Metadata and remaining lemma costs

Relative to the fixed-window plan, metadata now pays for an actual predecessor, deficit recurrence or explicit-next value, method/F tags, exact outgoing endpoint, variable counts and final reach. General mixed-F deficit steps include divisions; same-F runs use H and addition/subtraction instead. The accepted Proth geometry gives worst deficit widths9,10,17 for B=10^16,2*10^16,4*10^18 respectively, not the earlier fixed7/8-bit offsets. Smaller block widths require actual per-record bounds. Full explicit p values and grouped redundant candidate/M witnesses are separate payload costs, not free compression. Partition masks and candidate-position checks are additional work; direct q=1 avoids them but uses more narrow modular chains.

The new proofs needed beyond the earlier architecture are: the guarded general deficit equivalence; same-F recurrence with H=0 rejection; method-specific bound-to-primality adapters; exact ordered-table binding and group partition soundness; shard transition induction; adjacent-summary composition; and the odd-interval coverage/final-reach theorem. Smooth-F and general fallback soundness are still new Lean work even though their mathematical contracts have paper reviews. No batch size, representation, fallback fraction or runtime winner is established here.

## Pinned inputs

Paths below are under `work/qrh-campaign/agents/`. Existing Lean producers remain the `Check.lean`/`Spec.lean` sources pinned in the first architecture, particularly `Spec:38–55,105–118` and the fixed-window limitation at287–304.

| Input | SHA256 |
|---|---|
| `integration/LEAN_SUPPLIED_ROOT_CHECKER_ARCHITECTURE_2026-11-11.md` | `1C7A5D888770D343F87E8E9240B1B2AE44BBD8972BEF5273B5F32360BEB6B463` |
| `major-constants/EFFICIENCY_ADAPTIVE_PRIME_CHAIN_2026-11-11.md` | `77ADA365011EA6069D3D2F8131950AD65ECAD285400BBD5C307C7444F0093785` |
| `audit/REVIEW_EFFICIENCY_ADAPTIVE_PRIME_CHAIN_2026-11-11.md` | `18EA39FC8F4142FFE4091FA3D542F4BBD43DB7A1DDB03B33246E06438E285B37` |
| `prime-estimates/SMOOTH_FACTOR_LADDER_PORTFOLIO_2026-11-11.md` | `5C49B39D44D432A71F7A5F45E924F6C76E9E173666DB6301EF0469F1AAD5F59A` |
| `audit/REVIEW_SMOOTH_FACTOR_LADDER_PORTFOLIO_2026-11-11.md` | `A51F4408037C3A49A0B59D3144113D8B01D186915444CD7A215ED98443CBBA1E` |

Only this new supplement was written. No frozen input or Lean file was changed.
