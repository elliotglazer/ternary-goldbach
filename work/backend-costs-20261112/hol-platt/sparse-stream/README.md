# Streaming the selected raw signs

The conductor-10000 input consists of four character grids on the width-50 guard schedule. The original sparse selector is in `../sparse-count`. Its monolithic full-width HOL quotation exhausted the bounded worker before completing the first channel (`../sparse-count/even02.log`). Streaming small raw records produced all 5,324 tile propositions.

| Character | Retained raw values | Required coarse signs |
|---:|---:|---:|
| 3 | 17,883 | 15,989 |
| 6667 | 18,234 | 15,986 |
| 11 | 17,207 | 15,997 |
| 9091 | 18,001 | 15,989 |

`pack.py` checks each retained raw value against its original grid and emits bit masks at the original positions. A tile proposition records the character, tile number, masks, and the actual biased 256-bit sample fields. The kernel checks the requested coarse signs at radius 519575974158995 and the tile mask constraints. The build also rejected one deliberately flipped requested sign per character. The 103 off-grid interpolations and the two weighted pair tests belong to the separate checker in `../sparse-head`.

The run took **105.18 CPU seconds** including loading and exporting the theory, and 148.46 seconds of wall time. Preparing the kernel templates, constructing the numeral inputs, checking the tiles and the remaining in-memory checks took 0.108, 7.559, 7.433 and 0.289 CPU seconds respectively. Writing the 333 proof batches took 9.759 CPU seconds. Reloading them and checking every theorem statement took 60.771. The archive is 40,572,450 bytes. At peak the worker used 1,573,568 KiB. Each tile theorem had empty hypotheses and passed the existing tag check after reload.

`results.json` records the build receipt and a hash of every persisted batch. `summary.py` reproduces it from the successful build. The inputs to these arithmetic propositions are numerical sample centers. Transferring their signs to the analytic functions requires the corresponding enclosures from the transform and error analysis. The streamed coarse check and the sparse-head projection/checker both test coarse signs, so adding their entire costs would count this work twice.
