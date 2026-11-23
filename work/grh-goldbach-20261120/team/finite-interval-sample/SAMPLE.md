# Prespecified binary Goldbach intervals

The four high intervals are half-open `[L,L+2^20)` with `L` equal to `97000000000`, `98000000000`, `99000000000`, and `100000000000−2^20`. The control has the same width and ends at `10000000000`. These endpoints were selected before reading any prime or coverage counts. Each interval contains exactly 524,288 even integers.

Use the same acceptance predicate in all runs. Where the checker accepts configurable shard sizes, compare equal total work with one large shard and several smaller shards inside each fixed window. Where a safe independent check is inexpensive, use it to validate equality of coverage or the checker outputs. The gaps between the sample intervals are outside this experiment.
## Results

Lean 4.35 accepted all five intervals with each row layout. The four upper windows together cover 2,097,152 evens. The lower control covers another 524,288. Each theorem reports `propext`, `Classical.choice`, and `Quot.sound`. The interval statements use a strict upper bound, including for the window ending at 10^11.

| Four upper windows combined | One wide row per window | Four shorter rows per window |
|---|---:|---:|
| Anchor occurrences | 299 | 908 |
| Row module source, bytes | 5,356 | 13,930 |
| Verifier CPU, seconds | 14.22 | 13.75 |
| Verifier wall, seconds | 14.78 | 13.95 |
| Peak resident memory, KiB | 1,460,312 | 1,492,460 |

Wide rows cut the row-module bytes by a factor of 2.60. The difference in CPU is below half a second in a single trial per layout and includes startup and imports. The lower control used 72 and 223 anchors respectively.

At a 3,000 MiB limit the monolithic source-sieve proof and monolithic upper factorial proof both failed. Breaking the source sieve into 32-segment proofs checked the same 528,384-bit source (62.53 CPU seconds, 2,834,440 KiB peak). The four exact products giving 316227! and their join checked in 91.73 CPU seconds total (1,958,240 KiB peak). The 100000! control checked in 21.72 CPU seconds. These costs are shared across windows in their respective groups. The windows do not extend the continuous prefix.

To reproduce, run `generate_sample.py` and then `split_factorial.py`. Run the existing `small-prefix/check.py` against this directory with a 3,000 MiB limit. Module order is FastHex, SampleBits, SampleLowerFactorial, SampleHighProduct0 through SampleHighProduct3, SampleHigherFactorial, then the four Parts modules. Each JSON receipt records inputs, compiler version, wall time, CPU, peak resident memory, and output digest.
