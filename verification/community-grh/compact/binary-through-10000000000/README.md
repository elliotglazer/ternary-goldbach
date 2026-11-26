# Binary Goldbach through 10,000,000,000

Every even natural number from 4 through 10,000,000,000 inclusive is the sum of two primes. NanoDa and stock Lean 4.35.0 independently accepted the same proof export of the original production theorem. The trusted statement imports only Mathlib's definitions of primes and parity. [Trusted statement](TrustedPrefix.lean) · [Production theorem](https://github.com/elliotglazer/ternary-goldbach/blob/fc729595d20448d3689f706378879a30a323a762/Power10Joined.lean)

NanoDa accepted during the first protected run. The workstation's memory guard interrupted the following Lean check. A second protected invocation kept the same theorem, axiom policy and read-only exports, and ran the Lean kernel to completion. [First run](comparator-initial.log) · [Lean recovery](comparator-default.log) · [Complete measurements and hashes](receipt.json)

The 19 production modules took 0.285 core-hours with the pinned Mathlib cache. Compiling the small verification modules and exporting both inputs took another 0.039 core-hours. On one Linux CPU, NanoDa had accepted by 554.9 seconds after the first run began. The separate successful Lean invocation took 620.8 seconds including its statement and axiom comparison. [Axiom audit](axioms.log)

## Replay

Use Linux with the stock Lean 4.35.0 distribution, Git and Bubblewrap. Keep this evidence folder separate from the pinned source checkout. Use trusted package objects from the matching Mathlib cache or build the dependencies at their pinned revisions.

```sh
git clone --filter=blob:none --no-checkout --branch codex/community-grh-compact https://github.com/elliotglazer/ternary-goldbach.git goldbach-source
git -C goldbach-source checkout --detach fc729595d20448d3689f706378879a30a323a762
(cd goldbach-source && lake exe cache get && lake build +Power10Joined)
python3 /path/to/evidence/replay.py goldbach-source /tmp/goldbach-10-billion
```

The replay script runs both kernels in one invocation and saves the two new exports and the judge log in the output directory. The receipt gives the filenames and SHA-256 hashes for the original exports. [Solution import](FinitePrefixSolution.lean) · [Two-kernel configuration](comparator.json) · [Default-only configuration](comparator-default.json)
