# Lean kernel mask-certificate benchmarks

Date: 2026-11-10. Scope: isolated experiments under `work/formal-goldbach-bench/lean`. No canonical repository or dependency was changed, and no Mathlib build was run.

## Result

Large natural-number operations in Lean 4.35 materially outperform a bit-by-bit proof model. On the measured actual-prime fixtures, the fastest checked coverage calculation per target was a packed multiplication at width 262144: 3.400 ms per block, or 12.97 ns per target. At width 65536, direct shifted-mask coverage took 1.750–1.803 ms; the packed calculation took .986–1.010 ms. Building the direct proof expression from cached slice expressions increased its cost to 1.927–2.016 ms.

These are real kernel-checked arithmetic equalities, not native-evaluation assertions. They are not complete Goldbach proofs: primality and the correspondence between the supplied numerical data and a certified prime table remain outside these microbenchmarks.

## Toolchain and checking boundary

The executable was `C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe`, reporting Lean 4.35.0, x86_64-w64-windows-gnu, commit `eb6cafb7290e8bd5f2937522d8d804f58f02bafc`, Release. Runs used the installed Init/Lean modules, with no external libraries.

The final measurements pass `-t0`. Their logs print `TRUST,0`. The harness invokes `Kernel.Environment.addDeclCore 0 100000 declaration none`; here the first zero is the unlimited-heartbeat setting, not a trust setting. The environment's trust setting comes from `-t0`. Every declaration is checked by the C++ kernel. The environment returned by a check is discarded for the repeated direct-check cases, so no previously accepted theorem substitutes for checking the next trial.

Ordinary imported compiled Init/Lean modules remain the baseline, as in a normal Lean invocation. This experiment does not independently rebuild or verify their entire library. Early discovery runs used the default environment trust value 1025 and are explicitly separated from the final strict runs.

`Audit.lean` installs the actual 65536-bit direct theorem using the checked environment API and stores it in `Audit.olean`. `#print axioms actual_mask_cover` reports `[propext]`. `PackedBench.lean` installs the analogous packed theorem; it also reports `[propext]`. The generic `or_extend` lemma reports `[propext]`. There are no custom axioms, `sorry` proofs, or `native_decide` calls in the accepted benchmark path. `Tiny.lean` additionally checks an ordinary Init-only source theorem by `rfl`.

The installed version's kernel directly recognizes `Nat.land`, `Nat.lor`, `Nat.xor`, shifts, addition and multiplication on numeral arguments. In particular, runtime overrides in the Lean definitions do not mean the final kernel uses recursive bit evaluation here. See the version-pinned [kernel implementation, especially lines 639–654](https://raw.githubusercontent.com/leanprover/lean4/v4.35.0/src/kernel/type_checker.cpp).

## Exact claims checked

For a direct fixture, let P be the supplied source bitset, W the target width, F=2^W-1, and s_i the supplied shifts. The whole-source claim is

    land (lor_i (shiftRight P s_i)) F = F.

The earlier layout applies `land ... F` to each shifted source before OR. Both were measured. The chunked version represents each source window by two adjacent W-bit chunks and uses the appropriate shift within that pair. It avoids shifting a huge global prime table.

The proof value is `Eq.refl F`, and the declared type contains the unreduced arithmetic expression above. The kernel must reduce that expression to establish definitional equality. Input terms are shared expression DAGs, not repeated text copies.

For the packed fixture, each source bit is placed in a base-B digit, B=2^k. The anchor polynomial contains one term per shift. The checked claim is

    land (add (mul expandedP anchorA) Ks) Hs = Hs.

Hs contains the high bit of every target digit, at the correct shift offset. Ks contains one less than that high bit in each target digit. The fixture producer checked the convolution coefficients and chose a base large enough to prevent carries. Connecting this arithmetic equality to the original bitset and to positive coverage is a separate mathematical lemma, not proved in this benchmark. The kernel equality itself has no assumed success premise.

The numerical fixtures came from the separate prime-cover worker. Widths 1024, 16384 and 65536 use 110, 168 and 168 actual prime shifts; widths 262144 and 1048576 use 188 and 250 shifts. The source bit lengths include the necessary halo, not merely W bits. These are externally produced data from actual prime computations, not Lean-certified primes. Copies of their exact operands are fixed in `Fixtures.lean`, `PackedFixtures.lean`, and the `operands` directory.

## Primary measurements

Times are milliseconds per accepted block proof. Ranges show two runs on the same shared host, not statistical confidence intervals.

| Width | Anchors | Direct OR, two chunks, mask once | Packed 3-operation equality |
|---:|---:|---:|---:|
| 1024 | 110 | .873 discovery run | .0694–.0738 |
| 16384 | 168 | 1.540 discovery run | .360–.393 |
| 65536 | 168 | 1.750–1.803 | .986–1.010 |
| 262144 | 188 | 4.785 | 3.400 |
| 1048576 | 250 | 19.086 | 20.303 |

The two smaller direct-OR entries are from the initial default-trust discovery run. They are not used as strict-run forecast anchors. All packed entries and direct entries at width 65536 and above are strict runs.

At width 65536, strict whole-source/per-mask masking took 3.369–3.457 ms, versus 1.941–2.247 ms after moving the final mask outside the OR. The chunked/per-mask layout took 2.672–3.035 ms. Masking once is therefore a material optimization in this test.

The explicit reusable-lemma comparison creates a checked theorem for every OR extension, uses `or_extend` to connect it to the previous prefix theorem, and checks the final full-mask target. It took 168–222 ms per 65536-bit block, roughly two orders of magnitude slower than the direct arithmetic equality. This is an engineering comparison of these implementations, not a lower bound on all lemma-based designs. That lane includes construction of its intermediate expressions and environments.

