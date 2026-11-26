# Verifying Ternary Goldbach with community GRH

The Lean target is `PalomarTernaryGoldbach.ternary_goldbach`. Every odd natural number greater than 5 is the sum of three primes. The [solution source](https://github.com/elliotglazer/ternary-goldbach/blob/cb1dffe10fd5a86ab53fb71a4812eb73786ed530/GoldbachSolution.lean) states the quantifiers, primality conditions and sum explicitly.

## Replaying the candidate

Check out [candidate cb1dffe1](https://github.com/elliotglazer/ternary-goldbach/tree/cb1dffe10fd5a86ab53fb71a4812eb73786ed530). Its root contains `lakefile.toml`, `lean-toolchain` and the pinned Mathlib manifest. With the specified Lean 4.35.0 toolchain and Mathlib dependencies available, the project build entry point is `lake build`. It defaults to `GoldbachSolution`. For the protected challenge comparison, use the [Palomar replay instructions](stock-runtime/protected-final/README.md).

## What has been checked

| Input or target | Evidence as of November 26, 2026 |
| --- | --- |
| Analytic reduction | Lean compiled and independently reimported the theorem assuming RH, critical-line GRH for primitive Dirichlet characters in the open strip, and binary Goldbach through 564,383,557,524. All four groups of numerical bounds enter the proof. [Source and receipt](native-analytic-controls/price-joint-24954b28/verified-price-rows-portable.json) |
| Finite binary input | Stock Lean 4.35 on Linux compiled the binary theorem for every even integer from 4 through 138,580,583,424 and reported only the three standard axioms. Its two bitmap modules built in 22 and 83 seconds. The [full finite input](https://github.com/elliotglazer/ternary-goldbach/blob/cb1dffe10fd5a86ab53fb71a4812eb73786ed530/ProductPrefix564386325504.lean) runs through 564,386,325,504. An earlier Windows build verified every even number through 152,539,227,136. [Linux prefix](binary-through-138580583424/linux-prefix.json) · [Windows prefix](binary-through-152539227136/native-prefix.json) |
| Community GRH | Of 794 dependencies, the Linux build reused 658 modules and compiled 34 more. Four modules failed on that revision. The candidate above revises all four. [Build result](linux-grh-86170f19/result.json) |
| Palomar intake | The stock verifier prepared candidate `cb1dffe1`, inspected 1,529 Lean files (364,965,011 bytes) and reported zero errors. [Intake summary](stock-runtime/stock-palomar-prepare-cb1dffe1-summary.json) |

The candidate turns off concurrent theorem elaboration within 103 finite interval files. One complete 320-row interval took 43.2 seconds on Windows, peaked at 1.70 GiB of resident memory and emitted the C output requested by Lake. The full Linux build can schedule many interval files at once. [Interval measurement](binary-through-152539227136/synchronous-interval.json)

The stock resource probe on the retained Linux host measured a shared limit of 32 vCPUs and 64 GiB RAM with swap disabled. The probe also restored the original cgroup settings. [Measurements](stock-runtime/aggregate/qualified-32x64/aggregate-report.json) · [Restoration check](stock-runtime/aggregate/qualified-32x64/postcheck.json)

## What establishes the final result

The [final proof](https://github.com/elliotglazer/ternary-goldbach/blob/cb1dffe10fd5a86ab53fb71a4812eb73786ed530/CompletedGoldbach.lean) applies the two GRH results to the [finite and analytic theorem](https://github.com/elliotglazer/ternary-goldbach/blob/cb1dffe10fd5a86ab53fb71a4812eb73786ed530/CompletedFiniteRows.lean). The [joint replay](warm-main/joint-final/join_warm.py) checks the provenance of both input builds, elaborates that application and checks the exported solution statement. A complete protected run must also collect Palomar's comparator and kernel outcomes for the same candidate within the resource limits. Those end-to-end results are pending.
