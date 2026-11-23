# Dense-cell generating-function certificate

Stock HOL4 checked two 128-residue cells at conductor 131071. Every residue
is a unit. The height-1 central cell (512) has degree 8 and uses 240-bit
signed fields. The height-6400 cell (1) has degree 19 and uses 440-bit
fields. Both coordinates are included in every per-output measurement.
The denominator for a cell of degree d is (2c)^d.

| CPU µs per complex output | Degree 8 | Degree 19 |
|---|---:|---:|
| Compute seeds, establish bounds and check packed congruence | 835 | 1735 |
| Extract and compare rounded coordinates | 599 | 1802 |
| Fused certificate and extraction | 1449 | 3655 |
| Direct exact Horner and final rounding | 27.28 | 38.62 |

These are medians of five stock CV evaluations in a single HOL process
with previously admitted terms and selected equations. The fused calculation
also took 1.859 and 2.761 CPU seconds per cell to admit the input terms.
CPython direct candidate generation plus packing took 197 and 438 µs per
cell respectively, timed separately. The HOL timings for individual
operations include the costs of their own distinct inputs and conversions.
The 15–18 µs target exceeds the throughput of every full evaluation here.

From the scaled coefficients, the checker computes the first d+1 polynomial
values and applies d+1 backward differences on a zero-extended prefix.
Packing the resulting prefix gives U(B). It checks the congruence modulo
B^128 and the range of the biased packed candidate. It also verifies an
absolute-coefficient Horner bound at the maximum displacement and both
endpoints. The sink extracts each field and rounds with ties upward. A
separate direct evaluator checks the same claimed outputs against the same
scaled coefficients. Kernel equality with T was checked, including the
exact left-hand term and empty theorem hypotheses. These fixed instances
do not export a general finite-difference soundness theorem. The input
coefficient/denominator alignment was performed by the Python generator.

cert04.log records all individual trials. prices.json gives the medians
and input-admission charges. producer.log covers the native producer.

## Pairing real and imaginary coordinates

The pair/ subdirectory contains the NatPair replay at the same two cells.
With 128 consecutive residuals, the checker chooses the positive or
alternating-sign coefficient table according to the signed displacement,
evaluates one natural-number Horner recurrence at its absolute value,
decodes the two fields, subtracts the exact geometric bias and rounds.
The same-process signed comparison emits the same interleaved 256 centers.
All five trials closed for every mode.

| Median stock CV kernel µs/complex output | Degree 8 | Degree 19 |
|---|---:|---:|
| Literal packed columns and per-residue biases | 91.94 | 94.88 |
| Construct sign columns, use literal per-residue biases | 79.75 | 84.84 |
| Construct sign columns and all per-residue biases | 43.48 | 31.34 |
| Interleaved direct signed scalar | 44.33 | 33.29 |

The last fused case starts from aligned grid-94 coefficient pairs and supplied
powers of the denominator and bias-column weights. It includes coefficient
packing, sign selection, bias evaluation, final divisions and output equality.
It required 2.147/2.302 CPU seconds of input admission for the two cells.
Direct signed started from weighted coefficients and required 1.726/1.264 s.
These checks do not price the source producer or high-band transfer. Serving
cached objects from an upstream CV computation would differ from supplying
cached integers as literal HOL inputs. pair/prices.json and pair/pair01.log
record the admission phases and the five replays.
