# Map01 parser repair

13 November 2026. Source-only repair authorized by the coordinator. No build or finite evaluation was performed for this repair.

`map01` failed in the theory parser, before either Boolean check definition, translation, or finite check could complete. The log reports a `<` after `=` at source lines 36–37. This is not a failed arithmetic assertion and supplies no map theorem.

The successor changes exactly two definition binders:

```
label_ok i =       becomes label_ok i <=>
coordinate_ok i =  becomes coordinate_ok i <=>
```

Both definitions return Boolean propositions. `<=>` supplies the intended outer Boolean equivalence without the ambiguous relation chain. Every right-hand side, bound, conjunction, map function, finite check, theorem statement, and proof is byte-identical. A reverse replacement reconstructs the complete original source bytes exactly. The other definitions are numeric/list/tuple expressions; `finite_checks` already uses `<=>`. No other source changes were needed for this parser issue. Successful parsing, translation and checking remain pending a new coordinator-run attempt.

The exact old source, `REVIEW.md`, `README.md`, map01 theory log/time, and inner theory log are preserved under `history/map01_parser/`, with `SHA256.json`. Original map01 receipts and the historical review/README remain untouched. The historical review's mathematical scope transfers through this two-token repair, but its old source pin is not the successor pin.

| Artifact | SHA256 |
| --- | --- |
| Original C10004MapScript.sml | 0773AC5249A66AF85814F7694063D53759AEF19C41D6172BE06DA906FD60AC6E |
| Successor C10004MapScript.sml | 7A3307716CE158DE2B04DA6CB80EDA84A38E345E455A79391AB36054689C4BD1 |
| Historical REVIEW.md | 6580D991FE4720FA4AAED1C59FABF63CA04E93C967663013FE8CBED61E3877C8 |
| Historical README.md | 897CA3840A422D63789C67122D7351B2397C2A9719C5BF8037DF30163A06C583 |
| map01_theory.log | 427AF995A47D9B0600129ADE0AD261DAA6BE190AB1752213E80554EBAB9184D8 |
| map01_theory.time | 2EC2E693037E0918D35255EA5AF0541BE2FA75B387BC0153F0FD7EF3B60E0243 |
| Archived inner C10004MapTheory.log | 5DBD1E287E5EA6AE450F982A3D10AD2910B4482E0CF2331B782F90CEBC3B5343 |

The unchanged `run_map.sh` can be used by the coordinator with a fresh `map02` label. This note authorizes no dependency rebuild and makes no compiled-theorem, character, or DFT claim.
