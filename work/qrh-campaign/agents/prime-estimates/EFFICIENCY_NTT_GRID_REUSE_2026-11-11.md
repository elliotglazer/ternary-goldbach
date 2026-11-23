# Reusing exact NTT proofs across the binary coverage grid

2026-11-11. Supplement to the independently reviewed large-product NTT design. Only integer geometry and proof-template arithmetic were executed. No arrays, primes, transforms, modular values, proof streams or benchmarks were generated; no builds ran. Existing files remain unchanged.

## Main conclusion

For a fixed halo D and source origin convention u=0, the source transform depends on the tile, while the anchor transform depends on the outer block. If one common anchor multiset is used across that block, a complete R-by-J grid needs J source transforms, R anchor transforms and one coefficient transform per cell. For C actual cells, the product count falls from C(3mu+T) to (J+R+C)mu+CT, where mu is the nonunity product count of one transform. This is an arithmetic reuse statement, conditional on the supplied source, anchor and coverage certificates.

A full transform cache is not necessary for most of this saving. A strip of c cached source transforms permits J source transforms and at most R ceil(J/c) anchor transforms; its asymptotic product cost per cell is (1+1/c)mu+T. The symmetric row-strip schedule exchanges source and anchor roles. At c=64 and the broad-halo geometry, raw retained transforms occupy 512 MiB and product counts are about 36.1% of isolated leaves. Proof storage, indexing, primality provenance and input rereads are additional costs, so this is not a runtime or memory-feasibility claim.

Nor does reuse justify discarding span normalization: the broad-envelope shared limit still uses more products per cell than an isolated narrow-span transform in the earlier example.

## 1. Exact grid, input arrays and final boundary

For even B put E=B/2. Assume L>=2 and E>=L. Let R=floor(E/L); blocks are r=1,...,R with width w_r=min(L,E-rL+1). The initial range 4<=n<2L remains separately proved. In particular w_R=E-RL+1 is positive even when L divides E, when it equals one. The identity

    (L-2)+(R-1)L+w_R=E-1

counts all even targets, with no missing boundary and no credit for transferring more work into the initial proof.

Choose nominal tile width W, J=ceil(L/W), a_j=jW for 0<=j<J and v_j=min(W,L-a_j). A cell (r,j) exists iff a_j<w_r. Its required width is w_(r,j)=min(v_j,w_r-a_j). Consequently

    C=(R-1)J+ceil(w_R/W).

For each nominal tile define the full source vector

    Q_j[z]=P[a_j+z], 0<=z<v_j+D.

This is independent of r. Its greatest source index is at most L+D-1, including a short nominal tile. For the actual short final cell, reuse this **nominal** source vector; restrict required target indices to x<w_(r,j). Extra nominal coefficients are arithmetic padding/unused outputs, not extra prime-sum assertions about targets beyond B.

For block r choose a nonempty multiset of offsets s_(r,i) in [0,D]. Each must bind to a proved prime q_(r,i)=2rL-(2s_(r,i)+1)>=3. Fix the whole multiset across that pass over the block. Define

    A_r[z]=#{i:D-s_(r,i)=z}, 0<=z<=D.

Then the exact convolution coefficient at D+x is

    (Q_j*A_r)[D+x]=sum_i P[a_j+x+s_(r,i)].

The prime-sum identity for an actual cell is 2(rL+a_j+x)=q_(r,i)+(2(a_j+x+s_(r,i))+1). It uses the same source positions and actual block-dependent anchor primes. Sharing the numeric histogram does not share the primality of different anchor values.

Let m_r be the multiset size; the earlier one-prime NTT certificate applies with a bound m_max>=m_r, p>m_max, and common T>=W+2D. Pad every vector to T, including a short nominal source tile. There is no circular wrap, because its product support is below v_j+2D<=T. The complete claimed coefficient vector remains checked at every one of the T transform frequencies. Its non-target coefficients may not be freely omitted.

No assumption says these anchors cover even one tile. A pass checks its actual positive-coefficient mask against the current exact residual. Remaining bits must survive into another pass, a split, or explicit prime witnesses. A common anchor set can be tried across a block without requiring that it alone covers the block.

## 2. Exact reuse and general cache admission

For fixed p,T, an admissible cache entry contains a theorem bound to the full exact input vector and its full exact output transform. Its input is not merely an offset, length or hash. Source entries additionally bind to the actual indexed source bitmap; anchor entries bind to the actual histogram. A hash may locate candidate bytes but is not evidence of equality or primality.

For one fixed successful pass at each block, checking F(C_(r,j))=F(Q_j)F(A_r) uses each cached input transform without recomputing its numeric proof. The coefficient transform is still new for a new input pair. Bit reversal, roots and table parameters must agree. Do not reuse a transform across a modulus or length change without a proved conversion.

More generally form a bipartite graph whose left vertices are **distinct actual source vectors**, right vertices are distinct actual anchor histograms, and edges are the input pairs whose convolutions are checked. Fix parameters within each graph. With N_Q left vertices, N_A right vertices and N_E distinct checked pairs, full admitted reuse needs

    (N_Q+N_A+N_E) transforms and N_E*T point products.

