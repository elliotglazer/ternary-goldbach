# A contiguous 134,217,728-even interval ending at one trillion

Lean 4.35 accepted `TrillionBlock.interval` for every even integer from 999,731,564,546 through 1,000,000,000,000 inclusive. The proof checks 256 consecutive rows in groups of eight and joins all 32 group theorems. Its last row reproduces the independently audited single endpoint row. The accepted theorem reports `propext`, `Classical.choice` and `Quot.sound`. The band contains 19,182 anchor occurrences, with 70 to 82 per row.

| Phase | CPU seconds | Wall seconds | Peak RSS, KiB |
|---|---:|---:|---:|
| Generate all row witnesses | 20.578 | 20.841 | — |
| Compile the fresh row-data module | 21.547 | 1,946.098 | 1,463,540 |
| Import the identical row-data module in a control | 17.391 | 20.333 | 1,442,632 |
| Check the 32 groups and their complete join | 41.594 | 45.974 | 1,643,700 |

The proof cost 24.203 CPU seconds above the matched import control. For a campaign that produces, compiles and checks each block once, the measured cost is 83.719 CPU seconds. The separate control is a benchmark diagnostic. The data compilation wall time includes a period when the tool host stopped responding; its CPU remained 21.547 seconds. Wall and CPU diverged sharply for this row.

The generated data source takes 280,912 bytes, the group proofs and join take 8,487 source bytes, and writing the generated sources took 0.0021 wall seconds. The data object takes 1,134,168 bytes and the joined proof object 122,168 bytes. The factorial and bitmap are shared with the one-row test. Their original verification cost is recorded in `summary.json` and `README.md`.

The interval `(10^11,10^12]` has 450 billion evens. Applying this block's rate across that interval gives about 78 core-hours for witness generation, data compilation and fresh proof checks. This single endpoint block supplies a cost observation; a continuous certificate additionally requires every intervening block and their final join. Run `block.py` to reproduce the producer and all three sequential Lean invocations. The generated group file, receipts, axiom log and source digests are in this directory.
