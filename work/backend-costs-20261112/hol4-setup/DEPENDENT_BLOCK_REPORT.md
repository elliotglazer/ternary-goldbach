# Dependent arithmetic blocks, 13 November 2026 UTC

The compact-block experiment succeeds. HOL4 executes successive rounded
butterfly layers, derives a closed integer mathematical result, rejects five
corruptions and exports the result. Three fresh processes produce byte-identical
exports. The matching native GMP program checks every output coordinate against
the independently generated reference and rejects the same five corruptions.
This is a dependent integer network, not a certified FFT or a zero counter.

## Mathematical contract

The initial data are the 128 complex inputs and 64 coefficients in the existing
P343N64 fixture. Each layer applies the output-producing rounded butterfly to
adjacent pairs, then rotates the entire vector left by one complex coordinate.
The next layer consumes that result. Rotation connects different pairs across
layers. Coefficients remain fixed across layers. Later layers do not replay the
initial inputs. This permutation and coefficient schedule are not an FFT.

DependentBlockScript.sml proves preservation of length and an inductive
contract containing every layer's local integer residual inequalities. It also
proves that acceptance implies the existence of a final vector with that
contract, the original length, a verified coordinate bound and an exact
checksum. The checksum is the integer fold r+3*i+9*rest. It is an output
statistic, not a cryptographic commitment, and does not claim uniqueness or
equality of vectors with equal checksums. No hash assumption enters the proof.

The evaluator computes rounded outputs internally using floor division. It
does not consume the earlier scalar checker's claimed output at each butterfly
or run all nineteen conditions at every step. The positive-scale preconditions
are proved and discharged explicitly. Concrete input constants are conservative
definitions built from the pinned fixture, with integer-construction round trips.

Roots of unity, source enclosures, real interpretation, propagated global
errors and zero-count completeness remain outside this experiment. The final
coordinate bound is checked on the computed result. A generic intermediate
range/error invariant for the intended spectral algorithm is still needed.

## Measured costs

HOL4 has three calls per case in each of three fresh processes. Native GMP has
three batches of 1000 calls per case in each of three fresh processes. The two
measurement campaigns run sequentially. Medians below pool the nine observations
per case. Calls reuse the same named input and coefficient constants. Native
timings include copying inputs, all layers, the final bound and checksum checks;
they exclude initial decimal-string parsing. HOL timings include cv_eval, closing
its precondition and checking that its equality refers to the exact input term.
Deriving the existential mathematical conclusion adds a small fraction of a
millisecond in the recorded runs.

| Layers | Butterflies | Maximum coordinate bits | HOL4 median CPU | Native GMP median CPU |
|---:|---:|---:|---:|---:|
| 1 | 64 | 354 | 45.564 ms | 0.103176 ms |
| 8 | 512 | 358 | 108.877 ms | 0.303512 ms |
| 32 | 2048 | 370 | 47.987 ms | 0.964792 ms |
| 128 | 8192 | 418 | 73.960 ms | 3.747830 ms |

The small HOL cases show considerable variation and nonmonotonic medians.
Do not fit a global throughput law to them. The 128-layer calls range from
64.013 to 123.944 ms, with process medians 67.575, 72.952 and 122.038 ms.
Its pooled rate is 9.028 microseconds per butterfly, versus 0.4575 microseconds
in native GMP, a 19.7-fold runtime ratio on this particular block.

Preparing the named literal input and coefficient representations costs a
median 4.269485 CPU seconds per fresh HOL process, excluding source construction.
That cost is shared across the four sizes and their repeated calls. It must be
charged again when a fresh payload needs a new representation proof. Naming
constants makes the final statement compact; it does not eliminate this cost.
Coefficient reuse and internally computed source values may amortize it, but
the latter producer is not implemented by this experiment.

The initial full HOL process takes 18.62 CPU seconds and 27.51 elapsed seconds,
with peak RSS 1385580 KiB. That includes imports, literal translation, all cases,
controls, construction of changed-input definitions and export. The other full
process measurements are retained in DEPENDENT_RESULTS.json. These whole-process
costs must not be divided by a single case's butterfly count as a throughput rate.

The saved results context is 1655281 bytes. All three copies have SHA256
BE312E58A96CCAF1A547C2EFBB24FB0189D569D4929EA5881A72360825349EF3.
The displayed final propositions use named inputs and have 505–545 characters.
The .dat file uses normal HOL4 saved-theorem loading trust; it is not an
independently replayable inference trace.

## What the result changes

The earlier ordinary cv_eval certificate interface cost about three seconds for
64 P343 rows and scaled badly at 256 rows. This experiment shows that those costs
are not lower bounds for output-producing computation inside HOL4. This is a
different acceptance algorithm and contract; its speed ratio is not a measured
stock-Lean, Candle or ordinary-MM0 improvement.

For scale only, applying the 128-layer runtime rate to the previously counted
218799609396458 small-family butterflies gives about 63 core-years of HOL
acceptance or 3.2 core-years of native execution. Charging a fresh copy of the
entire literal setup for each block instead gives about 3700 HOL core-years.
The 32-layer sensitivity is about 162 HOL runtime core-years or 14600 including
fresh literal setup per block. DEPENDENT_SENSITIVITY.json records all scenarios.
These are component sensitivities, not a claim that a real transform has this
shape, a full TG forecast, or lower/upper bounds on an optimized implementation.
The omitted source, roots, other products, large-conductor branch, principal
zeros, completeness, prime coverage, retries, setup/export and engineering
obligations remain nonzero.

The next useful comparisons are the same dependent algorithm in stock Lean and
Candle, followed by a justified input representation or source producer that
avoids repeated per-literal translation. A real spectral block must then add
the coefficient, source and error-propagation contracts. Finite prime coverage
requires its own packed-bitset measurement.

## Trust, validation and reproduction

The ancestry audit permits exactly HOL4's four standard bool-theory axioms:
BOOL_CASES_AX, ETA_AX, SELECT_AX and INFINITY_AX. Every final theorem has empty
hypotheses and no unexpected oracle tag; DISK_THM is allowed for imported
theorems. This is not a three-axiom Lean artifact. No cross-system bridge is
implemented. Successful native execution alone carries no logical authority.

summarize_dependent.py checks completion markers, process exits, the ancestry,
the theorem tags, every saved positive theorem, all rejection controls, matching
fixture hashes and the identical exports before writing DEPENDENT_RESULTS.json.
Controls change the expected checksum, set the bound to zero, change the depth,
change one input coordinate and change a coefficient. The native program also
compares every coordinate of each reference output, not just its checksum.

Source generation uses generate_dependent.py and generate_dependent_native.py.
The existing workspace HOL4 toolchain builds dependent.exe through Holmake.
run_dependent_hol_samples.sh performs the two additional fresh reproductions;
the first complete run is dependent_run.log/.time. build_dependent_native.sh
builds the GMP baseline; run_dependent_native_samples.sh runs its three fresh
processes. Toolchain pins and source/build assumptions are in STATUS.md and
source.json. DEPENDENT_RESULTS.json pins the scripts, results and exports.

Development logs retain failed proof and wrapper attempts. One proof used
unbounded rewriting of a recursive precondition and was stopped. The corrected
proof uses Once, following the upstream examples. The concrete wrapper then
required explicit integer reduction of scale positivity and application of
block_accept_pre_ok to discharge the named precondition. No axiom, admitted
premise or altered arithmetic contract resolved these failures.
