# Candle dependent-network comparison, 13 November 2026 UTC

The dependent integer network now has a complete Candle proof and successful
kernel-channel export. Three fresh processes pass all four workloads and five
corruption tests. Every input, coefficient and output coordinate matches the
shared HOL4/native/Lean fixture exactly. All three exported artifacts are
byte-identical. DEPENDENT_RESULTS.json records the checks, timings and hashes.

## Mathematical contract

dependent_arithmetic.ml proves signed normalization, Euclidean floor division
by a positive natural, and the scaled rounding residual. Negative numerators
with a nonzero remainder receive the required additional quotient unit.
Normalizing each output prevents unnecessary growth in the difference-of-
naturals representation during repeated dependent layers.

dependent_network.ml implements the same three-product complex butterfly,
adjacent pairing, left rotation and dependent iteration used in the other
backends. It proves both output-validity and all four local integer residual
bounds. dependent_sound.ml proves preservation of encoded list validity and
length, every layer's residual contract, the whole dependent contract, final
coordinate bounds and the exact integer checksum. The final theorem has no
hypotheses after the concrete well-formedness proofs and computed acceptance
are supplied.

The contract uses an explicit cval encoding and Zdecode to state integer
facts. Its block relation follows the deterministic computed intermediate
states. The HOL4/Lean relations use their native lists and integer types.
No cross-system interpretation theorem is claimed; all coordinates are also
compared independently on every fixture. This network is not an FFT. It has
no certified roots, spectral source enclosures, global real error bound or
zero-count theorem. The checksum is an output statistic, not a commitment.

## Measurements

Each fresh process constructs the same named inputs, proves their validity,
then makes three acceptance calls at each size. The timed call includes the
ordinary compute interface, derivation of the integer mathematical conclusion
and an empty-hypothesis check. It excludes generic library loading, input setup,
full-coordinate diagnostic dumps and final theorem export.

| Layers | Butterflies | Candle median CPU | HOL4 median CPU | Native GMP median CPU | Lean kernel median elapsed |
|---:|---:|---:|---:|---:|---:|
| 1 | 64 | 114.243 ms | 45.564 ms | 0.103176 ms | 128.975 ms |
| 8 | 512 | 109.908 ms | 108.877 ms | 0.303512 ms | 579.512 ms |
| 32 | 2048 | 126.437 ms | 47.987 ms | 0.964792 ms | 2.846937 s |
| 128 | 8192 | 158.679 ms | 73.960 ms | 3.747830 ms | 13.464615 s |

The largest Candle samples range from 150.126 to 195.682 ms. Its median is
about 42 times native GMP and 2.15 times HOL4. Lean's elapsed/kernel-loop time
is about 85 times the Candle CPU figure, with Windows versus WSL and mixed
clock methods as additional qualifications. These are implementations and
contracts at particular sizes, not universal prover speed ratios or optimized
lower bounds. Fixed conversion/assembly costs dominate the smaller cases.

Input construction, balanced presentation, definitions and validity proofs
cost 3.901, 4.301 and 4.186 CPU seconds in the three fresh processes. The median
is 4.186 seconds. This setup is shared across the timed workloads. Cold setup
must not be silently excluded from a production model that repeatedly creates
new inputs.

The complete processes cost 97.89, 103.73 and 102.61 CPU seconds, with wall
times 120.76, 126.66 and 125.05 seconds. Each includes the shared library and
generic proof development, all cases, controls, coordinate dumps and export.
Peak RSS is about 3328000 KiB with the chosen 3 GiB CakeML heap and 1 GiB stack
settings. This is measured peak memory, not a demonstrated minimum requirement.

## Input presentation, export and trust

The development run checked the mathematical results but failed during export.
The successful fresh runs use balanced append expressions and balanced numeral
expressions in the input definitions. Ordinary kernel-checked equalities relate
these to the canonical data consumed by the evaluator. The final theorem's
large numerals also receive the previously proved presentation conversion.
No numerical fact is assumed and no kernel acceptance rule is weakened.

The dedicated kernel-channel artifact contains the theorem and complete logical
context. It has 349541411 bytes and SHA256

    68262dafb050690d3015fcd903577256ab33cc7a90715ad91834ee7762ae29d9

The three exports have this identical digest. Export costs 3.069, 3.096 and
2.925 CPU seconds. A structural audit finds one empty-hypothesis Sequent and
three NewAxiom entries, with maximum S-expression depth 149. The library axiom
check permits only INFINITY_AX, SELECT_AX and ETA_AX. These are Candle's HOL
axioms, not Lean's three axioms.

The first artifact compresses to 4413583 bytes, with an exact hash-matching
decompression. Structural scanning costs 17.984 CPU seconds and compression
3.094 seconds. Those transport checks occur outside the prover measurements;
they are not independent logical replay. The export includes shared context,
so its byte count is not a per-butterfly or production per-block proof rate.

Source/compiler pins, local binary provenance and host/FFI assumptions are
unchanged from STATUS.md. The published Candle architecture has an end-to-end
soundness development. This experiment does not independently reconstruct the
connection between the downloaded compiler artifact and that formal theorem.
It also does not produce a stock-Lean theorem or an ordinary MM0 proof.

## Cost implication and next step

For a deliberately component-only sensitivity, applying the largest-block
runtime to the old small-family count of 218799609396458 butterflies gives
about 134 core-years. Charging this experiment's entire fresh input setup for
every 8192-butterfly block raises that figure to about 3677 core-years, before
any final export. Neither figure is a full TG forecast or an assertion that
the synthetic network is interchangeable with the spectral workload.

This gap makes source production and data lifetime concrete design questions.
Keep many dependent steps inside one checked execution, derive short semantic
conclusions and account explicitly for shared inputs. A production design
should avoid permanently defining every large intermediate input in the global
logical context. The next useful arithmetic experiment must add actual source
enclosures, coefficients and propagation to reach a spectral conclusion.

## Reproduction

generate_dependent.py reads the pinned shared fixture and creates the exact
input source, full-coordinate dumps and five controls. reproduce_dependent.ml
loads only the completed source versions. run_dependent.sh runs each fresh
sample with a 600-second external wall cap and refuses to overwrite a recorded
sample. summarize_dependent.py requires all three successful processes, all
markers, no errors, exact coordinates, identical exports, the structural axiom
count and a compression round trip before writing DEPENDENT_RESULTS.json.

The interactive development log retains failed proof attempts and the failed
export; it is not a clean reproduction log. An initial metadata hash used LF
text rather than the written Windows file bytes. The generator now hashes the
actual file, and the complete audit passes without changing the numerical
proof source or rerunning completed computations. All processes are terminal.
