# Ternary Goldbach in Lean — source replay in progress

The solution source states that every odd natural number above five is the sum of three primes. The challenge and solution declare `PalomarTernaryGoldbach.ternary_goldbach`. The arithmetic and analytic proof is assembled in `CompletedFiniteRows.lean`. The application in `CompletedGoldbach.lean` uses the two theorems exported by the pinned community GRH package.

Use the Lean toolchain in `lean-toolchain` and the Git revisions in `lake-manifest.json`. Build with `lake build GoldbachSolution`. The trusted challenge can be checked independently with `lake build GoldbachChallenge`. Comparator configuration is in `comparator.json`.

The legacy source archive and the individual source checksums are identified in `source-manifest.json`. Historical attribution is preserved in `NOTICE`, with upstream licenses and notices in `licenses/`. The 4.37 port is under verification. The challenge and the FastHex and GoldbachNatPowMod modules have compiled in this package. The complete solution and comparator run are outstanding.
