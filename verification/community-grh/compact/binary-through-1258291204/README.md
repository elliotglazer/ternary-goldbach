# Binary Goldbach through 1,258,291,204

Every even natural number from 4 through 1,258,291,204 inclusive is the sum of two primes. Stock Lean 4.35.0 and NanoDa both accepted the exported proof. Their protected Linux run took 262.71 seconds on one CPU. [Checker output](comparator.log) · [Measurements and SHA-256 digests](receipt.json)

The first production block proves coverage from 6 up to the exclusive endpoint 1,258,291,206. The adapter uses the existing `prefix_of_covered` theorem to include 4 and express the largest even endpoint explicitly. The trusted module independently defines the meaning of coverage using only Mathlib and states both the original block and the inclusive prime-pair theorem. [Trusted statement](TrustedPrefix.lean) · [Solution adapter](FinitePrefixSolution.lean) · [Pinned production block](https://github.com/elliotglazer/ternary-goldbach/blob/fc729595d20448d3689f706378879a30a323a762/Power10Block00.lean)

The native Windows build used Mathlib at `56a005855ea17e0b0958f73ec801ae140b0a1679`. The Linux judge matched the statements against the independent challenge, checked the axiom whitelist and ran both kernels on the same proof export. Each theorem uses `propext`, `Classical.choice` and `Quot.sound`. [Axiom output](axioms.log) · [Judge policy](comparator.json)

## Replay

Use Linux with the standard Lean 4.35.0 distribution, Git and Bubblewrap. Keep this evidence folder accessible while preparing a separate source checkout. The challenge uses Mathlib and its transitive packages from that checkout. Use trusted package objects from the pinned Mathlib cache or build them from their pinned sources.

```sh
git clone --branch codex/community-grh-compact https://github.com/elliotglazer/ternary-goldbach.git goldbach-source
git -C goldbach-source checkout --detach fc729595d20448d3689f706378879a30a323a762
(cd goldbach-source && lake exe cache get && lake build +Power10Block00)
python3 /path/to/evidence/replay.py goldbach-source /tmp/goldbach-first-block
```

The replay writes `challenge.export`, `solution.export` and `comparator.log` to the output directory. The original export sizes and hashes are in the receipt. Platform-specific elaboration can change the export bytes. Comparator checks the mathematical statements and proof on each replay.
