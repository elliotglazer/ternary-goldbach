# Stock HOL4 products at the full small-family time tile width

The four width-specific stock HOL4/GMP ratios raise the published 86,425.67 CPU-hour native product model to **96,634.95 CPU hours** for the same 1,051,852,215 scalar products. Folding the ascending and descending HOL runs separately gives 94,090.91 and 99,178.99 hours. These two observations measure repeat variation. They are not probability or confidence bounds. The central estimate uses 24.2% of a 400,000-core-hour budget before any other computation.

| Field bits | Operand bytes | Products | HOL CPU seconds/product | Same-input native seconds/product | HOL/native | Ratio-adjusted hours |
|---:|---:|---:|---:|---:|---:|---:|
| 552 | 4,521,984 | 638,542,494 | 0.247285 | 0.230469 | 1.0730 | 50,552 |
| 616 | 5,046,272 | 241,218,072 | 0.293548 | 0.248047 | 1.1834 | 26,019 |
| 680 | 5,570,560 | 103,539,564 | 0.329904 | 0.257813 | 1.2796 | 12,651 |
| 744 | 6,094,848 | 68,552,085 | 0.315296 | 0.316406 | 0.9965 | 7,412 |

The source is the T=65,536 case of the adjacent c10000-kronecker-time-price/tiles.json. For each width, multiply its original seeded-random full-product CPU median by its matched HOL/native ratio and product count. The 888,805,833 full and 163,046,382 ragged integer products retain the original policy of charging each ragged case as full size within its width class. It is a pricing convention rather than a mathematical runtime upper bound. Directly charging the repeated-block HOL rates to the same counts instead gives **79,023.17 CPU hours**. The native measured costs of the dense repeated-block inputs differ from the original seeded-random products, which motivates preserving this distinction.

| Bridge operand bytes | HOL seconds/product | Same-input native seconds/product | HOL/native |
|---:|---:|---:|---:|
| 6,144 | 0.0000887 | 0.0000610 | 1.4531 |
| 65,536 | 0.002028 | 0.001343 | 1.5101 |
| 524,288 | 0.023134 | 0.019531 | 1.1844 |
| 2,097,152 | 0.111426 | 0.107422 | 1.0373 |

## What the checker executed

Two distinct 1,024-bit SHAKE-derived seeds contain 497 and 512 set bits. For each width, internally generate the repeating factor (2^(8·bytes)−1)/(2^1024−1), then multiply by the two seeds. One signed operand is negative. Both magnitudes fill their requested bit lengths. The checker varies the low-order first operand by the iteration index and takes the product modulo 65,537. A final checksum includes both the original operands and all the modular product results. Its independent reference uses 2^1024 congruent to 1 modulo 65,537 and arithmetic on the two seeds and copy count. All 48 exact closed-equality checks passed, with empty hypothesis/explicit-axiom lists and only allowed disk-theorem tags. The large product was resident inside stock CV, with no multi-million-bit term parsed, decoded or exported. These checks prove the stated checksums for generated controls. They do not prove a production transform result.

Per run and size, the HOL rate is (CPU at largest repetition count minus CPU at zero repetitions) divided by that count. The order was ascending sizes and repetitions, then reversed sizes and repetitions. Use 0,32,96 repetitions for the two smallest sizes and 0,3,8 for all others. The reported rate averages the two run slopes. The kernel includes signed multiplication, a small offset addition, modular reduction and checksum accumulation. All four phases of every formal conversion and both alternative slopes are in projection.json. The zero-repetition runs separately charge operand production and the input checksum. At the maximum width these took 0.193478 and 0.185841 CPU seconds. Production input decoding, matching roots and source values, building and retaining genuine signed tiles, and cold generic theorem development have different costs.

Native FLINT/GMP used one thread and exactly the same two generated integers. Three equivalent batches per size verify the same independent checksums. At small sizes 4,096 and 256 iterations limit the effect of the Windows CPU clock granularity; at the other sizes each batch has eight. native.json also records stand-alone multiplication CPU and wall observations and operand generation CPU. The formal process used 35.63 user + 10.70 system seconds, 69.31 wall seconds and 680,584 KiB peak RSS under a 4 GiB address-space cap. It included the generic theory build, scans, translation and both passes. The initial compile encountered a generated division precondition. The successful theory uses total division and remainder helpers with explicit zero-denominator branches.

## Remaining costs

The audited tile schedule counts 9.404 PB in aggregate input capacities and 9.404 PB in aggregate result capacities. The test used reusable locally generated operands and returned a small checksum. It provides no measured proof that the actual source and chirp tiles, signed split, overlap accumulation, final extraction, 1,775,431,871,117 samples, interpolation, or the proof sink can be supplied within the remaining budget. Even for a resident multiply, seed structure, signed shape, memory locality, backend, worker scheduling and hardware matter. The estimate isolates one scheduled arithmetic class and is not an end-to-end historical comparison.

bench.py generates TilePriceScript.sml from TilePrice.sml.in and runs the same-input native measurements with the campaign interval-env Python interpreter. The stock theory log is tile02.log with matching time/status receipts. fold.py tile02 reconstructs projection.json from the saved native measurements and original tile ledger. projection.json pins the run, ledger, SML and paired native controls. No accepted prior report was changed.