Every cell/pass occurrence still needs its own residual, source-prime and target-index consumption. If exactly the same pair appears repeatedly, its convolution theorem can also be reused; this optional equality-based sharing is not credited in the R,J,C examples. Failed producer attempts that are not serialized are still generation work.

If a later pass uses another block-wide anchor set, it adds a right vertex (unless identical) and edges only for the cells checked in that pass. Source transforms remain reusable. If anchor choices vary per tile, N_A can grow to the number of cells/passes; the R bound then fails. If offsets are normalized by varying u or d, Q depends on (a+u,v+d), and T may change. Group matching arrays into parameter-compatible cohorts; there is no automatic J source bound across these cohorts. Equal d alone does not make different origins equal.

The fixed-envelope option deliberately pays the full D span to maximize potential reuse. It is a choice, not a proof that full-envelope arithmetic is cheaper.

## 3. Modular-operation arithmetic

For T=2^ell set

    mu=T*ell/2-(T-1),     alpha=T*ell.

These are the nonunity modular products and modular additions/subtractions in one dense radix-2 forward transform. The common root table costs T/2-1 setup products, with separately checked prime/root support. The isolated and fully shared grid costs are

    M_iso=C*(3mu+T),          A_iso=3C*alpha;
    M_shared=(J+R+C)*mu+CT,   A_shared=(J+R+C)*alpha.

Thus the exact product saving is (2C-J-R)mu for this schedule. When both dimensions are large, the ratio approaches (mu+T)/(3mu+T); it does not approach zero. All CT point products and all C coefficient transforms remain.

At W=2^18,D=2^19,T=2^21,ell=21, mu=19922945 and alpha=44040192. Isolated cells use 61865987 products; the shared limiting cost is 22020097 per cell, ratio 22020097/61865987. This is about .35593, before additions and all structural costs. With the prior conditional 32-bit modulus/byte-PA template, multiply these product counts by Q(4)=205 and price additions separately. This conditional template does not certify existence of a chosen modulus or implementation speed.

The exact integer script reproduces the existing full-cell counts:

| B | L | R | J | C |
|---:|---:|---:|---:|---:|
| 10^16 | 2^32 | 1164153 | 16384 | 19073469945 |
| 10^16 | 2^34 | 291038 | 65536 | 19073420793 |
| 10^16 | 2^36 | 72759 | 262144 | 19073224185 |
| 2*10^16 | 2^32 | 2328306 | 16384 | 38146956273 |
| 2*10^16 | 2^34 | 582076 | 65536 | 38146907121 |
| 2*10^16 | 2^36 | 145519 | 262144 | 38146710513 |

The first three full-cache product ratios are approximately .3559521, .3559382 and .3559379. These counts exclude the initial recursive coverage and assume the stipulated one-pass geometry; actual fallback work adds to them.

## 4. Strip schedules: most arithmetic reuse without a full cache

Two complete schedules need only c retained transforms plus current working arrays:

* **Tile strips:** retain up to c source transforms; stream every outer block and compute its anchor transform for this strip; process its existing cells in the strip. Then discard that strip and continue. Source transforms: J. Anchor transforms: at most R ceil(J/c).
* **Row strips:** retain up to c anchor transforms; stream all nominal source tiles and process existing cells of this row strip. Source transforms: at most J ceil(R/c). Anchor transforms: R.

Both still compute exactly C coefficient transforms and CT point products for their actual cells. These transform counts are upper bounds: a strip containing no actual final-row cell need not compute that final-row anchor, and a final row-only strip need not visit its absent columns. The script deliberately retains the safe upper bounds.

For either schedule its product bill is (N_Q+N_A+C)mu+CT, using these recomputation counts rather than the full-cache counts. Root tables can remain shared. At B=10^16,L=2^32 the tile-strip product ratios versus isolated leaves are:

| c | raw retained transforms | upper product ratio |
|---:|---:|---:|
| 1 | 8 MiB | .6779666 |
| 8 | 64 MiB | .3961868 |
| 64 | 512 MiB | .3609643 |
| 512 | 4 GiB | .3565615 |

These are not peak memory figures. Current input/output buffers, root tables, proof terms, quotient witnesses, source/anchor records and residual state are additional. The two orientations differ in source and anchor rereads, prime-reference lookup and range-assembly order. A source-strip sweep repeatedly streams block anchor metadata; a row-strip sweep repeatedly streams source tiles. Those costs must be measured rather than hidden in the transform saving.

The one-pass mathematical coverage proof can aggregate cell certificates in either order. An implementation still needs a checked grid permutation or row-prefix invariant. It cannot forget unresolved cells when discarding a cache strip. Keeping a small number of row accumulators is a possible proof architecture, not evidence that the current MM0 store releases all prior objects.

