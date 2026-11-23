# What the packed binary certificate proves

Lean 4.35.0 checked every even integer from 3,999,999,999,967,234 through 4,000,000,000,000,000 inclusive. The combined `PackedWide.verified` theorem contains 16,384 targets in two contiguous intervals. Its axiom report lists `propext`, `Classical.choice` and `Quot.sound`. The separate endpoint fixture covers 1,024 consecutive even numbers ending at 10¹⁶. Neither fixture establishes the full prefix through its endpoint.

- [Explicit 16,384-target theorem](wide8192/PackedWideTogether.lean), [joined theorem receipt](wide8192/combine01/receipt.json), [axiom audit](wide8192/combine01/PackedWideTogether.log).
- [First 8,192-target proof](wide8192/PackedWideShard0.lean), [two shard receipts](wide8192/complete01/receipt.json). Both use the certificate team's `UpperShared.source_sound` and `UpperAnchors.valid`.
- [The 10¹⁶ endpoint fixture](PackedEndpoint.lean), [first independent process receipts](receipts/packed01/receipts.json).
- [Generic no-carry convolution and witness theorem](PackedDigits.lean), [binary Goldbach prime semantics](PackedGoldbach.lean), [window and radix interface](FastGoldbach.lean).

## The full tile width

The 262,144-target fixture uses a shared 266,234-bit source bitmap and a 2,129,865-bit expanded bitmap. The two adjacent test blocks use different prime anchors and the same raw source. Sixteen independent groups plus a join established the source expansion in 106.125 aggregate process CPU seconds. The earlier monolithic expression exceeded the 2 GiB process memory limit. The expansion theorem reports `propext` as its only axiom. Each block's cached anchor operand, mask and padding was checked against its formula. The multiply/add/mask equality then passed on both sets of operands.

| Measurement | Block 1 | Block 2 |
| --- | ---: | ---: |
| Fresh 262,144-target arithmetic module, process CPU, including cache equalities | 5.03 s | 3.50 s |
| Warm kernel replay of the one cached numerical equality, mean elapsed over 30 runs | 5.415 ms | 4.685 ms |
| Warm kernel replay of the **8,192**-target interval assembly, mean elapsed over 20 runs | 139.3 ms | 107.7 ms |

Warm rechecks refer to previously accepted dependencies. Each assembly row includes its own theorem-local proof closure. The adjacent-interval join cost 40.6 ms over 50 warm replays. A cold join and axiom audit took 19.33 process CPU seconds. Thread contention on the workstation affects elapsed time. The maximum measured throughput of the cached equality excludes proof and certificate production, source prime verification, translations between windows, assembly, file I/O and export.

Sources for these measurements are the [large expansion receipt](wide262144-cache/segmented02/receipt.json), [both wide arithmetic receipts](wide262144-cache/operator01/receipt.json), [wide kernel replay log](wide262144-cache/operator01/PackedReplay.log), and [small assembly replay log](wide8192/assemblyReplay01/PackedAssemblyReplay.log). The wider source/anchor primality certificates have not yet been imported into a complete packed block.

The two full-width [conditional theorems](wide262144-cache/PendingPrimes.lean) independently close all numerical, interval-index and assembly conditions. Their explicit remaining hypotheses are primality of every marked source slot and the actual 80 or 84 anchor numbers for each interval. Those hypotheses cover the tested consecutive half-open interval [3,999,999,998,951,426, 4,000,000,000,000,002), containing 524,288 even integers. Both declarations compiled together in 17.34 process CPU seconds in a fresh Lean process. [Conditional compilation and axiom report](wide262144-cache/pending03/PendingPrimes.log)

## Binary-only cost sensitivity

Replacing the original 3.40 ms numerical calibration with the observed two-block mean of 5.05 ms and retaining the other planning assumptions gives the scenario below. It uses 512 reserved anchors per large block and charges one global source-prime table, certificate production, checker work and 25% for seams, I/O and assembly. The fixture used radix 256. A production checker allowing 512 anchors needs a wider radix, so the two-block observation still needs a production pilot.

| Binary cutoff | Estimated core-hours | Physical-equivalent cores for 29 h at 70% duty | Latest start for 8,192 cores, Saturday 15:00 PST deadline |
| --- | ---: | ---: | --- |
| 4 × 10¹⁵ | 60,285 | 2,970 | Saturday 04:29 PST |
| 10¹⁶ | 123,825 | 6,100 | Friday 17:24 PST |

The estimate depends on amortizing anchors, cache imports and assembly over 16,384 tiles per production block. Checking the current 8,192-target interval wrapper individually for every 262,144-target tile would exceed the assembly allowance. The result therefore does not justify production release. The remaining gate is an accepted multi-tile block with production anchor span and count, genuine distinct source windows, a shared resident proof environment, production of certificate bytes, and measured time and memory for its final exported theorem. Full finite and analytic Goldbach obligations are separate.

The numbers are reproducible with [reforecast.py](reforecast.py) and [reforecast.json](reforecast.json).

The revised scenario permits about 355 recurring CPU seconds per 2³³-integer block at the lower cutoff after reserving shared table costs, and 339 seconds at 10¹⁶. The 512 MiB raw source expands to 5 GiB at a fixed 10 bits per source digit. Reading one 320 KiB expanded source per 262,144-target tile would amount to 2.5 PB of aggregate reads at 4 × 10¹⁵. A resident shared cache and repeated object-storage downloads have different bandwidth and billing consequences.

## Sharing the anchors across tiles

[TiledGoldbach.lean](TiledGoldbach.lean) proves one closed binary interval from an arbitrary number of contiguous, equal-width source windows. One anchor validity proof serves the whole block. A separate lemma extracts any translated window from a certified source bitmap. Both lemmas have been compiled.

The [two-window fixture](wide8192/SmallTiled.lean) re-proved 8,192 even targets using two distinct 4,096-target windows and one set of 38 anchors. It finished in 21.00 CPU seconds including fresh imports, both expansion and product checks, the shared anchor membership proof, the final Goldbach declaration and its axiom audit. The final declaration has only the three standard axioms. Across 20 warm replays the two-window arithmetic proof took 34.51 ms, the shared anchor membership theorem took 90.55 ms, and the final Goldbach wrapper took 12.10 ms. These component times use accepted source-expansion and primality checkpoints. Scaling this layout to 16,384 production tiles still needs an integrated measurement. [Cold receipt](wide8192/tiled01/receipt.json) · [Warm replay log](wide8192/tiledReplay01/SmallTiledReplay.log)

## Reproduce the full-width fixture

From this directory on the recorded Windows workstation, using its Lean 4.35.0 installation and the compiled support files:

```powershell
python wide_packed.py 262144 --cached
python check_wide.py 262144 op-repeat --cached --inputs-only --replay
python split_bitmap.py 262144
python check_wide.py 262144 source-repeat --cached --expansion-from wide262144-cache/op-repeat
python pending_wide.py 262144
python check_wide.py 262144 proof-repeat --cached --arithmetic-build wide262144-cache/op-repeat --source-build wide262144-cache/source-repeat --conditional
```

Choose fresh run labels for subsequent executions. The runner refuses to overwrite earlier receipts.
