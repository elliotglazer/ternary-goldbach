# Lean prime-certificate benchmark

Measured 2026-11-10 on an AMD Ryzen 9 8945HS, 8 physical cores and 16 logical processors. Lean 4.35.0; borrowed Mathlib commit `56a005855ea17e0b0958f73ec801ae140b0a1679`. Dependencies were read-only and were not rebuilt.

## Result

The final cohort contains 32 genuine prime proofs, selected as the first four anchors in each of the native experiment's eight pools. The values lie near 2e18 and 4e18 and have 61 or 62 bits. All 32 proofs compiled successfully and printed exactly these axioms:

    propext, Classical.choice, Quot.sound

The full shared certificate closure contains 250 named Pratt prime nodes and 1,105 auxiliary proof declarations. These auxiliary declarations matter: `decide +kernel` lifts its modular-arithmetic evidence out of the named primality theorem.

| Timed region, ten repetitions | Declarations per repetition | CPU ms per anchor | Wall ms per anchor |
|---|---:|---:|---:|
| Named root theorem bodies only, incomplete | 32 | 0.684 | 0.683 |
| Root theorems and all their local auxiliary proofs | 210 | 17.871 | 17.918 |
| Full shared closure, including supporting factor primes and their auxiliaries | 1,355 | **55.078** | **55.222** |

Use the full-closure row as the measured candidate for this prototype. The root-plus-auxiliary row prices the incremental step when every supporting factor-prime certificate is already available. The named-body-only row omits almost all computation and must not be used as a prime-checking forecast.

At exactly 238,418,579,456 anchors, linear extrapolation of 55.078 ms CPU per anchor gives about **416 core-years for prime-certificate checking alone**. The root-plus-auxiliary rate gives about **135 core-years**, conditional on supporting factor proofs already being checked. Neither number is a measured full campaign, a bound for arbitrary 62-bit primes, nor a price for Goldbach coverage or proof production.

The 32-root cohort has 7.81 named prime nodes per root. The producer's larger 4,096-root fixture has 17,649 nodes, about 4.31 per root. More sharing can reduce support cost, but node counts alone do not determine runtime because node sizes differ. The earlier three-root closure had 40 named prime nodes and 148 auxiliaries and cost 69.516 ms wall per anchor. Its three incremental root costs, including auxiliaries, were 15.701, 27.161, and 12.375 ms. These are sample comparisons, not universal lower and upper bounds.

No partial-factor Pocklington optimization, special-form-prime restriction, batched modular exponentiation, or optimized alternative certificate evaluator was implemented. Those could change the measured cost. This is a working full-factor Lucas/Pratt baseline, not an assertion of the best possible Lean implementation.

## What was checked

`PrimeSupport.lean` proves `lucasNat` from Mathlib's `lucas_primality`. It translates `Nat.powMod` equalities to arithmetic in `ZMod`. Each generated certificate proves the factorization of `p-1`, uses recursively checked prime factors, and checks the Lucas modular-power conditions by kernel evaluation. The native fixture supplies proposed factors and bases only; those proposals are not accepted as axioms.

`PrimeSamples32.lean` contains the 250 recursive prime declarations and exact `#check`/`#print axioms` commands for the 32 roots. There are no primality hypotheses in the exported root theorems. Their statements are ordinary `Nat.Prime <literal>` propositions. The final compilation exited zero.

The benchmark extracts each theorem's actual stored body and submits a fresh declaration through `Kernel.Environment.addDeclCore`. It does not time a reference to an already-proved root theorem. Each check starts from the same imported environment; the returned extended environment is discarded. Thus repetitions check the bodies again. Every expected declaration was accepted: 320 named-root checks, 2,100 root-plus-auxiliary checks, and 13,550 full-closure checks. An intentionally malformed theorem body was rejected in each region.

The command used `-j 1 -t 0`, and the environment printed trust level zero. The first argument `0` in `addDeclCore 0 100000` is an unlimited heartbeat budget, not a trust-level setting. `addDeclCore` is the checked API; `addDeclWithoutChecking` is not used. Imported Mathlib declarations and the fixed `lucasNat` proof remain previously checked dependencies, as in a normal Lean build. This benchmark does not recheck all of Mathlib.

`ModPowBench.lean` supplies a separate computational negative control. Three full-width Fermat modular-power equalities were accepted 100 times each, while replacing the correct residue 1 by 2 was rejected. The strict run took about 3.04, 3.52, and 4.31 ms wall per modular-power equality. Its standalone theorem printed only `propext` and `Quot.sound`. This is an arithmetic component, not an independent primality proof.

## Timing method and exclusions

`IO.monoNanosNow` surrounds the kernel replay loops. Windows `GetProcessTimes`, sampled using the explicit Lean process ID, measures user-plus-kernel CPU time around the same loops. The CPU interval includes a small parent-process launch/return overhead for the sampling helper; wall timing excludes helper calls. Windows timer granularity is negligible compared with the final 17.625-second full-closure CPU batch.

The final full-closure region used 17.625 CPU seconds and 17.6711772 wall seconds for 320 anchor-equivalents. The entire benchmark process used 38.5625 CPU seconds and 39.60215 wall seconds, including imports, warm-up checks, negative controls, all three regions, and reporting. Those whole-process numbers are not divided by 320 to price a prime.

The separate proof-construction process for `PrimeSamples32.lean` used 35.265625 CPU seconds and 27.704578 wall seconds. It includes imports, elaboration, kernel checks during construction, axiom reports, and artifact writing. It is not a clean measure of either pure proof generation or one kernel pass.

One preliminary CPU helper mistakenly sampled the Windows Python launcher instead of Lean. Its near-zero regional CPU numbers were rejected. The final helper receives `IO.Process.getPID` explicitly; `summarize_results.py` also rejects implausibly near-zero CPU samples. Earlier named-body-only timing likewise remains diagnostic and is not promoted to a whole-certificate cost.

The reusable compiled fixed-support theorem and imported Mathlib are one-time setup. Supporting small-prime proofs are included in the full sampled closure. A campaign-level cache can share them more broadly. Imports, data generation, coverage-mask checking, retained proof storage, and final theorem assembly are outside the 416-core-year extrapolation.

## Artifacts and reproduction

`results.json` records normalized rows, all roots, acceptance counts, axiom checks, raw log paths and SHA-256 hashes. `PrimeSamples32.manifest.json` records the selected roots and recursive prime-node set. Logs retain both successful runs and failed development probes; only the pinned successful runs feed `results.json`.

From the repository workspace, the successful commands were:

```powershell
python work/formal-goldbach-bench/prime-cert/generate_primes.py 32 spread
python work/formal-goldbach-bench/prime-cert/run_lean.py -j 1 -t 0 -o PrimeSamples32.olean PrimeSamples32.lean
python work/formal-goldbach-bench/prime-cert/run_lean.py -j 1 -t 0 PrimeBench32.lean
python work/formal-goldbach-bench/prime-cert/run_lean.py -j 1 -t 0 ModPowBench.lean
python work/formal-goldbach-bench/prime-cert/summarize_results.py
```

The runner sets `LEAN_PATH` to this experiment plus the existing package artifact directories and invokes the pinned Lean executable directly. No Lake dependency build or update is involved. `PrimeSupport.olean` must already have been built from the accompanying source using the same runner.