For the direct 65536-bit chunked case, expression construction from cached source-slice expressions plus checking took 1.927–2.016 ms. The corresponding check-only result was 1.750–1.803 ms. For the packed case, construction plus checking took .953–1.029 ms. Its occasional lower time than the check-only run is ordinary run-to-run variation; no negative construction cost is inferred.

The initial synthetic sweep varied 32, 128 and 256 masks at fixed widths. At W=65536 with the mask moved outside the union, the recorded totals for 1000 trials were .382, 1.432 and 2.920 seconds. This supports approximately linear growth in the number of masks over that range. A partial captured output is preserved in `Sweep.discovery.extract.log`; the full reproducible sweep source is `Sweep.lean`. It is discovery evidence at trust 1025, separate from the strict actual-fixture results.

## Timing interpretation

`kernel_seconds` in each JSON is elapsed monotonic time inside the checked-declaration loop. It includes kernel computation, declaration admission and disposal of returned environments. It excludes module loading, data parsing, fixture construction and initial expression construction except for the explicitly named build-and-check lanes. Trials use warm operands and a stable imported environment.

The runner also uses Windows `GetProcessTimes`. `user_seconds` and `kernel_cpu_seconds` cover the whole child process. The latter means Windows operating-system CPU time, not time inside Lean's logical kernel. Overall wall time and these CPU fields must not be substituted for the inner timing without stating the distinction. The host was shared with other experiments; no core pinning or isolated-frequency protocol was used.

Repetition counts were 1000 for the strict 65536-bit direct cases, 10000 for 1024-bit packed cases, 2000 for 16384/65536-bit packed cases, 500 for 262144-bit cases, and 100 for 1048576-bit cases. Every row records the exact count and number accepted. Packed per-mask rates in JSON are normalizations by the original anchor count; the packed kernel does not execute one operation per mask.

## Negative controls

Every direct numeric declaration is accompanied by a corrupted proof result, using a reflexivity proof of the wrong numeral. The checked API rejects it. Every packed case is also checked with its expanded source replaced by zero and the required target unchanged; it is rejected. These checks run at `-t0` in the final data.

`CorruptSimple.lean` is an ordinary source proof claiming `Nat.lor 3 4 = 6` by `rfl`; Lean exits 1 with a definitional-equality error. The expected failure is recorded separately. The reusable-step lane reuses the already-tested checked API and has a final target check, but its JSON `rejected` field inherits the suite control; it is not a separate mutated-chain experiment.

## Reproduction and artifacts

Run from this directory in PowerShell:

    ./run_all.ps1 -Large

This compiles only the local fixture definitions and audit target, then runs the scoped Python harness. No Lake or Mathlib command is involved. A different installed toolchain can be supplied through `-Toolchain`, but the recorded results are specifically for 4.35.0.

Equivalent individual commands, with LEAN_PATH set to this directory, are:

    lean -t0 -o Fixtures.olean Fixtures.lean
    lean -t0 -o PackedFixtures.olean PackedFixtures.lean
    lean -t0 -o Audit.olean Audit.lean
    python run_bench.py QuickActual.lean QuickActual.replay
    python run_bench.py PackedBench.lean PackedBench.replay
    python run_bench.py LargeBench.lean LargeBench.replay

The main raw results are `QuickActual.strict` and `QuickActual.repeat`, `PackedBench.strict` and `PackedBench.repeat`, and `LargeBench.strict`, each as both `.log` and `.json`. `Audit.strict` and `Tiny.strict` record accepted proof audits. `CorruptSimple.expected_failure` records the rejected source proof. `artifacts.sha256.json` pins the source, data, accepted audit artifact and result files.

Exploratory `Hello.lean`, `KernelBench.lean`, `SourceProofs.lean`, and `Corrupt.lean` are not part of the final replay. The full `import Lean` standalone harness stalled in this environment; narrowing to `Lean.Elab.Command` and using the command's existing environment solved that setup issue. A large textual nested-rfl frontend trial was stopped before completion. Neither incomplete trial contributes a successful timing claim.

## What remains for the full finite Goldbach theorem

The benchmark proves arithmetic coverage of supplied data. It does not prove the source flags prime, the anchors prime, the source-address mapping, the correctness of packed expansion, the no-carry interpretation, or global interval coverage up to 4e18. It also does not measure certificate serialization, source data production, checked sieve cost, a long-lived theorem environment, or complete proof aggregation.

The best observed 12.97 ns per target would scale arithmetically to roughly 822 core-years for 2e18 targets if it held uniformly. That is a coverage-kernel-only extrapolation, not an end-to-end forecast. Width choice, anchor counts, packing, data movement and prime certification can change it substantially. The experiment does show that the prior literal per-bit/per-strike PA trace model cannot be used to predict this optimized Lean coverage path.

Key source SHA256 identities:

- `QuickActual.lean`: `7cff6c2c09f1dd7bf01cf88ffee0a13c5a655da314a44d6ff87fba7f1b100bfd`
- `PackedBench.lean`: `957483a3be153593107c3547608d5cff600cdf38b2615ff2a242f7d967bf44fa`
- `LargeBench.lean`: `0049b39b9f03fd04c9e14e6ba0262f620d69705fd9f0afda8c7f35bf6efd7102`
- `Audit.lean`: `4a291b5b1c45e8df4144176d343739ba0a2791553718069bf778a6cd112813ca`
- `run_bench.py`: `d38553e9a35bedd4a1746bb67a474e31137c3daeaf85f847ec13ad6b9090bc13`
- `run_all.ps1`: `189a5f5ba211e938d368d031de8b0ba07128904e12d270475ec02a4d6918e19c`
