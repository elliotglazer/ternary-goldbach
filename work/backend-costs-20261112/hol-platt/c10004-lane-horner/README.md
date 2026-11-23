# Packing K20 Horner stages across heights

The benchmark uses the frozen band1_K20_b94 grid schedule and conductor 10004.
A block contains one residue, with real and imaginary coordinates adjacent
for each height. All heights share the same residual and grid schedule.
The 20 coefficients of each coordinate are independently generated signed
integers inside the stage bounds. The benchmark begins with already
grid-converted coefficients. Synthetic coefficients do not establish that
a source coefficient table satisfies these bounds.

For stage input m at signed bias B, the lane contains B+m. A negative
residual changes this to 2B−(B+m). Write c=abs(r) times the dyadic grid
alignment factor, o=(10004−cB) mod 20008, and t=(cB+o−10004)/20008.
With the selected sign, the numerator N=c(B+sign(r)m)+o is nonnegative.
The output before adding the next signed coefficient is floor(N/20008)−t.
Thus exact ties round towards positive infinity, including negative ties.
Adding the next coefficient plus its stage bias before subtracting t
preserves the nonnegative packed representation. The synthetic fixtures
independently check all intermediate signed bounds.

For H=2^k and M=ceil(H/v), let e=vM−H. Since 0≤e<v and N<2^W,
k≥W+ceil(log2(v)) gives Ne<H. Therefore (NMv) DIV H=N, whereas
(NMv) DIV v=NM. The two iterated divisions commute, yielding
(NM) DIV H=N DIV v. Each stage multiplies the packed lanes by c and M.
The fixed 232-bit common stride covers the largest product at every
residual magnitude ≤5002. After shifting by k, the Python bit mask removes
bits shifted in from the next lane. Stock CV uses arithmetic digit
extraction to implement the mask. This adds work per lane.

The initial coefficient is the input at stage 19. All 20 columns may be
packed once for heights sharing their fine cell, coefficient table, stage
grids and stride. Residual-specific masks, correction constants and
multipliers may be reused across height blocks with the same residual
and lane count. Output unpacking and the transpose to height-major tensor
order recur on each block. The 64×64 transpose microbenchmark produces
a height-major list of 64 real/imaginary pairs for each height. It excludes
the next transform and its input encoding.

The CSV uses native CPython arbitrary-precision integer arithmetic, seven
batch medians, synthetic coefficient vectors, and a fixed negative residual
from residue 10003. Times are microseconds. Cold timings are independent
whole-pipeline medians. Coefficient construction, conversion from the
analytic source, and proof discharge are outside the CPython timing.

## Actual conductor-10004 slab

actual.py checked the 448 complex results for heights 1 through 64 and the
seven residues of cells 0 and 1 against the supplied fixed-point outputs.
The individual CPython timings are recorded in actual-times.txt. The shared
coefficient costs use two tables, while setup uses seven residuals. For this
slab, warm evaluation plus transpose took 2.838 ms and scalar evaluation
plus transpose took 5.307 ms. A call building all caches took 7.153 ms.

The stock HOL4 CV replay in price03.log checked residue 5 and heights 1
through 8, with real and imaginary lanes adjacent. It discharged exact
outputs from scalar mixed rounding, the coefficient pack, a packed
accumulator, and the cold pack/evaluate/decode path. CPU seconds were
0.018285, 0.240164, 0.534391 and 0.533953 respectively. Each separate
measurement includes proving its own output equation. In particular the
standalone coefficient pack exports a large integer list. Its time does
not add to the hot time to predict the fused cold calculation.

The generic rounded-up reciprocal division identity and its width
corollary both kernel-built in reciprocal/lane05.log. Their statements
hold for all natural inputs, including non-power-of-two h and b.

## Scalar throughput in a persistent HOL process

The 64-height batches each cover conductor 10004, fine cells 0 and 1,
and residues 1, 3, 5, 7, 9, 11 and 13. One closed Boolean evaluation checks
896 signed grid-94 coordinates, or 448 whole complex outputs, against a
literal reference. The source generator checks the mixed coordinates
against the supplied slab and removes only common zero top coefficients.
The delayed calculation applies one nearest rounding after exact numerator
evaluation. The mixed calculation rounds after each grid-aligned stage.

| Heights | Degree | Method | Median kernel µs/complex output | Whole warm µs/complex output | Literal CV admission s/slab |
|---|---:|---|---:|---:|---:|
| 1–64 | 9 | Delayed | 49.507 | 57.125 | 8.084 |
| 1–64 | 9 | Mixed | 50.400 | 56.692 | 8.118 |
| 6337–6400 | 19 | Delayed | 83.672 | 96.551 | 14.468 |
| 6337–6400 | 19 | Mixed | 93.866 | 105.877 | 19.147 |

Five interleaved trials used the same admitted input and a single stock
HOL4 process with one worker. Kernel time includes the fused comparison
with all expected centers. Whole warm time includes conversion to a HOL
Boolean, premise discharge, and structural checks on both sides of the
conclusion. The large left-hand term costs 2.7 to 6.7 ms to compare on
these runs. The two input terms shared construction, taking 80.8 ms on the
low slab and 53.6 ms on the edge slab. Fresh data require admission again.
Theory compilation and export are included in the per-job time files.
Both samples are band 1, from a single conductor and the first two fine cells.
Other conductors, cell locations, bands and the downstream transform need
their own measurements. The Boolean certificate establishes exact agreement
with the supplied fixed-point inputs. Analytic source enclosure remains a
separate obligation.

The eight-height delayed packed comparison is in delayed/delay02.log.
For a5, degree 8 and a 27-byte signed stride, its scalar, fused cold packed,
and decoded prepacked evaluations took 5.511, 9.331, and 16.519 ms. Each
returned all sixteen signed centers and matched the independent pinned
fixture. Those single-call figures include dispatch and certificate costs.
