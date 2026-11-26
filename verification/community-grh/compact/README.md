# Verifying Ternary Goldbach with community GRH

The Lean target is `PalomarTernaryGoldbach.ternary_goldbach`. Every odd natural number greater than 5 is the sum of three primes. The [solution source](https://github.com/elliotglazer/ternary-goldbach/blob/333aa9bb21fd87ef1f6be2159dbffc2c8da75962/GoldbachSolution.lean) states the quantifiers, primality conditions and sum explicitly.

## Replaying the candidate

Check out [candidate 333aa9bb](https://github.com/elliotglazer/ternary-goldbach/tree/333aa9bb21fd87ef1f6be2159dbffc2c8da75962). Its root contains `lakefile.toml`, `lean-toolchain` and the pinned Mathlib manifest. With the specified Lean 4.35.0 toolchain and Mathlib dependencies available, the project build entry point is `lake build`. It defaults to `GoldbachSolution`. For the protected challenge comparison, use the [Palomar replay instructions](stock-runtime/protected-final/README.md).

## What has been checked

| Input or target | Evidence as of November 26, 2026 |
| --- | --- |
| Analytic reduction | Lean compiled and independently reimported the theorem assuming RH, critical-line GRH for primitive Dirichlet characters in the open strip, and binary Goldbach through 564,383,557,524. All four groups of numerical bounds enter the proof. [Source and receipt](native-analytic-controls/price-joint-24954b28/verified-price-rows-portable.json) |
| Finite binary input | A retained Linux build compiled the binary theorem for every even integer from 4 through 100,328,530,944 inclusive and printed its three axioms. The candidate's [full input theorem](https://github.com/elliotglazer/ternary-goldbach/blob/333aa9bb21fd87ef1f6be2159dbffc2c8da75962/ProductPrefix564386325504.lean) extends coverage through 564,386,325,504. [Linux prefix record](binary-through-100328530944/linux-prefix.json) · [Independent native build of the same prefix](binary-through-100328530944/receipt.json) |
| Community GRH | The candidate's GRH root imports 794 project modules. The next Linux build reused 619 modules and compiled 21 more. Seven modules failed. [Build statistics and module names](linux-grh-9e6a0519/result.json) For example, the complete theta-lift module now compiles and all 15 audited declarations use only `propext`, `Classical.choice` and `Quot.sound`. [Import closure](warm-main/joint-final/source-preflight-333aa9bb.json) · [Theta-lift receipt](native-grh-controls/lift-333aa9bb/receipt.json) |
| Palomar intake | The stock verifier accepted the candidate's source package with zero errors and zero warnings. [Intake report](stock-runtime/stock-palomar-prepare-333aa9bb.json) |

The stock resource probe on the retained Linux host measured a shared limit of 32 vCPUs and 64 GiB RAM with swap disabled. The probe also restored the original cgroup settings. [Measurements](stock-runtime/aggregate/qualified-32x64/aggregate-report.json) · [Restoration check](stock-runtime/aggregate/qualified-32x64/postcheck.json)

## What establishes the final result

The [final proof](https://github.com/elliotglazer/ternary-goldbach/blob/333aa9bb21fd87ef1f6be2159dbffc2c8da75962/CompletedGoldbach.lean) applies the two GRH results to the [finite and analytic theorem](https://github.com/elliotglazer/ternary-goldbach/blob/333aa9bb21fd87ef1f6be2159dbffc2c8da75962/CompletedFiniteRows.lean). The [joint replay](warm-main/joint-final/join_warm.py) checks the provenance of both input builds, elaborates that application and checks the exported solution statement. A complete protected run must also collect Palomar's comparator and kernel outcomes for the same candidate within the resource limits. Those end-to-end results are pending.
