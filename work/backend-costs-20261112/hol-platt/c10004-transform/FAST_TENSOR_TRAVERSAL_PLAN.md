# A linear-traversal consumer for the frozen transform reference

13 November 2026. Source-only implementation plan. No builds, values,
benchmarks or changes to the frozen transform were made. This note proposes
the next traversal implementation; it does not claim that an existing HOL
evaluator already applies these transformations.

The frozen reference is useful for correctness and exposes a serious timing
limitation. `tx_pair k xs` follows k list tails. Its first tensor pass fetches
each input index0..4799 once, so a direct execution visits
`4800*4801/2 = 11522400` input-list cells just for those fetches. That pass
should instead consume the4800 cells once. `tx_flatten` also indexes row lists
repeatedly. A timing of this reference cannot be presented as the intended
production traversal cost.

The replacement must preserve the exact integer outputs, root objects,
summation order and rounding operations. It changes traversal and ownership
of containers, not the arithmetic graph. The outer full-versus-selected
theorem is being developed separately. This implementation should refine
`tx_tensor_selected` directly and then use that theorem, rather than duplicate
its proof or assume it.

## Concrete outer traversal

Proposed executable helpers use option results for malformed shapes:

```
pair_differences : ipair list -> ipair list option
chunks_exact : num -> num -> 'a list -> 'a list list option
transpose_exact : num -> num -> 'a list list -> 'a list list option
concat_rows : 'a list list -> 'a list
fast_selected : prepared_plans -> ipair list -> ipair list option
```

Implement `chunks_exact width rows` with a head/tail split loop that returns
both the next row and the unconsumed suffix. It must not restart a `DROP` or
indexed lookup from the original list for each row. A reversed row accumulator
followed by one reverse per row is acceptable; it makes the extra traversal
and allocation explicit.

Implement `transpose_exact rows cols` by repeating this operation cols times:
scan the current row-list once, remove one head from every row, and return the
column plus the list of remaining tails. This uses exactly rows*cols data-head
extractions. Reverse the accumulators once per column to preserve row order.
At completion verify that every row is empty. Empty, short, extra or ragged
input is rejected, not filled with default zero. No operation calls an indexed
lookup on a whole data array.

The c10004 program then follows this order:

| Step | Traversal and exact order | Data size |
|---|---|---:|
| 1 | Consume adjacent pairs, output `tx_sub x0 x1`. Input is `2*(40*j61+j41)+j4`. | 4800 input cells;2400 results |
| 2 | Split once into60 rows of40, preserving ascending j61 and j41. | 2400 cells |
| 3 | Apply the fast omit-zero40 transform to each row. Retain row nesting. | 60 rows of39 |
| 4 | Transpose the60-by39 result using head/tail extraction. | 2340 data-head extractions;39 rows of60 |
| 5 | Apply the fast omit-zero60 transform to each row in ascending k41. | 39 rows of59 |
| 6 | Concatenate each output row once, preserving ascending k61. | 2301 output cells |

The result order is exactly `59*(k41-1)+(k61-1)`. There is no intermediate
global flattened array between steps3 and5. All2400 axis2 subtractions,
the60 length40 transforms and39 length60 transforms remain. The first step
is the literal length2 omit-zero operation, so it does not compute and discard
the unused sum.

Separate input validation can cost one additional4800-cell pass and output
validation one2301-cell pass. Fuse bounds/shape checks into consumption only
after proving that the same `tx_input_ok` and `tx_output_ok` predicates are
enforced. Preserve the public NONE/SOME behavior. These validation costs are
not removed by better indexing.

Concatenation should be a structural row append, or one reverse-accumulate
pass followed by a final reverse. Do not use a left fold of append onto an
ever-growing prefix. The latter recreates the quadratic problem.

## Small-node traversal is also real work

The outer plan can first call the unchanged `tx_omit` on each40/60-element
row. This already removes global quadratic lookups, and is a useful first
refinement checkpoint. It still pays repeated small-list indexing inside
each CT node. Do not call that version a fully linear inner implementation.

The intended next helper is a fixed-plan CT evaluator with the following
passes at a node n=r*m, r=2 or3:

1. Deal successive input groups of r elements into r row accumulators, then
   reverse each once. This creates the rows `x[a+r*b]` with one input pass.
2. Transform each m-element child using the same fixed subtree and root
   centers as the reference.
3. Transpose the r child rows into m columns of r elements using head/tail
   extraction. For column v, apply the same cross-root actions a*v in a=0..r-1
   order. No child or bridge product is recomputed for another output.
4. Compute the r-point final row with the same direct arithmetic. For v0 in
   an omit-zero node, compute only u=1..r-1. For other v, compute all u.
5. Collect each result into its u-specific accumulator while v increases.
   Reverse the r accumulators, then concatenate u0,u1,... . In the pruned
   case u0 contains v1..m-1 and the other rows contain v0..m-1. This gives
   k=v+m*u in ascending order with k0 absent, without evaluating k0 or
   constructing a numerical dummy for it.

Because r<=3, use explicit pairs/triples of accumulators or a bounded r-list.
Do not dynamically index a growing n-list to deposit each result. The direct
3/5 leaf scans its input left-to-right for each output row; that is at most
five short scans and preserves the reference's summation order. Its existing
quadratic arithmetic in the leaf length is not being removed, and the leaf
length is bounded by5.

For structural cost, each composite node has a fixed number of linear passes
over n values, plus r recursive m-child traversals and at most r*n final-row
operand visits. Thus a bound has the form
`T(n) <= r*T(m) + (c_deal+c_transpose+c_bridge+c_collect+c_reverse+c_join
 + r*c_direct)*n`, with implementation-specific constant operation prices.
