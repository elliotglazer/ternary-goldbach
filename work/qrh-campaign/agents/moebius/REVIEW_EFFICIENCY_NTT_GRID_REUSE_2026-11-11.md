# Independent review of NTT grid reuse

2026-11-11. Verdict: PASS at paper acceptance, exact grid/count and conditional proof-reuse scope. No correction is required. The 64-transform result is an arithmetic subtotal with a raw-cache size, not an implemented memory bound, successful prime coverage or measured speedup.

Reviewed frozen files under `work/qrh-campaign/agents/prime-estimates`:

| File | SHA256 |
|---|---|
| `EFFICIENCY_NTT_GRID_REUSE_2026-11-11.md` | `84F02A3867A371313E81CC89664293986C52EC515EED2B2046BFCB0D94097738` |
| `ntt_grid_reuse_sizes_20261111.py` | `2F2AA424A7F21A3461A24DB5823CE533FAF2F10DB17CBC7AE66E23A92DC6EDAB` |
| `ntt_grid_reuse_sizes_20261111.json` | `04D2F14172FFCC36D77C7955D2E279251581093D754163C988796871A089DB8F` |

I read the complete note and script and independently checked the receipt with a separate integer calculation. All 254 checks passed, covering six grids, 24 cache settings, both strip orientations, operation counts, ratios and raw storage. I did not import or execute the author script. No prime, root, transform, analytic value, proof stream or build was evaluated. Only this new review was written.

## Exact inputs and boundary coverage

For R=floor((B/2)/L), blocks 1 through R-1 have full width L. The final width w_R=B/2-RL+1 is in [1,L], including width one when L divides B/2. With J=ceil(L/W), each full block has J tiles, while the last has ceil(w_R/W). Hence C=(R-1)J+ceil(w_R/W). The separately retained initial L-2 targets make the complete count B/2-1. There is no missing endpoint or erased initial proof.

At tile origin a_j, its nominal width v_j satisfies a_j+v_j<=L. The source vector has length v_j+D and its last index is a_j+v_j+D-1<=L+D-1. It is independent of the outer block. For a short final cell, keeping this full nominal vector is sound: only targets x<w_(r,j) are consumed, while the full convolution and its zero padding remain checked. Truncating the source to the final cell and then reusing the old transform without an equality proof would not be sound; the report does not do that.

The block histogram A_r[z] counts offsets with D-s=z. Thus its convolution coefficient D+x equals sum_i P[a_j+x+s_(r,i)]. The actual anchors remain q_(r,i)=2rL-(2s_(r,i)+1), with their own prime proofs. Equal histograms in two rows do not make those different anchor integers equal or transfer their primality. Reuse concerns the numerical transform theorem; target consumption still needs the row's genuine prime facts and exact sum identity.

The one-prime NTT contract survives unchanged with T>=W+2D and p>m_max. The short nominal product has degree below v_j+2D<=T, so there is no cyclic wrap. Every claimed coefficient and all T transform frequencies remain bound and checked; non-target coefficients are not arbitrary padding.

A partially successful pass needs a sound residual update, not the old terminal condition falsely asserted on the whole residual. Let H be the exact mask of target coefficients proved positive. Then R_new=R AND complement(H), within the cell mask, retains precisely the unproved obligations. The convolution identity proves every newly discharged target. This immediate adapter follows from the reviewed residual invariant but remains eventual formalization work. A terminal pass must still prove R_new=0 or supply further complete children/witnesses. The report preserves those obligations and does not assume a fixed anchor set covers a cell.

## Cache theorem and grid schedules

At fixed p,T and root/permutation convention, a cache entry must prove the full transform of its exact input vector. A hash or equal length does not establish that vector equality. The report retains this condition for both source and histogram inputs.

For one fixed anchor set per row, full reuse computes at most J source transforms, R anchor transforms and C coefficient transforms. Optional equality-based reuse of identical pairs could reduce that count, but is not assumed in the grid tables. If anchors vary by tile, the right-vertex count can grow to C or beyond across passes. If span normalization changes source origin, source length or transform length, the old J bound no longer follows. The general bipartite graph count correctly exposes these cases.

