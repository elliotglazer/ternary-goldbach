# Stock Lean dependent-block comparison, 13 November 2026 UTC

The same dependent integer network now compiles in stock Lean 4.35.0. Every
concrete mathematical theorem has exactly propext, Classical.choice and
Quot.sound in its axiom audit. All five corrupted positive claims fail strict
kernel checking; separate theorems prove their checker results are false and
have no axioms. No native_decide, custom axiom or dependency rebuild is used.

## Contract and scope

DependentBlock.lean follows the HOL4 definitions for positive scale. It proves
the floor-rounding residual bound, all four local butterfly residual bounds,
length preservation and the dependent layer/network contracts. It then derives
existence of a final vector with the network contract, the original length, a
coordinate bound and an exact output checksum from an accepted computation.
Successive layers consume the preceding output, and a left rotation connects
different pairs. The checksum is an output statistic, not a commitment.

generate.py reads the exact hol4-setup/dependent_fixture.json integers. The
scale is 2^343 and the four depths are 1, 8, 32 and 128, each with 64 butterflies
per layer. A fixture hash and source hashes bind this comparison to HOL4 and
native GMP. It has no certified roots, source enclosures, real interpretation,
global error propagation or zero count. It is not an FFT or a TG proof.

## Measurements

Each proof is first compiled normally. Fresh kernel replay then collects the
three declarations in the concrete theorem's proof closure, renames them,
rejects surviving references to the old concrete namespace, and submits them
to addDeclCore at trust level zero. This includes the numeric proof helper,
not only the cheap final application of accept_sound. Each of three fresh
processes performs one untimed warmup and one timed replay from the same base
kernel environment. Generic theory and input definitions are imported.

| Layers | Butterflies | Lean kernel replay median | HOL4 acceptance median CPU | Native GMP median CPU |
|---:|---:|---:|---:|---:|
| 1 | 64 | 128.975 ms | 45.564 ms | 0.103176 ms |
| 8 | 512 | 579.512 ms | 108.877 ms | 0.303512 ms |
| 32 | 2048 | 2.846937 s | 47.987 ms | 0.964792 ms |
| 128 | 8192 | 13.464615 s | 73.960 ms | 3.747830 ms |

The Lean column measures elapsed time inside a single-threaded kernel loop.
The other columns measure CPU time. Windows Lean and WSL HOL/GMP also have
different process and I/O environments. The large-block ratios of roughly
180 to HOL4 and 3600 to native GMP are therefore approximate comparisons,
not controlled measurements of a universal prover constant. The three Lean
large-block samples are 10.809693, 14.855863 and 13.464615 seconds.

One normal build of the 8192-butterfly proof file costs 16.8125 CPU seconds
and 16.9678 elapsed seconds, including imports and proof elaboration/checking.
The generic theory build costs 6.59375 CPU / 26.1127 elapsed seconds. The data
file costs 7.734375 CPU / 7.9376 elapsed seconds and includes the changed-input
and changed-coefficient definitions used by the controls. Do not compare that
entire file directly with HOL4's setup for only the original payload.
All process memory, artifact sizes and setup costs are in RESULTS.json.

The cold proof build and a replay process have different purposes. A replay
process includes imports, an untimed warmup and the timed check; its whole CPU
time is not the single replay cost. No file or loop timing is a full TG cost.

## Consequence

Moving dependent work inside one function is not enough to obtain HOL4-like
throughput in stock Lean. The current Lean kernel still pays substantial costs
for this list-and-Int computation. These are measured implementations, not
lower bounds on the best standard-axiom Lean proof. The earlier scalar-certificate
and this output-producing algorithm have different contracts, so their ratio
must not be used to discount the old full TG forecast.

A separate packed-natural-number probe is complete. Small batches of products
check about 1.7 to 2.7 times faster, while the sparse 64-product layout loses to
scalar arithmetic. Balanced literal loading also removes a severe frontend
bottleneck. PACKED_REPORT.md and PACKED_RESULTS.json record the successful
audits and three fresh processes per case. The packed identities still lack
the generic positional-digit bridge, signed arithmetic, rounding, bounds and
full network. No full-proof cost is discounted by these local ratios.

## Reproduction and audit

generate.py creates input definitions, all concrete theorem files, replay
commands and controls. run_lean.py uses the pinned Lean executable, one thread,
trust level zero, a 600-second wall cap and a 4 GiB memory limit. Only new
project-owned outputs are written. StageCheck and Replay are read-only shared
dependencies pinned by hash. The maxRecDepth setting is 65536; heartbeats are
unlimited inside the externally bounded process. Those options change resource
limits, not proof acceptance.

run_suite.py build builds the four concrete proofs and controls and performs
the axiom audit. run_suite.py replay runs the twelve fresh replay processes.
summarize.py requires every successful exit, exact axiom set, expected kernel
control outcome, complete renamed closure and all three samples before writing
RESULTS.json. These scripts create named logs exclusively, so reproduction
needs fresh labels or a separate output directory rather than overwriting
the recorded measurements.
