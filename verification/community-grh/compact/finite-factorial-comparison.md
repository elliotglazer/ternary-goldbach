# Finite certificate measurements and cost estimate

The dependency closure of `ProductPrefix564386325504` contains 415 local modules. Of the certificate rows, 191,362 use a factorial and 118,536 use a prime-product modulus. The factorial rows cover 50,164,265,470 even candidates and the prime-product rows cover 232,028,897,280. The 19,074 early Power10 rows are a subset of the factorial group.

## Same-result trial

Both proofs establish `GoldbachAB.target : Covered 6 33554438` from the same 64 original rows, offsets, and bitmap. The alternate proof chooses 5793! as its certified factorial, using the upper endpoint to bound every anchor. The generator recomputes the modular inverses. Both use the existing `checked_interval` proof and stock kernels. Independent inspection identified the corresponding factorial certificate in each export and confirmed neither references the already-proved original block.

| CPU seconds | Original 100000! | Local 5793! |
|---|---:|---:|
| Lean kernel | 57.635 | 29.436 |
| NanoDa | 41.665 | 37.438 |
| Both | 99.300 | 66.874 |

The two exports have 15,445,301 and 15,008,029 bytes. Both passed with only the standard three axioms. The trial includes the one-time cost of each factorial certificate. A larger chain can amortize a common certificate over many blocks, which can change the result. The prior arm also ran first on a shared machine. The 32.7% CPU reduction cannot be applied to the entire finite proof from this experiment.

## Fermi estimate in actual CPU hours

Dividing the census by one observed marginal block and multiplying by its stock-kernel and NanoDa CPU yields 6.96 combined hours by row count, 6.85 by anchor count, or 7.59 by row-module source bytes, apart from shared overhead. Each denominator comes from the marginal second block (2,400 rows, 185,836 anchors, 2,364,420 source bytes). The sample uses the early factorial certificates. Other bands have different arithmetic and row widths. A factor-of-two sensitivity about seven hours (3.5–14 CPU hours) is a scenario range, not a confidence interval. Export, analytic checking and compact GRH checking are excluded.

The archive records at least 5.19 core-hours of preexisting TG source compilation against released GRH objects, 3.49 of those in the finite binary pipeline. The recorded compilation covers 405/415 finite and 130/317 other local modules. Combining those historical timings with the finite independent-replay proxy gives about 12 CPU hours for the two named tasks. This mixes Lean versions and machines and excludes untimed modules, analytic independent replay, and compact GRH. There is no measured full Sernau compact user-plus-system CPU total in these receipts. Allocated instance cores multiplied by a ceiling or elapsed wall time measure capacity, not consumed CPU. These results cannot determine whether a 330-minute protected full verification fits.