Each row strip can instead be an independently checked shard: admit its at most c anchor transforms, compute each source transform once in that shard, finish its row-range theorems, and discard the shard's arithmetic context. This explicitly recomputes the source transforms ceil(R/c) times, rather than assuming their statements survive globally. To bound both dimensions, shards of at most r_b rows and j_b columns have source/anchor transform upper counts J ceil(R/r_b) and R ceil(J/j_b). Each shard processes its own actual cells and exports a precise rectangular coverage statement; checked rectangle/range assembly retains all boundaries and the initial proof obligation. Raw retained input transforms are at most 4T(r_b+j_b) bytes if both sides are held, or less when one side is streamed. The C coefficient transforms are unchanged.

A fresh ordinary-MM0 check may not treat a previous shard's theorem or a library/source hash as a new axiom. It must replay the required proved prefix, or use a correctly preserved previously checked context, or be composed into an ordinary proof stream whose cited conclusions are already proved. If fresh shards replay a prefix of cost H, charge H times the number of such checks, plus serialization and the final checked composition. The source primality, anchor primality, root-table and generic NTT statements obey this rule too. Independent shard checks can bound live arithmetic data; they do not by themselves establish safe context snapshots, proof-store reclamation, or zero-cost imports.

## 5. Full caches, I/O and actual proof sharing

For 32-bit residues each transform has 4T=8 MiB of raw output. Full source caches for L=2^32,2^34,2^36 require respectively 128 GiB, 512 GiB and 2 TiB. At B=10^16 the full anchor caches require 9765623169024, 2441403695104 and 610346729472 bytes. Source primality bitmaps are much smaller and are separate objects. Persisting all transforms to disk avoids numeric recomputation but does not make retrieving them or their proof references free.

For the explicit point-product circuit, the two input arrays account for 2CT logical residue operands (8CT raw bytes at 32 bits). This is an accounting measure for that schedule, not a disk-transfer lower bound: cache residency, compressed/repeated values or fusion can change physical traffic. The C coefficient transforms and output/range checks also read data. A producer and independent checker may make separate passes.

In Lean, an admitted concrete transform theorem can avoid reducing its original proof again, but consuming indexed values may still traverse or normalize large encoded arrays. In ordinary MM0, a theorem application need not repeat its proof, but statement unification, term references, array equality and actual modular gate proofs remain. The model does not presume constant-time selection from a huge natural numeral or free garbage collection. A specialized checked memory model is additional work, not an ordinary PA inference supplied by a cached hash.

Root/prime support can be globally reused only at matching parameters. Source and anchor primality proofs have different semantic lifetimes from the transform cache and must remain available through later target consumption.

## 6. Reuse versus small spans and residual work

The earlier narrow scenario W=2^18,d=4096 has T=2^19 and isolated cost 13893635 products per cell. This is already less than the full-envelope shared limit 22020097. If the normalized histogram stays fixed per block while origins vary, its transform can still be shared across the block, giving approximately two transforms plus point products per cell; only the common J-source bound is lost. Conversely, identical origins/spans within a cohort can share source transforms. Choose using actual vector identities and the full graph, not labels such as 'cached' or 'normalized.'

Direct residual word-OR also benefits from the same already certified source table and anchor proofs. It need not inspect already discharged words if its completeness invariant is proved. It does not acquire an artificial R*J input-proof penalty merely to make NTT attractive. Compare the reused NTT bill against the actual residual-update schedule, unbalanced packed multiplication and their respective provenance costs.

A bounded future test should use several rows and columns of the same immutable accepted inputs, compare both strip orientations and isolated checks, and report numeric proof generation, theorem admission, repeated use, object memory and traffic separately. The present result authorizes no execution or claim of coverage. It identifies a reusable arithmetic structure and preserves all unsolved source, anchor, residual and backend obligations.

## Source and artifact pins

* `work/qrh-blueprint/BINARY_BLOCK_SCALING_2026-11-11.md`: 982115AD458F718039B391DAEA714E25C5E80823C49B537ED78FEC8F155480CD.
* `moebius/EFFICIENCY_BINARY_COVERAGE_2026-11-11.md`: EEED5871CE2A7737F01D92CDBC0D362BA42307FF58D0A1192892989C4FBF8436.
* `prime-estimates/EFFICIENCY_MM0_PACKED_NTT_2026-11-11.md`: 9B212F658CCDE0E72FD255C751604C969A54D5B231D661BC5183E66E8E8368CA.
* Independent NTT review `moebius/REVIEW_EFFICIENCY_MM0_PACKED_NTT_2026-11-11.md`: 940CCAC47E7DFF360297CF713A4456E345E47E18D55F1D5A9A9295CDB1AD44DE.
* Integer-only script `ntt_grid_reuse_sizes_20261111.py`: 2F2AA424A7F21A3461A24DB5823CE533FAF2F10DB17CBC7AE66E23A92DC6EDAB.
* Exact size receipt `ntt_grid_reuse_sizes_20261111.json`: 04D2F14172FFCC36D77C7955D2E279251581093D754163C988796871A089DB8F.
