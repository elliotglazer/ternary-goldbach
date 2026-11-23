# Review of finite-binary incidence-column acceptance

2026-11-11. PASS at conditional paper/source and fixed-dimension scope, jointly with the mandatory fallback-setup companion. No further correction requested. The proposal gives an equivalent finite acceptance test and a conditional complete-cost comparison; it supplies no actual dictionary, prime anchors, successful coverage, useful K, reuse distribution or runtime improvement.

Reviewed frozen author: independent-feasibility/FINITE_BINARY_INCIDENCE_COLUMN_RECOMMENDATION_2026-11-11.md, SHA256 `58551C27EEB2D8E80F9F5762B00D6406CA5723F14C2868391C84C102FB464B37`.

Required companion: independent-feasibility/CLARIFICATION_BINARY_COLUMN_FALLBACK_SETUP_2026-11-11.md, SHA256 `6B6D38B57D0E18A940BF06C0496CBD7E65B4F16E750E490EDF5A9878095CB56C`.

I read both in full, the bounded clause compiler and its review, source-bitmap/block geometry, and the actual binary statement and SmallCases consumer. I inspected the author's scalar script without importing or running it and checked its saved dimensions directly. All four packet hashes and all fourteen prerequisite hashes in the receipt match. No new inventory, Boolean-mask enumeration, prime or function evaluation, build, declaration or proof emission occurred. Frozen files remain unchanged.

## Source provenance and complete target coverage

The actual target `Statement.lean:26-27` is coverage of every even n with 4 <= n <= B. The pinned `SmallCases.lean:21-40` consumes binary coverage through 4*10^18, first with prime 3 and then with the actual prime ladder. It does not already implement the proposed smaller-B/N0 replacement. The author correctly retains that separate source/assembly obligation.

For the nonempty outer-block geometry retain B=2E, E>=L, L>=D+2 and J=L+D from the consumed compiler. The initial range contains L-2 even targets. Outer blocks r=1,...,R, R=floor(E/L), have widths min(L,E-rL+1). Thus

    (L-2)+(R-1)L+(E-RL+1)=E-1.

In particular E divisible by L gives a last block of width one, not zero. A tile manifest must cover each actual block interval, including exceptions and partial tiles. If E<L there are no outer blocks and the direct initial-range proof must cover the requested smaller range; the displayed R>=1 decomposition is not used in that case. No saving may come from omitting the initial obligation or its larger size after changing L.

For natural t0,t,s with t<W, t0+W<=L and s<=D,

    t0+t+s <= L+D-1 < J.

Also r>=1 and L>=D+2 imply 2rL-(2s+1)>=3. Consequently natural subtraction has its intended integer value and the exact sum identity is

    2(rL+t0+t) = [2rL-(2s+1)] + [2(t0+t+s)+1].

The two primality facts have distinct origins. The first must be supplied for the actual block r and palette offset s; availability is not inferred from a hopeful mask or from the same offset in another block. The second follows only from the same actual source object's positive bit and its checked prime theorem. The source need not contain every prime, and a missing bit proves no compositeness. A survivor-based source proof still needs its own complete base-divisor list. Index zero and prime 2 retain their separate source/base treatment.

## Exact equivalence, with its necessary domain restriction

Let H_t be the actual source row on the fixed palette. The accepted compiled certificate has nonempty clauses C_j, each equal to H_(tau_j) for a checked tau_j<W, and every H_t contains at least one C_j. These are two independent premises.

If A hits every C_j, choose a contained clause for a target t; a hit in that clause is a hit in H_t. Conversely if A hits every H_t, specialize at tau_j to obtain a hit in C_j. The actual-row equality is essential for the converse. A merely sufficient subclause could impose a stronger test than direct same-palette coverage. Neither equivalence asserts all possible Goldbach representations or the existence of any prime availability set.

For each palette index i, the proposed exact column has K bits with

    bit(V_i,j)=1 iff i belongs to C_j.

Induction over the finite actual list A gives

    bit(OR_(i in A) V_i,j)=1 iff A intersects C_j.

With checked zero high padding, equality to the K-bit all-ones mask is therefore equivalent to all K clause hits, hence to direct coverage by this P, palette and A on the compiled full tile. No arithmetic values or finite enumeration are needed for this quantified proof. Empty A fails because K>=1. Sorted distinct A justifies using a as its cardinality; allowing duplicates would require counting their actual repeated work.

The author preserves the important prefix limitation. Restricting a proved full-tile coverage conclusion to a shorter final prefix is sound, but the full-tile clause test need not be equivalent to direct coverage of that prefix. A dedicated prefix certificate or direct fallback has its own correct cost. Likewise, failure of an exact full-tile column test cannot be rescued by the same full-tile direct test with unchanged source and A: the two are equivalent. Recovery needs additional certified anchors, another palette or a genuinely complete different residual/witness certificate.

## Column construction and ordinary proof bindings

The K*M transpose bindings are a conservative sufficient construction cost, not a mandatory lower bound or an already checked table. Every packed bit must be linked to the same accepted clause data, palette, source and tile. A hash or native transpose establishes none of those mathematical facts.

