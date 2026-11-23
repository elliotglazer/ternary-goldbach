# Pruning the per-character time transform

The input frequencies occupy a cyclic interval from −J to J. The output needs a prefix starting at time index zero. At radix-2 depth r there are g = 2^r residue classes. Exactly min(g, 2J+1) parents are live. A parent has two live children precisely when the next level adds an occupied class, so the number of such parents is min(2g, 2J+1) − min(g, 2J+1). The local prefix has min(N/g, m+1) requested results. These counts distinguish a general complex multiplication from a quarter turn, a normalization or a complex addition.

`count_time_fft.py` tests the formulas against explicit graph walks and compares dense and pruned rounded integer outputs over 682 small graph shapes. Even when one leg is zero, the pruned circuit retains the prescribed normalization of each requested output. It folds the results over all 7,499 conductor records and the primitive characters at each conductor. The hash of the input schedule is in `counts.json`.

| Full-length time transform | Dense | Pruned |
|---|---:|---:|
| General complex rotations | 76,001,578,705,000 | 72,071,407,901,803 |
| Complex additions | 179,716,435,214,336 | 146,303,204,129,267 |

Pruning alone removes 5.17% of general rotations. A separate one-character Hermitian algorithm packs each pair of time samples before a half-length transform. On that algorithm the pruned inner transform takes 33,726,300,359,272 general rotations and preparation requires a further 1,202,846,693,883. Together that is 54.04% fewer general rotations than the full dense count. It also needs 73,151,638,882,058 inner complex additions plus 2,405,693,387,766 for preparation. Packing changes where rounding occurs. The corresponding end-to-end error proof and wide HOL kernel measurements remain open.

The [two-character packing alternative](../time-pairing/) uses the same opportunity differently. Its savings cannot be added to the single-character reduction. All entries here count arithmetic on this one axis. CPU-hour reductions require actual kernel timings.
