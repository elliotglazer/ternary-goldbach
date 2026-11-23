# Small-family time convolution outside the integer multiplications

The 65,536-field tiled schedule needs 1,836,492,654 retained signed pieces across 1,051,852,215 real integer products. These are **billions of tile operations**. Separately it must emit 1,775,431,871,117 real samples. The synthetic native controls price the other arithmetic and in-memory serialization at roughly **7,683 single-worker wall hours**. Adding this proxy to the separately calibrated 96,635-hour product component gives about 104,318 hours under their respective throughput assumptions. No full time transform or proof acceptance was timed here.

| Work | Exact count under this schedule | Synthetic one-worker hours |
|---|---:|---:|
| Regrid positive Gaussian source pairs | 1,202,865,170,991 | 127 |
| Prechirp signed complex inputs | 2,405,711,864,874 | 876 |
| Pack three real product operands per complex source slot | 2,405,711,864,874 triplets | 1,281 |
| Pack conductor-shared kernel operands | 9,002,338,536 triplets | 4 |
| Generate certified chirps | 6,397,142,169 complex entries | 12 |
| Centered split of tile products | 1,051,852,215 | 3,158 |
| Add retained low or high pieces | 1,836,492,654 | 528 |
| Convert three completed accumulators to field bytes | 35,871,686 complex tiles | 155 |
| Extract, recombine, postchirp, normalize, round and emit | 1,775,431,871,117 samples | 1,542 |

## Stream and proof obligations

For each conductor, generate and certify the even-periodic chirps p_j for j=0..m+J. Use conjugates and symmetry to produce the kernel over −J..m+J. Maintain a packed kernel cache across that conductor's primitive character lanes. For each character, regrid its admitted exact Gaussian centers at j=0..J. Reconstruct the negative entries by conjugation and prechirp both sides. Materialize three signed streams for re, im and re+im with the proven global field width w from the row. The analogous kernel streams are consumed by the three independent real products. A kernel eviction or a reset that loses proof context requires another admission.

Visit products in ascending tile diagonal. For a product z, set H=2^(wT), high=floor((z+H/2)/H), low=z−H high. This is a signed split. The bound 4LXY<2^(w−1) applies to every partial convolution coefficient, so low lies in the centered interval, represents the complete low polynomial, and introduces no spurious digit carry. Retain a low or high piece only if it intersects the requested middle window. Each diagonal finalizes the previous carry plus its low pieces and accumulates high pieces for the next diagonal. Two accumulation tiles per real convolution suffice. The largest pair of operands is below 12.2 MB total, before product, scratch and temporary buffers. Large conductor inputs and kernels can live in tiled backing stores. This bounds the live accumulator count while potentially rereading operands.

When all three scalar tiles complete, recover a real and imaginary convolution numerator from t1−t2 and t3−t1−t2. Only the real postchirped coordinate is needed. If r,s are the grid-p postchirp numerators and C,D the convolution pair on grid 2p, the terminal real center on normalized grid p is nearest((Cr−Ds)/2^(2p+log2 N)). The resulting center represents U/N. Multiplication by N is exact when applying the raw sample guard. The implementation model writes the normalized signed output to bytes and includes that memory write in its sink timing.

Retain the existing raw error tolerance 7 eps N Delta/2816 and the row-specific chirp precision proved in ../c10000-kronecker-time-price/README.md. It includes initial regrid, prechirp rounding, root perturbations and terminal normalized rounding. The Gaussian-source construction, Hermitian symmetry, exact support, canonical phase, sign threshold and downstream interpolation still need their own evidence. This is a small-family time transform of stored Gaussian coefficient centers; it does not consume a separate Hurwitz raw head. An implementation must verify the source bound B, signed operand packing and root accuracy before using the middle-convolution theorem.

## Calibration and data movement

nonproduct.py prices four byte-aligned width classes, 552, 616, 680 and 744 bits, using their actual conductor populations. Synthetic signed prechirp pairs have approximately p+39 source bits and p-bit multiplier coordinates. The prechirp test measures fixed-point complex products. The regrid benchmark uses a synthetic 32-bit shift; wider source encodings or non-dyadic inputs require a new price. Field packing includes conversion to fixed-width bytes and assembling the big integer. The split test uses a signed full-length synthetic product. The sink and extraction test uses independent signed result fields close to the field limit and charges three field reads, complex recombination, postchirp, division by a power of two, rounding and signed byte output. Its representative normalization shift uses N=2^19. The calibration charges full-tile bytes for tile finalization and full-width splits even on ragged ends. Native Arb evaluated chirps directly and checked strict nearest-p rounding in representative 2,048-entry samples. The chirp estimate assumes successful rounding at p+64 working precision; ambiguous intervals require additional precision or exact special-case handling.

Reported hours are wall-time proxies for one worker. Small kernel timings vary with scheduling and interpreter overhead. The script does not measure HOL theorem construction, IO to disk or network, actual Gaussian supplies, long-lived kernel lookup, source conjugate traversal, page faults, chunk scheduling, and downstream sign checking. Memory arithmetic and explicit byte construction are included. The proof checker needs independent timings for paired-coordinate regrids, signed packing, partial extraction, centered splits at wT bits, scalar tile additions, recombination, rounded normalized emission, and binding these results to actual indices.

The packed source spool accounts for 513.45 TB written once over the schedule; the conductor-shared kernel spool accounts for 1.962 TB. The output record format costs 67.63 TB, with a width derived from B and p for each conductor. Diagonal traversal presents 9.404 PB of summed operand capacity to the multiplication engine. Some of these bytes may be reused in RAM; the number is not an observed disk reading. If all nominal operand bytes crossed a storage interface, that transfer alone would take about 522 hours at sustained 5 GB/s or 26,123 hours at 100 MB/s. Do not add this example to the arithmetic price without a cache, overlap and storage policy.

receipt.json records class populations, exact counts and event rates. control.py independently exercises signed packing, centered split, diagonal piece retention and digit recovery against direct convolution for 125 small middle-window configurations.