The subsequent OR fold must use proved finite-word semantics, correct indices and the exact last-word mask. The array-access representation, source/anchor references, range proofs, word assembly and the final equality are charged. A native word OR is not one ordinary proof command or one Lean kernel step. Generic correctness of the fold does not check its concrete operands for free.

Once the transpose theorem is actually established, raw row storage can be released only if its surviving theorem and required definitions are still available through legitimate proof references. Separate worker environments or theorem-local resets can require re-establishment/import. Keeping a data array or its digest is not the same as retaining a checked theorem. Source-cover premise checking and its genuine environment lifetime remain part of setup; the column circuit does not replace them.

## Dimension checks and cost comparison

I independently reconstruct the fixed example: M=512, K=1024, a=16, w=64 gives b_M=8 and b_K=16. The specified complete row scan has 8192 ANDs, 8192 ORs and 1024 nonzero tests. The column scan has 256 ORs and 16 final equalities. Each packed orientation occupies 512*1024/8=65536 raw bytes, and retaining both uses 131072 raw bytes before proofs and other state. The naive transpose has 524288 bit bindings. These exact dimensions say nothing about real clause size, anchors, coverage success or reuse.

The schedules intentionally retain initialization and all non-Boolean work in their extra terms. They compare a prescribed full row scan, not a lower bound on early-exit rows or sparse witness lookup. The sparse K-witness alternative must include its memberships, indices, actual anchor facts and lookup costs. A mathematical minimum over interfaces is not free selection or free common setup.

For an already checked common dictionary, the proposed condition

    S_trans < sum_selected (D_i-Col_i),

together with Col_i<=D_i on selected uses, proves a strict reduction in the one specified complete additive cost coordinate. Its homogeneous threshold N>S_trans/(D-Col) requires D>Col and actual valid reuse. It proves no useful N or favorable price. Setup, search attempts, transports, storage and worker copies remain in the correct account. A difference of unrelated upper bounds cannot be promoted to a saving.

The companion is mandatory for cold comparisons. The correct new-side cost includes

    C0 + S_trans + S_dir,new
       + sum_selected Col_i + sum_fallback Direct_i,

against S_dir,old + sum_all Direct_i. If fallback needs the complete original direct setup, its new and old charges cancel rather than producing a refund. Partial caches, shared imports and copies must receive their actual union/lifetime costs. Different source or anchor sets require their differential production and proof costs as well. The same rule applies to a four-way Direct/Row/Witness/Column portfolio.

Generation, proof construction and checking require separate prices. Failed compiler or prime searches are not refunded when a final artifact chooses fallback. The retained bounded compiler caps are not permission for unlimited palette attempts. Without actual K, a, source/anchor certificates, reusable environments and complete backend prices, no saving or ranking follows.

## Bounded verdict and pins

The recommendation is mathematically sound when read with its companion and inherited geometry. It adds one equivalent finite representation with explicit admission and amortization conditions. It does not change the Goldbach target, approve a smaller binary hypothesis as the original one, supply a certified ladder, or discharge principal/spectral/library obligations. No new proof-implementation or runtime claim is accepted.

Packet pins verified here:

| Artifact | SHA256 |
|---|---|
| Author | 58551C27EEB2D8E80F9F5762B00D6406CA5723F14C2868391C84C102FB464B37 |
| Required fallback-setup companion | 6B6D38B57D0E18A940BF06C0496CBD7E65B4F16E750E490EDF5A9878095CB56C |
| independent-feasibility/finite_binary_incidence_columns_20261111.py | 1CC91FB078BD04C7B0F159B01298130A6F3B0AE3B9AE60A656FFCC8BB9CEEE07 |
| independent-feasibility/finite_binary_incidence_columns_20261111.json | 9E8D91BE1EA98F7D5229032B24C15C0BB16FB855F58AB86EE7706F77C7E277E9 |

The receipt's fourteen prerequisite entries were individually hashed and matched. Decisive source identities are:

| Workspace-relative source | SHA256 |
|---|---|
| work/ternary-goldbach/TernaryGoldbach/Statement.lean | 3F61837D2C3A0DDE3A1997F05AF21C20C7FE6EE13E29891125495F6947596BF8 |
| work/ternary-goldbach/TernaryGoldbach/Helfgott/SmallCases.lean | 61B94AFA308E82B7C8D9DA927CE5EB18F8847F9D58554589E4A28F5A2B7BF359 |
| work/qrh-campaign/agents/major-constants/BOUNDED_BINARY_CLAUSE_PROOF_REPRESENTATION_2026-11-11.md | A43E9F4B180D0406BE0BC147DD793BD4DEE8F83F44BF86E57BA1479BB19279E3 |
| work/qrh-campaign/agents/zero-sum/REVIEW_BOUNDED_BINARY_CLAUSE_PROOF_REPRESENTATION_2026-11-11.md | F4B77426B389262CD4169DC5F8E58C58A0BBA5176C44048496C5270F4E4FA777 |
| work/qrh-campaign/agents/independent-feasibility/BINARY_SOURCE_BITMAP_COST_DESIGN_2026-11-11.md | 4B877FC2377CEB81C60CE139331ED5380AB0CB78011DE500D8768B2F837B99EA |

The author's 23 checks concern hashes and fixed dimensions only; this review does not recast them as actual coverage evidence. No independent execution of that script or new enumeration was performed.