In a tile strip of at most c columns, each source transform is computed once and each row's anchor transform is computed at most once per strip. This gives J and R*ceil(J/c). The row-strip argument exchanges their roles and gives J*ceil(R/c) and R. Absent final-row cells only lower these bounds. The stated schedules may harmlessly compute unused nominal inputs, so their formulas remain conservative even in a small degenerate grid.

For two-dimensional shards with at most r_b rows and j_b columns, each source input is recomputed at most ceil(R/r_b) times, and each anchor input at most ceil(J/j_b) times. Thus the stated upper counts J*ceil(R/r_b) and R*ceil(J/j_b) are correct. Every actual cell belongs to exactly one shard when the partition is bound to the grid indices. A shard at the outer boundary must export its bounding rectangle intersected with the valid-cell and target-width predicates; it cannot assert additional prime representations beyond B. This is the precise interpretation of the report's requirement to process actual cells and retain all boundaries.

Discarding a cache does not discharge an unresolved cell. A row/rectangle proof must export the exact coverage or residual state that later composition consumes. Logical reordering, input reads, primality references and this composition have costs independent of the saved numerical transforms.

## Exact subtotal and memory check

For T=2^21, ell=21, one dense transform uses

    mu = sum_(s=1)^21 [T/2-T/2^s] = 19922945 products,
    alpha = sum_(s=1)^21 T = 44040192 additions/subtractions.

The isolated grid uses C(3mu+T) products. Full reuse uses (J+R+C)mu+CT. Their difference is exactly (2C-J-R)mu. The limiting shared per-cell count is 22020097, while isolated cells use61865987. This leaves every point product and coefficient transform in the bill.

For B=10^16,L=2^32, the exact values are R=1164153, J=16384 and C=19073469945. With c=64, tile strips compute J source and298023168 anchor transforms. Their product subtotal is425937483917805305 versus1179999043662260715 for isolated cells. The exact ratio is

    85187496783561061 / 235999808732452143,

which lies strictly between .3609642 and .3609644. This confirms the approximately36.1 percent claim. The corresponding row-strip subtotal is425960386558382450, slightly different because its ceiling and boundary costs differ. The report does not identify the two finite schedules.

All six C values, all strip transform counts and both orientation totals matched the independent calculation. It also reproduced the full-cache ratios, additions, logical operand counts and raw bytes. The c=64 retained outputs occupy exactly536870912 bytes, or512 MiB. This is only64 transforms of4T bytes each. The current source/anchor/coefficient buffers, root table, proof terms, quotient witnesses, source and anchor facts, row residual state and allocator overhead are additional. In particular the claim is not a512 MiB total-process guarantee.

The full-source cache sizes of128 GiB,512 GiB and2 TiB, and the stated full-anchor cache sizes, follow from the same4T-byte convention. Logical operand traffic8CT bytes is not a disk-I/O lower bound; actual residency and repeated values can change physical traffic. Proof-store retention or reclamation has not been implemented by these arithmetic counts.

## Checked context and competing methods

A fresh ordinary-MM0 check cannot import a previous shard's hash as an axiom. Reusing a theorem requires the same already checked context, replay of its proved prefix, or placement in a single ordinary proof stream after the declaration. The report explicitly charges repeated prefix cost H once per fresh check where applicable. Root tables, source primality and anchor proofs have the same provenance requirement. This prevents the transform saving from being obtained merely by moving verification into an uncharged cache.

The earlier narrow-span isolated count13893635 is less than the broad-envelope shared limit22020097. This does not settle the full cost, but correctly blocks a claim that reuse always defeats span normalization. Narrow-span histograms can also be reused when their actual values and parameters agree. Residual OR benefits from the same genuine source/anchor proofs and is not artificially charged one fresh prime proof per cell for this comparison.

The accepted result is therefore a conditional reduction in a named arithmetic stage, with exact input identity, coverage, finite-field and context obligations retained. It establishes neither a complete anchor search nor that the backend can retain or efficiently consume the cache. The predecessor NTT author/review pins are `9B212F658CCDE0E72FD255C751604C969A54D5B231D661BC5183E66E8E8368CA` and `940CCAC47E7DFF360297CF713A4456E345E47E18D55F1D5A9A9295CDB1AD44DE`; the residual contract remains `EEED5871CE2A7737F01D92CDBC0D362BA42307FF58D0A1192892989C4FBF8436`.