The largest selected trees have only three composite levels before a3/5
leaf. This establishes the intended linear structural scaling for these
fixed40/60 transforms; it is not an opcode count or wall-time bound.

Every reverse, row-spine construction, pair match, bounds check and option
branch remains an operation to count and measure. The fast consumer still
has to allocate its output and usually at least one transpose representation.
Persistent functional values are not mutable arrays merely because the
mathematics permits overwriting them.

## Root access and prepared plans

The reference repeatedly searches a nine-row cache and then a list of up to60
root entries. These lengths are bounded, but the work is repeated at many
gates. Retain its checked input packet and exact cache-sum construction.
Prepare action descriptors once per packet, then pass the appropriate
descriptor sequence directly into the node evaluator.

An action descriptor is one of identity, negation, positive quarter turn,
negative quarter turn, or a general cached integer tuple. Exact tags are
chosen by the same integer conditions as `tx_action`; a numerical center
near a special value is never reclassified. A general descriptor contains
the same `(wr,wi,wr+wi,wi-wr)` integers, preferably through a retained shared
object if the representation supports that.

A conservative finite preparation can store every bridge action for the six
composites10,15,20,30,40,60, one for each of their n pairs (a,v), and complete
direct-row actions for3 and5. This is
`10+15+20+30+40+60+3*3+5*5 = 209` action descriptors. It includes identity
entries and unused j0 entries deliberately. The original185 root entries
and their exact sums still need validation and construction. No new angle
identity catalogue is assumed.

During this one-time preparation it is acceptable to use the reference's
bounded row/entry lookups. Their cost is then charged to setup. At execution,
each bridge consumes its descriptor row in lockstep with the data column,
and each direct output consumes its descriptor row in lockstep with the
input. Select the fixed child plan by constructor fields, not by searching
the global table at each scalar operation. Reuse this prepared plan across
all lines and both heights only while the exact root packet remains the
same retained object or has a proved binding to it.

209 is a descriptor count, not209 free pointers or a memory-byte claim. The
actual CV representation may copy tuples, retain original roots, or allocate
extra tags and list spines. Prepare-time equality/shape proofs, allocation,
conversion and eventual collection are all included in the measurement.
Rebuilding the plan between lines or heights must be reported as such.

## Exact refinement obligations

Prepare a separate `C10004FastTraversalScript.sml` only after the reference's
own source repairs/build status are settled. Required lemmas are:

- `chunks_exact` returns exactly the declared number and length of rows and
  concatenates to the original list; it rejects every malformed shape.
- `transpose_exact` preserves dimensions and gives output[j][i]=input[i][j]
  for the valid index ranges. Its proof may use reference indexed notation;
  its executable body must use heads/tails.
- Prepared action descriptors evaluate identically to `tx_action` on every
  input pair, including all special-root cases and exact cached sums.
- Fast full and omit-zero nodes equal `tx_full 6 n cache xs` and
  `tx_omit 6 n cache xs` for the admitted nodes and well-sized inputs.
  An induction over the fixed plan proves this without assuming numerical
  root correctness. Direct leaf arithmetic order must be identical.
- Fast outer pair/chunk/transpose traversal equals
  `tx_tensor_selected cache xs` for every4800-entry input. This is a traversal
  refinement, not a second proof of equality with the full tensor.
- The public fast checker has exactly the same result as `tx_checked` for
  every root packet and input, including NONE cases. Preparation or shape
  failure must not silently relax a reference guard.

The separate outer-projection theorem can then be composed with these
equalities. No analytic radius, character map or sign theorem follows solely
from them. Those source/semantic obligations are unchanged.

## Source-to-consumer boundary and measurement gate

This design starts with a correctly ordered4800-entry input. The streamed
EM/Horner producer visits fine-anchor buckets, which is a different order.
Its scatter must also be implemented, not hidden in a native array oracle.
One possible checked reorder stores `(tensor_index,value)` records and uses
13 stable binary partitions on indices below8192, then checks consecutive
indices0..4799. Each partition is a linear cons/reverse pass; it has a fixed
13-pass cost and requires a proved permutation and exact-once property.
An indexed immutable tree is another option with logarithmic update cost.
Neither has been implemented or priced here. Source generation order,
reorder cost and producer live storage remain separate measurements.

The next useful timing compares the reference and fast traversal on identical
retained input and root objects, first proving the output equality above.
Report root preparation, input validation, outer traversal, small-node work,
output validation, proof construction and export separately, plus complete
CPU and RSS. An unchanged-root warm run and first construction answer
different questions. Synthetic inputs may validate the implementation but
cannot replace the later actual-source measurement.

No new synthetic benchmark is proposed by this note. Its purpose is to keep
the reference's quadratic indexing out of any production-cost claim and to
give the next implementation a checkable linear traversal contract.

## Frozen reference bindings

The existing files were read only:

- `C10004TransformScript.sml`: `F352C75345C809D7BD019DF3959C4984F216AF09E644C1D777F793F52CB56440`.
- `MISSING_THEOREMS.md`: `E94D9AB07B167B92242EF3940C2DBD078022B3B1AC46C4DE5EB1152C41F1C2D9`.
- `SOURCE_MANIFEST.sha256`: `DA80C47F90CFEC64B41B54D178FAA4B8D376BAD00BC3C4593563BBF3AAA5DA5F`.

This new note is outside that frozen implementation manifest and changes no
previous source or claim.
