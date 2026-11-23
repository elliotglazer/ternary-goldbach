# Accepted generic traversal refinement

Reviewed 13 November 2026 against the completed refinement06 receipts. This is a coordinator review of recorded construction and reload results, not a new independent kernel replay or a throughput benchmark.

## Accepted scope

The theory proves the sequential traversal implements the selected integer tensor for every cache and every input list of length 4800. Its public checked entry agrees with the reference on every root table and input list, including rejected inputs:

```sml
!cache xs. LENGTH xs = 4800 ==>
  ft_tensor cache xs = SOME (tx_tensor_selected cache xs)

!roots xs. ft_checked roots xs = tx_checked roots xs
```

The second equality has no added length, root-validity, magnitude or analytic premise. It preserves the existing input, root and output guards. The accepted traversal program definitions remain in the separately accepted C10004TraversalBase module.

The six reload roots are ftr_genlist_pair, ftr_chunks_any, ftr_transpose_any, ftr_concat_shape, ft_tensor_refines and ft_checked_refines. The audit checks each exact conclusion by aconv, empty hypotheses, only DISK_THM import tags, empty explicit axiom tags, and ancestry containing only bool.BOOL_CASES_AX, bool.ETA_AX, bool.SELECT_AX and bool.INFINITY_AX. The source audit and successful log agree on the six roots and the unique completion marker.

## Evidence checked

All seven source_expected entries, five run-source entries, eleven dependency/tool entries and three output entries were rehashed against the current files and matched. All three phase status files and the container exit receipt report zero. Source and dependency postchecks are present from the runner.

| Artifact | SHA256 |
|---|---|
| C10004TraversalRefinementScript.sml | 7240919887faa83e49a2ee64d8b56127f2027ccf7de45fcd0c25456019b44892 |
| source_expected.sha256 | a958be6c7abddc99a02081ef5367edf38b04e33b3460ceff23b7b38d04f8b107 |
| refinement_audit.sml | a0a40450cd82c655b615d155c5bbabc1ffb742b8a1c4b2eb98a674b4262124ea |
| C10004TraversalRefinementTheory.uo | 68b4a95d4ca6f07c79769656b14b3a91300af82d216b0223af35869a3b9eb17f |
| C10004TraversalRefinementTheory.dat | b56d622f8051de18397745e9336f25e24352f4ce5fe694be767bcb748bae149a |
| refinement_audit.uo | d7ef94f7649da34ce8ad3a7078725a1c52e7a1415d743d7d9d5f544d6b87071c |

| Phase | CPU seconds | Wall seconds | Peak RSS KiB |
|---|---:|---:|---:|
| Theory construction | 12.57 | 60.58 | 338712 |
| Audit module construction | 3.10 | 30.36 | 28264 |
| Audit execution | 4.00 | 10.96 | 279540 |
| Phase sum | 19.67 | 101.90 | |

The container receipt records 103.352 seconds wall time. The inner script's 0.589-second report excludes the wider construction process and is not the full build price. Dependencies were already constructed; these measurements are not a fresh build of the entire library. Earlier failed construction and diagnostic receipts remain preserved and are not included in this successful-run subtotal.

## Repairs and limits

The completed construction integrates the saved-state repairs for the explicitly typed rectangular-row length, beta reduction before inner list extensionality, and two distinct extensionality steps for the column equality. The theory passed the remaining transpose, row-map, tensor and checked-entry proofs and exported normally.

This result proves program equivalence only. It does not establish actual roots, Fourier semantics, source enclosures, analytic error bounds, strict signs, zero counts or campaign completion. The sequential program still needs stock CV translation and the prespecified matched benchmark. No execution speed or forecast reduction is credited.

The arithmetic price interface records that the frozen model already allocates about 0.062634 seconds to this transform's counted arithmetic roles. Improving on the approximately two-second reference public call does not by itself improve that forecast. Those measurements have different cost boundaries, and complete source/transform/sign/count blocks remain required.
