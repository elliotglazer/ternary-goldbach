# Saved recovery graph validation

The saved recovery graph passes offline validation. No HOL, WSL, or subprocess command was run for this validation. The original recovery command returned zero after 30.7870564 seconds. Its Windows adapter failed while parsing stdout because the JSON was prefixed by `Holmake: `.

`Holmake.sml:2477` sends the graph through `info`. `Holmake_tools.sml:284–302` implements that channel with an executable-name prefix followed by a newline. Its SHA256 is `B9A679BC109622736A99F700F4F1BFB7625DDC6D0CA515AAE8EE595BC5695B8B`. The offline adapter requires exactly the nine bytes `Holmake: ` at offset zero, immediately followed by `[`. It removes those bytes only, then parses the entire remainder as one UTF-8 JSON value. It does not search for JSON or discard intervening diagnostics.

The raw 678,396-byte file remains unchanged at SHA256 `C2C0B4F8A54F73FA50AD04DA7565AA61FC18023EA2955A49E4152CB9A18BABAC`. The separately stored normalized graph has SHA256 `452E41CD91C2892DCEA17C29A27C616C9AAD4005B56F4387CB35EBC9A25E7F78`.

## Graph scope and exact local aggregate

The first offline checker stopped after normalization because the local empty-command `all` node has two dependencies, the pinned `hol.state` and `RawPairRoundTheory.uo`. Its script and normalized output remain in place. The successor checks exactly this pair, the exact local directory, an empty command, a nonphony node, unique target identity, and no incoming edge to the aggregate. It does not authorize arbitrary phony or custom-command nodes.

The full JSON has 1,227 nodes. `HM_DepGraph.sml:432` defines its `needs_rebuild` field as `status <> Succeeded`. That field alone does not say a node is selected or runnable. Lines 437–458 mark the transitive selected dependency closure; lines 461–471 handle `--no_prereqs`; lines 267–276 require `Pending{needed=true}` and satisfied dependencies before a node can run. The pinned file SHA256 is `9C4AD829B57C9EE093E49A39B19FF71680CCA11030351717A472EB624835612F`.

The checker therefore validates the full graph schema and edges, then reconstructs the exact closure of the helper and pinned state. It contains 777 nodes, including 172 local nodes and 605 external nodes. Every external node in that closure is already `Succeeded`. No selected component is phony. The other 449 nodes are outside that closure; the one additional local aggregate is checked separately.

The full selected graph is saved unchanged. A second, explicitly labelled checking projection removes only dormant command strings on already-satisfied external nodes, preserving every node and edge. The original strict local-command validator then checks the projection. It finds 93 local action-bearing nodes with `needs_rebuild=true`, comprising 48 nodes carrying built-in theory-builder commands and 45 carrying built-in compiler commands. These are graph nodes, not 93 distinct executions; theory output nodes share builder commands. All prospective active commands remain inside the owned stage. This validation applies to the same target and no-prerequisite policy, not an arbitrary future command.

## Preservation and result

All 62 original source/boundary/helper checks and 46 staged source/helper checks passed. All 126 protected preexisting stage files retained their exact bytes, and the full 40-file `.hol/objs` set and hashes remained unchanged. The other 47 original snapshot files are refreshable dependency metadata; they were not treated as immutable object evidence. The raw recovery output, prior logs, original failed-build evidence and bindings remain untouched. The offline files were written outside the stage.

The successor `validate_recovery_offline_v2.py` has SHA256 `89E799275BC961466FDE63F00FB2B1377167AA24BF6B3D8388C6C39AB225F9B9`. Its receipt is `recovery01-offline-validation-v2/RECEIPT.json`, SHA256 `E6E5B91478C0E7B808DD914BAC09B208110FFA924F2C4752E9681BB89A748B3D`. The detailed graph validation has SHA256 `33A10B73C801512716C66F28BB89BDD36D705265AA5228300F8663CAC4FB1B76`.

This completes the saved graph preflight and the postchecks skipped by the parser failure. It preserves the earlier actual partial-build history. It does not run the remaining build, prove the helper, or prove any transcendental input or L-function statement. Root can review this evidence before a separate bounded build that reuses the existing local caches.
