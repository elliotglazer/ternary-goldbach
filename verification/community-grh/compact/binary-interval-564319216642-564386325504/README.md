# Binary Goldbach from 564,319,216,642 through 564,386,325,504

Every even natural number from 564,319,216,642 through 564,386,325,504 inclusive is a sum of two primes. Stock Linux Lean 4.35.0 and NanoDa accepted the original production theorem. The interval contains 33,554,432 even inputs. Its independent Mathlib-only challenge defines the exact meaning of coverage and prime pairs. [Trusted challenge](TrustedPrefix.lean) · [Checker log](comparator.log) · [Axiom audit](axioms.log)

This is a separate finite binary Goldbach theorem. The all-input ternary Goldbach proof still requires its full finite coverage and analytic argument. The challenge checks the statement against the production theorem. The production axiom audit reports `propext`, `Classical.choice` and `Quot.sound`.

The measured build used [project commit fc729595](https://github.com/elliotglazer/ternary-goldbach/commit/fc729595d20448d3689f706378879a30a323a762). All 15 production source files listed in the receipt have identical bytes at [candidate b5b23824](https://github.com/elliotglazer/ternary-goldbach/commit/b5b238244b7b73e2ebcd13ca6d16782e90faea4b).

The 15 project modules in the source closure took 0.132 core-hours to compile. The endpoint module itself took 17.25 CPU seconds after its shared dependencies were available. This sample includes one range check and the two upstream source maps. The source timings assume that the pinned Mathlib dependencies are available.

Compiling the two verification modules and exporting their inputs took 0.258 core-hours. On one Linux CPU the protected structural comparison and the two kernel checks took 1409.97 seconds together. The receipt reports per-process CPU and peak memory samples. [Receipt](receipt.json)

## Replay

Use Linux with stock Lean 4.35.0, Git and Bubblewrap. Use trusted Mathlib package objects or build the dependencies at their pinned revisions.

```sh
git clone --filter=blob:none --no-checkout --branch codex/community-grh-compact https://github.com/elliotglazer/ternary-goldbach.git goldbach-source
git -C goldbach-source checkout --detach fc729595d20448d3689f706378879a30a323a762
(cd goldbach-source && lake exe cache get && lake build +ProductRange564319216642Interval)
python3 /path/to/evidence/replay.py goldbach-source /tmp/goldbach-product-tile
```

The script regenerates both exports and saves the protected judge log in the new output directory. [Solution import](FinitePrefixSolution.lean) · [Judge policy](comparator.json) · [Pinned production theorem](https://github.com/elliotglazer/ternary-goldbach/blob/fc729595d20448d3689f706378879a30a323a762/ProductRange564319216642Interval.lean)
