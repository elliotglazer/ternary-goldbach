# Binary Goldbach through 1,258,291,204

Every even natural number from 4 through 1,258,291,204 inclusive is the sum of two primes. Stock Lean 4.35.0 and NanoDa both accepted the exported proof. Their protected Linux run took 262.71 seconds on one CPU. [Checker output](comparator.log) · [Measurements and SHA-256 digests](receipt.json)

The first production block proves coverage from 6 up to the exclusive endpoint 1,258,291,206. The adapter uses the existing `prefix_of_covered` theorem to include 4 and express the largest even endpoint explicitly. The trusted module independently defines the meaning of coverage using only Mathlib and states both the original block and the inclusive prime-pair theorem. [Trusted statement](TrustedPrefix.lean) · [Solution adapter](FinitePrefixSolution.lean) · [Pinned production block](https://github.com/elliotglazer/ternary-goldbach/blob/fc729595d20448d3689f706378879a30a323a762/Power10Block00.lean)

The native Windows build used Mathlib at `56a005855ea17e0b0958f73ec801ae140b0a1679`. The Linux judge matched the statements against the independent challenge, checked the axiom whitelist and ran both kernels on the same proof export. Each theorem uses `propext`, `Classical.choice` and `Quot.sound`. [Axiom output](axioms.log) · [Judge policy](comparator.json)

## Replay

Use Linux with Lean 4.35.0, Git and Bubblewrap. In a checkout of `fc729595d20448d3689f706378879a30a323a762`, run `lake build +Power10Block00` with the pinned Mathlib dependencies available. Invoke the included replay script with the checkout path and a new output directory.

```sh
python3 replay.py /path/to/ternary-goldbach /tmp/goldbach-first-block
```

The replay writes `challenge.export`, `solution.export` and `comparator.log` to the output directory. The original export sizes and hashes are in the receipt. Platform-specific elaboration can change the export bytes. Comparator checks the mathematical statements and proof on each replay.
