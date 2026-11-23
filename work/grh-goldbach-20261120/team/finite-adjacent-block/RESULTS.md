# Binary Goldbach interval near 10^11

Lean 4.35 checked every even integer in the half-open interval [99,250,000,000, 99,518,435,456). This interval contains 134,217,728 evens in 256 contiguous rows. The producer used 19,170 prime-anchor occurrences, between 71 and 83 per row. The row-data source takes 265,020 bytes. The finite theorem uses `propext`, `Classical.choice`, and `Quot.sound`. Its endpoints were selected before generating the rows and lie beyond the established prefix through 10^10.

| Job | Core-seconds | Peak resident memory, KiB |
|---|---:|---:|
| Generate the row witnesses in Python | 21.55 | unmeasured |
| Compile the row-data module | 16.44 | 1,462,948 |
| Import the data with an otherwise empty proof | 14.80 | 1,445,484 |
| Check the first 64 rows in a single reduction | 18.17 | 2,347,636 |
| Check the identical 64 rows in eight reductions and join them | 17.42 | 1,586,508 |
| Check all 256 rows in one process, eight per reduction | 31.20 | 1,616,308 |

The last process took 52.66 wall seconds. Every run used one Lean thread and a 3,000 MiB cap. The four separate shard checks, row-data module and final join took 97.20 core-seconds combined. Compiling the same data and the single-process balanced proof took 47.64 core-seconds. The single-process proof imports the full dataset and uses 32 eight-row checks. All rows and predicates agree between the variants.

## Projection for the decade

The band [10^10,10^11) contains 45 billion evens, equivalent to 335.28 measured blocks. Using ceiling-sized blocks and a shortened last row changes the count slightly. Repeating the measured work gives about 4.44 core-hours for row-data compilation and proof checking, plus 2.01 core-hours for certificate generation and about 89 MB of row-data source. The source-prime bitmap and four-piece 316227! certificate can be used over the entire band. They took 154.27 core-seconds, or 0.043 core-hours, to certify once in the preceding experiment. The production bitmap and factorial took 1.25 CPU seconds to initialize.

These numbers give 6.49 core-hours for generation, shared input certification, and checking the row blocks on this machine. The estimate extrapolates a single high block. Machine contention affected wall times and system CPU. The final join over the blocks, a terminal endpoint check if an inclusive band is required, base library compilation, and any independent replay add separate costs. The estimate applies only to this next decade.

## Reproduction

`block.py` checks the hashes of the shared Lean objects, copies them into this isolated directory, and writes the row witnesses and four shard proofs. `pack_shards.py` forms the single-process balanced proof from those same declarations. The existing `small-prefix/check.py` verifies modules using this directory as its scope and emits a receipt per module. The joined theorem is in `AdjacentJoined.lean` and the single-process theorem is in `AdjacentPacked256.lean`.
