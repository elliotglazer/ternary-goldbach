# Review of immutable source-bitmap acceptance

2026-11-11. **PASS at mathematical/source-design scope; no correction to the frozen author note required.** This review adds implementation obligations and possible work reductions, without accepting an executable checker, a source bitmap or a runtime estimate. No build, source modification, sieve, prime computation or numerical analytic evaluation was performed. I read the full author note and scalar script, inspected the relevant source bodies, and checked their hashes; I did not rerun the scalar script or independently reproduce its entire numerical table.

Author: `work/qrh-campaign/agents/prime-estimates/EFFICIENCY_SOURCE_SIEVE_2026-11-11.md`, SHA256 `55052C31D2DEFD00CAB9DB99CC1E947C4E14E509FDF0ED376E20374A1F6C0F54`.

## Survivor proof and endpoints

The proposed object has exactly J odd-number positions: j represents n=2j+1 for 0<=j<J, with maximum U=2J-1. A set bit need only imply primality; extra zero bits are allowed. They may make later Goldbach coverage fail, but cannot invalidate source-prime soundness.

Let W=15015 and R[j] express gcd(2j+1,W)=1. The precise wheel condition is B[j] implies R[j] **or j is one of the five exact indices 1,2,3,5,6**, representing primes 3,5,7,11,13. It is not an exemption for entire residue classes, whole words or chunks containing these primes. Clear j=0 separately: it is wheel-admissible but represents1. The prime2 is outside the odd source object and remains a separate binary-coverage case.

Suppose B[j]=1 represents a composite n>1. Its least prime divisor p is odd and p²<=n<=U, so p<=Y=floor(sqrt U). If p divides W, n cannot pass the wheel, and it cannot be one of the five prime exceptions. Otherwise p>13 and gcd(p,W)=1. Writing n=p*m with odd m gives m=2k+1. From p²<=n, k>=(p-1)/2, and

    j=(p-1)/2+p*k,
    gcd(n,W)=1 iff gcd(2k+1,W)=1.

This is exactly a checked sparse progression hit. Its demanded zero contradicts B[j]=1. The lower cofactor endpoint includes n=p²; the upper condition j<J includes n=U when it occurs. There is no assumption that the source is complete, nor a need to prove primality of each surviving bit separately. Repeated hits from several base primes are harmless.

The actual `PsiSieve3.prime_iff_PS3:113-125` supplies the minimum-factor mechanism, but its fixed numeric range cannot be used as a generic theorem for the new U. The proposed generalized proof must retain the source's positivity/nonunit premises and exact Y²<=U<(Y+1)² witness.

## Base-list and scheduler obligations

The base list must contain **every** relevant prime p<=Y. A recursive bitmap satisfying only the source's one-sided implication does not establish that: it could clear a prime and omit the least factor of a larger composite. The selected recursively certified complete list therefore needs a two-sided prime characterization, or an independently proved divisor-cover property. This is already required by the author's wording; it must remain explicit in implementation.

For this one-sided source theorem, primality of every listed divisor is stronger than necessary: a complete admissible superset of divisors can also work, at potentially greater checking cost. Duplicate list entries are also sound but wasteful. This observation does not permit an incomplete list of probable primes.

For a chunk [b,b+w), the exact cofactor range for p is the integer interval simultaneously satisfying k>=(p-1)/2 and b<=(p-1)/2+p*k<b+w. Its first element and strict terminal bound must be checked with the same global-index convention. The wheel's sorted residues and wraparound gap must enumerate all admissible k in that interval. A list that merely increases, or ends beyond the chunk, does not establish coverage. A bucket schedule must additionally account for all base divisors, p² activation, all unvisited hits, and transitions between chunks; its state is a proof obligation even though B itself is immutable.

The wheel extraction bound `(b mod W)+w <= T+W-1` is correct. A medium-prime template of length T+p-1 likewise covers every phase and a chunk of length at most T. Its residue is `(p-1)/2 mod p`, in the odd-index coordinate. The p² cutoff is `(p²-1)/2`, not p² in bitmap coordinates. Complement masks must be truncated to their specified finite width; an unbounded/complemented numeral has no implicit finite-word semantics.

