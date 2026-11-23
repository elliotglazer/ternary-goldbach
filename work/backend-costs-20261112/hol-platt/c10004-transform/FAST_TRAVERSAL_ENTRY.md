# Sequential outer traversal candidate

13 November 2026. `C10004FastTraversalScript.sml` is prepared source only.
No build, evaluation, test fixture or benchmark was run. It is outside the
frozen reference manifest and changes none of its definitions or arithmetic.

This is the first checkpoint from `FAST_TENSOR_TRAVERSAL_PLAN.md`. It removes
global indexed list access from the outer selected tensor while retaining
the exact existing `tx_omit 6 40` and `tx_omit 6 60` programs inside each row.
Their small-node repeated indexing and root lookup are still paid. The
prepared action-descriptor and fully sequential inner CT design are not
implemented here.

The candidate consumes adjacent input pairs, splits the resulting2400 values
into60 rows of40 using one prefix/suffix traversal per row, transforms those
rows, transposes the60-by39 result by simultaneous head/tail extraction,
transforms the39 resulting60-element rows and concatenates the39 output rows.
It neither materializes a global flat intermediate merely to index it again
nor recomputes an earlier transform for each later output. Input and output
checks are the same reference predicates. Root caches are still constructed
once through `tx_cache` at the public entry.

`ft_take` returns both the row and its suffix. `ft_heads_tails` extracts a
column and its remaining rows together. `ft_concat` appends each row once
on the right-recursive tail; it does not repeatedly append to an expanding
prefix. The exact shape is checked by the chunk count, requested column
count and empty-tail condition. Every helper is total, with explicit NONE
for a short or ragged shape. Public input length remains exactly4800.

The code is structurally recursive, not tail-recursive throughout. It may
retain stack frames and intermediate spines. Linear traversal does not
establish the packed-memory bound or constant-stack operation. CV's actual
call/constructor behavior and garbage collection need measurement. A future
tail-recursive version requires its own refinement proof and cannot be
silently substituted in a timing comparison.

## Required refinement before production timing

The candidate includes only `ft_checked_guards`, a proof attempt exposing its
actual guard behavior. It deliberately exports no presumed equivalence to
the reference. The essential missing targets are:

```
!cache xs. LENGTH xs = 4800 ==>
  ft_tensor cache xs = SOME (tx_tensor_selected cache xs)

!roots xs. ft_checked roots xs = tx_checked roots xs
```

Prove them by the following helper contracts:

1. `ft_pairs` has exactly the adjacent differences in input order, rejecting
   odd length. For4800 entries it equals the reference's flattened2400
   length2 omitted outputs.
2. `ft_take n xs=SOME(pre,rest)` implies `LENGTH pre=n` and
   `xs=pre++rest`, and succeeds whenever n<=LENGTH xs.
3. `ft_chunks count width xs` succeeds exactly on length=count*width,
   returns count rows each of length width, and their concatenation is xs.
4. On rows with the specified common length, `ft_heads_tails` and
   `ft_transpose` give the same bounded column lookups as the reference,
   preserving row and column order. Reject short, long and ragged rows.
5. Apply congruence of the unchanged40/60 transforms to those equal line
   inputs, and prove the final concatenation equals `tx_flatten 39 59`.
6. For invalid public inputs both entries return NONE by the same guard;
   for valid inputs, use the core equality and identical output guard.

This is a traversal-refinement proof, separate from the outer
full-versus-pruned theorem owned by the tensor-projection module. It does
not duplicate that theorem and does not supply analytic root or L semantics.

## Root integration gate

First complete the repaired reference's build and source review. Then review
this candidate and its refinement proof. Only after those gates should root
add a separate explicit build target and diagnostic runner. The frozen
reference runner and Holmakefile have not been edited to run this candidate.
There is no benchmark command or throughput claim in this packet.

Reference dependency: `C10004TransformScript.sml`
`2CA9519C95BC6C41992E988D9278B0F76C90F76104716D113E20A4DAD6D58B9A`.
Its sole change from reviewed F352C753 is the separately pinned proved
numerical identity translation rule. The unchanged arithmetic definitions
remain the exact refinement target.
