# Finite layout result

Coordinator recorded-result review, 13 November 2026. Layout02 passed complete construction and the eight-root reload audit. This is not an independent kernel replay.

The exact finite predicate checks both directions at every one of the 4800 positions. Its forward and inverse functions connect the old order `2400*j4 + 60*j41 + j61` to the tensor order `2*(40*j61+j41)+j4`. The ordinary consequences prove exactly one preimage for each tensor position, permutation of the complete index range, and preservation of the actual CRT residue in both directions.

For each tensor position, the checked source residue lies strictly between zero and 10004. Its fine-cell index is at most 1024 and satisfies the stated strict lower and non-strict upper integer inequalities. These are at most 1025 cell indices; the result does not claim every cell is occupied or the cell assignment is injective. The real-valued radius interpretation and analytic source consumption remain separate proofs.

The script accepts the finite evaluation only with its exact predicate on the left, true on the right, and no hypotheses. The reload audit checks empty hypotheses, permitted `DISK_THM` import tags and only the four standard HOL ancestry axioms. All eight printed root conclusions were inspected against the source; the audit does not separately compare an expected term for each root. All eight printed axiom-tag fields are empty.

The coordinator matched five run source pins, ten dependency/tool pins, three exported artifact pins and all entries of `source_expected.sha256`. The predecessor map remains unchanged. The exact eight expected root names and one completion marker are present. All phase receipts and the outer container receipt record exit zero.

- Layout source SHA256: `76D89DCA88B42D18ABAB41F2B2DE3C8578D86463AD886E01CEE7119997000EF1`.
- Source manifest SHA256: `3E92921ABA73545C673E1E9046E12F6AAA8C7831A47E38EC51A7706C1B7B9324`.
- Audit log SHA256: `396FA7F440EE73D931927EAD5B4346E39B8ACD921BB4AA18B27E99887807A26C`.

| Phase | CPU seconds | Wall seconds | Maximum RSS KiB |
|---|---:|---:|---:|
| Theory construction | 9.92 | 52.79 | 288592 |
| Audit executable construction | 2.76 | 22.70 | 22300 |
| Reload audit | 3.67 | 10.75 | 292124 |

The phase sum is 16.35 CPU seconds and 86.24 wall seconds, excluding outer setup and runner hashing. These figures establish the cost of this finite layout check in the recorded container, not spectral throughput or a campaign saving.

Layout01 evaluated the finite predicate successfully but stopped at unopened identity-theorem names in its follow-on proofs. Its source and failure receipts are preserved under `history/layout01_identity_namespace`. Layout02 qualifies those two references; definitions, finite ranges and mathematical claims are unchanged. Character identities, DFT interpretation, interpolation, actual source accuracy, completed signs and zero counts remain outside this result.