## What an indexed zero-bit check must prove

A depth-12 tree for a full 4096-word chunk gives a mathematical path length, not automatically twelve kernel instructions. For each global index j, the acceptance theorem needs:

1. The chunk start b and its actual length w, with b<=j<b+w<=J.
2. Local index j-b=64*r+s, with 0<=s<64 and r in the represented leaf range.
3. The lookup returns the leaf at r of this exact immutable tree, each word lying in [0,2^64).
4. The global source bit B[j] equals that leaf's bit s; the zero test is a proved operation on that bounded word.
5. The same tree/word sequence is used by the coverage input, or a proved exact packing/dilation relation connects them. A newly supplied packed literal or digest alone cannot make this connection.

For a final partial chunk/word, bits beyond J must either be cleared or be excluded from every consuming operation by its proved length. They cannot silently become extra source primes. A supplied lookup path must bind to the concrete checked object, not merely to some tree with a zero leaf. These requirements are compatible with the author's representation plan and explain why its lookup cost remains unmeasured.

## Avoidable work and limits of the proposed saving

The removal of mutable clearing-state refinement is genuine: immutable zero-bit propositions suffice. Population count and assertions that every cleared position is composite are unnecessary for source soundness. Several further reductions are possible, but are not claimed by the author's cost table:

- A chunk proved identically zero satisfies source soundness without visiting any divisor. A proved zero word can similarly replace all hit checks targeting it, provided the scheduler's remaining coverage is accounted for. This is useful only if the resulting bitmap still supplies the required binary coverage.
- Several hits within one word can be combined into one forbidden-bit mask and one AND-zero check. The mask still needs its exact hit interpretation. Grouping does not prove an incomplete event list complete.
- Wheel-compressed storage can omit forbidden residue positions and reconstruct them as zero, but adds a rank/select or exact expansion proof and separate exception handling. It is an alternative to measure, not a free reduction of the existing 64-bit leaf cost.
- Additional cached wheel groups may clear their own small prime positions. That is harmless for the one-sided contract if deliberately allowed; preserving those primes requires their exact exceptions or p² cutoffs.

The scalar sparse bound has the correct structure: for an interval of h cofactor indices, periodic discrepancy gives at most rho*h+disc admissible hits; h<=J/p+1 leads to `(rho+disc)*P_l` in addition to `rho*J*sum(1/p)`. Upper-bounding the reciprocal sum by counts of wheel-admissible odd integers in dyadic bins is valid because each bin is open at its lower endpoint. Ignoring p² only enlarges the bound. This review validates that derivation, not every saved finite discrepancy/table value independently.

Sparse events, wide mask pairs, scalar starts, tree accesses and proof-object imports remain different costs. A common period or literal template does not guarantee cross-declaration caching. Both strict Lean and stock MM0 require complete semantics and closed acceptance, while a specialized checker has a separate implementation/translation trust obligation. No measured saving or foundation-preserving native implementation follows from this packet.

## Verified pins

| File | SHA256 |
|---|---|
| Author note | `55052C31D2DEFD00CAB9DB99CC1E947C4E14E509FDF0ED376E20374A1F6C0F54` |
| `prime-estimates/efficiency_source_sieve_sizes_20261111.py` | `0C46B460A9B3DE54126802EB03F2AA58BC2AABEA3DF462CE02B0EC28EB8A3184` |
| `prime-estimates/efficiency_source_sieve_sizes_20261111.json` | `417FB7D5849794C97852BE6BD8C15D12E4004F1B6A198CD66C267D7513E6C3CE` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/PsiSieve.lean` | `B4FB6979014B6B2AD516E775A45EAD01DD544BF9828948C7F512DCDC16596652` |
| `work/ternary-goldbach/TernaryGoldbach/Prelim/PsiSieve3.lean` | `36309975B0656C69E2659A685963BD1955B24096AC99BA8A23B7193A48111ED3` |

The audit confirms a sound conditional certificate design, with the complete-base, indexing, scheduler and source-binding gates still to implement and validate. It is not a new prime certificate or proof of binary Goldbach.
