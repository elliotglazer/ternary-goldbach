# Warm GRH source diagnostic

The worker accepts a repaired Git commit and its tree and runs `lake --no-cache build +Main` with four Lake threads. The accepted project inputs are the 794 files in `CompactGRH/src` and the three original Lake/toolchain configuration files. The untouched finite Goldbach package is outside the import closure.

The sole host service must hold the existing worker lock, run the builder as `grhreplay`, and preserve the original EC2 stop on November 26 at 10:17:24 UTC. The helper enforces a two-hour maximum for each Lake process and a two-minute margin before that stop. The supervising service must bound the whole invocation, including verification of the retained inputs. The supervisor owns boot, queueing and poweroff.

## Run

After the supervisor fetches an operator-approved immutable commit and validates the instance, evidence volume and original shutdown schedule, its unprivileged child runs the following. The output directory must be new. Its parent must exist on the evidence volume.

```sh
python3 warm_main.py \
  --commit "$commit" --tree "$tree" --source-repo "$fetched_git_repo" \
  --receipt-sha 5eca91028a75f56c21abfe6c9d189e5f2d02d2b6fc08997172dd2187eced650c \
  --output "/work/tg-warm-diagnostics/$commit-$job" \
  --deadline-epoch 1795688244
```

The source-preflight log and receipt belong to attempt `33006912706042b49c1ddbc13515a4fb`. The helper verifies the original trace, exact Git blobs, unchanged Lake configuration, dependency commits and stock Lean/Lake binary hashes before copying any retained project outputs. A module qualifies only if the original Lake log records a successful build and all of its project ancestors qualify on the repaired source. The helper checks the actual bytes of every output against the original trace through stock Lake's binary hashing implementation. It copies accepted outputs to separate inodes. Failed modules and their descendants compile again.

The original worker prunes intermediate `.setup.json` files. Stock Lake can reuse a successfully traced output without that file. Each new compile produces its own setup. The isolated build mounts trusted packages and source read-only and puts all new output under the job directory. The `seeds.json` ledger lists accepted modules and rejected traces. The `warm-main.log` and `result.json` retain the new source errors or successful compilation. A successful warm Main build still needs a separate clean end-to-end run for the Goldbach verdict.

## Linux regression

```sh
python3 -B test_warm_main.py "$lean_435_root" "$bwrap" "$receipt_path"
```

The test builds a small package with an intermediate proof error and an independent finite target. It repairs the first error and changes the source of a previously successful module. The warm run reuses two unchanged modules, recompiles the changed module and its dependent, and reaches a previously blocked proof error. A second candidate repairs that error and passes Main. A separate control corrupts the bytes of a successful output while keeping its original trace and sidecars. The worker rejects that module and its dependents. The original source and object digest is identical after every attempt.

In the fourth live log snapshot, 351 of 794 compact modules had passed, including 30 in `New`. All 351 had complete, unchanged source ancestry on candidate `eadbe8e8e7d47e437429d485aeae11538d697d50`. Their retention on the volume is checked at runtime. With all those seeds available, the observed timings suggest roughly 35 to 75 minutes for a repaired-source diagnostic, including initialization. The hourly instance rate multiplied by 0.58 to 1.25 gives its incremental instance charge. Further source errors can bring the run to an earlier stop.
