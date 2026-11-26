# Marginal kernel cost of an adjacent Goldbach tile

Stock Lean 4.35.0 took **0.594, 0.625 and 0.594 CPU seconds** to check a second production tile and join it to the first. Each tile covers 33,554,432 even integers. The pair uses the same verified bitmap and primorial certificate.

| Trial | First tile elapsed (s) | First tile CPU (s) | Second tile and join elapsed (s) | Second tile and join CPU (s) |
|---:|---:|---:|---:|---:|
| 1 | 0.6283765 | 0.625000 | 0.5901539 | 0.593750 |
| 2 | 0.6357084 | 0.640625 | 0.6268390 | 0.625000 |
| 3 | 0.6418828 | 0.656250 | 0.5909396 | 0.593750 |

A separate run of the portable script on the same host took 1.313 CPU seconds for the first phase and 1.047 CPU seconds for the second. Elapsed times were 1.383 and 1.051 seconds. The trial-to-trial range above does not bound run-to-run variation. [Portable replay receipt](evidence/portable-validation.json)

The first tile covers even integers in `[563648128002, 563715236866)`. The second covers even integers in `[563715236866, 563782345730)`. The original Lean file defines the private theorems `c48` and `c56`. Each uses eight rows with sixteen packed literals. The benchmark appends two public references to the exact original bytes. The first reference selects `c48`. The second applies `SmallGoldbach.join` to `c48` and `c56`. [Original proof source](https://github.com/elliotglazer/ternary-goldbach/blob/fc729595d20448d3689f706378879a30a323a762/ProductRange563245474818Interval.lean) · [Source and interval hashes](provenance.json) · [Appended declarations](append.lean.inc)

Each trial starts a fresh Lean process and loads the production module’s prebuilt imports. The driver collects the new declarations needed for the first reference and passes them to `Lean.Kernel.Environment.replay`. It uses the environment returned by that call for the second reference. Each call adds five declarations. The driver checks that each root is absent before its call and present afterward. Both references report `propext`, `Classical.choice` and `Quot.sound`. [Timing driver](MarginalReplay.lean) · [Axiom audit](evidence/compile.log) · [Raw trials and added declaration names](evidence/marginal-replay-receipt.json)

The elapsed clock covers the kernel API call. Windows `GetProcessTimes` supplies user and system CPU time across a synchronization handshake, at coarser resolution. The measurements were made on a Windows x86-64 AMD Ryzen 9 8945HS host. The augmented source took 15.078125 CPU seconds to compile before the timed trials. An earlier run hit Lean’s 2,600 MB limit during the second tile. All three reported trials completed with `-M3500`. [Compilation receipt](evidence/compile-receipt.json) · [Earlier memory-limit exit](evidence/failed-2600MB-trial.json)

The timings exclude loading imports, checking the shared bitmap and primorial from scratch, generating or reading a full proof export, and running NanoDa or Comparator. They measure one adjacent pair with the 22-bit bitmap. Other bitmap widths, other witnesses and full ternary Goldbach require their own measurements.

## Reproduce

Use Python 3.11 or newer, Git and the pinned Lean toolchain. The following commands run from this bundle’s directory.

```sh
python3 replay.py --verify
git clone https://github.com/elliotglazer/ternary-goldbach.git /path/to/goldbach
git -C /path/to/goldbach checkout fc729595d20448d3689f706378879a30a323a762
python3 replay.py /path/to/goldbach --out /path/to/new-result
```

The replay builds `WideSource22` and `PilotPrimeProductBasis` with Lake. It verifies the project source, Mathlib and Lean revisions, rebuilds the augmented module and timing driver, and writes each trial’s log and the new receipt under the output directory. Existing prebuilt imports can be supplied through `--lean`, `--mathlib` and repeated `--lib` arguments. All platforms record elapsed time. Windows and Linux also record per-phase process CPU. [Replay script](replay.py) · [Bundle checksums](sha256.json)
